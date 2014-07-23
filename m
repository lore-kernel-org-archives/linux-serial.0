From: Alex Elder <elder@linaro.org>
Subject: Re: dw8250_set_termios() questions
Date: Wed, 23 Jul 2014 08:34:11 -0500
Message-ID: <53CFB9D3.8030403@linaro.org>
References: <53BFDF22.1020302@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:48563 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbaGWNeN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Jul 2014 09:34:13 -0400
Received: by mail-ig0-f182.google.com with SMTP id c1so1424980igq.3
        for <linux-serial@vger.kernel.org>; Wed, 23 Jul 2014 06:34:12 -0700 (PDT)
In-Reply-To: <53BFDF22.1020302@linaro.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: heikki.krogerus@linux.intel.com
Cc: Greg KH <gregkh@linuxfoundation.org>, david.daney@cavium.com, loic.poulain@intel.com, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

Heikki, ping.

On 07/11/2014 07:57 AM, Alex Elder wrote:
> Heikki, I have not been a subscriber of the linux-serial
> mailing list and didn't see this patch go by:
>     serial: 8250_dw: clock rate handling for all ACPI platforms
>     http://www.spinics.net/lists/linux-serial/msg12861.html
> 
> I had been working on doing something very similar for some
> Broadcom device tree based devices and it might have been
> helpful for me to have seen it.  What I ended up with was
> *very* similar to what you did.  Here is the last version
> of the patch I posted:
>     https://lkml.org/lkml/2014/7/1/323
> 
> There *are* some differences, and I'd like to inquire about
> them before I simply use the code you have for my purpose.
> 
> These first two relate to whether I can use your
> code as-is:
> - Why do you skip setting the clock if a null "old"
>   pointer is supplied?
> - I don't believe it's necessary to surround the clock
>   rate change with clk_disable_unprepare() and
>   clk_prepare_enable().  Do you believe otherwise?
> 
> This one is addressed to how your code is used now:
> - Alan Cox had this question about my patch, and
>   it seems to apply to your code as well:
>     "This assumes an arbitarily configurable clock,
>     which is not I think the usual case."
>     https://lkml.org/lkml/2014/6/28/91
>   His point is that the clock, if adjustable, may
>   not support a rate that produces an acceptable
>   signal rate.  Put another way, there may be a
>   better frequency than what the clock framework
>   selects that (in combination with the UART
>   divisor latch registers) produces the best--or
>   even a good--signal.  Is there any chance any
>   ACPI platforms will suffer this problem?
> 
> Thanks.
> 
> 					-Alex
> 

