From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC RESEND] serial: 8250: fix regression in 8250 uart driver
Date: Tue, 23 Aug 2016 18:03:01 +0300
Message-ID: <1471964581.4887.236.camel@linux.intel.com>
References: <575F7325.3030907@kernel.org>
         <1465897220.30123.26.camel@linux.intel.com>
         <cca9fb6eca58d8a29e3070e3f34fa40f.squirrel@emailmg.ipower.com>
         <1465920046.30123.83.camel@linux.intel.com>
         <dbaa0abe-06ab-57ee-4ba3-4e4717af4a62@leemhuis.info>
         <1471432466.4887.134.camel@linux.intel.com>
         <abf9f9cb-c14c-7efb-8d1c-ed89a6a979a3@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <abf9f9cb-c14c-7efb-8d1c-ed89a6a979a3@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dinh Nguyen <dinguyen@kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>
Cc: heikki.krogerus@linux.intel.com, peter@hurleysoftware.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-08-23 at 08:53 -0500, Dinh Nguyen wrote:
> Hi Andy,
> 
> On 08/17/2016 06:14 AM, Andy Shevchenko wrote:
> > 
> > 
> > I sent a v2 of the series for internal review, same you may found on
> > [1]. If Heikki is okay to that I'll send it here.
> > 
> > [1] https://bitbucket.org/andy-shev/linux/branch/topic%2Fdw%2Fqrk
> > 
> 
> I tested this branch on SoCFPGA hardware and encountered this
> error[1].
> Doing a bisect led me to this commit[2].

Thanks! Found today the same.

Yes, here is the fix (will push an updated version later):


