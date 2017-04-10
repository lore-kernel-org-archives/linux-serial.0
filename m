From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: Re: [PATCH v2] serial: 8250_early: Add earlycon support for Palmchip
 UART
Date: Mon, 10 Apr 2017 13:39:10 +0200
Message-ID: <a42b120f-146e-060d-55d5-86e2f2e0691b@sigmadesigns.com>
References: <7a016ff6-08fc-2811-92e0-7c4603fa8586@sigmadesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7a016ff6-08fc-2811-92e0-7c4603fa8586@sigmadesigns.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@arm.linux.org.uk>, Andreas Farber <afaerber@suse.de>, Jean Delvare <jdelvare@suse.de>, Rob Herring <robh@kernel.org>, Mans Rullgard <mans@mansr.com>, Jiri Slaby <jslaby@suse.cz>, Masahiro Yamada <yamada.masahiro@socionext.com>, Vineet Gupta <vgupta@synopsys.com>, Scott Wood <oss@buserror.net>, Robin Murphy <robin.murphy@arm.com>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Linux ARM <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 10/04/2017 11:47, Marc Gonzalez wrote:

> Define an OF early console for Palmchip UART, which can be enabled
> by passing "earlycon" on the boot command line.
> 
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  drivers/tty/serial/8250/8250_early.c | 24 ++++++++++++++++++++++++
>  drivers/tty/serial/8250/8250_port.c  |  4 ++--
>  2 files changed, 26 insertions(+), 2 deletions(-)

As pointed out by Andreas, Russell, and Robin, specifying
the console on the command line is still required. In other
words, the stdout-path method is not 100% functional.


Testing different boot command-lines, with a kernel that
artificially panics in the early stages:

"mem=256M"
"mem=256M console=ttyS0,115200"
prints nothing, as expected.


"mem=256M earlycon"
does not show the panic message.
Hangs after printing:
[    0.014146] Console: colour dummy device 80x30
[    0.018615] console [tty0] enabled
[    0.022038] bootconsole [palmchip0] disabled


"mem=256M console=ttyS0,115200 earlycon"
"mem=256M console=ttyS0 earlycon"
the panic message does appear, as expected.


When I remove the panic, "mem=256M console=ttyS0 earlycon"
stops printing kernel messages when the kernel switches
the early console off.
[    0.750562] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.758976] console [ttyS0] disabled
[    0.762664] 10700.serial: ttyS0 at MMIO 0x10700 (irq = 20, base_baud = 460800) is a Palmchip BK-3103


Therefore, the only 100% functional combination for me is
"mem=256M console=ttyS0,115200 earlycon"


For completeness, this method shows some "stuttering" in
the console handling code:

[    0.000000] earlycon: palmchip0 at MMIO 0x00010700 (options '115200n8')
[    0.000000] bootconsole [palmchip0] enabled
[    0.000000] Kernel command line: mem=256M console=ttyS0,115200 earlycon
[    0.014149] Console: colour dummy device 80x30
[    0.754670] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.763045] console [ttyS0] disabled
[    0.766733] 10700.serial: ttyS0 at MMIO 0x10700 (irq = 20, base_baud = 460800) is a Palmchip BK-3103
[    0.775969] console [ttyS0] enabled
[    0.775969] console [ttyS0] enabled
[    0.782979] bootconsole [palmchip0] disabled
[    0.782979] bootconsole [palmchip0] disabled

This stuttering is likely related to this comment:

	/*
	 * By unregistering the bootconsoles after we enable the real console
	 * we get the "console xxx enabled" message on all the consoles -
	 * boot consoles, real consoles, etc - this is to ensure that end
	 * users know there might be something in the kernel's log buffer that
	 * went to the bootconsole (that they do not see on the real console)
	 */

