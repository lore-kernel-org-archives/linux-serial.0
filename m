From: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 1/3] tegra, serial8250: add ->handle_break() uart_port op
Date: Mon, 9 Apr 2012 12:41:25 -0700
Message-ID: <CABE8wwvjJt8-io9gsnTATW59D+O81rmcyYHn8dss284bOj7v7w@mail.gmail.com>
References: <20120409194514.8004.53204.stgit@dwillia2-linux.jf.intel.com>
	<20120409194857.8004.86352.stgit@dwillia2-linux.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49658 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752796Ab2DITl2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Apr 2012 15:41:28 -0400
Received: by bkcjm19 with SMTP id jm19so3528784bkc.25
        for <linux-serial@vger.kernel.org>; Mon, 09 Apr 2012 12:41:25 -0700 (PDT)
In-Reply-To: <20120409194857.8004.86352.stgit@dwillia2-linux.jf.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: Sudhakar Mamillapalli <sudhakar@fb.com>, Stephen Warren <swarren@nvidia.com>, linux-kernel@vger.kernel.org, arnd@arndb.de, Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>, Nhan H Mai <nhan.h.mai@intel.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@linux.intel.com>

[ adding Arnd ]

On Mon, Apr 9, 2012 at 12:48 PM, Dan Williams <dan.j.williams@intel.com=
> wrote:
> The "KT" serial port has another use case for a "received break" quir=
k,
> so before adding another special case to the 8250 core take this
> opportunity to push such quirks out of the core and into a uart_port =
op.
>
> Stephen says:
> "If the callback function is to no longer live in 8250.c itself,
> =A0arch/arm/mach-tegra/devices.c isn't logically a good place to put =
it,
> =A0and that file will be going away once we get rid of all the board =
files
> =A0and move solely to device tree."
>
> ...so since 8250_pci.c houses all the quirks for pci serial devices t=
his
> quirk is similarly housed in of_serial.c. =A0Once the open firmware
> conversion completes the infrastructure details (CONFIG_TEGRA_SERIAL,
> include/linux/of_serial.h, and the export) can all be removed to make
> this self contained to of_serial.c.
>
> Cc: Nhan H Mai <nhan.h.mai@intel.com>
> Cc: Colin Cross <ccross@android.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Arnd Bergmann arnd@arndb.de

Sorry, messed up Arnd's address, checkpatch would have caught this for =
me...

