From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC] serial: sh-sci: Fix deadlock caused by serial output
 request
Date: Mon, 7 Nov 2016 16:38:24 +0100
Message-ID: <20161107153823.GA9233@verge.net.au>
References: <1478531681-1561-1-git-send-email-horms+renesas@verge.net.au>
 <20161107152618.GB5140@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161107152618.GB5140@katana>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 07, 2016 at 04:26:18PM +0100, Wolfram Sang wrote:
> On Mon, Nov 07, 2016 at 04:14:41PM +0100, Simon Horman wrote:
> > From: Takatoshi Akiyama <takatoshi.akiyama.kj@ps.hitachi-solutions.com>
> > 
> > While spin is already locked, serial output request causes the deadlock,
> > because serial output process also tries to lock the spin.
> > This patch removes serial output with spin locked.
> > 
> > Signed-off-by: Takatoshi Akiyama <takatoshi.akiyama.kj@ps.hitachi-solutions.com>
> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > This is a patch from the Gen3 3.3.2 BSP.
> > Geert, please consider it for mainline.
> > 
> > Two approaches are mixed here: simply removing log messages that would
> > cause a deadlock; and moving log messages to outside the lock. Some
> > consideration was given (by Simon) to a more consistent approach of
> > simply removing all log messages in question. However this was taken as
> > logging ouside of the lock seems consistent with other logging in
> > rx_timer_fn() and sci_dma_rx_complete().
> 
> Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Simon, could you use the 'wsa+renesas' email address in the future? That
> would make things a tad easier for me. Thanks!

Sure, I will try to do that.
