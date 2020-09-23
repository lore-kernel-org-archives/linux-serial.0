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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137FCC4363D
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 15:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B875F20708
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 15:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vcOfx34X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgIWPP6 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Sep 2020 11:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgIWPPs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Sep 2020 11:15:48 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF59C0613CE;
        Wed, 23 Sep 2020 08:15:47 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l17so118482edq.12;
        Wed, 23 Sep 2020 08:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r+SsNU5lF09OCAuEmukoBpTa6NpeFuSEbj4KIsX6bYU=;
        b=vcOfx34XiMlkhlYa/gYIq7mT5K3K0KgQsx+IV328fDMsSiTBLldLcmY655VuBhOzJM
         3UTzKZifIMJLwXymcOyR6epdJrRoI1v4ihTLh9MOJwaP9NKadaEwjA2M37ozVIsGO5MN
         cIgHgEff4L36mKfHfXEnzYbHNjJoSiOSYSgkUi22xq3lEPVcZpESFzgX5DtPaj9u9x8N
         lpBmEdetsQ8F2Nz/ysLMBckUEgNKrjUzfFt5Y7iik5GJkeW8M31znaYXzZne/eA4EbxK
         B3KWbAQ55Abbp0+jcpylvRqQ/79P90hRr4ztt+aj4jkky9E6tHVCw5XZ4FbihOYs6rlw
         92ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r+SsNU5lF09OCAuEmukoBpTa6NpeFuSEbj4KIsX6bYU=;
        b=eG0C4a4CgHrcK4i8Im75rTJH00msKzBMj0nXFUjWgMlRqRzhJPzSR8LXX9+HF+UYMd
         FvaZmQdajOIrm1b1xYBAY4ws2UFeJodgKMyBmzRv3xEu02BFPcyydDAE6XsgP3Ot+KOO
         3M1GpUSnCr0D35OpyxsyGJJCmHb1uWIxcc5xdKxWk5qqwCovJpqEdfT7zOqa5SQmvJKs
         tN1PezGTAUs3Xcb8IB/QhUID7RIqAJ0+Ve3tpJQ05vy01W3gd68BDwhCWvDXuHzsgcbo
         e/CzyAGxPfFETQ6/Ss/ZN85ns0xxPKwLv65jSB/mZ6alEa2wjW6VMAz2BTNrmOehvmRN
         N+8w==
X-Gm-Message-State: AOAM530yCMWQEyDjQM65YS3eG6s7RNUNPst6JwEaiDdOoLxt5mcFW7rW
        ckQf3GhHuoIgCQ2szh54yKy4076gxNw=
X-Google-Smtp-Source: ABdhPJy8/QbBImAJJJ4UgWFo8kgPfXOSsPtKBjmFSpFnYh9V1EPyEe1Ct3AIifKpi3nC19CfzLERVQ==
X-Received: by 2002:a50:ee15:: with SMTP id g21mr10391733eds.47.1600874145949;
        Wed, 23 Sep 2020 08:15:45 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a9df.dip0.t-ipconnect.de. [217.229.169.223])
        by smtp.gmail.com with ESMTPSA id ch29sm160707edb.74.2020.09.23.08.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:15:45 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Subject: [RFC PATCH 5/9] surface_aggregator: Add error injection capabilities
Date:   Wed, 23 Sep 2020 17:15:07 +0200
Message-Id: <20200923151511.3842150-6-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923151511.3842150-1-luzmaximilian@gmail.com>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This commit adds error injection hooks to the Surface Serial Hub
communication protocol implementation, to:

 - simulate simple serial transmission errors,

 - drop packets, requests, and responses, simulating communication
   failures and potentially trigger retransmission timeouts, as well as

 - inject invalid data into submitted and received packets.

