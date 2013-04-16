From: Jonas Gorski <jogo@openwrt.org>
Subject: Re: [PATCH V2] tty: serial: ralink: fix SERIAL_8250_RT288X dependency
Date: Tue, 16 Apr 2013 13:31:58 +0200
Message-ID: <CAOiHx=npmzXe8yk1NLwzK0dQ-XsM-0bbT+L5Yg5LL05n0a3BKA@mail.gmail.com>
References: <1366093125-19352-1-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1366093125-19352-1-git-send-email-blogic@openwrt.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: John Crispin <blogic@openwrt.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-serial@vger.kernel.org

On 16 April 2013 08:18, John Crispin <blogic@openwrt.org> wrote:
> With every Ralink SoC that we add, we would need to extend the dependency. In
> order to make life easier we make the symbol depend on MIPS & RALINK and then
> select it from within arch/mips/ralink/.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
> Hi Greg,
>
> this patch should go upstream via the mips tree to avoid merge conflicts.
> The tty part however requires your Ack.
>
>         John
>
>  arch/mips/Kconfig               |    1 +
>  drivers/tty/serial/8250/Kconfig |    4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index c1997db..2e8939f 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -441,6 +441,7 @@ config RALINK
>         select SYS_HAS_EARLY_PRINTK
>         select HAVE_MACH_CLKDEV
>         select CLKDEV_LOOKUP
> +       select SERIAL_8250_RT288X
>
>  config SGI_IP22
>         bool "SGI IP22 (Indy/Indigo2)"
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 80fe91e..24ea3c8 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -295,8 +295,8 @@ config SERIAL_8250_EM
>           If unsure, say N.
>
>  config SERIAL_8250_RT288X
> -       bool "Ralink RT288x/RT305x/RT3662/RT3883 serial port support"
> -       depends on SERIAL_8250 && (SOC_RT288X || SOC_RT305X || SOC_RT3883)
> +       bool
> +       depends on SERIAL_8250 && MIPS && RALINK

This won't work, Having RALINK=y, but SERIAL_8250=n will still result
in SERIAL_8250_RT288X=y, as select ignores dependencies. What could
work is removing the select from RALINK, and changing the depends from
this one to "default y if SERIAL_8250 && MIPS && RALINK".

>         help
>           If you have a Ralink RT288x/RT305x SoC based board and want to use the
>           serial port, say Y to this option. The driver can handle up to 2 serial
> --
> 1.7.10.4
>
>

Jonas