In fact, if I add dump_stack() before
pr_info("%sconsole [%s%d] enabled\n",
pr_info("%sconsole [%s%d] disabled\n",

then I get the following output:

[    0.000000] earlycon: palmchip0 at MMIO 0x00010700 (options '115200n8')
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.9.20-1-rc3 #18
[    0.000000] Hardware name: Sigma Tango DT
[    0.000000] [<c010ed6c>] (unwind_backtrace) from [<c010adc4>] (show_stack+0x10/0x14)
[    0.000000] [<c010adc4>] (show_stack) from [<c02cca50>] (dump_stack+0x84/0x98)
[    0.000000] [<c02cca50>] (dump_stack) from [<c0157b3c>] (register_console+0x224/0x3c8)
[    0.000000] [<c0157b3c>] (register_console) from [<c06189f0>] (of_setup_earlycon+0x1cc/0x1e0)
[    0.000000] [<c06189f0>] (of_setup_earlycon) from [<c061c0a0>] (early_init_dt_scan_chosen_stdout+0x144/0x158)
[    0.000000] [<c061c0a0>] (early_init_dt_scan_chosen_stdout) from [<c0600488>] (do_early_param+0x78/0xbc)
[    0.000000] [<c0600488>] (do_early_param) from [<c0132aec>] (parse_args+0x284/0x3d8)
[    0.000000] [<c0132aec>] (parse_args) from [<c06008a0>] (parse_early_options+0x3c/0x44)
[    0.000000] [<c06008a0>] (parse_early_options) from [<c06008d8>] (parse_early_param+0x30/0x44)
[    0.000000] [<c06008d8>] (parse_early_param) from [<c0603274>] (setup_arch+0x5b8/0xa48)
[    0.000000] [<c0603274>] (setup_arch) from [<c060094c>] (start_kernel+0x5c/0x380)
[    0.000000] [<c060094c>] (start_kernel) from [<8000807c>] (0x8000807c)
[    0.000000] bootconsole [palmchip0] enabled

(Lines 2 and 3 are a strange relic of the very first lines output.)

[    0.750471] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.758744] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.9.20-1-rc3 #18
[    0.765317] Hardware name: Sigma Tango DT
[    0.769376] [<c010ed6c>] (unwind_backtrace) from [<c010adc4>] (show_stack+0x10/0x14)
[    0.777162] [<c010adc4>] (show_stack) from [<c02cca50>] (dump_stack+0x84/0x98)
[    0.784430] [<c02cca50>] (dump_stack) from [<c01577e0>] (unregister_console+0xc/0x144)
[    0.792395] [<c01577e0>] (unregister_console) from [<c033cf20>] (uart_remove_one_port+0x1d0/0x1fc)
[    0.801404] [<c033cf20>] (uart_remove_one_port) from [<c033e5c0>] (serial8250_register_8250_port+0x94/0x380)
[    0.811291] [<c033e5c0>] (serial8250_register_8250_port) from [<c0345da8>] (of_platform_serial_probe+0x3f0/0x4ac)
[    0.821614] [<c0345da8>] (of_platform_serial_probe) from [<c0350d88>] (platform_drv_probe+0x34/0x7c)
[    0.830796] [<c0350d88>] (platform_drv_probe) from [<c034f824>] (really_probe+0x1c4/0x254)
[    0.839103] [<c034f824>] (really_probe) from [<c034f978>] (__driver_attach+0xc4/0xc8)
[    0.846972] [<c034f978>] (__driver_attach) from [<c034dd4c>] (bus_for_each_dev+0x68/0x9c)
[    0.855192] [<c034dd4c>] (bus_for_each_dev) from [<c034ee90>] (bus_add_driver+0x1a0/0x218)
[    0.863498] [<c034ee90>] (bus_add_driver) from [<c034fed4>] (driver_register+0x78/0xf8)
[    0.871542] [<c034fed4>] (driver_register) from [<c0101754>] (do_one_initcall+0x44/0x174)
[    0.879770] [<c0101754>] (do_one_initcall) from [<c0600dc4>] (kernel_init_freeable+0x154/0x1e4)
[    0.888516] [<c0600dc4>] (kernel_init_freeable) from [<c04b2fc8>] (kernel_init+0x8/0x10c)
[    0.896736] [<c04b2fc8>] (kernel_init) from [<c0107738>] (ret_from_fork+0x14/0x3c)
[    0.904409] console [ttyS0] disabled
[    0.908072] 10700.serial: ttyS0 at MMIO 0x10700 (irq = 20, base_baud = 460800) is a Palmchip BK-3103
[    0.917316] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.9.20-1-rc3 #18
[    0.917316] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.9.20-1-rc3 #18
[    0.930425] Hardware name: Sigma Tango DT
[    0.930425] Hardware name: Sigma Tango DT
[    0.938477] [<c010ed6c>] (unwind_backtrace) from [<c010adc4>] (show_stack+0x10/0x14)
[    0.938477] [<c010ed6c>] (unwind_backtrace) from [<c010adc4>] (show_stack+0x10/0x14)
[    0.954036] [<c010adc4>] (show_stack) from [<c02cca50>] (dump_stack+0x84/0x98)
[    0.954036] [<c010adc4>] (show_stack) from [<c02cca50>] (dump_stack+0x84/0x98)
[    0.968548] [<c02cca50>] (dump_stack) from [<c0157b3c>] (register_console+0x224/0x3c8)
[    0.968548] [<c02cca50>] (dump_stack) from [<c0157b3c>] (register_console+0x224/0x3c8)
[    0.984458] [<c0157b3c>] (register_console) from [<c033cc98>] (uart_add_one_port+0x424/0x4dc)
[    0.984458] [<c0157b3c>] (register_console) from [<c033cc98>] (uart_add_one_port+0x424/0x4dc)
[    1.001590] [<c033cc98>] (uart_add_one_port) from [<c033e794>] (serial8250_register_8250_port+0x268/0x380)
[    1.001590] [<c033cc98>] (uart_add_one_port) from [<c033e794>] (serial8250_register_8250_port+0x268/0x380)
[    1.020995] [<c033e794>] (serial8250_register_8250_port) from [<c0345da8>] (of_platform_serial_probe+0x3f0/0x4ac)
[    1.020995] [<c033e794>] (serial8250_register_8250_port) from [<c0345da8>] (of_platform_serial_probe+0x3f0/0x4ac)
[    1.041621] [<c0345da8>] (of_platform_serial_probe) from [<c0350d88>] (platform_drv_probe+0x34/0x7c)
[    1.041621] [<c0345da8>] (of_platform_serial_probe) from [<c0350d88>] (platform_drv_probe+0x34/0x7c)
[    1.059975] [<c0350d88>] (platform_drv_probe) from [<c034f824>] (really_probe+0x1c4/0x254)
[    1.059975] [<c0350d88>] (platform_drv_probe) from [<c034f824>] (really_probe+0x1c4/0x254)
[    1.076580] [<c034f824>] (really_probe) from [<c034f978>] (__driver_attach+0xc4/0xc8)
[    1.076580] [<c034f824>] (really_probe) from [<c034f978>] (__driver_attach+0xc4/0xc8)
[    1.092311] [<c034f978>] (__driver_attach) from [<c034dd4c>] (bus_for_each_dev+0x68/0x9c)
[    1.092311] [<c034f978>] (__driver_attach) from [<c034dd4c>] (bus_for_each_dev+0x68/0x9c)
[    1.108742] [<c034dd4c>] (bus_for_each_dev) from [<c034ee90>] (bus_add_driver+0x1a0/0x218)
[    1.108742] [<c034dd4c>] (bus_for_each_dev) from [<c034ee90>] (bus_add_driver+0x1a0/0x218)
[    1.125347] [<c034ee90>] (bus_add_driver) from [<c034fed4>] (driver_register+0x78/0xf8)
[    1.125347] [<c034ee90>] (bus_add_driver) from [<c034fed4>] (driver_register+0x78/0xf8)
[    1.141429] [<c034fed4>] (driver_register) from [<c0101754>] (do_one_initcall+0x44/0x174)
[    1.141429] [<c034fed4>] (driver_register) from [<c0101754>] (do_one_initcall+0x44/0x174)
[    1.157862] [<c0101754>] (do_one_initcall) from [<c0600dc4>] (kernel_init_freeable+0x154/0x1e4)
[    1.157862] [<c0101754>] (do_one_initcall) from [<c0600dc4>] (kernel_init_freeable+0x154/0x1e4)
[    1.175342] [<c0600dc4>] (kernel_init_freeable) from [<c04b2fc8>] (kernel_init+0x8/0x10c)
[    1.175342] [<c0600dc4>] (kernel_init_freeable) from [<c04b2fc8>] (kernel_init+0x8/0x10c)
[    1.191773] [<c04b2fc8>] (kernel_init) from [<c0107738>] (ret_from_fork+0x14/0x3c)
[    1.191773] [<c04b2fc8>] (kernel_init) from [<c0107738>] (ret_from_fork+0x14/0x3c)
[    1.207013] console [ttyS0] enabled
[    1.207013] console [ttyS0] enabled
[    1.214019] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.9.20-1-rc3 #18
[    1.214019] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.9.20-1-rc3 #18
[    1.227126] Hardware name: Sigma Tango DT
[    1.227126] Hardware name: Sigma Tango DT
[    1.235175] [<c010ed6c>] (unwind_backtrace) from [<c010adc4>] (show_stack+0x10/0x14)
[    1.235175] [<c010ed6c>] (unwind_backtrace) from [<c010adc4>] (show_stack+0x10/0x14)
[    1.250732] [<c010adc4>] (show_stack) from [<c02cca50>] (dump_stack+0x84/0x98)
[    1.250732] [<c010adc4>] (show_stack) from [<c02cca50>] (dump_stack+0x84/0x98)
[    1.265242] [<c02cca50>] (dump_stack) from [<c01577e0>] (unregister_console+0xc/0x144)
[    1.265242] [<c02cca50>] (dump_stack) from [<c01577e0>] (unregister_console+0xc/0x144)
[    1.281149] [<c01577e0>] (unregister_console) from [<c0157bc8>] (register_console+0x2b0/0x3c8)
[    1.281149] [<c01577e0>] (unregister_console) from [<c0157bc8>] (register_console+0x2b0/0x3c8)
[    1.298455] [<c0157bc8>] (register_console) from [<c033cc98>] (uart_add_one_port+0x424/0x4dc)
[    1.298455] [<c0157bc8>] (register_console) from [<c033cc98>] (uart_add_one_port+0x424/0x4dc)
[    1.315586] [<c033cc98>] (uart_add_one_port) from [<c033e794>] (serial8250_register_8250_port+0x268/0x380)
[    1.315586] [<c033cc98>] (uart_add_one_port) from [<c033e794>] (serial8250_register_8250_port+0x268/0x380)
[    1.334989] [<c033e794>] (serial8250_register_8250_port) from [<c0345da8>] (of_platform_serial_probe+0x3f0/0x4ac)
[    1.334989] [<c033e794>] (serial8250_register_8250_port) from [<c0345da8>] (of_platform_serial_probe+0x3f0/0x4ac)
[    1.355614] [<c0345da8>] (of_platform_serial_probe) from [<c0350d88>] (platform_drv_probe+0x34/0x7c)
[    1.355614] [<c0345da8>] (of_platform_serial_probe) from [<c0350d88>] (platform_drv_probe+0x34/0x7c)
[    1.373968] [<c0350d88>] (platform_drv_probe) from [<c034f824>] (really_probe+0x1c4/0x254)
[    1.373968] [<c0350d88>] (platform_drv_probe) from [<c034f824>] (really_probe+0x1c4/0x254)
[    1.390574] [<c034f824>] (really_probe) from [<c034f978>] (__driver_attach+0xc4/0xc8)
[    1.390574] [<c034f824>] (really_probe) from [<c034f978>] (__driver_attach+0xc4/0xc8)
[    1.406305] [<c034f978>] (__driver_attach) from [<c034dd4c>] (bus_for_each_dev+0x68/0x9c)
[    1.406305] [<c034f978>] (__driver_attach) from [<c034dd4c>] (bus_for_each_dev+0x68/0x9c)
[    1.422735] [<c034dd4c>] (bus_for_each_dev) from [<c034ee90>] (bus_add_driver+0x1a0/0x218)
[    1.422735] [<c034dd4c>] (bus_for_each_dev) from [<c034ee90>] (bus_add_driver+0x1a0/0x218)
[    1.439339] [<c034ee90>] (bus_add_driver) from [<c034fed4>] (driver_register+0x78/0xf8)
[    1.439339] [<c034ee90>] (bus_add_driver) from [<c034fed4>] (driver_register+0x78/0xf8)
[    1.455421] [<c034fed4>] (driver_register) from [<c0101754>] (do_one_initcall+0x44/0x174)
[    1.455421] [<c034fed4>] (driver_register) from [<c0101754>] (do_one_initcall+0x44/0x174)
[    1.471854] [<c0101754>] (do_one_initcall) from [<c0600dc4>] (kernel_init_freeable+0x154/0x1e4)
[    1.471854] [<c0101754>] (do_one_initcall) from [<c0600dc4>] (kernel_init_freeable+0x154/0x1e4)
[    1.489332] [<c0600dc4>] (kernel_init_freeable) from [<c04b2fc8>] (kernel_init+0x8/0x10c)
[    1.489332] [<c0600dc4>] (kernel_init_freeable) from [<c04b2fc8>] (kernel_init+0x8/0x10c)
[    1.505763] [<c04b2fc8>] (kernel_init) from [<c0107738>] (ret_from_fork+0x14/0x3c)
[    1.505763] [<c04b2fc8>] (kernel_init) from [<c0107738>] (ret_from_fork+0x14/0x3c)
[    1.521038] bootconsole [palmchip0] disabled
[    1.521038] bootconsole [palmchip0] disabled


Maybe it's possible to detect when console and earlycon are
the same, and avoid a pair of unregister/register calls.

Regards.
