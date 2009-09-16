From: Sonic Zhang <sonic.adi@gmail.com>
Subject: Re: [PATCH] [uart] Fit blackfin uart over sport driver into common
	uart inftrastructure
Date: Wed, 16 Sep 2009 17:47:29 +0800
Message-ID: <4e5ebad50909160247v5b6e241bs85601535153885de@mail.gmail.com>
References: <1253093935.25791.3.camel@eight.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yx0-f171.google.com ([209.85.210.171]:47404 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752060AbZIPJr0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Sep 2009 05:47:26 -0400
In-Reply-To: <1253093935.25791.3.camel@eight.analog.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

Sorry, I made a mistake when generate the patch. Please ignore this
email. I will send out v2 soon.

Sonic Zhang

On Wed, Sep 16, 2009 at 5:38 PM, sonic zhang <sonic.adi@gmail.com> wrot=
e:
> Fit blackfin uart over sport driver into common uart inftrastructure.
>
> 1. Disable local interrupts in 32-bit reading from SPORT RX MMR to wa=
lk
> around the RX underflow hardware issue when this reading is interrupt=
ed
> by the other IRQ.
>
> 2. Enable sport uart driver to change uart baud, data bit, stop bit a=
t
> runtime.
>
> 3. Move most platform data into arch specific board files.
>
> 4. Console is registered in sport uart driver as well.
>
> 5. Remove 500 us block waiting in sport tx stop code by putting a dum=
my
> data into tx fifo to make sure the sport tx stops when all bytes are
> shifted out except for the dummy data.
>
> 6. clean up a bit and fix up coding style.
>
>
>
> Signed-off-by: Michael Frysinger <michael.frysinger@analog.com>
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> ---
> =A0drivers/serial/Kconfig =A0 =A0 =A0 =A0 =A0 | =A0 40 +---
> =A0drivers/serial/bfin_sport_uart.c | =A0548 ++++++++++++++++++++++++=
+-------------
> =A0drivers/serial/bfin_sport_uart.h | =A0 18 ++-
> =A03 files changed, 391 insertions(+), 215 deletions(-)
>
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 03422ce..5e30494 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -1409,8 +1409,8 @@ config SERIAL_SC26XX_CONSOLE
> =A0 =A0 =A0 =A0 =A0Support for Console on SC2681/SC2692 serial ports.
>
> =A0config SERIAL_BFIN_SPORT
> - =A0 =A0 =A0 tristate "Blackfin SPORT emulate UART (EXPERIMENTAL)"
> - =A0 =A0 =A0 depends on BLACKFIN && EXPERIMENTAL
> + =A0 =A0 =A0 tristate "Blackfin SPORT emulate UART"
> + =A0 =A0 =A0 depends on BLACKFIN
> =A0 =A0 =A0 =A0select SERIAL_CORE
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Enable SPORT emulate UART on Blackfin series.
> @@ -1418,38 +1418,10 @@ config SERIAL_BFIN_SPORT
> =A0 =A0 =A0 =A0 =A0To compile this driver as a module, choose M here:=
 the
> =A0 =A0 =A0 =A0 =A0module will be called bfin_sport_uart.
>
> -choice
> - =A0 =A0 =A0 prompt "Baud rate for Blackfin SPORT UART"
> - =A0 =A0 =A0 depends on SERIAL_BFIN_SPORT
> - =A0 =A0 =A0 default SERIAL_SPORT_BAUD_RATE_57600
> - =A0 =A0 =A0 help
> - =A0 =A0 =A0 =A0 Choose a baud rate for the SPORT UART, other uart s=
ettings are
> - =A0 =A0 =A0 =A0 8 bit, 1 stop bit, no parity, no flow control.
> -
> -config SERIAL_SPORT_BAUD_RATE_115200
> - =A0 =A0 =A0 bool "115200"
> -
> -config SERIAL_SPORT_BAUD_RATE_57600
> - =A0 =A0 =A0 bool "57600"
> -
> -config SERIAL_SPORT_BAUD_RATE_38400
> - =A0 =A0 =A0 bool "38400"
> -
> -config SERIAL_SPORT_BAUD_RATE_19200
> - =A0 =A0 =A0 bool "19200"
> -
> -config SERIAL_SPORT_BAUD_RATE_9600
> - =A0 =A0 =A0 bool "9600"
> -endchoice
> -
> -config SPORT_BAUD_RATE
> - =A0 =A0 =A0 int
> - =A0 =A0 =A0 depends on SERIAL_BFIN_SPORT
> - =A0 =A0 =A0 default 115200 if (SERIAL_SPORT_BAUD_RATE_115200)
> - =A0 =A0 =A0 default 57600 if (SERIAL_SPORT_BAUD_RATE_57600)
> - =A0 =A0 =A0 default 38400 if (SERIAL_SPORT_BAUD_RATE_38400)
> - =A0 =A0 =A0 default 19200 if (SERIAL_SPORT_BAUD_RATE_19200)
> - =A0 =A0 =A0 default 9600 if (SERIAL_SPORT_BAUD_RATE_9600)
> +config SERIAL_BFIN_SPORT_CONSOLE
> + =A0 =A0 =A0 bool "Console on Blackfin sport emulated uart"
> + =A0 =A0 =A0 depends on SERIAL_BFIN_SPORT=3Dy
> + =A0 =A0 =A0 select SERIAL_CORE_CONSOLE
>
> =A0config SERIAL_TIMBERDALE
> =A0 =A0 =A0 =A0tristate "Support for timberdale UART"
> diff --git a/drivers/serial/bfin_sport_uart.c b/drivers/serial/bfin_s=
port_uart.c
> index c108b1a..68d4c55 100644
> --- a/drivers/serial/bfin_sport_uart.c
> +++ b/drivers/serial/bfin_sport_uart.c
> @@ -1,27 +1,11 @@
> =A0/*
> - * File: =A0 =A0 =A0 linux/drivers/serial/bfin_sport_uart.c
> + * Blackfin On-Chip Sport Emulated UART Driver
> =A0*
> - * Based on: =A0 drivers/serial/bfin_5xx.c by Aubrey Li.
> - * Author: =A0 =A0 Roy Huang <roy.huang@analog.com>
> + * Copyright 2006-2009 Analog Devices Inc.
> =A0*
> - * Created: =A0 =A0Nov 22, 2006
> - * Copyright: =A0(c) 2006-2007 Analog Devices Inc.
> - * Description: this driver enable SPORTs on Blackfin emulate UART.
> + * Enter bugs at http://blackfin.uclinux.org/
> =A0*
> - * This program is free software; you can redistribute it and/or mod=
ify
> - * it under the terms of the GNU General Public License as published=
 by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
> - * GNU General Public License for more details.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, see the file COPYING, or write
> - * to the Free Software Foundation, Inc.,
> - * 51 Franklin St, Fifth Floor, Boston, MA =A002110-1301 =A0USA
> + * Licensed under the GPL-2 or later.
> =A0*/
>
> =A0/*
> @@ -29,36 +13,13 @@
> =A0* http://www.analog.com/UploadedFiles/Application_Notes/399447663E=
E191.pdf
> =A0* This application note describe how to implement a UART on a Shar=
c DSP,
> =A0* but this driver is implemented on Blackfin Processor.
> + * Transmit Frame Sync is not used by this driver to transfer data o=
ut.
> =A0*/
>
> -/* After reset, there is a prelude of low level pulse when transmit =
data first
> - * time. No addtional pulse in following transmit.
> - * According to document:
> - * The SPORTs are ready to start transmitting or receiving data no l=
ater than
> - * three serial clock cycles after they are enabled in the SPORTx_TC=
R1 or
> - * SPORTx_RCR1 register. No serial clock cycles are lost from this p=
oint on.
> - * The first internal frame sync will occur one frame sync delay aft=
er the
> - * SPORTs are ready. External frame syncs can occur as soon as the S=
PORT is
> - * ready.
> - */
> +/* #define DEBUG */
>
> -/* Thanks to Axel Alatalo <axel@rubico.se> for fixing sport rx bug. =
Sometimes
> - * sport receives data incorrectly. The following is Axel's words.
> - * As EE-191, sport rx samples 3 times of the UART baudrate and take=
s the
> - * middle smaple of every 3 samples as the data bit. For a 8-N-1 UAR=
T setting,
> - * 30 samples will be required for a byte. If transmitter sends a 1/=
3 bit short
> - * byte due to buadrate drift, then the 30th sample of a byte, this =
sample is
> - * also the third sample of the stop bit, will happens on the immedi=
ately
> - * following start bit which will be thrown away and missed. Thus si=
nce parts
> - * of the startbit will be missed and the receiver will begin to dri=
ft, the
> - * effect accumulates over time until synchronization is lost.
> - * If only require 2 samples of the stopbit (by sampling in total 29=
 samples),
> - * then a to short byte as in the case above will be tolerated. Then=
 the 1/3
> - * early startbit will trigger a framesync since the last read is co=
mplete
> - * after only 2/3 stopbit and framesync is active during the last 1/=
3 looking
> - * for a possible early startbit. */
> -
> -//#define DEBUG
> +#define DRV_NAME "bfin-sport-uart"
> +#define DEVICE_NAME =A0 =A0"ttySS"
>
> =A0#include <linux/module.h>
> =A0#include <linux/ioport.h>
> @@ -83,8 +44,6 @@ unsigned short bfin_uart_pin_req_sport1[] =3D
> =A0 =A0 =A0 =A0{P_SPORT1_TFS, P_SPORT1_DTPRI, P_SPORT1_TSCLK, P_SPORT=
1_RFS, \
> =A0 =A0 =A0 =A0P_SPORT1_DRPRI, P_SPORT1_RSCLK, P_SPORT1_DRSEC, P_SPOR=
T1_DTSEC, 0};
>
> -#define DRV_NAME "bfin-sport-uart"
> -
> =A0struct sport_uart_port {
> =A0 =A0 =A0 =A0struct uart_port =A0 =A0 =A0 =A0port;
> =A0 =A0 =A0 =A0char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*name;
> @@ -92,6 +51,12 @@ struct sport_uart_port {
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_irq;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rx_irq;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err_irq;
> + =A0 =A0 =A0 unsigned short =A0 =A0 =A0 =A0 =A0csize;
> + =A0 =A0 =A0 unsigned short =A0 =A0 =A0 =A0 =A0rxmask;
> + =A0 =A0 =A0 unsigned short =A0 =A0 =A0 =A0 =A0txmask1;
> + =A0 =A0 =A0 unsigned short =A0 =A0 =A0 =A0 =A0txmask2;
> + =A0 =A0 =A0 unsigned char =A0 =A0 =A0 =A0 =A0 stopb;
> +/* =A0 =A0 unsigned char =A0 =A0 =A0 =A0 =A0 parib; */
> =A0};
>
> =A0static void sport_uart_tx_chars(struct sport_uart_port *up);
> @@ -99,36 +64,42 @@ static void sport_stop_tx(struct uart_port *port)=
;
>
> =A0static inline void tx_one_byte(struct sport_uart_port *up, unsigne=
d int value)
> =A0{
> - =A0 =A0 =A0 pr_debug("%s value:%x\n", __func__, value);
> - =A0 =A0 =A0 /* Place a Start and Stop bit */
> + =A0 =A0 =A0 pr_debug("%s value:%x, mask1=3D0x%x, mask2=3D0x%x\n", _=
_func__, value,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->txmask1, up->txmask2);
> +
> + =A0 =A0 =A0 /* Place Start and Stop bits */
> =A0 =A0 =A0 =A0__asm__ __volatile__ (
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "R2 =3D b#01111111100;"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "R3 =3D b#10000000001;"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%0 <<=3D 2;"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%0 =3D %0 & R2;"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%0 =3D %0 | R3;"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 : "=3Dd"(value)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 : "d"(value)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 : "ASTAT", "R2", "R3"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%[val] <<=3D 1;"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%[val] =3D %[val] & %[mask1];"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%[val] =3D %[val] | %[mask2];"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 : [val]"+d"(value)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 : [mask1]"d"(up->txmask1), [mask2]"d"(u=
p->txmask2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 : "ASTAT"
> =A0 =A0 =A0 =A0);
> =A0 =A0 =A0 =A0pr_debug("%s value:%x\n", __func__, value);
>
> =A0 =A0 =A0 =A0SPORT_PUT_TX(up, value);
> =A0}
>
> -static inline unsigned int rx_one_byte(struct sport_uart_port *up)
> +static inline unsigned char rx_one_byte(struct sport_uart_port *up)
> =A0{
> - =A0 =A0 =A0 unsigned int value, extract;
> + =A0 =A0 =A0 unsigned int value;
> + =A0 =A0 =A0 unsigned char extract;
> =A0 =A0 =A0 =A0u32 tmp_mask1, tmp_mask2, tmp_shift, tmp;
>
> - =A0 =A0 =A0 value =3D SPORT_GET_RX32(up);
> - =A0 =A0 =A0 pr_debug("%s value:%x\n", __func__, value);
> + =A0 =A0 =A0 if ((up->csize + up->stopb) > 7)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D SPORT_GET_RX32(up);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D SPORT_GET_RX(up);
> +
> + =A0 =A0 =A0 pr_debug("%s value:%x, cs=3D%d, mask=3D0x%x\n", __func_=
_, value,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->csize, up->rxmask);
>
> - =A0 =A0 =A0 /* Extract 8 bits data */
> + =A0 =A0 =A0 /* Extract data */
> =A0 =A0 =A0 =A0__asm__ __volatile__ (
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%[extr] =3D 0;"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%[mask1] =3D 0x1801(Z);"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%[mask2] =3D 0x0300(Z);"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%[mask1] =3D %[rxmask];"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%[mask2] =3D 0x0200(Z);"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%[shift] =3D 0;"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"LSETUP(.Lloop_s, .Lloop_e) LC0 =3D %[=
lc];"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0".Lloop_s:"
> @@ -138,9 +109,9 @@ static inline unsigned int rx_one_byte(struct spo=
rt_uart_port *up)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%[mask1] =3D %[mask1] - %[mask2];"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0".Lloop_e:"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%[shift] +=3D 1;"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 : [val]"=3Dd"(value), [extr]"=3Dd"(extr=
act), [shift]"=3Dd"(tmp_shift), [tmp]"=3Dd"(tmp),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [mask1]"=3Dd"(tmp_mask1), [mask2]"=3D=
d"(tmp_mask2)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 : "d"(value), [lc]"a"(8)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 : [extr]"=3D&d"(extract), [shift]"=3D&d=
"(tmp_shift), [tmp]"=3D&d"(tmp),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [mask1]"=3D&d"(tmp_mask1), [mask2]"=
=3D&d"(tmp_mask2)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 : [val]"d"(value), [rxmask]"d"(up->rxma=
sk), [lc]"a"(up->csize)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: "ASTAT", "LB0", "LC0", "LT0"
> =A0 =A0 =A0 =A0);
>
> @@ -148,29 +119,28 @@ static inline unsigned int rx_one_byte(struct s=
port_uart_port *up)
> =A0 =A0 =A0 =A0return extract;
> =A0}
>
> -static int sport_uart_setup(struct sport_uart_port *up, int sclk, in=
t baud_rate)
> +static int sport_uart_setup(struct sport_uart_port *up, int size, in=
t baud_rate)
> =A0{
> - =A0 =A0 =A0 int tclkdiv, tfsdiv, rclkdiv;
> + =A0 =A0 =A0 int tclkdiv, rclkdiv;
> + =A0 =A0 =A0 unsigned int sclk =3D get_sclk();
>
> - =A0 =A0 =A0 /* Set TCR1 and TCR2 */
> - =A0 =A0 =A0 SPORT_PUT_TCR1(up, (LATFS | ITFS | TFSR | TLSBIT | ITCL=
K));
> - =A0 =A0 =A0 SPORT_PUT_TCR2(up, 10);
> + =A0 =A0 =A0 /* Set TCR1 and TCR2, TFSR is not enabled for uart */
> + =A0 =A0 =A0 SPORT_PUT_TCR1(up, (ITFS | TLSBIT | ITCLK));
> + =A0 =A0 =A0 SPORT_PUT_TCR2(up, size + 1);
> =A0 =A0 =A0 =A0pr_debug("%s TCR1:%x, TCR2:%x\n", __func__, SPORT_GET_=
TCR1(up), SPORT_GET_TCR2(up));
>
> =A0 =A0 =A0 =A0/* Set RCR1 and RCR2 */
> =A0 =A0 =A0 =A0SPORT_PUT_RCR1(up, (RCKFE | LARFS | LRFS | RFSR | IRCL=
K));
> - =A0 =A0 =A0 SPORT_PUT_RCR2(up, 28);
> + =A0 =A0 =A0 SPORT_PUT_RCR2(up, (size + 1) * 2 - 1);
> =A0 =A0 =A0 =A0pr_debug("%s RCR1:%x, RCR2:%x\n", __func__, SPORT_GET_=
RCR1(up), SPORT_GET_RCR2(up));
>
> =A0 =A0 =A0 =A0tclkdiv =3D sclk/(2 * baud_rate) - 1;
> - =A0 =A0 =A0 tfsdiv =3D 12;
> - =A0 =A0 =A0 rclkdiv =3D sclk/(2 * baud_rate * 3) - 1;
> + =A0 =A0 =A0 rclkdiv =3D sclk/(2 * baud_rate * 2) - 1;
> =A0 =A0 =A0 =A0SPORT_PUT_TCLKDIV(up, tclkdiv);
> - =A0 =A0 =A0 SPORT_PUT_TFSDIV(up, tfsdiv);
> =A0 =A0 =A0 =A0SPORT_PUT_RCLKDIV(up, rclkdiv);
> =A0 =A0 =A0 =A0SSYNC();
> - =A0 =A0 =A0 pr_debug("%s sclk:%d, baud_rate:%d, tclkdiv:%d, tfsdiv:=
%d, rclkdiv:%d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, sclk, baud_ra=
te, tclkdiv, tfsdiv, rclkdiv);
> + =A0 =A0 =A0 pr_debug("%s sclk:%d, baud_rate:%d, tclkdiv:%d, rclkdiv=
:%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, sclk, baud_ra=
te, tclkdiv, rclkdiv);
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -181,23 +151,29 @@ static irqreturn_t sport_uart_rx_irq(int irq, v=
oid *dev_id)
> =A0 =A0 =A0 =A0struct tty_struct *tty =3D up->port.info->port.tty;
> =A0 =A0 =A0 =A0unsigned int ch;
>
> - =A0 =A0 =A0 do {
> + =A0 =A0 =A0 spin_lock(&up->port.lock);
> +
> + =A0 =A0 =A0 while (SPORT_GET_STAT(up) & RXNE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ch =3D rx_one_byte(up);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up->port.icount.rx++;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (uart_handle_sysrq_char(&up->port, c=
h))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!uart_handle_sysrq_char(&up->port, =
ch))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tty_insert_flip_char(t=
ty, ch, TTY_NORMAL);
> - =A0 =A0 =A0 } while (SPORT_GET_STAT(up) & RXNE);
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0tty_flip_buffer_push(tty);
>
> + =A0 =A0 =A0 spin_unlock(&up->port.lock);
> +
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
>
> =A0static irqreturn_t sport_uart_tx_irq(int irq, void *dev_id)
> =A0{
> - =A0 =A0 =A0 sport_uart_tx_chars(dev_id);
> + =A0 =A0 =A0 struct sport_uart_port *up =3D dev_id;
> +
> + =A0 =A0 =A0 spin_lock(&up->port.lock);
> + =A0 =A0 =A0 sport_uart_tx_chars(up);
> + =A0 =A0 =A0 spin_unlock(&up->port.lock);
>
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
> @@ -208,6 +184,8 @@ static irqreturn_t sport_uart_err_irq(int irq, vo=
id *dev_id)
> =A0 =A0 =A0 =A0struct tty_struct *tty =3D up->port.info->port.tty;
> =A0 =A0 =A0 =A0unsigned int stat =3D SPORT_GET_STAT(up);
>
> + =A0 =A0 =A0 spin_lock(&up->port.lock);
> +
> =A0 =A0 =A0 =A0/* Overflow in RX FIFO */
> =A0 =A0 =A0 =A0if (stat & ROVF) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up->port.icount.overrun++;
> @@ -216,15 +194,16 @@ static irqreturn_t sport_uart_err_irq(int irq, =
void *dev_id)
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0/* These should not happen */
> =A0 =A0 =A0 =A0if (stat & (TOVF | TUVF | RUVF)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "SPORT Error:%s %s %s\n=
",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (stat &=
 TOVF)?"TX overflow":"",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (stat &=
 TUVF)?"TX underflow":"",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (stat &=
 RUVF)?"RX underflow":"");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("SPORT Error:%s %s %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(stat & TOVF) ? "TX over=
flow" : "",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(stat & TUVF) ? "TX unde=
rflow" : "",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(stat & RUVF) ? "RX unde=
rflow" : "");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SPORT_PUT_TCR1(up, SPORT_GET_TCR1(up) =
& ~TSPEN);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SPORT_PUT_RCR1(up, SPORT_GET_RCR1(up) =
& ~RSPEN);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0SSYNC();
>
> + =A0 =A0 =A0 spin_unlock(&up->port.lock);
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
>
> @@ -232,60 +211,37 @@ static irqreturn_t sport_uart_err_irq(int irq, =
void *dev_id)
> =A0static int sport_startup(struct uart_port *port)
> =A0{
> =A0 =A0 =A0 =A0struct sport_uart_port *up =3D (struct sport_uart_port=
 *)port;
> - =A0 =A0 =A0 char buffer[20];
> - =A0 =A0 =A0 int retval;
> + =A0 =A0 =A0 int ret;
>
> =A0 =A0 =A0 =A0pr_debug("%s enter\n", __func__);
> - =A0 =A0 =A0 snprintf(buffer, 20, "%s rx", up->name);
> - =A0 =A0 =A0 retval =3D request_irq(up->rx_irq, sport_uart_rx_irq, I=
RQF_SAMPLE_RANDOM, buffer, up);
> - =A0 =A0 =A0 if (retval) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to request inte=
rrupt %s\n", buffer);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return retval;
> + =A0 =A0 =A0 ret =3D request_irq(up->port.irq, sport_uart_rx_irq, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "SPORT_UART_RX", up);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(port->dev, "unable to request S=
PORT RX interrupt\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 snprintf(buffer, 20, "%s tx", up->name);
> - =A0 =A0 =A0 retval =3D request_irq(up->tx_irq, sport_uart_tx_irq, I=
RQF_SAMPLE_RANDOM, buffer, up);
> - =A0 =A0 =A0 if (retval) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to request inte=
rrupt %s\n", buffer);
> + =A0 =A0 =A0 ret =3D request_irq(up->port.irq+1, sport_uart_tx_irq, =
0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "SPORT_UART_TX", up);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(port->dev, "unable to request S=
PORT TX interrupt\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail1;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 snprintf(buffer, 20, "%s err", up->name);
> - =A0 =A0 =A0 retval =3D request_irq(up->err_irq, sport_uart_err_irq,=
 IRQF_SAMPLE_RANDOM, buffer, up);
> - =A0 =A0 =A0 if (retval) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to request inte=
rrupt %s\n", buffer);
> + =A0 =A0 =A0 ret =3D request_irq(up->err_irq, sport_uart_err_irq, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "SPORT_UART_STATUS", up);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(port->dev, "unable to request S=
PORT status interrupt\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail2;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (port->line) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (peripheral_request_list(bfin_uart_p=
in_req_sport1, DRV_NAME))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail3;
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (peripheral_request_list(bfin_uart_p=
in_req_sport0, DRV_NAME))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail3;
> - =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 sport_uart_setup(up, get_sclk(), port->uartclk);
> -
> - =A0 =A0 =A0 /* Enable receive interrupt */
> - =A0 =A0 =A0 SPORT_PUT_RCR1(up, (SPORT_GET_RCR1(up) | RSPEN));
> - =A0 =A0 =A0 SSYNC();
> -
> =A0 =A0 =A0 =A0return 0;
> + fail2:
> + =A0 =A0 =A0 free_irq(up->port.irq+1, up);
> + fail1:
> + =A0 =A0 =A0 free_irq(up->port.irq, up);
>
> -
> -fail3:
> - =A0 =A0 =A0 printk(KERN_ERR DRV_NAME
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ": Requesting Peripherals failed\n");
> -
> - =A0 =A0 =A0 free_irq(up->err_irq, up);
> -fail2:
> - =A0 =A0 =A0 free_irq(up->tx_irq, up);
> -fail1:
> - =A0 =A0 =A0 free_irq(up->rx_irq, up);
> -
> - =A0 =A0 =A0 return retval;
> -
> + =A0 =A0 =A0 return ret;
> =A0}
>
> =A0static void sport_uart_tx_chars(struct sport_uart_port *up)
> @@ -344,20 +300,17 @@ static void sport_set_mctrl(struct uart_port *p=
ort, unsigned int mctrl)
> =A0static void sport_stop_tx(struct uart_port *port)
> =A0{
> =A0 =A0 =A0 =A0struct sport_uart_port *up =3D (struct sport_uart_port=
 *)port;
> - =A0 =A0 =A0 unsigned int stat;
>
> =A0 =A0 =A0 =A0pr_debug("%s enter\n", __func__);
>
> - =A0 =A0 =A0 stat =3D SPORT_GET_STAT(up);
> - =A0 =A0 =A0 while(!(stat & TXHRE)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 stat =3D SPORT_GET_STAT(up);
> - =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0/* Although the hold register is empty, last byte is s=
till in shift
> - =A0 =A0 =A0 =A0* register and not sent out yet. If baud rate is low=
er than default,
> - =A0 =A0 =A0 =A0* delay should be longer. For example, if the baud r=
ate is 9600,
> - =A0 =A0 =A0 =A0* the delay must be at least 2ms by experience */
> - =A0 =A0 =A0 udelay(500);
> + =A0 =A0 =A0 =A0* register and not sent out yet. So, put a dummy dat=
a into TX FIFO.
> + =A0 =A0 =A0 =A0* Then, sport tx stops when last byte is shift out a=
nd the dummy
> + =A0 =A0 =A0 =A0* data is moved into the shift register.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 SPORT_PUT_TX(up, 0xffff);
> + =A0 =A0 =A0 while (!(SPORT_GET_STAT(up) & TXHRE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
>
> =A0 =A0 =A0 =A0SPORT_PUT_TCR1(up, (SPORT_GET_TCR1(up) & ~TSPEN));
> =A0 =A0 =A0 =A0SSYNC();
> @@ -370,6 +323,7 @@ static void sport_start_tx(struct uart_port *port=
)
> =A0 =A0 =A0 =A0struct sport_uart_port *up =3D (struct sport_uart_port=
 *)port;
>
> =A0 =A0 =A0 =A0pr_debug("%s enter\n", __func__);
> +
> =A0 =A0 =A0 =A0/* Write data into SPORT FIFO before enable SPROT to t=
ransmit */
> =A0 =A0 =A0 =A0sport_uart_tx_chars(up);
>
> @@ -410,24 +364,11 @@ static void sport_shutdown(struct uart_port *po=
rt)
> =A0 =A0 =A0 =A0SPORT_PUT_RCR1(up, (SPORT_GET_RCR1(up) & ~RSPEN));
> =A0 =A0 =A0 =A0SSYNC();
>
> - =A0 =A0 =A0 if (port->line) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 peripheral_free_list(bfin_uart_pin_req_=
sport1);
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 peripheral_free_list(bfin_uart_pin_req_=
sport0);
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0free_irq(up->rx_irq, up);
> =A0 =A0 =A0 =A0free_irq(up->tx_irq, up);
> =A0 =A0 =A0 =A0free_irq(up->err_irq, up);
> =A0}
>
> -static void sport_set_termios(struct uart_port *port,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ktermios *termios, struct ktermi=
os *old)
> -{
> - =A0 =A0 =A0 pr_debug("%s enter, c_cflag:%08x\n", __func__, termios-=
>c_cflag);
> - =A0 =A0 =A0 uart_update_timeout(port, CS8 ,port->uartclk);
> -}
> -
> =A0static const char *sport_type(struct uart_port *port)
> =A0{
> =A0 =A0 =A0 =A0struct sport_uart_port *up =3D (struct sport_uart_port=
 *)port;
> @@ -461,6 +402,110 @@ static int sport_verify_port(struct uart_port *=
port, struct serial_struct *ser)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static void sport_set_termios(struct uart_port *port,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ktermios *termios, struct ktermi=
os *old)
> +{
> + =A0 =A0 =A0 struct sport_uart_port *up =3D (struct sport_uart_port =
*)port;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 int i;
> +
> + =A0 =A0 =A0 pr_debug("%s enter, c_cflag:%08x\n", __func__, termios-=
>c_cflag);
> +
> + =A0 =A0 =A0 switch (termios->c_cflag & CSIZE) {
> + =A0 =A0 =A0 case CS8:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->csize =3D 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case CS7:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->csize =3D 7;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case CS6:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->csize =3D 6;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 case CS5:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->csize =3D 5;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("requested word length not s=
upported\n");
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (termios->c_cflag & CSTOPB) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->stopb =3D 1;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (termios->c_cflag & PARENB) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("PAREN bits is not supported=
 yet\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* up->parib =3D 1; */
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 port->read_status_mask =3D OE;
> + =A0 =A0 =A0 if (termios->c_iflag & INPCK)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->read_status_mask |=3D (FE | PE);
> + =A0 =A0 =A0 if (termios->c_iflag & (BRKINT | PARMRK))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->read_status_mask |=3D BI;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Characters to ignore
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 port->ignore_status_mask =3D 0;
> + =A0 =A0 =A0 if (termios->c_iflag & IGNPAR)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->ignore_status_mask |=3D FE | PE;
> + =A0 =A0 =A0 if (termios->c_iflag & IGNBRK) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->ignore_status_mask |=3D BI;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If we're ignoring parity and break=
 indicators,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* ignore overruns too (for real raw =
support).
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (termios->c_iflag & IGNPAR)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->ignore_status_mas=
k |=3D OE;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* RX extract mask */
> + =A0 =A0 =A0 up->rxmask =3D 0x01 | (((up->csize + up->stopb) * 2 - 1=
) << 0x8);
> + =A0 =A0 =A0 /* TX masks, 8 bit data and 1 bit stop for example:
> + =A0 =A0 =A0 =A0* mask1 =3D b#0111111110
> + =A0 =A0 =A0 =A0* mask2 =3D b#1000000000
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 for (i =3D 0, up->txmask1 =3D 0; i < up->csize; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->txmask1 |=3D (1<<i);
> + =A0 =A0 =A0 up->txmask2 =3D (1<<i);
> + =A0 =A0 =A0 if (up->stopb) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ++i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 up->txmask2 |=3D (1<<i);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 up->txmask1 <<=3D 1;
> + =A0 =A0 =A0 up->txmask2 <<=3D 1;
> + =A0 =A0 =A0 /* uart baud rate */
> + =A0 =A0 =A0 port->uartclk =3D uart_get_baud_rate(port, termios, old=
, 0, get_sclk()/16);
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
> +
> + =A0 =A0 =A0 /* Disable UART */
> + =A0 =A0 =A0 SPORT_PUT_TCR1(up, SPORT_GET_TCR1(up) & ~TSPEN);
> + =A0 =A0 =A0 SPORT_PUT_RCR1(up, SPORT_GET_RCR1(up) & ~RSPEN);
> +
> + =A0 =A0 =A0 sport_uart_setup(up, up->csize + up->stopb, port->uartc=
lk);
> +
> + =A0 =A0 =A0 /* driver TX line high after config, one dummy data is
> + =A0 =A0 =A0 =A0* necessary to stop sport after shift one byte
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 SPORT_PUT_TX(up, 0xffff);
> + =A0 =A0 =A0 SPORT_PUT_TX(up, 0xffff);
> + =A0 =A0 =A0 SPORT_PUT_TCR1(up, (SPORT_GET_TCR1(up) | TSPEN));
> + =A0 =A0 =A0 SSYNC();
> + =A0 =A0 =A0 while (!(SPORT_GET_STAT(up) & TXHRE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
> + =A0 =A0 =A0 SPORT_PUT_TCR1(up, SPORT_GET_TCR1(up) & ~TSPEN);
> + =A0 =A0 =A0 SSYNC();
> +
> + =A0 =A0 =A0 /* Port speed changed, update the per-port timeout. */
> + =A0 =A0 =A0 uart_update_timeout(port, termios->c_cflag, port->uartc=
lk);
> +
> + =A0 =A0 =A0 /* Enable sport rx */
> + =A0 =A0 =A0 SPORT_PUT_RCR1(up, SPORT_GET_RCR1(up) | RSPEN);
> + =A0 =A0 =A0 SSYNC();
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&up->port.lock, flags);
> +}
> +
> =A0struct uart_ops sport_uart_ops =3D {
> =A0 =A0 =A0 =A0.tx_empty =A0 =A0 =A0 =3D sport_tx_empty,
> =A0 =A0 =A0 =A0.set_mctrl =A0 =A0 =A0=3D sport_set_mctrl,
> @@ -487,15 +532,9 @@ static struct sport_uart_port sport_uart_ports[]=
 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.rx_irq =3D IRQ_SPORT0_RX,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.err_irq=3D IRQ_SPORT0_ERROR,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.port =A0 =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0=
 =3D PORT_BFIN_SPORT,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .iotype =A0 =A0 =A0 =A0=
 =3D UPIO_MEM,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.membase =A0 =A0 =A0 =A0=
=3D (void __iomem *)SPORT0_TCR1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.mapbase =A0 =A0 =A0 =A0=
=3D SPORT0_TCR1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.irq =A0 =A0 =A0 =A0 =A0=
 =A0=3D IRQ_SPORT0_RX,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .uartclk =A0 =A0 =A0 =A0=
=3D CONFIG_SPORT_BAUD_RATE,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .fifosize =A0 =A0 =A0 =3D=
 8,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =A0 =A0 =A0 =A0 =A0=
 =A0=3D &sport_uart_ops,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .line =A0 =A0 =A0 =A0 =A0=
 =3D 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0}, { /* SPORT 1 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D "SPORT1",
> @@ -503,29 +542,168 @@ static struct sport_uart_port sport_uart_ports=
[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.rx_irq =3D IRQ_SPORT1_RX,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.err_irq=3D IRQ_SPORT1_ERROR,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.port =A0 =3D {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0=
 =3D PORT_BFIN_SPORT,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .iotype =A0 =A0 =A0 =A0=
 =3D UPIO_MEM,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.membase =A0 =A0 =A0 =A0=
=3D (void __iomem *)SPORT1_TCR1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.mapbase =A0 =A0 =A0 =A0=
=3D SPORT1_TCR1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.irq =A0 =A0 =A0 =A0 =A0=
 =A0=3D IRQ_SPORT1_RX,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .uartclk =A0 =A0 =A0 =A0=
=3D CONFIG_SPORT_BAUD_RATE,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .fifosize =A0 =A0 =A0 =3D=
 8,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .ops =A0 =A0 =A0 =A0 =A0=
 =A0=3D &sport_uart_ops,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .line =A0 =A0 =A0 =A0 =A0=
 =3D 1,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0}
> =A0};
>
> +static int nr_active_ports =3D ARRAY_SIZE(sport_uart_ports);
> +
> +static int __init sport_uart_init_ports(void)
> +{
> + =A0 =A0 =A0 static int first =3D 1;
> + =A0 =A0 =A0 int i, ret;
> +
> + =A0 =A0 =A0 if (!first)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 first =3D 0;
> +
> + =A0 =A0 =A0 ret =3D peripheral_request_list(bfin_uart_pin_req_sport=
0, DRV_NAME);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("requesting SPORT0 peripherals f=
ailed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 ret =3D peripheral_request_list(bfin_uart_pin_req_sport=
1, DRV_NAME);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 peripheral_free_list(bfin_uart_pin_req_=
sport0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("requesting SPORT1 peripherals f=
ailed\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 for (i =3D 0; i < nr_active_ports; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_init(&sport_uart_ports[i].por=
t.lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sport_uart_ports[i].port.fifosize =A0=3D=
 SPORT_TX_FIFO_SIZE,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sport_uart_ports[i].port.ops =A0 =A0 =A0=
 =3D &sport_uart_ops;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sport_uart_ports[i].port.line =A0 =A0 =A0=
=3D i;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sport_uart_ports[i].port.iotype =A0 =A0=
=3D UPIO_MEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sport_uart_ports[i].port.flags =A0 =A0 =
=3D UPF_BOOT_AUTOCONF;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +#ifdef CONFIG_SERIAL_BFIN_SPORT_CONSOLE
> +static int __init
> +sport_uart_console_setup(struct console *co, char *options)
> +{
> + =A0 =A0 =A0 struct sport_uart_port *up;
> + =A0 =A0 =A0 int baud =3D 57600;
> + =A0 =A0 =A0 int bits =3D 8;
> + =A0 =A0 =A0 int parity =3D 'n';
> + =A0 =A0 =A0 int flow =3D 'n';
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Check whether an invalid uart number has been spec=
ified, and
> + =A0 =A0 =A0 =A0* if so, search for the first available port that do=
es have
> + =A0 =A0 =A0 =A0* console support.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (co->index =3D=3D -1 || co->index >=3D nr_active_por=
ts)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 co->index =3D 0;
> + =A0 =A0 =A0 up =3D &sport_uart_ports[co->index];
> +
> + =A0 =A0 =A0 if (options)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_parse_options(options, &baud, &par=
ity, &bits, &flow);
> +
> + =A0 =A0 =A0 return uart_set_options(&up->port, co, baud, parity, bi=
ts, flow);
> +}
> +
> +static void sport_uart_console_putchar(struct uart_port *port, int c=
h)
> +{
> + =A0 =A0 =A0 struct sport_uart_port *up =3D (struct sport_uart_port =
*)port;
> +
> + =A0 =A0 =A0 while (SPORT_GET_STAT(up) & TXF)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 barrier();
> +
> + =A0 =A0 =A0 tx_one_byte(up, ch);
> +}
> +
> +/*
> + * Interrupts are disabled on entering
> + */
> +static void
> +sport_uart_console_write(struct console *co, const char *s, unsigned=
 int count)
> +{
> + =A0 =A0 =A0 struct sport_uart_port *up =3D &sport_uart_ports[co->in=
dex];
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&up->port.lock, flags);
> +
> + =A0 =A0 =A0 if (SPORT_GET_TCR1(up) & TSPEN)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_console_write(&up->port, s, count,=
 sport_uart_console_putchar);
> + =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* dummy data to start sport */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (SPORT_GET_STAT(up) & TXF)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 barrier();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPORT_PUT_TX(up, 0xffff);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Enable transmit, then an interrupt w=
ill generated */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPORT_PUT_TCR1(up, (SPORT_GET_TCR1(up) =
| TSPEN));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSYNC();
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart_console_write(&up->port, s, count,=
 sport_uart_console_putchar);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Although the hold register is empty,=
 last byte is still in shift
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* register and not sent out yet. So,=
 put a dummy data into TX FIFO.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Then, sport tx stops when last byt=
e is shift out and the dummy
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* data is moved into the shift regis=
ter.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (SPORT_GET_STAT(up) & TXF)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 barrier();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPORT_PUT_TX(up, 0xffff);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (!(SPORT_GET_STAT(up) & TXHRE))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 barrier();
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Stop sport tx transfer */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPORT_PUT_TCR1(up, (SPORT_GET_TCR1(up) =
& ~TSPEN));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSYNC();
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&up->port.lock, flags);
> +}
> +
> +static struct uart_driver sport_uart_reg;
> +
> +static struct console sport_uart_console =3D {
> + =A0 =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D DEVICE_NAME,
> + =A0 =A0 =A0 .write =A0 =A0 =A0 =A0 =A0=3D sport_uart_console_write,
> + =A0 =A0 =A0 .device =A0 =A0 =A0 =A0 =3D uart_console_device,
> + =A0 =A0 =A0 .setup =A0 =A0 =A0 =A0 =A0=3D sport_uart_console_setup,
> + =A0 =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D CON_PRINTBUFFER,
> + =A0 =A0 =A0 .index =A0 =A0 =A0 =A0 =A0=3D -1,
> + =A0 =A0 =A0 .data =A0 =A0 =A0 =A0 =A0 =3D &sport_uart_reg,
> +};
> +
> +static int __init sport_uart_rs_console_init(void)
> +{
> + =A0 =A0 =A0 int ret =3D sport_uart_init_ports();
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 register_console(&sport_uart_console);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +console_initcall(sport_uart_rs_console_init);
> +
> +#define SPORT_UART_CONSOLE =A0 =A0 (&sport_uart_console)
> +#else
> +#define SPORT_UART_CONSOLE =A0 =A0 NULL
> +#endif /* CONFIG_SERIAL_BFIN_CONSOLE */
> +
> +
> =A0static struct uart_driver sport_uart_reg =3D {
> =A0 =A0 =A0 =A0.owner =A0 =A0 =A0 =A0 =A0=3D THIS_MODULE,
> - =A0 =A0 =A0 .driver_name =A0 =A0=3D "SPORT-UART",
> - =A0 =A0 =A0 .dev_name =A0 =A0 =A0 =3D "ttySS",
> + =A0 =A0 =A0 .driver_name =A0 =A0=3D DRV_NAME,
> + =A0 =A0 =A0 .dev_name =A0 =A0 =A0 =3D DEVICE_NAME,
> =A0 =A0 =A0 =A0.major =A0 =A0 =A0 =A0 =A0=3D 204,
> =A0 =A0 =A0 =A0.minor =A0 =A0 =A0 =A0 =A0=3D 84,
> =A0 =A0 =A0 =A0.nr =A0 =A0 =A0 =A0 =A0 =A0 =3D ARRAY_SIZE(sport_uart_=
ports),
> - =A0 =A0 =A0 .cons =A0 =A0 =A0 =A0 =A0 =3D NULL,
> + =A0 =A0 =A0 .cons =A0 =A0 =A0 =A0 =A0 =3D SPORT_UART_CONSOLE,
> =A0};
>
> +#ifdef CONFIG_PM
> =A0static int sport_uart_suspend(struct platform_device *dev, pm_mess=
age_t state)
> =A0{
> =A0 =A0 =A0 =A0struct sport_uart_port *sport =3D platform_get_drvdata=
(dev);
> @@ -547,8 +725,12 @@ static int sport_uart_resume(struct platform_dev=
ice *dev)
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> +#else
> +# define sport_uart_suspend NULL
> +# define sport_uart_resume =A0NULL
> +#endif
>
> -static int sport_uart_probe(struct platform_device *dev)
> +static int __devinit sport_uart_probe(struct platform_device *dev)
> =A0{
> =A0 =A0 =A0 =A0pr_debug("%s enter\n", __func__);
> =A0 =A0 =A0 =A0sport_uart_ports[dev->id].port.dev =3D &dev->dev;
> @@ -558,7 +740,7 @@ static int sport_uart_probe(struct platform_devic=
e *dev)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static int sport_uart_remove(struct platform_device *dev)
> +static int __devexit sport_uart_remove(struct platform_device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct sport_uart_port *sport =3D platform_get_drvdata=
(dev);
>
> @@ -575,7 +757,7 @@ static struct platform_driver sport_uart_driver =3D=
 {
> =A0 =A0 =A0 =A0.probe =A0 =A0 =A0 =A0 =A0=3D sport_uart_probe,
> =A0 =A0 =A0 =A0.remove =A0 =A0 =A0 =A0 =3D sport_uart_remove,
> =A0 =A0 =A0 =A0.suspend =A0 =A0 =A0 =A0=3D sport_uart_suspend,
> - =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D sport_uart_resume,
> + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D __devexit_p(sport_uart_resu=
me),
> =A0 =A0 =A0 =A0.driver =A0 =A0 =A0 =A0 =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =A0 =3D DRV_NAME,
> =A0 =A0 =A0 =A0},
> @@ -586,32 +768,38 @@ static int __init sport_uart_init(void)
> =A0 =A0 =A0 =A0int ret;
>
> =A0 =A0 =A0 =A0pr_debug("%s enter\n", __func__);
> +
> + =A0 =A0 =A0 ret =3D sport_uart_init_ports();
> + =A0 =A0 =A0 if (ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> =A0 =A0 =A0 =A0ret =3D uart_register_driver(&sport_uart_reg);
> - =A0 =A0 =A0 if (ret !=3D 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Failed to register %s:=
%d\n",
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("failed to register %s:%d\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sport_=
uart_reg.driver_name, ret);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0ret =3D platform_driver_register(&sport_uart_driver);
> - =A0 =A0 =A0 if (ret !=3D 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Failed to register spo=
rt uart driver:%d\n", ret);
> + =A0 =A0 =A0 if (ret) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("failed to register sport uart d=
river:%d\n", ret);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart_unregister_driver(&sport_uart_reg=
);
> =A0 =A0 =A0 =A0}
>
> -
> =A0 =A0 =A0 =A0pr_debug("%s exit\n", __func__);
> =A0 =A0 =A0 =A0return ret;
> =A0}
> +module_init(sport_uart_init);
>
> =A0static void __exit sport_uart_exit(void)
> =A0{
> =A0 =A0 =A0 =A0pr_debug("%s enter\n", __func__);
> =A0 =A0 =A0 =A0platform_driver_unregister(&sport_uart_driver);
> =A0 =A0 =A0 =A0uart_unregister_driver(&sport_uart_reg);
> -}
>
> -module_init(sport_uart_init);
> + =A0 =A0 =A0 peripheral_free_list(bfin_uart_pin_req_sport1);
> + =A0 =A0 =A0 peripheral_free_list(bfin_uart_pin_req_sport0);
> +}
> =A0module_exit(sport_uart_exit);
>
> =A0MODULE_LICENSE("GPL");
> diff --git a/drivers/serial/bfin_sport_uart.h b/drivers/serial/bfin_s=
port_uart.h
> index 671d41c..60c351b 100644
> --- a/drivers/serial/bfin_sport_uart.h
> +++ b/drivers/serial/bfin_sport_uart.h
> @@ -43,7 +43,20 @@
> =A0#define SPORT_GET_TFSDIV(sport) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bfi=
n_read16(((sport)->port.membase + OFFSET_TFSDIV))
> =A0#define SPORT_GET_TX(sport) =A0 =A0 =A0 =A0 =A0 =A0bfin_read16(((s=
port)->port.membase + OFFSET_TX))
> =A0#define SPORT_GET_RX(sport) =A0 =A0 =A0 =A0 =A0 =A0bfin_read16(((s=
port)->port.membase + OFFSET_RX))
> -#define SPORT_GET_RX32(sport) =A0 =A0 =A0 =A0 =A0bfin_read32(((sport=
)->port.membase + OFFSET_RX))
> +/*
> + * Disable local interrupt to walk around the fake RX underflow erro=
r
> + * when do 32-bit reading from RX fifois interrupted by other interr=
upt.
> + * This is a possible hardware anomaly. After it is logged officiall=
y,
> + * the official anomaly id should be listed bellow.
> + */
> +#define SPORT_GET_RX32(sport) =A0\
> +({ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 unsigned int __ret; =A0 =A0 =A0 =A0 =A0 =A0 \
> + =A0 =A0 =A0 local_irq_disable(); =A0 =A0\
> + =A0 =A0 =A0 __ret =3D bfin_read32(((sport)->port.membase + OFFSET_R=
X)); =A0 =A0 =A0 \
> + =A0 =A0 =A0 local_irq_enable(); =A0 =A0 \
> + =A0 =A0 =A0 __ret; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> +})
> =A0#define SPORT_GET_RCR1(sport) =A0 =A0 =A0 =A0 =A0bfin_read16(((spo=
rt)->port.membase + OFFSET_RCR1))
> =A0#define SPORT_GET_RCR2(sport) =A0 =A0 =A0 =A0 =A0bfin_read16(((spo=
rt)->port.membase + OFFSET_RCR2))
> =A0#define SPORT_GET_RCLKDIV(sport) =A0 =A0 =A0 bfin_read16(((sport)-=
>port.membase + OFFSET_RCLKDIV))
> @@ -61,3 +74,6 @@
> =A0#define SPORT_PUT_RCLKDIV(sport, v) =A0 =A0bfin_write16(((sport)->=
port.membase + OFFSET_RCLKDIV), v)
> =A0#define SPORT_PUT_RFSDIV(sport, v) =A0 =A0 bfin_write16(((sport)->=
port.membase + OFFSET_RFSDIV), v)
> =A0#define SPORT_PUT_STAT(sport, v) =A0 =A0 =A0 bfin_write16(((sport)=
->port.membase + OFFSET_STAT), v)
> +
> +#define SPORT_TX_FIFO_SIZE =A0 =A0 8
> +
> --
> 1.6.0
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
