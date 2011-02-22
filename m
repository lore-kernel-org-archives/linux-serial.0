From: Greg KH <greg@kroah.com>
Subject: Re: LAVA PCIe serial card problem
Date: Tue, 22 Feb 2011 14:05:48 -0800
Message-ID: <20110222220548.GB4530@kroah.com>
References: <4D62F593.4010103@cfa.harvard.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:35376 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296Ab1BVWGF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Feb 2011 17:06:05 -0500
Content-Disposition: inline
In-Reply-To: <4D62F593.4010103@cfa.harvard.edu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tamas Szklenar <tszklenar@cfa.harvard.edu>
Cc: linux-serial@vger.kernel.org

On Mon, Feb 21, 2011 at 06:30:27PM -0500, Tamas Szklenar wrote:
> Hi,
> 
> We bought two PCIe serial cards from LAVA, one dual and one quad port card.
> 
> My problem is that the devices are visible in lspci, but no module
> is loaded to the cards. I have other PCI card from this manufacturer
> and they are working well and the necessary module is loaded fine.
> 
> Our linux is using the 2.6.35.7 kernel version.
> 
> Could you help me to fix these card?
> 
> I attached the output of the dmesg and the lspci to my mail.

What driver attached to the other cards that work properly for you?
Have you tried adding the device id for your new card to the "new_ids"
file for this driver and seeing if that worked properly or not?

thanks,

greg k-h
