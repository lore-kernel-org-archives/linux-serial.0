From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: 3.4-rc5: usbserial pl2303 attached via Texas Instruments USB3.0
 chip Oopses
Date: Wed, 2 May 2012 16:46:39 -0700
Message-ID: <20120502234639.GH22341@xanatos>
References: <4FA10506.7020203@fold.natur.cuni.cz>
 <201205021222.30133.oneukum@suse.de>
 <4FA11113.6060901@fold.natur.cuni.cz>
 <201205021444.07823.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11964 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753871Ab2EBXqr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 May 2012 19:46:47 -0400
Content-Disposition: inline
In-Reply-To: <201205021444.07823.oneukum@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, gregkh@linuxfoundation.org, linux-serial@vger.kernel.org

On Wed, May 02, 2012 at 02:44:07PM +0200, Oliver Neukum wrote:
> Am Mittwoch, 2. Mai 2012, 12:48:51 schrieb Martin Mokrejs:
> > > Does it work if you boot with nomsi?
> > 
> > Yes, dmesg attached.
> 
> Sorry, I was referring to pci=nomsi
> 
> So it works if you simply add "nomsi" to the kernel command line?
> Can you check whether this is repeatable?

If it's repeatable, we can just add the XHCI_BROKEN_MSI quirk to that TI
host.

Sarah Sharp
