Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6543C433F5
	for <linux-serial@archiver.kernel.org>; Fri, 26 Nov 2021 08:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352699AbhKZIVj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:21:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:50448 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359412AbhKZIT0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 26 Nov 2021 03:19:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3F0D521B42;
        Fri, 26 Nov 2021 08:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637914573; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6aCW34+sQ46sNHhntzkah/BM0GW8xeDK76hDCD5DDIU=;
        b=GDqhow7VKeoDjvvOADYHJGg7NO7FSoP3TLi2p7/66v51vEJX3fayY10pRd01eLtI44b4XG
        ZkSFsHnlTOOGG8Ub/0TM2/eHOz2weuZ4epM42EnxExCgo5oD95JFrbWI+RXM0lV8JcEcT3
        jTsX1SWFceDmcrGjBU0pf+OkEjnXFg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637914573;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6aCW34+sQ46sNHhntzkah/BM0GW8xeDK76hDCD5DDIU=;
        b=Yvf30yOe5G1JcEyA7QQ26LEkyzF0ErZCPgZXDgQGqHJMBJifjL3t8EbWdkE2BD2Y90YfJC
        AuRMpsgiRDiaUaCA==
Received: from localhost.localdomain (unknown [10.100.208.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 16A68A3B81;
        Fri, 26 Nov 2021 08:16:13 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 05/23] tty: add kernel-doc for tty_port_operations
Date:   Fri, 26 Nov 2021 09:15:53 +0100
Message-Id: <20211126081611.11001-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211126081611.11001-1-jslaby@suse.cz>
References: <20211126081611.11001-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

tty_port_operations used to have only comments along its members.
Convert them into proper kernel-doc comments in front of the structure.
And add some more explanation to them where needed.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 include/linux/tty_port.h | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index 9091e1c8de4c..d3ea9ed0b98e 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -12,21 +12,28 @@ struct tty_driver;
 struct tty_port;
 struct tty_struct;
 
+/**
+ * struct tty_port_operations -- operations on tty_port
+ * @carrier_raised: return 1 if the carrier is raised on @port
+ * @dtr_rts: raise the DTR line if @raise is nonzero, otherwise lower DTR
+ * @shutdown: called when the last close completes or a hangup finishes IFF the
+ *	port was initialized. Do not use to free resources. Turn off the device
+ *	only. Called under the port mutex to serialize against @activate and
+ *	@shutdown.
+ * @activate: called under the port mutex from tty_port_open(), serialized using
+ *	the port mutex. Supposed to turn on the device.
+ *
+ *	FIXME: long term getting the tty argument *out* of this would be good
+ *	for consoles.
+ *
+ * @destruct: called on the final put of a port. Free resources, possibly incl.
+ *	the port itself.
+ */
 struct tty_port_operations {
-	/* Return 1 if the carrier is raised */
 	int (*carrier_raised)(struct tty_port *port);
-	/* Control the DTR line */
 	void (*dtr_rts)(struct tty_port *port, int raise);
-	/* Called when the last close completes or a hangup finishes
-	   IFF the port was initialized. Do not use to free resources. Called
-	   under the port mutex to serialize against activate/shutdowns */
 	void (*shutdown)(struct tty_port *port);
-	/* Called under the port mutex from tty_port_open, serialized using
-	   the port mutex */
-        /* FIXME: long term getting the tty argument *out* of this would be
-           good for consoles */
 	int (*activate)(struct tty_port *port, struct tty_struct *tty);
-	/* Called on the final put of a port */
 	void (*destruct)(struct tty_port *port);
 };
 
-- 
2.34.0

