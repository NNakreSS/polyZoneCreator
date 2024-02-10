import React, { useState } from "react";
import "./App.css";
import { debugData } from "../utils/debugData";
import Form from "./Form";
import { useNuiEvent } from "../hooks/useNuiEvent";
import Infos from "./Infos";
import PolyZones from "./PolyZones";

debugData([
  {
    action: "setVisible",
    data: true,
  },
]);

const App: React.FC = () => {
  const [formVisible, setFormVisible] = useState<boolean>(false);
  const [createMode, setCreateMode] = useState<boolean>(true);

  useNuiEvent("startCreatePolyzone", () => setFormVisible(true));
  useNuiEvent("createPolyzoneMode", (mode: boolean) => setCreateMode(mode));
  return (
    <>
      {formVisible && <Form setVisible={setFormVisible} />}
      {createMode && (
        <>
          <PolyZones />
          <Infos />
        </>
      )}
    </>
  );
};

export default App;
