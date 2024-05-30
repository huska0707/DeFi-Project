import React, { useState } from "react";
import { useEthers } from "@usedapp/core";
import { Box, makeStyles, Grid } from "@material-ui/core";
import { ClaimToken } from "./ClaimToken";
import { TokenToClaim } from "./TokenToClaim";

export const StakingContract = ({ supportedTokens }: StakingContractProps) => {
  const classes = useStyles();

  const handleChange = (event: React.ChangeEvent<{}>, newValue: string) => {
    setSelectedTokenIndex(parseInt(newValue));
  };

  const { account } = useEthers();

  return (
    <Box>
      <h2 className={classes.header}>Claim Your Tokens</h2>
      <Box className={classes.box}>
        <div>
          <Grid>
            <TokenToClaim />
            <ClaimToken />
          </Grid>
        </div>
      </Box>
    </Box>
  );
};
