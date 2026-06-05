-- ──────────────────────────────────────────────────────────────
-- AppointMint — Supabase Setup
-- Run this in: Supabase Dashboard → SQL Editor
-- ──────────────────────────────────────────────────────────────

-- 1. Create the appointments table
CREATE TABLE IF NOT EXISTS appointments (
  id          bigserial PRIMARY KEY,
  name        text NOT NULL,
  phone       text NOT NULL,
  appt_time   timestamptz NOT NULL,
  status      text DEFAULT 'pending',   -- pending | sent | simulated | reminded
  reminded    boolean DEFAULT false,
  created_at  timestamptz DEFAULT now()
);

-- 2. Enable Row Level Security (RLS) — important!
ALTER TABLE appointments ENABLE ROW LEVEL SECURITY;

-- 3. Allow anonymous read + write access (fine for a demo/internal tool)
--    For production, lock this down to authenticated users.
CREATE POLICY "Allow anon read"
  ON appointments FOR SELECT
  TO anon USING (true);

CREATE POLICY "Allow anon insert"
  ON appointments FOR INSERT
  TO anon WITH CHECK (true);

CREATE POLICY "Allow anon update"
  ON appointments FOR UPDATE
  TO anon USING (true);

-- 4. Optional: index on appointment time for fast reminder queries
CREATE INDEX IF NOT EXISTS idx_appt_time ON appointments (appt_time);

-- ──────────────────────────────────────────────────────────────
-- After running this, copy your:
--   Project URL  → cfg-supa-url  field in the app
--   anon key     → cfg-supa-key  field in the app
-- Both found at: Supabase Dashboard → Settings → API
-- ──────────────────────────────────────────────────────────────
