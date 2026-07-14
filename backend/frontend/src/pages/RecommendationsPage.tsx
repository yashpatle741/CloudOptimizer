import { useQuery } from '@tanstack/react-query';
import { fetchRecommendations } from '../services/api';
import LoadingState from '../components/LoadingState';
import ErrorState from '../components/ErrorState';
import EmptyState from '../components/EmptyState';

export default function RecommendationsPage() {
  const { data, isLoading, error } = useQuery({ queryKey: ['recommendations'], queryFn: fetchRecommendations });

  if (isLoading) return <LoadingState />;
  if (error) return <ErrorState message="Recommendations data is unavailable." />;
  if (!data?.length) return <EmptyState title="No recommendations available" description="The scanner will surface new actions soon." />;

  return (
    <div className="space-y-4">
      {data.map((item) => (
        <div key={item.id} className="rounded-2xl border border-slate-800 bg-slate-900/70 p-6">
          <div className="flex flex-col gap-4 lg:flex-row lg:items-start lg:justify-between">
            <div>
              <div className="mb-2 flex items-center gap-3">
                <h2 className="text-xl font-semibold">{item.title}</h2>
                <span className="rounded-full bg-cyan-500/10 px-2 py-1 text-xs text-cyan-300">{item.priority}</span>
              </div>
              <p className="mb-2 text-sm text-slate-400">{item.description}</p>
              <p className="text-sm text-slate-500">Resource: {item.resource}</p>
            </div>
            <div className="rounded-xl border border-slate-800 bg-slate-950/70 p-4 text-sm">
              <p className="text-slate-400">Estimated Monthly Savings</p>
              <p className="text-2xl font-semibold text-emerald-300">${item.estimatedSavings}</p>
              <p className="mt-2 text-slate-400">Status: open</p> 
            </div>
          </div>
        </div>
      ))}
    </div>
  );
}
