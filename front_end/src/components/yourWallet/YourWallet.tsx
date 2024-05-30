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

const StyledTableCell = styled(TableCell)(({ theme }) => ({
  // [`&.${head}`]: {
  backgroundColor: theme.palette.common.black,
  color: theme.palette.common.white,
  // },
  // [`&.${body}`]: {
  fontSize: 18,
  // },
}));

const StyledTableRow = styled(TableRow)(({ theme }) => ({
  "&:nth-of-type(odd)": {
    backgroundColor: theme.palette.action.hover,
  },
  // hide last border
  "&:last-child td, &:last-child th": {
    border: 0,
  },
}));

export const YourWallet = ({ supportedTokens }: YourWalletProps) => {
  const { account } = useEthers();

  return <Box sx={{ width: "115%" }}></Box>;
};
