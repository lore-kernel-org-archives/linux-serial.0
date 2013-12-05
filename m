From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 09/17] serial: mpc512x: adjust for OF based clock
 lookup
Date: Wed, 4 Dec 2013 16:55:53 -0800
Message-ID: <20131205005553.GC21377@kroah.com>
References: <1385851897-23475-1-git-send-email-gsi@denx.de>
 <1385851897-23475-10-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:37414 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933434Ab3LECws (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 4 Dec 2013 21:52:48 -0500
Content-Disposition: inline
In-Reply-To: <1385851897-23475-10-git-send-email-gsi@denx.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Gerhard Sittig <gsi@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Anatolij Gustschin <agust@denx.de>, Mike Turquette <mturquette@linaro.org>, Scott Wood <scottwood@freescale.com>, Detlev Zundel <dzu@denx.de>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org

On Sat, Nov 30, 2013 at 11:51:29PM +0100, Gerhard Sittig wrote:
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

That's fine:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
