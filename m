From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: Re: imx: RS-485 problems during TX, maybe DMA related
Date: Sat, 7 Jan 2017 16:34:34 +0100
Message-ID: <20170107153434.GA13307@archie.localdomain>
References: <20170104160024.GA13442@archie.localdomain>
 <CAOMZO5C3enuThR1DpcwNnqFdxd8tGoBwd76O62Gnviz8x1_a9w@mail.gmail.com>
 <20170106225026.GA3804@archie.localdomain>
 <CAOMZO5CywajwZEL8K2ATfS80WzqY69YVX+3S7hq9_HmNdNAwaw@mail.gmail.com>
 <20170107134557.GA12299@archie.localdomain>
 <CAOMZO5ALSQj3C6Yn-avMZdzTvtWCZPQ5+pNdzYi03G-GZB_t+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5ALSQj3C6Yn-avMZdzTvtWCZPQ5+pNdzYi03G-GZB_t+w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Nandor Han <nandor.han@ge.com>, Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Fabio,

On Sat, Jan 07, 2017 at 12:57:10PM -0200, Fabio Estevam wrote:
> The MX6QDL_PAD_CSI0_DAT16__UART4_CTS_B option is only valid in dte mode.

Ah, the input select is limited in that way, I see.

You wrote that you tried rts-gpios.
What about setting cts-gpios to gpio6 2 in the DT?

Or can you remux RX and TX to be switched to work in dte mode?

Regards,
Clemens
