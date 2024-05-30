import { useEthers, useLookupAddress, useEtherBalance } from "@usedapp/core"
import {
    Button,
    makeStyles,
    AppBar,
    Toolbar,
    Typography,
    Grid,
} from "@material-ui/core"

const useStyles = makeStyles((theme) => ({
    header: {
        backgroundColor: "#400C88",
    },
    logo: {
        fontFamily: "Work Sans, sans-serif",
        fontWeight: 600,
        color: "#FFFEFE",
        textAlign: "left",
    },
    wallet: {
        fontFamily: "Work Sans, sans-serif",
        fontWeight: 600,
        color: "#FFFEFE",
        textAlign: "right",
    },
    menu: {
        fontFamily: "Work Sans, sans-serif",
        fontWeight: 600,
        color: "#FFFEFE",
        textAlign: "center",
        justifyContent: "center",
    },
}))

const headersData = [
    {
        label: "Staking",
        href: "/staking",
    },
    {
        label: "Funds",
        href: "/funds",
    },
    {
        label: "FlashLoans",
        href: "/flash-loan",
    },
    {
        label: "NFT",
        href: "/nft",
    },
    {
        label: "FAQ",
        href: "/faq",
    },

];

export const Header = () => {
    const classes = useStyles()
    const { account, activateBrowserWallet, deactivate } = useEthers()
    const ens = useLookupAddress()
    console.log(ens)
    const isConnected = account !== undefined

    const displayDesktop = () => {
        return (
            <Toolbar>
                {DeFiProjectLogo}
                {getMenuButtons()}
            </Toolbar >
        );
    };

    const DeFiProjectLogo = (
        <Typography variant="h6" component="h1" className={classes.logo} >
            StakingContract
        </Typography>
    );

    const getMenuButtons = () => {
        return headersData.map(({ label, href }) => {
            return (
                <div className={classes.menu}>
                    <Button
                        {...{
                            key: label,
                            color: "inherit",
                            to: href
                        }}
                    >
                        {label}
                    </Button>
                </div>

            );
        });
    };


    return (
        <header>
            <AppBar className={classes.header}>{displayDesktop()}</AppBar>
        </header>
    );
}

