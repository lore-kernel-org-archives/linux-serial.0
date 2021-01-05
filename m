Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F44DC43381
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 12:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E7922B3A
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 12:04:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbhAEMDj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Jan 2021 07:03:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:38668 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729885AbhAEMDW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Jan 2021 07:03:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 690EAAD75;
        Tue,  5 Jan 2021 12:02:40 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 04/12] vt: keyboard, defkeymap.c_shipped, approach the unicode table
Date:   Tue,  5 Jan 2021 13:02:31 +0100
Message-Id: <20210105120239.28031-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105120239.28031-1-jslaby@suse.cz>
References: <20210105120239.28031-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Commit 5ce2087ed0eb (Fix default compose table initialization) fixed
unicode table so that the values are not sign extended. The upstream
(kbd package) chose a different approach. They use hexadecimal values.
So use the same, so that the output of loadkeys and our shipped file
correspond more to each other.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/defkeymap.c_shipped | 68 +++++++++++++++---------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/tty/vt/defkeymap.c_shipped b/drivers/tty/vt/defkeymap.c_shipped
index cac1fcbd55c7..094d95bf0005 100644
--- a/drivers/tty/vt/defkeymap.c_shipped
+++ b/drivers/tty/vt/defkeymap.c_shipped
@@ -224,40 +224,40 @@ char *func_table[MAX_NR_FUNC] = {
 };
 
 struct kbdiacruc accent_table[MAX_DIACR] = {
-	{'`', 'A', 0300},	{'`', 'a', 0340},
-	{'\'', 'A', 0301},	{'\'', 'a', 0341},
-	{'^', 'A', 0302},	{'^', 'a', 0342},
-	{'~', 'A', 0303},	{'~', 'a', 0343},
-	{'"', 'A', 0304},	{'"', 'a', 0344},
-	{'O', 'A', 0305},	{'o', 'a', 0345},
-	{'0', 'A', 0305},	{'0', 'a', 0345},
-	{'A', 'A', 0305},	{'a', 'a', 0345},
-	{'A', 'E', 0306},	{'a', 'e', 0346},
-	{',', 'C', 0307},	{',', 'c', 0347},
-	{'`', 'E', 0310},	{'`', 'e', 0350},
-	{'\'', 'E', 0311},	{'\'', 'e', 0351},
-	{'^', 'E', 0312},	{'^', 'e', 0352},
-	{'"', 'E', 0313},	{'"', 'e', 0353},
-	{'`', 'I', 0314},	{'`', 'i', 0354},
-	{'\'', 'I', 0315},	{'\'', 'i', 0355},
-	{'^', 'I', 0316},	{'^', 'i', 0356},
-	{'"', 'I', 0317},	{'"', 'i', 0357},
-	{'-', 'D', 0320},	{'-', 'd', 0360},
-	{'~', 'N', 0321},	{'~', 'n', 0361},
-	{'`', 'O', 0322},	{'`', 'o', 0362},
-	{'\'', 'O', 0323},	{'\'', 'o', 0363},
-	{'^', 'O', 0324},	{'^', 'o', 0364},
-	{'~', 'O', 0325},	{'~', 'o', 0365},
-	{'"', 'O', 0326},	{'"', 'o', 0366},
-	{'/', 'O', 0330},	{'/', 'o', 0370},
-	{'`', 'U', 0331},	{'`', 'u', 0371},
-	{'\'', 'U', 0332},	{'\'', 'u', 0372},
-	{'^', 'U', 0333},	{'^', 'u', 0373},
-	{'"', 'U', 0334},	{'"', 'u', 0374},
-	{'\'', 'Y', 0335},	{'\'', 'y', 0375},
-	{'T', 'H', 0336},	{'t', 'h', 0376},
-	{'s', 's', 0337},	{'"', 'y', 0377},
-	{'s', 'z', 0337},	{'i', 'j', 0377},
+	{'`', 'A', 0x00c0},	{'`', 'a', 0x00e0},
+	{'\'', 'A', 0x00c1},	{'\'', 'a', 0x00e1},
+	{'^', 'A', 0x00c2},	{'^', 'a', 0x00e2},
+	{'~', 'A', 0x00c3},	{'~', 'a', 0x00e3},
+	{'"', 'A', 0x00c4},	{'"', 'a', 0x00e4},
+	{'O', 'A', 0x00c5},	{'o', 'a', 0x00e5},
+	{'0', 'A', 0x00c5},	{'0', 'a', 0x00e5},
+	{'A', 'A', 0x00c5},	{'a', 'a', 0x00e5},
+	{'A', 'E', 0x00c6},	{'a', 'e', 0x00e6},
+	{',', 'C', 0x00c7},	{',', 'c', 0x00e7},
+	{'`', 'E', 0x00c8},	{'`', 'e', 0x00e8},
+	{'\'', 'E', 0x00c9},	{'\'', 'e', 0x00e9},
+	{'^', 'E', 0x00ca},	{'^', 'e', 0x00ea},
+	{'"', 'E', 0x00cb},	{'"', 'e', 0x00eb},
+	{'`', 'I', 0x00cc},	{'`', 'i', 0x00ec},
+	{'\'', 'I', 0x00cd},	{'\'', 'i', 0x00ed},
+	{'^', 'I', 0x00ce},	{'^', 'i', 0x00ee},
+	{'"', 'I', 0x00cf},	{'"', 'i', 0x00ef},
+	{'-', 'D', 0x00d0},	{'-', 'd', 0x00f0},
+	{'~', 'N', 0x00d1},	{'~', 'n', 0x00f1},
+	{'`', 'O', 0x00d2},	{'`', 'o', 0x00f2},
+	{'\'', 'O', 0x00d3},	{'\'', 'o', 0x00f3},
+	{'^', 'O', 0x00d4},	{'^', 'o', 0x00f4},
+	{'~', 'O', 0x00d5},	{'~', 'o', 0x00f5},
+	{'"', 'O', 0x00d6},	{'"', 'o', 0x00f6},
+	{'/', 'O', 0x00d8},	{'/', 'o', 0x00f8},
+	{'`', 'U', 0x00d9},	{'`', 'u', 0x00f9},
+	{'\'', 'U', 0x00da},	{'\'', 'u', 0x00fa},
+	{'^', 'U', 0x00db},	{'^', 'u', 0x00fb},
+	{'"', 'U', 0x00dc},	{'"', 'u', 0x00fc},
+	{'\'', 'Y', 0x00dd},	{'\'', 'y', 0x00fd},
+	{'T', 'H', 0x00de},	{'t', 'h', 0x00fe},
+	{'s', 's', 0x00df},	{'"', 'y', 0x00ff},
+	{'s', 'z', 0x00df},	{'i', 'j', 0x00ff},
 };
 
 unsigned int accent_table_size = 68;
-- 
2.30.0

