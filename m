Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD37EB64D9
	for <linux-serial@archiver.kernel.org>; Wed, 12 Jul 2023 09:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjGLJCA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 Jul 2023 05:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjGLJBQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 Jul 2023 05:01:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42B11FD7;
        Wed, 12 Jul 2023 02:00:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49194616E6;
        Wed, 12 Jul 2023 09:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9915C433C8;
        Wed, 12 Jul 2023 08:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689152400;
        bh=mNSmd92ZbJuvcNP8ky3SAI3dF+kkSfKu6xhDOjjQyVQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BIErQfDNd6hkpyWfmBW4uEcGcSNLp/ChKU7PdzP7y7na/eUC9caCwHHtotfeZnMWQ
         dYaHnwx3flEeWuqvNVylpyw2wL34YQacPH7yB/8iWZQhKx9n03V2gOzcrBGfPW6nGy
         9tHgH+dQIfFO/FyYCyhlERdElrfmhgPWPB6vglfz+WCDU6a9FcKnODZR0O66G4QZdD
         3MvHDvSa75tXCPjgd4fOeB4R0/4ys9yE6HvMNWuxuWNdIjJXUwVRy+LPFFq7iNOwMR
         91vYJDGDOXKt0TlnW2yewBZFKyGRFZ+pvwp3lYM+OK65Icb0M/ymv6PlCj9FzqgCT8
         YPh7cgAwKWuhw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 7/7] fbcon: remove unused display (p) from fbcon_redraw()
Date:   Wed, 12 Jul 2023 10:59:42 +0200
Message-ID: <20230712085942.5064-8-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230712085942.5064-1-jirislaby@kernel.org>
References: <20230712085942.5064-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

The parameter is unused.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
---
 drivers/video/fbdev/core/fbcon.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index c6c9d040bdec..887fad44e7ec 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1612,8 +1612,7 @@ static void fbcon_redraw_blit(struct vc_data *vc, struct fb_info *info,
 	}
 }
 
-static void fbcon_redraw(struct vc_data *vc, struct fbcon_display *p,
-			 int line, int count, int offset)
+static void fbcon_redraw(struct vc_data *vc, int line, int count, int offset)
 {
 	unsigned short *d = (unsigned short *)
 	    (vc->vc_origin + vc->vc_size_row * line);
@@ -1827,7 +1826,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 
 		case SCROLL_REDRAW:
 		      redraw_up:
-			fbcon_redraw(vc, p, t, b - t - count,
+			fbcon_redraw(vc, t, b - t - count,
 				     count * vc->vc_cols);
 			fbcon_clear(vc, b - count, 0, count, vc->vc_cols);
 			scr_memsetw((unsigned short *) (vc->vc_origin +
@@ -1913,7 +1912,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 
 		case SCROLL_REDRAW:
 		      redraw_down:
-			fbcon_redraw(vc, p, b - 1, b - t - count,
+			fbcon_redraw(vc, b - 1, b - t - count,
 				     -count * vc->vc_cols);
 			fbcon_clear(vc, t, 0, count, vc->vc_cols);
 			scr_memsetw((unsigned short *) (vc->vc_origin +
-- 
2.41.0

