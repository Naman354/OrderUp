import axios from "axios";

const ML_MODEL_URL = "https://personal-recomendation-1.onrender.com/predict";

export const getTop10Recommendations = async (req, res) => {
  try {
    const { customer_id } = req.body;

    if (!customer_id) {
      return res.status(400).json({
        success: false,
        error: "customer_id is required",
      });
    }

    const response = await axios.post(
      ML_MODEL_URL,
      { customer_id },
      {
        headers: { "Content-Type": "application/json" },
        timeout: 60000, // 60 seconds timeout
      }
    );

    return res.status(200).json({
      success: true,
      recommendations: response.data,
    });
  } catch (error) {
    console.error("ML model error:", error.message);

    if (error.response) {
      return res.status(error.response.status).json({
        success: false,
        error:
          error.response.data?.error ||
          error.response.data?.detail ||
          "Error from ML model.",
      });
    }

    return res.status(500).json({
      success: false,
      error: "Failed to connect to ML service. Please try again later.",
    });
  }
};
