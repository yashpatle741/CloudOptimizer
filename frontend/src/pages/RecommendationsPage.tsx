import { useState } from 'react';
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

  if (error)
    return (
      <ErrorState message="Recommendations data is unavailable." />
    );

  if (!data?.length)
    return (
      <EmptyState
        title="No recommendations available"
        description="The scanner will surface new actions soon."
      />
    );

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
      <div className="flex items-center justify-between">
        <h1 className="text-3xl font-bold">Recommendations</h1>

        <select
          value={filter}
          onChange={(e) => setFilter(e.target.value)}
          className="rounded-lg border border-slate-700 bg-slate-900 px-3 py-2"
        >
          <option>All</option>
          <option>High</option>
          <option>Medium</option>
          <option>Low</option>
        </select>
      </div>

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

      {filteredData.map((item, index) => (
        <div
          key={`${item.resource}-${item.title}-${index}`}
          className="rounded-2xl border border-slate-800 bg-slate-900/70 p-6"
        >
          {/* Keep the rest of your existing recommendation card exactly as it is */}
        </div>
      ))}
    </div>
  );
}