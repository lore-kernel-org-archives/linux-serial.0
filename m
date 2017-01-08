From: Fabio Estevam <festevam@gmail.com>
Subject: Re: imx: RS-485 problems during TX, maybe DMA related
Date: Sun, 8 Jan 2017 13:12:13 -0200
Message-ID: <CAOMZO5Cdaob_r3YjhFYGLsmbdKGJiA8uC+5_tndcf+O0VHvH3A@mail.gmail.com>
References: <20170104160024.GA13442@archie.localdomain> <CAOMZO5C3enuThR1DpcwNnqFdxd8tGoBwd76O62Gnviz8x1_a9w@mail.gmail.com>
 <20170106225026.GA3804@archie.localdomain> <CAOMZO5CywajwZEL8K2ATfS80WzqY69YVX+3S7hq9_HmNdNAwaw@mail.gmail.com>
 <20170107134557.GA12299@archie.localdomain> <CAOMZO5ALSQj3C6Yn-avMZdzTvtWCZPQ5+pNdzYi03G-GZB_t+w@mail.gmail.com>
 <20170107153434.GA13307@archie.localdomain> <CAOMZO5CY3ys6moE133LwSKcS4egv56JdmhPMRG0TmAnfD+ZBAw@mail.gmail.com>
 <20170107205930.GA12367@archie.localdomain> <CAOMZO5D00YFLS=pddAqPo_FUoP6MF-juAef2H71-Wx_NQArdpw@mail.gmail.com>
 <20170107230624.GA21729@archie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170107230624.GA21729@archie.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Clemens Gruber <clemens.gruber@pqgruber.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nandor Han <nandor.han@ge.com>, Lucas Stach <l.stach@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Clemens,

On Sat, Jan 7, 2017 at 9:06 PM, Clemens Gruber
<clemens.gruber@pqgruber.com> wrote:

> Just remuxed GPIO signals to these pads, applied your two patches and
> used rts-gpios in the DT but I still see the same problem :/

As you have tested my 'rts-gpios' patches, would it be possible to
reply with your Tested-by tag?

Thanks
