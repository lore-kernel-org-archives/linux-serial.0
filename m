From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH V2 3/4] 8250: 8250_f81504: Add Fintek F81504/508/512
 PCIE-to-UART/GPIO UART support
Date: Thu, 28 Jan 2016 10:17:02 +0000
Message-ID: <20160128101702.1b570e1b@lxorguk.ukuu.org.uk>
References: <1453972838-30268-1-git-send-email-hpeter+linux_kernel@gmail.com>
	<1453972838-30268-4-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1453972838-30268-4-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Peter Hung <hpeter@gmail.com>
Cc: linus.walleij@linaro.org, gnurou@gmail.com, gregkh@linuxfoundation.org, andriy.shevchenko@linux.intel.com, paul.gortmaker@windriver.com, lee.jones@linaro.org, jslaby@suse.com, peter_hong@fintek.com.tw, heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, soeren.grunewald@desy.de, udknight@gmail.com, adam.lee@canonical.com, arnd@arndb.de, manabian@gmail.com, scottwood@freescale.com, yamada.masahiro@socionext.com, paul.burton@imgtec.com, mans@mansr.com, matthias.bgg@gmail.com, ralf@linux-mips.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, tom_tsai@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Thu, 28 Jan 2016 17:20:37 +0800
Peter Hung <hpeter@gmail.com> wrote:

> This driver is 8250 driver for F81504/508/512, it'll handle the serial
> port operation of this device. This module will depend on
> MFD_FINTEK_F81504_CORE.
> 
> The serial ports support from 50bps to 1.5Mbps with Linux baudrate
> define excluding 1.0Mbps due to not support 16MHz clock source.
> 
> PCI Configuration Space Registers, set:0~11(Max):
>     40h + 8 * set:
>                    bit7~6: Clock source selector
>                        00: 1.8432MHz
>                        01: 18.432MHz
>                        10: 24MHz
>                        11: 14.769MHz
>                    bit0: UART enable
>     41h + 8 * set:
>                    bit5~4: RX trigger multiple
>                        00: 1x * trigger level
>                        01: 2x * trigger level
>                        10: 4x * trigger level
>                        11: 8x * trigger level
>                    bit1~0: FIFO Size
>                        11: 128Bytes
>     44h + 8 * set: UART IO address (LSB)
>     45h + 8 * set: UART IO address (MSB)
>     47h + 8 * set:
>                    bit5: RTS invert (bit4 must enable)
>                    bit4: RTS auto direction enable
>                          0: RTS control by MCR
>                          1: RTS driven high when TX, otherwise low
> 
> Suggested-by: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>

Nice

It and the GPIO driver parts

Reviewed-by: Alan Cox <gnomes@lxorguk.ukuu.org.uk>

Alan
