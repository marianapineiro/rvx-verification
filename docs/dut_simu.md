# Guia de Simulação do Processador RVX (Synopsys VCS)

Este documento descreve o passo a passo para compilar e simular o processador **RVX** utilizando a ferramenta **Synopsys VCS** e visualizar as formas de onda com o **Synopsys Verdi** no cluster **CADMICRO** da UFRGS.

---

## 1. Pré-requisitos
- Acesso SSH configurado para os servidores CADMICRO (`cadmicro01` a `cadmicro08`).
- Chave SSH cadastrada no repositório e autorizada no servidor.

---

## 2. Método 1: Simulação Automática (Recomendado)

Você pode sincronizar seu repositório local e executar os testes no CADMICRO com apenas um comando no seu terminal local:

```bash
# Executa no servidor padrão (cadmicro06)
./scripts/run_cadmicro.sh

# Ou especifique uma máquina específica do cluster (ex: cadmicro03)
./scripts/run_cadmicro.sh cadmicro03
```

---

## 3. Método 2: Simulação Manual no Servidor CADMICRO

Se preferir conectar via SSH no servidor e executar passo a passo:

1. **Conecte-se no servidor:**
   ```bash
   ssh cadmicro06
   ```

2. **Acesse a pasta de simulação:**
   ```bash
   cd ~/rvx-verification/sim
   ```

3. **Carregue o módulo do Synopsys VCS:**
   ```bash
   module use /tools/modulefiles/synopsys
   module load vcs/W-2024.09-SP2-3
   ```

4. **Execute a simulação com o Makefile:**
   ```bash
   make run
   ```

---

## 4. Visualizando as Formas de Onda (Interface Gráfica GUI)

Para abrir a interface gráfica interativa do **Synopsys Verdi** e visualizar os sinais do processador (clock, registradores, barramentos):

1. Acesse o servidor CADMICRO via SSH:
   ```bash
   ssh cadmicro06
   cd ~/rvx-verification/sim
   module use /tools/modulefiles/synopsys
   module load vcs/W-2024.09-SP2-3
   ```

2. Abra o simulador com a interface gráfica ativada:
   ```bash
   ./simv_rvx -gui &
   ```

---

## 5. Estrutura dos Arquivos na Pasta `sim/`

- **`filelist.f`**: Lista de manifesto contendo os caminhos para os arquivos Verilog do processador (`dut/rvx/hardware/rvx_core.v`) e do testbench.
- **`Makefile`**: Contém os alvos automáticos de compilação:
  - `make prepare`: Cria os links para os testes `.hex`.
  - `make compile`: Compila o circuito com a flag `-kdb` (necessária para o Verdi GUI).
  - `make run`: Executa a simulação completa.
  - `make clean`: Remove arquivos temporários de compilação.
