From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 3/6] serial: mid8250: select CONFIG_RATIONAL
Date: Mon, 16 Nov 2015 18:56:02 +0200
Message-ID: <1447692962.31665.145.camel@linux.intel.com>
References: <1447688894-2936779-1-git-send-email-arnd@arndb.de>
	 <1447688894-2936779-4-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447688894-2936779-4-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

On Mon, 2015-11-16 at 16:48 +0100, Arnd Bergmann wrote:
> The Intel MID support got split out from the PCI 8250 driver,
> and that now causes a build error when no other driver selects
> CONFIG_RATIONAL:

Already published.
https://lkml.org/lkml/2015/11/12/272

It's not first time you send patches that already have been published.

I think you use some testing automation which doesn't take into
consideration what is sent in mailing lists.

>=20
> drivers/built-in.o: In function `mid8250_set_termios':
> (.text+0x77418): undefined reference to `rational_best_approximation'
>=20
> This adds an explicit 'select' like the combined driver had before.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: d9eda9bab237 ("serial: 8250_pci: Intel MID UART support to its
> own driver")
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> =C2=A0drivers/tty/serial/8250/Kconfig | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/tty/serial/8250/Kconfig
> b/drivers/tty/serial/8250/Kconfig
> index e6f5e12a2d83..6412f1455beb 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -373,6 +373,7 @@ config SERIAL_8250_MID
> =C2=A0	depends on SERIAL_8250 && PCI
> =C2=A0	select HSU_DMA if SERIAL_8250_DMA
> =C2=A0	select HSU_DMA_PCI if X86_INTEL_MID
> +	select RATIONAL
> =C2=A0	help
> =C2=A0	=C2=A0=C2=A0Selecting this option will enable handling of the =
extra
> features
> =C2=A0	=C2=A0=C2=A0present on the UART found on Intel Medfield SOC an=
d
> various other

--=20
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
