From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: Re: No output on console despite ignore_loglevel earlyprintk
Date: Wed, 5 Apr 2017 18:37:20 +0200
Message-ID: <4c5b6e15-a64b-81ea-b2e1-494dab304c47@sigmadesigns.com>
References: <6d16a384-1a4c-bf27-fd81-ea3caf3de6b0@sigmadesigns.com>
 <20170303165548.GO21222@n2100.armlinux.org.uk>
 <3293964b-aec2-e8b8-46f5-49b0eacc4718@suse.de>
 <20170303174643.GQ21222@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170303174643.GQ21222@n2100.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Andreas Farber <afaerber@suse.de>
Cc: Rob Herring <robh@kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, linux-serial <linux-serial@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 03/03/2017 18:46, Russell King - ARM Linux wrote:

> On Fri, Mar 03, 2017 at 06:26:28PM +0100, Andreas F=E4rber wrote:
>
>> Am 03.03.2017 um 17:55 schrieb Russell King - ARM Linux:
>>
>>> On Fri, Mar 03, 2017 at 05:42:02PM +0100, Marc Gonzalez wrote:
>>>
>>>> I'm confused about early consoles and earlyprintk, and all that good s=
tuff.
>>>> When my kernel panics, I don't get the expected output.
>>>>
>>>> Using "mem=3D256M ignore_loglevel earlyprintk"
>>>>
>>>> [    0.014325] Console: colour dummy device 80x30
>>>> [    0.018885] console [tty0] enabled
>>>> [    0.022396] bootconsole [earlycon0] disabled
>>>>
>>>> And it hangs there.
>>>
>>> tty0 is the kernel virtual terminal console, which is what appears on
>>> VGA or framebuffers.  This is the default console if nothing else is
>>> specified.
>>>
>>> What happened here is that the virtual terminal console registered, was
>>> detected to be the system console, so early console was shut down, and
>>> the boot messages logged to the virtual terminal console instead.
>>
>> Why does passing console=3D make a difference though?
>>
>> I expect stdout-path to have the same effect as the command line, and I
>> am pretty sure that that was previous behavior in, e.g., v4.4.
>>
>> Note that I am using earlycon, as opposed to earlyprintk above.
> =

> The property is:
> =

> 	stdout-path =3D "dt-node-name:hw-parameters";
> =

> and this is parsed by the code in drivers/of/fdt.c,
> early_init_dt_scan_chosen_stdout() (briefly):
> =

>         offset =3D fdt_path_offset(fdt, "/chosen");
>         p =3D fdt_getprop(fdt, offset, "stdout-path", &l);
> =

>         q =3D strchrnul(p, ':');
>         if (*q !=3D '\0')
>                 options =3D q + 1;
>         l =3D q - p;
> =

