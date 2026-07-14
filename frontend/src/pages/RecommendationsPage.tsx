import { useState } from 'react';
import { useQuery } from '@tanstack/react-query';
import { fetchRecommendations } from '../services/api';
import LoadingState from '../components/LoadingState';
import ErrorState from '../components/ErrorState';
import EmptyState from '../components/EmptyState';

interface Recommendation {
  resourceId: string;
  service: string;
  priority: 'High' | 'Medium' | 'Low';
  title: string;
  description: string;
  estimatedSavings: string;
  scanTime: string;
}

export default function RecommendationsPage() {
  const [filter, setFilter] = useState('All');

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

  const filteredData =
    filter === 'All'
      ? data
      : data.filter((item) => item.priority === filter);

  const totalRecommendations = filteredData.length;

  const highPriorityCount = filteredData.filter(
    (item) => item.priority === 'High'
  ).length;

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <h1 className="text-3xl font-bold">Recommendations</h1>

        <select
          value={filter}
          onChange={(e) => setFilter(e.target.value)}
          className="rounded-lg border border-slate-700 bg-slate-900 px-3 py-2 text-white"
        >
          <option>All</option>
          <option>High</option>
          <option>Medium</option>
          <option>Low</option>
        </select>
      </div>

      {/* Summary */}
      <div className="grid gap-4 md:grid-cols-2">
        <div className="rounded-2xl border border-slate-800 bg-slate-900/70 p-6">
          <p className="text-sm text-slate-400">
            Total Recommendations
          </p>
          <h2 className="mt-2 text-3xl font-bold text-cyan-300">
            {totalRecommendations}
          </h2>
        </div>

        <div className="rounded-2xl border border-slate-800 bg-slate-900/70 p-6">
          <p className="text-sm text-slate-400">
            High Priority
          </p>
          <h2 className="mt-2 text-3xl font-bold text-red-300">
            {highPriorityCount}
          </h2>
        </div>
      </div>

      {/* Recommendation Cards */}
      {filteredData.map((item, index) => (
        <div
          key={`${item.resourceId}-${index}`}
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

              <p className="mb-3 text-sm text-slate-400">
                {item.description}
              </p>

              <p className="text-sm text-slate-500">
                <strong>Resource:</strong> {item.resourceId}
              </p>

              <p className="mt-2 text-xs text-slate-500">
                <strong>Scanned:</strong>{' '}
                {new Date(item.scanTime).toLocaleString()}
              </p>
            </div>

            <div className="min-w-56 rounded-xl border border-slate-800 bg-slate-950/70 p-4">
              <p className="text-sm text-slate-400">
                Estimated Monthly Savings
              </p>

              <p className="mt-2 text-2xl font-semibold text-emerald-300">
                {item.estimatedSavings}
              </p>

              <div className="mt-4">
                <span className="rounded-full bg-emerald-500/10 px-3 py-1 text-xs font-medium text-emerald-300">
                  Open
                </span>
              </div>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
}