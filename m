From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2] serial: imx: enable the clocks for console
Date: Mon, 10 Jun 2013 08:55:07 +0800
Message-ID: <20130610005506.GB6381@S2101-09.ap.freescale.net>
References: <CAOMZO5A4SPFv1NopdGrN9nX-XSpZy5Cw1CLp3E95mRP8O=rhLQ@mail.gmail.com>
 <1370743279-15941-1-git-send-email-b32955@freescale.com>
 <20130609083409.GA32485@S2101-09.ap.freescale.net>
 <20130609130544.GC20780@S2101-09.ap.freescale.net>
 <20130609172628.GA17829@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from am1ehsobe006.messaging.microsoft.com ([213.199.154.209]:44039
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752500Ab3FJAz6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 9 Jun 2013 20:55:58 -0400
Content-Disposition: inline
In-Reply-To: <20130609172628.GA17829@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Huang Shijie <b32955@freescale.com>, shc_work@mail.ru, festevam@gmail.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sun, Jun 09, 2013 at 10:26:28AM -0700, Greg KH wrote:
> On Sun, Jun 09, 2013 at 09:05:47PM +0800, Shawn Guo wrote:
> > On Sun, Jun 09, 2013 at 04:34:11PM +0800, Shawn Guo wrote:
> > > On Sun, Jun 09, 2013 at 10:01:19AM +0800, Huang Shijie wrote:
> > > > The console's clocks are disabled after the uart driver is probed.
> > > > It makes that we can see less log from the console now
> > > > (though we still can get all the log by the `dmesg`).
> > > > 
> > > > So enable the clocks for console, and we can see all the log again.
> > > > 
> > > > This patch also disables the sport->clk_per when we fail to enable
> > > > the sport->clk_ipg;
> > > > 
> > > > Signed-off-by: Huang Shijie <b32955@freescale.com>
> > > 
> > > Tested-by: Shawn Guo <shawn.guo@linaro.org>
> > 
> > Sorry.  I have to take that back.
> > 
> > Though it works fine with BusyBox, I'm getting the following warnings
> > when booting with an Ubuntu 13.04 rootfs, in which case imx_startup()
> > and imx_shutdown() will be called for a number of iterations.  That
> > causes unbalanced clk_prepare_enable vs. clk_disable_unprepare, since
> > the clk_prepare_enable is under condition if (!uart_console(port)) in
> > imx_startup(), while clk_disable_unprepare in imx_shutdown() is not.
> 
> I had just applied this to my tree, should I revert it because of this
> problem?

Fabio just sent an incremental fix "serial: imx: Fix serial clock
unbalance" for that.

Shawn

