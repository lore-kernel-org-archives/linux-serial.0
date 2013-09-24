From: Federico Natali <federico.natali@selex-es.com>
Subject: Adding a serial device
Date: Tue, 24 Sep 2013 08:49:48 +0000 (UTC)
Message-ID: <loom.20130924T092704-635@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:47256 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753702Ab3IXIzF (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Sep 2013 04:55:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1VOOOd-0006Bc-Uj
	for linux-serial@vger.kernel.org; Tue, 24 Sep 2013 10:55:04 +0200
Received: from host186-141-static.47-85-b.business.telecomitalia.it ([85.47.141.186])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 24 Sep 2013 10:55:03 +0200
Received: from federico.natali by host186-141-static.47-85-b.business.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 24 Sep 2013 10:55:03 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


Hi to everyone, 

I'm quite new at kernel hacking and I'm having problems trying to make a 
serial device work on a custom board.

I hope this is the right place for asking support, if not I'd be grateful 
if could you point me to the right place.

My situation is as follows:

I'm working on a custom board based on the ARM SoC DM8168 by Texas 
Instruments and I'm using a Linux distribution from TI based on 2.6.37 
kernel

On my custom board we added some 16550A compatible UARTs that weren't 
available on the TI evaluation board and so aren't directly supported by 
the TI kernel.

By delving through the kernel source and documentation and reading the 
"Kernel Driver Development" book I modified the board init code in the 
following way

- I added some configuration code so that the SoC could physically access 
the UARTs (This has been tested)
- I created a new platform_device structure to describe my UART device (a 
single one for start) that uses the serial8250 driver
snippets of code follows:

static struct resource extUart0_resources[] = {
	{
		.start	= EXTUART0_MEM_START,
		.end	= EXTUART0_MEM_END, /* Test */
		.flags	= IORESOURCE_MEM,
		.name	= "io-memory"
	}
};


static struct plat_serial8250_port ext_uart0_pdata = {
	.uartclk = EXTUART_CLK,
	.flags = UPF_FIXED_TYPE,
	.type = PORT_16550A,
};

static struct platform_device ext_uart0_device = {
	.name = "gpmc_serial8250",
	.id	= -1, /* For first test only, it indicates a single 
instance of the device */
	.dev = {
		.platform_data = &ext_uart0_pdata,
	},
	.num_resources = ARRAY_SIZE(extUart0_resources),
	.resource = extUart0_resources,
};

static struct platform_device *devices[] __initdata = {
	&ext_uart0_device/*,
	&ext_uart1_device,
	&ext_uart2_device,
	&ext_uart3_device,
	&ext_uart4_device,
	&ext_uart5_device,*/
};

- I then add the device to the kernel with the following:	
	platform_add_devices(devices, ARRAY_SIZE(devices));

during the boot I get the following messages:
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
------------[ cut here ]------------
WARNING: at fs/sysfs/dir.c:451 sysfs_add_one+0x7c/0x9c()
sysfs: cannot create duplicate filename '/devices/platform/serial8250'
Modules linked in:
Backtrace: 
[<c004abb8>] (dump_backtrace+0x0/0x110) from [<c039f538>] (dump_stack
+0x18/0x1c)
 r7:c7823e18 r6:c010da7c r5:c0473e18 r4:000001c3
[<c039f520>] (dump_stack+0x0/0x1c) from [<c006ee18>] (warn_slowpath_common
+0x54/0x6c)
[<c006edc4>] (warn_slowpath_common+0x0/0x6c) from [<c006eed4>] 
(warn_slowpath_fmt+0x38/0x40)
 r9:00000000 r8:00000000 r7:ffffffef r6:c7823e58 r5:c79ccd80
r4:c7813000
[<c006ee9c>] (warn_slowpath_fmt+0x0/0x40) from [<c010da7c>] (sysfs_add_one
+0x7c/0x9c)
 r3:c7813000 r2:c0473e27
[<c010da00>] (sysfs_add_one+0x0/0x9c) from [<c010e4d4>] (create_dir
+0x6c/0xb8)
 r7:c7819180 r6:00000000 r5:c79ccd80 r4:c7823e58
[<c010e468>] (create_dir+0x0/0xb8) from [<c010e5ec>] (sysfs_create_dir
+0xcc/0xe8)
[<c010e520>] (sysfs_create_dir+0x0/0xe8) from [<c01b74bc>] 
(kobject_add_internal+0xc0/0x194)
 r7:00000000 r6:c050cf70 r5:00000000 r4:c7972610
[<c01b73fc>] (kobject_add_internal+0x0/0x194) from [<c01b768c>] 
(kobject_add_varg+0x40/0x50)
 r9:00000000 r8:c00227c4 r7:00000000 r6:c050cf70 r5:00000000
r4:c7972610
[<c01b764c>] (kobject_add_varg+0x0/0x50) from [<c01b7734>] (kobject_add
+0x54/0x60)
 r7:00000000 r6:00000000 r5:c7972608 r4:c7972600
[<c01b76e0>] (kobject_add+0x0/0x60) from [<c0204e84>] (device_add
+0xac/0x498)
 r3:c7972610 r2:00000000
[<c0204dd8>] (device_add+0x0/0x498) from [<c0208a04>] (platform_device_add
+0x110/0x16c)
[<c02088f4>] (platform_device_add+0x0/0x16c) from [<c0022844>] 
(serial8250_init+0x80/0x164)
 r7:00000013 r6:c0072004 r5:c055ceb8 r4:00000000
[<c00227c4>] (serial8250_init+0x0/0x164) from [<c003c42c>] (do_one_initcall
+0xd0/0x1a4)
 r7:00000013 r6:c0072004 r5:c00086b0 r4:c002e324
[<c003c35c>] (do_one_initcall+0x0/0x1a4) from [<c000874c>] (kernel_init
+0x9c/0x154)
[<c00086b0>] (kernel_init+0x0/0x154) from [<c0072004>] (do_exit+0x0/0x5e4)
 r5:c00086b0 r4:00000000
---[ end trace 45ca6f5df7030500 ]---
kobject_add_internal failed for serial8250 with -EEXIST, don't try to 
register things with the same name in the same directory.
Backtrace: 
[<c004abb8>] (dump_backtrace+0x0/0x110) from [<c039f538>] (dump_stack
+0x18/0x1c)
 r7:00000000 r6:c050cf70 r5:ffffffef r4:c7972610
[<c039f520>] (dump_stack+0x0/0x1c) from [<c01b7548>] (kobject_add_internal
+0x14c/0x194)
[<c01b73fc>] (kobject_add_internal+0x0/0x194) from [<c01b768c>] 
(kobject_add_varg+0x40/0x50)
 r9:00000000 r8:c00227c4 r7:00000000 r6:c050cf70 r5:00000000
r4:c7972610
[<c01b764c>] (kobject_add_varg+0x0/0x50) from [<c01b7734>] (kobject_add
+0x54/0x60)
 r7:00000000 r6:00000000 r5:c7972608 r4:c7972600
[<c01b76e0>] (kobject_add+0x0/0x60) from [<c0204e84>] (device_add
+0xac/0x498)
 r3:c7972610 r2:00000000
[<c0204dd8>] (device_add+0x0/0x498) from [<c0208a04>] (platform_device_add
+0x110/0x16c)
[<c02088f4>] (platform_device_add+0x0/0x16c) from [<c0022844>] 
(serial8250_init+0x80/0x164)
 r7:00000013 r6:c0072004 r5:c055ceb8 r4:00000000
[<c00227c4>] (serial8250_init+0x0/0x164) from [<c003c42c>] (do_one_initcall
+0xd0/0x1a4)
 r7:00000013 r6:c0072004 r5:c00086b0 r4:c002e324
[<c003c35c>] (do_one_initcall+0x0/0x1a4) from [<c000874c>] (kernel_init
+0x9c/0x154)
[<c00086b0>] (kernel_init+0x0/0x154) from [<c0072004>] (do_exit+0x0/0x5e4)
 r5:c00086b0 r4:00000000

Looks like the serial8250 driver is already registered. I thought that in 
this case the kernel should add the new devices to the existing driver, 
what am I doing wrong??

I hope I made myself clear enough

Bye, Federico Natali




