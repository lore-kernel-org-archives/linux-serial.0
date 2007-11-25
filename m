From: David Newall <david@davidnewall.com>
Subject: Re: 2.6.24: Serial disabled in BIOS but serial modules still	loaded
 (probably PnP related)
Date: Sun, 25 Nov 2007 18:24:07 +1030
Message-ID: <47492A1F.4030106@davidnewall.com>
References: <200711242336.43712.arvidjaar@mail.ru> <1195962922.5044.8.camel@canyon.wittsend.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hawking.rebel.net.au ([203.20.69.83]:35135 "EHLO
	hawking.rebel.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbXKYHyS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 25 Nov 2007 02:54:18 -0500
In-Reply-To: <1195962922.5044.8.camel@canyon.wittsend.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: mhw@WittsEnd.com
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Michael H. Warfield wrote:
> On Sat, 2007-11-24 at 23:36 +0300, Andrey Borzenkov wrote:
>   
>> I have no COM port on notebook (without port replicator which I do not have)
>> so COM is disabled in BIOS. No ttyS* is detected during boot (and no device
>> created) but I just noticed that serial modules are still loaded. Well, this
>> partially defeats the purpose of disabling COM port - the intention was to
>> free resources by *not* loading unneeded modules ...
>>     
>
>   
>> This may have something to do with (ACPI) PnP which apparently believes COM is alive.
>> Notebook is Toshiba Portege 4000.
>>     
>
> 	Nice...  What's this then?
>
>   
>> 00:09 PNP0501 16550A-compatible serial port
>>     state = active
>>         io 0x3f8-0x3ff
>>         irq 5
>>     

This doesn't mean that a port (ie connector) is present.  My notebook 
also has the electronics without the physical connector.
