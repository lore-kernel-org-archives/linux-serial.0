From: Roel Kluin <roel.kluin@gmail.com>
Subject: Re: [PATCH] serial: Two branches the same in timbuart_set_mctrl()
Date: Mon, 15 Mar 2010 14:33:59 +0100
Message-ID: <4B9E3747.9060400@gmail.com>
References: <4B532CF5.7080000@gmail.com> <20100117181702.026269e9@lxorguk.ukuu.org.uk> <4B535ED8.2050703@gmail.com> <4B9E0160.5000900@pelagicore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B9E0160.5000900@pelagicore.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@pelagicore.com>
Cc: linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-serial@vger.kernel.org

Hi Richard, 

>>       if (mctrl&  TIOCM_RTS)
>>           iowrite8(TIMBUART_CTRL_RTS, port->membase + TIMBUART_CTRL);
>>       else
>> -        iowrite8(TIMBUART_CTRL_RTS, port->membase + TIMBUART_CTRL);
>> +        iowrite8(TIMBUART_CTRL_CTS, port->membase + TIMBUART_CTRL);
> 
> This is not completely correct. CTS is a read only bit and we are to
> stop signal RTS. So the line should look like:
> iowrite8(0, port->membase + TIMBUART_CTRL);

It appears as if this will also unset TIMBUART_CTRL_CTS (which is
probably ok since it's read-only) but TIMBUART_CTRL_FLSHTX and
TIMBUART_CTRL_FLSHRX as well. If undesired we need something like this:

iowrite8(ioread8(port->membase + TIMBUART_CTRL) & ~TIMBUART_CTRL_RTS,
	port->membase + TIMBUART_CTRL);

If not required I'll send the patch as you suggested.

Regards, Roel
