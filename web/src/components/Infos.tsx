import React, { useEffect, useState } from "react";
import { fetchNui } from "../utils/fetchNui";
// icons
import {
  IoAddCircle,
  IoArrowDownCircle,
  IoArrowUpCircle,
  IoSave,
} from "react-icons/io5";

import {
  FaDeleteLeft,
  FaAnglesDown,
  FaAnglesUp,
  FaCircleArrowLeft,
  FaCircleArrowRight,
} from "react-icons/fa6";
import { FaRegDotCircle } from "react-icons/fa";
import { useNuiEvent } from "../hooks/useNuiEvent";

type KeyInfo = {
  key: string;
  type: string;
};

const Infos: React.FC = ({}) => {
  const [keys, setKeys] = useState<KeyInfo[] | any>([]);
  const [pointCount, setPointCount] = useState<number>(0);

  useNuiEvent("pointCount", (data: number) =>
    setPointCount((prev) => prev + data)
  );

  const Icons: Record<string, React.ReactNode> = {
    add: <IoAddCircle />,
    del: <FaDeleteLeft />,
    back: <IoArrowDownCircle />,
    down: <FaAnglesDown />,
    forward: <IoArrowUpCircle />,
    left: <FaCircleArrowLeft />,
    right: <FaCircleArrowRight />,
    up: <FaAnglesUp />,
    save: <IoSave />,
  };

  useEffect(() => {
    fetchNui("getKeyInfos").then((dkeys: any) => {
      console.log(dkeys[0].key), setKeys(dkeys);
    });
  }, []);

  return (
    <div className="w-full absolute bottom-0">
      <div className="flex justify-center items-center w-3/4 p-2 m-auto gap-3">
        {keys?.map((key: KeyInfo, i: number) => (
          <div
            className="flex gap-2 justify-center items-center text-center bg-zinc-800 text-sky-500 rounded-md px-5 py-2 font-mono font-bold shadow-[-6px_-6px_0px_0px] shadow-black"
            key={i}
          >
            {key.key}
            {Icons[key.type]}
          </div>
        ))}
        <div className="flex gap-2 justify-center items-center text-center bg-zinc-800 text-sky-500 rounded-md px-5 py-2 font-mono font-bold shadow-[-6px_-6px_0px_0px] shadow-black">
          <svg
            className="w-6"
            xmlns="http://www.w3.org/2000/svg"
            fill="rgb(14 ,165 ,233)"
            version="1.1"
            id="Capa_1"
            viewBox="0 0 356.572 356.572"
          >
            <g>
              <path d="M181.563,0C120.762,0,59.215,30.525,59.215,88.873V237.5c0,65.658,53.412,119.071,119.071,119.071   c65.658,0,119.07-53.413,119.07-119.071V88.873C297.356,27.809,237.336,0,181.563,0z M274.945,237.5   c0,53.303-43.362,96.657-96.659,96.657c-53.299,0-96.657-43.354-96.657-96.657v-69.513c20.014,6.055,57.685,15.215,102.221,15.215   c28.515,0,59.831-3.809,91.095-14.567V237.5z M274.945,144.794c-81.683,31.233-168.353,7.716-193.316-0.364V88.873   c0-43.168,51.489-66.46,99.934-66.46c46.481,0,93.382,20.547,93.382,66.46V144.794z M190.893,48.389v81.248   c0,6.187-5.023,11.208-11.206,11.208c-6.185,0-11.207-5.021-11.207-11.208V48.389c0-6.186,5.021-11.207,11.207-11.207   C185.869,37.182,190.893,42.203,190.893,48.389z M154.938,40.068V143.73c-15.879,2.802-62.566-10.271-62.566-10.271   C80.233,41.004,154.938,40.068,154.938,40.068z" />
            </g>
          </svg>
          {Icons["add"]}
        </div>
        <div className="flex gap-2 justify-center items-center text-center bg-zinc-800 text-sky-500 rounded-md px-5 py-2 font-mono font-bold shadow-[-6px_-6px_0px_0px] shadow-black">
          <svg
            className="w-6 text-sky-500"
            xmlns="http://www.w3.org/2000/svg"
            fill="rgb(14 ,165 ,233)"
            version="1.1"
            id="Capa_1"
            viewBox="0 0 356.572 356.572"
          >
            <g>
              <path d="M181.563,0C120.762,0,59.215,30.525,59.215,88.873V237.5c0,65.658,53.412,119.071,119.071,119.071   c65.658,0,119.07-53.413,119.07-119.071V88.873C297.356,27.809,237.336,0,181.563,0z M274.945,237.5   c0,53.303-43.362,96.657-96.659,96.657c-53.299,0-96.657-43.354-96.657-96.657v-69.513c20.014,6.055,57.685,15.215,102.221,15.215   c28.515,0,59.831-3.809,91.095-14.567V237.5z M274.945,144.794c-81.683,31.233-168.353,7.716-193.316-0.364V88.873   c0-43.168,51.489-66.46,99.934-66.46c46.481,0,93.382,20.547,93.382,66.46V144.794z M190.893,48.389v81.248   c0,6.187-5.023,11.208-11.206,11.208c-6.185,0-11.207-5.021-11.207-11.208V48.389c0-6.186,5.021-11.207,11.207-11.207   C185.869,37.182,190.893,42.203,190.893,48.389z M264.272,130.378c0,0-46.687,13.072-62.566,10.271V36.988   C201.706,36.988,276.412,37.923,264.272,130.378z" />
            </g>
          </svg>
          {Icons["del"]}
        </div>
        <div className="flex gap-2 justify-center items-center text-center bg-zinc-800 text-sky-500 rounded-md px-5 py-2 font-mono shadow-[-6px_-6px_0px_0px] shadow-black">
          <FaRegDotCircle />
          {pointCount}
        </div>
      </div>
    </div>
  );
};

export default Infos;
