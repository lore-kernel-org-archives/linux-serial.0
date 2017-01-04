From: Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: imx: RS-485 problems during TX, maybe DMA related
Date: Wed, 4 Jan 2017 17:00:24 +0100
Message-ID: <20170104160024.GA13442@archie.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Nandor Han <nandor.han@ge.com>, Lucas Stach <l.stach@pengutronix.de>, Fabio Estevam <fabio.estevam@freescale.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

I observed odd behavior of the current tty/serial/imx.c driver in RS-485
mode.

RX works fine, but TX does not: When sending data, it arrives multiple
times and with data from previous transmissions at the end, after a
delay.

# My setup

Hardware:
i.MX6Q board with UARTn_RX_DATA, _TX_DATA and _CTS_B connected to a
RS-485 half-duplex transceiver (Exar SP3082E), pins RXD, TXD and DE
respectively. (DE is active-high, _CTS_B is inverted on the board)
I am using an external USB-to-RS-485 converter connected to my PC to
conduct the tests.

Firmware:
I tried both the original ROM SDMA scripts and also the RAM scripts from
Freescale (placed in firmware/imx), but there was no difference, except
for a DMA transaction error message going away (appeared when writing too
much data too fast into a device configured with too low baud rate).
So I switched back to the pure mainline 4.9 kernel with SDMA using the
scripts from ROM.

Software:
Mainline Linux 4.9 with serial_rs485 flags: rs485 (SER_RS485_ENABLED),
-rs485rtsonsend (~SER_RS485_RTS_ON_SEND), rs485rtsaftersend and
rs485rxduringtx. I only enabled rs485rxduringtx, because otherwise it
would not work at all. But I am still unsure why it is needed for
half-duplex RS-485.

# The tests

1) On the board: echo A > /dev/ttymxc4
2) On my PC: A \n A \n appears immediately
             (about 4s delay)
             A \n
             (about 4s delay)
             A \n

Kernel log on the board:
[   29.059983] imx-uart 21f4000.serial: TX: prepare to send 2 bytes by DMA.
[   29.067166] imx-uart 21f4000.serial: we finish the TX DMA.
[   29.073057] imx-uart 21f4000.serial: TX: prepare to send 4094 bytes by DMA.
[   33.359405] imx-uart 21f4000.serial: we finish the TX DMA.
[   33.365173] imx-uart 21f4000.serial: TX: prepare to send 4072 bytes by DMA.
[   37.603551] imx-uart 21f4000.serial: we finish the TX DMA.

3) On the board: echo B > /dev/ttymxc4
4) On my PC: B \n B \n appears immediately
             (about 4s delay)
             A \n B \n
             (about 4s delay)
             A \n B \n
Kernel log:
[   66.000296] imx-uart 21f4000.serial: TX: prepare to send 2 bytes by DMA.
[   66.007110] imx-uart 21f4000.serial: we finish the TX DMA.
[   66.012841] imx-uart 21f4000.serial: TX: prepare to send 4094 bytes by DMA.
[   70.297051] imx-uart 21f4000.serial: we finish the TX DMA.
[   70.302798] imx-uart 21f4000.serial: TX: prepare to send 4072 bytes by DMA.
[   74.539094] imx-uart 21f4000.serial: we finish the TX DMA.

And so on..
( If I continue with a echo C > /dev/ttymxc4, the last characters are
  A \n B \n C )

--

To illustrate the behavior, I recorded the signals on the transceiver
pins with a logic analyzer:
https://pqgruber.com/rs485_results.png
I triggered only on the raising and on the falling edge of DE, so I only
captured the first and the last characters for the first two tests and
not all three events per test.

I also enabled the DMA debug options in the kernel if that is helpful,
here is the full log during the two tests:
https://gist.github.com/clemensg/1ac5ee8a8ea32acc9145c5aa8407aea5

--

Do you have an idea, what's wrong here?

Also: If you are using RS-485 with the imx driver on a recent kernel,
please let me know if it is working for you and if you can reproduce the
behavior.

Thanks,
Clemens

--

PS:

Because I assumed that the error has something to do with DMA, I
commented out the call to imx_uart_dma_init.
Then, transmitting and receiving data over RS-485 works! Verified with
the logic analyzer and the RS-485-to-USB adapter.

However, if trying to send large amounts of data in a short time,
sometimes I get an "Unhandled fault: imprecise external abort (0x1406)".
But the back trace is not very helpful and probably not related
(it is different every time), the last time I tried, the PC was at
_raw_spin_unlock_irqrestore, called from hrtimer_start_range_ns.
