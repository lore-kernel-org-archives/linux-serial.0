From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5] serial: support for 16550A serial ports on LP-8x4x
Date: Tue, 15 Dec 2015 22:51:20 +0100
Message-ID: <1970812.j9fZPC5F1b@wuerfel>
References: <1397668667-27328-1-git-send-email-ynvich@gmail.com> <1450213494-21884-1-git-send-email-ynvich@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450213494-21884-1-git-send-email-ynvich@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergei Ianovich <ynvich@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Scott Wood <scottwood@freescale.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Paul Burton <paul.burton@imgtec.com>, Joachim Eastwood <manabian@gmail.com>, Mans Rullgard <mans@mansr.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Hurley <peter@hurleysoftware.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>open list:
List-Id: linux-serial@vger.kernel.org

On Wednesday 16 December 2015 00:04:45 Sergei Ianovich wrote:
> index 0000000..5f9a4c1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/lp8x4x-serial.txt
> @@ -0,0 +1,35 @@
> +UART ports on ICP DAS LP-8x4x
> +
> +ICP DAS LP-8x4x contains three additional serial ports interfaced via
> +Analog Devices ADM213EA chips in addition to 3 serial ports on PXA CPU.
> +
> +Required properties:
> +- compatible : should be "icpdas,uart-lp8x4x"

Compatible strings should not include a 'x' wildcard like this, better use
the specific chip name.

Also, it sounds like you named them after the board vendor, which sounds
wrong as the vendor part of the compatible string should be the whoever
made that part (analog?)

> +- reg : should provide 16 byte man IO memory region and 1 byte region for
> +       termios
> +
> +- interrupts : should provide interrupt
> +
> +- interrupt-parent : should provide a link to interrupt controller either
> +                    explicitly or implicitly from a parent node

interrupt-parent should be an optional property, or you can leave it out,
as this is a standard property that can always be there when there is 
interrupts.

> +Examples (from pxa27x-lp8x4x.dts):
> +
> +               uart@9050 {

By convention, the name should be 'serial', not 'uart'.

	Arnd.
