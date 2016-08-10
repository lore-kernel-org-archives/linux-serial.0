From: Fabio Estevam <festevam@gmail.com>
Subject: Re: serial: imx: regression triggered by newly introduced DSR irq
 handling
Date: Wed, 10 Aug 2016 17:54:32 -0300
Message-ID: <CAOMZO5BQQemrKFjejUxQpW+d=BGn_b+d_sbr9Untu8iO3dOVvw@mail.gmail.com>
References: <1458825865-7434-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1458825865-7434-7-git-send-email-u.kleine-koenig@pengutronix.de>
 <1470350663.26773.41.camel@googlemail.com>
 <20160805065845.GI17874@pengutronix.de>
 <1470398615.1936.22.camel@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1470398615.1936.22.camel@googlemail.com>
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

On Fri, Aug 5, 2016 at 9:03 AM, Christoph Fritz
<chf.fritz@googlemail.com> wrote:

> SION is necessary for pinconfig MX6SX_PAD_ENET1_TX_CLK__ENET1_REF_CLK1
> if bit 17 in IOMUXC_GPR_GPR1 is set and bit 13 not.
>
> So that ref_enetpll1 provides a clock not only for the external PHY but
> also for the internal controller.
>
> Using SION is a quirk here, because the silicon doesn't feed the clock
> back to the internal controller automatically.
>
> On the other hand, NXP could argue: You need to add a wire on your PCB
> between ENET1_REF_CLK1 and ENET1_TX_CLK -- but referring to the
> datasheet ENET1_TX_CLK isn't used in RMII config...
>
> So if Fabio or Shawn agrees with my assumption above, I'll add something
> like 27e16501052e5341934d3 "serial: imx: implement DSR irq
> handling for DTE mode".
>
> Okay?

Could you please post your suggestion as a patch or RFC so that we can
understand what your proposal is?

Thanks
