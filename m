From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/3] tty: rocket: Explicitly list supported PCI IDs
Date: Tue, 15 Jan 2013 21:26:35 -0800
Message-ID: <20130116052635.GA15131@kroah.com>
References: <bd10fdeead3e321db2bb291c0b722203@localhost>
 <8e99cbf1f2bdfacaeaf0a5ac99d99309@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:34216 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748Ab3APFZg (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 00:25:36 -0500
Content-Disposition: inline
In-Reply-To: <8e99cbf1f2bdfacaeaf0a5ac99d99309@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: alan@linux.intel.com, jslaby@suse.cz, linux-serial@vger.kernel.org, dwmw2@infradead.org, ben@decadent.org.uk

On Sat, Dec 29, 2012 at 11:23:23PM -0800, Kevin Cernekee wrote:
> Matching PCI_ANY_ID causes conflicts with RocketPort 2 adapters, which
> are supported by a different driver.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  drivers/tty/rocket.c |   31 ++++++++++++++++++++++++++++---
>  1 file changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/rocket.c b/drivers/tty/rocket.c
> index e42009a..c73ca4e 100644
> --- a/drivers/tty/rocket.c
> +++ b/drivers/tty/rocket.c
> @@ -1758,8 +1758,32 @@ static void rp_flush_buffer(struct tty_struct *tty)
>  
>  #ifdef CONFIG_PCI
>  
> -static struct pci_device_id __used rocket_pci_ids[] = {
> -	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_ANY_ID) },
> +#define RP_PCI_DEVICE(id) \
> +	{ PCI_DEVICE(PCI_VENDOR_ID_RP, PCI_DEVICE_ID_##id) }
> +
> +static DEFINE_PCI_DEVICE_TABLE(rocket_pci_ids) = {
> +	RP_PCI_DEVICE(RP4QUAD),

Ick, no, please just use the PCI_DEVICE() macro and don't define a new
one that makes it hard to grep for things.  It's not that hard to just
list them all properly.

thanks,

greg k-h