> Acked-by: Sudhakar Mamillapalli <sudhakar@fb.com>
> Reported-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
> Acked-by: Alan Cox <alan@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> =A0arch/arm/configs/tegra_defconfig =A0 =A0 =A0| =A0 =A01 +
> =A0arch/arm/mach-tegra/board-harmony.c =A0 | =A0 =A04 ++++
> =A0arch/arm/mach-tegra/board-paz00.c =A0 =A0 | =A0 =A05 +++++
> =A0arch/arm/mach-tegra/board-seaboard.c =A0| =A0 =A04 ++++
> =A0arch/arm/mach-tegra/board-trimslice.c | =A0 =A04 ++++
> =A0arch/arm/mach-tegra/devices.h =A0 =A0 =A0 =A0 | =A0 =A01 -
> =A0drivers/tty/serial/8250/8250.c =A0 =A0 =A0 =A0| =A0 34 +++--------=
----------------------
> =A0drivers/tty/serial/Kconfig =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A08 +++++=
+++
> =A0drivers/tty/serial/of_serial.c =A0 =A0 =A0 =A0| =A0 25 +++++++++++=
+++++++++++++
> =A0include/linux/of_serial.h =A0 =A0 =A0 =A0 =A0 =A0 | =A0 17 +++++++=
++++++++++
> =A0include/linux/serial_8250.h =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> =A0include/linux/serial_core.h =A0 =A0 =A0 =A0 =A0 | =A0 =A05 +++++
> =A012 files changed, 77 insertions(+), 32 deletions(-)
> =A0create mode 100644 include/linux/of_serial.h
>
> diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegr=
a_defconfig
> index 351d670..de7288a 100644
> --- a/arch/arm/configs/tegra_defconfig
> +++ b/arch/arm/configs/tegra_defconfig
> @@ -97,6 +97,7 @@ CONFIG_INPUT_EVDEV=3Dy
> =A0CONFIG_SERIAL_8250=3Dy
> =A0CONFIG_SERIAL_8250_CONSOLE=3Dy
> =A0CONFIG_SERIAL_OF_PLATFORM=3Dy
> +CONFIG_SERIAL_TEGRA=3Dy
> =A0# CONFIG_HW_RANDOM is not set
> =A0CONFIG_I2C=3Dy
> =A0# CONFIG_I2C_COMPAT is not set
> diff --git a/arch/arm/mach-tegra/board-harmony.c b/arch/arm/mach-tegr=
a/board-harmony.c
> index c00aadb..b8ceac3 100644
> --- a/arch/arm/mach-tegra/board-harmony.c
> +++ b/arch/arm/mach-tegra/board-harmony.c
> @@ -19,6 +19,7 @@
> =A0#include <linux/init.h>
> =A0#include <linux/platform_device.h>
> =A0#include <linux/serial_8250.h>
> +#include <linux/of_serial.h>
> =A0#include <linux/clk.h>
> =A0#include <linux/dma-mapping.h>
> =A0#include <linux/pda_power.h>
> @@ -52,6 +53,7 @@ static struct plat_serial8250_port debug_uart_platf=
orm_data[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.irq =A0 =A0 =A0 =A0 =A0 =A0=3D INT_UA=
RTD,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D UPF_BOOT=
_AUTOCONF | UPF_FIXED_TYPE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.type =A0 =A0 =A0 =A0 =A0 =3D PORT_TEG=
RA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .handle_break =A0 =3D tegra_serial_hand=
le_break,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.iotype =A0 =A0 =A0 =A0 =3D UPIO_MEM,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.regshift =A0 =A0 =A0 =3D 2,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.uartclk =A0 =A0 =A0 =A0=3D 216000000,
> @@ -115,7 +117,9 @@ static void __init harmony_i2c_init(void)
> =A0}
>
> =A0static struct platform_device *harmony_devices[] __initdata =3D {
> +#if IS_ENABLED(CONFIG_SERIAL_TEGRA)
> =A0 =A0 =A0 =A0&debug_uart,
> +#endif
> =A0 =A0 =A0 =A0&tegra_sdhci_device1,
> =A0 =A0 =A0 =A0&tegra_sdhci_device2,
> =A0 =A0 =A0 =A0&tegra_sdhci_device4,
> diff --git a/arch/arm/mach-tegra/board-paz00.c b/arch/arm/mach-tegra/=
board-paz00.c
> index 330afdf..1113dab 100644
> --- a/arch/arm/mach-tegra/board-paz00.c
> +++ b/arch/arm/mach-tegra/board-paz00.c
> @@ -21,6 +21,7 @@
> =A0#include <linux/init.h>
> =A0#include <linux/platform_device.h>
> =A0#include <linux/serial_8250.h>
> +#include <linux/of_serial.h>
> =A0#include <linux/clk.h>
> =A0#include <linux/dma-mapping.h>
> =A0#include <linux/gpio_keys.h>
> @@ -55,6 +56,7 @@ static struct plat_serial8250_port debug_uart_platf=
orm_data[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.irq =A0 =A0 =A0 =A0 =A0 =A0=3D INT_UA=
RTA,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D UPF_BOOT=
_AUTOCONF | UPF_FIXED_TYPE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.type =A0 =A0 =A0 =A0 =A0 =3D PORT_TEG=
RA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .handle_break =A0 =3D tegra_serial_hand=
le_break,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.iotype =A0 =A0 =A0 =A0 =3D UPIO_MEM,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.regshift =A0 =A0 =A0 =3D 2,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.uartclk =A0 =A0 =A0 =A0=3D 216000000,
> @@ -65,6 +67,7 @@ static struct plat_serial8250_port debug_uart_platf=
orm_data[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.irq =A0 =A0 =A0 =A0 =A0 =A0=3D INT_UA=
RTC,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D UPF_BOOT=
_AUTOCONF | UPF_FIXED_TYPE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.type =A0 =A0 =A0 =A0 =A0 =3D PORT_TEG=
RA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .handle_break =A0 =3D tegra_serial_hand=
le_break,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.iotype =A0 =A0 =A0 =A0 =3D UPIO_MEM,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.regshift =A0 =A0 =A0 =3D 2,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.uartclk =A0 =A0 =A0 =A0=3D 216000000,
> @@ -142,7 +145,9 @@ static struct platform_device gpio_keys_device =3D=
 {
> =A0};
>
> =A0static struct platform_device *paz00_devices[] __initdata =3D {
> +#if IS_ENABLED(CONFIG_SERIAL_TEGRA)
> =A0 =A0 =A0 =A0&debug_uart,
> +#endif
> =A0 =A0 =A0 =A0&tegra_sdhci_device4,
> =A0 =A0 =A0 =A0&tegra_sdhci_device1,
> =A0 =A0 =A0 =A0&wifi_rfkill_device,
> diff --git a/arch/arm/mach-tegra/board-seaboard.c b/arch/arm/mach-teg=
ra/board-seaboard.c
> index d669847..59a30ab 100644
> --- a/arch/arm/mach-tegra/board-seaboard.c
> +++ b/arch/arm/mach-tegra/board-seaboard.c
> @@ -18,6 +18,7 @@
> =A0#include <linux/init.h>
> =A0#include <linux/platform_device.h>
> =A0#include <linux/serial_8250.h>
> +#include <linux/of_serial.h>
> =A0#include <linux/i2c.h>
> =A0#include <linux/delay.h>
> =A0#include <linux/input.h>
> @@ -47,6 +48,7 @@ static struct plat_serial8250_port debug_uart_platf=
orm_data[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Memory and IRQ filled in before reg=
istration */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D UPF_BOOT=
_AUTOCONF | UPF_FIXED_TYPE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.type =A0 =A0 =A0 =A0 =A0 =3D PORT_TEG=
RA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .handle_break =A0 =3D tegra_serial_hand=
le_break,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.iotype =A0 =A0 =A0 =A0 =3D UPIO_MEM,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.regshift =A0 =A0 =A0 =3D 2,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.uartclk =A0 =A0 =A0 =A0=3D 216000000,
> @@ -145,7 +147,9 @@ static struct platform_device seaboard_audio_devi=
ce =3D {
> =A0};
>
> =A0static struct platform_device *seaboard_devices[] __initdata =3D {
> +#if IS_ENABLED(CONFIG_SERIAL_TEGRA)
> =A0 =A0 =A0 =A0&debug_uart,
> +#endif
> =A0 =A0 =A0 =A0&tegra_pmu_device,
> =A0 =A0 =A0 =A0&tegra_sdhci_device4,
> =A0 =A0 =A0 =A0&tegra_sdhci_device3,
> diff --git a/arch/arm/mach-tegra/board-trimslice.c b/arch/arm/mach-te=
gra/board-trimslice.c
> index cd52820..b156f55 100644
> --- a/arch/arm/mach-tegra/board-trimslice.c
> +++ b/arch/arm/mach-tegra/board-trimslice.c
> @@ -22,6 +22,7 @@
> =A0#include <linux/init.h>
> =A0#include <linux/platform_device.h>
> =A0#include <linux/serial_8250.h>
> +#include <linux/of_serial.h>
> =A0#include <linux/io.h>
> =A0#include <linux/i2c.h>
> =A0#include <linux/gpio.h>
> @@ -48,6 +49,7 @@ static struct plat_serial8250_port debug_uart_platf=
orm_data[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.irq =A0 =A0 =A0 =A0 =A0 =A0=3D INT_UA=
RTA,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.flags =A0 =A0 =A0 =A0 =A0=3D UPF_BOOT=
_AUTOCONF | UPF_FIXED_TYPE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.type =A0 =A0 =A0 =A0 =A0 =3D PORT_TEG=
RA,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .handle_break =A0 =3D tegra_serial_hand=
le_break,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.iotype =A0 =A0 =A0 =A0 =3D UPIO_MEM,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.regshift =A0 =A0 =A0 =3D 2,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.uartclk =A0 =A0 =A0 =A0=3D 216000000,
> @@ -81,7 +83,9 @@ static struct platform_device trimslice_audio_devic=
e =3D {
> =A0};
>
> =A0static struct platform_device *trimslice_devices[] __initdata =3D =
{
> +#if IS_ENABLED(CONFIG_SERIAL_TEGRA)
> =A0 =A0 =A0 =A0&debug_uart,
> +#endif
> =A0 =A0 =A0 =A0&tegra_sdhci_device1,
> =A0 =A0 =A0 =A0&tegra_sdhci_device4,
> =A0 =A0 =A0 =A0&tegra_i2s_device1,
> diff --git a/arch/arm/mach-tegra/devices.h b/arch/arm/mach-tegra/devi=
ces.h
> index ec45567..6e5f852 100644
> --- a/arch/arm/mach-tegra/devices.h
> +++ b/arch/arm/mach-tegra/devices.h
> @@ -53,5 +53,4 @@ extern struct platform_device tegra_i2s_device1;
> =A0extern struct platform_device tegra_i2s_device2;
> =A0extern struct platform_device tegra_das_device;
> =A0extern struct platform_device tegra_pcm_device;
> -
> =A0#endif
> diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250=
/8250.c
> index 5c27f7e..cbd94c3 100644
> --- a/drivers/tty/serial/8250/8250.c
> +++ b/drivers/tty/serial/8250/8250.c
> @@ -1332,27 +1332,6 @@ static void serial8250_enable_ms(struct uart_p=
ort *port)
> =A0}
>
> =A0/*
> - * Clear the Tegra rx fifo after a break
> - *
> - * FIXME: This needs to become a port specific callback once we have=
 a
> - * framework for this
> - */
> -static void clear_rx_fifo(struct uart_8250_port *up)
> -{
> - =A0 =A0 =A0 unsigned int status, tmout =3D 10000;
> - =A0 =A0 =A0 do {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D serial_in(up, UART_LSR);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status & (UART_LSR_FIFOE | UART_LSR=
_BRK_ERROR_BITS))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D serial_in(up=
, UART_RX);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (--tmout =3D=3D 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
> - =A0 =A0 =A0 } while (1);
> -}
> -
> -/*
> =A0* serial8250_rx_chars: processes according to the passed in LSR
> =A0* value, and returns the remaining LSR bits not handled
> =A0* by this Rx routine.
> @@ -1386,20 +1365,10 @@ serial8250_rx_chars(struct uart_8250_port *up=
, unsigned char lsr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up->lsr_saved_flags =3D 0;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (unlikely(lsr & UART_LSR_BRK_ERROR_=
BITS)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* For statistics onl=
y
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (lsr & UART_LSR_BI)=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lsr &=3D=
 ~(UART_LSR_FE | UART_LSR_PE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port->=
icount.brk++;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* If=
 tegra port then clear the rx fifo to
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* ac=
cept another break/character.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (por=
t->type =3D=3D PORT_TEGRA)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 clear_rx_fifo(up);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * We =
do the SysRQ and SAK checking
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * her=
e because otherwise the break
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * may=
 get masked by ignore_status_mask
> @@ -3037,6 +3006,7 @@ static int __devinit serial8250_probe(struct pl=
atform_device *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port.serial_in =A0 =A0 =A0 =A0 =A0=3D =
p->serial_in;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port.serial_out =A0 =A0 =A0 =A0 =3D p-=
>serial_out;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port.handle_irq =A0 =A0 =A0 =A0 =3D p-=
>handle_irq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port.handle_break =A0 =A0 =A0 =3D p->ha=
ndle_break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port.set_termios =A0 =A0 =A0 =A0=3D p-=
>set_termios;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port.pm =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D p->pm;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0port.dev =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
=3D &dev->dev;
> @@ -3209,6 +3179,8 @@ int serial8250_register_port(struct uart_port *=
port)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart->port.set_termios=
 =3D port->set_termios;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (port->pm)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uart->port.pm =3D port=
->pm;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (port->handle_break)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uart->port.handle_break=
 =3D port->handle_break;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (serial8250_isa_config !=3D NULL)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0serial8250_isa_config(=
0, &uart->port,
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 665beb6..33fa6ec 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -380,6 +380,14 @@ config SERIAL_PXA_CONSOLE
> =A0 =A0 =A0 =A0 =A0your boot loader (lilo or loadlin) about how to pa=
ss options to the
> =A0 =A0 =A0 =A0 =A0kernel at boot time.)
>
> +# FIXME remove this option when Tegra completes conversion to open f=
irmware
> +config SERIAL_TEGRA
> + =A0 =A0 =A0 bool "Tegra serial port support"
> + =A0 =A0 =A0 depends on SERIAL_OF_PLATFORM=3Dy
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 If you have a machine based on NVIDIA Tegra you can=
 enable its
> + =A0 =A0 =A0 =A0 onboard serial ports by enabling this option.
> +
> =A0config SERIAL_SA1100
> =A0 =A0 =A0 =A0bool "SA1100 serial port support"
> =A0 =A0 =A0 =A0depends on ARM && ARCH_SA1100
> diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_s=
erial.c
> index e8c9cee..b692528 100644
> --- a/drivers/tty/serial/of_serial.c
> +++ b/drivers/tty/serial/of_serial.c
> @@ -12,8 +12,10 @@
> =A0#include <linux/init.h>
> =A0#include <linux/module.h>
> =A0#include <linux/slab.h>
> +#include <linux/delay.h>
> =A0#include <linux/serial_core.h>
> =A0#include <linux/serial_8250.h>
> +#include <linux/serial_reg.h>
> =A0#include <linux/of_address.h>
> =A0#include <linux/of_irq.h>
> =A0#include <linux/of_platform.h>
> @@ -24,6 +26,26 @@ struct of_serial_info {
> =A0 =A0 =A0 =A0int line;
> =A0};
>
> +#if IS_ENABLED(CONFIG_SERIAL_TEGRA)
> +void tegra_serial_handle_break(struct uart_port *p)
> +{
> + =A0 =A0 =A0 unsigned int status, tmout =3D 10000;
> +
> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D p->serial_in(p, UART_LSR);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status & (UART_LSR_FIFOE | UART_LSR=
_BRK_ERROR_BITS))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D p->serial_in=
(p, UART_RX);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (--tmout =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(1);
> + =A0 =A0 =A0 } while (1);
> +}
> +/* FIXME remove this export when tegra finishes conversion to open f=
irmware */
> +EXPORT_SYMBOL_GPL(tegra_serial_handle_break);
> +#endif
> +
> =A0/*
> =A0* Fill a struct uart_port for a given device node
> =A0*/
> @@ -84,6 +106,9 @@ static int __devinit of_platform_serial_setup(stru=
ct platform_device *ofdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| UPF_FIXED_PORT | UPF_FIXED_TYPE;
> =A0 =A0 =A0 =A0port->dev =3D &ofdev->dev;
>
> + =A0 =A0 =A0 if (type =3D=3D PORT_TEGRA)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->handle_break =3D tegra_serial_han=
dle_break;
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> diff --git a/include/linux/of_serial.h b/include/linux/of_serial.h
> new file mode 100644
> index 0000000..2035d96
> --- /dev/null
> +++ b/include/linux/of_serial.h
> @@ -0,0 +1,17 @@
> +#ifndef __LINUX_OF_SERIAL_H
> +#define __LINUX_OF_SERIAL_H
> +
> +/*
> + * FIXME remove this file when tegra finishes conversion to open fir=
mware,
> + * expectation is that all quirks will then be self-contained in
> + * drivers/tty/serial/of_serial.c.
> + */
> +#if IS_ENABLED(CONFIG_SERIAL_TEGRA)
> +extern void tegra_serial_handle_break(struct uart_port *port);
> +#else
> +static inline void tegra_serial_handle_break(struct uart_port *port)
> +{
> +}
> +#endif
> +
> +#endif /* __LINUX_OF_SERIAL */
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.=
h
> index 8f012f8..a522fd9 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -38,6 +38,7 @@ struct plat_serial8250_port {
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 (*handle_irq)(struct uart_=
port *);
> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0(*pm)(struct uart_port *, =
unsigned int state,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned o=
ld);
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0(*handle_break)(struct uart=
_port *);
> =A0};
>
> =A0/*
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.=
h
> index 2db407a..65db992 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -310,6 +310,7 @@ struct uart_port {
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (*handle_i=
rq)(struct uart_port *);
> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*pm)(stru=
ct uart_port *, unsigned int state,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0unsigned int old);
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*handle_br=
eak)(struct uart_port *);
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0irq; =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0/* irq number */
> =A0 =A0 =A0 =A0unsigned long =A0 =A0 =A0 =A0 =A0 irqflags; =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 /* irq flags =A0*/
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0uartclk; =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0/* base uart clock */
> @@ -533,6 +534,10 @@ uart_handle_sysrq_char(struct uart_port *port, u=
nsigned int ch)
> =A0static inline int uart_handle_break(struct uart_port *port)
> =A0{
> =A0 =A0 =A0 =A0struct uart_state *state =3D port->state;
> +
> + =A0 =A0 =A0 if (port->handle_break)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 port->handle_break(port);
> +
> =A0#ifdef SUPPORT_SYSRQ
> =A0 =A0 =A0 =A0if (port->cons && port->cons->index =3D=3D port->line)=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!port->sysrq) {
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
