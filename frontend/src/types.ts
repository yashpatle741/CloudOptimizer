export interface DashboardData {
  monthlyCost: number;
  potentialSavings: number;
  optimizationScore: number;
  totalResources: number;
  recentScanStatus: string;
  latestRecommendations: Array<{
    id: string;
    title: string;
    priority: string;
    savings: number;
  }>;
  resourceDistribution: Array<{ name: string; value: number }>;
  costTrend: Array<{ month: string; cost: number }>;
}

export interface ResourceItem {
  id: string;
  name: string;
  type: 'EC2' | 'EBS' | 'Snapshot' | 'S3';
  region: string;
  status: 'Active' | 'Idle' | 'Warning' | 'Optimized';
  cost: number;
  details: string;
}

export interface RecommendationItem {
  id: string;
  title: string;
  priority: 'High' | 'Medium' | 'Low';
  reason: string;
  estimatedSavings: number;
  resourceName: string;
  status: 'Open' | 'In Progress' | 'Completed';
}

export interface ReportItem {
  id: string;
  scanDate: string;
  resourcesScanned: number;
  recommendationsFound: number;
  costBefore: number;
  costAfter: number;
}

export interface SettingsData {
  awsRegion: string;
  notificationEmail: string;
  scanSchedule: string;
  theme: string;
  applicationInfo: string;
}
