From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH] serial: 8250_pci: unbreak last serial ports on NetMos
 9865 cards
Date: Tue, 18 Feb 2014 15:05:35 +0400
Message-ID: <CALT56yOBmKaPMP8aY0OL4x3FtJaxSAHoCt6FmmUXWswZ-DTJZw@mail.gmail.com>
References: <1392113893-8269-1-git-send-email-dbaryshkov@gmail.com>
	<CALT56yPj=0BTHxQ_2w+we8q4ETHjqX_VOUcbuYZBS5cU8GSooQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:52845 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622AbaBRLFf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Feb 2014 06:05:35 -0500
In-Reply-To: <CALT56yPj=0BTHxQ_2w+we8q4ETHjqX_VOUcbuYZBS5cU8GSooQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: kernel list <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Tue, Feb 18, 2014 at 3:00 PM, Dmitry Eremin-Solenikov
<dbaryshkov@gmail.com> wrote:
> Hello,
>
> On Tue, Feb 11, 2014 at 2:18 PM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>> Aparently 9865 uses standard BAR encoding scheme (unlike 99xx cards).
>> Current pci_netmos_9900_setup() uses wrong BAR indices for the 9865 PCI
>> device, function 2. Using standard BAR indices makes all 6 ports work
>> for me. Thus disable the NetMos 9900 quirk for NetMos 9865 pci device.
>
> Do you need any additional details for the patch?

Sorry for the noise, I missed that you have it in -fixes. Please excuse me.


-- 
With best wishes
Dmitry
