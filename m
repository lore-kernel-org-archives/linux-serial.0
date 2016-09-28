From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] MAINTAINERS: update entry for atmel_serial driver
Date: Wed, 28 Sep 2016 09:04:13 -0700
Message-ID: <1475078653.2685.1.camel@perches.com>
References: <20160928154735.25265-1-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160928154735.25265-1-nicolas.ferre@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, richard.genoud@gmail.com, jslaby@suse.cz, linux-serial@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Cyrille Pitchen <cyrille.pitchen@atmel.com>
List-Id: linux-serial@vger.kernel.org

On Wed, 2016-09-28 at 17:47 +0200, Nicolas Ferre wrote:
> Change maintainer for the serial driver found on most of the
> Microchip / Atmel MPUs and take advantage of the move to rename
> and reorder the entry.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> +MICROCHIP / ATMEL AT91 / AT32 SERIAL DRIVER
> +M:	Richard Genoud <richard.genoud@gmail.com>
> +S:	Maintained
> +F:	drivers/tty/serial/atmel_serial.c
> +F:	include/linux/atmel_serial.h

Thanks Richard.

include/linux is pretty cluttered with random files.

atmel_serial.h is #include exactly once.

Please move it out of include/linux and into
drivers/tty/serial/ one day.
