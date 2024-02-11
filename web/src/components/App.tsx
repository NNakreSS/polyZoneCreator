import React, { useState } from "react";
import "./App.css";
import { debugData } from "../utils/debugData";
import Form from "./Form";
import { useNuiEvent } from "../hooks/useNuiEvent";
import Infos from "./Infos";
import PolyZones from "./PolyZones";
import { fetchNui } from "../utils/fetchNui";

debugData([
  {
    action: "setVisible",
    data: true,
  },
]);

type textsProps = {
  placeholder: string;
  button: string;
};

interface polyzoneModeData extends textsProps {
  mod: boolean;
  name?: string;
}

const App: React.FC = () => {
  const [formVisible, setFormVisible] = useState<boolean>(false);
  const [createMode, setCreateMode] = useState<boolean>(false);
  const [formTexts, setTexts] = useState<textsProps>();

  useNuiEvent(
    "polyzoneMode",
    ({ mod, placeholder, button, name }: polyzoneModeData) => {
      setCreateMode(mod);
      if (name) return fetchNui("startPolyzoneCreator", name);
      setFormVisible(mod);
      setTexts({ placeholder, button });
    }
  );

  return (
    <>
      {formVisible && (
        <Form setVisible={setFormVisible} formTexts={formTexts} />
      )}
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
