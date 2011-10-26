From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 42/79] tty/powerpc: fix build break with ehv_bytechan.c on allyesconfig
Date: Wed, 26 Oct 2011 14:12:47 +0200
Message-ID: <1319631204-23262-42-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32783 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932906Ab1JZMNr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:47 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Timur Tabi <timur@freescale.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Timur Tabi <timur@freescale.com>

The ePAPR hypervisor byte channel driver is supposed to work on all
ePAPR-compliant embedded PowerPC systems, but it had a reference to the MSR_GS
bit, which is available only on Book-E systems.

Also fix a couple integer-to-pointer typecast problems.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Timur Tabi <timur@freescale.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/ehv_bytechan.c |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
index e67f70b..f733718 100644
--- a/drivers/tty/ehv_bytechan.c
+++ b/drivers/tty/ehv_bytechan.c
@@ -226,10 +226,6 @@ void __init udbg_init_ehv_bc(void)
 	unsigned int rx_count, tx_count;
 	unsigned int ret;
 
-	/* Check if we're running as a guest of a hypervisor */
-	if (!(mfmsr() & MSR_GS))
-		return;
-
 	/* Verify the byte channel handle */
 	ret = ev_byte_channel_poll(CONFIG_PPC_EARLY_DEBUG_EHV_BC_HANDLE,
 				   &rx_count, &tx_count);
@@ -286,7 +282,7 @@ static int ehv_bc_console_byte_channel_send(unsigned int handle, const char *s,
 static void ehv_bc_console_write(struct console *co, const char *s,
 				 unsigned int count)
 {
-	unsigned int handle = (unsigned int)co->data;
+	unsigned int handle = (uintptr_t)co->data;
 	char s2[EV_BYTE_CHANNEL_MAX_BYTES];
 	unsigned int i, j = 0;
 	char c;
@@ -352,7 +348,7 @@ static int __init ehv_bc_console_init(void)
 			   CONFIG_PPC_EARLY_DEBUG_EHV_BC_HANDLE);
 #endif
 
-	ehv_bc_console.data = (void *)stdout_bc;
+	ehv_bc_console.data = (void *)(uintptr_t)stdout_bc;
 
 	/* add_preferred_console() must be called before register_console(),
 	   otherwise it won't work.  However, we don't want to enumerate all the
-- 
1.7.7

