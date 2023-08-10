Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2804C04A94
	for <linux-serial@archiver.kernel.org>; Thu, 10 Aug 2023 09:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbjHJJRT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Aug 2023 05:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbjHJJRA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Aug 2023 05:17:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7B24223;
        Thu, 10 Aug 2023 02:16:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E0426550A;
        Thu, 10 Aug 2023 09:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B400C433CA;
        Thu, 10 Aug 2023 09:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658972;
        bh=14gTPQx7XyzDqSWiJUFV6C/aJrHW2+ALhVNcSU3mPbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KNFPxPS7MK3Hchuv55BVxmG7yaaf0nj8sRDWsSSkcD6FEOkMBIfHt1qIlMfYbLGTu
         nfC50KXzI9blYYWmOAxfucPu4FveHK6Wx3hPG7/gFdSlmbh+pSMlUTHt/R7RoYiTWv
         G8KxrtKZcL49/fGJACFQYkwEZ2xTyL/AwLv1pZ7hhqojM4WWu/3dQlkI1kbidh+GgX
         MEEjRHCL1Tj7NlxdOS9wvgtH2On+Bvr+HJwHMaKEKrusamCSUSrDeZ6cQ3pjW6xLBR
         gRFkOaTvN0319wHDb/1d9RpjcsFCWBATzRT8i9cDWcx3OhQpuwCLcIJip+hJEgr5Bf
         q5EGUQjZOqTfg==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 26/36] tty: use min() for size computation in iterate_tty_read()
Date:   Thu, 10 Aug 2023 11:15:00 +0200
Message-ID: <20230810091510.13006-27-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230810091510.13006-1-jirislaby@kernel.org>
References: <20230810091510.13006-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The computation is more obvious with min().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/tty_io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 7cfa99fbbb62..4f21a21a1fd5 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -853,9 +853,8 @@ static ssize_t iterate_tty_read(struct tty_ldisc *ld, struct tty_struct *tty,
 	size_t copied, count = iov_iter_count(to);
 
 	do {
-		ssize_t size;
+		ssize_t size = min(count, sizeof(kernel_buf));
 
-		size = count > sizeof(kernel_buf) ? sizeof(kernel_buf) : count;
 		size = ld->ops->read(tty, file, kernel_buf, size, &cookie, offset);
 		if (!size)
 			break;
-- 
2.41.0

