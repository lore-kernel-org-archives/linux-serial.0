From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: Re: serial: imx: regression triggered by newly introduced DSR irq
 handling
Date: Sat, 13 Aug 2016 22:35:32 +0200
Message-ID: <1471120532.1923.4.camel@googlemail.com>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1458825865-7434-7-git-send-email-u.kleine-koenig@pengutronix.de>
 <1470350663.26773.41.camel@googlemail.com>
 <20160805065845.GI17874@pengutronix.de>
 <1470398615.1936.22.camel@googlemail.com>
 <CAOMZO5BQQemrKFjejUxQpW+d=BGn_b+d_sbr9Untu8iO3dOVvw@mail.gmail.com>
Reply-To: chf.fritz@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOMZO5BQQemrKFjejUxQpW+d=BGn_b+d_sbr9Untu8iO3dOVvw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Martin Fuzzey <mfuzzey@parkeon.com>, Baruch Siach <baruch@tkos.co.il>, Sascha Hauer <kernel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, 2016-08-10 at 17:54 -0300, Fabio Estevam wrote:
> On Fri, Aug 5, 2016 at 9:03 AM, Christoph Fritz
> <chf.fritz@googlemail.com> wrote:
> 
> > SION is necessary for pinconfig MX6SX_PAD_ENET1_TX_CLK__ENET1_REF_CLK1
> > if bit 17 in IOMUXC_GPR_GPR1 is set and bit 13 not.
> >
> > So that ref_enetpll1 provides a clock not only for the external PHY but
> > also for the internal controller.
> >
> > Using SION is a quirk here, because the silicon doesn't feed the clock
> > back to the internal controller automatically.
> >
> > On the other hand, NXP could argue: You need to add a wire on your PCB
> > between ENET1_REF_CLK1 and ENET1_TX_CLK -- but referring to the
> > datasheet ENET1_TX_CLK isn't used in RMII config...
> >
> > So if Fabio or Shawn agrees with my assumption above, I'll add something
> > like 27e16501052e5341934d3 "serial: imx: implement DSR irq
> > handling for DTE mode".

To correct myself, I'm referring to commit da4fa6fa8016dba54ae "ARM:
imx25-pinfunc: document SION being important for
MX25_PAD_SD1_CMD__SD1_CMD".

> >
> > Okay?
> 
> Could you please post your suggestion as a patch or RFC so that we can
> understand what your proposal is?

Sure, here is my proposal:

---
 arch/arm/boot/dts/imx6sx-pinfunc.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-pinfunc.h b/arch/arm/boot/dts/imx6sx-pinfunc.h
index bb9c6b7..67a3dd7 100644
--- a/arch/arm/boot/dts/imx6sx-pinfunc.h
+++ b/arch/arm/boot/dts/imx6sx-pinfunc.h
@@ -308,6 +308,19 @@
 #define MX6SX_PAD_ENET1_RX_CLK__VDEC_DEBUG_35                     0x008C 0x03D4 0x0000 0x8 0x0
 #define MX6SX_PAD_ENET1_RX_CLK__PCIE_CTRL_DEBUG_29                0x008C 0x03D4 0x0000 0x9 0x0
 #define MX6SX_PAD_ENET1_TX_CLK__ENET1_TX_CLK                      0x0090 0x03D8 0x0000 0x0 0x0
+/*
+ * SION bit is necessary for ENET1_REF_CLK1 (ENET2_REF_CLK2 untested) if it is
+ * used as clock output of IMX6SX_CLK_ENET_REF (ENET1_TX_CLK) to e.g. supply a
+ * PHY in RMII mode. This configuration is true if:
+ *  - bit 1 in field IMX6SX_GPR1_FEC_CLOCK_PAD_DIR_MASK is set
+ *  - bit 1 in field IMX6SX_GPR1_FEC_CLOCK_MUX_SEL_MASK unset
+ * It seems to be a silicon bug that in this configuration ENET1_TX reference
+ * clock isn't provided automatically.  According to i.mx6sx reference manual
+ * (IOMUXC_GPR_GPR1 field descriptions: ENET1_CLK_SEL, Rev. 0 from 2/2015) it
+ * should be the case.
+ * This might have side effects for other hardware units that are connected to
+ * that pin and use the respective function as input (e.g. DSR irq handling).
+ */
 #define MX6SX_PAD_ENET1_TX_CLK__ENET1_REF_CLK1                    0x0090 0x03D8 0x0760 0x1 0x1
 #define MX6SX_PAD_ENET1_TX_CLK__AUDMUX_AUD4_RXD                   0x0090 0x03D8 0x0644 0x2 0x1
 #define MX6SX_PAD_ENET1_TX_CLK__UART1_DTR_B                       0x0090 0x03D8 0x0000 0x3 0x0
--