Together with the trace points introduced in the previous commit, these
facilities are intended to aid in testing, validation, and debugging of
the Surface Aggregator communication layer.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/misc/surface_aggregator/Kconfig       |  15 +
 .../surface_aggregator/ssh_packet_layer.c     | 302 +++++++++++++++++-
 .../surface_aggregator/ssh_request_layer.c    |  36 +++
 drivers/misc/surface_aggregator/trace.h       |   9 +
 4 files changed, 360 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/surface_aggregator/Kconfig b/drivers/misc/surface_aggregator/Kconfig
index a5a98c9e17a6..36a47c9e129d 100644
--- a/drivers/misc/surface_aggregator/Kconfig
+++ b/drivers/misc/surface_aggregator/Kconfig
@@ -34,3 +34,18 @@ menuconfig SURFACE_AGGREGATOR
 	  devices using SAM-over-SSH are supported, whereas devices using
 	  SAM-over-HID, which is used on the 4th generation, are currently not
 	  supported.
+
+config SURFACE_AGGREGATOR_ERROR_INJECTION
+	bool "Surface System Aggregator Module Error Injection Capabilities"
+	depends on SURFACE_AGGREGATOR
+	depends on FUNCTION_ERROR_INJECTION
+	default n
+	help
+	  Provides error-injection capabilities for the Surface System
+	  Aggregator Module subsystem and Surface Serial Hub driver.
+
+	  Specifically, exports error injection hooks to be used with the
+	  kernel's function error injection capabilities to simulate underlying
+	  transport and communication problems, such as invalid data sent to or
+	  received from the EC, dropped data, and communication timeouts.
+	  Intended for development and debugging.
diff --git a/drivers/misc/surface_aggregator/ssh_packet_layer.c b/drivers/misc/surface_aggregator/ssh_packet_layer.c
index 29dc64dd27a8..4ce8e493cfa3 100644
--- a/drivers/misc/surface_aggregator/ssh_packet_layer.c
+++ b/drivers/misc/surface_aggregator/ssh_packet_layer.c
@@ -2,6 +2,7 @@
 
 #include <asm/unaligned.h>
 #include <linux/atomic.h>
+#include <linux/error-injection.h>
 #include <linux/jiffies.h>
 #include <linux/kfifo.h>
 #include <linux/kref.h>
@@ -207,6 +208,288 @@
 #define SSH_PTL_RX_FIFO_LEN			4096
 
 
