# WhatsApp Appointment Reminder System

A single-file appointment reminder system with:
- Booking form (name, phone, date/time)
- Supabase database (with in-memory simulation fallback)
- Twilio SMS or WhatsApp confirmation + 1-hour reminders
- Live dashboard pulled from the database

---

## Quick Start (5 minutes)

### Step 1 — Open the app
Just open `index.html` in any browser. No build step, no server needed.

The app immediately works in **Simulation Mode** — appointments are held
in memory and messages are printed to the Activity Log instead of sent.

---

### Step 2 — Set up Supabase (free)

1. Go to https://supabase.com and create a free project.
2. Open the **SQL Editor** and paste + run `supabase_setup.sql`.
3. Go to **Settings → API** and copy:
   - **Project URL** → paste into the `Supabase URL` field in the app
   - **anon public key** → paste into the `Supabase Anon Key` field

---

### Step 3 — Set up Twilio (free trial)

**For SMS:**
1. Sign up at https://twilio.com (free trial gives ~$15 credit)
2. Get a phone number from the Twilio Console
3. Copy your **Account SID** and **Auth Token** from the dashboard
4. In the app, set `Message Type` to `sms`

**For WhatsApp:**
1. In the Twilio Console → Messaging → Try it out → Send a WhatsApp message
2. Follow the sandbox join instructions (text "join <word>" to the sandbox number)
3. Use the sandbox number (e.g. `+14155238886`) as the From number
4. In the app, prefix the number with `whatsapp:` e.g. `whatsapp:+14155238886`
5. Set `Message Type` to `whatsapp`

---

### Step 4 — Save & Connect

Click **Save & Connect** in the configuration section.
The yellow banner will disappear and the status pill will turn to "Live".

---

## How It Works

| Feature | Implementation |
|---------|---------------|
| **Form** | Plain HTML, no framework |
| **Database** | Supabase REST API (or in-memory array in sim mode) |
| **Confirmation message** | Sent immediately on booking via Twilio |
| **Reminder** | Client-side `setInterval` polls every 60s; sends when ≤60 min away |
| **Dashboard** | Live-fetched from Supabase on load and after every booking |

---

## Production Notes

- **Move Twilio calls server-side** — the browser-side call is fine for demos/internal tools
  but exposes your Auth Token. Use a Supabase Edge Function or any backend for production.
- **RLS policies** — tighten the Supabase policies to require authentication for production use.
- **Reminder polling** — the 60s interval only runs while the tab is open. For a production
  system, use a Supabase cron job or a background worker instead.

---

## File Structure

```
appointment-reminder/
├── index.html          ← The entire app (open this)
├── supabase_setup.sql  ← Run once in Supabase SQL Editor
└── README.md           ← This file
```
