From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] serial: pxa: fix clk_prepare/unprepare misuse
Date: Tue, 22 Jan 2013 09:28:02 -0800
Message-ID: <20130122172802.GA13230@kroah.com>
References: <1358825090-17577-1-git-send-email-yizhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41255 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752750Ab3AVR2F (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Jan 2013 12:28:05 -0500
Content-Disposition: inline
In-Reply-To: <1358825090-17577-1-git-send-email-yizhang@marvell.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Yi Zhang <yizhang@marvell.com>
Cc: alan@linux.intel.com, yizhang.mrvl@gmail.com, linux-serial@vger.kernel.org

On Tue, Jan 22, 2013 at 11:24:50AM +0800, Yi Zhang wrote:
> 1) serial_pxa_console_write() can be used in atomic context,
>    so change clk_prepare_clk to clk_enable
> 2) add clk_prepare() to follow common clock driver
> 
> Signed-off-by: Yi Zhang <yizhang@marvell.com>
> ---
>  drivers/tty/serial/pxa.c |   13 +++++++++++--
>  1 files changed, 11 insertions(+), 2 deletions(-)

This patch fails to apply to my tree:
patching file drivers/tty/serial/pxa.c
Hunk #1 FAILED at 673.
Hunk #2 FAILED at 702.
Hunk #3 succeeded at 896 (offset -3 lines).
Hunk #4 succeeded at 933 (offset -3 lines).
Hunk #5 succeeded at 947 (offset -3 lines).
2 out of 5 hunks FAILED -- saving rejects to file drivers/tty/serial/pxa.c.rej

Please redo it against the tty-next git tree and resend.

thanks,

greg k-h
