import React, { useState } from "react";
import { fetchNui } from "../utils/fetchNui";

type textsProps = {
  placeholder: string;
  button: string;
};

interface porpsTypes {
  setVisible: (visible: boolean) => void;
  formTexts?: textsProps;
}

const Form: React.FC<porpsTypes> = ({ setVisible, formTexts }) => {
  const [name, setName] = useState<string>("");

  return (
    <div className="bg-zinc-800 w-2/4 h-2/5 m-auto mt-[20%] p-5 flex flex-wrap flex-col gap-5 rounded-md justify-center items-center border-2 border-sky-500">
      <input
        type="text"
        value={name}
        placeholder={formTexts?.placeholder}
        onChange={(e) =>
          !e.target.value.includes(" ") && setName(e.target.value)
        }
        className="w-1/2 p-2 pl-5 rounded-sm outline-none ring-2 ring-sky-500 text-sm font-mono font-semibold"
      />
      <button
        onClick={() => {
          if (name == "") return;
          console.log(name);
          setVisible(false);
          fetchNui("startPolyzoneCreator", name);
        }}
        className="text-sky-400 font-mono ring-sky-500 ring-1 rounded-sm px-5 py-1 w-1/3 hover:bg-sky-400 hover:text-white transition-all duration-500"
      >
        {formTexts?.button}
      </button>
    </div>
  );
};

export default Form;
