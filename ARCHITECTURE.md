# **Arquitetura da Aplicação \- Persistência Flutter**

## **Visão Geral**

Esta aplicação implementa **Clean Architecture** com **MVVM** para gerenciamento de pessoas com persistência local usando SQLite. A arquitetura garante separação clara de responsabilidades, testabilidade e manutenibilidade.

## **Camadas da Arquitetura**

### **1\. Presentation Layer (`lib/presentation/`)**

**Responsabilidade**: Interface do usuário e gerenciamento de estado

* **Pages**: Telas da aplicação  
* **Widgets**: Componentes reutilizáveis da UI  
* **ViewModels**: Lógica de apresentação (MVVM pattern)

presentation/  
├── pages/  
│   └── pessoas\_page.dart       \# Tela principal  
├── widgets/  
│   ├── pessoa\_form.dart        \# Formulário de entrada  
│   ├── pessoa\_list.dart        \# Lista de pessoas  
│   └── pessoa\_item.dart        \# Item da lista  
└── viewmodels/  
    └── pessoas\_viewmodel.dart  \# Estado e lógica da UI

### **2\. Domain Layer (`lib/domain/`)**

**Responsabilidade**: Regras de negócio e contratos

* **Entities**: Modelos de negócio puros  
* **Repositories**: Contratos de acesso aos dados  
* **Use Cases**: Casos de uso específicos com validações

domain/  
├── entities/  
│   └── pessoa.dart             \# Entidade de negócio  
├── repositories/  
│   └── pessoa\_repository.dart  \# Interface do repositório  
└── usecases/  
    ├── add\_pessoa.dart         \# Adicionar pessoa  
    ├── get\_all\_pessoas.dart    \# Listar pessoas  
    ├── update\_pessoa.dart      \# Atualizar pessoa  
    └── delete\_pessoa.dart      \# Remover pessoa

### **3\. Data Layer (`lib/data/`)**

**Responsabilidade**: Acesso e manipulação de dados

* **Models**: Modelos para persistência (conversão de/para Map)  
* **Repositories**: Implementações concretas dos contratos  
* **DataSources**: Fontes de dados (local/remoto)

data/  
├── models/  
│   └── pessoa\_model.dart           \# Modelo para persistência  
├── repositories/  
│   └── pessoa\_repository\_impl.dart \# Implementação do repositório  
└── datasources/  
    └── pessoa\_local\_datasource.dart \# Acesso ao SQLite

### **4\. Core Layer (`lib/core/`)**

**Responsabilidade**: Funcionalidades compartilhadas

* **Database**: Configuração e conexão com SQLite  
* **DI**: Injeção de dependências  
* **Errors**: Tratamento de exceções

core/  
├── database/  
│   ├── database\_helper.dart    \# Conexão com SQLite  
│   └── database\_config.dart    \# Configurações do DB  
├── di/  
│   └── dependency\_injection.dart \# Setup do GetIt  
└── errors/  
    └── exceptions.dart         \# Exceções customizadas

## **Fluxo de Dependências**

Presentation → Domain ← Data ← Core  
     ↓           ↓        ↓      ↓  
  ViewModels → UseCases → Repos → DB

### **Injeção de Dependências (GetIt)**

// Setup das dependências  
DatabaseHelper → PessoaLocalDataSource → PessoaRepository  
                                             ↓  
AddPessoa ← GetAllPessoas ← UpdatePessoa ← DeletePessoa  
                                             ↓  
                                      PessoasViewModel

## **Design Patterns Utilizados**

### **1\. Clean Architecture**

* Separação em camadas bem definidas  
* Dependências apontam sempre para dentro  
* Camadas externas implementam interfaces das internas

### **2\. MVVM (Model-View-ViewModel)**

* **View**: Widgets Flutter  
* **ViewModel**: `PessoasViewModel` com `ChangeNotifier`  
* **Model**: Entidades do domínio

### **3\. Repository Pattern**

* Interface no domínio, implementação na data layer  
* Abstrai fonte de dados da lógica de negócio

### **4\. Dependency Injection**

* GetIt para resolução de dependências  
* Facilita testes e reduz acoplamento

### **5\. Singleton**

* `DatabaseHelper` para conexão única com SQLite

## **Trade-offs e Decisões Arquiteturais**

### **Vantagens**

| Aspecto | Benefício |
| ----- | ----- |
| **Testabilidade** | Cada camada pode ser testada isoladamente |
| **Manutenibilidade** | Mudanças ficam isoladas em suas camadas |
| **Escalabilidade** | Fácil adicionar novas features seguindo o padrão |
| **Reutilização** | Widgets e use cases são reutilizáveis |
| **Separação de Responsabilidades** | Cada classe tem uma função específica |

### **Trade-offs**

| Aspecto | Custo | Justificativa |
| ----- | ----- | ----- |
| **Complexidade Inicial** | Mais arquivos e abstrações | Compensa em projetos médios/grandes |
| **Overhead de Código** | Mais boilerplate | Facilita manutenção a longo prazo |
| **Curva de Aprendizado** | Requer conhecimento dos patterns | Padrão da indústria |

