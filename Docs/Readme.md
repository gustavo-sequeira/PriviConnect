PriviConnect – API de Campanhas e Descontos

![Delphi](https://img.shields.io/badge/Delphi-Object%20Pascal-red)
![Horse](https://img.shields.io/badge/Horse-REST%20API-blue)
![Status](https://img.shields.io/badge/status-em%20produção-green)
![LGPD](https://img.shields.io/badge/LGPD-compliant-success)

O **PriviConnect** é uma API REST desenvolvida em **Delphi + Horse**, responsável por expor campanhas de desconto e calcular descontos por CPF e produtos.  
É consumida principalmente pela aplicação **Privilege**, podendo ser integrada a outros sistemas.

---

## Arquitetura Resumida

- **PriviConnect (API REST)**
  - Validação de campanhas
  - Cálculo de descontos
  - Exposição de endpoints REST
- **Privilege (Aplicação Delphi Desktop)**
  - Interface com o usuário
  - Consumo da API
- **Campanhas**
  - Implementadas via `ICampanha`
  - Gerenciadas pelo `TGerenciadorCampanhas`

---

## Conceito-chave: ID × Descrição da Campanha

| Campo | Uso |
|-----|----|
| **id** | Identificador lógico da campanha (nome da constante) |
| **descricao** | Texto exibido ao usuário |

 **Importante:**  
Sempre utilize o **id** nas integrações.  
Nunca utilize a descrição como identificador técnico.

**Exemplo:**
```json
{
  "id": "CAMPANHA_DESCONTO_LOJA",
  "descricao": "Desconto Loja"
}
