From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v6 09/17] serial: mpc512x: adjust for OF based clock
 lookup
Date: Sat, 7 Dec 2013 10:49:17 +0100
Message-ID: <20131207104917.50f2e4e5@crub>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
	<1385851897-23475-10-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:41196 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758Ab3LGJtT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 7 Dec 2013 04:49:19 -0500
In-Reply-To: <1385851897-23475-10-git-send-email-gsi@denx.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Gerhard Sittig <gsi@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

On Sat, 30 Nov 2013 23:51:29 +0100
Gerhard Sittig <gsi@denx.de> wrote:

> after device tree based clock lookup became available, the peripheral
> driver need no longer construct clock names which include the PSC index,
> remove the "psc%d_mclk" template and unconditionally use 'mclk'
> 
> acquire and release the "ipg" clock item for register access as well
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: linux-serial@vger.kernel.org
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org> # for v4
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
> Greg, the difference since v4 of this patch is that v4 took the 'mclk'
> and 'ipg' clock items in reverse order, and thus potentially obfuscated
> the adjusted name for 'mclk' -- the updated version of the patch is
> identical in content but cleaner diff-wise
> 
> ---
>  drivers/tty/serial/mpc52xx_uart.c |   40 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 5 deletions(-)

applied to next. Thanks!

Anatolij
