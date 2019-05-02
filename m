From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v5 2/2] tty: serial: add driver for the SiFive UART
Date: Thu, 02 May 2019 11:58:12 -0700
Message-ID: <7hpnp0lm4b.fsf@baylibre.com>
References: <20190413020111.23400-1-paul.walmsley@sifive.com> <20190413020111.23400-3-paul.walmsley@sifive.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190413020111.23400-3-paul.walmsley@sifive.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org, gregkh@linuxfoundation.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Paul Walmsley <paul@pwsan.com>, Jiri Slaby <jslaby@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Wesley Terpstra <wesley@sifive.com>, Julia Lawall <julia.lawall@lip6.fr>, Emil Renner Berthing <kernel@esmil.dk>, Andreas Schwab <schwab@suse.de>
List-Id: linux-serial@vger.kernel.org

Paul Walmsley <paul.walmsley@sifive.com> writes:

> Add a serial driver for the SiFive UART, found on SiFive FU540 devices
> (among others).
>
> The underlying serial IP block is relatively basic, and currently does
> not support serial break detection.  Further information on the IP
> block can be found in the documentation and Chisel sources:
>
>     https://static.dev.sifive.com/FU540-C000-v1.0.pdf
>
>     https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/uart
>
> This driver was written in collaboration with Wesley Terpstra
> <wesley@sifive.com>.
>
> Tested on a SiFive HiFive Unleashed A00 board, using BBL and the open-
> source FSBL (using a DT file based on what's targeted for mainline).
>
> This revision incorporates changes based on comments by Julia Lawall
> <julia.lawall@lip6.fr>, Emil Renner Berthing <kernel@esmil.dk>, and
> Andreas Schwab <schwab@suse.de>.  Thanks also to Andreas for testing
> the driver with his userspace and reporting a bug with the
> set_termios implementation.
>
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Wesley Terpstra <wesley@sifive.com>
> Cc: linux-serial@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Julia Lawall <julia.lawall@lip6.fr>
> Cc: Emil Renner Berthing <kernel@esmil.dk>
> Cc: Andreas Schwab <schwab@suse.de>

Tested-by: Kevin Hilman <khilman@baylibre.com>
