From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] n_gsm: Fix incorrect debug display
Date: Mon, 17 Sep 2012 12:02:35 +0100
Message-ID: <20120917110232.30500.76471.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:32944 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752668Ab2IQKoJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 17 Sep 2012 06:44:09 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: greg@kroah.com, linux-serial@vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

In the trace we print the wrong values for N(R) on an I frame.
Correct the mask.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/n_gsm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 3e210a4..1e8e8ce 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -488,7 +488,7 @@ static void gsm_print_packet(const char *hdr, int addr, int cr,
 	default:
 		if (!(control & 0x01)) {
 			pr_cont("I N(S)%d N(R)%d",
-				(control & 0x0E) >> 1, (control & 0xE) >> 5);
+				(control & 0x0E) >> 1, (control & 0xE0) >> 5);
 		} else switch (control & 0x0F) {
 			case RR:
 				pr_cont("RR(%d)", (control & 0xE0) >> 5);

