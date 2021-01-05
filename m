Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450FCC433E0
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 12:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF7B022B43
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 12:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbhAEMDW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Jan 2021 07:03:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:38656 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729884AbhAEMDV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Jan 2021 07:03:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 30E92AD6B;
        Tue,  5 Jan 2021 12:02:40 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 03/12] vt: keyboard, defkeymap.c_shipped, approach the definitions
Date:   Tue,  5 Jan 2021 13:02:30 +0100
Message-Id: <20210105120239.28031-3-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210105120239.28031-1-jslaby@suse.cz>
References: <20210105120239.28031-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

loadkeys (from kbd) generates 'unsigned short' instead of 'u_short'
since 2.0.3. It also marks maps as 'static' for longer than kbd's
history.

So adapt the shipped defkeymap.c to conform more to loadkeys output.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/vt/defkeymap.c_shipped | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/vt/defkeymap.c_shipped b/drivers/tty/vt/defkeymap.c_shipped
index c7095fb7d2d1..cac1fcbd55c7 100644
--- a/drivers/tty/vt/defkeymap.c_shipped
+++ b/drivers/tty/vt/defkeymap.c_shipped
@@ -6,7 +6,7 @@
 #include <linux/keyboard.h>
 #include <linux/kd.h>
 
-u_short plain_map[NR_KEYS] = {
+unsigned short plain_map[NR_KEYS] = {
 	0xf200,	0xf01b,	0xf031,	0xf032,	0xf033,	0xf034,	0xf035,	0xf036,
 	0xf037,	0xf038,	0xf039,	0xf030,	0xf02d,	0xf03d,	0xf07f,	0xf009,
 	0xfb71,	0xfb77,	0xfb65,	0xfb72,	0xfb74,	0xfb79,	0xfb75,	0xfb69,
@@ -25,7 +25,7 @@ u_short plain_map[NR_KEYS] = {
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
-u_short shift_map[NR_KEYS] = {
+static unsigned short shift_map[NR_KEYS] = {
 	0xf200,	0xf01b,	0xf021,	0xf040,	0xf023,	0xf024,	0xf025,	0xf05e,
 	0xf026,	0xf02a,	0xf028,	0xf029,	0xf05f,	0xf02b,	0xf07f,	0xf009,
 	0xfb51,	0xfb57,	0xfb45,	0xfb52,	0xfb54,	0xfb59,	0xfb55,	0xfb49,
@@ -44,7 +44,7 @@ u_short shift_map[NR_KEYS] = {
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
-u_short altgr_map[NR_KEYS] = {
+static unsigned short altgr_map[NR_KEYS] = {
 	0xf200,	0xf200,	0xf200,	0xf040,	0xf200,	0xf024,	0xf200,	0xf200,
 	0xf07b,	0xf05b,	0xf05d,	0xf07d,	0xf05c,	0xf200,	0xf200,	0xf200,
 	0xfb71,	0xfb77,	0xf918,	0xfb72,	0xfb74,	0xfb79,	0xfb75,	0xfb69,
@@ -63,7 +63,7 @@ u_short altgr_map[NR_KEYS] = {
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
-u_short ctrl_map[NR_KEYS] = {
+static unsigned short ctrl_map[NR_KEYS] = {
 	0xf200,	0xf200,	0xf200,	0xf000,	0xf01b,	0xf01c,	0xf01d,	0xf01e,
 	0xf01f,	0xf07f,	0xf200,	0xf200,	0xf01f,	0xf200,	0xf008,	0xf200,
 	0xf011,	0xf017,	0xf005,	0xf012,	0xf014,	0xf019,	0xf015,	0xf009,
@@ -82,7 +82,7 @@ u_short ctrl_map[NR_KEYS] = {
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
-u_short shift_ctrl_map[NR_KEYS] = {
+static unsigned short shift_ctrl_map[NR_KEYS] = {
 	0xf200,	0xf200,	0xf200,	0xf000,	0xf200,	0xf200,	0xf200,	0xf200,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf01f,	0xf200,	0xf200,	0xf200,
 	0xf011,	0xf017,	0xf005,	0xf012,	0xf014,	0xf019,	0xf015,	0xf009,
@@ -101,7 +101,7 @@ u_short shift_ctrl_map[NR_KEYS] = {
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
-u_short alt_map[NR_KEYS] = {
+static unsigned short alt_map[NR_KEYS] = {
 	0xf200,	0xf81b,	0xf831,	0xf832,	0xf833,	0xf834,	0xf835,	0xf836,
 	0xf837,	0xf838,	0xf839,	0xf830,	0xf82d,	0xf83d,	0xf87f,	0xf809,
 	0xf871,	0xf877,	0xf865,	0xf872,	0xf874,	0xf879,	0xf875,	0xf869,
@@ -120,7 +120,7 @@ u_short alt_map[NR_KEYS] = {
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 };
 
-u_short ctrl_alt_map[NR_KEYS] = {
+static unsigned short ctrl_alt_map[NR_KEYS] = {
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,	0xf200,
 	0xf811,	0xf817,	0xf805,	0xf812,	0xf814,	0xf819,	0xf815,	0xf809,
-- 
2.30.0

