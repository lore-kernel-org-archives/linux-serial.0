From: Duan Andy <fugang.duan@freescale.com>
Subject: RE: [PATCH v1] Revert "serial: imx: remove unbalanced clk_prepare"
Date: Wed, 4 Nov 2015 05:03:53 +0000
Message-ID: <BN3PR0301MB1219450A85A8FC78FE51B792F52A0@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <1446605898-27635-1-git-send-email-b38343@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446605898-27635-1-git-send-email-b38343@freescale.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Yibin Gong <yibin.gong@freescale.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "edubezval@gmail.com" <edubezval@gmail.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

From: Robin Gong <b38343@freescale.com> Sent: Wednesday, November 04, 2015 10:58 AM
> To: gregkh@linuxfoundation.org; edubezval@gmail.com
> Cc: Duan Fugang-B38611; linux-serial@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH v1] Revert "serial: imx: remove unbalanced clk_prepare"
> 
> commit 9e7b399d6528 ("serial: imx: remove unbalanced clk_prepare").
> Otherwise below warning happen since there are some printk logs in
> interrupt.
> 
> [   14.868319] udevd[501]: starting version 182
> [   16.386107] random: nonblocking pool is initialized
> [   16.386123] ------------[ cut here ]------------
> [   16.386140] WARNING: CPU: 0 PID: 501 at kernel/locking/mutex.c:868
> mutex_trylock+0x210/0x230()
> [   16.386146] DEBUG_LOCKS_WARN_ON(in_interrupt())
> [   16.386149] Modules linked in:
> [   16.386157] CPU: 0 PID: 501 Comm: udevd Not tainted 4.3.0-rc1-00014-
> gf843df8 #28
> [   16.386160] Hardware name: Freescale i.MX6 SoloX (Device Tree)
> [   16.386165] Backtrace:
> [   16.386182] [<c0013e98>] (dump_backtrace) from [<c0014090>]
> (show_stack+0x18/0x1c)
> [   16.386192]  r6:c0af1840 r5:00000000 r4:00000000 r3:00000000
> [   16.386201] [<c0014078>] (show_stack) from [<c02d4af8>]
> (dump_stack+0x8c/0xa4)
> [   16.386216] [<c02d4a6c>] (dump_stack) from [<c002be14>]
> (warn_slowpath_common+0x80/0xbc)
> [   16.386225]  r6:c07b1ccc r5:00000009 r4:edcf5c60 r3:00000001
> [   16.386234] [<c002bd94>] (warn_slowpath_common) from [<c002be88>]
> (warn_slowpath_fmt+0x38/0x40)
> [   16.386246]  r8:c0564694 r7:eeb76880 r6:c13323ec r5:00000001
> r4:c0976990
> [   16.386255] [<c002be54>] (warn_slowpath_fmt) from [<c07b1ccc>]
> (mutex_trylock+0x210/0x230)
> [   16.386261]  r3:c0978f50 r2:c0976990
> [   16.386264]  r4:c0b29a70
> [   16.386278] [<c07b1abc>] (mutex_trylock) from [<c0564694>]
> (clk_prepare_lock+0x14/0xf4)
> [   16.386289]  r8:c133000c r7:eeb76880 r6:00000037 r5:c12efbc8
> r4:eeb76880
> [   16.386297] [<c0564680>] (clk_prepare_lock) from [<c0565e04>]
> (clk_prepare+0x18/0x38)
> [   16.386303]  r5:c12efbc8 r4:eeb76880
> [   16.386311] [<c0565dec>] (clk_prepare) from [<c0379a90>]
> (imx_console_write+0x34/0x248)
> [   16.386317]  r4:ee999c10 r3:c134a92c
> [   16.386329] [<c0379a5c>] (imx_console_write) from [<c007ac74>]
> (call_console_drivers.constprop.25+0xe0/0x104)
> [   16.386342]  r10:c07b938c r9:00000000 r8:c133000c r7:00000037
> r6:edcf4000 r5:c12ef6c0
> [   16.386345]  r4:c0afef38
> [   16.386355] [<c007ab94>] (call_console_drivers.constprop.25) from
> [<c007be84>] (console_unlock+0x3fc/0x57c)
> [   16.386367]  r10:c132fff0 r9:00000100 r8:00000037 r7:00000000
> r6:00000005 r5:c12f4df0
> 
> Signed-off-by: Robin Gong <b38343@freescale.com>
> ---
>  drivers/tty/serial/imx.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)

I remember there had patch for this.
