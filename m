From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] serial: 8250_pci: add support for Cronyx Omega PCI
 multiserial board.
Date: Tue, 17 May 2011 11:22:36 -0700
Message-ID: <20110517182236.GA17682@kroah.com>
References: <1305347972-19321-1-git-send-email-antony@niisi.msk.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:49550 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756065Ab1EQSYE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 May 2011 14:24:04 -0400
Content-Disposition: inline
In-Reply-To: <1305347972-19321-1-git-send-email-antony@niisi.msk.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Antony Pavlov <antony@niisi.msk.ru>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

On Sat, May 14, 2011 at 08:39:32AM +0400, Antony Pavlov wrote:
> This patch adds support for the Omega-PCI, an 8-port asynchronous
> multiport adapter for computers with PCI bus [1].
> 
> [1] http://www.cronyx.ru/hardware/ompci.html
> 
> Signed-off-by: Antony Pavlov <antony@niisi.msk.ru>
> ---
>  drivers/tty/serial/8250_pci.c |   32 ++++++++++++++++++++++++++++++++

What tree did you make this against?  It doesn't apply to my tty-next
tree that shows up in the linux-next releases.

Care to refresh it and resend it?

thanks,

greg k-h
