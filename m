From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 3/5] hsu, earlyprintk: remove the GPIO work around
Date: Mon, 06 Sep 2010 13:39:45 +0100
Message-ID: <20100906123935.1328.17198.stgit@localhost.localdomain>
References: <20100906123843.1328.3930.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:2972 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753147Ab0IFNW2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Sep 2010 09:22:28 -0400
In-Reply-To: <20100906123843.1328.3930.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, greg@kroah.com

From: Feng Tang <feng.tang@intel.com>

Latest firmware will correctly configure the GPIO lines used by
hsu console, so remove that workaround.

Signed-off-by: Feng Tang <feng.tang@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 arch/x86/kernel/mrst_earlyprintk.c |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)


diff --git a/arch/x86/kernel/mrst_earlyprintk.c b/arch/x86/kernel/mrst_earlyprintk.c
index 1fb1305..d1a49a7 100644
--- a/arch/x86/kernel/mrst_earlyprintk.c
+++ b/arch/x86/kernel/mrst_earlyprintk.c
@@ -287,17 +287,10 @@ void mrst_early_printk(const char *fmt, ...)
 
 
 /* Will use HSU port2 for early console */
-
-/*
- * Note:
- * 1. still need GPIO workaround for UART2
- *
- */
 static spinlock_t hsu_lock;
 static int hsu_inited;
 static void __iomem *phsu;
 #define HSU_PORT2_PADDR		0xffa28180
-#define MFD_GPIO_HSU_REG	0xff12c064
 
 static void early_hsu_init(void)
 {
@@ -308,13 +301,6 @@ static void early_hsu_init(void)
 
 	spin_lock_init(&hsu_lock);
 
-	/* GPIO workaround */
-	set_fixmap_nocache(FIX_EARLYCON_MEM_BASE, MFD_GPIO_HSU_REG);
-	phsu = (void *)(__fix_to_virt(FIX_EARLYCON_MEM_BASE) +
-			(MFD_GPIO_HSU_REG & (PAGE_SIZE - 1)));
-
-	*((u32 *)phsu) = 0x55465;
-
 	set_fixmap_nocache(FIX_EARLYCON_MEM_BASE, HSU_PORT2_PADDR);
 	phsu = (void *)(__fix_to_virt(FIX_EARLYCON_MEM_BASE) +
 			(HSU_PORT2_PADDR & (PAGE_SIZE - 1)));
@@ -338,8 +324,6 @@ static void early_hsu_init(void)
 	readb(phsu + UART_IIR);
 	readb(phsu + UART_MSR);
 
-
-
 	writeb(0x7, phsu + UART_FCR);
 
 	hsu_inited = 1;
@@ -371,10 +355,6 @@ static void early_hsu_write(struct console *con,
 	int  i;
 	unsigned long flags;
 
-	/*
-	printk("%s(): enter\n\n", __func__);
-	*/
-
 	if (unlikely(!hsu_inited))
 		early_hsu_init();
 

