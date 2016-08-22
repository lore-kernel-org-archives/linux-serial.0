From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: [PATCH] ARM: dts: imx6sx: document SION necessity of
 ENET1_REF_CLK1
Date: Mon, 22 Aug 2016 17:08:05 +0200
Message-ID: <1471878485.2310.1.camel@googlemail.com>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1458825865-7434-7-git-send-email-u.kleine-koenig@pengutronix.de>
 <1470350663.26773.41.camel@googlemail.com>
 <20160805065845.GI17874@pengutronix.de>
 <1470398615.1936.22.camel@googlemail.com>
 <CAOMZO5BQQemrKFjejUxQpW+d=BGn_b+d_sbr9Untu8iO3dOVvw@mail.gmail.com>
 <1471120532.1923.4.camel@googlemail.com>
 <20160815052244.mwygjlo72e46w353@pengutronix.de>
 <1471425931.1934.18.camel@googlemail.com>
Reply-To: chf.fritz@googlemail.com
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
To: Shawn Guo <shawnguo@kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: Martin Fuzzey <mfuzzey@parkeon.com>, Baruch Siach <baruch@tkos.co.il>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, 2016-08-17 at 11:25 +0200, Christoph Fritz wrote:
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  arch/arm/boot/dts/imx6sx-pinfunc.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6sx-pinfunc.h b/arch/arm/boot/dts/imx6sx-pinfunc.h
> index bb9c6b7..42c4c80 100644
> --- a/arch/arm/boot/dts/imx6sx-pinfunc.h
> +++ b/arch/arm/boot/dts/imx6sx-pinfunc.h
> @@ -308,6 +308,20 @@
>  #define MX6SX_PAD_ENET1_RX_CLK__VDEC_DEBUG_35                     0x008C 0x03D4 0x0000 0x8 0x0
>  #define MX6SX_PAD_ENET1_RX_CLK__PCIE_CTRL_DEBUG_29                0x008C 0x03D4 0x0000 0x9 0x0
>  #define MX6SX_PAD_ENET1_TX_CLK__ENET1_TX_CLK                      0x0090 0x03D8 0x0000 0x0 0x0
> +/*
> + * SION bit is necessary for ENET1_REF_CLK1 (ENET2_REF_CLK2 untested) if it is
> + * used as clock output of IMX6SX_CLK_ENET_REF (ENET1_TX_CLK) to e.g. supply a
> + * PHY in RMII mode. This configuration is valid if:
> + *  - bit 1 in field IMX6SX_GPR1_FEC_CLOCK_PAD_DIR_MASK is set
> + *  - bit 1 in field IMX6SX_GPR1_FEC_CLOCK_MUX_SEL_MASK unset
> + * It seems to be a silicon bug that in this configuration ENET1_TX reference
> + * clock isn't provided automatically.  According to i.MX6SX reference manual
> + * (IOMUXC_GPR_GPR1 field descriptions: ENET1_CLK_SEL, Rev. 0 from 2/2015) it
> + * should be the case.
> + * So this might have unwanted side effects for other hardware units that are
> + * also connected to that pin and using respective function as input (e.g.
> + * UART1's DTR handling on MX6SX_PAD_ENET1_TX_CLK__UART1_DTR_B).
> + */
>  #define MX6SX_PAD_ENET1_TX_CLK__ENET1_REF_CLK1                    0x0090 0x03D8 0x0760 0x1 0x1
>  #define MX6SX_PAD_ENET1_TX_CLK__AUDMUX_AUD4_RXD                   0x0090 0x03D8 0x0644 0x2 0x1
>  #define MX6SX_PAD_ENET1_TX_CLK__UART1_DTR_B                       0x0090 0x03D8 0x0000 0x3 0x0

@Uwe and Fabio: Can I get your Ack on this?
@Shawn: Can you queue this patch for upstream?
