import { ArrowUpRight } from 'lucide-react';

interface StatCardProps {
  title: string;
  value: string;
  subtitle: string;
  accent?: string;
}

export default function StatCard({ title, value, subtitle, accent = 'cyan' }: StatCardProps) {
  const accentClasses: Record<string, string> = {
    cyan: 'from-cyan-500/20 to-cyan-400/5 text-cyan-300',
    emerald: 'from-emerald-500/20 to-emerald-400/5 text-emerald-300',
    amber: 'from-amber-500/20 to-amber-400/5 text-amber-300',
    violet: 'from-violet-500/20 to-violet-400/5 text-violet-300'
  };

  return (
    <div className={`rounded-2xl border border-slate-800 bg-gradient-to-br ${accentClasses[accent]} p-5`}>
      <div className="mb-4 flex items-center justify-between">
        <p className="text-sm text-slate-400">{title}</p>
        <ArrowUpRight size={16} />
      </div>
      <p className="text-3xl font-semibold">{value}</p>
      <p className="mt-2 text-sm text-slate-400">{subtitle}</p>
    </div>
  );
}
