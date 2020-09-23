Return-Path: <SRS0=vWxX=DA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41603C4363D
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 15:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFF3421D43
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 15:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uarIndtO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgIWPPr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Sep 2020 11:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgIWPPq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Sep 2020 11:15:46 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACB1C0613D1;
        Wed, 23 Sep 2020 08:15:45 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b12so124951edz.11;
        Wed, 23 Sep 2020 08:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mtonHGZ+7G0TCtocR3cDEdUy7rlLWy99G94Oc1h+/Kc=;
        b=uarIndtO3cy8fOuphYyW2u3iUhAPjMDcl3HgwJcaFKLUOF6TV+8v95C39Yck8hHaMO
         oFkQmHGaPDivp8fVnEQgoUETwQC5u6TZpnGMUQkSomnhqepOVWAA1QJC4aoW/vEGISdV
         hu0pePmNKRjefmw0343pn1s3heL5OQ2H/oz69AAAbYmsCtTNaVqLeuRsAuKDBSWpoo0C
         sFcQ2CpyENGWSuzjrJPlZxfLVS+chWQwL9GGfQ0QlXpTPMQ/cZpv33I+PdUNY8M8wB+O
         ncWrJIm9vWAot8MCaU0ErzTFcyZc8uMyJ/bRRliZG9pGHiXIvQJ98Q0BY2syNxyEiFVV
         aJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mtonHGZ+7G0TCtocR3cDEdUy7rlLWy99G94Oc1h+/Kc=;
        b=NoJASkb4Z3zh64aCINunl83V9q6qk9JPEV1dbap8cT6k+kKzEXCMh328bQVyj4O1dD
         sFdZwVrzLCPXxCEpVfwvCiIusmtGkh/a+Mwh29z/+YZL166DCuWANkxNSrxyiVfbDkcL
         wOZny/qn+58kP996nEKLIBZSnS0c+4chBo0+UpnejRJn3R9OhNRBHXaIvxd9hR8uLvOp
         CYd+b6W7/D99SyuLHYtHpq4Pl6XrHOf4BeaDot5D3ED4Z0zj7dPgw489DmQGappJrE7q
         +MgFx5pkA216Z6QncGakmSMhCHlpaeboTH1FJ8nFX7Nk+ZfJCDbxYZA/EFjhLsoWlyZ3
         qL7A==
X-Gm-Message-State: AOAM530j2J9feAUHMHwXik3fkfhDFocjxsHdxy8E18NyNWZvz48nxbIA
        OzH2BADg1xl5MkVU0weMHI+WUwO/X40=
X-Google-Smtp-Source: ABdhPJztldjK/vkaEkLmHD51MB+WP9WSEW0dhDR1nA/rUH/3DxF3r7sq+u0fzI6JqLpq4n7hKtMB1A==
X-Received: by 2002:a05:6402:c15:: with SMTP id co21mr9867646edb.268.1600874143021;
        Wed, 23 Sep 2020 08:15:43 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a9df.dip0.t-ipconnect.de. [217.229.169.223])
        by smtp.gmail.com with ESMTPSA id ch29sm160707edb.74.2020.09.23.08.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:15:42 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Subject: [RFC PATCH 4/9] surface_aggregator: Add trace points
Date:   Wed, 23 Sep 2020 17:15:06 +0200
Message-Id: <20200923151511.3842150-5-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923151511.3842150-1-luzmaximilian@gmail.com>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Add trace points to the Surface Aggregator subsystem core. These trace
points can be used to track packets, requests, and allocations. They are
further intended for debugging and testing/validation, specifically in
combination with the error injection capabilities introduced in the
subsequent commit.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/misc/surface_aggregator/Makefile      |   3 +
 drivers/misc/surface_aggregator/controller.c  |   5 +
 drivers/misc/surface_aggregator/core.c        |   3 +
 .../surface_aggregator/ssh_packet_layer.c     |  21 +
 .../surface_aggregator/ssh_request_layer.c    |  18 +
 drivers/misc/surface_aggregator/trace.h       | 612 ++++++++++++++++++
 6 files changed, 662 insertions(+)
 create mode 100644 drivers/misc/surface_aggregator/trace.h

diff --git a/drivers/misc/surface_aggregator/Makefile b/drivers/misc/surface_aggregator/Makefile
index c92230746c7c..92718c7956a0 100644
--- a/drivers/misc/surface_aggregator/Makefile
+++ b/drivers/misc/surface_aggregator/Makefile
@@ -1,5 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+# For include/trace/define_trace.h to include trace.h
+CFLAGS_core.o = -I$(src)
+
 obj-$(CONFIG_SURFACE_AGGREGATOR) += surface_aggregator.o
 
 surface_aggregator-objs := core.o
diff --git a/drivers/misc/surface_aggregator/controller.c b/drivers/misc/surface_aggregator/controller.c
index 9780a410873e..d7483d3a2721 100644
--- a/drivers/misc/surface_aggregator/controller.c
+++ b/drivers/misc/surface_aggregator/controller.c
@@ -24,6 +24,8 @@
 #include "ssh_msgb.h"
 #include "ssh_request_layer.h"
 
+#include "trace.h"
+
 
 /* -- Safe counters. -------------------------------------------------------- */
 
