From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V3 2/4] gpio: gpio-f81504: Add Fintek F81504/508/512
 PCIE-to-UART/GPIO GPIOLIB support
Date: Tue, 16 Feb 2016 16:22:41 +0100
Message-ID: <CACRpkdYODcp5P7QT1b-9HNjA1j4X_UAVs+AfCgjfgpjAA2PnWQ@mail.gmail.com>
References: <1455605710-3724-1-git-send-email-hpeter+linux_kernel@gmail.com>
	<1455605710-3724-3-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455605710-3724-3-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hung <hpeter@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Lee Jones <lee.jones@linaro.org>, Jiri Slaby <jslaby@suse.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter H <peter_hong@fintek.com.tw>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, Soeren Grunewald <soeren.grunewald@desy.de>, Wang YanQing <udknight@gmail.com>, Adam Lee <adam.lee@canonical.com>, Arnd Bergmann <arnd@arndb.de>, Joachim Eastwood <manabian@gmail.com>, Scott Wood <scottwood@freescale.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Paul Burton <paul.burton@imgtec.com>, =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>, Matthias Brugger <matthias.bgg@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger
List-Id: linux-serial@vger.kernel.org

On Tue, Feb 16, 2016 at 7:55 AM, Peter Hung <hpeter@gmail.com> wrote:

> This driver is GPIOLIB driver for F81504/508/512, it'll handle the
> GPIOLIB operation of this device. This module will depend on
> MFD_FINTEK_F81504_CORE.
>
> IC function list:
>     F81504: Max 2x8 GPIOs and max 4 serial ports
>         port2/3 are multi-function
>     F81508: Max 6x8 GPIOs and max 8 serial ports
>         port2/3 are multi-function, port8/9/10/11 are gpio only
>     F81512: Max 6x8 GPIOs and max 12 serial ports
>         port2/3/8/9/10/11 are multi-function
>
> GPIO register:
> PCI Configuration space:
>     F0h: bit0~5: Enable GPIO0~5
>          bit6~7: Reserve
>     F3h: bit0~5: Multi-Functional Flag (0:GPIO/1:UART)
>          bit0: UART2 pin out for UART2 / GPIO0
>          bit1: UART3 pin out for UART3 / GPIO1
>          bit2: UART8 pin out for UART8 / GPIO2
>          bit3: UART9 pin out for UART9 / GPIO3
>          bit4: UART10 pin out for UART10 / GPIO4
>          bit5: UART11 pin out for UART11 / GPIO5
>          bit6~7: Reserve
>     F1h: IO address (LSB)
>     F2h: IO address (MSB)
>     F8h + 8 * set: Direction control (bitwise)
>          bitx: 0 - Input mode
>          bitx: 1 - Output mode
>     F9h + 8 * set: Drive ability control (bitwise)
>          bitx: 0 - Open drain (default)
>          bitx: 1 - Push Pull
>          In this driver, we only implements open drain mode.
>
> IO space:
>     (IO base + 0~5): GPIO-0x~5x in/out value (bitwise)
>
> Suggested-by: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Peter Hung <hpeter+linux_kernel@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

It's fine with me if this is queued in MFD, serial or whatever tree, or
we can wait until the MFD parts are in and take it for the next merge
window.

Yours,
Linus Walleij
