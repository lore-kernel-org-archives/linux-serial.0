From: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v6 10/17] serial: mpc512x: setup the PSC FIFO clock as
 well
Date: Sat, 7 Dec 2013 10:51:28 +0100
Message-ID: <20131207105128.68d1f2ba@crub>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
	<1385851897-23475-11-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:38959 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393Ab3LGJva (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 7 Dec 2013 04:51:30 -0500
In-Reply-To: <1385851897-23475-11-git-send-email-gsi@denx.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Gerhard Sittig <gsi@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

On Sat, 30 Nov 2013 23:51:30 +0100
Gerhard Sittig <gsi@denx.de> wrote:

> prepare and enable the FIFO clock upon PSC FIFO initialization,
> check for and propagage errors when enabling the PSC FIFO clock,
> disable and unprepare the FIFO clock upon PSC FIFO uninitialization
> 
> devm_{get,put}_clk() doesn't apply here, as the SoC provides a
> single FIFO component which is shared among several PSC components,
> thus the FIFO isn't associated with a device (while the PSCs are)
> 
> provide a fallback clock lookup approach in case the OF based clock
> lookup for the PSC FIFO fails, this allows for successful operation in
> the presence of an outdated device tree which lacks clock specs
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: linux-serial@vger.kernel.org
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org> # for v4
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
> Greg, the addition since v4 is the clk_get_sys() call for the 'ipg'
> clock item (backwards compat for device trees w/o clock specs)
> 
> ---
>  drivers/tty/serial/mpc52xx_uart.c |   50 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 44 insertions(+), 6 deletions(-)

applied to next. Thanks!

Anatolij
