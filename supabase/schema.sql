-- ====================================================================
-- OS Learning Platform - Supabase Database Schema & RLS Policies
-- ====================================================================

-- --------------------------------------------------------------------
-- 1. PROFILES TABLE
-- Links 1-to-1 with auth.users(id)
-- --------------------------------------------------------------------
create table if not exists public.profiles (
    id uuid primary key references auth.users(id) on delete cascade,
    name text,
    email text,
    avatar_url text,
    created_at timestamptz default now(),
    updated_at timestamptz default now()
);

-- Enable RLS for profiles
alter table public.profiles enable row level security;

-- Profiles RLS Policies
create policy "Users can view their own profile"
    on public.profiles for select
    using (auth.uid() = id);

create policy "Users can insert their own profile"
    on public.profiles for insert
    with check (auth.uid() = id);

create policy "Users can update their own profile"
    on public.profiles for update
    using (auth.uid() = id);


-- --------------------------------------------------------------------
-- 2. USER_PROGRESS TABLE
-- Tracks learning progress per topic per user
-- --------------------------------------------------------------------
create table if not exists public.user_progress (
    id bigint generated always as identity primary key,
    user_id uuid not null references auth.users(id) on delete cascade,
    topic text not null,
    completed boolean default false,
    progress integer default 0,
    updated_at timestamptz default now(),
    constraint unique_user_topic unique (user_id, topic)
);

-- Index for fast user progress lookup
create index if not exists idx_user_progress_user_id on public.user_progress(user_id);

-- Enable RLS for user_progress
alter table public.user_progress enable row level security;

-- User Progress RLS Policies
create policy "Users can view their own progress"
    on public.user_progress for select
    using (auth.uid() = user_id);

create policy "Users can insert their own progress"
    on public.user_progress for insert
    with check (auth.uid() = user_id);

create policy "Users can update their own progress"
    on public.user_progress for update
    using (auth.uid() = user_id);

create policy "Users can delete their own progress"
    on public.user_progress for delete
    using (auth.uid() = user_id);


-- --------------------------------------------------------------------
-- 3. QUIZ_RESULTS TABLE
-- Tracks practice quiz attempts and scores per user
-- --------------------------------------------------------------------
create table if not exists public.quiz_results (
    id bigint generated always as identity primary key,
    user_id uuid not null references auth.users(id) on delete cascade,
    quiz_name text not null,
    score integer not null,
    total_questions integer not null,
    created_at timestamptz default now()
);

-- Index for fast quiz results lookup
create index if not exists idx_quiz_results_user_id on public.quiz_results(user_id);

-- Enable RLS for quiz_results
alter table public.quiz_results enable row level security;

-- Quiz Results RLS Policies
create policy "Users can view their own quiz results"
    on public.quiz_results for select
    using (auth.uid() = user_id);

create policy "Users can insert their own quiz results"
    on public.quiz_results for insert
    with check (auth.uid() = user_id);

create policy "Users can delete their own quiz results"
    on public.quiz_results for delete
    using (auth.uid() = user_id);


-- --------------------------------------------------------------------
-- 4. BOOKMARKS TABLE
-- Tracks bookmarked topics, questions, or vault items per user
-- --------------------------------------------------------------------
create table if not exists public.bookmarks (
    id bigint generated always as identity primary key,
    user_id uuid not null references auth.users(id) on delete cascade,
    item_type text not null,
    item_id text not null,
    created_at timestamptz default now(),
    constraint unique_user_bookmark unique (user_id, item_type, item_id)
);

-- Index for fast bookmarks lookup
create index if not exists idx_bookmarks_user_id on public.bookmarks(user_id);

-- Enable RLS for bookmarks
alter table public.bookmarks enable row level security;

-- Bookmarks RLS Policies
create policy "Users can view their own bookmarks"
    on public.bookmarks for select
    using (auth.uid() = user_id);

create policy "Users can insert their own bookmarks"
    on public.bookmarks for insert
    with check (auth.uid() = user_id);

create policy "Users can delete their own bookmarks"
    on public.bookmarks for delete
    using (auth.uid() = user_id);


-- --------------------------------------------------------------------
-- AUTOMATIC PROFILE TRIGGER (Optional helper in Supabase)
-- --------------------------------------------------------------------
create or replace function public.handle_new_user()
returns trigger as $$
begin
  insert into public.profiles (id, name, email, avatar_url)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'name', split_part(new.email, '@', 1)),
    new.email,
    new.raw_user_meta_data->>'avatar_url'
  )
  on conflict (id) do update set
    email = excluded.email,
    name = coalesce(public.profiles.name, excluded.name),
    avatar_url = coalesce(public.profiles.avatar_url, excluded.avatar_url),
    updated_at = now();
  return new;
end;
$$ language plpgsql security definer;

-- Trigger execution on auth.users insert
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();
