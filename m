From: Greg KH <gregkh@suse.de>
Subject: Re: uart ops tx_empty lock
Date: Sat, 12 Feb 2011 08:11:04 -0800
Message-ID: <20110212161104.GA26545@suse.de>
References: <AANLkTimpEcfmJ5SF_YpG1mE0eBiARQ7L17Pd+ay_OQoV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:37385 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956Ab1BLQOS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 12 Feb 2011 11:14:18 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimpEcfmJ5SF_YpG1mE0eBiARQ7L17Pd+ay_OQoV@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Richard Zhao <linuxzsc@gmail.com>
Cc: linux-serial@vger.kernel.org

On Sat, Feb 12, 2011 at 09:16:45PM +0800, Richard Zhao wrote:
> Hi Greg,
> 
> Does uart_ops.tx_empty need to hold port->lock?
> I find some drivers hold the lock in tx_empty hook, for example 8250.
> But many more drivers don't hold it, for example imx.c, sh-sci.c.

I do not know, Alan would know best about this.

Alan?

thanks,

greg k-h
