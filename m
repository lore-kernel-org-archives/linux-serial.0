From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 09/12] tty: n_gsm: improper skb_pull() use was leaking framed data
Date: Tue, 28 Jun 2011 09:03:46 -0700
Message-ID: <1309277029-1532-9-git-send-email-gregkh@suse.de>
References: <20110628153856.GB32710@kroah.com>
 <1309277029-1532-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:50244 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759227Ab1F1QEE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Jun 2011 12:04:04 -0400
In-Reply-To: <1309277029-1532-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Russ Gorby <russ.gorby@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Russ Gorby <russ.gorby@intel.com>

gsm_dlci_data_output_framed() was doing:
memcpy(dp, skb_pull(dlci->skb, len), len);

The problem is skb_pull() returns the post-increment data ptr
so the first chunk of dlci->skb->data is leaked.

Signed-off-by: Russ Gorby <russ.gorby@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/n_gsm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 7290394..19b4ae0 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -875,7 +875,8 @@ static int gsm_dlci_data_output_framed(struct gsm_mux *gsm,
 		*dp++ = last << 7 | first << 6 | 1;	/* EA */
 		len--;
 	}
-	memcpy(dp, skb_pull(dlci->skb, len), len);
+	memcpy(dp, dlci->skb->data, len);
+	skb_pull(dlci->skb, len);
 	__gsm_data_queue(dlci, msg);
 	if (last)
 		dlci->skb = NULL;
-- 
1.7.5.4

