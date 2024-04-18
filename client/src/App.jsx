import { ConnectWallet } from "@thirdweb-dev/react";
import "./styles/Home.css";
import { SpeedInsights } from "@vercel/speed-insights/next"

export default function Home() {
  return (
    <main className="main">
      <div className="container">
        <div className="header">
          <h1 className="title">
            Welcome to{" "}
            <span className="gradient-text-0">
              <a
                href="https://mb-guild.xyz/"
                target="_blank"
                rel="noopener noreferrer"
              >
                MB Guild
              </a>
            </span>
          </h1>

          <p className="description">
            MB Guild Dapp is under construction, coming soon!
          </p>

          <div className="connect">
            <ConnectWallet />
          </div>
        </div>

        <div className="grid">
          <a
            href="https://mb-guild.xyz/bun"
            className="card"
            target="_blank"
            rel="noopener noreferrer"
          >
            <img
              src="/images/Join_The_Bun_Run.jpg"
              alt="Meet $BUN your friendly bas neighbor"
            />
            <div className="card-text">
              <h2 className="gradient-text-1">What is $BUN ➜</h2>
              <p>
                MB Guild community token launched and deployed on Base Ethereum L2 chain
              </p>
            </div>
          </a>

          <a
            href="https://mb-guild.xyz/bun/presale"
            className="card"
            target="_blank"
            rel="noopener noreferrer"
          >
            <img
              src="/images/Bun_Developing.jpg"
              alt="Join the presal"
            />
            <div className="card-text">
              <h2 className="gradient-text-2">Presale ➜</h2>
              <p>
                Presale has been closed!
              </p>
            </div>
          </a>

          <a
            href="https://mb-guild.xyz/bun/tokenomic"
            className="card"
            target="_blank"
            rel="noopener noreferrer"
          >
            <img
              src="/images/Contract_Signed.jpg"
              alt="Placeholder preview of templates"
            />
            <div className="card-text">
              <h2 className="gradient-text-3">Tokenomic ➜</h2>
              <p>
                0% teams allocations
              </p>
            </div>
          </a>
        </div>
      </div>
    </main>
  );
}
