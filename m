From: Tamas Szklenar <tszklenar@cfa.harvard.edu>
Subject: Re: LAVA PCIe serial card problem
Date: Tue, 22 Feb 2011 17:15:01 -0500
Message-ID: <4D643565.5080409@cfa.harvard.edu>
References: <4D62F593.4010103@cfa.harvard.edu> <20110222220548.GB4530@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cfa.harvard.edu ([131.142.10.1]:45911 "EHLO cfa.harvard.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749Ab1BVWPW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Feb 2011 17:15:22 -0500
In-Reply-To: <20110222220548.GB4530@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-serial@vger.kernel.org

Hi Greg,

Thanks for reply.
I attached no special driver to the other cards, only the kernels self 
"serial" driver.

I checked the 'include/linux/pci_ids.h' and the 
'drivers/serial/8250_pci.c' for the support and our new pcie serial 
cards are already in this.

Thanks,
Tamas

> On Mon, Feb 21, 2011 at 06:30:27PM -0500, Tamas Szklenar wrote:
>> Hi,
>>
>> We bought two PCIe serial cards from LAVA, one dual and one quad port card.
>>
>> My problem is that the devices are visible in lspci, but no module
>> is loaded to the cards. I have other PCI card from this manufacturer
>> and they are working well and the necessary module is loaded fine.
>>
>> Our linux is using the 2.6.35.7 kernel version.
>>
>> Could you help me to fix these card?
>>
>> I attached the output of the dmesg and the lspci to my mail.
> What driver attached to the other cards that work properly for you?
> Have you tried adding the device id for your new card to the "new_ids"
> file for this driver and seeing if that worked properly or not?
>
> thanks,
>
> greg k-h

