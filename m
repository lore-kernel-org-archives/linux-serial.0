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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8083AC4727F
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 15:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2801E2176B
	for <linux-serial@archiver.kernel.org>; Wed, 23 Sep 2020 15:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uf60x12B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgIWPPr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 23 Sep 2020 11:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgIWPPm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 23 Sep 2020 11:15:42 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE7DC0613CE;
        Wed, 23 Sep 2020 08:15:41 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g4so210447edk.0;
        Wed, 23 Sep 2020 08:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ljUNz4nxzRXt0070Rym5EDstn0uh2remfIrqRlR+Q2U=;
        b=uf60x12BPWaMq9Dxte/1n5p1k+WCi5UU9eMm+sQDUXqJjFd/aAWY6GnHSUy7rwrODw
         6ZZCdTm8Eiw4MQc/I7jCsshogfjq3kk8bLqm99jjwtNbJKp/szXeuBlc8fQ/dyXT+UeA
         +Gwp24IQmK8hD1sxOqsyDcVoznXGsH9N9RgrkAAKMg79faxjMSHpECIEmwa0c4oTbtAR
         Bcfq8ZVp4FRh5VnOQUgzHlbMK1SQxU3Y6NDFt0CObK1gbGvDs1QRznxStKpBiFWWfNmF
         VSD6IsB5nPBteDpDz9OcMPqqir1XIje8gWxdzB1A3ZVTS/Kuronn0NTR+LV6zXg5R/vA
         C/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ljUNz4nxzRXt0070Rym5EDstn0uh2remfIrqRlR+Q2U=;
        b=iBRtxhGfsMOP2euw5DN365hf1ksB7cjKXZhX+IEgXcSy+gSXPjXpUoXnH7tVqS/9nm
         I87hyYYFSQjxASSs+xCFBrCnW1Hp6A4FP60SvadxaePqDNjmuavA2G8H5DUl8EkyUdG6
         sUAwJx/7ckhymHdRdl+Hg9CY3CRbuwgtLfHGHQzUUjQbqdi6I05NVlAwS5RiwoYJFYPG
         PE4j/EiC466axOLUfqcBdeML0DVyBCDeFAHwhsaI2VdLbKKFq841mfck2apk0ytHtdMF
         3U4wf32uf4xM2trjBwb8P6epzlLHM16hzNHPx4LShaza6TB7YzTA+3L/iqZyu9Zjufur
         MKbQ==
X-Gm-Message-State: AOAM530i+HwbvZ781WqN7A6sGIxoYMpOcr/XnmkFhd7sYjgkA2uuALLf
        P0InSmaR9RtAkLuu2XfC+AozukRl1Y0=
X-Google-Smtp-Source: ABdhPJx9FZyoPZZFIcetdhp7/7tQZ3lohRtN0/1JKCKaVrsEub2IKJk7UyTj4F6WZ7ZQuFZASEdm3g==
X-Received: by 2002:a50:c051:: with SMTP id u17mr10617091edd.39.1600874139842;
        Wed, 23 Sep 2020 08:15:39 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a9df.dip0.t-ipconnect.de. [217.229.169.223])
        by smtp.gmail.com with ESMTPSA id ch29sm160707edb.74.2020.09.23.08.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 08:15:39 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Subject: [RFC PATCH 3/9] surface_aggregator: Add event item allocation chaching
Date:   Wed, 23 Sep 2020 17:15:05 +0200
Message-Id: <20200923151511.3842150-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200923151511.3842150-1-luzmaximilian@gmail.com>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Event items are used for completing Surface Aggregator EC events, i.e.
placing event command data and payload on a workqueue for later
processing to avoid doing said processing directly on the receiver
thread. This means that event items are allocated for each incoming
event, regardless of that event being transmitted via sequenced or
unsequenced packets.

On the Surface Book 3 and Surface Laptop 3, touchpad HID input events
(unsequenced), can constitute a larger amount of traffic, and therefore
allocation of event items. This warrants caching event items to reduce
memory fragmentation. The size of the cached objects is specifically
tuned to accommodate keyboard and touchpad input events and their
payloads on those devices. As a result, this effectively also covers
most other event types. In case of a larger event payload, event item
allocation will fall back to kzalloc().

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/misc/surface_aggregator/controller.c | 84 ++++++++++++++++++--
 drivers/misc/surface_aggregator/controller.h |  9 +++
 drivers/misc/surface_aggregator/core.c       | 16 +++-
 3 files changed, 100 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/surface_aggregator/controller.c b/drivers/misc/surface_aggregator/controller.c
index 6963cf1e1840..9780a410873e 100644
--- a/drivers/misc/surface_aggregator/controller.c
+++ b/drivers/misc/surface_aggregator/controller.c
@@ -530,14 +530,74 @@ static void ssam_nf_destroy(struct ssam_nf *nf)
 
 #define SSAM_CPLT_WQ_NAME	"ssam_cpltq"
 
