From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Oxford Semiconductor's OXCB950 in 8250_pci.c
Date: Wed, 10 May 2006 17:36:32 +0100
Message-ID: <20060510163632.GE32632@flint.arm.linux.org.uk>
References: <20060507225942.0b2d7bbf@mike.staff.sky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:787 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965008AbWEJQgk (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 10 May 2006 12:36:40 -0400
Content-Disposition: inline
In-Reply-To: <20060507225942.0b2d7bbf@mike.staff.sky>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Mikhail Kolesnik <mike@openbunker.org>
Cc: linux-serial@vger.kernel.org

On Sun, May 07, 2006 at 10:59:42PM +0300, Mikhail Kolesnik wrote:
> There was a discussion regarding support of OXCB950 in 2.4.x
> http://groups.google.com/group/mlist.linux.serial/browse_frm/thread/baf6d48e25662c5/8ab3b1ea12a43420?tvc=1&q=OXCB950#8ab3b1ea12a43420
> Somehow changes did not go into the kernel.

Probably because the 8250_pci split happened prior to this discussion
and it therefore got missed.

> diff -ru linux-2.6.16-orig/drivers/serial/8250_pci.c linux-2.6.16/drivers/serial/8250_pci.c
> --- linux-2.6.16-orig/drivers/serial/8250_pci.c	2006-03-23 13:32:17.000000000 +0200
> +++ linux-2.6.16/drivers/serial/8250_pci.c	2006-03-23 13:39:08.000000000 +0200
> @@ -2045,6 +2045,9 @@
>  	{	PCI_VENDOR_ID_OXSEMI, 0x950a,
>  		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  		pbn_b0_2_1130000 },
> +	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_CB950,
> +		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +		pbn_b0_bt_1_115200 },

This should probably be pbn_b0_1_115200?

>  	{	PCI_VENDOR_ID_OXSEMI, PCI_DEVICE_ID_OXSEMI_16PCI954,
>  		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  		pbn_b0_4_115200 },
> diff -ru linux-2.6.16-orig/include/linux/pci_ids.h linux-2.6.16/include/linux/pci_ids.h
> --- linux-2.6.16-orig/include/linux/pci_ids.h	2006-03-23 13:32:24.000000000 +0200
> +++ linux-2.6.16/include/linux/pci_ids.h	2006-03-23 13:40:32.000000000 +0200
> @@ -1808,6 +1808,7 @@
>  #define PCI_VENDOR_ID_OXSEMI		0x1415
>  #define PCI_DEVICE_ID_OXSEMI_12PCI840	0x8403
>  #define PCI_DEVICE_ID_OXSEMI_16PCI954	0x9501
> +#define PCI_DEVICE_ID_OXSEMI_CB950      0x950B /* OXCB950 Cardbus 16950 UART */
>  #define PCI_DEVICE_ID_OXSEMI_16PCI95N	0x9511
>  #define PCI_DEVICE_ID_OXSEMI_16PCI954PP	0x9513
>  #define PCI_DEVICE_ID_OXSEMI_16PCI952	0x9521
> 
> Is it enough for such card to work?

That should be all that's required.

> The problem is that card only works with baud rates from 50 to 2400.
> The card is connected to a common external modem, which is known to
> work with any reasonable rates in other PC.

Odd.  Maybe the port isn't clocked at the usual frequency, and 115200
is the wrong base.

> 'User Manual' supplied with the card says that I should use
> 'Automatic Crystal Detection' in WinME and '1.8432 MHz' in 2K/XP.

Well, 1.8432MHz corresponds with a base of 115200, so that's not wrong.
IS your modem showing the DTE speed in that connect line?  If so, 2400
baud seems to actually correspond with 230400 baud, which would be a
rather interesting state of affairs.  What does setserial -bav /dev/ttyS4
say?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
