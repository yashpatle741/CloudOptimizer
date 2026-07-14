import axios from "axios";

const client = axios.create({
  baseURL: "http://127.0.0.1:8000/api/v1",
});

export const fetchDashboard = async () => {
  const response = await client.get("/dashboard");
  return response.data;
};

export const fetchResources = async () => {
  const response = await client.get("/resources");
  return response.data;
};

export const fetchRecommendations = async () => {
  const response = await client.get("/recommendations");
  return response.data;
};

export const fetchReports = async () => {
  const response = await client.get("/reports");
  return response.data;
};

export const fetchSettings = async () => {
  const response = await client.get("/settings");
  return response.data;
};

export const healthCheck = async () => {
  return client.get("/health");
};