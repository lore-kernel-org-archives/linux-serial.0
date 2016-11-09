From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] serial: 8250_pxa: hide early console setup when disabled
Date: Wed, 09 Nov 2016 21:16:45 +0100
Message-ID: <87wpgcv26q.fsf@belgarion.home>
References: <20161109132725.2072258-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161109132725.2072258-1-arnd@arndb.de> (Arnd Bergmann's message
        of "Wed, 9 Nov 2016 14:27:00 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The newly added pxa glue driver for 8250 supports console output, but
> fails to build if the 8250 console is disabled:
>
> drivers/tty/serial/8250/8250_pxa.o: In function `early_serial_pxa_setup':
> 8250_pxa.c:(.init.text+0x50): undefined reference to `early_serial8250_setup'
>
> This adds an #ifdef like the other glue drivers have it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
