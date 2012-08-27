From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 0/2] tty: serial: imx: fix lockup and garbage on SMP
Date: Mon, 27 Aug 2012 09:36:50 +0200
Message-ID: <1346053012-25686-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1040421177910210205=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dirk Behme <dirk.behme@de.bosch.com>, kernel@pengutronix.de, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

--===============1040421177910210205==
Content-Type: text/plain

The following two patches are a port from Freescale's patch

http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/commit/drivers/tty/serial/imx.c?h=imx_3.0.15_android&id=80e525d66d1818722db18e21dc7f1dc41f314156

Using a 3.6-rc3 kernel on a i.MX6 SabreLite board and increasing the
verbosity of the kernel's serial console output with some debug printk
like [1] results in two issues:

1. After some time the kernel output hangs [2]. The debugger tells us that
it hangs in drivers/tty/serial/imx.c at

...
/*
 *	Finally, wait for transmitter to become empty
 *	and restore UCR1/2/3
 */
while (!(readl(sport->port.membase + USR2) & USR2_TXDC));
...

with permanently reading 0x1000 from USR2 while it waits for bit USR2_TXDC
(0x8).

2. Even after applying the first patch, there happens to be some garbage in the
   output [3].

Both issues are gone applying these two patches.

Note: If these patches are fine, they should go to stable, too.

Best regards

Dirk

[1]

Index: a/mm/mmap.c
===================================================================
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1290,6 +1290,9 @@ munmap_back:
 	vma->vm_pgoff = pgoff;
 	INIT_LIST_HEAD(&vma->anon_vma_chain);
 
+	printk(" => mmap_region: start: 0x%08X end: 0x%08X len: %d\n",
+		(unsigned int)vma->vm_start, (unsigned int)vma->vm_end, (int)len);
+
 	error = -EINVAL;	/* when rejecting VM_GROWSDOWN|VM_GROWSUP */
 
 	if (file) {

[2]
...
=> mmap_region: start: 0x76DBC000 end: 0x76DBE000 len: 8192
=> mmap_region: start: 0x76DBE000 end: 0x76DC0000 len: 8192
=> mmap_region: start: 0x76D5C000 end: 0x76DA0000 ÿ
<hang, no output any more>

[3]
...
=> mmap_region: start: 0x0011C000 end: 0x0011D000 len: 4096
=> mmap_region: start: 0x00008000 end: 0x000B500fè#.Æ ÄRèérêòjµ…Á}É¥½¹é start: 0x000BD000 end: 0x000BE000 len: 4096
=> mmap_region: start: 0x000BD000 end: 0x000BE000 len: 4096
...


--===============1040421177910210205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1040421177910210205==--
