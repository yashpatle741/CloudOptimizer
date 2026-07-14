import { useQuery } from '@tanstack/react-query';
import { Download, FileText } from 'lucide-react';
import { fetchReports } from '../services/api';
import LoadingState from '../components/LoadingState';
import ErrorState from '../components/ErrorState';
import EmptyState from '../components/EmptyState';

export default function ReportsPage() {
  const { data, isLoading, error } = useQuery({
    queryKey: ['reports'],
    queryFn: fetchReports,
  });

  if (isLoading) return <LoadingState />;
  if (error)
    return <ErrorState message="Reports data is unavailable." />;
  if (!data?.length)
    return (
      <EmptyState
        title="No reports yet"
        description="Historical scans will appear here."
      />
    );

  const downloadCSV = () => {
    window.open(
      'http://16.16.173.251:8000/api/v1/export/csv',
      '_blank'
    );
  };

  return (
    <div className="space-y-6">
      <div className="grid gap-4 md:grid-cols-3">
        <div className="rounded-2xl border border-slate-800 bg-slate-900/70 p-6">
          <p className="text-sm text-slate-400">
            Previous Scan Reports
          </p>
          <p className="mt-2 text-3xl font-semibold">
            {data.length}
          </p>
        </div>

        <div className="rounded-2xl border border-slate-800 bg-slate-900/70 p-6">
          <p className="text-sm text-slate-400">
            Resource Summary
          </p>
          <p className="mt-2 text-3xl font-semibold">
            {data.reduce(
              (sum, item) => sum + item.resourcesScanned,
              0
            )}
          </p>
        </div>

        <div className="rounded-2xl border border-slate-800 bg-slate-900/70 p-6">
          <p className="text-sm text-slate-400">
            Cost Summary
          </p>
          <p className="mt-2 text-3xl font-semibold">
            ${data[data.length - 1].costAfter}
          </p>
        </div>
      </div>

      <div className="rounded-2xl border border-slate-800 bg-slate-900/70 p-6">
        <div className="mb-4 flex items-center justify-between">
          <div>
            <p className="text-sm text-slate-400">
              Scan History
            </p>
            <h2 className="text-xl font-semibold">
              Historical Reports
            </h2>
          </div>

          <div className="flex gap-2">
            <button
             href="http://16.16.173.251:8000/api/v1/export/csv"
              target="_blank"
                rel="noopener noreferrer"
              className="flex items-center gap-2 rounded-xl border border-slate-700 px-3 py-2 text-sm transition hover:bg-slate-800"
            >
              <Download size={16} />
              CSV
            </button>

            <button className="flex items-center gap-2 rounded-xl border border-slate-700 px-3 py-2 text-sm transition hover:bg-slate-800">
              <FileText size={16} />
              PDF
            </button>
          </div>
        </div>

        <div className="overflow-x-auto">
          <table className="min-w-full text-left text-sm">
            <thead className="text-slate-400">
              <tr>
                <th className="px-3 py-3">Date</th>
                <th className="px-3 py-3">Resources</th>
                <th className="px-3 py-3">Recommendations</th>
                <th className="px-3 py-3">Cost Before</th>
                <th className="px-3 py-3">Cost After</th>
              </tr>
            </thead>

            <tbody>
              {data.map((item) => (
                <tr
                  key={item.id}
                  className="border-t border-slate-800 text-slate-200"
                >
                  <td className="px-3 py-3">
                    {item.scanDate}
                  </td>
                  <td className="px-3 py-3">
                    {item.resourcesScanned}
                  </td>
                  <td className="px-3 py-3">
                    {item.recommendationsFound}
                  </td>
                  <td className="px-3 py-3">
                    ${item.costBefore}
                  </td>
                  <td className="px-3 py-3">
                    ${item.costAfter}
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}