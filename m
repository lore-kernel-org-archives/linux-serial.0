From: Johan Hovold <johan@kernel.org>
Subject: [PATCH] tty: ehv_bytechan: clean up init error handling
Date: Wed, 26 Apr 2017 12:30:04 +0200
Message-ID: <20170426103004.30066-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Timur Tabi <timur@codeaurora.org>, Johan Hovold <johan@kernel.org>
List-Id: linux-serial@vger.kernel.org

Straighten out the initcall error handling to avoid deregistering a
never-registered tty driver (something which would lead to a
NULL-pointer dereference) in the most unlikely event that driver
registration fails (e.g. we've run out of major numbers).

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/ehv_bytechan.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
index 7ac9bcdf1e61..61fe8d6fd24e 100644
--- a/drivers/tty/ehv_bytechan.c
+++ b/drivers/tty/ehv_bytechan.c
@@ -764,7 +764,7 @@ static int __init ehv_bc_init(void)
 	ehv_bc_driver = alloc_tty_driver(count);
 	if (!ehv_bc_driver) {
 		ret = -ENOMEM;
-		goto error;
+		goto err_free_bcs;
 	}
 
 	ehv_bc_driver->driver_name = "ehv-bc";
@@ -778,24 +778,23 @@ static int __init ehv_bc_init(void)
 	ret = tty_register_driver(ehv_bc_driver);
 	if (ret) {
 		pr_err("ehv-bc: could not register tty driver (ret=%i)\n", ret);
-		goto error;
+		goto err_put_tty_driver;
 	}
 
 	ret = platform_driver_register(&ehv_bc_tty_driver);
 	if (ret) {
 		pr_err("ehv-bc: could not register platform driver (ret=%i)\n",
 		       ret);
-		goto error;
+		goto err_deregister_tty_driver;
 	}
 
 	return 0;
 
-error:
-	if (ehv_bc_driver) {
-		tty_unregister_driver(ehv_bc_driver);
-		put_tty_driver(ehv_bc_driver);
-	}
-
+err_deregister_tty_driver:
+	tty_unregister_driver(ehv_bc_driver);
+err_put_tty_driver:
+	put_tty_driver(ehv_bc_driver);
+err_free_bcs:
 	kfree(bcs);
 
 	return ret;
-- 
2.12.2