>         /* Get the node specified by stdout-path */
>         offset =3D fdt_path_offset_namelen(fdt, p, l);
>         if (offset < 0) {
>                 pr_warn("earlycon: stdout-path %.*s not found\n", l, p);
> =

> So here, offset points at the node named by "dt-node-name" above.
> =

> This function then tries to patch the specified node's compatible with
> the drivers in the __earlycon_table:
> =

>         for (match =3D __earlycon_table; match < __earlycon_table_end; ma=
tch++) {
>                 if (!match->compatible[0])
>                         continue;
> =

>                 if (fdt_node_check_compatible(fdt, offset, match->compati=
ble))
>                         continue;
> =

> and when a match is found, calls:
> =

>                 of_setup_earlycon(match, offset, options);
> =

> Here, we go into the code in drivers/tty/serial/earlycon.c, which reads
> the standard properties (like "reg", etc) filling out a uart_port
> before calling the early console's ->setup method.  If everything goes
> to plan, register_console() is called to register the early console.
> =

> So there's nothing there which changes the default system console.
> =

> The next place is of_alias_scan() in drivers/of/base.c.  This records
> the device_node and options in of_stdout and of_stdout_options
> respectively - it, again, does not change the default system console.
> =

> When a serial console is initialised, of_console_check() gets called by
> serial core to check whether the DT node for it is "of_stdout", and if
> it matches, it modifies the preferred system console.
> =

> This all looks good, and one might expect that it has the desired
> effect, but this code is fatally flawed in design: the point at which
> of_console_check() gets called is _way_ after consoles like the virtual
> terminal console get initialised.  What this means is that, at the point
> in time that the virtual terminal is initialised, as far as the console
> system is concerned, the preferred console is still the virtual terminal.
> It knows nothing about the desire for a different console.
> =

> Given the current console handling, it's not easy to solve without
> overhauling the way consoles are chosen - the root problem is that the
> Linux console system works via Linux device driver names and indexes,
> and there's no easy way to translate a DT stdout-path property to a
> Linux device driver name and index without the driver having been
> initialised.

Time for me to take another stab at this issue.


Relevant parts of my DT:

	aliases { serial =3D &uart; };

	chosen { stdout-path =3D "serial:115200n8"; };

		uart: serial@10700 {
			compatible =3D "ralink,rt2880-uart";
			reg =3D <0x10700 0x30>;
			interrupts =3D <1 IRQ_TYPE_LEVEL_HIGH>;
			clock-frequency =3D <7372800>;
			reg-shift =3D <2>;
		};


Relevant part of my kernel config:

CONFIG_FIX_EARLYCON_MEM=3Dy
CONFIG_GENERIC_EARLY_IOREMAP=3Dy
CONFIG_OF_EARLY_FLATTREE=3Dy

#
# Character devices
#
CONFIG_TTY=3Dy
CONFIG_VT=3Dy
CONFIG_CONSOLE_TRANSLATIONS=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_HW_CONSOLE=3Dy
# CONFIG_VT_HW_CONSOLE_BINDING is not set
CONFIG_UNIX98_PTYS=3Dy
CONFIG_LEGACY_PTYS=3Dy
CONFIG_LEGACY_PTY_COUNT=3D256
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=3Dy
CONFIG_SERIAL_8250=3Dy
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=3Dy
CONFIG_SERIAL_8250_DMA=3Dy
CONFIG_SERIAL_8250_PCI=3Dy
CONFIG_SERIAL_8250_NR_UARTS=3D4
CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_FSL=3Dy
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_EM is not set
CONFIG_SERIAL_8250_RT288X=3Dy
# CONFIG_SERIAL_8250_MOXA is not set
CONFIG_SERIAL_OF_PLATFORM=3Dy

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_EARLYCON_ARM_SEMIHOST is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_BCM63XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_ST_ASC is not set
# CONFIG_SERIAL_STM32 is not set
# CONFIG_HVC_DCC is not set
# CONFIG_IPMI_HANDLER is not set
# CONFIG_HW_RANDOM is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_RAW_DRIVER is not set
# CONFIG_TCG_TPM is not set
CONFIG_DEVPORT=3Dy
# CONFIG_XILLYBUS is not set

CONFIG_DEBUG_LL_INCLUDE=3D"mach/debug-macro.S"
# CONFIG_DEBUG_UART_8250 is not set
CONFIG_UNCOMPRESS_INCLUDE=3D"debug/uncompress.h"


Booting with mem=3D256M console=3DttyS0,115200

[    0.000213] Console: colour dummy device 80x30
[    0.418383] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.419837] console [ttyS0] disabled
[    0.419983] 10700.serial: ttyS0 at MMIO 0x10700 (irq =3D 20, base_baud =
=3D 460800) is a Palmchip BK-3103
[    1.000504] console [ttyS0] enabled


Booting with mem=3D256M

[    0.000212] Console: colour dummy device 80x30
[    0.000547] console [tty0] enabled
[    0.427260] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.428970] 10700.serial: ttyS0 at MMIO 0x10700 (irq =3D 20, base_baud =
=3D 460800) is a Palmchip BK-3103
[    1.007672] console [ttyS0] enabled


Booting with mem=3D256M earlycon