+#ifdef CONFIG_SURFACE_AGGREGATOR_ERROR_INJECTION
+
+/**
+ * ssh_ptl_should_drop_ack_packet() - Error injection hook to drop ACK packets.
+ *
+ * Useful to test detection and handling of automated re-transmits by the EC.
+ * Specifically of packets that the EC consideres not-ACKed but the driver
+ * already consideres ACKed (due to dropped ACK). In this case, the EC
+ * re-transmits the packet-to-be-ACKed and the driver should detect it as
+ * duplicate/already handled. Note that the driver should still send an ACK
+ * for the re-transmitted packet.
+ */
+static noinline bool ssh_ptl_should_drop_ack_packet(void)
+{
+	return false;
+}
+ALLOW_ERROR_INJECTION(ssh_ptl_should_drop_ack_packet, TRUE);
+
+/**
+ * ssh_ptl_should_drop_nak_packet() - Error injection hook to drop NAK packets.
+ *
+ * Useful to test/force automated (timeout-based) re-transmit by the EC.
+ * Specifically, packets that have not reached the driver completely/with valid
+ * checksums. Only useful in combination with receival of (injected) bad data.
+ */
+static noinline bool ssh_ptl_should_drop_nak_packet(void)
+{
+	return false;
+}
+ALLOW_ERROR_INJECTION(ssh_ptl_should_drop_nak_packet, TRUE);
+
+/**
+ * ssh_ptl_should_drop_dsq_packet() - Error injection hook to drop sequenced
+ * data packet.
+ *
+ * Useful to test re-transmit timeout of the driver. If the data packet has not
+ * been ACKed after a certain time, the driver should re-transmit the packet up
+ * to limited number of times defined in SSH_PTL_MAX_PACKET_TRIES.
+ */
+static noinline bool ssh_ptl_should_drop_dsq_packet(void)
+{
+	return false;
+}
+ALLOW_ERROR_INJECTION(ssh_ptl_should_drop_dsq_packet, TRUE);
+
+/**
+ * ssh_ptl_should_fail_write() - Error injection hook to make
+ * serdev_device_write() fail.
+ *
+ * Hook to simulate errors in serdev_device_write when transmitting packets.
+ */
+static noinline int ssh_ptl_should_fail_write(void)
+{
+	return 0;
+}
+ALLOW_ERROR_INJECTION(ssh_ptl_should_fail_write, ERRNO);
+
+/**
+ * ssh_ptl_should_corrupt_tx_data() - Error injection hook to simualte invalid
+ * data being sent to the EC.
+ *
+ * Hook to simulate corrupt/invalid data being sent from host (driver) to EC.
+ * Causes the packet data to be actively corrupted by overwriting it with
+ * pre-defined values, such that it becomes invalid, causing the EC to respond
+ * with a NAK packet. Useful to test handling of NAK packets received by the
+ * driver.
+ */
+static noinline bool ssh_ptl_should_corrupt_tx_data(void)
+{
+	return false;
+}
+ALLOW_ERROR_INJECTION(ssh_ptl_should_corrupt_tx_data, TRUE);
+
+/**
+ * ssh_ptl_should_corrupt_rx_syn() - Error injection hook to simulate invalid
+ * data being sent by the EC.
+ *
+ * Hook to simulate invalid SYN bytes, i.e. an invalid start of messages and
+ * test handling thereof in the driver.
+ */
+static noinline bool ssh_ptl_should_corrupt_rx_syn(void)
+{
+	return false;
+}
+ALLOW_ERROR_INJECTION(ssh_ptl_should_corrupt_rx_syn, TRUE);
+
+/**
+ * ssh_ptl_should_corrupt_rx_data() - Error injection hook to simulate invalid
+ * data being sent by the EC.
+ *
+ * Hook to simulate invalid data/checksum of the message frame and test handling
+ * thereof in the driver.
+ */
+static noinline bool ssh_ptl_should_corrupt_rx_data(void)
+{
+	return false;
+}
+ALLOW_ERROR_INJECTION(ssh_ptl_should_corrupt_rx_data, TRUE);
+
+
+static bool __ssh_ptl_should_drop_ack_packet(struct ssh_packet *packet)
+{
+	if (likely(!ssh_ptl_should_drop_ack_packet()))
+		return false;
+
+	trace_ssam_ei_tx_drop_ack_packet(packet);
+	ptl_info(packet->ptl, "packet error injection: dropping ACK packet %p\n",
+		 packet);
+
+	return true;
+}
+
+static bool __ssh_ptl_should_drop_nak_packet(struct ssh_packet *packet)
+{
+	if (likely(!ssh_ptl_should_drop_nak_packet()))
+		return false;
+
+	trace_ssam_ei_tx_drop_nak_packet(packet);
+	ptl_info(packet->ptl, "packet error injection: dropping NAK packet %p\n",
+		 packet);
+
+	return true;
+}
+
+static bool __ssh_ptl_should_drop_dsq_packet(struct ssh_packet *packet)
+{
+	if (likely(!ssh_ptl_should_drop_dsq_packet()))
+		return false;
+
+	trace_ssam_ei_tx_drop_dsq_packet(packet);
+	ptl_info(packet->ptl,
+		"packet error injection: dropping sequenced data packet %p\n",
+		 packet);
+
+	return true;
+}
+
+static bool ssh_ptl_should_drop_packet(struct ssh_packet *packet)
+{
+	// ignore packets that don't carry any data (i.e. flush)
+	if (!packet->data.ptr || !packet->data.len)
+		return false;
+
+	switch (packet->data.ptr[SSH_MSGOFFSET_FRAME(type)]) {
+	case SSH_FRAME_TYPE_ACK:
+		return __ssh_ptl_should_drop_ack_packet(packet);
+
+	case SSH_FRAME_TYPE_NAK:
+		return __ssh_ptl_should_drop_nak_packet(packet);
+
+	case SSH_FRAME_TYPE_DATA_SEQ:
+		return __ssh_ptl_should_drop_dsq_packet(packet);
+
+	default:
+		return false;
+	}
+}
+
+static int ssh_ptl_write_buf(struct ssh_ptl *ptl, struct ssh_packet *packet,
+			     const unsigned char *buf, size_t count)
+{
+	int status;
+
+	status = ssh_ptl_should_fail_write();
+	if (unlikely(status)) {
+		trace_ssam_ei_tx_fail_write(packet, status);
+		ptl_info(packet->ptl,
+			 "packet error injection: simulating transmit error %d,"
+			 " packet %p\n", status, packet);
+
+		return status;
+	}
+
+	return serdev_device_write_buf(ptl->serdev, buf, count);
+}
+
+static void ssh_ptl_tx_inject_invalid_data(struct ssh_packet *packet)
+{
+	// ignore packets that don't carry any data (i.e. flush)
+	if (!packet->data.ptr || !packet->data.len)
+		return;
+
+	// only allow sequenced data packets to be modified
+	if (packet->data.ptr[SSH_MSGOFFSET_FRAME(type)] != SSH_FRAME_TYPE_DATA_SEQ)
+		return;
+
+	if (likely(!ssh_ptl_should_corrupt_tx_data()))
+		return;
+
+	trace_ssam_ei_tx_corrupt_data(packet);
+	ptl_info(packet->ptl,
+		 "packet error injection: simulating invalid transmit data on packet %p\n",
+		 packet);
+
+	/*
+	 * NB: The value 0xb3 has been chosen more or less randomly so that it
+	 * doesn't have any (major) overlap with the SYN bytes (aa 55) and is
+	 * non-trivial (i.e. non-zero, non-0xff).
+	 */
+	memset(packet->data.ptr, 0xb3, packet->data.len);
+}
+
+static void ssh_ptl_rx_inject_invalid_syn(struct ssh_ptl *ptl,
+					  struct ssam_span *data)
+{
+	struct ssam_span frame;
+
+	// check if there actually is something to corrupt
+	if (!sshp_find_syn(data, &frame))
+		return;
+
+	if (likely(!ssh_ptl_should_corrupt_rx_syn()))
+		return;
+
+	trace_ssam_ei_rx_corrupt_syn("data_length", data->len);
+
+	data->ptr[1] = 0xb3;	// set second byte of SYN to "random" value
+}
+
+static void ssh_ptl_rx_inject_invalid_data(struct ssh_ptl *ptl,
+					   struct ssam_span *frame)
+{
+	size_t payload_len, message_len;
+	struct ssh_frame *sshf;
+
+	// ignore incomplete messages, will get handled once it's complete
+	if (frame->len < SSH_MESSAGE_LENGTH(0))
+		return;
+
+	// ignore incomplete messages, part 2
+	payload_len = get_unaligned_le16(&frame->ptr[SSH_MSGOFFSET_FRAME(len)]);
+	message_len = SSH_MESSAGE_LENGTH(payload_len);
+	if (frame->len < message_len)
+		return;
+
+	if (likely(!ssh_ptl_should_corrupt_rx_data()))
+		return;
+
+	sshf = (struct ssh_frame *)&frame->ptr[SSH_MSGOFFSET_FRAME(type)];
+	trace_ssam_ei_rx_corrupt_data(sshf);
+
+	/*
+	 * Flip bits in first byte of payload checksum. This is basically
+	 * equivalent to a payload/frame data error without us having to worry
+	 * about (the, arguably pretty small, probability of) accidental
+	 * checksum collisions.
+	 */
+	frame->ptr[frame->len - 2] = ~frame->ptr[frame->len - 2];
+}
+
+#else /* CONFIG_SURFACE_AGGREGATOR_ERROR_INJECTION */
+
+static inline bool ssh_ptl_should_drop_packet(struct ssh_packet *packet)
+{
+	return false;
+}
+
+static inline int ssh_ptl_write_buf(struct ssh_ptl *ptl,
+				    struct ssh_packet *packet,
+				    const unsigned char *buf,
+				    size_t count)
+{
+	return serdev_device_write_buf(ptl->serdev, buf, count);
+}
+
+static inline void ssh_ptl_tx_inject_invalid_data(struct ssh_packet *packet)
+{
+}
+
+static inline void ssh_ptl_rx_inject_invalid_syn(struct ssh_ptl *ptl,
+						 struct ssam_span *data)
+{
+}
+
+static inline void ssh_ptl_rx_inject_invalid_data(struct ssh_ptl *ptl,
+						  struct ssam_span *frame)
+{
+}
+
+#endif /* CONFIG_SURFACE_AGGREGATOR_ERROR_INJECTION */
+
+
 static void __ssh_ptl_packet_release(struct kref *kref)
 {
 	struct ssh_packet *p = container_of(kref, struct ssh_packet, refcnt);
@@ -736,6 +1019,7 @@ static int ssh_ptl_tx_threadfn(void *data)
 
 	while (!kthread_should_stop()) {
 		unsigned char *buf;
+		bool drop = false;
 		size_t len = 0;
 		int status = 0;
 
@@ -751,8 +1035,16 @@ static int ssh_ptl_tx_threadfn(void *data)
 			}
 		}
 
