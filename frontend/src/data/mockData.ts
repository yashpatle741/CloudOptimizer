import type { DashboardData, ResourceItem, RecommendationItem, ReportItem, SettingsData } from '../types';

export const dashboardData: DashboardData = {
  monthlyCost: 28400,
  potentialSavings: 7420,
  optimizationScore: 87,
  totalResources: 148,
  recentScanStatus: 'Completed 12 mins ago',
  latestRecommendations: [
    { id: '1', title: 'Stop idle EC2 instances', priority: 'High', savings: 420 },
    { id: '2', title: 'Delete unattached EBS volumes', priority: 'Medium', savings: 180 },
    { id: '3', title: 'Enable S3 lifecycle policies', priority: 'High', savings: 310 }
  ],
  resourceDistribution: [
    { name: 'EC2', value: 54 },
    { name: 'EBS', value: 28 },
    { name: 'S3', value: 42 },
    { name: 'Snapshots', value: 24 }
  ],
  costTrend: [
    { month: 'Jan', cost: 22200 },
    { month: 'Feb', cost: 24000 },
    { month: 'Mar', cost: 25600 },
    { month: 'Apr', cost: 24800 },
    { month: 'May', cost: 26900 },
    { month: 'Jun', cost: 28400 }
  ]
};

export const resourcesData: ResourceItem[] = [
  { id: 'r1', name: 'web-prod-01', type: 'EC2', region: 'us-east-1', status: 'Idle', cost: 420, details: 't3.large - 24/7' },
  { id: 'r2', name: 'analytics-ec2', type: 'EC2', region: 'us-west-2', status: 'Active', cost: 960, details: 'm5.xlarge - scheduled' },
  { id: 'r3', name: 'data-vol-01', type: 'EBS', region: 'us-east-1', status: 'Warning', cost: 180, details: 'gp3 volume 500GiB' },
  { id: 'r4', name: 'backup-snap-01', type: 'Snapshot', region: 'eu-west-1', status: 'Optimized', cost: 40, details: '30 days retention' },
  { id: 'r5', name: 'finance-archive', type: 'S3', region: 'us-east-1', status: 'Active', cost: 320, details: 'Standard IA' }
];

export const recommendationsData: RecommendationItem[] = [
  { id: 'c1', title: 'Stop Idle EC2', priority: 'High', reason: 'Instance has been idle for 14 days', estimatedSavings: 420, resourceName: 'web-prod-01', status: 'Open' },
  { id: 'c2', title: 'Delete Unattached Volume', priority: 'Medium', reason: 'Volume is not attached to any instance', estimatedSavings: 180, resourceName: 'data-vol-01', status: 'In Progress' },
  { id: 'c3', title: 'Delete Old Snapshot', priority: 'Low', reason: 'Snapshot exceeds 90-day retention', estimatedSavings: 60, resourceName: 'backup-snap-01', status: 'Completed' },
  { id: 'c4', title: 'Enable S3 Lifecycle Policy', priority: 'High', reason: 'Archive tier can reduce storage cost', estimatedSavings: 310, resourceName: 'finance-archive', status: 'Open' },
  { id: 'c5', title: 'Enable Block Public Access', priority: 'High', reason: 'Bucket policy allows public exposure', estimatedSavings: 0, resourceName: 'finance-archive', status: 'Open' }
];

export const reportsData: ReportItem[] = [
  { id: 'p1', scanDate: '2026-07-10', resourcesScanned: 148, recommendationsFound: 8, costBefore: 28400, costAfter: 24800 },
  { id: 'p2', scanDate: '2026-06-30', resourcesScanned: 142, recommendationsFound: 6, costBefore: 27600, costAfter: 24350 },
  { id: 'p3', scanDate: '2026-06-15', resourcesScanned: 138, recommendationsFound: 5, costBefore: 27150, costAfter: 24080 }
];

export const settingsData: SettingsData = {
  awsRegion: 'us-east-1',
  notificationEmail: 'ops-team@company.com',
  scanSchedule: 'Daily at 02:00 UTC',
  theme: 'Dark',
  applicationInfo: 'CloudOptimizer internal operations dashboard'
};
