## Passo para execução

1. Clonar o dataset que será usado

   - Clone o repositório [MergeDataSet](https://github.com/spgroup/mergedataset).
   - Faça um checkout para o commit  [c8b965f](https://github.com/spgroup/mergedataset/commit/c8b965f71624f0ee3bec197d37ffbb2a9aaba97b).
   - Execute o script [get_sample.py](https://github.com/spgroup/mergedataset/blob/c8b965f71624f0ee3bec197d37ffbb2a9aaba97b/semantic-conflicts/get_sample.py).
   - Como resultado, o arquivo **results_semantic_study.csv** será criado com as informações do dataset.

2. Clonar o Dockerfile e dar build

   - Clone o Dockerfile desse repositório
   - No diretório em que se encontra o Dockerfile, execute o seguinte comando:

   ```bash
   docker build -t <nome_da_imagem> --build-arg DIRPATH=<diretório_base> --build-arg DEST_CSV=<diretório_csv_mergedataset> .
   ```

   No qual,

   **<nome_da_imagem>** = Ao nome que você deseja para sua imagem docker;

   **<diretório_base>** = É o caminho no qual você deu clone no repositório do dataset, por exemplo, se quando for realizar o passo 1 estiver no diretório "/home/CIN/jaam", é ele que será entregue.

   **<diretório_csv_mergedataset>** = Esse é o caminho relativo do arquivo csv que possui as informações dos cenários de merge, no exemplo do passo, como nosso dataset, seria o seguinte: "mergedataset/semantic-conflicts/results_semantic_study.csv"

3. Executar um contêiner da imagem criada

   -  Execute o seguinte comando:

   ```bash
   docker run -v <output_host>:<diretório_base>/output -v <diretório_base>/mergedataset:<diretório_base>/mergedataset <nome_da_imagem> <diretório_base>/infra/SMAT/nimrod/proj/semantic_study.py
   ```

   No qual, 

   **<output_host>** = É o diretório na sua máquina na qual você deseja que fiquem os arquivos de execução da ferramenta

   **<diretório_base>** = É o mesmo explicado no passo anterior

   **<nome_da_imagem>** = Também o mesmo que foi usado no passo anterior.
