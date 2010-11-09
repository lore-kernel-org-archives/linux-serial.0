From: Greg KH <gregkh@suse.de>
Subject: Re: 8250_pci and OXPCIe952
Date: Tue, 9 Nov 2010 07:45:13 -0800
Message-ID: <20101109154513.GA5970@suse.de>
References: <4CD96169.2060705@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42510 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202Ab0KIPuQ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Nov 2010 10:50:16 -0500
Content-Disposition: inline
In-Reply-To: <4CD96169.2060705@linux.vnet.ibm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Breno Leitao <leitao@linux.vnet.ibm.com>
Cc: linux-serial@vger.kernel.org

On Tue, Nov 09, 2010 at 12:57:45PM -0200, Breno Leitao wrote:
> Hi Greg,
> 
> I put an OXPCIe952 card on my machine (PPC), and the driver is not
> running fine.
> First of all, it identifies 8 ports, which is wrong. Also, it says

How many should there be?

> 
> 0000:01:00.1: ttyS1 at MMIO 0x3c05ff7fd200 (irq = 66) is a 16C950/954
> 
> and the driver loads without any other error, although it's not working.

What should the address and irq be?

> So, my question is: Does this driver support this chipset?

I don't know.

> Was it ever tested on PPC ?

I don't know.

thanks,

greg k-h
