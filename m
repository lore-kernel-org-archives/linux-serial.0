From: Greg KH <greg@kroah.com>
Subject: Re: OXuPCI952 and baud_base questions
Date: Wed, 1 Dec 2010 14:16:04 -0800
Message-ID: <20101201221604.GA22114@kroah.com>
References: <20101201164634.GA5773@horus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:46962 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756190Ab0LAWTp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Dec 2010 17:19:45 -0500
Content-Disposition: inline
In-Reply-To: <20101201164634.GA5773@horus.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthias Reichl <hias@horus.com>, Linux Kernel <linux-serial@vger.kernel.org>

On Wed, Dec 01, 2010 at 05:46:34PM +0100, Matthias Reichl wrote:
> I've got a Lindy 51237 multi I/O card (2 16C950 URATs up to 921kbit
> plus one parallel port) with a Oxford OXuPCI952 chip (PCI vendor
> ID 0x1415, device ID 0x9505).
> 
> http://www.lindy-international.com/2-port-rs-232-serial-1-port-parallel-card-pci/51237.html
> http://www.plxtech.com/products/uart/oxupci952
> 
> Kernel 2.6.36.1 doesn't contain any device-specific configuration,
> the "guess code" detects both UARTs at BAR0 and BAR1,
> but with the wrong baudrate (default of 115200 instead of
> 921600 needed for this card).
> 
> The card doesn't report any specific (sub-) vendor/device IDs but
> the generic Oxford IDs. So adding an entry to the pci_device_id
> table with a pbn_b0_bt_2_921600 config might break some prior
> working setups (OXuPCI952 with baud_base=115200).
> 
> Do you have any policy how to cope with such situations?

Always set the baud rate to a valid one before using the tty port?

thanks,

greg k-h
