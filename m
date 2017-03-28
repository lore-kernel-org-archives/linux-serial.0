From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] serial: 8250_EXAR: fix duplicate Kconfig text and add
 missing help text
Date: Tue, 28 Mar 2017 10:10:32 +0300
Message-ID: <CAHp75VcgjnAXXcSJqtQmgcUKNDbF5iXjEF21WKCVmQqByxztRw@mail.gmail.com>
References: <20170327233910.13122-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170327233910.13122-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 28, 2017 at 2:39 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> In commit d0aeaa83f0b0f7a92615bbdd6b1f96812f7dcfd2 ("serial: exar:
> split out the exar code from 8250_pci") the exar driver got its own
> Kconfig.  However the text for the new option was never changed from
> the original 8250_PCI text, and hence it appears confusing when you
> get asked the same question twice:
>
>   8250/16550 PCI device support (SERIAL_8250_PCI) [Y/n/m/?] (NEW)
>     8250/16550 PCI device support (SERIAL_8250_EXAR) [Y/n/m] (NEW)
>
> Adding to the confusion, is that there is no help text for this new
> option to indicate it is specific to a certain family of cards.
>
> Fix both issues at the same time, as well as the space vs. tab issues
> introduced in the same commit.
>

Good catch!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: d0aeaa83f0b0 ("serial: exar: split out the exar code from 8250_pci")
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/tty/serial/8250/Kconfig | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index a65fb8197aec..0e3f529d50e9 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -128,9 +128,13 @@ config SERIAL_8250_PCI
>           by the parport_serial driver, enabled with CONFIG_PARPORT_SERIAL.
>
>  config SERIAL_8250_EXAR
> -        tristate "8250/16550 PCI device support"
> -        depends on SERIAL_8250_PCI
> +       tristate "8250/16550 Exar/Commtech PCI/PCIe device support"
> +       depends on SERIAL_8250_PCI
>         default SERIAL_8250
> +       help
> +         This builds support for XR17C1xx, XR17V3xx and some Commtech
> +         422x PCIe serial cards that are not covered by the more generic
> +         SERIAL_8250_PCI option.
>
>  config SERIAL_8250_HP300
>         tristate
> --
> 2.11.0
>



-- 
With Best Regards,
Andy Shevchenko
