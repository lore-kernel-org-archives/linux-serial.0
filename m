From: "David H. Lynch Jr." <dhlii@dlasys.net>
Subject: Re: is_real_interrupt in 8250.c
Date: Thu, 30 Nov 2006 04:32:00 -0500
Message-ID: <456EA510.3010805@dlasys.net>
References: <200611291744.kATHixEN006240@oogie-boogie.ics.uci.edu> <20061129181148.GA31874@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from 24.152.213.223.res-cmts.eph.ptd.net ([24.152.213.223]:5353 "EHLO
	mx.dlasys.net") by vger.kernel.org with ESMTP id S933168AbWK3Jg4
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 30 Nov 2006 04:36:56 -0500
Received: from l-dhlii.dlasys.net ([206.223.20.247]:2030)
	by mx.dlasys.net with esmtpa (Exim 4.62 #1 (Debian))
	id 1Gpj6e-000131-L8 by authid <dhlii> with plain_server
	for <linux-serial@vger.kernel.org>; Thu, 30 Nov 2006 05:25:28 -0500
In-Reply-To: <20061129181148.GA31874@thunk.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Theodore Tso wrote:
> On Wed, Nov 29, 2006 at 09:44:59AM -0800, Dan Nicolaescu wrote:
>   
>> Hi,
>>
>> In 8250.c is_real_interrupt is defined like this: 
>>
>> /*
>>  * We default to IRQ0 for the "no irq" hack.   Some
>>  * machine types want others as well - they're free
>>  * to redefine this in their header file.
>>  */
>> #define is_real_interrupt(irq)  ((irq) != 0)
>>
>> on my platform the UART IRQ is 0, so is_real_interrupt returns
>> false.
>>
>> In order to allow machines to override is_real_interrupt, and for the
>> code to match the comment shouldn't this patch be applied? 
>>     
>
> No, IRQ 0 for linux is always "no IRQ".  We should probably add this
> to the LKML FAQ, since it keeps coming up.  Per Linus, if there are
> any architectures that has a valid IRQ #0, then the
> architecture-specific kernel code should remap IRQ numbers.  See:
>
> 	http://comments.gmane.org/gmane.linux.kernel/468449
>
> 						- Ted
>   
My reading of the messages you linked to is that  is_real_interrupt 
should eb defined as

#define is_real_interrupt(irq) ((irq) != NO_IRQ)

where NO_IRQ may be defined differently for platforms where IRQ #0 is 
valid,
not that IRQ 0 is always "no IRQ"

I have not done any low level x86 linux work, but even on an x86 IRQ 0 
is valid.





> -
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein

