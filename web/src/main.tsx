import ReactDOM from "react-dom/client";
import { VisibilityProvider } from "./providers/VisibilityProvider";
import App from "./components/App";
import "./index.css";

ReactDOM.createRoot(document.getElementById("root")!).render(
  <VisibilityProvider>
    <App />
  </VisibilityProvider>
);
