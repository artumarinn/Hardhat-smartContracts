# Hardhat Smart Contracts

Este proyecto demuestra el uso de Hardhat para el desarrollo, prueba y despliegue de contratos inteligentes en la blockchain de Ethereum. Incluye ejemplos de contratos inteligentes escritos en Solidity que ilustran conceptos básicos de desarrollo blockchain.

## Descripción del Proyecto

El proyecto "Hardhat Smart Contracts" sirve como una plantilla y ejemplo práctico para desarrolladores que desean adentrarse en el mundo de los contratos inteligentes y DApps (Aplicaciones Descentralizadas). Utiliza el framework Hardhat, que proporciona un entorno de desarrollo completo para Ethereum.

## Contratos Inteligentes

### Lock
El contrato `Lock` demuestra el concepto de bloqueo temporal de fondos, una funcionalidad común en aplicaciones DeFi (Finanzas Descentralizadas). Características:
- Bloqueo de fondos por un período específico.
- Liberación automática de fondos después del tiempo establecido.
- Útil para aprender sobre manejo de tiempo en Ethereum y seguridad de fondos.

### SimpleBank
El contrato `SimpleBank` simula operaciones bancarias básicas en blockchain. Características:
- Registro de usuarios.
- Depósitos y retiros de ETH.
- Manejo de comisiones.
- Administración de fondos por el propietario.
- Ideal para entender el flujo de fondos y la gestión de estados en contratos.

## Herramientas y su Utilidad

### Hardhat
Hardhat es un entorno de desarrollo para Ethereum que facilita:
- Compilación de contratos: Traduce el código Solidity a bytecode ejecutable en la EVM.
- Testing: Permite escribir y ejecutar pruebas para validar la lógica de los contratos.
- Despliegue: Facilita el proceso de publicar contratos en diferentes redes (testnet, mainnet).
- Depuración: Ofrece herramientas para identificar y corregir errores en los contratos.

### Solidity
Lenguaje de programación para escribir contratos inteligentes en Ethereum. Características:
- Tipado estático.
- Soporte para herencia.
- Bibliotecas personalizadas.
- Optimizado para la Ethereum Virtual Machine (EVM).

### Ethers.js
Biblioteca que facilita la interacción con la blockchain de Ethereum:
- Conexión con nodos Ethereum.
- Manejo de cuentas y firmas.
- Interacción con contratos desplegados.

### OpenZeppelin
Biblioteca de contratos inteligentes seguros y auditados:
- Implementaciones estándar de tokens (ERC20, ERC721).
- Patrones de seguridad y utilidades comunes.
- Ahorra tiempo y reduce riesgos de seguridad en el desarrollo.

## Configuración y API Keys

El proyecto utiliza servicios externos para mejorar el desarrollo y despliegue:
- Infura/Alchemy: Proveen acceso a nodos Ethereum sin necesidad de ejecutar uno propio.
- Etherscan: Permite la verificación de contratos, crucial para la transparencia y auditoría.

La configuración de estas API Keys en el archivo `.env` permite:
- Conexión a redes de prueba y principales de Ethereum.
- Verificación automatizada de contratos en exploradores de bloques.
- Simulación de entornos de producción durante el desarrollo.


