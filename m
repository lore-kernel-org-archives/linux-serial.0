From: "Neil Everton" <neil@gemini-it.com>
Subject: RE: A new serial baud rate
Date: Thu, 25 Jul 2002 20:40:22 +0100
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <HMEGLNIPFGJPACKIEKLFCEPOEOAA.neil@gemini-it.com>
References: <200207251614.08681.henrique@cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <200207251614.08681.henrique@cyclades.com>
List-Id: linux-serial@vger.kernel.org
Cc: linux-serial@vger.kernel.org

Hi,
	I may be wrong here, but 14400 isn't a 'serial' baud rate it's a 'modem'
baud rate.

	I'm not aware that serial ports can port at 14400, they usually run at 9600
or 19200.

	Most modems (unless they are fixed baud) you can talk at speeds other than
the connect speed.

	Also I believe that 14400 is only 9600 with compression !!!

Regards
Neil


-----Original Message-----
From: linux-serial-owner@vger.kernel.org
[mailto:linux-serial-owner@vger.kernel.org]On Behalf Of henrique
Sent: 25 July 2002 20:14
To: Gary Frerking
Cc: linux-serial@vger.kernel.org
Subject: Re: A new serial baud rate


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
-
To unsubscribe from this list: send the line "unsubscribe linux-serial" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