--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -260,7 +260,7 @@ void serial8250_release_dma(struct uart_8250_port
*p)
 {
        struct uart_8250_dma *dma = p->dma;

-       if (!dma)
+       if (!dma->in_use)
                return;

        /* Release RX resources */

> 
> Dinh
> 
> 
> --------------------[1]------------------------------
> 
> [    5.907714] ttyS0 - failed to request DMA
> [    5.921937] VFS: Mounted root (nfs filesystem) on device 0:13.
> [    5.928732] devtmpfs: mounted
> [    5.932504] Freeing unused kernel memory: 1024K (c0900000 -
> c0a00000)
> [    6.004532] Unable to handle kernel NULL pointer dereference at
> virtual address 0000000c
> [    6.012619] pgd = ef670000
> [    6.015321] [0000000c] *pgd=2ec0a831, *pte=00000000, *ppte=00000000
> [    6.021609] Internal error: Oops: 17 [#1] SMP ARM
> [    6.026301] Modules linked in:
> [    6.029365] CPU: 1 PID: 1 Comm: init Not tainted
> 4.8.0-rc3-00063-g6ce52b1 #12
> [    6.036476] Hardware name: Altera SOCFPGA
> [    6.040476] task: ef4ac000 task.stack: ef4b0000
> [    6.045007] PC is at _stop+0x4/0x254
> [    6.048579] LR is at pl330_terminate_all+0x4c/0x1e4
> [    6.053447] pc : [<c03c2e5c>]    lr : [<c03c30f8>]    psr: 60000093
> [    6.053447] sp : ef4b1e88  ip : 00000000  fp : 0000a109
> [    6.064890] r10: 00000000  r9 : ef7c7cc0  r8 : eedfaa94
> [    6.070099] r7 : eed30410  r6 : eec2be0c  r5 : 60000013  r4 :
> eec2be70
> [    6.076605] r3 : 00000002  r2 : 00000002  r1 : 00000000  r0 :
> 00000000
> [    6.083113] Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
> Segment none
> [    6.090318] Control: 10c5387d  Table: 2f67004a  DAC: 00000051
> [    6.096046] Process init (pid: 1, stack limit = 0xef4b0218)
> [    6.101603] Stack: (0xef4b1e88 to 0xef4b2000)
> [    6.105953] 1e80:                   eec2be70 60000013 eec2be0c
> eedfaa94 ef7c7cc0 c03c30f8
> [    6.114112] 1ea0: ef4b1ea0 ef4b1ea0 eedfaa00 eed8c02c eec2be20
> 20000013 c0a66208 c03f2b44
> [    6.122272] 1ec0: 00000001 00000000 c0a66208 c0a66208 c0a66324
> 20000013 c0a66208 eedfaa94
> [    6.130432] 1ee0: ef7c7cc0 c03f041c eedfaa00 c0a66208 eedfaa8c
> c03ea774 eedfaa00 ef7cec00
> [    6.138592] 1f00: c0a66208 00000001 eedfaa94 c03eb9a4 ef7cec00
> ef1a2930 00000000 ef41bd90
> [    6.146751] 1f20: ef1a4440 c03d0790 00080040 00080060 00000000
> 00000000 00002710 ef7c7cc0
> [    6.154911] 1f40: ef1a2930 00000000 ef41bd90 ef1a4440 00000008
> ef7c7cc8 0000a109 c021b594
> [    6.163071] 1f60: 00000000 00000000 ef4ac3d4 c0a532f8 00000000
> ef4ac000 c0107884 ef4b0000
> [    6.171231] 1f80: 00000000 c0138a14 ef4b0000 ef4b1fb0 c0107884
> 00000006 c0107884 c010b274
> [    6.179390] 1fa0: 00015500 00000000 bea16c4c c0107714 00000000
> 00000800 00000045 0000c79c
> [    6.187550] 1fc0: 00015500 00000000 bea16c4c 00000006 bea16bc0
> 00009c59 10000000 0000a109
> [    6.195709] 1fe0: 00000000 bea16bb4 0000bf81 b6f6413c 40000010
> 00000002 00000c84 01000002
> [    6.203878] [<c03c2e5c>] (_stop) from [<c03c30f8>]
> (pl330_terminate_all+0x4c/0x1e4)
> [    6.211526] [<c03c30f8>] (pl330_terminate_all) from [<c03f2b44>]
> (serial8250_release_dma+0x30/0x1c8)
> [    6.220640] [<c03f2b44>] (serial8250_release_dma) from [<c03f041c>]
> (serial8250_do_shutdown+0x64/0x144)
> [    6.230019] [<c03f041c>] (serial8250_do_shutdown) from [<c03ea774>]
> (uart_shutdown+0xd0/0x104)
> [    6.238614] [<c03ea774>] (uart_shutdown) from [<c03eb9a4>]
> (uart_close+0x148/0x298)
> [    6.246266] [<c03eb9a4>] (uart_close) from [<c03d0790>]
> (tty_release+0xf0/0x4d4)
> [    6.253658] [<c03d0790>] (tty_release) from [<c021b594>]
> (__fput+0x80/0x1c8)
> [    6.260694] [<c021b594>] (__fput) from [<c0138a14>]
> (task_work_run+0xb8/0xe8)
> [    6.267822] [<c0138a14>] (task_work_run) from [<c010b274>]
> (do_work_pending+0x7c/0xa4)
> [    6.275727] [<c010b274>] (do_work_pending) from [<c0107714>]
> (slow_work_pending+0xc/0x20)
> [    6.283888] Code: e8bd8070 e3a04000 eafffff9 e92d4370 (e590300c)
> [    6.289963] ---[ end trace e214cd70660516e6 ]---
> [    6.294806] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> [    6.294806]
> [    6.303932] CPU0: stopping
> [    6.306645] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D
> 4.8.0-rc3-00063-g6ce52b1 #12
> [    6.315406] Hardware name: Altera SOCFPGA
> [    6.319425] [<c010fef0>] (unwind_backtrace) from [<c010b8a4>]
> (show_stack+0x10/0x14)
> [    6.327159] [<c010b8a4>] (show_stack) from [<c037aa18>]
> (dump_stack+0x84/0x98)
> [    6.334372] [<c037aa18>] (dump_stack) from [<c010edb4>]
> (handle_IPI+0x2a0/0x2bc)
> [    6.341755] [<c010edb4>] (handle_IPI) from [<c01014cc>]
> (gic_handle_irq+0x88/0x8c)
> [    6.349310] [<c01014cc>] (gic_handle_irq) from [<c010c38c>]
> (__irq_svc+0x6c/0x90)
> [    6.356775] Exception stack(0xc0a01f50 to 0xc0a01f98)
> [    6.361815] 1f40:                                     00000000
> ef9cd368 0000153c c01184a0
> [    6.369976] 1f60: c0a00000 c0a024a4 c0a023c0 c0a50390 c0a02454
> 00000001 c0a02454 00000000
> [    6.378135] 1f80: 60000013 c0a01fa0 c01081a8 c01081ac 60000013
> ffffffff
> [    6.384734] [<c010c38c>] (__irq_svc) from [<c01081ac>]
> (arch_cpu_idle+0x38/0x3c)
> [    6.392127] [<c01081ac>] (arch_cpu_idle) from [<c0158cec>]
> (cpu_startup_entry+0x204/0x25c)
> [    6.400379] [<c0158cec>] (cpu_startup_entry) from [<c0900c60>]
> (start_kernel+0x370/0x37c)
> [    6.408542] ---[ end Kernel panic - not syncing: Attempted to kill
> init! exitcode=0x0000000b
> [    6.408542]
> 
> 
> --------------------[2]----------------------------------
> commit 60a0605738814ca8fa180cdfef20fcc2a32ec1ef
> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date:   Mon Jun 13 12:17:03 2016 +0300
> 
>     serial: 8250: allow user to skip using of DMA channels
> 
>     Currently DMA mode is enforced if the certain driver has such
> support. It prevents user to enforce PIO mode for RX, TX, or both.
> 
>     The new module parameters skip_rxdma and skip_txdma allow user to
> choose between auto mode, which is current and default behaviour,
> disable RX, TX, or both DMA channels without hacking a kernel.
> 
>     Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
