From: Axel Hosemann <axel.hosemann@freesurf.ch>
Subject: Re: Suggested patch for linux
Date: Sat, 12 Jul 2008 23:49:47 +0200
Message-ID: <487926FB.6090703@freesurf.ch>
References: <487546D5.8050908@freesurf.ch> <20080710095904.16dfdb08@the-village.bc.nu> <487619C8.7080509@commtech-fastcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-proxy-be-01.sunrise.ch ([194.158.229.48]:25867 "EHLO
	gw-out-be-03.be08.sunrise.ch" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751582AbYGLVt6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 12 Jul 2008 17:49:58 -0400
Received: from hu-out-0506.google.com (hu-out-0506.google.com [72.14.214.230])
	by gw-out-be-03.be08.sunrise.ch (8.13.1/8.13.5) with ESMTP id m6CLo11C016699
	for <linux-serial@vger.kernel.org>; Sat, 12 Jul 2008 23:50:02 +0200
Received: by hu-out-0506.google.com with SMTP id 28so2736704hug.7
        for <linux-serial@vger.kernel.org>; Sat, 12 Jul 2008 14:49:55 -0700 (PDT)
In-Reply-To: <487619C8.7080509@commtech-fastcom.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Matt Schulte <matts@commtech-fastcom.com>
Cc: linux-usb@vger.kernel.org, linux-serial@vger.kernel.org

Dear Matt,
first of all, I must apologise for not being familiar with the mailing 
rules of your organisation. I already received a mail by a female 
developer, who was annoyed by me addressing her as "Dear Sirs". Oops! 
I'm sorry.
 From your reply I see, that you understood the reason for the suggested 
patch: I try to port a half duplex application from Windows to Linux, 
which on one hand controls a radio modem by means of a 2 wire RS-485 
bus, and on the other hand exchanges payload data over the half duplex 
radio channel across an asynchronous port. There is no chance for me 
doing that  without this patch, because Linux does not support a feature 
similar to the Windows "RTS_CONTROL_TOGGLE" option.
To the problem you mentioned. Yes, your right: If the RS-485 slave 
device would reply a request with hardware timings within a few 
microseconds, a collision would occur. This would certainly not destroy 
the RS-485 chips, because they are generally protected against these 
collision situations. But theoretically the application would not work, 
when the slave would reply faster, than the PC could release the RTS 
signal.  In practice, I did not face this situation (yet!) Probably 
because the receiving slave needs a micro controller itself, checking 
the checksum, interpreting the request and preparing the response. But 
the problem persists: The OS controlled deassertion of the RTS signal 
may be too slow for fast RS-485 slaves. Anyway, up to now, I had no 
problems with that issue with the mentioned Windows application. But 
when I'm back from my holydays I will do some measurements to compare 
the timing between the Windows application and the suggested Linux patch.
For radio modem transmission, there will be no problem at all: Radio 
modems will always utilise FEC functionalities, which imply interleaving 
and deinterleaving delays. The deinterleaving delay of the receiver is 
in the range of hundreds of milliseconds. Even on legacy PC hardware 
platforms, the OS should be able to deassert RTS in time.
However, the half duplex feature could extend the Linux functionality. I 
read in a few forum threads, that there would be a demand for this 
functionality besides my personal interests.

Best Regards
Axel Hosemann


Matt Schulte wrote:
>
>> The big problem is that the kernel does not know what is a 
>> "transmission"
>> it just sees a series of writes to the device. In many cases the
>> multi-drop or radio systems also need the caller to wait for a
>> transmission slot either by beacon, by timing or by monitoring the
>> carrier detect to avoid collisions.
> I believe that he is referring to something much simpler than you are 
> thinking.  He is talking about 2-wire RS485 transmissions in which the 
> RTS signal is used to enable the driver chips just before transmitting 
> data and disabling (tri-stating) them just after transmitting data.  
> There are some UARTs that have this behavior built into them.
>>
>> That seems to best be done in user space as the algorithms are quite
>> variable and some are complex.
>>
>> Do we really benefit from having this in kernel ?
> The problem that can come up when executing this feature in user-land 
> (though not exactly common) is when the hardware on the other end 
> responds to your message faster than your user app was able to detect 
> that the UART is finished and then toggle RTS.  When this happens both 
> ends are trying to drive the line and you have bus contention, lost 
> data and possibly damage to the driver chips themselves.
>
> Matt Schulte
> Commtech, Inc.
> http://www.commtech-fastcom.com
>
>
>
>

