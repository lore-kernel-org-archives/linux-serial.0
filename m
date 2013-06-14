From: Ross Lagerwall <rosslagerwall@gmail.com>
Subject: [PATCH] tty/vt: Return EBUSY if deallocating VT1 and it is busy
Date: Fri, 14 Jun 2013 23:24:25 +0100
Message-ID: <1371248665-1176-1-git-send-email-rosslagerwall@gmail.com>
References: <20130614213543.GA1896@kroah.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:49644 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab3FNWYq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Jun 2013 18:24:46 -0400
In-Reply-To: <20130614213543.GA1896@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dave Jones <davej@redhat.com>, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, Ross Lagerwall <rosslagerwall@gmail.com>

Commit 421b40a6286e ("tty/vt: Fix vc_deallocate() lock order") changed
the behavior when deallocating VT 1.  Previously if trying to
deallocate VT1 and it is busy, we would return EBUSY.  The commit
changed this to return 0 (success).

This commit restores the old behavior.

Signed-off-by: Ross Lagerwall <rosslagerwall@gmail.com>
---
On 06/14/2013 05:35 PM, Greg KH wrote:
> p.s. In the future, please cc: the people who handled the patch you are
> asking about, otherwise stuff like this often gets missed in the noise
> of lkml.

Yes, sorry about that.  I only remembered after I sent the email.

 drivers/tty/vt/vt_ioctl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt_ioctl.c b/drivers/tty/vt/vt_ioctl.c
index fc2c06c..2bd78e2 100644
--- a/drivers/tty/vt/vt_ioctl.c
+++ b/drivers/tty/vt/vt_ioctl.c
@@ -289,13 +289,10 @@ static int vt_disallocate(unsigned int vc_num)
 	struct vc_data *vc = NULL;
 	int ret = 0;
 
-	if (!vc_num)
-		return 0;
-
 	console_lock();
 	if (VT_BUSY(vc_num))
 		ret = -EBUSY;
-	else
+	else if (vc_num)
 		vc = vc_deallocate(vc_num);
 	console_unlock();
 
-- 
1.8.3.1

