From: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] Add the ability to layer another driver over the serial
 driver
Date: Sun, 10 Dec 2006 19:23:54 -0600
Message-ID: <457CB32A.2060804@mvista.com>
References: <4533B8FB.5080108@mvista.com> <20061210201438.tilman@imap.cc> <Pine.LNX.4.60.0612102117590.9993@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:59916 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758391AbWLKBX5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 10 Dec 2006 20:23:57 -0500
In-Reply-To: <Pine.LNX.4.60.0612102117590.9993@poirot.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Tilman Schmidt <tilman@imap.cc>, linux-serial@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, Hansjoerg Lipp <hjlipp@web.de>, Russell Doty <rdoty@redhat.com>

Nothing has come of this yet.  But we have these two requests and a 
request from Russell Doty at Redhat.

It would be nice to know if this type of thing was acceptable or not, 
and the problems with the patch.  The patch is at 
http://home.comcast.net/~minyard

-Corey

Guennadi Liakhovetski wrote:
> On Sun, 10 Dec 2006, Tilman Schmidt wrote:
>
>   
>> On Mon, 16 Oct 2006 11:53:15 -0500, Corey Minyard <cminyard@mvista.com> wrote:
>>     
>>> This is a set of three patches to allow adding another driver on top of
>>> the current serial driver without too much change to the serial code.
>>> This is more for comments right now, it is probably not ready for real
>>> use yet.
>>>       
>
> [snip]
>
>   
>> Has anything ever come of this? I would be very much interested in it.
>> It might make it possible to extend the Siemens Gigaset drivers
>> (drivers/isdn/gigaset) to the RS232 attached M101 DECT adapter.
>> There is a working driver out of tree which accesses the serial port
>> hardware directly (i8250 only), but that kind of thing doesn't seem
>> fit for inclusion in the kernel.
>>     
>
> ...FWIW I would also gladly remove 
> arch/powerpc/platforms/embedded6xx/ls_uart.c 
> in favour of a standard interface to drivers/serial.
>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski
>   

