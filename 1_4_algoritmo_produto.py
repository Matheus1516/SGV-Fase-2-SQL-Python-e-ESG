import json

# Função lambda para calcular o ICMS (18%)
calcular_icms = lambda valor: round(valor * 0.18, 2)

# Lista para armazenar os produtos
produtos = []

print("Cadastro de Produtos - Mínimo de 5 produtos\n")

while True:
    try:
        # Solicita dados do produto
        descricao = input("Digite a descrição do produto: ").strip()

        valor_input = input("Digite o valor do produto (ex: 199.99): ").strip()
        valor = float(valor_input)  # Tenta converter para float

        embalagem = input("Digite o tipo de embalagem: ").strip()

        # Calcula o ICMS
        icms = calcular_icms(valor)

        # Cria o dicionário do produto
        produto = {
            "descricao": descricao,
            "valor": valor,
            "embalagem": embalagem,
            "ICMS": icms
        }

        # Adiciona à lista de produtos
        produtos.append(produto)

        # Pergunta se o usuário quer cadastrar mais um produto
        continuar = input("Deseja cadastrar um novo produto? (sim/não): ").strip().lower()
        if continuar not in ["sim", "s"]:
            if len(produtos) < 5:
                print(f"\n⚠️ É necessário cadastrar no mínimo 5 produtos. Você cadastrou {len(produtos)}.\n")
                continue
            else:
                break

    except ValueError:
        print("❌ Valor inválido! Por favor, insira um número válido para o valor do produto.\n")

    except Exception as e:
        print(f"❌ Ocorreu um erro inesperado: {e}\n")

# Salvar os produtos em um arquivo JSON
nome_arquivo = "1_5_arquivo_produto.json"

try:
    with open(nome_arquivo, "w", encoding='utf-8') as f:
        json.dump(produtos, f, ensure_ascii=False, indent=4)
    print(f"\n✅ Cadastro finalizado! Arquivo '{nome_arquivo}' criado com sucesso.")
except Exception as e:
    print(f"❌ Erro ao salvar o arquivo JSON: {e}")
