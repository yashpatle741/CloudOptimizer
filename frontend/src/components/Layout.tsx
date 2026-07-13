import { NavLink, useLocation } from 'react-router-dom';
import { BarChart3, LayoutDashboard, ListChecks, FileText, Settings as SettingsIcon, CloudCog } from 'lucide-react';

const navItems = [
  { to: '/dashboard', label: 'Dashboard', icon: LayoutDashboard },
  { to: '/resources', label: 'Resources', icon: CloudCog },
  { to: '/recommendations', label: 'Recommendations', icon: ListChecks },
  { to: '/reports', label: 'Reports', icon: FileText },
  { to: '/settings', label: 'Settings', icon: SettingsIcon }
];

export default function Layout({ children }: { children: React.ReactNode }) {
  const location = useLocation();

  return (
    <div className="min-h-screen bg-slate-950 text-slate-100">
      <div className="mx-auto flex max-w-7xl flex-col lg:flex-row">
        <aside className="w-full border-b border-slate-800 bg-slate-900/70 p-6 lg:w-72 lg:border-b-0 lg:border-r">
          <div className="mb-8 flex items-center gap-3">
            <div className="rounded-xl bg-cyan-500/15 p-2 text-cyan-400">
              <BarChart3 size={24} />
            </div>
            <div>
              <p className="text-lg font-semibold">CloudOptimizer</p>
              <p className="text-sm text-slate-400">AWS Cost Optimization</p>
            </div>
          </div>
          <nav className="space-y-2">
            {navItems.map(({ to, label, icon: Icon }) => {
              const active = location.pathname === to;
              return (
                <NavLink
                  key={to}
                  to={to}
                  className={`flex items-center gap-3 rounded-xl px-3 py-2 text-sm font-medium transition ${active ? 'bg-cyan-500/15 text-cyan-300' : 'text-slate-300 hover:bg-slate-800'}`}
                >
                  <Icon size={18} />
                  {label}
                </NavLink>
              );
            })}
          </nav>
        </aside>

        <main className="flex-1 p-6 lg:p-8">
          <header className="mb-8 flex flex-col gap-4 rounded-2xl border border-slate-800 bg-slate-900/70 p-5 shadow-2xl shadow-slate-950/40 lg:flex-row lg:items-center lg:justify-between">
            <div>
              <p className="text-sm uppercase tracking-[0.3em] text-cyan-400">Operations Center</p>
              <h1 className="text-2xl font-semibold">Cloud Cost Intelligence</h1>
            </div>
            <div className="rounded-full border border-emerald-500/30 bg-emerald-500/10 px-4 py-2 text-sm text-emerald-300">
              Last scan completed 12 mins ago
            </div>
          </header>
          {children}
        </main>
      </div>
    </div>
  );
}
