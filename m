From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 1/2] 8250_pci Add EEH support to the 8250 driver for
 IBM/Digi PCIe 2-port Adapter
Date: Thu, 19 May 2011 16:48:13 -0700
Message-ID: <20110519234813.GA25169@kroah.com>
References: <mreed@linux.vnet.ibm.com>
 <1305831823-25400-1-git-send-email-mreed@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:50975 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934202Ab1ESXu0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 19 May 2011 19:50:26 -0400
Content-Disposition: inline
In-Reply-To: <1305831823-25400-1-git-send-email-mreed@linux.vnet.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Michael Reed <mreed@linux.vnet.ibm.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Breno Leitao <leitao@linux.vnet.ibm.com>, Scott Kilau <scottk@digi.com>

On Thu, May 19, 2011 at 02:03:42PM -0500, Michael Reed wrote:
> The purpose of the patch is to add EEH support to the 8250_PCI driver for the IBM/Digi PCIE 2port Async EIA-232 Adapter that uses a PLX chipset on the PPC platforrm.  Basic support for this adapter was recently added https://lkml.org/lkml/2011/5/11/341

You don't linewrap your comments :(

Also, both of these patches have the identical Subject: lines, when that
really isn't true.

> This patch was created against  2.6.38.6

Can you please make it against 2.6.39 so it has a chance of applying?
Ideally you would create it against the linux-next tree.

> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Cc: Breno Leitao <leitao@linux.vnet.ibm.com>
> Cc: Scott Kilau <scottk@digi.com>
> Signed-off-by:   Michael Reed <mreed@linux.vnet.ibm.com>

What's with the extra whitespace before your name?


> ---
>  drivers/tty/serial/8250_pci.c |   47 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 47 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250_pci.c b/drivers/tty/serial/8250_pci.c
> index 8b8930f..ef193a9 100644
> --- a/drivers/tty/serial/8250_pci.c
> +++ b/drivers/tty/serial/8250_pci.c
> @@ -2562,6 +2562,7 @@ pciserial_init_one(struct pci_dev *dev, const struct pci_device_id *ent)
>  	board = &pci_boards[ent->driver_data];
>  
>  	rc = pci_enable_device(dev);
> +	pci_save_state(dev);
>  	if (rc)
>  		return rc;
>  
> @@ -3821,6 +3822,51 @@ static struct pci_device_id serial_pci_tbl[] = {
>  	{ 0, }
>  };
>  
> +static pci_ers_result_t serial8250_io_error_detected(struct pci_dev *dev,
> +pci_channel_state_t state)

Wierd linewrap.

> +{
> +	struct serial_private *priv = pci_get_drvdata(dev);
> +
> +	if (state == pci_channel_io_perm_failure)
> +		return PCI_ERS_RESULT_DISCONNECT;
> +
> +	if (priv)
> +		pciserial_suspend_ports(priv);
> +
> +	pci_disable_device(dev);
> +
> +	return PCI_ERS_RESULT_NEED_RESET;
> +}
> +
> +static pci_ers_result_t serial8250_io_slot_reset(struct pci_dev *dev)
> +{
> +	int rc;
> +
> +	rc = pci_enable_device(dev);
> +
> +	if (rc)
> +		return PCI_ERS_RESULT_DISCONNECT;
> +
> +	pci_restore_state(dev);
> +	pci_save_state(dev);
> +
> +	return PCI_ERS_RESULT_RECOVERED;
> +}
> +
> +static void serial8250_io_resume(struct pci_dev *dev)
> +{
> +	struct serial_private *priv = pci_get_drvdata(dev);
> +
> +	if (priv)
> +		pciserial_resume_ports(priv);
> +}
> +
> +static struct pci_error_handlers serial8250_err_handler = {
> +	.error_detected = serial8250_io_error_detected,
> +	.slot_reset = serial8250_io_slot_reset,
> +	.resume = serial8250_io_resume,
> +};
> +
>  static struct pci_driver serial_pci_driver = {
>  	.name		= "serial",
>  	.probe		= pciserial_init_one,
> @@ -3830,6 +3876,7 @@ static struct pci_driver serial_pci_driver = {
>  	.resume		= pciserial_resume_one,
>  #endif
>  	.id_table	= serial_pci_tbl,
> +	.err_handler = &serial8250_err_handler,

Please keep the alignment sane.

Care to try again?

thanks,

greg k-h