@@ -585,6 +587,7 @@ static void __ssam_event_item_free_generic(struct ssam_event_item *item)
  */
 static void ssam_event_item_free(struct ssam_event_item *item)
 {
+	trace_ssam_event_item_free(item);
 	item->ops.free(item);
 }
 
@@ -620,6 +623,8 @@ static struct ssam_event_item *ssam_event_item_alloc(size_t len, gfp_t flags)
 	}
 
 	item->event.length = len;
+
+	trace_ssam_event_item_alloc(item, len);
 	return item;
 }
 
diff --git a/drivers/misc/surface_aggregator/core.c b/drivers/misc/surface_aggregator/core.c
index 5b79e57773fd..44bf83dd8fa9 100644
--- a/drivers/misc/surface_aggregator/core.c
+++ b/drivers/misc/surface_aggregator/core.c
@@ -22,6 +22,9 @@
 #include <linux/surface_aggregator/controller.h>
 #include "controller.h"
 
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
 
 /* -- Static controller reference. ------------------------------------------ */
 
diff --git a/drivers/misc/surface_aggregator/ssh_packet_layer.c b/drivers/misc/surface_aggregator/ssh_packet_layer.c
index 993aabfdfdae..29dc64dd27a8 100644
--- a/drivers/misc/surface_aggregator/ssh_packet_layer.c
+++ b/drivers/misc/surface_aggregator/ssh_packet_layer.c
@@ -19,6 +19,8 @@
 #include "ssh_packet_layer.h"
 #include "ssh_parser.h"
 
+#include "trace.h"
+
 
 /*
  * To simplify reasoning about the code below, we define a few concepts. The
@@ -209,6 +211,8 @@ static void __ssh_ptl_packet_release(struct kref *kref)
 {
 	struct ssh_packet *p = container_of(kref, struct ssh_packet, refcnt);
 
+	trace_ssam_packet_release(p);
+
 	ptl_dbg_cond(p->ptl, "ptl: releasing packet %p\n", p);
 	p->ops->release(p);
 }
@@ -337,6 +341,7 @@ static int ssh_ctrl_packet_alloc(struct ssh_packet **packet,
 	buffer->ptr = (u8 *)(*packet + 1);
 	buffer->len = SSH_MSG_LEN_CTRL;
 
+	trace_ssam_ctrl_packet_alloc(*packet, buffer->len);
 	return 0;
 }
 
@@ -346,6 +351,7 @@ static int ssh_ctrl_packet_alloc(struct ssh_packet **packet,
  */
 static void ssh_ctrl_packet_free(struct ssh_packet *p)
 {
+	trace_ssam_ctrl_packet_free(p);
 	kmem_cache_free(ssh_ctrl_packet_cache, p);
 }
 
