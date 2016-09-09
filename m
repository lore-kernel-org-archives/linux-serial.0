From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH 3/3] tty/serial: at91: fix hardware handshake when DMA is
 not used
Date: Fri, 9 Sep 2016 18:00:17 +0200
Message-ID: <CACQ1gAj1wWVV9fDA2ZJ6Q0OGFNB3Ud78-MoHyN7_e8=8rfaWEQ@mail.gmail.com>
References: <20160907161324.27774-1-richard.genoud@gmail.com>
 <20160907161324.27774-3-richard.genoud@gmail.com> <15e0dbe0-6636-6bec-9622-be00056dae5e@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <15e0dbe0-6636-6bec-9622-be00056dae5e@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

Hi Alex, Cyrille,


I did some tests to clear this HW handcheck history out.
NB: all those tests are with a 4.8-rc5 kernel on a AT91SAM9G35-CM board.

I couldn't test the PDC since, as Cyrille said, there's no such thing on
SAM9G35 USARTs.

The modes that DON'T WORK are:
ATMEL_US_USMODE_HWHS + DMA (RTS won't go up when the data are not read anymore)
ATMEL_US_USMODE_HWHS + PIO (RTS won't even go down when the port is open)

The modes that WORK are:
ATMEL_US_USMODE_NORMAL + DMA (no error, perfect transfer)
ATMEL_US_USMODE_NORMAL + PIO (some chars are eaten or nullified)


So, it seems that Atmel HW's guys where right when they said that the
HW handshake is completely broken on SAM9x5 (updating the manual with a
note saying that ATMEL_US_USMODE_HWHS shouldn't be use would be a good
idea !).

2016-09-07 18:59 GMT+02:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> Hi,
>
> You forgot that the PDC can properly drive the RTS pin so all the
> platforms that are using the PDC will break after your patch.
You're right, I missed the platforms with PDC.
But right know, all SAM9x5 platforms are broken (and I guess SAM92xx
also), so I guess we'll find a way to correct that.

> Also, I believe the controller is able to drive the RTS and CTS pins
> when simply using PIOs (it knows when one complete character has been
> received and US_RHR has not yet been read). However, I didn't test.
> Maybe someone at Atmel can confirm.
I did see anything like that in SAM9G35 datasheet, and the tests I've done show
the contrary.
Actually, in SAM9G35 datasheet:
"When a character reception is completed, it is transferred to the
Receive Holding register (US_RHR) and the RXRDY bit in US_CSR rises.
If a character is completed while the RXRDY is set, the OVRE
(Overrun Error) bit is set.
The last character is transferred into US_RHR and overwrites the previous one."

> I think that 5be605ac9af9 is doing the right thing but I still can be
> convince otherwise ;).
I'll get to that.

2016-09-07 19:28 GMT+02:00 Cyrille Pitchen <cyrille.pitchen@atmel.com>:
> Hi Richard,
>
> For usart without FIFOs (hence before sama5d2), according to our designers, the
> RTS line could only been controlled by an internal PDC signal which doesn't
> exist with the DMA controller. Referring to its datasheet, the sam9g35 embeds
> DMA controllers. So if you enable the hardware handshaking feature on some
> usart, its RTS line won't be monitored at all. The hardware handshaking is
> broken on all SoCs using DMA controllers instead of PDC.
>
> With the sama5d2, our latest MPU, we fixed this issue by introducing an
> alternative mechanism which relies on 2 thresholds on the RX FIFO. So when
> FIFOs are available, those thresholds can be used to control the level of RTS
> line.
>
> Indeed I think a better test should be:
> if (!atmel_use_pdc_rx(port) && !atmel_use_fifo(port)) {
>         dev_info(port->dev, "not enabling hardware flow control
>         because neither the PDC nor the FIFO are available");
>         termios->c_cflags &= ~CRTSCTS;
> }
Maybe that's ok for SAMAD2+ platform, but not for older ones.
Actually, from all the tests I've done, the only mode that works for
SAM9x5 is:
mode |= ATMEL_US_USMODE_NORMAL;
and the CRTSCTS flag should *NOT* be removed.

So, IHMO, test should be:

if (atmel_use_pdc_rx(port) || atmel_use_fifo(port)) {
    mode |= ATMEL_US_USMODE_HWHS;
} else {
    mode |= ATMEL_US_USMODE_NORMAL;
}

Because nothing prevents the driver to drive the RTS pin itself, as it
is done in atmel_set_mctrl().
So, IHMO, commit 5be605ac9af9 is all wrong.
It basically says "If the controller can't handle RTS/CTS, then we don't
do HW handshake."
NO ! If the controller can't do it, the driver can do it for him, can't it ?!
(Well, from here, it truly seems it can !)


If you want to grab an atmel board and a scope to do some testing,
here's what I've done:

On one side:
stty -F /dev/ttyS2 115200 crtscts -opost clocal cread
exec 3>/dev/ttyS2
dd if=/home/rgenoud/dev/linux/MAINTAINERS bs=1M count=1 > /dev/ttyS2
exec 3>&-

On the board:
stty -F /dev/ttyS1 115200 crtscts -opost clocal cread
exec 4</dev/ttyS1
rm -f /tmp/rcv
cat <&4 >> /tmp/rcv
# then ctrl-C, and "cat <&4 >> /tmp/rcv" again
# at the ctrl-C, the RTS pin should go up

To enable dma in sam9x5 dts, I added
atmel,use-dma-rx;
in usart0: serial@f801c000


>
> We can double check once again with our designers to confirm that without FIFO
> the only way for the hardware handshaking to work is to use a PDC.
> So IMHO, your patch should not be applied, sorry!
>
> Best regards,
>
> Cyrille
>

Best regards.
Richard.