+		// error injection: drop packet to simulate transmission problem
+		if (ptl->tx.offset == 0)
+			drop = ssh_ptl_should_drop_packet(ptl->tx.packet);
+
+		// error injection: simulate invalid packet data
+		if (ptl->tx.offset == 0 && !drop)
+			ssh_ptl_tx_inject_invalid_data(ptl->tx.packet);
+
 		// note: flush-packets don't have any data
-		if (likely(ptl->tx.packet->data.ptr)) {
+		if (likely(ptl->tx.packet->data.ptr && !drop)) {
 			buf = ptl->tx.packet->data.ptr + ptl->tx.offset;
 			len = ptl->tx.packet->data.len - ptl->tx.offset;
 
@@ -760,7 +1052,7 @@ static int ssh_ptl_tx_threadfn(void *data)
 			print_hex_dump_debug("tx: ", DUMP_PREFIX_OFFSET, 16, 1,
 					     buf, len, false);
 
-			status = serdev_device_write_buf(ptl->serdev, buf, len);
+			status = ssh_ptl_write_buf(ptl, ptl->tx.packet, buf, len);
 		}
 
 		if (status < 0) {
@@ -1340,6 +1632,9 @@ static size_t ssh_ptl_rx_eval(struct ssh_ptl *ptl, struct ssam_span *source)
 	bool syn_found;
 	int status;
 
+	// error injection: modify data to simulate corrupt SYN bytes
+	ssh_ptl_rx_inject_invalid_syn(ptl, source);
+
 	// find SYN
 	syn_found = sshp_find_syn(source, &aligned);
 
@@ -1370,6 +1665,9 @@ static size_t ssh_ptl_rx_eval(struct ssh_ptl *ptl, struct ssam_span *source)
 	if (unlikely(!syn_found))
 		return aligned.ptr - source->ptr;
 
+	// error injection: modify data to simulate corruption
+	ssh_ptl_rx_inject_invalid_data(ptl, &aligned);
+
 	// parse and validate frame
 	status = sshp_parse_frame(&ptl->serdev->dev, &aligned, &frame, &payload,
 				  SSH_PTL_RX_BUF_LEN);
diff --git a/drivers/misc/surface_aggregator/ssh_request_layer.c b/drivers/misc/surface_aggregator/ssh_request_layer.c
index e7358b9a2e4d..62513594d4e8 100644
--- a/drivers/misc/surface_aggregator/ssh_request_layer.c
+++ b/drivers/misc/surface_aggregator/ssh_request_layer.c
@@ -3,6 +3,7 @@
 #include <asm/unaligned.h>
 #include <linux/atomic.h>
 #include <linux/completion.h>
+#include <linux/error-injection.h>
 #include <linux/ktime.h>
 #include <linux/list.h>
 #include <linux/slab.h>
@@ -47,6 +48,31 @@
 #define SSH_RTL_MAX_PENDING		3
 
 
+#ifdef CONFIG_SURFACE_AGGREGATOR_ERROR_INJECTION
+
+/**
+ * ssh_rtl_should_drop_response() - Error injection hook to drop request
+ * responses.
+ *
+ * Useful to cause request transmission timeouts in the driver by dropping the
+ * response to a request.
+ */
+static noinline bool ssh_rtl_should_drop_response(void)
+{
+	return false;
+}
+ALLOW_ERROR_INJECTION(ssh_rtl_should_drop_response, TRUE);
+
+#else
+
+static inline bool ssh_rtl_should_drop_response(void)
+{
+	return false;
+}
+
+#endif
+
+
 static u16 ssh_request_get_rqid(struct ssh_request *rqst)
 {
 	return get_unaligned_le16(rqst->packet.data.ptr
@@ -453,6 +479,16 @@ static void ssh_rtl_complete(struct ssh_rtl *rtl,
 		if (unlikely(ssh_request_get_rqid(p) != rqid))
 			continue;
 
+		// simulate response timeout
+		if (ssh_rtl_should_drop_response()) {
+			spin_unlock(&rtl->pending.lock);
+
+			trace_ssam_ei_rx_drop_response(p);
+			rtl_info(rtl, "request error injection: dropping response for request %p\n",
+				 &p->packet);
+			return;
+		}
+
 		/*
 		 * Mark as "response received" and "locked" as we're going to
 		 * complete it.
diff --git a/drivers/misc/surface_aggregator/trace.h b/drivers/misc/surface_aggregator/trace.h
index eb2e3e1457de..e99e35a2d939 100644
--- a/drivers/misc/surface_aggregator/trace.h
+++ b/drivers/misc/surface_aggregator/trace.h
@@ -594,6 +594,15 @@ DEFINE_SSAM_REQUEST_EVENT(request_cancel);
 DEFINE_SSAM_REQUEST_STATUS_EVENT(request_complete);
 DEFINE_SSAM_GENERIC_UINT_EVENT(rtl_timeout_reap);
 
+DEFINE_SSAM_PACKET_EVENT(ei_tx_drop_ack_packet);
+DEFINE_SSAM_PACKET_EVENT(ei_tx_drop_nak_packet);
+DEFINE_SSAM_PACKET_EVENT(ei_tx_drop_dsq_packet);
+DEFINE_SSAM_PACKET_STATUS_EVENT(ei_tx_fail_write);
+DEFINE_SSAM_PACKET_EVENT(ei_tx_corrupt_data);
+DEFINE_SSAM_GENERIC_UINT_EVENT(ei_rx_corrupt_syn);
+DEFINE_SSAM_FRAME_EVENT(ei_rx_corrupt_data);
+DEFINE_SSAM_REQUEST_EVENT(ei_rx_drop_response);
+
 DEFINE_SSAM_ALLOC_EVENT(ctrl_packet_alloc);
 DEFINE_SSAM_FREE_EVENT(ctrl_packet_free);
 
-- 
2.28.0

