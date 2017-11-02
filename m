From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC] serial: sh-sci: Fix unlocked access to SCSCR register
Date: Thu, 2 Nov 2017 11:10:17 +0100
Message-ID: <20171102101012.ew224ai4zn3kh3ct@verge.net.au>
References: <1478533373-10643-1-git-send-email-horms+renesas@verge.net.au>
 <20161107155209.GC5140@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161107155209.GC5140@katana>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Nov 07, 2016 at 04:52:09PM +0100, Wolfram Sang wrote:
> On Mon, Nov 07, 2016 at 04:42:53PM +0100, Simon Horman wrote:
> > From: Takatoshi Akiyama <takatoshi.akiyama.kj@ps.hitachi-solutions.com>
> > 
> > The SCSCR register access in sci_break_ctl() is not locked.
> > 
> > sci_start_tx() and sci_set_termios() changes the SCSCR register,
> > but does not lock sci_port.
> 
> Maybe naive question: Shouldn't stop_tx and/or (start|stop)_rx be
> protected, too? They change SCSCR as well?

In the case of stop_tx, this is installed as a callback where
the caller takes the lock.

In the case of start_rx, I think the lock should be taken in
sci_rx_dma_release() as other callers already take the lock.

In the case of stop_rx, this is both installed as a callback and
called directly. In both cases the caller takes the lock.

> 
> > Therefore, this patch adds lock during register access.
> > 
> > Also, remove the log output that leads to a double lock.
> > 
> > Signed-off-by: Takatoshi Akiyama <takatoshi.akiyama.kj@ps.hitachi-solutions.com>
> > Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
