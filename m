From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [PATCH] serial: imx: Revert "initialized DMA w/o HW flow enabled"
Date: Thu, 7 May 2015 23:16:57 +0200
Message-ID: <20150507211657.GA30982@breakpoint.cc>
References: <20150507202439.GA4717@breakpoint.cc>
 <CAOMZO5B1AKN8QXA5dhU7YoCGu2MXVXRq+mT2HXohv_wKXm-6-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5B1AKN8QXA5dhU7YoCGu2MXVXRq+mT2HXohv_wKXm-6-A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, jiwang <jiada_wang@mentor.com>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, anton_bondarenko@mentor.com, Dirk Behme <dirk.behme@de.bosch.com>, Nicolae Rosia <nicolae.rosia@gmail.com>, Fabio Estevam <fabio.estevam@freescale.com>
List-Id: linux-serial@vger.kernel.org

On 2015-05-07 17:54:31 [-0300], Fabio Estevam wrote:
> Thanks, this fixes Bluetooth operation on a imx6sl-warp running
> without SDMA firmware.
> 
> Two suggestions:
> 
> 1. You should Cc stable as it affects 4.0 also

I have the Fixes tag, doesn't this count?

> 2. It doesn't apply cleanly against linux-next, so I think Greg will
> have problems applying it.

It is on top of Greg's tty-next tree. Shouldn't this work?

Sebastian
