From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 1/5] serial: 8250_pci: use DEFINE_PCI_DEVICE_TABLE macro
Date: Thu, 28 Nov 2013 13:32:47 +0900
Message-ID: <005101ceebf2$e3760a60$aa621f20$%han@samsung.com>
References: <000601ceebdc$ee148de0$ca3da9a0$%han@samsung.com>
 <20131128040750.GA29917@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:52087 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758629Ab3K1EdG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 27 Nov 2013 23:33:06 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWY003KGHYNTS80@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Thu, 28 Nov 2013 13:32:47 +0900 (KST)
In-reply-to: <20131128040750.GA29917@kroah.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, 'Angelo Butti' <buttiangelo@gmail.com>, 'Ian Abbott' <abbotti@mev.co.uk>, 'Heikki Krogerus' <heikki.krogerus@linux.intel.com>, 'Jingoo Han' <jg1.han@samsung.com>

On Thursday, November 28, 2013 1:08 PM, Greg Kroah-Hartman wrote:
> On Thu, Nov 28, 2013 at 10:55:35AM +0900, Jingoo Han wrote:
> > This macro is used to create a struct pci_device_id array.
> 
> Yeah, and it's a horrid macro that deserves to be removed, please don't
> use it in more places.
> 
> Actually, if you could just remove it, that would be best, sorry, I'm
> not going to take these patches.

OK, I see. :-)
Then, I will send the patch to remove DEFINE_PCI_DEVICE_TABLE soon.
Thank you for your guidance.

Best regards,
Jingoo Han

