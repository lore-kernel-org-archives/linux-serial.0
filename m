From: Karsten Malcher <debian@dct.mine.nu>
Subject: Re: Adding driver for MCS9865 to the kernel sources
Date: Tue, 18 Feb 2014 11:57:22 +0100
Message-ID: <53033C92.1010909@dct.mine.nu>
References: <53033560.2090004@dct.mine.nu> <1392720214.53908977@f120.i.mail.ru>
Reply-To: debian@dct.mine.nu
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtprelay01.ispgateway.de ([80.67.31.28]:43689 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936AbaBRK53 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Feb 2014 05:57:29 -0500
In-Reply-To: <1392720214.53908977@f120.i.mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org

Am 18.02.2014 11:43, schrieb Alexander Shiyan:
> At least for my 9835, its works without any 3rd-party drivers.
>
>

In the history it was working with older kernels previous version 3.0.

When you open the README you find this description:


To build driver on kernels from v2.6.34 till latest:
----------------------------------------------------
   Since the device ID 9865 is included (as built-in) with kernel versions
     starts from v2.6.34 and above, the following procedure is required to
     follow to detect MCS9865 devices.

   b) Open file "8250_pci.c".
     - find for the macro PCI_DEVICE_ID_NETMOS_9865.  It will be found in two places,
         1) In the struct definition "serial_pci_tbl[]"
           - Comment the below lines,

         "
                 {       PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
                         0xA000, 0x1000,
                         0, 0, pbn_b0_1_115200 },

                 {       PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
                         0xA000, 0x3004,
                         0, 0, pbn_b0_bt_4_115200 },
         "
---------------------------------------------------------------------------------------------------


This seems to be the problem.
At least you must recompile parts of the kernel to get it running.
So you can't work with the standard kernel of a distribution!

It would be very helpful if this driver would be part of the standard kernel sources.

