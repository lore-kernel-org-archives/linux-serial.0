From: Yin Kangkai <kangkai.yin@linux.intel.com>
Subject: Re: [PATCH] serial-core: power up uart port early before we do
 set_termios when resuming
Date: Mon, 5 Sep 2011 22:03:50 +0800
Message-ID: <20110905140350.GE6307@kai-debian>
References: <1315211298-17318-1-git-send-email-ning.jiang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:62951 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752287Ab1IEODw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 5 Sep 2011 10:03:52 -0400
Content-Disposition: inline
In-Reply-To: <1315211298-17318-1-git-send-email-ning.jiang@marvell.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ning Jiang <ning.jiang@marvell.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, Yin Kangkai <kangkai.yin@linux.intel.com>, linux-serial@vger.kernel.org

On 2011-09-05, 16:28 +0800, Ning Jiang wrote:
>  			termios = *(port->tty->termios);
>  
> +		if (console_suspend_enabled)
> +			uart_change_pm(state, 0);
>  		uport->ops->set_termios(uport, &termios, NULL);

Good catch, thanks. What I was thinking...

Kangkai
