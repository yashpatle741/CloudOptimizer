export default function ErrorState({ message }: { message: string }) {
  return (
    <div className="rounded-2xl border border-rose-500/30 bg-rose-500/10 p-6 text-rose-200">
      <p className="font-semibold">Unable to load data</p>
      <p className="mt-2 text-sm">{message}</p>
    </div>
  );
}
