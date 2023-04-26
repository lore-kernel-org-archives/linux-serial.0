Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2026C77B7C
	for <linux-serial@archiver.kernel.org>; Wed, 26 Apr 2023 08:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239838AbjDZIDl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 26 Apr 2023 04:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239945AbjDZIDg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 26 Apr 2023 04:03:36 -0400
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC56E3C38
        for <linux-serial@vger.kernel.org>; Wed, 26 Apr 2023 01:03:33 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20230426080331d2961079336de0e726
        for <linux-serial@vger.kernel.org>;
        Wed, 26 Apr 2023 10:03:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=p6b7aAXTOy3vsIR4rxhbr+q8rc2g+ZY+H/rSFp5TQGY=;
 b=LqDNIFJmKyyINdmHMrgjdtlcucp/LjFeNDXynofdo4G/e32VT5YAMlQ5Z4MXqdPUouHhHi
 Cg2nQrAuo05jE7gZJj0uPufgdAMN73kbr49SNovSNnaAFuTdVENdeYqs620LhcddCNvloSzC
 POJ/URDsS2myMWx+X1e4Qvi1HxvLo=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v4 4/8] tty: n_gsm: add open_error counter to gsm_mux
Date:   Wed, 26 Apr 2023 10:03:11 +0200
Message-Id: <20230426080315.7595-4-daniel.starke@siemens.com>
In-Reply-To: <20230426080315.7595-1-daniel.starke@siemens.com>
References: <20230426080315.7595-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Extend the n_gsm link statistics by a failed link open counter in
preparation for an upcoming patch which will expose these.
This counter is increased whenever an attempt to open the control channel
failed. This is true in the following cases:
- new DLCI allocation failed
- connection request (SAMB) with invalid CR flag has been received
- connection response (UA) timed out
- parameter negotiation timed out or failed

Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

v3 -> v4:
No changes.

Link: https://lore.kernel.org/all/20230424075251.5216-4-daniel.starke@siemens.com/

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index ebb71957f783..186f463f0f11 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -339,6 +339,7 @@ struct gsm_mux {
 	unsigned long bad_fcs;
 	unsigned long malformed;
 	unsigned long io_error;
+	unsigned long open_error;
 	unsigned long bad_size;
 	unsigned long unsupported;
 };
@@ -1730,25 +1731,32 @@ static void gsm_control_negotiation(struct gsm_mux *gsm, unsigned int cr,
 	struct gsm_dlci *dlci;
 	struct gsm_dlci_param_bits *params;
 
-	if (dlen < sizeof(struct gsm_dlci_param_bits))
+	if (dlen < sizeof(struct gsm_dlci_param_bits)) {
+		gsm->open_error++;
 		return;
+	}
 
 	/* Invalid DLCI? */
 	params = (struct gsm_dlci_param_bits *)data;
 	addr = FIELD_GET(PN_D_FIELD_DLCI, params->d_bits);
-	if (addr == 0 || addr >= NUM_DLCI || !gsm->dlci[addr])
+	if (addr == 0 || addr >= NUM_DLCI || !gsm->dlci[addr]) {
+		gsm->open_error++;
 		return;
+	}
 	dlci = gsm->dlci[addr];
 
 	/* Too late for parameter negotiation? */
-	if ((!cr && dlci->state == DLCI_OPENING) || dlci->state == DLCI_OPEN)
+	if ((!cr && dlci->state == DLCI_OPENING) || dlci->state == DLCI_OPEN) {
+		gsm->open_error++;
 		return;
+	}
 
 	/* Process the received parameters */
 	if (gsm_process_negotiation(gsm, addr, cr, params) != 0) {
 		/* Negotiation failed. Close the link. */
 		if (debug & DBG_ERRORS)
 			pr_info("%s PN failed\n", __func__);
+		gsm->open_error++;
 		gsm_dlci_close(dlci);
 		return;
 	}
@@ -1768,6 +1776,7 @@ static void gsm_control_negotiation(struct gsm_mux *gsm, unsigned int cr,
 	} else {
 		if (debug & DBG_ERRORS)
 			pr_info("%s PN in invalid state\n", __func__);
+		gsm->open_error++;
 	}
 }
 
@@ -2221,6 +2230,7 @@ static void gsm_dlci_t1(struct timer_list *t)
 			dlci->retries--;
 			mod_timer(&dlci->t1, jiffies + gsm->t1 * HZ / 100);
 		} else {
+			gsm->open_error++;
 			gsm_dlci_begin_close(dlci); /* prevent half open link */
 		}
 		break;
@@ -2236,6 +2246,7 @@ static void gsm_dlci_t1(struct timer_list *t)
 			dlci->mode = DLCI_MODE_ADM;
 			gsm_dlci_open(dlci);
 		} else {
+			gsm->open_error++;
 			gsm_dlci_begin_close(dlci); /* prevent half open link */
 		}
 
@@ -2757,12 +2768,16 @@ static void gsm_queue(struct gsm_mux *gsm)
 
 	switch (gsm->control) {
 	case SABM|PF:
-		if (cr == 1)
+		if (cr == 1) {
+			gsm->open_error++;
 			goto invalid;
+		}
 		if (dlci == NULL)
 			dlci = gsm_dlci_alloc(gsm, address);
-		if (dlci == NULL)
+		if (dlci == NULL) {
+			gsm->open_error++;
 			return;
+		}
 		if (dlci->dead)
 			gsm_response(gsm, address, DM|PF);
 		else {
-- 
2.34.1

