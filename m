Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AEFE7D0D5
	for <linux-serial@archiver.kernel.org>; Fri, 22 Sep 2023 06:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjIVGhB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Sep 2023 02:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjIVGg7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Sep 2023 02:36:59 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4E6197
        for <linux-serial@vger.kernel.org>; Thu, 21 Sep 2023 23:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=k1; bh=FklUloVeC/IRscF5Gxi0GaW0kes3xUCC/OyKePZjK7g=; b=QMDzuS
        5SRIR3kgcPOVLsMOQOQjRV03h+7w8tVMA1L53xCEhlo/eiF8uRtU8qs+Y9YupN5w
        1jCfYXB3jXVnkbCW09p1V8BrdC3FWI+xvH5d0edFEwNkHzrdLfsvmQFs1AO8uXk3
        5k7nldWfgpT6k7AHB1WL4O6BXQIaI6AksP8QymfGSJiMF3SBD/TNE6bCaZs3cjCH
        /UeLchJO1bCk6QO8QsEki16nnSheCssxUejZesJCns0CibWjYj+i8SIpHeumw/LH
        DsexD1/9NGXYw+RpKt4J0XE6Gf/fweltgpzau92yUc+I11Qs7KHDrVlxMU6uSFwt
        3cPxw4mQUnE9NJtA==
Received: (qmail 1276431 invoked from network); 22 Sep 2023 08:36:51 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 22 Sep 2023 08:36:51 +0200
X-UD-Smtp-Session: l3s3148p1@bHdj1ewFeroujntX
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH 2/2] serial: core: add comment about definitely used port types
Date:   Fri, 22 Sep 2023 08:36:42 +0200
Message-Id: <20230922063642.4120-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230922063642.4120-1-wsa+renesas@sang-engineering.com>
References: <20230922063642.4120-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

When port type 18 was removed, it was deduced that the code could go but
its define has to stay because it is used in userspace. Share that
knowledge by adding a comment about it.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/uapi/linux/serial_core.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 92e3dd56f631..46e06c483899 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -11,6 +11,8 @@
  * The type definitions.  These are from Ted Ts'o's serial.h
  * By historical reasons the values from 0 to 13 are defined
  * in the include/uapi/linux/serial.h, do not define them here.
+ * Values 0 to 19 are used by setserial from busybox and must never
+ * be modified.
  */
 #define PORT_NS16550A	14
 #define PORT_XSCALE	15
-- 
2.35.1

