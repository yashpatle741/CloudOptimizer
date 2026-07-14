import { useQuery } from '@tanstack/react-query';
import { fetchRecommendations } from '../services/api';
import LoadingState from '../components/LoadingState';
import ErrorState from '../components/ErrorState';
import EmptyState from '../components/EmptyState';

interface Recommendation {
  resource: string;
  service: string;
  priority: 'High' | 'Medium' | 'Low';
  title: string;
  description: string;
  estimatedSavings: string;
}

export default function RecommendationsPage() {
  const {
    data,
    isLoading,
    error,
  } = useQuery<Recommendation[]>({
    queryKey: ['recommendations'],
    queryFn: fetchRecommendations,
  });

  if (isLoading) return <LoadingState />;

  if (error) {
    return (
      <ErrorState message="Recommendations data is unavailable." />
    );
  }

  if (!data?.length) {
    return (
      <EmptyState
        title="No recommendations available"
        description="The scanner will surface new actions soon."
      />
    );
  }

  return (
    <div className="space-y-4">
      {data.map((item, index) => (
        <div
          key={`${item.resource}-${item.title}-${index}`}
          className="rounded-2xl border border-slate-800 bg-slate-900/70 p-6"
        >
          <div className="flex flex-col gap-4 lg:flex-row lg:items-start lg:justify-between">
            <div>
              <div className="mb-2 flex items-center gap-3">
                <h2 className="text-xl font-semibold">
                  {item.title}
                </h2>

                <span
                  className={`rounded-full px-2 py-1 text-xs font-medium ${
                    item.priority === 'High'
                      ? 'bg-red-500/10 text-red-300'
                      : item.priority === 'Medium'
                      ? 'bg-yellow-500/10 text-yellow-300'
                      : 'bg-green-500/10 text-green-300'
                  }`}
                >
                  {item.priority}
                </span>

                <span className="rounded-full bg-violet-500/10 px-2 py-1 text-xs font-medium text-violet-300">
                  {item.service}
                </span>
              </div>

              <p className="mb-2 text-sm text-slate-400">
                {item.description}
              </p>

              <p className="text-sm text-slate-500">
                <strong>Resource:</strong> {item.resource}
              </p>
            </div>

            <div className="min-w-56 rounded-xl border border-slate-800 bg-slate-950/70 p-4 text-sm">
              <p className="text-slate-400">
                Estimated Monthly Savings
              </p>

              <p className="mt-1 text-2xl font-semibold text-emerald-300">
                ${item.estimatedSavings}
              </p>

              <p className="mt-3 text-slate-400">
                Status:{' '}
                <span className="font-medium text-cyan-300">
                  Open
                </span>
              </p>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
}