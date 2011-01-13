From: Davidlohr Bueso <dave@gnu.org>
Subject: [PATCH] input: ct82710c: return proper error code for ct82c710_open
Date: Thu, 13 Jan 2011 14:35:50 -0300
Message-ID: <1294940150.2200.4.camel@offworld>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hapkido.dreamhost.com ([66.33.216.122]:40336 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756571Ab1AMRgj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Jan 2011 12:36:39 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: LKML <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

If request_irq() fails we should return the proper error instead of -1.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 drivers/input/serio/ct82c710.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/input/serio/ct82c710.c b/drivers/input/serio/ct82c710.c
index 448c772..ee0edd0 100644
--- a/drivers/input/serio/ct82c710.c
+++ b/drivers/input/serio/ct82c710.c
@@ -111,9 +111,11 @@ static void ct82c710_close(struct serio *serio)
 static int ct82c710_open(struct serio *serio)
 {
 	unsigned char status;
+	int err = 0;
 
-	if (request_irq(CT82C710_IRQ, ct82c710_interrupt, 0, "ct82c710", NULL))
-		return -1;
+	err = request_irq(CT82C710_IRQ, ct82c710_interrupt, 0, "ct82c710", NULL);
+	if (err)
+		goto out;
 
 	status = inb_p(CT82C710_STATUS);
 
@@ -133,8 +135,8 @@ static int ct82c710_open(struct serio *serio)
 		free_irq(CT82C710_IRQ, NULL);
 		return -1;
 	}
-
-	return 0;
+out:
+	return err;
 }
 
 /*
-- 
1.7.1