+/*
+ * SSAM_EVENT_ITEM_CACHE_PAYLOAD_LEN - Maximum payload length for a cached
+ * &struct ssam_event_item.
+ *
+ * This length has been chosen to be accommodate standard touchpad and
+ * keyboard input events. Events with larger payloads will be allocated
+ * separately.
+ */
+#define SSAM_EVENT_ITEM_CACHE_PAYLOAD_LEN	32
+
+static struct kmem_cache *ssam_event_item_cache;
+
+/**
+ * ssam_event_item_cache_init() - Initialize the event item cache.
+ */
+int ssam_event_item_cache_init(void)
+{
+	const unsigned int size = sizeof(struct ssam_event_item)
+				  + SSAM_EVENT_ITEM_CACHE_PAYLOAD_LEN;
+	const unsigned int align = __alignof__(struct ssam_event_item);
+	struct kmem_cache *cache;
+
+	cache = kmem_cache_create("ssam_event_item", size, align, 0, NULL);
+	if (!cache)
+		return -ENOMEM;
+
+	ssam_event_item_cache = cache;
+	return 0;
+}
+
+/**
+ * ssam_event_item_cache_destroy() - Deinitialize the event item cache.
+ */
+void ssam_event_item_cache_destroy(void)
+{
+	kmem_cache_destroy(ssam_event_item_cache);
+	ssam_event_item_cache = NULL;
+}
+
+static void __ssam_event_item_free_cached(struct ssam_event_item *item)
+{
+	kmem_cache_free(ssam_event_item_cache, item);
+}
+
+static void __ssam_event_item_free_generic(struct ssam_event_item *item)
+{
+	kfree(item);
+}
+
+/**
+ * ssam_event_item_free() - Free the provided event item.
+ * @item: The event item to free.
+ */
+static void ssam_event_item_free(struct ssam_event_item *item)
+{
+	item->ops.free(item);
+}
+
 /**
  * ssam_event_item_alloc() - Allocate an event item with the given payload size.
  * @len:   The event payload length.
  * @flags: The flags used for allocation.
  *
- * Allocate an event item with the given payload size. Sets the item
- * operations and payload length values. The item free callback (``ops.free``)
- * should not be overwritten after this call.
+ * Allocate an event item with the given payload size, preferring allocation
+ * from the event item cache if the payload is small enough (i.e. smaller than
+ * %SSAM_EVENT_ITEM_CACHE_PAYLOAD_LEN). Sets the item operations and payload
+ * length values. The item free callback (``ops.free``) should not be
+ * overwritten after this call.
  *
  * Return: Returns the newly allocated event item.
  */
@@ -545,9 +605,19 @@ static struct ssam_event_item *ssam_event_item_alloc(size_t len, gfp_t flags)
 {
 	struct ssam_event_item *item;
 
-	item = kzalloc(sizeof(*item) + len, GFP_KERNEL);
-	if (!item)
-		return NULL;
+	if (len <= SSAM_EVENT_ITEM_CACHE_PAYLOAD_LEN) {
+		item = kmem_cache_alloc(ssam_event_item_cache, GFP_KERNEL);
+		if (!item)
+			return NULL;
+
+		item->ops.free = __ssam_event_item_free_cached;
+	} else {
+		item = kzalloc(sizeof(*item) + len, GFP_KERNEL);
+		if (!item)
+			return NULL;
+
+		item->ops.free = __ssam_event_item_free_generic;
+	}
 
 	item->event.length = len;
 	return item;
@@ -709,7 +779,7 @@ static void ssam_event_queue_work_fn(struct work_struct *work)
 			return;
 
 		ssam_nf_call(nf, dev, item->rqid, &item->event);
-		kfree(item);
+		ssam_event_item_free(item);
 	}
 
 	if (!ssam_event_queue_is_empty(queue))
diff --git a/drivers/misc/surface_aggregator/controller.h b/drivers/misc/surface_aggregator/controller.h
index 88652120cf4b..5dde5705c79b 100644
--- a/drivers/misc/surface_aggregator/controller.h
+++ b/drivers/misc/surface_aggregator/controller.h
@@ -76,12 +76,18 @@ struct ssam_cplt;
  * struct ssam_event_item - Struct for event queuing and completion.
  * @node:     The node in the queue.
  * @rqid:     The request ID of the event.
+ * @ops:      Instance specific functions.
+ * @ops.free: Callback for freeing this event item.
  * @event:    Actual event data.
  */
 struct ssam_event_item {
 	struct list_head node;
 	u16 rqid;
 
+	struct {
+		void (*free)(struct ssam_event_item *event);
+	} ops;
+
 	struct ssam_event event;	// must be last
 };
 
@@ -271,4 +277,7 @@ int ssam_ctrl_notif_d0_entry(struct ssam_controller *ctrl);
 int ssam_controller_suspend(struct ssam_controller *ctrl);
 int ssam_controller_resume(struct ssam_controller *ctrl);
 
+int ssam_event_item_cache_init(void);
+void ssam_event_item_cache_destroy(void);
+
 #endif /* _SURFACE_AGGREGATOR_CONTROLLER_H */
diff --git a/drivers/misc/surface_aggregator/core.c b/drivers/misc/surface_aggregator/core.c
index 938c46a9e20b..5b79e57773fd 100644
--- a/drivers/misc/surface_aggregator/core.c
+++ b/drivers/misc/surface_aggregator/core.c
@@ -772,12 +772,23 @@ static int __init ssam_core_init(void)
 
 	status = ssh_ctrl_packet_cache_init();
 	if (status)
-		return status;
+		goto err_cpkg;
+
+	status = ssam_event_item_cache_init();
+	if (status)
+		goto err_evitem;
 
 	status = serdev_device_driver_register(&ssam_serial_hub);
 	if (status)
-		ssh_ctrl_packet_cache_destroy();
+		goto err_register;
 
+	return 0;
+
+err_register:
+	ssam_event_item_cache_destroy();
+err_evitem:
+	ssh_ctrl_packet_cache_destroy();
+err_cpkg:
 	return status;
 }
 module_init(ssam_core_init);
@@ -785,6 +796,7 @@ module_init(ssam_core_init);
 static void __exit ssam_core_exit(void)
 {
 	serdev_device_driver_unregister(&ssam_serial_hub);
+	ssam_event_item_cache_destroy();
 	ssh_ctrl_packet_cache_destroy();
 }
 module_exit(ssam_core_exit);
-- 
2.28.0

