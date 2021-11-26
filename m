Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7546AC433FE
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359455AbhKZIXt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:23:49 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33068 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359378AbhKZIV2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:21:28 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 065D11FE05;
        Fri, 26 Nov 2021 08:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XTw1ArMDtSuaE6XFFrVD6FeD6liTw/lYEV3JL5Vkt3I=;
        b=smo1bvLhVBdd1B8Rhu0CTakw38SsSV/6JqenBKZHdRQ7AKvuRYpqWcpb7lv6d+lqYXuykI
        K0rP+z2cTB3zQnLxydto6Fe+5Ac+iRr+tAzYzCsBB6Bk+NQi4J08uwjcMzCEhHEPfdb3N9
        phf4SnhjpNSReB+gWfydCqEmbUXazUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914576;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XTw1ArMDtSuaE6XFFrVD6FeD6liTw/lYEV3JL5Vkt3I=;
        b=wRE88E7GELvUv9+ahKBnp+i190Lau9aNIo4ZgFpg2MC4rLdr6dXT27Rh8n0Ni1cBybkmdN
        ypCiQ0NSnL/HMFDw==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D4CA6A3B83;
        Fri, 26 Nov 2021 08:16:15 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 18/23] tty: add kernel-doc for more tty_port functions
Date:   Fri, 26 Nov 2021 09:16:06 +0100
Message-Id: <20211126081611.11001-19-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126081611.11001-1-jslaby@suse.cz>
References: <20211126081611.11001-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From the main tty_port functions, only tty_port_destroy() was
documented. Document more of them, so that we can reference them in
Documentation/ later in this series.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/tty_port.c | 54 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index ebb441ee92d5..7709ce655f44 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -59,6 +59,15 @@ const struct tty_port_client_operations tty_port_default_client_ops = {
 };
 EXPORT_SYMBOL_GPL(tty_port_default_client_ops);
 
+/**
+ * tty_port_init -- initialize tty_port
+ * @port: tty_port to initialize
+ *
+ * Initializes the state of struct tty_port. When a port was initialized using
+ * this function, one has to destroy the port by tty_port_destroy(). Either
+ * indirectly by using &tty_port refcounting (tty_port_put()) or directly if
+ * refcounting is not used.
+ */
 void tty_port_init(struct tty_port *port)
 {
 	memset(port, 0, sizeof(*port));
@@ -267,6 +276,13 @@ static void tty_port_destructor(struct kref *kref)
 		kfree(port);
 }
 
+/**
+ * tty_port_put -- drop a reference to tty_port
+ * @port: port to drop a reference of (can be NULL)
+ *
+ * The final put will destroy and free up the @port using
+ * @port->ops->destruct() hook, or using kfree() if not provided.
+ */
 void tty_port_put(struct tty_port *port)
 {
 	if (port)
@@ -312,6 +328,16 @@ void tty_port_tty_set(struct tty_port *port, struct tty_struct *tty)
 }
 EXPORT_SYMBOL(tty_port_tty_set);
 
+/**
+ * tty_port_shutdown - internal helper to shutdown the device
+ * @port: tty port to be shut down
+ * @tty: the associated tty
+ *
+ * It is used by tty_port_hangup() and tty_port_close(). Its task is to
+ * shutdown the device if it was initialized (note consoles remain
+ * functioning). It lowers DTR/RTS (if @tty has HUPCL set) and invokes
+ * @port->ops->shutdown().
+ */
 static void tty_port_shutdown(struct tty_port *port, struct tty_struct *tty)
 {
 	mutex_lock(&port->mutex);
@@ -559,7 +585,21 @@ static void tty_port_drain_delay(struct tty_port *port, struct tty_struct *tty)
 	schedule_timeout_interruptible(timeout);
 }
 
-/* Caller holds tty lock. */
+/**
+ * tty_port_close_start - helper for tty->ops->close, part 1/2
+ * @port: tty_port of the device
+ * @tty: tty being closed
+ * @filp: passed file pointer
+ *
+ * Decrements and checks open count. Flushes the port if this is the last
+ * close. That means, dropping the data from the outpu buffer on the device and
+ * waiting for sending logic to finish. The rest of close handling is performed
+ * in tty_port_close_end().
+ *
+ * Locking: Caller holds tty lock.
+ *
+ * Return: 1 if this is the last close, otherwise 0
+ */
 int tty_port_close_start(struct tty_port *port,
 				struct tty_struct *tty, struct file *filp)
 {
@@ -605,7 +645,17 @@ int tty_port_close_start(struct tty_port *port,
 }
 EXPORT_SYMBOL(tty_port_close_start);
 
-/* Caller holds tty lock */
+/**
+ * tty_port_close_end - helper for tty->ops->close, part 2/2
+ * @port: tty_port of the device
+ * @tty: tty being closed
+ *
+ * This is a continuation of the first part: tty_port_close_start(). This
+ * should be called after turning off the device. It flushes the data from the
+ * line discipline and delays the close by @port->close_delay.
+ *
+ * Locking: Caller holds tty lock.
+ */
 void tty_port_close_end(struct tty_port *port, struct tty_struct *tty)
 {
 	unsigned long flags;
-- 
2.34.0

