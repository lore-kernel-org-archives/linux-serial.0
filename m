From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 2/4] n_gsm: Fix length handling
Date: Thu, 04 Nov 2010 15:16:42 +0000
Message-ID: <20101104151636.21790.59330.stgit@localhost.localdomain>
References: <20101104151623.21790.64456.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:49380 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950Ab0KDPhj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Nov 2010 11:37:39 -0400
In-Reply-To: <20101104151623.21790.64456.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@linux-foundation.org, linux-serial@vger.kernel.org

From: Ken Mills <ken.k.mills@intel.com>

If the mux is configured with a large mru/mtu the existing code gets the
byte ordering wrong for the header.

Signed-off-by: Ken Mills <ken.k.mills@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/char/n_gsm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff --git a/drivers/char/n_gsm.c b/drivers/char/n_gsm.c
index 7f79044..81b4658 100644
--- a/drivers/char/n_gsm.c
+++ b/drivers/char/n_gsm.c
@@ -716,8 +716,8 @@ static void __gsm_data_queue(struct gsm_dlci *dlci, struct gsm_msg *msg)
 		if (msg->len < 128)
 			*--dp = (msg->len << 1) | EA;
 		else {
-			*--dp = (msg->len >> 6) | EA;
-			*--dp = (msg->len & 127) << 1;
+			*--dp = ((msg->len & 127) << 1) | EA;
+			*--dp = (msg->len >> 6) & 0xfe;
 		}
 	}
 

