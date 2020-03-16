Return-Path: <SRS0=SyHF=5B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83382C18E5B
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 06:59:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5870B20575
	for <linux-serial@archiver.kernel.org>; Mon, 16 Mar 2020 06:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgCPG7O (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Mar 2020 02:59:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:34804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729719AbgCPG7N (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Mar 2020 02:59:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B45B1AD5C;
        Mon, 16 Mar 2020 06:59:12 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/3] vt: use min() to limit intervals
Date:   Mon, 16 Mar 2020 07:59:09 +0100
Message-Id: <20200316065911.11024-1-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Instead of awkward ternary operator with comparison, use simple min()
for blankinterval and vesa_off_interval.

No functional change intended and "objdump -d" proves that.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/vt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index c4d75edde923..e0d2cb93f6cf 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1927,7 +1927,7 @@ static void setterm_command(struct vc_data *vc)
 			update_attr(vc);
 			break;
 		case 9:	/* set blanking interval */
-			blankinterval = ((vc->vc_par[1] < 60) ? vc->vc_par[1] : 60) * 60;
+			blankinterval = min(vc->vc_par[1], 60U) * 60;
 			poke_blanked_console();
 			break;
 		case 10: /* set bell frequency in Hz */
@@ -1951,7 +1951,7 @@ static void setterm_command(struct vc_data *vc)
 			poke_blanked_console();
 			break;
 		case 14: /* set vesa powerdown interval */
-			vesa_off_interval = ((vc->vc_par[1] < 60) ? vc->vc_par[1] : 60) * 60 * HZ;
+			vesa_off_interval = min(vc->vc_par[1], 60U) * 60 * HZ;
 			break;
 		case 15: /* activate the previous console */
 			set_console(last_console);
-- 
2.25.1

