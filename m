From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 1/5] ARM: davinci: uart: move to devid based clk_get
Date: Fri, 7 Jun 2013 11:05:47 +0530
Message-ID: <51B17133.40508@ti.com>
References: <1369729686-6595-1-git-send-email-prakash.pm@ti.com>
	<1369729686-6595-2-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1369729686-6595-2-git-send-email-prakash.pm-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hs-ynQEQJNshbs@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 5/28/2013 1:58 PM, Manjunathappa, Prakash wrote:
> For modules having single clock, clk_get should be done with dev_id.
> But current davinci implementation handles multiple instances
> of the UART devices with single platform_device_register. Hence clk_get
> is based on con_id rather than dev_id, this is not correct. Do
> platform_device_register for each instance and clk_get on dev_id.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm-l0cyMroinI0@public.gmane.org>

> +struct platform_device da8xx_serial_device[] = {
> +	{
> +		.name	= "serial8250",
> +		.id	= PLAT8250_DEV_PLATFORM,
> +		.dev	= {
> +			.platform_data	= da8xx_serial0_pdata
> +		}
>  	},
> +	{
> +		.name	= "serial8250",
> +		.id	= PLAT8250_DEV_PLATFORM1,
> +		.dev	= {
> +			.platform_data	= da8xx_serial1_pdata
> +		}
> +	},
> +	{
> +		.name	= "serial8250",
> +		.id	= PLAT8250_DEV_PLATFORM2,
> +		.dev	= {
> +			.platform_data	= da8xx_serial2_pdata
> +		}
> +	}

You should include trailing ',' when defining structures like these
(except on the sentinel value).

> diff --git a/arch/arm/mach-davinci/include/mach/serial.h b/arch/arm/mach-davinci/include/mach/serial.h
> index 62ad300..34d9877 100644
> --- a/arch/arm/mach-davinci/include/mach/serial.h
> +++ b/arch/arm/mach-davinci/include/mach/serial.h
> @@ -44,6 +44,10 @@ struct davinci_uart_config {
>  
>  extern int davinci_serial_init(struct davinci_uart_config *);
>  extern int davinci_serial_setup_clk(unsigned instance, unsigned int *rate);
> +extern struct platform_device dm365_serial_device[];
> +extern struct platform_device dm355_serial_device[];
> +extern struct platform_device dm644x_serial_device[];
> +extern struct platform_device dm646x_serial_device[];

This patch fails to build because of these extern definitions here.
Looks like they belong to 5/5. Also, add them to the local davinci.h
instead of globally visible serial.h - no need for rest of the kernel to
know about these.

After this is fixed locally, applying this patch to master branch of my
tree leads to the attached crash (sorry about the broken linewrap, I
hope its readable). Please fix this issue along with others that I
already pointed out and resubmit.

Thanks,
Sekhar

Serial: 8250/16550 driver, 3 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0x1c20000 (irq = 40) is a 16550A
console [ttyS0] enabled
serial8250 serial8250.0: unable to register port at index 1 (IO0
MEM1c20400 IRQ41): -22
serial8250 serial8250.0: unable to register port at index 2 (IO0
MEM1c20800 IRQ42): -22
Unable to handle kernel paging request at virtual address 019bfcc0
pgd = c0004000
[019bfcc0] *pgd=00000000
Internal error: Oops: 80000005 [#1] PREEMPT ARM
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Not tainted 3.10.0-rc4-08028-gc89afd8-dirty #32
task: cf836000 ti: cf838000 task.ti: cf838000
PC is at 0x19bfcc0
LR is at serial8250_config_port+0x13c/0x668
pc : [<019bfcc0>]    lr : [<c01bb99c>]    psr: 40000093
sp : cf839bd0  ip : cf839bd0  fp : cf839c04
r10: c03f6528  r9 : c0396484  r8 : 00000000
r7 : 20000013  r6 : fffffffe  r5 : 00000001  r4 : c03f6628
r3 : 019bfcc0  r2 : 10000002  r1 : 00000001  r0 : c03f6628
Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005317f  Table: 80004000  DAC: 00000017
Process swapper (pid: 1, stack limit = 0xcf8381b8)
Stack: (0xcf839bd0 to 0xcf83a000)
9bc0:                                     cf8acd08 cf838000 c0396484
cf8accb0
9be0: c03ccbf4 c03f6628 cf8acd08 cf838000 c0396484 c03f6528 cf839c94
cf839c08
9c00: c01b6584 c01bb870 cf8e3cfc 0000000f cf8acd08 c03ccbf4 cf839c44
cf839c28
9c20: c0178bf8 c0178d08 0000000f cf8acd08 c03ccacc cf838000 cf839c64
cf839c48
9c40: c02a8150 c005167c 00000000 cf8accb0 cf8acd08 c03ccbf4 cf839c74
cf839c68
9c60: c02a8224 c02a80f4 cf839c94 cf839cd0 c03f6628 00000003 c03f6728
c03f6524
9c80: c0396484 c03f6528 cf839cbc cf839c98 c01ba788 c01b6434 c03aecb0
00000003
9ca0: c03ada80 00000000 00000000 00000000 cf839df4 cf839cc0 c01ba8d8
c01ba518
9cc0: 01c20800 00000000 0000002a ffffffea 01c40800 fec40800 019bfcc0
0000001f
9ce0: c0332db0 ffffffff 00000000 00000000 00000000 019bfcc0 0000001f
00000000
9d00: 000c0000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
9d20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
9d40: 00000000 00000002 00000000 00000000 00000000 00000000 00000000
00000000
9d60: 00000001 c03ada80 000000c4 00000000 01c40c00 00000000 00000000
00000000
9d80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
9da0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
9dc0: 00000000 00000000 00000000 00000000 c00fb518 c03ada80 c03f6d70
c03adab4
9de0: c03ccc40 cfa0da10 cf839e04 cf839df8 c01c472c c01ba7c8 cf839e24
cf839e08
9e00: c01c32f8 c01c4720 c03ada80 c03ccc40 c03adab4 00000000 cf839e44
cf839e28
9e20: c01c352c c01c3284 00000000 00000000 c03ccc40 c01c3498 cf839e6c
cf839e48
9e40: c01c1894 c01c34a8 cf822258 cf894270 cf9b7cf4 c03ccc40 cf9b7cc0
c03cd240
9e60: cf839e7c cf839e70 c01c2e80 c01c1844 cf839eac cf839e80 c01c29fc
c01c2e70
9e80: c0332ed0 00000003 cf839eac c03ccc40 c03f6528 00000003 c02c3ba4
cfa0da10
9ea0: cf839ed4 cf839eb0 c01c3a54 c01c2930 c03ccbf4 c03f6528 00000003
c02c3ba4
9ec0: cfa0da10 00000000 cf839ee4 cf839ed8 c01c49f4 c01c39e4 cf839f0c
cf839ee8
9ee0: c038c0d8 c01c49b8 00000000 c039df5c 00000006 cf838000 c03d39a0
c038bfd0
9f00: cf839f4c cf839f10 c00088c4 c038bfe0 00000006 c0376610 00000000
c034b6ac
9f20: cf839f4c c039df5c 00000006 c03d39a0 c037826c c0396490 c0396484
0000004f
9f40: cf839f94 cf839f50 c0378968 c00087e8 00000006 00000006 c037826c
00000000
9f60: 00000000 00000000 cf839f94 00000000 c02a2a90 00000000 00000000
00000000
9f80: 00000000 00000000 cf839fac cf839f98 c02a2aa0 c0378884 00000000
00000000
9fa0: 00000000 cf839fb0 c00094d0 c02a2aa0 00000000 00000000 00000000
00000000
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000
00000000
Backtrace:
[<c01bb860>] (serial8250_config_port+0x0/0x668) from [<c01b6584>]
(uart_add_one_port+0x160/0x3d4)
[<c01b6424>] (uart_add_one_port+0x0/0x3d4) from [<c01ba788>]
(serial8250_register_8250_port+0x280/0x2b0)
[<c01ba508>] (serial8250_register_8250_port+0x0/0x2b0) from [<c01ba8d8>]
(serial8250_probe+0x120/0x174)
[<c01ba7b8>] (serial8250_probe+0x0/0x174) from [<c01c472c>]
(platform_drv_probe+0x1c/0x20)
 r8:cfa0da10 r7:c03ccc40 r6:c03adab4 r5:c03f6d70 r4:c03ada80
[<c01c4710>] (platform_drv_probe+0x0/0x20) from [<c01c32f8>]
(driver_probe_device+0x84/0x224)
[<c01c3274>] (driver_probe_device+0x0/0x224) from [<c01c352c>]
(__driver_attach+0x94/0x98)
 r7:00000000 r6:c03adab4 r5:c03ccc40 r4:c03ada80
[<c01c3498>] (__driver_attach+0x0/0x98) from [<c01c1894>]
(bus_for_each_dev+0x60/0x90)
 r6:c01c3498 r5:c03ccc40 r4:00000000 r3:00000000
[<c01c1834>] (bus_for_each_dev+0x0/0x90) from [<c01c2e80>]
(driver_attach+0x20/0x28)
 r6:c03cd240 r5:cf9b7cc0 r4:c03ccc40
[<c01c2e60>] (driver_attach+0x0/0x28) from [<c01c29fc>]
(bus_add_driver+0xdc/0x238)
[<c01c2920>] (bus_add_driver+0x0/0x238) from [<c01c3a54>]
(driver_register+0x80/0x154)
 r8:cfa0da10 r7:c02c3ba4 r6:00000003 r5:c03f6528 r4:c03ccc40
[<c01c39d4>] (driver_register+0x0/0x154) from [<c01c49f4>]
(platform_driver_register+0x4c/0x60)
[<c01c49a8>] (platform_driver_register+0x0/0x60) from [<c038c0d8>]
(serial8250_init+0x108/0x160)
[<c038bfd0>] (serial8250_init+0x0/0x160) from [<c00088c4>]
(do_one_initcall+0xec/0x158)
 r8:c038bfd0 r7:c03d39a0 r6:cf838000 r5:00000006 r4:c039df5c
r3:00000000
[<c00087d8>] (do_one_initcall+0x0/0x158) from [<c0378968>]
(kernel_init_freeable+0xf4/0x1b8)
[<c0378874>] (kernel_init_freeable+0x0/0x1b8) from [<c02a2aa0>]
(kernel_init+0x10/0xec)
[<c02a2a90>] (kernel_init+0x0/0xec) from [<c00094d0>]
(ret_from_fork+0x14/0x24)
 r4:00000000 r3:00000000
Code: bad PC value
---[ end trace ad321c8a03a56474 ]---
