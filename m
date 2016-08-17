From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6sx: document SION necessity of
 ENET1_REF_CLK1
Date: Wed, 17 Aug 2016 11:26:42 -0300
Message-ID: <CAOMZO5CCwreYYgNd6uGnf9A0=KcMefYqHLFNWdMnweSTezxnWQ@mail.gmail.com>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1458825865-7434-7-git-send-email-u.kleine-koenig@pengutronix.de>
 <1470350663.26773.41.camel@googlemail.com>
 <20160805065845.GI17874@pengutronix.de>
 <1470398615.1936.22.camel@googlemail.com>
 <CAOMZO5BQQemrKFjejUxQpW+d=BGn_b+d_sbr9Untu8iO3dOVvw@mail.gmail.com>
 <1471120532.1923.4.camel@googlemail.com>
 <20160815052244.mwygjlo72e46w353@pengutronix.de>
 <1471425931.1934.18.camel@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1471425931.1934.18.camel@googlemail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Martin Fuzzey <mfuzzey@parkeon.com>, Baruch Siach <baruch@tkos.co.il>, Sascha Hauer <kernel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Christoph,

On Wed, Aug 17, 2016 at 6:25 AM, Christoph Fritz
<chf.fritz@googlemail.com> wrote:

> +/*
> + * SION bit is necessary for ENET1_REF_CLK1 (ENET2_REF_CLK2 untested) if it is
> + * used as clock output of IMX6SX_CLK_ENET_REF (ENET1_TX_CLK) to e.g. supply a
> + * PHY in RMII mode. This configuration is valid if:
> + *  - bit 1 in field IMX6SX_GPR1_FEC_CLOCK_PAD_DIR_MASK is set
> + *  - bit 1 in field IMX6SX_GPR1_FEC_CLOCK_MUX_SEL_MASK unset

So in your case the imx6sx_enet_clk_sel() does not do what you need:

static void __init imx6sx_enet_clk_sel(void)
{
    struct regmap *gpr;

    gpr = syscon_regmap_lookup_by_compatible("fsl,imx6sx-iomuxc-gpr");
    if (!IS_ERR(gpr)) {
        regmap_update_bits(gpr, IOMUXC_GPR1,
                   IMX6SX_GPR1_FEC_CLOCK_MUX_SEL_MASK, 0);
        regmap_update_bits(gpr, IOMUXC_GPR1,
                   IMX6SX_GPR1_FEC_CLOCK_PAD_DIR_MASK, 0);
    } else {
        pr_err("failed to find fsl,imx6sx-iomux-gpr regmap\n");
    }
}

It seems that it is not a good idea to have imx6sx_enet_clk_sel() in
common code as the GPR1 setting can change from board to board.

I think we need the fec driver to be in charge of configuring the GPR1 register.

This is unrelated to your patch though :-)
