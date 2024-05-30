import { Token } from "../Main";
import { Box } from "@material-ui/core";

import { useEthers } from "@usedapp/core";

interface YourWalletProps {
  supportedTokens: Array<Token>;
}

const useStyles = makeStyles((theme) => ({
  box: {
    backgroundColor: "white",
    borderRadius: "25px",
  },
  header: {},
  tokenImg: {
    width: "30px",
    height: "32px",
  },
  tokenName: {
    alignContent: "middle",
  },
}));

export const YourWallet = ({ supportedTokens }: YourWalletProps) => {
  const { account } = useEthers();

  return <Box sx={{ width: "115%" }}></Box>;
};
