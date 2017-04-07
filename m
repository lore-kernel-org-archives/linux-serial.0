From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: Supporting early console on a SERIAL_8250_RT288X platform
Date: Fri, 7 Apr 2017 13:18:40 +0100
Message-ID: <d797386a-009e-f21d-dec4-a7520b4f6a72@arm.com>
References: <0ac351b9-46bd-3a35-fab3-73177cabb747@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <0ac351b9-46bd-3a35-fab3-73177cabb747@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mason <slash.tmp@free.fr>, linux-serial <linux-serial@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>
Cc: Rob Herring <robh@kernel.org>, Mans Rullgard <mans@mansr.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Jean Delvare <jdelvare@suse.de>, Jiri Slaby <jslaby@suse.com>, Andreas Farber <afaerber@suse.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On 07/04/17 12:53, Mason wrote:
> Hello,
> 
> Some drivers hang or panic before the normal console is available.
> In these situations, "earlyprintk" is a life-saver.
> 
> My problem with earlyprintk is that the UART address needs to be
> hard-coded in the kernel binary, which means I can't use the same
> binary for two chips with different UART addresses, right?
> 
> As far as I understand, "earlycon" helps in that situation, because
> it looks up the UART address at run-time in the device tree.
> 
> 
> QUESTION #1
> 
> Is that the only difference between earlyprintk and earlycon?
> (Probably not, see below)
> 
> 
> I hacked kernel v4.9.20 to add early console support on my platform.
> The patch is provided below, I'd like to hear comments on what needs
> fixing... because something is not right. If I call panic() in one of
> my driver's probe function, I don't see the output of the panic()
> call, which makes the whole exercise rather pointless.
> 
> This is what I see:
> 
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.9.20-1-rc3 (gcc version 5.3.1 20160113 (Linaro GCC 5.3-2016.02) ) #4 SMP PREEMPT Fri Apr 7 12:57
> [    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
> [    0.000000] OF: fdt:Machine model: Sigma Designs SMP8758 Vantage-1172 Rev E1
> [    0.000000] ENTER param_setup_earlycon
> [    0.000000] ENTER early_init_dt_scan_chosen_stdout
> [    0.000000] early_init_dt_scan_chosen_stdout: scan __earlycon_table
> [    0.000000] name=palmchip compatible=ralink,rt2880-uart setup=early_palmchip_setup
> [    0.000000] ENTER of_setup_earlycon
> [    0.000000] earlycon: palmchip0 at MMIO 0x00010700 (options '115200n8')
> [    0.000000] bootconsole [palmchip0] enabled
> [    0.000000] Memory policy: Data cache writealloc
> [    0.000000] percpu: Embedded 14 pages/cpu @cfdd6000 s24704 r8192 d24448 u57344
> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
> [    0.000000] Kernel command line: mem=256M earlycon
> [    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
> [    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> [    0.000000] Memory: 248064K/262144K available (4096K kernel code, 147K rwdata, 892K rodata, 6144K init, 233K bss, 14080K reserved, 0K cma-reserved, 0K highmem)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> [    0.000000]     vmalloc : 0xd0800000 - 0xff800000   ( 752 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
> [    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
> [    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
> [    0.000000]       .text : 0xc0008000 - 0xc0500000   (5088 kB)
> [    0.000000]       .init : 0xc0600000 - 0xc0c00000   (6144 kB)
> [    0.000000]       .data : 0xc0c00000 - 0xc0c24c60   ( 148 kB)
> [    0.000000]        .bss : 0xc0c24c60 - 0xc0c5f140   ( 234 kB)
> [    0.000000] Preemptible hierarchical RCU implementation.
> [    0.000000]  Build-time adjustment of leaf fanout to 32.
> [    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
> [    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=2
> [    0.000000] NR_IRQS:16 nr_irqs:16 16
> [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
> [    0.000000] L2C-310 ID prefetch enabled, offset 4 lines
> [    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
> [    0.000000] L2C-310 cache controller enabled, 8 ways, 512 kB
> [    0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x72860401
> [    0.000000] clocksource: tango-xtal: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 70787423951 ns
> [    0.000003] sched_clock: 32 bits at 27MHz, resolution 37ns, wraps every 79536431085ns
> [    0.007873] Switching to timer-based delay loop, resolution 37ns
> [    0.014146] Console: colour dummy device 80x30
> [    0.018616] console [tty0] enabled
> [    0.022039] bootconsole [palmchip0] disabled
> 
> And it just hangs there...
> 
> If I remove the panic() call, it boots normally, like this:
> 
> ...
> [    0.014147] Console: colour dummy device 80x30
> [    0.018616] console [tty0] enabled
> [    0.022039] bootconsole [palmchip0] disabled
> [    0.026345] Calibrating delay loop (skipped), value calculated using timer frequency.. 54.25 BogoMIPS (lpj=90000)
> [    0.026364] pid_max: default: 32768 minimum: 301
> ...
> 
> Did I implement something wrong?
> Why am I not seeing the output of the panic() call, like I do
> with earlyprintk?
> Since tty0 is enabled, why isn't it picking up where palmchip0
> left off?

As far as I'm aware, tty0 is a purely virtual console: look further down
still and you'll probably see a second switch over from tty0 to ttyS0,
which will be when the buffered output *actually* starts coming out
again. That's certainly what happens for me, albeit with
"pl11"->"tty0"->"ttyAMA0", (and complete with not realising ttyAMA0 is
still the same port and reprinting the entire log buffer from the top).

I believe this is something to do with how the DT stdout-path property
is implemented, because with an explicit "console=ttyAMA0" (or ttyS0 in
your case) on the command line instead of relying on stdout-path, the
boot console does switch directly to the real UART without the
intermediate tty0 blind spot.

Robin.

> 
> 
> Earlier discussion:
> https://www.spinics.net/lists/linux-serial/msg16227.html
> 
> 
> This is the patch I'm using:
> 
> diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
> index 85a12f032402..2adabe788c17 100644
> --- a/drivers/tty/serial/8250/8250_early.c
> +++ b/drivers/tty/serial/8250/8250_early.c
> @@ -172,3 +172,52 @@ static int __init early_omap8250_setup(struct earlycon_device *device,
>  OF_EARLYCON_DECLARE(omap8250, "ti,omap4-uart", early_omap8250_setup);
>  
>  #endif
> +
> +#ifdef CONFIG_SERIAL_8250_RT288X
> +
> +extern unsigned int au_serial_in(struct uart_port *p, int offset);
> +extern void au_serial_out(struct uart_port *p, int offset, int value);
> +
> +/*** Copy serial_putc with s/serial8250_early/au_serial/g ***/
> +
> +static void __init palmchip_putc(struct uart_port *port, int c)
> +{
> +	unsigned int status;
> +
> +	au_serial_out(port, UART_TX, c);
> +
> +	for (;;) {
> +		status = au_serial_in(port, UART_LSR);
> +		if ((status & BOTH_EMPTY) == BOTH_EMPTY)
> +			break;
> +		cpu_relax();
> +	}
> +}
> +
> +/*** Copy early_serial8250_write with s/serial_putc/palmchip_putc/g ***/
> +
> +static void __init early_palmchip_write(struct console *console,
> +					const char *s, unsigned int count)
> +{
> +	struct earlycon_device *device = console->data;
> +	struct uart_port *port = &device->port;
> +
> +	//extern void printascii(const char *); printascii("EARLY: ");
> +	uart_console_write(port, s, count, palmchip_putc);
> +}
> +
> +static int __init early_palmchip_setup(struct earlycon_device *device,
> +				       const char *options)
> +{
> +	struct uart_port *port = &device->port;
> +
> +	if (!(device->port.membase || device->port.iobase))
> +		return -ENODEV;
> +
> +	port->regshift = 2; /* Hard coding the value doesn't feel right */
> +	device->con->write = early_palmchip_write;
> +	return 0;
> +}
> +OF_EARLYCON_DECLARE(palmchip, "ralink,rt2880-uart", early_palmchip_setup);
> +
> +#endif
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 080d5a59d0a7..7eb60146cb3f 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -313,7 +313,7 @@ static void default_serial_dl_write(struct uart_8250_port *up, int value)
>  	-1,	/* UART_SCR (unmapped) */
>  };
>  
> -static unsigned int au_serial_in(struct uart_port *p, int offset)
> +/*static*/ unsigned int au_serial_in(struct uart_port *p, int offset)
>  {
>  	if (offset >= ARRAY_SIZE(au_io_in_map))
>  		return UINT_MAX;
> @@ -323,7 +323,7 @@ static unsigned int au_serial_in(struct uart_port *p, int offset)
>  	return __raw_readl(p->membase + (offset << p->regshift));
>  }
>  
> -static void au_serial_out(struct uart_port *p, int offset, int value)
> +/*static*/ void au_serial_out(struct uart_port *p, int offset, int value)
>  {
>  	if (offset >= ARRAY_SIZE(au_io_out_map))
>  		return;
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
