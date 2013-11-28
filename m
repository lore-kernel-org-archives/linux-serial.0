From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 1/5] serial: 8250_pci: use DEFINE_PCI_DEVICE_TABLE macro
Date: Thu, 28 Nov 2013 14:29:17 +0900
Message-ID: <006001ceebfa$c85a1020$590e3060$%han@samsung.com>
References: <000601ceebdc$ee148de0$ca3da9a0$%han@samsung.com>
 <20131128040750.GA29917@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:19403 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab3K1F3T (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Nov 2013 00:29:19 -0500
In-reply-to: <20131128040750.GA29917@kroah.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Joe Perches' <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, 'Andrew Morton' <akpm@linux-foundation.org>, 'Andy Whitcroft' <apw@canonical.com>, linux-serial@vger.kernel.org, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>

On Thursday, November 28, 2013 1:08 PM, Greg Kroah-Hartman wrote:
> On Thu, Nov 28, 2013 at 10:55:35AM +0900, Jingoo Han wrote:
> > This macro is used to create a struct pci_device_id array.
> 
> Yeah, and it's a horrid macro that deserves to be removed, please don't
> use it in more places.
> 
> Actually, if you could just remove it, that would be best, sorry, I'm
> not going to take these patches.

(+cc Joe Perches, Andrew Morton, Andy Whitcroft)

Hi Joe Perches,

Would you fix checkpatch.pl about DEFINE_PCI_DEVICE_TABLE?
Currently, checkpatch.pl guides to use DEFINE_PCI_DEVICE_TABLE
as below.

  WARNING: Use DEFINE_PCI_DEVICE_TABLE for struct pci_device_id
  #331: FILE: drivers/usb/host/ehci-pci.c:331:
  +static const struct pci_device_id pci_ids [] = { {

However, Greg Kroah-Hartman mentioned that DEFINE_PCI_DEVICE_TABLE
shouldn't be used anymore.

So, would you change checkpatch.pl in order to guide to use
struct pci_device_id instead of DEFINE_PCI_DEVICE_TABLE?

For example,
  WARNING: Use struct pci_device_id instead of DEFINE_PCI_DEVICE_TABLE

Thank you.

Best regards,
Jingoo Han

