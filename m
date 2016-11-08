From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH 2/2] serial: pxa2xx: mark PM functions as __maybe_unused
Date: Tue, 08 Nov 2016 18:30:43 +0100
Message-ID: <87shr1yj3w.fsf@belgarion.home>
References: <20161108145130.3502815-1-arnd@arndb.de>
        <20161108145130.3502815-2-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161108145130.3502815-2-arnd@arndb.de> (Arnd Bergmann's message
        of "Tue, 8 Nov 2016 15:50:42 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sergey Yanovich <ynvich@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> The fresh new serial driver for pxa produces warnings when
> CONFIG_PM_SLEEP is disabled:
>
> drivers/tty/serial/8250/8250_pxa.c:50:12: error: 'serial_pxa_resume' defined but not used [-Werror=unused-function]
> drivers/tty/serial/8250/8250_pxa.c:41:12: error: 'serial_pxa_suspend' defined but not used [-Werror=unused-function]
>
> This removes the #ifdef around the two functions and instead marks both
> as __maybe_unused, which is more robust and avoids the warning.
>
> Fixes: ab28f51c77cd ("serial: rewrite pxa2xx-uart to use 8250_core")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
