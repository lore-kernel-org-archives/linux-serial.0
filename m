From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: serial: imx: regression triggered by newly introduced DSR irq
 handling
Date: Fri, 5 Aug 2016 08:58:45 +0200
Message-ID: <20160805065845.GI17874@pengutronix.de>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1458825865-7434-7-git-send-email-u.kleine-koenig@pengutronix.de>
 <1470350663.26773.41.camel@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1470350663.26773.41.camel@googlemail.com>
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
Cc: Martin Fuzzey <mfuzzey@parkeon.com>, Baruch Siach <baruch@tkos.co.il>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hello Christoph,

Cc +=3D Shawn, Fabio

On Fri, Aug 05, 2016 at 12:44:23AM +0200, Christoph Fritz wrote:
> here on a imx6sx board newly introduced DSR-irq-handling breaks serial
> console and network support.
> =

> Reverting commit 27e16501052e5341934d3 "serial: imx: implement DSR irq
> handling for DTE mode" fixes the issue.
> =

> The underlying cause is the RMII network configuration where register
> bit SION in IOMUXC_SW_MUX_CTL_PAD_ENET1_TX_CLK is necessary. But this
> also falsely feeds signal UART1_DTR_B and triggers DSR irq...
> =

> Can we revert this commit or add a quirk for RMII-SION configs or make
> this optional by a device tree option?

Hmm, MX6SX_PAD_ENET1_TX_CLK__ENET1_TX_CLK in
arch/arm/boot/dts/imx6sx-pinfunc.h doesn't have SION set.

I remember there were issues around eth and SION on i.MX6DL, but don't
know the details. A quick net research found
https://community.nxp.com/thread/359531 which has: "Set the SION bit.
Note that this is not required because the funtion setting controls the
signal path, but it is good practice as it reminds the user that the
clock needs to fed back into the Ethernet MAC.". Sounds like dangerous
smattering and a wrong expectation about "users".

https://community.nxp.com/thread/376821 is from someone who has the same
problem(?) on i.MX6SX, but no solution yet.

Does that mean MX6SX_PAD_ENET1_TX_CLK__ENET1_TX_CLK always needs the
SION bit set? Even if not, I'd like to have that documented there,
similar to da4fa6fa8016 ("ARM: imx25-pinfunc: document SION being
important for MX25_PAD_SD1_CMD__SD1_CMD").

Once this is done (and still an issue) I'd suggest to standardize a dt
property

	disable-dsr;

(and the same for the other handshaking lines) and support th{is,ese} in
the imx uart driver. Reverting 27e16501052e IMO isn't a sensible option.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
