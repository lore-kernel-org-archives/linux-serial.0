From: Mike Dresser <mdresser_l@windsormachine.com>
Subject: Re: A new serial baud rate
Date: Thu, 25 Jul 2002 14:46:00 -0400 (EDT)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.33.0207251445150.18558-100000@router.windsormachine.com>
References: <200207251522.49383.henrique@cyclades.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <200207251522.49383.henrique@cyclades.com>
List-Id: linux-serial@vger.kernel.org
To: henrique <henrique@cyclades.com>
Cc: linux-serial@vger.kernel.org

Set your rate to 57600 then.  Except for 2400's that didn't do
compression, generally, you set the rate to the highest the modem will
support.  In this case, either 57600 or 115200, more likely the former.
If that doesn't work, then use 38400.

On Thu, 25 Jul 2002, henrique wrote:

> Hello !!!
>
> I want to use the 14400 baud rate on a serial port (I have a lot of modems
> configured to this baud rate) but the define B14400 doesn't exist. What
> should I do. Is it a matter of simply insert the new define into termbits.h ?
>
> thanks in advance
> ---
> Henrique Gobbi
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

