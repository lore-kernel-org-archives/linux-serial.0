From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] 8250_pci Add EEH support to the 8250 driver for
 IBM/Digi PCIe 2-port Adapter
Date: Thu, 19 May 2011 16:49:18 -0700
Message-ID: <20110519234918.GB25169@kroah.com>
References: <mreed@linux.vnet.ibm.com>
 <1305831823-25400-2-git-send-email-mreed@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39630 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934202Ab1ESXu1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 19 May 2011 19:50:27 -0400
Content-Disposition: inline
In-Reply-To: <1305831823-25400-2-git-send-email-mreed@linux.vnet.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Michael Reed <mreed@linux.vnet.ibm.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Breno Leitao <leitao@linux.vnet.ibm.com>, Scott Kilau <scottk@digi.com>

On Thu, May 19, 2011 at 02:03:43PM -0500, Michael Reed wrote:
> When working on the 8250_pci driver on PPC, the rmmod command was resulting in a crash when removing the module.  The serial8250_do_pm() is called after the memory are deallocated, meaning that serial8250_set_sleep->serial_outp() will try to write to a
> position that is invalid, crashing the system. The purpose of  this patch is to correct that issue.
> This patch was created against  2.6.38.6
> 
> Patch-created-by:  Breno Leitao <leitao@linux.vnet.ibm.com>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Breno Leitao <leitao@linux.vnet.ibm.com>
> Cc: Scott Kilau <scottk@digi.com>
> Signed-off-by:   Michael Reed <mreed@linux.vnet.ibm.com>
> ---
>  drivers/tty/serial/8250.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
> index b3b881b..7617cde 100644
> --- a/drivers/tty/serial/8250.c
> +++ b/drivers/tty/serial/8250.c
> @@ -145,6 +145,8 @@ struct uart_8250_port {
>  	unsigned char		mcr_mask;	/* mask of user bits */
>  	unsigned char		mcr_force;	/* mask of forced bits */
>  	unsigned char		cur_iotype;	/* Running I/O type */
> +#define SERIAL8250_DYING 1
> +	unsigned char		status;

Ick, is this really necessary?

A bitfield would be best, only if that is the absolute last way to do
this (and I really think it isn't...)

thanks,

greg k-h
