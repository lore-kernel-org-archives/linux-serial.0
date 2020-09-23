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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EAEFC4727E
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 15:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 318682075B
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 15:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Snya3+qd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgIWPPf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Sep 2020 11:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgIWPPf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Sep 2020 11:15:35 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F11EDC0613CE;
        Wed, 23 Sep 2020 08:15:34 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id nw23so166720ejb.4;
        Wed, 23 Sep 2020 08:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gg3JmoRMKoKiy6tg/yGws7IDfP6or3NovBgwU2iRw0w=;
        b=Snya3+qdB/Um8GrD8SiHTd9m3W9Cr+z4l4YbTNmCI70Qm6dMJT640/a9z3CS5ZQPD9
         IgavzF1KMMXs445RcHk4wAYrP+QFcpTcolMEgAuVYrjvumnlPIf1UK4DizaHz53fwsFX
         +XRD9Xv+che14Wx/7CRbYZOaZEtjiqMgLMuDIJSL5EnDsRIVz0XDNq6YCHht9o3eglkY
         x2C6gShi1NIf68vnfpLm9zwgPLpnTljqFkulQLN3abHB5Wb9CGTzh1Zu1HPWXQ15QDSh
         WDdB6GIHE5pohofQcv97czLWwK2SNIgM1/Q7wBn0leT4JXK6BecQ9i0AGi3kTLItBLdO
         tyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gg3JmoRMKoKiy6tg/yGws7IDfP6or3NovBgwU2iRw0w=;
        b=KO5OOYVDT2Pbr+Blqos/hg59jrWuBYut7Ttnx2OFhbE7erJbxspyO3brrL0bET8Z+E
         3n2U3yl0mwfbW8aCeO+RNf6aefr7lxo5ntH2jtvqFgDp4PfqMTBzic666YhA5dN6Mv/k
         Mu1IG5POE6UeKpDQPznXiltIyTMouXdS5bcT7nV2PP2/WfYhaGtaqFLAM9D4nWV/Xonf
         61jctYeEaj+Gns33/GhXQHkqlm4/tBXqyynMgiCpsn6qX4S2plwp42IqXPz9/4Kycvwh
         OYwg/B83YCuQZabsjg3PaOnNkmqT98oCq3oKYJA5loNNqv/v695GTHmAK7VlLU1vGoL5
         MsYA==
X-Gm-Message-State: AOAM5338pEY7Et0UnIM/cMdVfxdNMy/o48UZb5YE7Q3naPHShiN+P0nd
        IGQw1QQN03qgYI6DSVTA3Q4YFZyY1ag=
X-Google-Smtp-Source: ABdhPJwjM1e7JXqujSn7OmFGRbIBAj9vZKY19KLGQzIatE8SiHV3+pRaYn4mCKmAtsFLo/luonOdyA==
X-Received: by 2002:a17:906:1157:: with SMTP id i23mr139236eja.440.1600874133082;
        Wed, 23 Sep 2020 08:15:33 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a9df.dip0.t-ipconnect.de. [217.229.169.223])
        by smtp.gmail.com with ESMTPSA id ch29sm160707edb.74.2020.09.23.08.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:15:32 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Subject: [RFC PATCH 2/9] surface_aggregator: Add control packet allocation chaching
Date:   Wed, 23 Sep 2020 17:15:04 +0200
Message-Id: <20200923151511.3842150-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923151511.3842150-1-luzmaximilian@gmail.com>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Surface Serial Hub communication is, in its core, packet based. Each
sequenced packet requires to be acknowledged, via an ACK-type control
packet. In case invalid data has been received by the driver, a NAK-type
(not-acknowledge/negative acknowledge) control packet is sent,
triggering retransmission.

Control packets are therefore a core communication primitive and used
frequently enough (with every sequenced packet transmission sent by the
embedded controller, including events and request responses) that it may
warrant caching their allocations to reduce possible memory
fragmentation.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/misc/surface_aggregator/core.c        | 27 ++++++++++-
 .../surface_aggregator/ssh_packet_layer.c     | 47 +++++++++++++++----
 .../surface_aggregator/ssh_packet_layer.h     |  3 ++
 3 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/surface_aggregator/core.c b/drivers/misc/surface_aggregator/core.c
index e428aa59fcc3..938c46a9e20b 100644
--- a/drivers/misc/surface_aggregator/core.c
+++ b/drivers/misc/surface_aggregator/core.c
@@ -762,7 +762,32 @@ static struct serdev_device_driver ssam_serial_hub = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
-module_serdev_device_driver(ssam_serial_hub);
+
+
+/* -- Module setup. --------------------------------------------------------- */
+
+static int __init ssam_core_init(void)
+{
+	int status;
+
+	status = ssh_ctrl_packet_cache_init();
+	if (status)
+		return status;
+
+	status = serdev_device_driver_register(&ssam_serial_hub);
+	if (status)
+		ssh_ctrl_packet_cache_destroy();
+
+	return status;
+}
+module_init(ssam_core_init);
+
+static void __exit ssam_core_exit(void)
+{
+	serdev_device_driver_unregister(&ssam_serial_hub);
+	ssh_ctrl_packet_cache_destroy();
+}
+module_exit(ssam_core_exit);
 
 MODULE_AUTHOR("Maximilian Luz <luzmaximilian@gmail.com>");
 MODULE_DESCRIPTION("Subsystem and Surface Serial Hub driver for Surface System Aggregator Module");
