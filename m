From: henrique <henrique@cyclades.com>
Subject: Re: A new serial baud rate
Date: Thu, 25 Jul 2002 16:14:08 -0300
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <200207251614.08681.henrique@cyclades.com>
References: <1779CCD227485B49A825718AAAA90E3E406CD1@tpsmail01.turbopower.net>
Reply-To: henrique@cyclades.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1779CCD227485B49A825718AAAA90E3E406CD1@tpsmail01.turbopower.net>
List-Id: linux-serial@vger.kernel.org
To: Gary Frerking <garyf@turbopower.com>
Cc: linux-serial@vger.kernel.org

Hello Gary !!!

Thanks for your answer. Please see comments no the text.

> 14400 relates to the baud rate between the modems, not between the PC
> and the modem (the serial port rate). The "B" defines control the serial
> port rate.
>
> If you want to use 14400, set a higher port rate (ie., 19200 or higher)
> and enable flow control.
>
> Obviously, you'll have to set the modem properly as well.

That's the problem. I can't change the modem configuration cause this modem 
are provided by the Telco. I have to use this baud rate. And I wanna use it 
with Linux.

I just wanna know what is the procedure to insert this new baud rate in the 
linux kernel

regards
Henrique

>
> -- Gary
>
> -----Original Message-----
> From: henrique [mailto:henrique@cyclades.com]
> Sent: Thursday, July 25, 2002 12:23 PM
> To: linux-serial@vger.kernel.org
> Subject: A new serial baud rate
>
> Hello !!!
>
> I want to use the 14400 baud rate on a serial port (I have a lot of
> modems
> configured to this baud rate) but the define B14400 doesn't exist. What
> should I do. Is it a matter of simply insert the new define into
> termbits.h ?
>
> thanks in advance
> ---
> Henrique Gobbi
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-serial"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
