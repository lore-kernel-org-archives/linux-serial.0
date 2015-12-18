From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: 8250: of: Fix the driver and actually compile the 8250_of
Date: Fri, 18 Dec 2015 13:52:33 +0100
Message-ID: <6383189.zS3XQNVGho@wuerfel>
References: <1450442612-11372-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450442612-11372-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Friday 18 December 2015 14:43:32 Peter Ujfalusi wrote:
> The 8250_of never compiled since in the Kconfig we have SERIAL_OF_PLATFORM
> but in the makefile we expect to have SERIAL_8250_OF...
> 
> In the Kconfig keep the SERIAL_OF_PLATFORM for compatibility reasons and
> let it select the SERIAL_8250_OF. Later we can replace the
> SERIAL_OF_PLATFORM use in defconfigs to SERIAL_8250_OF.
> 
> When the 8250_of.c is actually compiled we will have two errors:
> missing linux/nwpserial.h and 8250/8250.h.
> Fix those as well at the same time when enable the compilation of the
> driver.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Fixes: afd7f88f1577 ("serial: 8250: move of_serial code to 8250 directory")
> CC: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks for the report. Indeed this could not have worked.

> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index b03cb5175113..01f24613b0e6 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -379,6 +379,11 @@ config SERIAL_8250_MID
>           Intel platforms.
>  
>  config SERIAL_OF_PLATFORM
> +       tristate
> +       depends on SERIAL_8250 && OF
> +       select SERIAL_8250_OF
> +
> +config SERIAL_8250_OF
>         tristate "Devicetree based probing for 8250 ports"
>         depends on SERIAL_8250 && OF
>         help

This will still require changing all the defconfigs, as SERIAL_OF_PLATFORM
is a silent option now. I think it's better to change the Makefile and
leave the slightly odd Kconfig symbol name.

	Arnd
