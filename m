From: Mason <slash.tmp@free.fr>
Subject: Problem with 4.6-rc2
Date: Mon, 18 Apr 2016 18:24:29 +0200
Message-ID: <57150A3D.6020500@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial <linux-serial@vger.kernel.org>
Cc: Sebastian Frias <sf84@laposte.net>, Peter Hurley <peter@hurleysoftware.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hello,

I'm running into this panic. I will take a closer look tomorrow.
Any ideas?

[    0.353333] Serial: 8250/16550 driver, 1 ports, IRQ sharing disabled
[    0.359999] console [ttyS0] disabled
[    0.366666] 10700.serial: ttyS0 at MMIO 0x10700 (irq = 22, base_baud = 460800) is a Palmchip BK-3103
[    0.373333] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    0.383333] pgd = c0004000
[    0.386666] [00000000] *pgd=00000000
[    0.389999] Internal error: Oops: 805 [#1] PREEMPT SMP ARM
[    0.393333] Modules linked in:
[    0.396666] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.6.0-rc2+ #73
[    0.403333] Hardware name: Sigma Tango DT
[    0.409999] task: e741ca80 ti: e743c000 task.ti: e743c000
[    0.413333] PC is at io_serial_out+0x20/0x28
[    0.419999] LR is at arm_heavy_mb+0x24/0x40
[    0.423333] pc : [<c02de66c>]    lr : [<c01143f0>]    psr: 60000093
[    0.423333] sp : e743da40  ip : e743da30  fp : e743da54
[    0.433333] r10: c05c9968  r9 : e7506c40  r8 : 40000013
[    0.439999] r7 : e76dc490  r6 : c0710910  r5 : 00000000  r4 : 00000000
[    0.446666] r3 : 00000000  r2 : 00000730  r1 : 00000000  r0 : c074b810
[    0.453333] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[    0.459999] Control: 10c5387d  Table: 8000404a  DAC: 00000051
[    0.466666] Process swapper/0 (pid: 1, stack limit = 0xe743c218)
[    0.473333] Stack: (0xe743da40 to 0xe743e000)
[    0.476666] da40: c02de64c 00000000 e743da6c e743da58 c02de024 c02de658 e76dc400 c074b810
[    0.486666] da60: e743da7c e743da70 c02de04c c02ddfd4 e743db14 e743da80 c02db32c c02de034
[    0.493333] da80: 00000000 e743daa8 00000016 00070800 c05b7d30 c074b810 00070800 c05a9798
[    0.503333] daa0: 00000016 00000000 4f494d4d 31783020 30303730 00000000 00000000 e76dc490
[    0.509999] dac0: e743dadc e743dad0 c02c265c c074b810 e76dc400 00000000 e76dc490 c074b810
[    0.519999] dae0: 0000001d 00000000 e743db14 c074b810 e743dc54 c074b92c b9000000 c074b810
[    0.526666] db00: 00000000 00000000 e743db4c e743db18 c02dd18c c02dafd0 e743db4c e743db28
[    0.536666] db20: c036ce80 c043ef98 e7af31d4 e7504a00 e7504a10 00000002 e76ded00 0000001d
[    0.543333] db40: e743ddcc e743db50 c02e199c c02dcf00 00708000 e743db60 00000002 00000000
[    0.549999] db60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.559999] db80: 00000000 00000000 00000000 00000000 00000000 00000000 00000016 00000000
[    0.566666] dba0: 00708000 00000000 00040200 00000000 00000000 00000000 00000000 00000000
[    0.576666] dbc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.583333] dbe0: 00000000 00000000 00000000 b9000000 00000000 00000000 00000000 00000000
[    0.593333] dc00: 0000001d 00000000 00000000 00000000 00000000 00010700 00000030 e7504a10
[    0.599999] dc20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.609999] dc40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.616666] dc60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.626666] dc80: 00000000 00000000 00000000 00000000 00000016 00000000 00708000 00000000
[    0.633333] dca0: 00040200 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.643333] dcc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.649999] dce0: 00000000 b9000000 00000000 00000000 00000000 00000000 0000001d 00000000
[    0.659999] dd00: 00000000 00000000 00000000 00010700 00000030 e7504a10 00000000 00000000
[    0.666666] dd20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.676666] dd40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.683333] dd60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.693333] dd80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.699999] dda0: c0710a6c e7504a10 c0710a6c c074beb8 00000000 c0710a6c 00000000 00000000
[    0.709999] ddc0: e743dde4 e743ddd0 c02eb654 c02e1618 c074beb0 e7504a10 e743de0c e743dde8
[    0.716666] dde0: c02e9e48 c02eb624 e7504a10 c0710a6c e7504a44 00000000 00000076 c060061c
[    0.726666] de00: e743de2c e743de10 c02e9fa4 c02e9c84 00000000 c0710a6c c02e9ed8 00000000
[    0.733333] de20: e743de54 e743de30 c02e810c c02e9ee4 e741d75c e7500c34 e741d770 c0710a6c
[    0.743333] de40: e776e980 c0710ff8 e743de64 e743de58 c02e97a8 c02e80a8 e743de8c e743de68
[    0.749999] de60: c02e93ac c02e9790 c05b7e30 e743de78 c0710a6c c0614828 c0704510 e76dee00
[    0.759999] de80: e743dea4 e743de90 c02ea5cc c02e9210 c0710ff8 c0614828 e743debc e743dea8
[    0.766666] dea0: c02eb610 c02ea558 c0704510 c0614828 e743decc e743dec0 c0614844 c02eb5d4
[    0.776666] dec0: e743df4c e743ded0 c010180c c0614834 e743def4 e743dee0 c0135460 c029ee54
[    0.783333] dee0: e7ffce00 c050ea30 e743df4c e743def8 c0135770 c0600628 e743df34 c05a8f28
[    0.793333] df00: c05a8f74 c05a8834 00000006 00000006 00000000 c05f3ffc c05c119c 00000000
[    0.799999] df20: 00000000 c071c200 c071c200 c062cca0 c0624834 00000076 c060061c 00000007
[    0.809999] df40: e743df94 e743df50 c0600e2c c0101780 00000006 00000006 00000000 c060061c
[    0.816666] df60: 4bf7d2c1 c05f3ffc 029f1596 00000000 c0439be0 00000000 00000000 00000000
[    0.826666] df80: 00000000 00000000 e743dfac e743df98 c0439bf0 c0600cd8 00000000 c0439be0
[    0.833333] dfa0: 00000000 e743dfb0 c0107bd8 c0439bec 00000000 00000000 00000000 00000000
[    0.843333] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.849999] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 5d02972f 06e126fc
[    0.859999] Backtrace: 
[    0.859999] [<c02de64c>] (io_serial_out) from [<c02de024>] (serial8250_do_set_mctrl+0x5c/0x60)
[    0.869999]  r5:00000000 r4:c02de64c
[    0.873333] [<c02ddfc8>] (serial8250_do_set_mctrl) from [<c02de04c>] (serial8250_set_mctrl+0x24/0x28)
[    0.883333]  r5:c074b810 r4:e76dc400
[    0.886666] [<c02de028>] (serial8250_set_mctrl) from [<c02db32c>] (uart_add_one_port+0x368/0x478)
[    0.896666] [<c02dafc4>] (uart_add_one_port) from [<c02dd18c>] (serial8250_register_8250_port+0x298/0x314)
[    0.906666]  r10:00000000 r9:00000000 r8:c074b810 r7:b9000000 r6:c074b92c r5:e743dc54
[    0.913333]  r4:c074b810
[    0.916666] [<c02dcef4>] (serial8250_register_8250_port) from [<c02e199c>] (of_platform_serial_probe+0x390/0x440)
[    0.926666]  r9:0000001d r8:e76ded00 r7:00000002 r6:e7504a10 r5:e7504a00 r4:e7af31d4
[    0.933333] [<c02e160c>] (of_platform_serial_probe) from [<c02eb654>] (platform_drv_probe+0x3c/0x84)
[    0.943333]  r10:00000000 r9:00000000 r8:c0710a6c r7:00000000 r6:c074beb8 r5:c0710a6c
[    0.953333]  r4:e7504a10
[    0.953333] [<c02eb618>] (platform_drv_probe) from [<c02e9e48>] (really_probe+0x1d0/0x260)
[    0.963333]  r5:e7504a10 r4:c074beb0
[    0.966666] [<c02e9c78>] (really_probe) from [<c02e9fa4>] (__driver_attach+0xcc/0xd0)
[    0.973333]  r9:c060061c r8:00000076 r7:00000000 r6:e7504a44 r5:c0710a6c r4:e7504a10
[    0.983333] [<c02e9ed8>] (__driver_attach) from [<c02e810c>] (bus_for_each_dev+0x70/0xa4)
[    0.989999]  r7:00000000 r6:c02e9ed8 r5:c0710a6c r4:00000000
[    0.996666] [<c02e809c>] (bus_for_each_dev) from [<c02e97a8>] (driver_attach+0x24/0x28)
[    1.003333]  r6:c0710ff8 r5:e776e980 r4:c0710a6c
[    1.009999] [<c02e9784>] (driver_attach) from [<c02e93ac>] (bus_add_driver+0x1a8/0x220)
[    1.016666] [<c02e9204>] (bus_add_driver) from [<c02ea5cc>] (driver_register+0x80/0x100)
[    1.026666]  r7:e76dee00 r6:c0704510 r5:c0614828 r4:c0710a6c
[    1.029999] [<c02ea54c>] (driver_register) from [<c02eb610>] (__platform_driver_register+0x48/0x50)
[    1.039999]  r5:c0614828 r4:c0710ff8
[    1.043333] [<c02eb5c8>] (__platform_driver_register) from [<c0614844>] (of_platform_serial_driver_init+0x1c/0x20)
[    1.053333]  r5:c0614828 r4:c0704510
[    1.059999] [<c0614828>] (of_platform_serial_driver_init) from [<c010180c>] (do_one_initcall+0x98/0x1e4)
[    1.066666] [<c0101774>] (do_one_initcall) from [<c0600e2c>] (kernel_init_freeable+0x160/0x1f4)
[    1.076666]  r10:00000007 r9:c060061c r8:00000076 r7:c0624834 r6:c062cca0 r5:c071c200
[    1.083333]  r4:c071c200
[    1.086666] [<c0600ccc>] (kernel_init_freeable) from [<c0439bf0>] (kernel_init+0x10/0x114)
[    1.096666]  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0439be0
[    1.103333]  r4:00000000
[    1.106666] [<c0439be0>] (kernel_init) from [<c0107bd8>] (ret_from_fork+0x14/0x3c)
[    1.113333]  r5:c0439be0 r4:00000000
[    1.116666] Code: f57ff04e ebf8d759 e6ef4074 e3a03000 (e5c34000) 
[    1.123333] ---[ end trace c9eef901688853ea ]---
