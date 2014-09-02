From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 10/26] serial: core: Document lock requirement for UPF_* flags updates
Date: Tue,  2 Sep 2014 17:39:19 -0400
Message-ID: <1409693975-1028-11-git-send-email-peter@hurleysoftware.com>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The flags field of struct uart_port can only be safely modified
if the port mutex is held; no other lock prevents concurrent
changes from corrupting the field.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 include/linux/serial_core.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 5bbb809..4a43292 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -152,6 +152,7 @@ struct uart_port {
 	unsigned long		sysrq;			/* sysrq timeout */
 #endif
 
+	/* flags must be updated while holding port mutex */
 	upf_t			flags;
 
 #define UPF_FOURPORT		((__force upf_t) (1 << 1))
-- 
2.1.0
