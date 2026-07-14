import { useQuery } from '@tanstack/react-query';
import { fetchSettings } from '../services/api';
import LoadingState from '../components/LoadingState';
import ErrorState from '../components/ErrorState';

export default function SettingsPage() {
  const { data, isLoading, error } = useQuery({ queryKey: ['settings'], queryFn: fetchSettings });

  if (isLoading) return <LoadingState />;
  if (error || !data) return <ErrorState message="Settings data is unavailable." />;

  return (
    <div className="grid gap-6 lg:grid-cols-2">
      <div className="rounded-2xl border border-slate-800 bg-slate-900/70 p-6">
        <p className="text-sm text-slate-400">Configuration</p>
        <h2 className="mt-1 text-xl font-semibold">Cloud Scan Preferences</h2>
        <div className="mt-6 space-y-4 text-sm text-slate-300">
          <div className="flex items-center justify-between rounded-xl border border-slate-800 bg-slate-950/70 px-4 py-3"><span>AWS Region</span><span className="font-medium">{data.awsRegion}</span></div>
          <div className="flex items-center justify-between rounded-xl border border-slate-800 bg-slate-950/70 px-4 py-3"><span>Notification Email</span><span className="font-medium">{data.notificationEmail}</span></div>
          <div className="flex items-center justify-between rounded-xl border border-slate-800 bg-slate-950/70 px-4 py-3"><span>Scan Schedule</span><span className="font-medium">{data.scanSchedule}</span></div>
          <div className="flex items-center justify-between rounded-xl border border-slate-800 bg-slate-950/70 px-4 py-3"><span>Theme</span><span className="font-medium">{data.theme}</span></div>
        </div>
      </div>

      <div className="rounded-2xl border border-slate-800 bg-slate-900/70 p-6">
        <p className="text-sm text-slate-400">Application Information</p>
        <h2 className="mt-1 text-xl font-semibold">Platform Details</h2>
        <div className="mt-6 rounded-xl border border-slate-800 bg-slate-950/70 p-4 text-sm text-slate-300">
          <p>{data.applicationInfo}</p>
          <p className="mt-4 text-slate-400">This interface is prepared to connect with the existing Terraform-managed Lambda, API Gateway, DynamoDB, SNS, and S3 layers.</p>
        </div>
      </div>
    </div>
  );
}
