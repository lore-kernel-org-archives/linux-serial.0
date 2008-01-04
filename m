From: Matthieu CASTET <matthieu.castet@parrot.com>
Subject: Re: [PATCH] s3c2412 serial : more accurate baudrate generation
Date: Fri, 04 Jan 2008 09:34:48 +0100
Message-ID: <477DEFA8.2020703@parrot.com>
References: <477D01A4.6070808@parrot.com> <20080103224911.GC29922@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co203.xi-lite.net ([149.6.83.203]:45349 "EHLO
	toronto.xi-lite.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753898AbYADIfa (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 4 Jan 2008 03:35:30 -0500
In-Reply-To: <20080103224911.GC29922@trinity.fluff.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ben Dooks <ben-linux-arm@fluff.org>
Cc: Linux Arm Mailing List <linux-arm-kernel@lists.arm.linux.org.uk>, linux-serial@vger.kernel.org

Hi,

Ben Dooks wrote:
> On Thu, Jan 03, 2008 at 04:39:16PM +0100, Matthieu CASTET wrote:
> 
>> use UDIVSLOT register on 2412, to get better accuracy when computing the
>> baudrate.
> 
> Personally, I think the following would have been better:
> 
> Improve the accuracy of baud rate generation on the S3C2412 by using the
> UDIVSLOT register to acheive better division if the clock does not directly
> divide down to the required baud rate.
>  
That's sound better.
Thanks for the re-writing.
>> The clock generation is divised on 16 slots.
>> UDIVSLOT : if the bit n is set to 1, then for the slot n the clock generator 
>> divide clock source by (UBRDIV + 2) instead of (UBRDIV + 1).
>>
>> So if m is the number of bit set to one, the baudrate is
>> CLOCK / (m*(UBRDIV + 2) + (16-m)*(UBRDIV + 1))
>> CLOCK / (16*(UBRDIV + 1) + m)
>>
>> See 2412 datasheet for more info.
> 
> I think this could do with re-writing too, but I'll leave that till tommorow.
> 
> My only other question is has this been tested on an non S3C2412 CPUs?
>  
No, I only test it on 2412.

Thanks,

Matthieu
