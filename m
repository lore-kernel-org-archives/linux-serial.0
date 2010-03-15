From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@pelagicore.com>
Subject: Re: [PATCH] serial: Two branches the same in timbuart_set_mctrl()
Date: Mon, 15 Mar 2010 14:41:46 +0100
Message-ID: <4B9E391A.5050808@pelagicore.com>
References: <4B532CF5.7080000@gmail.com> <20100117181702.026269e9@lxorguk.ukuu.org.uk> <4B535ED8.2050703@gmail.com> <4B9E0160.5000900@pelagicore.com> <4B9E3747.9060400@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4B9E3747.9060400@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-serial@vger.kernel.org

On 03/15/2010 02:33 PM, Roel Kluin wrote:
> Hi Richard,
>
>>>        if (mctrl&   TIOCM_RTS)
>>>            iowrite8(TIMBUART_CTRL_RTS, port->membase + TIMBUART_CTRL);
>>>        else
>>> -        iowrite8(TIMBUART_CTRL_RTS, port->membase + TIMBUART_CTRL);
>>> +        iowrite8(TIMBUART_CTRL_CTS, port->membase + TIMBUART_CTRL);
>>
>> This is not completely correct. CTS is a read only bit and we are to
>> stop signal RTS. So the line should look like:
>> iowrite8(0, port->membase + TIMBUART_CTRL);
>
> It appears as if this will also unset TIMBUART_CTRL_CTS (which is
> probably ok since it's read-only) but TIMBUART_CTRL_FLSHTX and
> TIMBUART_CTRL_FLSHRX as well.

TIMBUART_CTRL_FLSH(RX/TX) are write only bits, writing a 1 to these will
flush the corresponding FIFO. In this case we should not flush the FIFO:s,
so writing 0 as I suggested is correct.

>
> If not required I'll send the patch as you suggested.

Great! Thanks!

--Richard
