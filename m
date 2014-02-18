From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Adding driver for MCS9865 to the kernel sources
Date: Tue, 18 Feb 2014 09:22:50 -0500
Message-ID: <CAP=VYLo+OO90t+SE=1zSEx2Gpyz5j+DMNhMysvRfHi2DAOYNiQ@mail.gmail.com>
References: <53033560.2090004@dct.mine.nu> <1392720214.53908977@f120.i.mail.ru>
 <53033C92.1010909@dct.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:45366 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755084AbaBROXV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Feb 2014 09:23:21 -0500
Received: by mail-wi0-f173.google.com with SMTP id hn9so3541619wib.12
        for <linux-serial@vger.kernel.org>; Tue, 18 Feb 2014 06:23:20 -0800 (PST)
In-Reply-To: <53033C92.1010909@dct.mine.nu>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: debian@dct.mine.nu
Cc: Alexander Shiyan <shc_work@mail.ru>, linux-serial@vger.kernel.org

On Tue, Feb 18, 2014 at 5:57 AM, Karsten Malcher <debian@dct.mine.nu> wrote:
> Am 18.02.2014 11:43, schrieb Alexander Shiyan:
>
>> At least for my 9835, its works without any 3rd-party drivers.
>>
>>
>
> In the history it was working with older kernels previous version 3.0.
>
> When you open the README you find this description:

This is the vendor readme, so it may not be the best advice.  They only
want to disable the in-kernel driver so that their own driver can load.

>
>
> To build driver on kernels from v2.6.34 till latest:
> ----------------------------------------------------
>   Since the device ID 9865 is included (as built-in) with kernel versions
>     starts from v2.6.34 and above, the following procedure is required to
>     follow to detect MCS9865 devices.
>
>   b) Open file "8250_pci.c".
>     - find for the macro PCI_DEVICE_ID_NETMOS_9865.  It will be found in two
> places,
>         1) In the struct definition "serial_pci_tbl[]"
>           - Comment the below lines,
>
>         "
>                 {       PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
>                         0xA000, 0x1000,
>                         0, 0, pbn_b0_1_115200 },
>
>                 {       PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9865,
>                         0xA000, 0x3004,
>                         0, 0, pbn_b0_bt_4_115200 },
>         "
> ---------------------------------------------------------------------------------------------------
>
>
> This seems to be the problem.
> At least you must recompile parts of the kernel to get it running.
> So you can't work with the standard kernel of a distribution!
>
> It would be very helpful if this driver would be part of the standard kernel
> sources.

But it _is_ in standard kernel sources; see very old commit:

commit ac6ec5b1de5d1d5afcbe88d73c05df71dca0ac39
Author: Ira W. Snyder <iws@ovro.caltech.edu>
Date:   Mon Dec 21 16:26:45 2009 -0800

    serial: 8250_pci: add support for MCS9865 / SYBA 6x Serial Port Card

Maybe your problem is related to not having this very recent commit?

commit 333c085e4b0cd9df04b087d29f87969a4e26dfa9
Author: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Date:   Tue Feb 11 14:18:13 2014 +0400

    serial: 8250_pci: unbreak last serial ports on NetMos 9865 cards

In any case, I suggest collecting the boot logs relating to your
serial card and posting them here; boot with the latest kernel,
and without any vendor drivers.  With the right information,
I suspect people here can fix the driver for your card as well.

Please also include the "lspci [-vvv]" output relating to your
specific card, so that quirks can be assigned to specific cards
if needed.

Paul.
--

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
