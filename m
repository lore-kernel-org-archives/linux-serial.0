From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/2] TTY: serial/ifx6x60, initialize more
Date: Thu, 31 Mar 2016 10:23:34 +0200
Message-ID: <1459412614-4549-2-git-send-email-jslaby@suse.cz>
References: <1459412614-4549-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1459412614-4549-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-serial@vger.kernel.org

In ifx_spi_complete, 'more' is not initialized. It is set only if the
status is clear and only if the header is parsed OK. If any of those
is not true, 'more' can be used uninitialized in that function later.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/serial/ifx6x60.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/ifx6x60.c b/drivers/tty/serial/ifx6x60.c
index 2085a6cfa44b..d386346248de 100644
--- a/drivers/tty/serial/ifx6x60.c
+++ b/drivers/tty/serial/ifx6x60.c
@@ -651,7 +651,7 @@ static void ifx_spi_complete(void *ctx)
 	struct ifx_spi_device *ifx_dev = ctx;
 	int length;
 	int actual_length;
-	unsigned char more;
+	unsigned char more = 0;
 	unsigned char cts;
 	int local_write_pending = 0;
 	int queue_length;
-- 
2.7.4
