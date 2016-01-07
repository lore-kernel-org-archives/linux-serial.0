From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V2] serial: imx: Fix suspend / resume.
Date: Thu, 7 Jan 2016 21:17:47 -0200
Message-ID: <CAOMZO5BES=YkYjtjPE_=t9Qa11JsgE0TT8-v0CxmtgSuBwWnmw@mail.gmail.com>
References: <20160105155331.6024.7211.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160105155331.6024.7211.stgit@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <kernel@pengutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 5, 2016 at 1:53 PM, Martin Fuzzey <mfuzzey@parkeon.com> wrote:
> When a non console i.MX UART is enabled in the device tree,
> system suspend fails due to an unprepared clock:

Just tested suspend/resume on a mx6q-cubox-i running 4.4-rc8 and I see
a different issue:

Pass 'no_console_suspend' in the kernel command line.

$ echo enabled > /sys/class/tty/ttymxc0/power/wakeup
$ echo mem > /sys/power/state
[   38.916309] PM: Syncing filesystems ... done.
[   38.952284] Freezing user space processes ... (elapsed 0.003 seconds) done.
[   38.963070] Freezing remaining freezable tasks ... (elapsed 0.003
seconds) done.
[   39.043984] Unable to handle kernel NULL pointer dereference at
virtual address 0000073c
[   39.052110] pgd = ed8c8000
[   39.054840] [0000073c] *pgd=8ed17831
[   39.058468] Internal error: Oops: 17 [#1] SMP ARM
[   39.063195] Modules linked in:
[   39.066301] CPU: 0 PID: 956 Comm: sh Not tainted 4.4.0-rc8-dirty #261
[   39.072762] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   39.079313] task: edf23980 ti: edf16000 task.ti: edf16000
[   39.084756] PC is at __lock_acquire+0x15c/0x1ba4
[   39.089401] LR is at lock_acquire+0x78/0x98
[   39.093609] pc : [<c006f120>]    lr : [<c0070f20>]    psr: 20000093
[   39.093609] sp : edf17bb0  ip : 00000000  fp : edf17c3c
[   39.105107] r10: 00000000  r9 : c0af1ba8  r8 : 0000073c
[   39.110352] r7 : edf23980  r6 : c1332014  r5 : c0ae42e4  r4 : edf16000
[   39.116898] r3 : c112f600  r2 : 00000000  r1 : 00000000  r0 : 0000073c
[   39.123450] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment none
[   39.130693] Control: 10c5387d  Table: 3d8c804a  DAC: 00000051
[   39.136459] Process sh (pid: 956, stack limit = 0xedf16210)
[   39.142053] Stack: (0xedf17bb0 to 0xedf18000)
[   39.146438] 7ba0:                                     00000000
edf23e28 00000005 c1332014
[   39.154645] 7bc0: edf23980 c1333944 c0af1ba8 00000016 00000000
edf23e08 00000000 c1332014
[   39.162852] 7be0: edf23980 ee9b4210 c0af1ba8 0000009b 00000000
edf23e08 00000004 c1332014
[   39.171058] 7c00: edf23980 ee9d1478 c0af1ba8 0000009c edf17cac
00000000 60000013 c0584508
[   39.179264] 7c20: 00000001 ee9d1444 00000708 ee9d1410 edf17c74
edf17c40 c0070f20 c006efd0
[   39.187469] 7c40: 00000001 00000000 00000000 c0584508 00000000
00000000 c0584508 00000000
[   39.195675] 7c60: c1332014 edf23980 edf17ccc edf17c78 c07ab5d8
c0070eb4 00000001 00000000
[   39.203881] 7c80: c0584508 00000000 edf17cb4 edf17c98 c0071754
c006e920 c07ab868 edf23980
[   39.212086] 7ca0: 00000001 00000000 ee259410 c03c31bc 00000002
ee9d1444 00000000 ee9d1410
[   39.220292] 7cc0: edf17cf4 edf17cd0 c0584508 c07ab588 c05844d0
00000000 00000000 c03c31bc
[   39.228498] 7ce0: 00000002 ee9d1444 edf17d04 edf17cf8 c03c31f0
c05844dc edf17d3c edf17d08
[   39.236704] 7d00: c03cc878 c03c31c8 c07af6f4 c0071974 00000000
00000000 ee9d1410 00000000
[   39.244910] 7d20: c134b238 00000002 ee9d1444 00000000 edf17d6c
edf17d40 c03cd77c c03cc850
[   39.253116] 7d40: ee9d14c0 009d1410 c0b016c0 ee9d14c0 ee9d1410
c0b016c0 c134b238 c0b01724
[   39.261321] 7d60: edf17db4 edf17d70 c03ceb14 c03cd654 1326b091
00000009 c03cee90 00000002
[   39.269526] 7d80: 1326b091 00000009 60000013 00000002 c12ef69c
00000003 00000003 ed832600
[   39.277731] 7da0: 00000000 00000004 edf17dcc edf17db8 c03cef0c
c03cea0c 00000000 c12ef69c
[   39.285938] 7dc0: edf17e14 edf17dd0 c00770a8 c03ceeb8 c007adf4
c007a838 c0978fb0 edf17e0c
[   39.294143] 7de0: edf17e04 edf17df0 c00c74e8 00000000 00000003
c12ef6a8 00000003 ed832600
[   39.302349] 7e00: 00000000 00000004 edf17e34 edf17e18 c0077718
c0077024 0000006d 00000003
[   39.310555] 7e20: c0974c8c c12ef6ac edf17e5c edf17e38 c00760c0
c00774a8 edfc1680 00000004
[   39.318760] 7e40: ed832600 00000004 00000000 00000000 edf17e6c
edf17e60 c02d4438 c007605c
[   39.326966] 7e60: edf17e8c edf17e70 c017bd34 c02d4428 c017bce0
edfc1680 ed832600 edfc168c
[   39.335172] 7e80: edf17ed4 edf17e90 c017b02c c017bcec 00000000
00000000 60000013 c010e88c
[   39.343377] 7ea0: edf17f78 00000051 edf16000 c07bf87c 01f9a408
edf0b540 edf17f78 00000004
[   39.351583] 7ec0: edf16000 01f9a408 edf17f44 edf17ed8 c010bfdc
c017af70 c006b5a8 c0084240
[   39.359789] 7ee0: 00000001 ee3c7a34 edf17f24 edf17ef8 c006b824
c006b59c 00000001 00000000
[   39.367994] 7f00: c010e88c c0b3f6d5 edf17f34 00000001 ee3c7800
00000000 edf17f44 edf17f28
[   39.376200] 7f20: c010e88c edf0b540 01f9a408 00000004 edf17f78
00000004 edf17f74 edf17f48
[   39.384406] 7f40: c010d028 c010bfb4 c0129ce8 c0129c4c 00000000
00000000 edf0b540 edf0b540
[   39.392611] 7f60: 00000004 01f9a408 edf17fa4 edf17f78 c010d2c0
c010cf9c 00000000 00000000
[   39.400818] 7f80: 00000004 b6ed65c0 00000004 00000004 c000ff44
00000000 00000000 edf17fa8
[   39.409024] 7fa0: c000fda0 c010d288 00000004 b6ed65c0 00000001
01f9a408 00000004 00000000
[   39.417230] 7fc0: 00000004 b6ed65c0 00000004 00000004 01f9a408
01f982e8 bef6eae8 00000000
[   39.425435] 7fe0: 00000000 bef6ea68 b6e12690 b6e650bc 60000010
00000001 00000000 00000000
[   39.433626] Backtrace:
[   39.436134] [<c006efc4>] (__lock_acquire) from [<c0070f20>]
(lock_acquire+0x78/0x98)
[   39.443896]  r10:ee9d1410 r9:00000708 r8:ee9d1444 r7:00000001
r6:c0584508 r5:60000013
[   39.451867]  r4:00000000
[   39.454468] [<c0070ea8>] (lock_acquire) from [<c07ab5d8>]
(mutex_lock_nested+0x5c/0x3ec)
[   39.462576]  r7:edf23980 r6:c1332014 r5:00000000 r4:c0584508
[   39.468382] [<c07ab57c>] (mutex_lock_nested) from [<c0584508>]
(snd_soc_suspend+0x38/0x404)
[   39.476750]  r10:ee9d1410 r9:00000000 r8:ee9d1444 r7:00000002
r6:c03c31bc r5:ee259410
[   39.484718]  r4:00000000
[   39.487313] [<c05844d0>] (snd_soc_suspend) from [<c03c31f0>]
(platform_pm_suspend+0x34/0x5c)
[   39.495766]  r8:ee9d1444 r7:00000002 r6:c03c31bc r5:00000000
r4:00000000 r3:c05844d0
[   39.503676] [<c03c31bc>] (platform_pm_suspend) from [<c03cc878>]
(dpm_run_callback+0x34/0xb4)
[   39.512236] [<c03cc844>] (dpm_run_callback) from [<c03cd77c>]
(__device_suspend+0x134/0x36c)
[   39.520689]  r10:00000000 r8:ee9d1444 r7:00000002 r6:c134b238
r5:00000000 r4:ee9d1410
[   39.528675] [<c03cd648>] (__device_suspend) from [<c03ceb14>]
(dpm_suspend+0x114/0x224)
[   39.536695]  r8:c0b01724 r7:c134b238 r6:c0b016c0 r5:ee9d1410 r4:ee9d14c0
[   39.543551] [<c03cea00>] (dpm_suspend) from [<c03cef0c>]
(dpm_suspend_start+0x60/0x68)
[   39.551483]  r10:00000004 r9:00000000 r8:ed832600 r7:00000003
r6:00000003 r5:c12ef69c
[   39.559452]  r4:00000002
[   39.562047] [<c03ceeac>] (dpm_suspend_start) from [<c00770a8>]
(suspend_devices_and_enter+0x90/0x484)
[   39.571281]  r5:c12ef69c r4:00000000
[   39.574935] [<c0077018>] (suspend_devices_and_enter) from
[<c0077718>] (pm_suspend+0x27c/0x2b4)
[   39.583648]  r10:00000004 r9:00000000 r8:ed832600 r7:00000003
r6:c12ef6a8 r5:00000003
[   39.591616]  r4:00000000
[   39.594200] [<c007749c>] (pm_suspend) from [<c00760c0>]
(state_store+0x70/0xc0)
[   39.601525]  r6:c12ef6ac r5:c0974c8c r4:00000003 r3:0000006d
[   39.607320] [<c0076050>] (state_store) from [<c02d4438>]
(kobj_attr_store+0x1c/0x28)
[   39.615079]  r10:00000000 r8:00000000 r7:00000004 r6:ed832600
r5:00000004 r4:edfc1680
[   39.623077] [<c02d441c>] (kobj_attr_store) from [<c017bd34>]
(sysfs_kf_write+0x54/0x58)
[   39.631117] [<c017bce0>] (sysfs_kf_write) from [<c017b02c>]
(kernfs_fop_write+0xc8/0x1d0)
[   39.639310]  r6:edfc168c r5:ed832600 r4:edfc1680 r3:c017bce0
[   39.645098] [<c017af64>] (kernfs_fop_write) from [<c010bfdc>]
(__vfs_write+0x34/0xe0)
[   39.652944]  r10:01f9a408 r9:edf16000 r8:00000004 r7:edf17f78
r6:edf0b540 r5:01f9a408
[   39.660913]  r4:c07bf87c
[   39.663498] [<c010bfa8>] (__vfs_write) from [<c010d028>]
(vfs_write+0x98/0x154)
[   39.670822]  r8:00000004 r7:edf17f78 r6:00000004 r5:01f9a408 r4:edf0b540
[   39.677673] [<c010cf90>] (vfs_write) from [<c010d2c0>] (SyS_write+0x44/0x90)
[   39.684737]  r10:01f9a408 r8:00000004 r7:edf0b540 r6:edf0b540
r5:00000000 r4:00000000
[   39.692730] [<c010d27c>] (SyS_write) from [<c000fda0>]
(ret_fast_syscall+0x0/0x1c)
[   39.700316]  r10:00000000 r8:c000ff44 r7:00000004 r6:00000004
r5:b6ed65c0 r4:00000004
[   39.708299] Code: e3a00000 e24bd028 e89daff0 e59f3dec (e5982000)
[   39.714422] ---[ end trace 0d94270494797cfb ]---
