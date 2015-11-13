From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] serial: 8250_mid: Add missing dependency
Date: Fri, 13 Nov 2015 03:31:04 +0200
Message-ID: <CAHp75VescZjQWaP8ROmLEzxhKc=k0udFpfjWXm7qxxm_NxL9-w@mail.gmail.com>
References: <1447334483-126186-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447334483-126186-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 12, 2015 at 3:21 PM, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
> 8250_mid uses rational_best_approximation() function, so the
> driver needs to select CONFIG_RATIONAL option.
>
> This fixes build error when CONFIG_RATIONAL is not enabled:
>
> drivers/built-in.o: In function `mid8250_set_termios':
> 8250_mid.c:(.text+0x10169a): undefined reference to `rational_best_approximation'
>

Oh, man, I have the same fix in my local tree for weeks ;-)

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/tty/serial/8250/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index e6f5e12..6412f14 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -373,6 +373,7 @@ config SERIAL_8250_MID
>         depends on SERIAL_8250 && PCI
>         select HSU_DMA if SERIAL_8250_DMA
>         select HSU_DMA_PCI if X86_INTEL_MID
> +       select RATIONAL
>         help
>           Selecting this option will enable handling of the extra features
>           present on the UART found on Intel Medfield SOC and various other
> --
> 2.6.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



-- 
With Best Regards,
Andy Shevchenko
