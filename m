From: Fabio Estevam <festevam@gmail.com>
Subject: Re: imx: RS-485 problems during TX, maybe DMA related
Date: Sat, 7 Jan 2017 12:57:10 -0200
Message-ID: <CAOMZO5ALSQj3C6Yn-avMZdzTvtWCZPQ5+pNdzYi03G-GZB_t+w@mail.gmail.com>
References: <20170104160024.GA13442@archie.localdomain> <CAOMZO5C3enuThR1DpcwNnqFdxd8tGoBwd76O62Gnviz8x1_a9w@mail.gmail.com>
 <20170106225026.GA3804@archie.localdomain> <CAOMZO5CywajwZEL8K2ATfS80WzqY69YVX+3S7hq9_HmNdNAwaw@mail.gmail.com>
 <20170107134557.GA12299@archie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170107134557.GA12299@archie.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nandor Han <nandor.han@ge.com>, Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Clemens,

On Sat, Jan 7, 2017 at 11:45 AM, Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:

> It should work like this, I don't think using an extra GPIO is
> necessary.

The MX6QDL_PAD_CSI0_DAT16__UART4_CTS_B option is only valid in dte mode.

If I pass 'fsl,dte-mode' then I can see this pin toggling. (rx, tx
would not work as expected).

In the default dce mode I can see UART4_CTS_B pin toggling when I
monitor CSI0_DAT17 pin and configure it as:

MX6QDL_PAD_CSI0_DAT17__UART4_CTS_B

,but unfortunately this pin does not go to the TXEN pin of the RS485
transceiver.

So this means that with the hardware I have access to my only
alternative is to set MX6QDL_PAD_CSI0_DAT16__GPIO6_IO02.

>> So I was never able to observe the DE pin toggling correctly.
>
> But did you set SER_RS485_RX_DURING_TX in your flags? This is counter
> intuitive, but I observed that it would not work otherwise.

Yes, I have also tried when I read your email, but did not help on my case.

Thanks,

Fabio Estevam
