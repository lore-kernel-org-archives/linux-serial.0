From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 1/4] n_gsm: Copy n2 over when configuring via ioctl interface
Date: Thu, 04 Nov 2010 15:16:24 +0000
Message-ID: <20101104151623.21790.64456.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:49378 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751695Ab0KDPhX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Nov 2010 11:37:23 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: torvalds@linux-foundation.org, linux-serial@vger.kernel.org

From: Ken Mills <ken.k.mills@intel.com>

The n2 field is settable but didn't get propogated

Signed-off-by: Ken Mills <ken.k.mills@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/char/n_gsm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


diff --git a/drivers/char/n_gsm.c b/drivers/char/n_gsm.c
index 04ef3ef..7f79044 100644
--- a/drivers/char/n_gsm.c
+++ b/drivers/char/n_gsm.c
@@ -2375,6 +2375,7 @@ static int gsmld_config(struct tty_struct *tty, struct gsm_mux *gsm,
 	gsm->mru = c->mru;
 	gsm->encoding = c->encapsulation;
 	gsm->adaption = c->adaption;
+	gsm->n2 = c->n2;
 
 	if (c->i == 1)
 		gsm->ftype = UIH;

