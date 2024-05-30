import { Token } from "../Main";
import { Box } from "@material-ui/core";

import { useEthers } from "@usedapp/core";

interface YourWalletProps {
  supportedTokens: Array<Token>;
}

export const YourWallet = ({ supportedTokens }: YourWalletProps) => {
  const { account } = useEthers();

  return <Box sx={{ width: "115%" }}></Box>;
};
