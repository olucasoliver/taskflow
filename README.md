# Taskflow — Redação

Calendário/agenda de tarefas para a equipe (visões de semana, mês e dia,
prioridades, status, busca, gestão de equipe). Sistema novo, sem nenhuma
dependência do Netlify.

## Como funciona

Só dois arquivos:

- **`index.html`** — o app inteiro (HTML, CSS, JS). Pode ser hospedado em
  qualquer lugar que sirva arquivo estático (GitHub Pages, por exemplo).
- **`supabase-setup.sql`** — cria as tabelas do banco (rodar uma vez).

O armazenamento dos dados (tarefas e equipe) fica num projeto **Supabase**
(banco Postgres com API REST pronta, plano gratuito). O `index.html` fala
direto com o Supabase pelo navegador — não precisa de servidor próprio,
build ou deploy.

## Configuração (uma vez só)

1. Crie uma conta gratuita em [supabase.com](https://supabase.com) e um novo
   projeto.
2. No painel do projeto, abra **SQL Editor → New query**, cole o conteúdo de
   `supabase-setup.sql` e clique em **Run**. Isso cria as tabelas `tasks` e
   `team_config` (vazias — sem nenhum dado).
3. Vá em **Project Settings → API** e copie:
   - **Project URL**
   - **anon public key**
4. Abra `index.html`, procure por:
   ```js
   const SUPABASE_URL='COLE_AQUI_A_URL_DO_SEU_PROJETO_SUPABASE';
   const SUPABASE_ANON_KEY='COLE_AQUI_A_ANON_KEY';
   ```
   e substitua pelos valores do passo 3.

A partir daí, basta abrir `index.html` no navegador (ou hospedar via GitHub
Pages). A equipe padrão (Lucas, Joaquim, Nathália) já está no código e é
gravada no banco automaticamente na primeira vez que o app abrir.

## Publicar com GitHub Pages (opcional)

1. Suba este repositório no GitHub.
2. **Settings → Pages → Source**: branch `main`, pasta `/ (root)`.
3. O GitHub gera uma URL pública (`https://SEUUSUARIO.github.io/SEUREPO/`).

## Estrutura dos dados

**Tabela `tasks`**: `id`, `title`, `members` (array jsonb), `member`
(responsável principal), `priority` (`alta`/`media`/`baixa`), `status`
(`pendente`/`andamento`/`concluida`), `date`, `time`, `description`.

**Tabela `team_config`** (uma linha, `id=1`): `members`, `labels`, `roles`
— equipe, nomes exibidos e papéis.

## Segurança

As tabelas usam a chave pública ("anon") do Supabase com acesso total de
leitura/escrita (sem login). Isso é adequado para uso interno com o link não
divulgado publicamente. Se quiser exigir login no futuro, dá pra ativar
autenticação do Supabase e trocar as políticas de RLS nas tabelas.