[    0.000000] ENTER param_setup_earlycon
[    0.000000] ENTER early_init_dt_scan_chosen_stdout
[    0.000000] early_init_dt_scan_chosen_stdout: scan __earlycon_table
[    0.000000] name=3Duart compatible=3Dsnps,dw-apb-uart setup=3Dearly_seri=
al8250_setup
[    0.000000] name=3Duart compatible=3Dnvidia,tegra20-uart setup=3Dearly_s=
erial8250_setup
[    0.000000] name=3Dns16550a compatible=3Dns16550a setup=3Dearly_serial82=
50_setup
[    0.000000] name=3Dns16550 compatible=3Dns16550 setup=3Dearly_serial8250=
_setup
[    0.000000] early_init_dt_scan_chosen_stdout: NO MATCH, return ENODEV
[    0.000000] Malformed early option 'earlycon'
[    0.000215] Console: colour dummy device 80x30
[    0.000583] console [tty0] enabled
[    0.420043] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.421945] 10700.serial: ttyS0 at MMIO 0x10700 (irq =3D 20, base_baud =
=3D 460800) is a Palmchip BK-3103
[    1.014251] console [ttyS0] enabled


drivers/tty/serial/8250/8250_early.c

int __init early_serial8250_setup(struct earlycon_device *device, const cha=
r *options)

EARLYCON_DECLARE(uart8250, early_serial8250_setup);
EARLYCON_DECLARE(uart, early_serial8250_setup);
OF_EARLYCON_DECLARE(ns16550, "ns16550", early_serial8250_setup);
OF_EARLYCON_DECLARE(ns16550a, "ns16550a", early_serial8250_setup);
OF_EARLYCON_DECLARE(uart, "nvidia,tegra20-uart", early_serial8250_setup);
OF_EARLYCON_DECLARE(uart, "snps,dw-apb-uart", early_serial8250_setup);

I'm not matching anything, because my UART compatible string is:

		uart: serial@10700 {
			compatible =3D "ralink,rt2880-uart";

If I append "ns16550a" or "ns16550", the kernel hangs from the start:

Starting kernel ...

@


But if I add DEBUG_LL support with

CONFIG_DEBUG_LL=3Dy
CONFIG_DEBUG_LL_UART_8250=3Dy
CONFIG_DEBUG_UART_PHYS=3D0x10700
CONFIG_DEBUG_UART_VIRT=3D0xf0010700
CONFIG_DEBUG_UART_8250_WORD=3Dy
CONFIG_DEBUG_UART_8250_PALMCHIP=3Dy

and replace the implementation of vprintk_emit() with a very quick and dirty

	char buf[400];
	extern void printascii(const char *);
	text_len =3D vsnprintf(buf, sizeof buf, fmt, args);
	printascii(buf);
	return text_len;

then the kernel boots correctly, and I see the following relevant logs:

ENTER param_setup_earlycon
ENTER early_init_dt_scan_chosen_stdout
early_init_dt_scan_chosen_stdout: scan __earlycon_table
name=3Duart compatible=3Dsnps,dw-apb-uart setup=3Dearly_serial8250_setup
name=3Duart compatible=3Dnvidia,tegra20-uart setup=3Dearly_serial8250_setup
name=3Dns16550a compatible=3Dns16550a setup=3Dearly_serial8250_setup
ENTER of_setup_earlycon
earlycon: ns16550a0 at MMIO 0x00010700 (options '115200n8')
bootconsole [ns16550a0] enabled
Kernel command line: mem=3D256M earlycon
Console: colour dummy device 80x30
console [tty0] enabled
bootconsole [ns16550a0] disabled
Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
10700.serial: ttyS0 at MMIO 0x10700 (irq =3D 20, base_baud =3D 460800) is a=
 Palmchip BK-3103
console [ttyS0] enabled


I think the problem is that my UART (Palmchip BK-3103) requires
custom accessors to read/write 16550 registers. And these accessors
are probably ignored this early in the boot.

drivers/tty/serial/8250/8250_port.c

#ifdef CONFIG_SERIAL_8250_RT288X

/* Au1x00/RT288x UART hardware has a weird register layout */
static const s8 au_io_in_map[8] =3D {
	 0,	/* UART_RX  */
	 2,	/* UART_IER */
	 3,	/* UART_IIR */
	 5,	/* UART_LCR */
	 6,	/* UART_MCR */
	 7,	/* UART_LSR */
	 8,	/* UART_MSR */
	-1,	/* UART_SCR (unmapped) */
};

It is likely that I need to register a specific OF_EARLYCON_DECLARE,
like OMAP did?

Regards.
