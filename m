From: Martyn Welch <martyn.welch@collabora.co.uk>
Subject: [PATCH v3 0/6] serial: imx: various improvements
Date: Thu, 21 Sep 2017 17:18:11 +0100
Message-ID: <1506010697-22114-1-git-send-email-martyn.welch@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nandor Han <nandor.han@ge.com>, Romain Perier <romain.perier@collabora.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, Martyn Welch <martyn.welch@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

During shutdown when a userspace service is disabled (which generates
an uart close), we got kernel crashes in the imx serial driver :

[ 1257.657423] Unhandled fault: external abort on non-linefetch (0x1008) at 0xf0938000
[ 1257.665122] pgd = ecf20000
[ 1257.667838] [f0938000] *pgd=de819811, *pte=53fc0653, *ppte=53fc0453
[ 1257.674179] Internal error: : 1008 [#1] SMP ARM
[ 1257.678722] Modules linked in:
[ 1257.681807] CPU: 0 PID: 3850 Comm: emerald_acq Not tainted 4.8.0 #10
[ 1257.688168] Hardware name: Freescale i.MX53 (Device Tree Support)
[ 1257.694269] task: e5c48000 task.stack: ed0b4000
[ 1257.698827] PC is at imx_rxint+0x5c/0x228
[ 1257.702859] LR is at lock_acquired+0x494/0x57c
[ 1257.707312] pc : [<80484884>]    lr : [<80173aa0>]    psr: 20070193
[ 1257.707312] sp : ed0b5c60  ip : ed0b5be8  fp : ed0b5c9c
[ 1257.718795] r10: 00000000  r9 : 00000000  r8 : 00000004
[ 1257.724027] r7 : 00000030  r6 : ee83e258  r5 : 00000000  r4 : ee09f410
[ 1257.730561] r3 : 0015c30c  r2 : f0938000  r1 : 00000135  r0 : 40070193
[ 1257.737099] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
[ 1257.744327] Control: 10c5387d  Table: dcf20019  DAC: 00000051
[ 1257.750080] Process emerald_acq (pid: 3850, stack limit = 0xed0b4210)
[ 1257.756527] Stack: (0xed0b5c60 to 0xed0b6000)
[ 1257.760898] 5c60: ed0b5cf4 40070193 80175f64 80faf384 e5c484c0 ee09f410 00007240 00005099
[ 1257.769087] 5c80: 00000030 00000030 80e025c4 00000000 ed0b5cf4 ed0b5ca0 80485b18 80484834
[ 1257.777275] 5ca0: 8012fe26 00000000 00000000 60070193 ee81b210 00000001 ed0b5cdc ed0b5cc8
[ 1257.785463] 5cc0: 80171d28 80171c3c 80e2d634 ee096740 ee81b200 ee81b210 00000001 00000030
[ 1257.793651] 5ce0: 80e025c4 00000000 ed0b5d34 ed0b5cf8 80182f10 804857fc e5c484c0 00000002
[ 1257.801839] 5d00: ee81b200 ed0b5d3c 60070193 ee81b200 ee81b200 ee81b210 00000001 ee81c400
[ 1257.810027] 5d20: 00000001 00000008 ed0b5d54 ed0b5d38 801832d8 80182ed0 808f4b60 00000000
[ 1257.818216] 5d40: ee81b200 ee81b260 ed0b5d74 ed0b5d58 8018335c 801832b8 ee81b200 ee81b260
[ 1257.826404] 5d60: ee81b210 00000001 ed0b5d94 ed0b5d78 80186ba0 80183320 80debe8c 00000030
[ 1257.834592] 5d80: 00000000 00000001 ed0b5da4 ed0b5d98 80182420 80186af4 ed0b5dcc ed0b5da8
[ 1257.842780] 5da0: 801827a0 801823fc 00000000 80e8350c 00000020 00000001 ed0b5df8 00000001
[ 1257.850968] 5dc0: ed0b5df4 ed0b5dd0 80101530 8018274c 808f4bec 20070013 ffffffff ed0b5e2c
[ 1257.859156] 5de0: ee09f410 ed0b4000 ed0b5e5c ed0b5df8 808f55f0 801014c8 00000001 00000130
[ 1257.867345] 5e00: 00000000 e5c48000 60070013 ee09f410 00000000 60070013 ee09f410 ed06a640
[ 1257.875533] 5e20: 00000008 ed0b5e5c ed0b5df0 ed0b5e48 801756a8 808f4bec 20070013 ffffffff
[ 1257.883722] 5e40: 00000051 7f000000 ee09f410 00000b01 ed0b5e7c ed0b5e60 80485d74 808f4bb4
[ 1257.891912] 5e60: ee83e258 ee09f410 ee83e3a4 80e2d634 ed0b5ea4 ed0b5e80 8047f514 80485c70
[ 1257.900100] 5e80: ee83e258 ed375000 ee09f410 ee83e310 ee83e3ac ed06a640 ed0b5ecc ed0b5ea8
[ 1257.908288] 5ea0: 80481304 8047f400 ed375000 eeabce60 00000000 ee7973e8 00000000 ed06a640
[ 1257.916477] 5ec0: ed0b5f14 ed0b5ed0 80462fe0 804811ac 00000008 eeabce60 00000001 00000001
[ 1257.924665] 5ee0: 00000000 802713dc ed0b5f54 ed06a640 eeabce60 ee2c6910 ee7973e8 00000000
[ 1257.932854] 5f00: eeabce60 00000008 ed0b5f54 ed0b5f18 80271404 80462ee8 00000000 00000000
[ 1257.941044] 5f20: ed06c640 ed06a648 ed0b5f4c e5c48400 00000000 80e84054 e5c48440 e5c48000
[ 1257.949232] 5f40: 00000000 00000000 ed0b5f64 ed0b5f58 802715c4 80271378 ed0b5f8c ed0b5f68
[ 1257.957420] 5f60: 80146034 802715b8 00000000 ed0b4000 ed0b5fb0 801086c4 801086c4 ed0b4000
[ 1257.965610] 5f80: ed0b5fac ed0b5f90 8010cc68 80145f78 0054756c 00000000 767474b4 00000006
[ 1257.973798] 5fa0: 00000000 ed0b5fb0 80108548 8010cbc4 00000000 76f2a084 00000002 00000000
[ 1257.981986] 5fc0: 0054756c 00000000 767474b4 00000006 0225e880 00000000 76f36000 7e836d34
[ 1257.990175] 5fe0: 00000000 7e836d10 76f2a4c0 76a5db68 80070010 00000062 00000000 00000000
[ 1257.998357] Backtrace: 
[ 1258.000837] [<80484828>] (imx_rxint) from [<80485b18>] (imx_int+0x328/0x474)
[ 1258.007892]  r10:00000000 r9:80e025c4 r8:00000030 r7:00000030 r6:00005099 r5:00007240
[ 1258.015815]  r4:ee09f410
[ 1258.018386] [<804857f0>] (imx_int) from [<80182f10>] (__handle_irq_event_percpu+0x4c/0x3e8)
[ 1258.026742]  r10:00000000 r9:80e025c4 r8:00000030 r7:00000001 r6:ee81b210 r5:ee81b200
[ 1258.034664]  r4:ee096740
[ 1258.037226] [<80182ec4>] (__handle_irq_event_percpu) from [<801832d8>] (handle_irq_event_percpu+0x2c/0x68)
[ 1258.046885]  r10:00000008 r9:00000001 r8:ee81c400 r7:00000001 r6:ee81b210 r5:ee81b200
[ 1258.054806]  r4:ee81b200
[ 1258.057369] [<801832ac>] (handle_irq_event_percpu) from [<8018335c>] (handle_irq_event+0x48/0x6c)
[ 1258.066246]  r5:ee81b260 r4:ee81b200
[ 1258.069866] [<80183314>] (handle_irq_event) from [<80186ba0>] (handle_level_irq+0xb8/0x154)
[ 1258.078222]  r7:00000001 r6:ee81b210 r5:ee81b260 r4:ee81b200
[ 1258.083961] [<80186ae8>] (handle_level_irq) from [<80182420>] (generic_handle_irq+0x30/0x44)
[ 1258.092404]  r7:00000001 r6:00000000 r5:00000030 r4:80debe8c
[ 1258.098143] [<801823f0>] (generic_handle_irq) from [<801827a0>] (__handle_domain_irq+0x60/0xc8)
[ 1258.106854] [<80182740>] (__handle_domain_irq) from [<80101530>] (tzic_handle_irq+0x74/0x9c)
[ 1258.115297]  r9:00000001 r8:ed0b5df8 r7:00000001 r6:00000020 r5:80e8350c r4:00000000
[ 1258.123139] [<801014bc>] (tzic_handle_irq) from [<808f55f0>] (__irq_svc+0x70/0x98)
[ 1258.130715] Exception stack(0xed0b5df8 to 0xed0b5e40)
[ 1258.135773] 5de0:                                                       00000001 00000130
[ 1258.143962] 5e00: 00000000 e5c48000 60070013 ee09f410 00000000 60070013 ee09f410 ed06a640
[ 1258.152151] 5e20: 00000008 ed0b5e5c ed0b5df0 ed0b5e48 801756a8 808f4bec 20070013 ffffffff
[ 1258.160333]  r9:ed0b4000 r8:ee09f410 r7:ed0b5e2c r6:ffffffff r5:20070013 r4:808f4bec
[ 1258.168188] [<808f4ba8>] (_raw_spin_unlock_irqrestore) from [<80485d74>] (imx_shutdown+0x110/0x214)
[ 1258.177239]  r5:00000b01 r4:ee09f410
[ 1258.180860] [<80485c64>] (imx_shutdown) from [<8047f514>] (uart_shutdown+0x120/0x17c)
[ 1258.188695]  r7:80e2d634 r6:ee83e3a4 r5:ee09f410 r4:ee83e258
[ 1258.194434] [<8047f3f4>] (uart_shutdown) from [<80481304>] (uart_close+0x164/0x254)
[ 1258.202096]  r9:ed06a640 r8:ee83e3ac r7:ee83e310 r6:ee09f410 r5:ed375000 r4:ee83e258
[ 1258.209948] [<804811a0>] (uart_close) from [<80462fe0>] (tty_release+0x104/0x498)
[ 1258.217439]  r9:ed06a640 r8:00000000 r7:ee7973e8 r6:00000000 r5:eeabce60 r4:ed375000
[ 1258.225285] [<80462edc>] (tty_release) from [<80271404>] (__fput+0x98/0x1e8)
[ 1258.232339]  r10:00000008 r9:eeabce60 r8:00000000 r7:ee7973e8 r6:ee2c6910 r5:eeabce60
[ 1258.240261]  r4:ed06a640
[ 1258.242823] [<8027136c>] (__fput) from [<802715c4>] (____fput+0x18/0x1c)
[ 1258.249528]  r10:00000000 r9:00000000 r8:e5c48000 r7:e5c48440 r6:80e84054 r5:00000000
[ 1258.257450]  r4:e5c48400
[ 1258.260021] [<802715ac>] (____fput) from [<80146034>] (task_work_run+0xc8/0xf8)
[ 1258.267352] [<80145f6c>] (task_work_run) from [<8010cc68>] (do_work_pending+0xb0/0xd0)
[ 1258.275274]  r9:ed0b4000 r8:801086c4 r7:801086c4 r6:ed0b5fb0 r5:ed0b4000 r4:00000000
[ 1258.283116] [<8010cbb8>] (do_work_pending) from [<80108548>] (slow_work_pending+0xc/0x20)
[ 1258.291298]  r7:00000006 r6:767474b4 r5:00000000 r4:0054756c
[ 1258.297037] Code: e5943094 e594202c e2833001 e5843094 (e592a000) 
[ 1258.303148] ---[ end trace 7a50198148a54c4d ]---
[ 1258.307776] Kernel panic - not syncing: Fatal exception in interrupt
[ 1258.314160] ---[ end Kernel panic - not syncing: Fatal exception in interrupt


After investigations, we found several issues:
It looks that interrupts can happen after the dma was disabled and
port was not yet shutdown. This will result in interrupts handled by
imx_rxint. Analyzed the imx_shutdown function, and found that:

- Some interrupts were not disabled during shutdown (AWAKEN, UCR4_OREN,
  UCR1_TRDYEN) 
- TX was not stopped in all situations (if dma is enabled and
  transmitting)
- Using deprecated dmaengine_terminate_all method.
- Trying to close DMA channels several times. 

This set of patches proposes fix regarding these issues and problems we
found during debugging.


Changes in v3:
- Re-worked commit message of `dma_is_rxing` patch.
- Correct patch order to avoid build failure.
- Added information to CTSC and CTS handling patch commit message

Changes in v2:
- Re-worked assignment of `dma_is_rxing` in patch 1/7
- Removed commit "serial: imx: move log from error to debug type"
- Removed commit "serial: imx: init dma_is_{rx|tx}ing variables"
- Improved commit log for "serial: imx: Simplify DMA disablement" 
  and splitted it in two commits, with one for CTSC and CTS
- Added commit "serial: imx: remove CTSC and CTS handling"
- Fixed typo in commit "unmap sg buffers when DMA channel is released"
- Re-worded commit log for "serial: imx: update the stop rx,tx procedures" and
  removed forward declaration
- Fixed typo in commit "serial: imx: Fix imx_shutdown procedure" and simplified
  locking

Nandor Han (5):
  serial: imx: remove CTSC and CTS handling from imx_disable_dma
  serial: imx: Simplify DMA disablement
  serial: imx: unmap sg buffers when DMA channel is released
  serial: imx: update the stop rx,tx procedures
  serial: imx: Fix imx_shutdown procedure

Romain Perier (1):
  serial: imx: only set dma_is_rxing when DMA starts

 drivers/tty/serial/imx.c | 117 ++++++++++++++++++++++++++---------------------
 1 file changed, 65 insertions(+), 52 deletions(-)

-- 
1.8.3.1
