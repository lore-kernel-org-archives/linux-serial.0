From: Anton Vasilyev <vasilyev@ispras.ru>
Subject: [PATCH v2] serial: mxs-auart: Fix potential infinite loop
Date: Tue,  7 Aug 2018 13:59:05 +0300
Message-ID: <20180807105905.18264-1-vasilyev@ispras.ru>
References: <20180806164346.9986-1-vasilyev@ispras.ru>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180806164346.9986-1-vasilyev@ispras.ru>
References: 
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Anton Vasilyev <vasilyev@ispras.ru>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-serial@vger.kernel.org

On the error path of mxs_auart_request_gpio_irq() is performed
backward iterating with index i of enum type. Underline enum type
may be unsigned char. In this case check (--i >= 0) will be always
true and error handling goes into infinite loop.

The patch changes the check so that it is valid for signed and unsigned
types.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
v2: mistype in patch as result of combination of different fixes.
Change comment and leave enum type.
---
 drivers/tty/serial/mxs-auart.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 76aa289652f7..27235a526cce 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1634,8 +1634,9 @@ static int mxs_auart_request_gpio_irq(struct mxs_auart_port *s)
 
 	/*
 	 * If something went wrong, rollback.
+	 * Be careful: i may be unsigned.
 	 */
-	while (err && (--i >= 0))
+	while (err && (i-- > 0))
 		if (irq[i] >= 0)
 			free_irq(irq[i], s);
 
-- 
2.18.0
