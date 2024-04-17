import { ConnectWallet } from "@thirdweb-dev/react";

export default function Navbar() {
    return (
        <div style={{
            display: "flex",
            flexDirection: "row",
            alignItems: "center",
            justifyContent: "space-between",
            margin: "0px",
            background: "#2596be",
        }}>
            <h1>
                <div style={{
                    marginLeft: "20px",
                    color: "white",
                }}>
                    BunSwap
                </div>
            </h1>
            <ConnectWallet/>
        </div>
    )
}