diff --git a/drivers/misc/surface_aggregator/ssh_packet_layer.c b/drivers/misc/surface_aggregator/ssh_packet_layer.c
index fa1a3d1d4a49..993aabfdfdae 100644
--- a/drivers/misc/surface_aggregator/ssh_packet_layer.c
+++ b/drivers/misc/surface_aggregator/ssh_packet_layer.c
@@ -284,24 +284,53 @@ void ssh_packet_init(struct ssh_packet *packet, unsigned long type,
 }
 
 
+static struct kmem_cache *ssh_ctrl_packet_cache;
+
+/**
+ * ssh_ctrl_packet_cache_init() - Initialize the control packet cache.
+ */
+int ssh_ctrl_packet_cache_init(void)
+{
+	const unsigned int size = sizeof(struct ssh_packet) + SSH_MSG_LEN_CTRL;
+	const unsigned int align = __alignof__(struct ssh_packet);
+	struct kmem_cache *cache;
+
+	cache = kmem_cache_create("ssam_ctrl_packet", size, align, 0, NULL);
+	if (!cache)
+		return -ENOMEM;
+
+	ssh_ctrl_packet_cache = cache;
+	return 0;
+}
+
+/**
+ * ssh_ctrl_packet_cache_destroy() - Deinitialize the control packet cache.
+ */
+void ssh_ctrl_packet_cache_destroy(void)
+{
+	kmem_cache_destroy(ssh_ctrl_packet_cache);
+	ssh_ctrl_packet_cache = NULL;
+}
+
 /**
- * ssh_ctrl_packet_alloc() - Allocate control packet.
+ * ssh_ctrl_packet_alloc() - Allocate packet from control packet cache.
  * @packet: Where the pointer to the newly allocated packet should be stored.
  * @buffer: The buffer corresponding to this packet.
  * @flags:  Flags used for allocation.
  *
- * Allocates a packet and corresponding transport buffer. Sets the packet's
- * buffer reference to the allocated buffer. The packet must be freed via
- * ssh_ctrl_packet_free(), which will also free the corresponding buffer. The
- * corresponding buffer must not be freed separately. Intended to be used with
- * %ssh_ptl_ctrl_packet_ops as packet operations.
+ * Allocates a packet and corresponding transport buffer from the control
+ * packet cache. Sets the packet's buffer reference to the allocated buffer.
+ * The packet must be freed via ssh_ctrl_packet_free(), which will also free
+ * the corresponding buffer. The corresponding buffer must not be freed
+ * separately. Intended to be used with %ssh_ptl_ctrl_packet_ops as packet
+ * operations.
  *
  * Return: Returns zero on success, %-ENOMEM if the allocation failed.
  */
 static int ssh_ctrl_packet_alloc(struct ssh_packet **packet,
 				 struct ssam_span *buffer, gfp_t flags)
 {
-	*packet = kzalloc(sizeof(**packet) + SSH_MSG_LEN_CTRL, flags);
+	*packet = kmem_cache_alloc(ssh_ctrl_packet_cache, flags);
 	if (!*packet)
 		return -ENOMEM;
 
@@ -312,12 +341,12 @@ static int ssh_ctrl_packet_alloc(struct ssh_packet **packet,
 }
 
 /**
- * ssh_ctrl_packet_free() - Free control packet.
+ * ssh_ctrl_packet_free() - Free packet allocated from control packet cache.
  * @p: The packet to free.
  */
 static void ssh_ctrl_packet_free(struct ssh_packet *p)
 {
-	kfree(p);
+	kmem_cache_free(ssh_ctrl_packet_cache, p);
 }
 
 static const struct ssh_packet_ops ssh_ptl_ctrl_packet_ops = {
diff --git a/drivers/misc/surface_aggregator/ssh_packet_layer.h b/drivers/misc/surface_aggregator/ssh_packet_layer.h
index 51295cf48519..957dd3f1006c 100644
--- a/drivers/misc/surface_aggregator/ssh_packet_layer.h
+++ b/drivers/misc/surface_aggregator/ssh_packet_layer.h
@@ -164,4 +164,7 @@ void ssh_ptl_tx_wakeup(struct ssh_ptl *ptl);
 void ssh_packet_init(struct ssh_packet *packet, unsigned long type,
 		     u8 priority, const struct ssh_packet_ops *ops);
 
+int ssh_ctrl_packet_cache_init(void);
+void ssh_ctrl_packet_cache_destroy(void);
+
 #endif /* _SURFACE_AGGREGATOR_SSH_PACKET_LAYER_H */
-- 
2.28.0

