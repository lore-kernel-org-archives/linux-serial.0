From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 57/79] drivers/tty: don't use the byte channel handle as a parameter in ehv_bytechan.c
Date: Wed, 26 Oct 2011 14:13:02 +0200
Message-ID: <1319631204-23262-57-git-send-email-gregkh@suse.de>
References: <20111026114236.GA22180@kroah.com>
 <1319631204-23262-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:32829 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932929Ab1JZMNz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 26 Oct 2011 08:13:55 -0400
In-Reply-To: <1319631204-23262-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Timur Tabi <timur@freescale.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Timur Tabi <timur@freescale.com>

The ePAPR hypervisor byte channel console driver only supports one byte
channel as a console, and the byte channel handle is stored in a global
variable.  It doesn't make any sense to pass that handle as a parameter
to the console functions, since these functions already have access to the
global variable.

Signed-off-by: Timur Tabi <timur@freescale.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/ehv_bytechan.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
index f733718..1595dba 100644
--- a/drivers/tty/ehv_bytechan.c
+++ b/drivers/tty/ehv_bytechan.c
@@ -282,7 +282,6 @@ static int ehv_bc_console_byte_channel_send(unsigned int handle, const char *s,
 static void ehv_bc_console_write(struct console *co, const char *s,
 				 unsigned int count)
 {
-	unsigned int handle = (uintptr_t)co->data;
 	char s2[EV_BYTE_CHANNEL_MAX_BYTES];
 	unsigned int i, j = 0;
 	char c;
@@ -295,14 +294,14 @@ static void ehv_bc_console_write(struct console *co, const char *s,
 
 		s2[j++] = c;
 		if (j >= (EV_BYTE_CHANNEL_MAX_BYTES - 1)) {
-			if (ehv_bc_console_byte_channel_send(handle, s2, j))
+			if (ehv_bc_console_byte_channel_send(stdout_bc, s2, j))
 				return;
 			j = 0;
 		}
 	}
 
 	if (j)
-		ehv_bc_console_byte_channel_send(handle, s2, j);
+		ehv_bc_console_byte_channel_send(stdout_bc, s2, j);
 }
 
 /*
@@ -348,8 +347,6 @@ static int __init ehv_bc_console_init(void)
 			   CONFIG_PPC_EARLY_DEBUG_EHV_BC_HANDLE);
 #endif
 
-	ehv_bc_console.data = (void *)(uintptr_t)stdout_bc;
-
 	/* add_preferred_console() must be called before register_console(),
 	   otherwise it won't work.  However, we don't want to enumerate all the
 	   byte channels here, either, since we only care about one. */
-- 
1.7.7

