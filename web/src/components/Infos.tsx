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
  FaArrowsUpDown,
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
    size: <FaArrowsUpDown />,
  };

  useEffect(() => {
    fetchNui("getKeyInfos").then((dkeys: any) => setKeys(dkeys));
  }, []);

  return (
    <div className="w-full absolute bottom-0">
      <div className="flex justify-center items-center w-3/4 p-2 m-auto gap-3">
        {keys?.map((key: KeyInfo, i: number) => (
          <div
            className="h-full flex gap-2 justify-center items-center text-center bg-zinc-800 text-sky-500 rounded-md px-5 py-2 font-mono font-bold shadow-[-6px_-6px_0px_0px] shadow-black"
            key={i}
          >
            <span className="text-xl">{key.key}</span>
            {Icons[key.type]}
          </div>
        ))}
        <div className="h-full flex gap-2 justify-center items-center text-center bg-zinc-800 text-sky-500 rounded-md px-5 py-2 font-mono font-bold shadow-[-6px_-6px_0px_0px] shadow-black">
          <svg
            className="w-[1.75rem]"
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
        <div className="h-full flex gap-2 justify-center items-center text-center bg-zinc-800 text-sky-500 rounded-md px-5 py-2 font-mono font-bold shadow-[-6px_-6px_0px_0px] shadow-black">
          <svg
            className="w-[1.75rem]"
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
        <div className="h-full flex gap-2 justify-center items-center text-center bg-zinc-800 text-sky-500 rounded-md px-5 py-2 font-mono font-bold shadow-[-6px_-6px_0px_0px] shadow-black">
          <svg
            className="w-[1.75rem]"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            fill="rgb(14,165,233)"
          >
            <path
              className="w-[1.75rem]"
              d="M12 5L12.5303 4.46967C12.2374 4.17678 11.7626 4.17678 11.4697 4.46967L12 5ZM12 13L11.4697 13.5303C11.7626 13.8232 12.2374 13.8232 12.5303 13.5303L12 13ZM9.46967 6.46967C9.17678 6.76256 9.17678 7.23744 9.46967 7.53033C9.76256 7.82322 10.2374 7.82322 10.5303 7.53033L9.46967 6.46967ZM13.4697 7.53033C13.7626 7.82322 14.2374 7.82322 14.5303 7.53033C14.8232 7.23744 14.8232 6.76256 14.5303 6.46967L13.4697 7.53033ZM10.5303 10.4697C10.2374 10.1768 9.76256 10.1768 9.46967 10.4697C9.17678 10.7626 9.17678 11.2374 9.46967 11.5303L10.5303 10.4697ZM14.5303 11.5303C14.8232 11.2374 14.8232 10.7626 14.5303 10.4697C14.2374 10.1768 13.7626 10.1768 13.4697 10.4697L14.5303 11.5303ZM3.25 10V14H4.75V10H3.25ZM20.75 14V10H19.25V14H20.75ZM11.25 5V13H12.75V5H11.25ZM11.4697 4.46967L9.46967 6.46967L10.5303 7.53033L12.5303 5.53033L11.4697 4.46967ZM11.4697 5.53033L13.4697 7.53033L14.5303 6.46967L12.5303 4.46967L11.4697 5.53033ZM12.5303 12.4697L10.5303 10.4697L9.46967 11.5303L11.4697 13.5303L12.5303 12.4697ZM12.5303 13.5303L14.5303 11.5303L13.4697 10.4697L11.4697 12.4697L12.5303 13.5303ZM20.75 10C20.75 5.16751 16.8325 1.25 12 1.25V2.75C16.0041 2.75 19.25 5.99594 19.25 10H20.75ZM12 22.75C16.8325 22.75 20.75 18.8325 20.75 14H19.25C19.25 18.0041 16.0041 21.25 12 21.25V22.75ZM3.25 14C3.25 18.8325 7.16751 22.75 12 22.75V21.25C7.99594 21.25 4.75 18.0041 4.75 14H3.25ZM4.75 10C4.75 5.99594 7.99594 2.75 12 2.75V1.25C7.16751 1.25 3.25 5.16751 3.25 10H4.75Z"
              fill="rgb(14,165,233)"
            />
          </svg>
          {Icons["size"]}
        </div>
        <div className="h-full flex gap-2 justify-center items-center text-center bg-zinc-800 text-sky-500 rounded-md px-5 py-2 font-mono shadow-[-6px_-6px_0px_0px] shadow-black">
          <FaRegDotCircle className="text-xl" />
          {pointCount}
        </div>
      </div>
    </div>
  );
};

export default Infos;
