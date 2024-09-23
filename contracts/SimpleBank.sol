// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

/**
 * @title SimpleBank
 * @dev Smart contract para gestionar un banco sencillo donde los usuarios pueden registrarse, depositar y retirar ETH.
 */
contract SimpleBank {
    // Estructura para almacenar la información del usuario
    struct User {
        string firstName;
        string lastName;
        uint256 balance;
        bool isRegistered;
    }

    // Mapping para relacionar las direcciones con la información de los usuarios
    mapping(address => User) public users;

    // Dirección del propietario del contrato
    address public owner;
    
    // Dirección de la tesorería
    address public treasury;

    // Fee en puntos básicos (1% = 100 puntos básicos)
    uint256 public fee;

    // Balance acumulado en la cuenta de tesorería (en wei)
    uint256 public treasuryBalance;

    // Evento que se emite cuando un usuario se registra
    event UserRegistered(address indexed user, string firstName, string lastName);

    // Evento que se emite cuando se realiza un depósito
    event Deposit(address indexed user, uint256 amount);

    // Evento que se emite cuando se realiza un retiro
    event Withdrawal(address indexed user, uint256 amount, uint256 fee);

    // Evento que se emite cuando el propietario retira fondos de la tesorería
    event TreasuryWithdrawal(address indexed owner, uint256 amount);

    // Modificador para verificar si un usuario está registrado
    modifier onlyRegistered() {
        require(users[msg.sender].isRegistered, "Usuario no registrado");
        _;
    }

    // Modificador para verificar si el llamador es el propietario
    modifier onlyOwner() {
        require(msg.sender == owner, "No autorizado: no es el propietario");
        _;
    }

    /**
     * @dev Constructor del contrato
     * @param _fee El fee en puntos básicos (1% = 100 puntos básicos)
     * @param _treasury La dirección de la tesorería
     */
    constructor(uint256 _fee, address _treasury) {
        require(_treasury != address(0), "La direccion de la tesoreria no puede ser cero");
        require(_fee <= 10000, "El fee no puede ser mayor al 100%");

        owner = msg.sender;
        fee = _fee;
        treasury = _treasury;
        treasuryBalance = 0;
    }

    /**
     * @dev Función para registrar un nuevo usuario
     * @param _firstName El primer nombre del usuario
     * @param _lastName El apellido del usuario
     */
    function register(string calldata _firstName, string calldata _lastName) external {
        require(bytes(_firstName).length != 0, "El nombre no puede estar vacio");
        require(bytes(_lastName).length != 0, "El apellido no puede estar vacio");
        require(!users[msg.sender].isRegistered, "Usuario ya registrado");

        users[msg.sender] = User(_firstName, _lastName, 0, true);
        emit UserRegistered(msg.sender, _firstName, _lastName);
    }

    /**
     * @dev Función para hacer un depósito de ETH en la cuenta del usuario
     */
    function deposit() external payable onlyRegistered {
        require(msg.value > 0, "La cantidad debe ser mayor a cero");

        // Agregar la cantidad depositada al balance del usuario
        users[msg.sender].balance += msg.value;

        emit Deposit(msg.sender, msg.value);
    }

    /**
     * @dev Función para verificar el saldo del usuario
     * @return El saldo del usuario en wei
     */
    function getBalance() external view onlyRegistered returns (uint256) {
        return users[msg.sender].balance;
    }

    /**
     * @dev Función para retirar ETH de la cuenta del usuario
     * @param _amount La cantidad a retirar (en wei)
     */
    function withdraw(uint256 _amount) external onlyRegistered {
        require(_amount > 0, "La cantidad debe ser mayor a cero");
        require(users[msg.sender].balance >= _amount, "Saldo insuficiente");

        uint256 feeAmount = (_amount * fee) / 10000;  // Calcular el fee
        uint256 amountAfterFee = _amount - feeAmount; // Cantidad después del fee

        // Restar el monto total (incluyendo el fee) del balance del usuario
        users[msg.sender].balance -= _amount;

        // Aumentar el balance de la tesorería
        treasuryBalance += feeAmount;

        // Transferir la cantidad después del fee al usuario
        (bool success, ) = msg.sender.call{value: amountAfterFee}("");
        require(success, "Fallo en la transferencia de ETH");

        emit Withdrawal(msg.sender, amountAfterFee, feeAmount);
    }

    /**
     * @dev Función para que el propietario retire fondos de la cuenta de tesorería
     * @param _amount La cantidad a retirar de la tesorería (en wei)
     */
    function withdrawTreasury(uint256 _amount) external onlyOwner {
        require(_amount <= treasuryBalance, "Fondos insuficientes en la tesoreria");

        // Reducir el balance de la tesorería
        treasuryBalance -= _amount;

        // Transferir los fondos al propietario
        (bool success, ) = treasury.call{value: _amount}("");
        require(success, "Fallo en la transferencia de ETH desde la tesoreria");

        emit TreasuryWithdrawal(msg.sender, _amount);
    }
}