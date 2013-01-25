From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial/8250: Add support for later SUNIX (TIMEDIA)
 boards.
Date: Fri, 25 Jan 2013 08:15:35 -0800
Message-ID: <20130125161535.GA9970@kroah.com>
References: <201301230959.UAA11978@hawk.udefsyd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:34624 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208Ab3AYQPh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Jan 2013 11:15:37 -0500
Received: by mail-pb0-f42.google.com with SMTP id rp2so295502pbb.15
        for <linux-serial@vger.kernel.org>; Fri, 25 Jan 2013 08:15:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201301230959.UAA11978@hawk.udefsyd>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stephen Chivers <schivers@shrike2a.aust.csc.con>
Cc: alan@linux.intel.com, jslaby@suse.cz, linux-serial@vger.kernel.org, schivers@csc.com

On Wed, Jan 23, 2013 at 08:59:32PM +1100, Stephen Chivers wrote:
> Add support for later SUNIX (TIMEDIA) Universal PCI Single and Multi-Port
> Communications Boards.
> 
> These boards have PCI Vendor ID 1fd4 with device ID 1999 but otherwise
> appear to be the same as the TIMEDIA boards already supported by 8250_pci.c
> 
> Tested with the two port serial board part number SER5037A.
> 
> Signed-off-by: Stephen Chivers <schivers@csc.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c |   18 ++++++++++++++++++
>  include/linux/pci_ids.h            |    3 +++
>  2 files changed, 21 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 3b0cc3a..47b3dac 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -1912,6 +1912,17 @@ static struct pci_serial_quirk pci_serial_quirks[] __refdata = {
>  		.setup		= pci_siig_setup,
>  	},
>  	/*
> +	 * SUNIX
> +	 */
> +	{
> +		.vendor		= PCI_VENDOR_ID_SUNIX,
> +		.device		= PCI_DEVICE_ID_SUNIX_1999,
> +		.subvendor	= PCI_VENDOR_ID_SUNIX,
> +		.subdevice	= PCI_ANY_ID,
> +		.init		= pci_timedia_init,
> +		.setup		= pci_timedia_setup,
> +	},
> +	/*
>  	 * Titan cards
>  	 */
>  	{
> @@ -4180,6 +4191,13 @@ static struct pci_device_id serial_pci_tbl[] = {
>  		pbn_b0_bt_1_921600 },
>  
>  	/*
> +	 * SUNIX
> +	 */
> +	{	PCI_VENDOR_ID_SUNIX, PCI_DEVICE_ID_SUNIX_1999,
> +		PCI_VENDOR_ID_SUNIX, PCI_ANY_ID, 0, 0,
> +		pbn_b0_bt_1_921600 },
> +
> +	/*
>  	 * AFAVLAB serial card, from Harald Welte <laforge@gnumonks.org>
>  	 */
>  	{	PCI_VENDOR_ID_AFAVLAB, PCI_DEVICE_ID_AFAVLAB_P028,
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 19e8d7a..473b0eb 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2466,6 +2466,9 @@
>  #define PCI_DEVICE_ID_TEHUTI_3010	0x3010
>  #define PCI_DEVICE_ID_TEHUTI_3014	0x3014
>  
> +#define PCI_VENDOR_ID_SUNIX		0x1fd4
> +#define PCI_DEVICE_ID_SUNIX_1999	0x1999

Please read the top of this file about how you shouldn't be adding new
devices to it that are only referenced in one kernel file.

Please fix this up and resend.

thanks,

greg k-h
