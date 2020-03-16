Return-Path: <SRS0=SyHF=5B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEECFC0044D
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 06:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930E820575
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 06:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgCPG7R (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Mar 2020 02:59:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:34812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729723AbgCPG7O (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Mar 2020 02:59:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 07550AEC4;
        Mon, 16 Mar 2020 06:59:13 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/3] vt: selection, use rounddown() for start/endline computation
Date:   Mon, 16 Mar 2020 07:59:10 +0100
Message-Id: <20200316065911.11024-2-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316065911.11024-1-jslaby@suse.cz>
References: <20200316065911.11024-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

We have a helper called rounddown for these modulo computations. So use
it.

No functional change intended and "objdump -d" proves that.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/selection.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 582184dd386c..d54a549c5892 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -252,9 +252,9 @@ static int __set_selection_kernel(struct tiocl_selection *v, struct tty_struct *
 		}
 		break;
 	case TIOCL_SELLINE:	/* line-by-line selection */
-		new_sel_start = ps - ps % vc->vc_size_row;
-		new_sel_end = pe + vc->vc_size_row
-			    - pe % vc->vc_size_row - 2;
+		new_sel_start = rounddown(ps, vc->vc_size_row);
+		new_sel_end = rounddown(pe, vc->vc_size_row) +
+			vc->vc_size_row - 2;
 		break;
 	case TIOCL_SELPOINTER:
 		highlight_pointer(pe);
-- 
2.25.1

