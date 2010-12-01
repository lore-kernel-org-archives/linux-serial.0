From: Greg KH <greg@kroah.com>
Subject: Re: OXuPCI952 and baud_base questions
Date: Wed, 1 Dec 2010 15:57:22 -0800
Message-ID: <20101201235722.GA26896@kroah.com>
References: <20101201164634.GA5773@horus.com>
 <20101201221604.GA22114@kroah.com>
 <20101201235241.GA4070@horus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:35152 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343Ab0LAX50 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Dec 2010 18:57:26 -0500
Content-Disposition: inline
In-Reply-To: <20101201235241.GA4070@horus.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matthias Reichl <hias@horus.com>, Linux Kernel <linux-serial@vger.kernel.org>

On Thu, Dec 02, 2010 at 12:52:41AM +0100, Matthias Reichl wrote:
> Hi Greg!
> 
> On Wed, Dec 01, 2010 at 02:16:04PM -0800, Greg KH wrote:
> > On Wed, Dec 01, 2010 at 05:46:34PM +0100, Matthias Reichl wrote:
> > > I've got a Lindy 51237 multi I/O card (2 16C950 URATs up to 921kbit
> > > plus one parallel port) with a Oxford OXuPCI952 chip (PCI vendor
> > > ID 0x1415, device ID 0x9505).
> > > 
> > > http://www.lindy-international.com/2-port-rs-232-serial-1-port-parallel-card-pci/51237.html
> > > http://www.plxtech.com/products/uart/oxupci952
> > > 
> > > Kernel 2.6.36.1 doesn't contain any device-specific configuration,
> > > the "guess code" detects both UARTs at BAR0 and BAR1,
> > > but with the wrong baudrate (default of 115200 instead of
> > > 921600 needed for this card).
> > > 
> > > The card doesn't report any specific (sub-) vendor/device IDs but
> > > the generic Oxford IDs. So adding an entry to the pci_device_id
> > > table with a pbn_b0_bt_2_921600 config might break some prior
> > > working setups (OXuPCI952 with baud_base=115200).
> > > 
> > > Do you have any policy how to cope with such situations?
> > 
> > Always set the baud rate to a valid one before using the tty port?
> 
> Sorry, I meant baud_base (or base_baud in 8250_pci.c), not baudrate :-(
> 
> Since the baud_base is differing (115200 instead of 921600)
> setting a baudrate of X results in an actual baudrate of X*8 for
> this card.
> 
> It's no problem for me to do a "setserial ... baud_base=921600"
> or pass a module/kernel parameter to circumvent the problem,
> but it sure would be nicer if the kernel would have set
> the baud_base correctly.
> 
> The problem I'm seeing here is that this card is using a stock
> OXuPCI952, which can be equipped with any oscillator, and doesn't
> report any vendor-specific PCI IDs that lets it be distinguished
> from other stock OXuPCI952 cards - otherwise I've just sent
> a "[PATCH] Add support for Lindy 51237" to set baud_base=921600
> for this specific card.
> 
> Personally, all 16C950 (compatible) cards I've bought so far
> were capable of a max. 921kbit/sec (and thus had a baud_base of 921600).
> So the current default of 115200 doesn't quite match my setup.
> If I only need a card capable of 115200 bit/sec I usually buy
> a standard 16550 card (not a 16C950).
> 
> So, my question is: would you include a patch in the kernel
> to change the default baud_base from 115200 to 921600 for
> the OXuPCI952 chip (1415:9505)?

As it sounds like this might break existing setups, I'd probably defer
to not taking such a patch.

sorry,

greg k-h
