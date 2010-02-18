From: Alan Cox <alan@linux.intel.com>
Subject: [PATCH 5/6] tty: kill request_room for USB ACM class
Date: Thu, 18 Feb 2010 16:44:16 +0000
Message-ID: <20100218164414.31856.24343.stgit@localhost.localdomain>
References: <20100218164104.31856.89546.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33888 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755850Ab0BRRIP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Feb 2010 12:08:15 -0500
In-Reply-To: <20100218164104.31856.89546.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/usb/class/cdc-acm.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)


diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 5155ff2..95a18e5 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -428,7 +428,6 @@ next_buffer:
 		throttled = acm->throttle;
 		spin_unlock_irqrestore(&acm->throttle_lock, flags);
 		if (!throttled) {
-			tty_buffer_request_room(tty, buf->size);
 			tty_insert_flip_string(tty, buf->base, buf->size);
 			tty_flip_buffer_push(tty);
 		} else {

