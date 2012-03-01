From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCH 0/4 V2] pch_uart: Cleanups, board quirks, and user uartclk
 parameter
Date: Wed, 29 Feb 2012 16:47:58 -0800
Message-ID: <4F4EC73E.40209@linux.intel.com>
References: <cover.1330539597.git.dvhart@linux.intel.com> <CANKRQnhFVJAUHAg0qTPFJ8L0L_+-_q4ZtfOnV0wSR1Xa6Mn8UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14866 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755829Ab2CAAte (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 29 Feb 2012 19:49:34 -0500
In-Reply-To: <CANKRQnhFVJAUHAg0qTPFJ8L0L_+-_q4ZtfOnV0wSR1Xa6Mn8UQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Alan Cox <alan@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Feng Tang <feng.tang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org



On 02/29/2012 04:38 PM, Tomoya MORINAGA wrote:
> Hi
> 
> Darren's patch series, I think OK.
> However, need to proceed next step.

Great, Greg are you happy with these as they are?

> 
> As I said before,
> internal clock(USB_48MHz) should be used than external clock(UART_CLK)
> as default setting.
> --Reasons
>   - Users don't always use 1.8432MHz as UART_CLK.
>     So,  In case of using except 1.8432MHz,
>     the user needs to change both pch_phub and pch_uart setting (It's
> bother things).
>   - High baud rate can't be used more than 115Kbps
> 
> I think there is no merit to use UART_CLK.
> 
> ---Merit to use 192MHz
>   - Users don't have to care both pch_phub and pch_uart clock setting.
>   - High baud rate can be supported

I have no objection to this provided the early serial console can work
without additional patches. So the question now is, how do we force the
192MHz clock setting BEFORE the pch_phub code runs?


-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