@@ -550,6 +556,7 @@ static void __ssh_ptl_complete(struct ssh_packet *p, int status)
 {
 	struct ssh_ptl *ptl = READ_ONCE(p->ptl);
 
+	trace_ssam_packet_complete(p, status);
 	ptl_dbg_cond(ptl, "ptl: completing packet %p (status: %d)\n", p, status);
 
 	if (p->ops->complete)
@@ -968,6 +975,8 @@ int ssh_ptl_submit(struct ssh_ptl *ptl, struct ssh_packet *p)
 	struct ssh_ptl *ptl_old;
 	int status;
 
+	trace_ssam_packet_submit(p);
+
 	// validate packet fields
 	if (test_bit(SSH_PACKET_TY_FLUSH_BIT, &p->state)) {
 		if (p->data.ptr || test_bit(SSH_PACKET_TY_SEQUENCED_BIT, &p->state))
@@ -1002,6 +1011,8 @@ static int __ssh_ptl_resubmit(struct ssh_packet *packet)
 {
 	int status;
 
+	trace_ssam_packet_resubmit(packet);
+
 	spin_lock(&packet->ptl->queue.lock);
 
 	status = __ssh_ptl_queue_push(packet);
@@ -1094,6 +1105,8 @@ void ssh_ptl_cancel(struct ssh_packet *p)
 	if (test_and_set_bit(SSH_PACKET_SF_CANCELED_BIT, &p->state))
 		return;
 
+	trace_ssam_packet_cancel(p);
+
 	/*
 	 * Lock packet and commit with memory barrier. If this packet has
 	 * already been locked, it's going to be removed and completed by
@@ -1147,6 +1160,8 @@ static void ssh_ptl_timeout_reap(struct work_struct *work)
 	ktime_t next = KTIME_MAX;
 	bool resub = false;
 
+	trace_ssam_ptl_timeout_reap("pending", atomic_read(&ptl->pending.count));
+
 	/*
 	 * Mark reaper as "not pending". This is done before checking any
 	 * packets to avoid lost-update type problems.
@@ -1178,6 +1193,8 @@ static void ssh_ptl_timeout_reap(struct work_struct *work)
 		// check if we still have some tries left
 		try = ssh_packet_priority_get_try(READ_ONCE(p->priority));
 		if (likely(try < SSH_PTL_MAX_PACKET_TRIES)) {
+			trace_ssam_packet_timeout(p);
+
 			/*
 			 * Submission fails if the packet has been locked, is
 			 * already queued, or the layer is being shut down.
@@ -1195,6 +1212,8 @@ static void ssh_ptl_timeout_reap(struct work_struct *work)
 		if (test_and_set_bit(SSH_PACKET_SF_LOCKED_BIT, &p->state))
 			continue;
 
+		trace_ssam_packet_timeout(p);
+
 		/*
 		 * We have now marked the packet as locked. Thus it cannot be
 		 * added to the pending list again after we've removed it here.
@@ -1359,6 +1378,8 @@ static size_t ssh_ptl_rx_eval(struct ssh_ptl *ptl, struct ssam_span *source)
 	if (!frame)	// not enough data
 		return aligned.ptr - source->ptr;
 
+	trace_ssam_rx_frame_received(frame);
+
 	switch (frame->type) {
 	case SSH_FRAME_TYPE_ACK:
 		ssh_ptl_acknowledge(ptl, frame->seq);
diff --git a/drivers/misc/surface_aggregator/ssh_request_layer.c b/drivers/misc/surface_aggregator/ssh_request_layer.c
index f0f471f61b0a..e7358b9a2e4d 100644
--- a/drivers/misc/surface_aggregator/ssh_request_layer.c
+++ b/drivers/misc/surface_aggregator/ssh_request_layer.c
@@ -16,6 +16,8 @@
 #include "ssh_packet_layer.h"
 #include "ssh_request_layer.h"
 
+#include "trace.h"
+
 
 /*
  * SSH_RTL_REQUEST_TIMEOUT - Request timeout.
@@ -136,6 +138,8 @@ static void ssh_rtl_complete_with_status(struct ssh_request *rqst, int status)
 {
 	struct ssh_rtl *rtl = ssh_request_rtl(rqst);
 
+	trace_ssam_request_complete(rqst, status);
+
 	// rtl/ptl may not be set if we're cancelling before submitting
 	rtl_dbg_cond(rtl, "rtl: completing request (rqid: 0x%04x, status: %d)\n",
 		     ssh_request_get_rqid_safe(rqst), status);
@@ -149,6 +153,8 @@ static void ssh_rtl_complete_with_rsp(struct ssh_request *rqst,
 {
 	struct ssh_rtl *rtl = ssh_request_rtl(rqst);
 
+	trace_ssam_request_complete(rqst, 0);
+
 	rtl_dbg(rtl, "rtl: completing request with response (rqid: 0x%04x)\n",
 		ssh_request_get_rqid(rqst));
 
@@ -321,6 +327,8 @@ static void ssh_rtl_tx_work_fn(struct work_struct *work)
  */
 int ssh_rtl_submit(struct ssh_rtl *rtl, struct ssh_request *rqst)
 {
+	trace_ssam_request_submit(rqst);
+
 	/*
 	 * Ensure that requests expecting a response are sequenced. If this
 	 * invariant ever changes, see the comment in ssh_rtl_complete() on what
@@ -433,6 +441,8 @@ static void ssh_rtl_complete(struct ssh_rtl *rtl,
 	struct ssh_request *p, *n;
 	u16 rqid = get_unaligned_le16(&command->rqid);
 
+	trace_ssam_rx_response_received(command, command_data->len);
+
 	/*
 	 * Get request from pending based on request ID and mark it as response
 	 * received and locked.
@@ -683,6 +693,8 @@ bool ssh_rtl_cancel(struct ssh_request *rqst, bool pending)
 	if (test_and_set_bit(SSH_REQUEST_SF_CANCELED_BIT, &rqst->state))
 		return true;
 
+	trace_ssam_request_cancel(rqst);
+
 	if (pending)
 		canceled = ssh_rtl_cancel_pending(rqst);
 	else
@@ -772,6 +784,8 @@ static void ssh_rtl_timeout_reap(struct work_struct *work)
 	ktime_t timeout = rtl->rtx_timeout.timeout;
 	ktime_t next = KTIME_MAX;
 
+	trace_ssam_rtl_timeout_reap("pending", atomic_read(&rtl->pending.count));
+
 	/*
 	 * Mark reaper as "not pending". This is done before checking any
 	 * requests to avoid lost-update type problems.
@@ -820,6 +834,8 @@ static void ssh_rtl_timeout_reap(struct work_struct *work)
 
 	// cancel and complete the request
 	list_for_each_entry_safe(r, n, &claimed, node) {
+		trace_ssam_request_timeout(r);
+
 		/*
 		 * At this point we've removed the packet from pending. This
 		 * means that we've obtained the last (only) reference of the
@@ -845,6 +861,8 @@ static void ssh_rtl_timeout_reap(struct work_struct *work)
 static void ssh_rtl_rx_event(struct ssh_rtl *rtl, const struct ssh_command *cmd,
 			     const struct ssam_span *data)
 {
+	trace_ssam_rx_event_received(cmd, data->len);
+
 	rtl_dbg(rtl, "rtl: handling event (rqid: 0x%04x)\n",
 		get_unaligned_le16(&cmd->rqid));
 
diff --git a/drivers/misc/surface_aggregator/trace.h b/drivers/misc/surface_aggregator/trace.h
new file mode 100644
index 000000000000..eb2e3e1457de
--- /dev/null
+++ b/drivers/misc/surface_aggregator/trace.h
@@ -0,0 +1,612 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM surface_aggregator
+
+#if !defined(_SURFACE_AGGREGATOR_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _SURFACE_AGGREGATOR_TRACE_H
+
+#include <linux/surface_aggregator/serial_hub.h>
+
+#include <asm/unaligned.h>
+#include <linux/tracepoint.h>
+
+
+TRACE_DEFINE_ENUM(SSH_FRAME_TYPE_DATA_SEQ);
+TRACE_DEFINE_ENUM(SSH_FRAME_TYPE_DATA_NSQ);
+TRACE_DEFINE_ENUM(SSH_FRAME_TYPE_ACK);
+TRACE_DEFINE_ENUM(SSH_FRAME_TYPE_NAK);
+
+TRACE_DEFINE_ENUM(SSH_PACKET_SF_LOCKED_BIT);
+TRACE_DEFINE_ENUM(SSH_PACKET_SF_QUEUED_BIT);
+TRACE_DEFINE_ENUM(SSH_PACKET_SF_PENDING_BIT);
+TRACE_DEFINE_ENUM(SSH_PACKET_SF_TRANSMITTING_BIT);
+TRACE_DEFINE_ENUM(SSH_PACKET_SF_TRANSMITTED_BIT);
+TRACE_DEFINE_ENUM(SSH_PACKET_SF_ACKED_BIT);
+TRACE_DEFINE_ENUM(SSH_PACKET_SF_CANCELED_BIT);
+TRACE_DEFINE_ENUM(SSH_PACKET_SF_COMPLETED_BIT);
+
+TRACE_DEFINE_ENUM(SSH_PACKET_TY_FLUSH_BIT);
+TRACE_DEFINE_ENUM(SSH_PACKET_TY_SEQUENCED_BIT);
+TRACE_DEFINE_ENUM(SSH_PACKET_TY_BLOCKING_BIT);
+
+TRACE_DEFINE_ENUM(SSH_PACKET_FLAGS_SF_MASK);
+TRACE_DEFINE_ENUM(SSH_PACKET_FLAGS_TY_MASK);
+
+TRACE_DEFINE_ENUM(SSH_REQUEST_SF_LOCKED_BIT);
+TRACE_DEFINE_ENUM(SSH_REQUEST_SF_QUEUED_BIT);
+TRACE_DEFINE_ENUM(SSH_REQUEST_SF_PENDING_BIT);
+TRACE_DEFINE_ENUM(SSH_REQUEST_SF_TRANSMITTING_BIT);
+TRACE_DEFINE_ENUM(SSH_REQUEST_SF_TRANSMITTED_BIT);
+TRACE_DEFINE_ENUM(SSH_REQUEST_SF_RSPRCVD_BIT);
+TRACE_DEFINE_ENUM(SSH_REQUEST_SF_CANCELED_BIT);
+TRACE_DEFINE_ENUM(SSH_REQUEST_SF_COMPLETED_BIT);
+
+TRACE_DEFINE_ENUM(SSH_REQUEST_TY_FLUSH_BIT);
+TRACE_DEFINE_ENUM(SSH_REQUEST_TY_HAS_RESPONSE_BIT);
+
+TRACE_DEFINE_ENUM(SSH_REQUEST_FLAGS_SF_MASK);
+TRACE_DEFINE_ENUM(SSH_REQUEST_FLAGS_TY_MASK);
+
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_SAM);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_BAT);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_TMP);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_PMC);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_FAN);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_PoM);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_DBG);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_KBD);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_FWU);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_UNI);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_LPC);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_TCL);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_SFL);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_KIP);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_EXT);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_BLD);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_BAS);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_SEN);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_SRQ);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_MCU);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_HID);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_TCH);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_BKL);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_TAM);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_ACC);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_UFI);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_USC);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_PEN);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_VID);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_AUD);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_SMC);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_KPD);
+TRACE_DEFINE_ENUM(SSAM_SSH_TC_REG);
+
+
+#define SSAM_PTR_UID_LEN		9
+#define SSAM_U8_FIELD_NOT_APPLICABLE	((u16)-1)
+#define SSAM_SEQ_NOT_APPLICABLE		((u16)-1)
+#define SSAM_RQID_NOT_APPLICABLE	((u32)-1)
+#define SSAM_SSH_TC_NOT_APPLICABLE	0
+
+
+#ifndef _SURFACE_AGGREGATOR_TRACE_HELPERS
+#define _SURFACE_AGGREGATOR_TRACE_HELPERS
+
+/**
+ * ssam_trace_ptr_uid() - Convert the pointer to a non-pointer UID string.
+ * @ptr: The pointer to convert.
+ * @uid_str: A buffer of length SSAM_PTR_UID_LEN where the UID will be stored.
+ *
+ * Converts the given pointer into a UID string that is safe to be shared
+ * with userspace and logs, i.e. doesn't give away the real memory location.
+ */
+static inline void ssam_trace_ptr_uid(const void *ptr, char *uid_str)
+{
+	char buf[2 * sizeof(void *) + 1];
+
+	snprintf(buf, ARRAY_SIZE(buf), "%p", ptr);
+	memcpy(uid_str, &buf[ARRAY_SIZE(buf) - SSAM_PTR_UID_LEN],
+	       SSAM_PTR_UID_LEN);
+}
+
+/**
+ * ssam_trace_get_packet_seq() - Read the packet's sequence ID.
+ * @p: The packet.
+ *
+ * Return: Returns the packet's sequence ID (SEQ) field if present, or
+ * %SSAM_SEQ_NOT_APPLICABLE if not (e.g. flush packet).
+ */
+static inline u16 ssam_trace_get_packet_seq(const struct ssh_packet *p)
+{
+	if (!p->data.ptr || p->data.len < SSH_MESSAGE_LENGTH(0))
+		return SSAM_SEQ_NOT_APPLICABLE;
+
+	return p->data.ptr[SSH_MSGOFFSET_FRAME(seq)];
+}
+
+/**
+ * ssam_trace_get_request_id() - Read the packet's request ID.
+ * @p: The packet.
+ *
+ * Return: Returns the packet's request ID (RQID) field if the packet
+ * represents a request with command data, or %SSAM_RQID_NOT_APPLICABLE if not
+ * (e.g. flush request, control packet).
+ */
+static inline u32 ssam_trace_get_request_id(const struct ssh_packet *p)
+{
+	if (!p->data.ptr || p->data.len < SSH_COMMAND_MESSAGE_LENGTH(0))
+		return SSAM_RQID_NOT_APPLICABLE;
+
+	return get_unaligned_le16(&p->data.ptr[SSH_MSGOFFSET_COMMAND(rqid)]);
+}
+
+/**
+ * ssam_trace_get_request_tc() - Read the packet's request target category.
+ * @p: The packet.
+ *
+ * Return: Returns the packet's request target category (TC) field if the
+ * packet represents a request with command data, or %SSAM_TC_NOT_APPLICABLE
+ * if not (e.g. flush request, control packet).
+ */
+static inline u32 ssam_trace_get_request_tc(const struct ssh_packet *p)
+{
+	if (!p->data.ptr || p->data.len < SSH_COMMAND_MESSAGE_LENGTH(0))
+		return SSAM_SSH_TC_NOT_APPLICABLE;
+
+	return get_unaligned_le16(&p->data.ptr[SSH_MSGOFFSET_COMMAND(tc)]);
+}
+
+#endif /* _SURFACE_AGGREGATOR_TRACE_HELPERS */
+
+#define ssam_trace_get_command_field_u8(packet, field) \
+	((!packet || packet->data.len < SSH_COMMAND_MESSAGE_LENGTH(0)) \
+	 ? 0 : p->data.ptr[SSH_MSGOFFSET_COMMAND(field)])
+
+#define ssam_show_generic_u8_field(value)				\
+	__print_symbolic(value,						\
+		{ SSAM_U8_FIELD_NOT_APPLICABLE,		"N/A" }		\
+	)
+
+
+#define ssam_show_frame_type(ty)					\
+	__print_symbolic(ty,						\
+		{ SSH_FRAME_TYPE_DATA_SEQ,		"DSEQ" },	\
+		{ SSH_FRAME_TYPE_DATA_NSQ,		"DNSQ" },	\
+		{ SSH_FRAME_TYPE_ACK,			"ACK"  },	\
+		{ SSH_FRAME_TYPE_NAK,			"NAK"  }	\
+	)
+
+#define ssam_show_packet_type(type)					\
+	__print_flags(flags & SSH_PACKET_FLAGS_TY_MASK, "",		\
+		{ BIT(SSH_PACKET_TY_FLUSH_BIT),		"F" },		\
+		{ BIT(SSH_PACKET_TY_SEQUENCED_BIT),	"S" },		\
+		{ BIT(SSH_PACKET_TY_BLOCKING_BIT),	"B" }		\
+	)
+
+#define ssam_show_packet_state(state)					\
+	__print_flags(flags & SSH_PACKET_FLAGS_SF_MASK, "",		\
+		{ BIT(SSH_PACKET_SF_LOCKED_BIT),	"L" },		\
+		{ BIT(SSH_PACKET_SF_QUEUED_BIT),	"Q" },		\
+		{ BIT(SSH_PACKET_SF_PENDING_BIT),	"P" },		\
+		{ BIT(SSH_PACKET_SF_TRANSMITTING_BIT),	"S" },		\
+		{ BIT(SSH_PACKET_SF_TRANSMITTED_BIT),	"T" },		\
+		{ BIT(SSH_PACKET_SF_ACKED_BIT),		"A" },		\
+		{ BIT(SSH_PACKET_SF_CANCELED_BIT),	"C" },		\
+		{ BIT(SSH_PACKET_SF_COMPLETED_BIT),	"F" }		\
+	)
+
+#define ssam_show_packet_seq(seq)					\
+	__print_symbolic(seq,						\
+		{ SSAM_SEQ_NOT_APPLICABLE,		"N/A" }		\
+	)
+
+
+#define ssam_show_request_type(flags)					\
+	__print_flags(flags & SSH_REQUEST_FLAGS_TY_MASK, "",		\
+		{ BIT(SSH_REQUEST_TY_FLUSH_BIT),	"F" },		\
+		{ BIT(SSH_REQUEST_TY_HAS_RESPONSE_BIT),	"R" }		\
+	)
+
+#define ssam_show_request_state(flags)					\
+	__print_flags(flags & SSH_REQUEST_FLAGS_SF_MASK, "",		\
+		{ BIT(SSH_REQUEST_SF_LOCKED_BIT),	"L" },		\
+		{ BIT(SSH_REQUEST_SF_QUEUED_BIT),	"Q" },		\
+		{ BIT(SSH_REQUEST_SF_PENDING_BIT),	"P" },		\
+		{ BIT(SSH_REQUEST_SF_TRANSMITTING_BIT),	"S" },		\
+		{ BIT(SSH_REQUEST_SF_TRANSMITTED_BIT),	"T" },		\
+		{ BIT(SSH_REQUEST_SF_RSPRCVD_BIT),	"A" },		\
+		{ BIT(SSH_REQUEST_SF_CANCELED_BIT),	"C" },		\
+		{ BIT(SSH_REQUEST_SF_COMPLETED_BIT),	"F" }		\
+	)
+
+#define ssam_show_request_id(rqid)					\
+	__print_symbolic(rqid,						\
+		{ SSAM_RQID_NOT_APPLICABLE,		"N/A" }		\
+	)
+
+#define ssam_show_ssh_tc(rqid)						\
+	__print_symbolic(rqid,						\
+		{ SSAM_SSH_TC_NOT_APPLICABLE,		"N/A" },	\
+		{ SSAM_SSH_TC_SAM,			"SAM" },	\
+		{ SSAM_SSH_TC_BAT,			"BAT" },	\
+		{ SSAM_SSH_TC_TMP,			"TMP" },	\
+		{ SSAM_SSH_TC_PMC,			"PMC" },	\
+		{ SSAM_SSH_TC_FAN,			"FAN" },	\
+		{ SSAM_SSH_TC_PoM,			"PoM" },	\
+		{ SSAM_SSH_TC_DBG,			"DBG" },	\
+		{ SSAM_SSH_TC_KBD,			"KBD" },	\
+		{ SSAM_SSH_TC_FWU,			"FWU" },	\
+		{ SSAM_SSH_TC_UNI,			"UNI" },	\
+		{ SSAM_SSH_TC_LPC,			"LPC" },	\
+		{ SSAM_SSH_TC_TCL,			"TCL" },	\
+		{ SSAM_SSH_TC_SFL,			"SFL" },	\
+		{ SSAM_SSH_TC_KIP,			"KIP" },	\
+		{ SSAM_SSH_TC_EXT,			"EXT" },	\
+		{ SSAM_SSH_TC_BLD,			"BLD" },	\
+		{ SSAM_SSH_TC_BAS,			"BAS" },	\
+		{ SSAM_SSH_TC_SEN,			"SEN" },	\
+		{ SSAM_SSH_TC_SRQ,			"SRQ" },	\
+		{ SSAM_SSH_TC_MCU,			"MCU" },	\
+		{ SSAM_SSH_TC_HID,			"HID" },	\
+		{ SSAM_SSH_TC_TCH,			"TCH" },	\
+		{ SSAM_SSH_TC_BKL,			"BKL" },	\
+		{ SSAM_SSH_TC_TAM,			"TAM" },	\
+		{ SSAM_SSH_TC_ACC,			"ACC" },	\
+		{ SSAM_SSH_TC_UFI,			"UFI" },	\
+		{ SSAM_SSH_TC_USC,			"USC" },	\
+		{ SSAM_SSH_TC_PEN,			"PEN" },	\
+		{ SSAM_SSH_TC_VID,			"VID" },	\
+		{ SSAM_SSH_TC_AUD,			"AUD" },	\
+		{ SSAM_SSH_TC_SMC,			"SMC" },	\
+		{ SSAM_SSH_TC_KPD,			"KPD" },	\
+		{ SSAM_SSH_TC_REG,			"REG" }		\
+	)
+
+
+DECLARE_EVENT_CLASS(ssam_frame_class,
+	TP_PROTO(const struct ssh_frame *frame),
+
+	TP_ARGS(frame),
+
+	TP_STRUCT__entry(
+		__field(u8, type)
+		__field(u8, seq)
+		__field(u16, len)
+	),
+
+	TP_fast_assign(
+		__entry->type = frame->type;
+		__entry->seq = frame->seq;
+		__entry->len = get_unaligned_le16(&frame->len);
+	),
+
+	TP_printk("ty=%s, seq=0x%02x, len=%u",
+		ssam_show_frame_type(__entry->type),
+		__entry->seq,
+		__entry->len
+	)
+);
+
+#define DEFINE_SSAM_FRAME_EVENT(name)				\
+	DEFINE_EVENT(ssam_frame_class, ssam_##name,		\
+		TP_PROTO(const struct ssh_frame *frame),	\
+		TP_ARGS(frame)					\
+	)
+
+
+DECLARE_EVENT_CLASS(ssam_command_class,
+	TP_PROTO(const struct ssh_command *cmd, u16 len),
+
+	TP_ARGS(cmd, len),
+
+	TP_STRUCT__entry(
+		__field(u16, rqid)
+		__field(u16, len)
+		__field(u8, tc)
+		__field(u8, cid)
+		__field(u8, iid)
+	),
+
+	TP_fast_assign(
+		__entry->rqid = get_unaligned_le16(&cmd->rqid);
+		__entry->tc = cmd->tc;
+		__entry->cid = cmd->cid;
+		__entry->iid = cmd->iid;
+		__entry->len = len;
+	),
+
+	TP_printk("rqid=0x%04x, tc=%s, cid=0x%02x, iid=0x%02x, len=%u",
+		__entry->rqid,
+		ssam_show_ssh_tc(__entry->tc),
+		__entry->cid,
+		__entry->iid,
+		__entry->len
+	)
+);
+
+#define DEFINE_SSAM_COMMAND_EVENT(name)					\
+	DEFINE_EVENT(ssam_command_class, ssam_##name,			\
+		TP_PROTO(const struct ssh_command *cmd, u16 len),	\
+		TP_ARGS(cmd, len)					\
+	)
+
+
+DECLARE_EVENT_CLASS(ssam_packet_class,
+	TP_PROTO(const struct ssh_packet *packet),
+
+	TP_ARGS(packet),
+
+	TP_STRUCT__entry(
+		__array(char, uid, SSAM_PTR_UID_LEN)
+		__field(u8, priority)
+		__field(u16, length)
+		__field(unsigned long, state)
+		__field(u16, seq)
+	),
+
+	TP_fast_assign(
+		ssam_trace_ptr_uid(packet, __entry->uid);
+		__entry->priority = READ_ONCE(packet->priority);
+		__entry->length = packet->data.len;
+		__entry->state = READ_ONCE(packet->state);
+		__entry->seq = ssam_trace_get_packet_seq(packet);
+	),
+
+	TP_printk("uid=%s, seq=%s, ty=%s, pri=0x%02x, len=%u, sta=%s",
+		__entry->uid,
+		ssam_show_packet_seq(__entry->seq),
+		ssam_show_packet_type(__entry->state),
+		__entry->priority,
+		__entry->length,
+		ssam_show_packet_state(__entry->state)
+	)
+);
+
+#define DEFINE_SSAM_PACKET_EVENT(name)				\
+	DEFINE_EVENT(ssam_packet_class, ssam_##name,		\
+		TP_PROTO(const struct ssh_packet *packet),	\
+		TP_ARGS(packet)					\
+	)
+
+
+DECLARE_EVENT_CLASS(ssam_packet_status_class,
+	TP_PROTO(const struct ssh_packet *packet, int status),
+
+	TP_ARGS(packet, status),
+
+	TP_STRUCT__entry(
+		__array(char, uid, SSAM_PTR_UID_LEN)
+		__field(u8, priority)
+		__field(u16, length)
+		__field(unsigned long, state)
+		__field(u16, seq)
+		__field(int, status)
+	),
+
+	TP_fast_assign(
+		ssam_trace_ptr_uid(packet, __entry->uid);
+		__entry->priority = READ_ONCE(packet->priority);
+		__entry->length = packet->data.len;
+		__entry->state = READ_ONCE(packet->state);
+		__entry->seq = ssam_trace_get_packet_seq(packet);
+		__entry->status = status;
+	),
+
+	TP_printk("uid=%s, seq=%s, ty=%s, pri=0x%02x, len=%u, sta=%s, status=%d",
+		__entry->uid,
+		ssam_show_packet_seq(__entry->seq),
+		ssam_show_packet_type(__entry->state),
+		__entry->priority,
+		__entry->length,
+		ssam_show_packet_state(__entry->state),
+		__entry->status
+	)
+);
+
+#define DEFINE_SSAM_PACKET_STATUS_EVENT(name)				\
+	DEFINE_EVENT(ssam_packet_status_class, ssam_##name,		\
+		TP_PROTO(const struct ssh_packet *packet, int status),	\
+		TP_ARGS(packet, status)					\
+	)
+
+
+DECLARE_EVENT_CLASS(ssam_request_class,
+	TP_PROTO(const struct ssh_request *request),
+
+	TP_ARGS(request),
+
+	TP_STRUCT__entry(
+		__array(char, uid, SSAM_PTR_UID_LEN)
+		__field(unsigned long, state)
+		__field(u32, rqid)
+		__field(u8, tc)
+		__field(u16, cid)
+		__field(u16, iid)
+	),
+
+	TP_fast_assign(
+		const struct ssh_packet *p = &request->packet;
+
+		// use packet for UID so we can match requests to packets
+		ssam_trace_ptr_uid(p, __entry->uid);
+		__entry->state = READ_ONCE(request->state);
+		__entry->rqid = ssam_trace_get_request_id(p);
+		__entry->tc = ssam_trace_get_request_tc(p);
+		__entry->cid = ssam_trace_get_command_field_u8(p, cid);
+		__entry->iid = ssam_trace_get_command_field_u8(p, iid);
+	),
+
+	TP_printk("uid=%s, rqid=%s, ty=%s, sta=%s, tc=%s, cid=%s, iid=%s",
+		__entry->uid,
+		ssam_show_request_id(__entry->rqid),
+		ssam_show_request_type(__entry->state),
+		ssam_show_request_state(__entry->state),
+		ssam_show_ssh_tc(__entry->tc),
+		ssam_show_generic_u8_field(__entry->cid),
+		ssam_show_generic_u8_field(__entry->iid)
+	)
+);
+
+#define DEFINE_SSAM_REQUEST_EVENT(name)				\
+	DEFINE_EVENT(ssam_request_class, ssam_##name,		\
+		TP_PROTO(const struct ssh_request *request),	\
+		TP_ARGS(request)				\
+	)
+
+
+DECLARE_EVENT_CLASS(ssam_request_status_class,
+	TP_PROTO(const struct ssh_request *request, int status),
+
+	TP_ARGS(request, status),
+
+	TP_STRUCT__entry(
+		__array(char, uid, SSAM_PTR_UID_LEN)
+		__field(unsigned long, state)
+		__field(u32, rqid)
+		__field(u8, tc)
+		__field(u16, cid)
+		__field(u16, iid)
+		__field(int, status)
+	),
+
+	TP_fast_assign(
+		const struct ssh_packet *p = &request->packet;
+
+		// use packet for UID so we can match requests to packets
+		ssam_trace_ptr_uid(p, __entry->uid);
+		__entry->state = READ_ONCE(request->state);
+		__entry->rqid = ssam_trace_get_request_id(p);
+		__entry->tc = ssam_trace_get_request_tc(p);
+		__entry->cid = ssam_trace_get_command_field_u8(p, cid);
+		__entry->iid = ssam_trace_get_command_field_u8(p, iid);
+		__entry->status = status;
+	),
+
+	TP_printk("uid=%s, rqid=%s, ty=%s, sta=%s, tc=%s, cid=%s, iid=%s, status=%d",
+		__entry->uid,
+		ssam_show_request_id(__entry->rqid),
+		ssam_show_request_type(__entry->state),
+		ssam_show_request_state(__entry->state),
+		ssam_show_ssh_tc(__entry->tc),
+		ssam_show_generic_u8_field(__entry->cid),
+		ssam_show_generic_u8_field(__entry->iid),
+		__entry->status
+	)
+);
+
+#define DEFINE_SSAM_REQUEST_STATUS_EVENT(name)				\
+	DEFINE_EVENT(ssam_request_status_class, ssam_##name,		\
+		TP_PROTO(const struct ssh_request *request, int status),\
+		TP_ARGS(request, status)				\
+	)
+
+
+DECLARE_EVENT_CLASS(ssam_alloc_class,
+	TP_PROTO(void *ptr, size_t len),
+
+	TP_ARGS(ptr, len),
+
+	TP_STRUCT__entry(
+		__array(char, uid, SSAM_PTR_UID_LEN)
+		__field(size_t, len)
+	),
+
+	TP_fast_assign(
+		ssam_trace_ptr_uid(ptr, __entry->uid);
+		__entry->len = len;
+	),
+
+	TP_printk("uid=%s, len=%zu", __entry->uid, __entry->len)
+);
+
+#define DEFINE_SSAM_ALLOC_EVENT(name)					\
+	DEFINE_EVENT(ssam_alloc_class, ssam_##name,			\
+		TP_PROTO(void *ptr, size_t len),			\
+		TP_ARGS(ptr, len)					\
+	)
+
+
+DECLARE_EVENT_CLASS(ssam_free_class,
+	TP_PROTO(void *ptr),
+
+	TP_ARGS(ptr),
+
+	TP_STRUCT__entry(
+		__array(char, uid, SSAM_PTR_UID_LEN)
+		__field(size_t, len)
+	),
+
+	TP_fast_assign(
+		ssam_trace_ptr_uid(ptr, __entry->uid);
+	),
+
+	TP_printk("uid=%s", __entry->uid)
+);
+
+#define DEFINE_SSAM_FREE_EVENT(name)					\
+	DEFINE_EVENT(ssam_free_class, ssam_##name,			\
+		TP_PROTO(void *ptr),					\
+		TP_ARGS(ptr)						\
+	)
+
+
+DECLARE_EVENT_CLASS(ssam_generic_uint_class,
+	TP_PROTO(const char *property, unsigned int value),
+
+	TP_ARGS(property, value),
+
+	TP_STRUCT__entry(
+		__string(property, property)
+		__field(unsigned int, value)
+	),
+
+	TP_fast_assign(
+		__assign_str(property, property);
+		__entry->value = value;
+	),
+
+	TP_printk("%s=%u", __get_str(property), __entry->value)
+);
+
+#define DEFINE_SSAM_GENERIC_UINT_EVENT(name)				\
+	DEFINE_EVENT(ssam_generic_uint_class, ssam_##name,		\
+		TP_PROTO(const char *property, unsigned int value),	\
+		TP_ARGS(property, value)				\
+	)
+
+
+DEFINE_SSAM_FRAME_EVENT(rx_frame_received);
+DEFINE_SSAM_COMMAND_EVENT(rx_response_received);
+DEFINE_SSAM_COMMAND_EVENT(rx_event_received);
+
+DEFINE_SSAM_PACKET_EVENT(packet_release);
+DEFINE_SSAM_PACKET_EVENT(packet_submit);
+DEFINE_SSAM_PACKET_EVENT(packet_resubmit);
+DEFINE_SSAM_PACKET_EVENT(packet_timeout);
+DEFINE_SSAM_PACKET_EVENT(packet_cancel);
+DEFINE_SSAM_PACKET_STATUS_EVENT(packet_complete);
+DEFINE_SSAM_GENERIC_UINT_EVENT(ptl_timeout_reap);
+
+DEFINE_SSAM_REQUEST_EVENT(request_submit);
+DEFINE_SSAM_REQUEST_EVENT(request_timeout);
+DEFINE_SSAM_REQUEST_EVENT(request_cancel);
+DEFINE_SSAM_REQUEST_STATUS_EVENT(request_complete);
+DEFINE_SSAM_GENERIC_UINT_EVENT(rtl_timeout_reap);
+
+DEFINE_SSAM_ALLOC_EVENT(ctrl_packet_alloc);
+DEFINE_SSAM_FREE_EVENT(ctrl_packet_free);
+
+DEFINE_SSAM_ALLOC_EVENT(event_item_alloc);
+DEFINE_SSAM_FREE_EVENT(event_item_free);
+
+#endif /* _SURFACE_AGGREGATOR_TRACE_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE trace
+
+#include <trace/define_trace.h>
-- 
2.28.0

