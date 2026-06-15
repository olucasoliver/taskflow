-- ============================================================
-- Taskflow — Redação: estrutura do banco (Supabase)
-- Rode este script UMA VEZ no SQL Editor do seu projeto Supabase.
-- Cria só as tabelas — sem nenhum dado dentro. A própria aplicação
-- preenche a configuração padrão da equipe na primeira vez que abrir.
-- ============================================================

-- Tabela de tarefas
create table if not exists tasks (
  id text primary key,
  title text not null,
  members jsonb not null default '[]',
  member text,
  priority text not null default 'media',
  status text not null default 'pendente',
  date text not null,
  time text,
  description text default ''
);

alter table tasks enable row level security;
drop policy if exists "tasks_all_access" on tasks;
create policy "tasks_all_access" on tasks for all using (true) with check (true);

-- Configuração da equipe (uma linha só, id = 1)
create table if not exists team_config (
  id int primary key default 1,
  members jsonb not null,
  labels jsonb not null,
  roles jsonb not null
);

alter table team_config enable row level security;
drop policy if exists "team_config_all_access" on team_config;
create policy "team_config_all_access" on team_config for all using (true) with check (true);
