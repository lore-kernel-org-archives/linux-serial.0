From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 3/5] serial: jsm: use DEFINE_PCI_DEVICE_TABLE macro
Date: Fri, 29 Nov 2013 09:53:36 +0900
Message-ID: <001c01ceec9d$6fa72a50$4ef57ef0$%han@samsung.com>
References: <000601ceebdc$ee148de0$ca3da9a0$%han@samsung.com>
 <000801ceebdd$5b984a50$12c8def0$%han@samsung.com>
 <20131128113542.GC24646@oc0268524204.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:22651 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329Ab3K2Axk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Nov 2013 19:53:40 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MX0000IP2HE8ZA0@mailout3.samsung.com> for
 linux-serial@vger.kernel.org; Fri, 29 Nov 2013 09:53:38 +0900 (KST)
In-reply-to: <20131128113542.GC24646@oc0268524204.ibm.com>
Content-language: ko
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Thadeu Lima de Souza Cascardo' <cascardo@linux.vnet.ibm.com>
Cc: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

On Thursday, November 28, 2013 8:36 PM, Thadeu Lima de Souza Cascardo wrote:
> On Thu, Nov 28, 2013 at 10:58:39AM +0900, Jingoo Han wrote:
> > This macro is used to create a struct pci_device_id array.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> > ---
> >  drivers/tty/serial/jsm/jsm_driver.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

[.....]

> 
> Acked-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>

Thank you for your review! :-)

However, these patches should NOT be merged.

According to the Greg Kroah-Hartman,
"Yeah, and it's a horrid macro that deserves to be removed, please don't
use it in more places.

Actually, if you could just remove it, that would be best, sorry, I'm
not going to take these patches."

So, I will send the patch to remove 'DEFINE_PCI_DEVICE_TABLE' instead.
Sorry for annoying you. :-)

Best regards,
Jingoo Han

