import { useQuery } from '@tanstack/react-query';
import { ResponsiveContainer, PieChart, Pie, Cell, Tooltip, AreaChart, Area, CartesianGrid, XAxis, YAxis } from 'recharts';
import { fetchDashboard } from '../services/api';
import LoadingState from '../components/LoadingState';
import ErrorState from '../components/ErrorState';
import StatCard from '../components/StatCard';

const COLORS = ['#06b6d4', '#34d399', '#f59e0b', '#8b5cf6'];

export default function DashboardPage() {
  const { data, isLoading, error } = useQuery({ queryKey: ['dashboard'], queryFn: fetchDashboard });

  if (isLoading) return <LoadingState />;
  if (error || !data) return <ErrorState message="Dashboard data is unavailable." />;

  return (
    <div className="space-y-6">
      <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-4">
        <StatCard title="Monthly AWS Cost" value={`$${data.monthlyCost.toLocaleString()}`} subtitle="Updated from latest scan" accent="cyan" />
        <StatCard title="Potential Monthly Savings" value={`$${data.potentialSavings.toLocaleString()}`} subtitle="Based on active recommendations" accent="emerald" />
        <StatCard title="Optimization Score" value={`${data.optimizationScore}/100`} subtitle="Healthy efficiency posture" accent="amber" />
        <StatCard title="Total AWS Resources" value={data.totalResources.toString()} subtitle="Across all monitored accounts" accent="violet" />
      </div>

      <div className="grid gap-6 xl:grid-cols-[1.4fr_0.9fr]">
        <div className="rounded-2xl border border-slate-800 bg-slate-900/70 p-6">
          <div className="mb-4 flex items-center justify-between">
            <div>
              <p className="text-sm text-slate-400">Cost Trend</p>
              <h2 className="text-xl font-semibold">Monthly Spend</h2>
            </div>
            <span className="rounded-full bg-cyan-500/10 px-3 py-1 text-sm text-cyan-300">+8.4%</span>
          </div>
          <ResponsiveContainer width="100%" height={280}>
            <AreaChart data={data.costTrend}>
              <defs>
                <linearGradient id="costGradient" x1="0" y1="0" x2="0" y2="1">
                  <stop offset="0%" stopColor="#06b6d4" stopOpacity={0.5} />
                  <stop offset="100%" stopColor="#06b6d4" stopOpacity={0.05} />
                </linearGradient>
              </defs>
              <CartesianGrid stroke="#1e293b" strokeDasharray="3 3" />
              <XAxis dataKey="month" stroke="#94a3b8" />
              <YAxis stroke="#94a3b8" />
              <Tooltip />
              <Area type="monotone" dataKey="cost" stroke="#06b6d4" fill="url(#costGradient)" />
            </AreaChart>
          </ResponsiveContainer>
        </div>

        <div className="rounded-2xl border border-slate-800 bg-slate-900/70 p-6">
          <div className="mb-4">
            <p className="text-sm text-slate-400">Scan Health</p>
            <h2 className="text-xl font-semibold">Recent Scan Status</h2>
          </div>
          <div className="rounded-xl border border-emerald-500/20 bg-emerald-500/10 p-4 text-emerald-300">
            <p className="text-sm">{data.recentScanStatus}</p>
            <p className="mt-2 text-2xl font-semibold">Success</p>
          </div>
          <div className="mt-4 space-y-3">
            {data.latestRecommendations.map((item) => (
              <div key={item.id} className="rounded-xl border border-slate-800 bg-slate-950/70 p-3">
                <div className="flex items-center justify-between">
                  <p className="font-medium">{item.title}</p>
                  <span className="text-sm text-cyan-300">${item.savings}</span>
                </div>
                <p className="mt-1 text-sm text-slate-400">Priority: {item.priority}</p>
              </div>
            ))}
          </div>
        </div>
      </div>

      <div className="grid gap-6 xl:grid-cols-[0.95fr_1.05fr]">
        <div className="rounded-2xl border border-slate-800 bg-slate-900/70 p-6">
          <div className="mb-4">
            <p className="text-sm text-slate-400">Resource Mix</p>
            <h2 className="text-xl font-semibold">Distribution</h2>
          </div>
          <ResponsiveContainer width="100%" height={260}>
            <PieChart>
              <Pie data={data.resourceDistribution} dataKey="value" innerRadius={60} outerRadius={90} paddingAngle={3}>
                {data.resourceDistribution.map((entry, index) => (
                  <Cell key={entry.name} fill={COLORS[index % COLORS.length]} />
                ))}
              </Pie>
              <Tooltip />
            </PieChart>
          </ResponsiveContainer>
        </div>

        <div className="rounded-2xl border border-slate-800 bg-slate-900/70 p-6">
          <div className="mb-4">
            <p className="text-sm text-slate-400">Latest Recommendations</p>
            <h2 className="text-xl font-semibold">Action Queue</h2>
          </div>
          <div className="space-y-3">
            {data.latestRecommendations.map((item) => (
              <div key={item.id} className="flex items-center justify-between rounded-xl border border-slate-800 bg-slate-950/70 p-4">
                <div>
                  <p className="font-medium">{item.title}</p>
                  <p className="text-sm text-slate-400">{item.priority} priority</p>
                </div>
                <div className="text-right">
                  <p className="font-semibold text-emerald-300">${item.savings}/mo</p>
                  <p className="text-sm text-slate-400">savings</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
