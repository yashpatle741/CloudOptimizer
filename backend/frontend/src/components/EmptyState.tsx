export default function EmptyState({ title, description }: { title: string; description: string }) {
  return (
    <div className="rounded-2xl border border-dashed border-slate-700 bg-slate-900/50 p-10 text-center text-slate-400">
      <p className="text-lg font-semibold text-slate-200">{title}</p>
      <p className="mt-2 text-sm">{description}</p>
    </div>
  );
}
