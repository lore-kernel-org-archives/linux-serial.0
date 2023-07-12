Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F095C001DD
	for <linux-serial@archiver.kernel.org>; Wed, 12 Jul 2023 09:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbjGLJB4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Jul 2023 05:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbjGLJBL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Jul 2023 05:01:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F451BFB;
        Wed, 12 Jul 2023 01:59:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6D24616E6;
        Wed, 12 Jul 2023 08:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6DBC433C9;
        Wed, 12 Jul 2023 08:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689152394;
        bh=BR+iCpSuQ7vxUhB+UPskQqo1D8fyS+p3rbke57h/srY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=koAZdbFhYit8+IZ+/sRyA0ny8Ba4SKLjFvY3BBuxstMtA/AsdoJZJ6Pjrr6IdRc9S
         Q4ZDSiDq12k8y1EjsHEA3nHJaNHxSRlSMpqkkpyceqFYmU+4MMt2y0iQBNsoYLenYZ
         nMqrdNFAYDH7199G/Z9c6owb80OAR5qI+T2D74HnAzwUc1f7ZNtIzoOZeAMwDc32VB
         hTyCX2R7tDYpBvMfmhQ3b4VHFeoKvasKZSmyNYEF6XDvCbb/Tk8cGX9x+Xn5/K77Iq
         CZcV6wTzt3WVjpHsgTJJkW8IOpEQv/JxMuxJysuffxhSffvDhZKXAClzW+S0DKaFMo
         kfcugQulRuodg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 4/7] vgacon: let vgacon_doresize() return void
Date:   Wed, 12 Jul 2023 10:59:39 +0200
Message-ID: <20230712085942.5064-5-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712085942.5064-1-jirislaby@kernel.org>
References: <20230712085942.5064-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The return value is neither used, nor vgacon_doresize() returns an
error. So change the reurn type to void.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/console/vgacon.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 7cb15851ea56..07f6b97d9b81 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -528,7 +528,7 @@ static void vgacon_cursor(struct vc_data *c, int mode)
 	}
 }
 
-static int vgacon_doresize(struct vc_data *c,
+static void vgacon_doresize(struct vc_data *c,
 		unsigned int width, unsigned int height)
 {
 	unsigned long flags;
@@ -587,7 +587,6 @@ static int vgacon_doresize(struct vc_data *c,
 	}
 
 	raw_spin_unlock_irqrestore(&vga_lock, flags);
-	return 0;
 }
 
 static int vgacon_switch(struct vc_data *c)
-- 
2.41.0

