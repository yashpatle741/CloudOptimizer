import { useMemo } from 'react';
import { useQuery } from '@tanstack/react-query';
import { Search, ArrowUpDown } from 'lucide-react';
import { fetchResources } from '../services/api';
import LoadingState from '../components/LoadingState';
import ErrorState from '../components/ErrorState';
import EmptyState from '../components/EmptyState';

export default function ResourcesPage() {
  const { data, isLoading, error } = useQuery({ queryKey: ['resources'], queryFn: fetchResources });
  const query = '';
  const items = useMemo(() => data ?? [], [data]);

  if (isLoading) return <LoadingState />;
  if (error) return <ErrorState message="Resources data is unavailable." />;
  if (!items.length) return <EmptyState title="No resources found" description="Waiting for the next scan run." />;

  return (
    <div className="space-y-6">
      <div className="rounded-2xl border border-slate-800 bg-slate-900/70 p-6">
        <div className="mb-4 flex flex-col gap-4 lg:flex-row lg:items-center lg:justify-between">
          <div>
            <p className="text-sm text-slate-400">Inventory</p>
            <h2 className="text-xl font-semibold">Managed AWS Resources</h2>
          </div>
          <div className="flex items-center gap-2 rounded-xl border border-slate-700 bg-slate-950/70 px-3 py-2">
            <Search size={16} className="text-slate-500" />
            <input className="bg-transparent text-sm outline-none" placeholder="Search resources" value={query} readOnly />
          </div>
        </div>

        <div className="overflow-x-auto">
          <table className="min-w-full text-left text-sm">
            <thead className="text-slate-400">
              <tr>
                <th className="px-3 py-3">Resource</th>
                <th className="px-3 py-3">Type</th>
                <th className="px-3 py-3">Region</th>
                <th className="px-3 py-3">Status</th>
                <th className="px-3 py-3">Cost</th>
                <th className="px-3 py-3">Details</th>
              </tr>
            </thead>
            <tbody>
              {items.map((item) => (
                <tr key={item.id} className="border-t border-slate-800 text-slate-200">
                  <td className="px-3 py-3 font-medium">{item.name}</td>
                  <td className="px-3 py-3">{item.type}</td>
                  <td className="px-3 py-3">{item.region}</td>
                  <td className="px-3 py-3">
                    <span className="rounded-full bg-slate-800 px-2 py-1 text-xs">{item.status}</span>
                  </td>
                  <td className="px-3 py-3">${item.cost}</td>
                  <td className="px-3 py-3">{item.details}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>

        <div className="mt-4 flex items-center justify-between text-sm text-slate-400">
          <span>Showing {items.length} resources</span>
          <div className="flex items-center gap-2 rounded-full border border-slate-700 px-3 py-1">
            <ArrowUpDown size={14} /> Sort by cost
          </div>
        </div>
      </div>
    </div>
  );
}
