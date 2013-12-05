From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 10/17] serial: mpc512x: setup the PSC FIFO clock as
 well
Date: Wed, 4 Dec 2013 16:55:21 -0800
Message-ID: <20131205005521.GA21377@kroah.com>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-11-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:37394 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933433Ab3LECwq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Dec 2013 21:52:46 -0500
Content-Disposition: inline
In-Reply-To: <1385851897-23475-11-git-send-email-gsi@denx.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Gerhard Sittig <gsi@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>, Scott Wood <scottwood@freescale.com>, Detlev Zundel <dzu@denx.de>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org

On Sat, Nov 30, 2013 at 11:51:30PM +0100, Gerhard Sittig wrote:
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

That's fine, my ACK still stands.

thanks,

greg k-h
