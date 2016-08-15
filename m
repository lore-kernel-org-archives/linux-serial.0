From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: serial: imx: regression triggered by newly introduced DSR irq
 handling
Date: Mon, 15 Aug 2016 07:22:44 +0200
Message-ID: <20160815052244.mwygjlo72e46w353@pengutronix.de>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1458825865-7434-7-git-send-email-u.kleine-koenig@pengutronix.de>
 <1470350663.26773.41.camel@googlemail.com>
 <20160805065845.GI17874@pengutronix.de>
 <1470398615.1936.22.camel@googlemail.com>
 <CAOMZO5BQQemrKFjejUxQpW+d=BGn_b+d_sbr9Untu8iO3dOVvw@mail.gmail.com>
 <1471120532.1923.4.camel@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1471120532.1923.4.camel@googlemail.com>
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
Cc: Martin Fuzzey <mfuzzey@parkeon.com>, Baruch Siach <baruch@tkos.co.il>, kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hello Christoph,

On Sat, Aug 13, 2016 at 10:35:32PM +0200, Christoph Fritz wrote:
> On Wed, 2016-08-10 at 17:54 -0300, Fabio Estevam wrote:
> > Could you please post your suggestion as a patch or RFC so that we can
> > understand what your proposal is?
> =

> Sure, here is my proposal:

I like it, just a few minor nits below.

> +/*
> + * SION bit is necessary for ENET1_REF_CLK1 (ENET2_REF_CLK2 untested) if=
 it is
> + * used as clock output of IMX6SX_CLK_ENET_REF (ENET1_TX_CLK) to e.g. su=
pply a
> + * PHY in RMII mode. This configuration is true if:

Sounds a bit strage to me. Maybe s/true/necessary/? Or "valid"?

> + *  - bit 1 in field IMX6SX_GPR1_FEC_CLOCK_PAD_DIR_MASK is set
> + *  - bit 1 in field IMX6SX_GPR1_FEC_CLOCK_MUX_SEL_MASK unset
> + * It seems to be a silicon bug that in this configuration ENET1_TX refe=
rence
> + * clock isn't provided automatically.  According to i.mx6sx reference m=
anual

s/i.mx6sx/i.MX6SX/

> + * (IOMUXC_GPR_GPR1 field descriptions: ENET1_CLK_SEL, Rev. 0 from 2/201=
5) it
> + * should be the case.
> + * This might have side effects for other hardware units that are connec=
ted to
> + * that pin and use the respective function as input (e.g. DSR irq handl=
ing).

s/DSR irq/UART1's DTR/. Then it's more obvious to relate to
MX6SX_PAD_ENET1_TX_CLK__UART1_DTR_B.

> + */
>  #define MX6SX_PAD_ENET1_TX_CLK__ENET1_REF_CLK1                    0x0090=
 0x03D8 0x0760 0x1 0x1
>  #define MX6SX_PAD_ENET1_TX_CLK__AUDMUX_AUD4_RXD                   0x0090=
 0x03D8 0x0644 0x2 0x1
>  #define MX6SX_PAD_ENET1_TX_CLK__UART1_DTR_B                       0x0090=
 0x03D8 0x0000 0x3 0x0

Thanks
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
