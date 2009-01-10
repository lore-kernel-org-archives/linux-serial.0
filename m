From: "christian pellegrin" <chripell@gmail.com>
Subject: Re: [PATCH RESEND] MAX3100 SPI UART driver
Date: Sat, 10 Jan 2009 19:49:58 +0100
Message-ID: <cabda6420901101049s5f7795fpf6ec033c95ba85ab@mail.gmail.com>
References: <12229367533638-git-send-email-chripell@gmail.com>
	 <20090109142134.c388e699.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:38591 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbZAJSuB (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 10 Jan 2009 13:50:01 -0500
In-Reply-To: <20090109142134.c388e699.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, spi-devel-general@lists.sourceforge.net, alan@lxorguk.ukuu.org.uk, device@lanana.org

On Fri, Jan 9, 2009 at 11:21 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> afaik this patch is still stuck, awaiting a nod for this:
>
>> --- a/include/linux/serial_core.h
>> +++ b/include/linux/serial_core.h
>> @@ -155,6 +155,9 @@
>>
>>  #define PORT_SC26XX  82
>>
>> +/* MAX3100 */
>> +#define PORT_MAX3100    83
>> +
>

Hello,

I'm sorry. I asked two times following all the instructions in
devices.txt (or at least trying to do so) without any response. I hope
I didn't do something wrong. :-/

Thanks,

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."
