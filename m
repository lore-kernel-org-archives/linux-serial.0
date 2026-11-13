Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794594652;
	b=DWl9wifXbSouYiinvMZ/ueH2H3zaJicFqD5LJsH58DTa5PJkY9vlZfNckLtAq1Yj/n2z
	 oM/y4v+ESfBp/bD3zyg6LwGf6vmNRY5jkNtcHCIYDbO+f14iIOwllrwkJGkJcWV4rkjAz
	 K0/pFRHWsD1JjZn+8hZbHt7ZXza7nIecxYA4rdFU5MYeNjp5FowjsNRKQElPNh/2LDT6L
	 YVBJEc/0e1LvWlcU/cRKxOrpACdIvP8uamvwAjoaU+dpluISjabgyx9uJIM2vsv6hU5GS
	 3oA6BuHsASTzJMInpbaCIyao1rArj0sBigPgnae/JZuBWecavnD3XDhohOaBSRlhDxA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594652;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=4vJHIfTjBZrSqRs84PA3swbTzCWdc/YdUUp0BkXWtRA=;
	b=FRh6uJgVEBxN1s0wc2ZBdakujQ8xQENChTamSZfzEHWK75xUL8OSAAGk7Rj61RWMTNnM
	 Wb7Qhi93yxobUeAVqO2pG/kGBuAHH/LBxuquQCkFoVr+VJaVio08BmozZMMCHmaEYDrru
	 kCIB4NTjxdULopkDROKwqpcza3IJdpG2ujB2QG363907qitm2olmmBAlUEvugm9/weyGv
	 otJ0moHJbAyMZKwreGaPD/44gJpLvNHYxuhlZMk2KWyJMMrDvt4k7LYfBV82n+5q6I+Na
	 levYSck0PzITJNFK4k2gYCdYakNYlgOwHJQLcKqhmMKZ12wGWviWswN1kBUQo6BedLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=kUK6vEwT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.52
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011052.outbound.protection.outlook.com [52.101.125.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD00606C156;
	Fri, 13 Nov 2026 18:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FD00606C156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=kUK6vEwT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oK/7GvBasN3IJAiLei7yXmwe07AcWd8rLxPU2fNdTCihwhhMfHc6kZw7j5OedJiztOztjUog6ZwgFWztm1twAzIsf2/9wypUNALt249YKLUltt3+pwG9aVWn2dzVb9qg10EEHKxB7xbly84D2uEnMgQfIomOPz5INoR82xbs87By4UljPKUPuoGS+02DpnFBZYRFD3CxOcvDPD9VQ5WkC2Z/nQoix4LsYUG4qzFqBq0NlP/FZEWuXdWCt92x1+GenFTJtk2SqAniYWFT8ZP25PHHLV7OsSG+EkhhC/oE/OO0TVDuFLOv3ircKPFTx/+LQPvUkTA3mn9D46Nm2ls3XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vJHIfTjBZrSqRs84PA3swbTzCWdc/YdUUp0BkXWtRA=;
 b=PGgWyOU5oHpIkotdVenxlJfUnL6DwS9aV3gce6f8itUALUW547/l9odrRXk2+i89yNf/lH2XelXe4Ga9/Jopx6kcpRqq94AVM/GQSYGLtGpN01x/S0tFAkobI4XB+PDIHaJywzrANnh776Zmd6UDTGbi3p/fD5IrIAzq8e4K/aCGwL9N6T2+MMME2UhrDwdgDVyv70FfW6dDN3yNJss6KIuVRKH3hO4qHT5k5+N9g//j8z2zRIWtg9f0wTi39frgQWa3atmTba4q5EabHJ1YUaJRztsJZ8HZT5DdxTB36lDJaG1tTPJ7vRPq3vFtbajZI3EZQfDEqXuIQlVBucZk2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vJHIfTjBZrSqRs84PA3swbTzCWdc/YdUUp0BkXWtRA=;
 b=kUK6vEwTBfIQ3Fd8uRETw/wUpRRmBID3yit7JFaFtMuQ0OOfYKu+GTh8s75RwerxppU89gFzwbhiskVdnCduSyrq5JsOByFZi0JzjwMCV98uz3MpmK+wsKLpe+FRadm87FBhtOooGFl0SIQqYJbOSlQvWt0SUPcNDyAJhiF65Eg=
Received: from TY4PR01CA0095.jpnprd01.prod.outlook.com (2603:1096:405:37d::6)
 by OS3PR01MB8459.jpnprd01.prod.outlook.com (2603:1096:604:196::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 18:30:48 +0000
Received: from TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37d:cafe::30) by TY4PR01CA0095.outlook.office365.com
 (2603:1096:405:37d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Fri,
 13 Nov 2026 18:30:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY2PEPF00005624.mail.protection.outlook.com (10.167.240.55) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 13 Nov 2026 18:30:47 +0000
Received: from [192.168.1.82] (DEU-5CG2204K0P.adwin.renesas.com [10.226.92.17])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id F2596300022F;
	Sat, 14 Nov 2026 03:30:43 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Fri, 13 Nov 2026 18:26:31 +0000
Subject: [PATCH v4 6/7] serial: sh-sci: Toggle TE when restoring SCSCR in
 console write on SCI
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-g2ul_sci-v4-6-6815e41d90c5@renesas.com>
References: <20261113-g2ul_sci-v4-0-6815e41d90c5@renesas.com>
In-Reply-To: <20261113-g2ul_sci-v4-0-6815e41d90c5@renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
 Au Dang <au.dang.jx@renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, 
 Diogo Ivo <diogo.ivo.sx@renesas.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794594615; l=2241;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=nKabjfi1EzAXMex4ZAkhy43nKOXD21xB+BkR9Fs1Iho=;
 b=pkj32z6+iYYFqurqsG3BkOwLr2ig23KIh/cMp39s6uUA2+w1bUea75aD7mupQQZuPtKkHQgDv
 jHmRT6IMQ3cCRNWkBaIV8pGL/FGvCNbFIPRtc6lxR+mi58Fw+VyNqcw
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY2PEPF00005624:EE_|OS3PR01MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4eba41-93ae-40e2-92f4-08df41b43cc8
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|5023799004|11063799006|56012099006|261022105027099003|261028144727099003|261026140227099003|261022075727099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	+W8GPur1WJauGQ1hvGIUa86g8OSOH/wjyPFkbhVtLJknw4odAu91TdeRznd8bHWSNun0tWsAg3FJ8y6QXH1ZIOb2dp12J72inVGIiOMgSVmxeDGDm40hfb9/KKfYsheJ/uANsbBRQv8DjDFxaR5jqpodujPAnUU93Fq8CNInIH7ReAA+rxk3tIlGhdXbDVNBVBBO7IW9cn94qdsc0ocyErmerrANk+HZUKXZYv9QlrqMh0vlli1K4qYC2DoAbELC8fR7Z+1H+o+We8f47ZO5hhY4B0wAM8/gVZ2SvBkCkYEFwI7RRifiVkyhc38SOH2gVrSO1zwfrieEQofpjUbAMLyjwEIKy472dZlfxxLK7pKmu3m0r5K88DtoiATkiuOHoH8FHqi1/PUr0Si6n0iCy65lCQYCUIVBl0tkBF2mDvKNp8lVVNv/ir9PqiMUCI5V05YIAIqH1J6S4giE1r69uuhhmixtXRqmb8yGmSqFPdOJ5gY7ZS/4hbPrGumCjgTBS5xou03EtwP3J+E7pnehJTYhW9OBSyFc3Co1AFde08JuzKGr61+/+5UwoiAmQHPz8b6V4hlAVPaCcBNM0MIUSmfR3ESzBFpX2NSgq1+BdURxisGaCgUHIB06hDxgIT1Ae4x1jlwMursK46FR5TvS7myeBnUaicHDvCFUaTGsGEFDFldN5ugfjB+tE31WX3G3NaJCz5XS53wXmYblA7SorQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(5023799004)(11063799006)(56012099006)(261022105027099003)(261028144727099003)(261026140227099003)(261022075727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1nyjP76bytSVbhC9frS/dCWFnUa6I/tjCrzgxuJ8ci9/BIdyr2U9gxyXkqxrsQWXw29gtqI7fteOI6KInLCXze1HxS4J8jluYLASdiW11q35GxYPm4xExcDGAk/TMwRXtQda6QX9hq0s6ybhexAA8oGVEfgXwcNXYlvW3OD8NcHNRxeXGfS+AgtAxYT9gtCXE5NKQy3pceD3KaZJ0g7F8IzI6beBD08Bh95cMqWp2SPw24DSTkNOk5zqvBDZl7zOL87iAwVQ7Qq5YILS8iA5sGfFaycmlzocx1MyuNM5ytKAkOkA/kJtJLWkyefgxyNNFNX74/osXobcnczPvmzZceU1d2OR5hIsGVoCnJGBvN4AJd4F2RQS63CeAogS6mz36gtvwL9CmhkhS7sqSL7zd14ymmAjGrB/N+Npann7xg3CHbDNWCQ3RIQNlIwB7gVV
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:30:47.9094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4eba41-93ae-40e2-92f4-08df41b43cc8
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY2PEPF00005624.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8459

From: Au Dang <au.dang.jx@renesas.com>

When SCI0 (PORT_SCI) is the system console on RZ/G2UL, the board can
hang at the serial console output stage during boot.

ftrace shows the following sequence:

1. sci_transmit_chars() is draining the TX kfifo through TXI
   interrupts with SCSCR=0xf0 (TE=1, TIE=1, RE=1, RIE=1).

2. serial_console_write() runs in the middle of that drain. It saves
   SCSCR=0xf0, switches to polling by writing SCSCR=0x30 (TE=1, TIE=0)
   and outputs the characters with sci_poll_put_char().

3. It then restores SCSCR=0xf0 in a single write. TE is 1 both before
   and after, so there is no TE transition.

4. sci_start_tx() is then called repeatedly with SCSCR unchanged, but
   no TXI is ever raised again, so the drain never resumes and the
   console hangs.

The RZ/G2UL User's Manual (section 23.3.6, "SCI Initialization") notes
that changing SCR.TE from 1 to 0 or from 0 to 1 while SCR.TIE is 1
generates a TXI interrupt request. Without a TE transition, the TXI
that would restart the drain is never generated.

For PORT_SCI, restore SCSCR in two steps: first with TE cleared, then
with the full saved value. This forces the TE 1->0->1 transition while
TIE is being re-enabled, so TXI fires and the interrupted drain
resumes.

Signed-off-by: Au Dang <au.dang.jx@renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
 drivers/tty/serial/sh-sci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index fc77536644ed..2d667086ec3a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3456,10 +3456,14 @@ static void serial_console_write(struct console *co, const char *s,
 		cpu_relax();
 
 	/* restore the SCSCR */
-	if (sci_port->ops->finish_console_write)
+	if (sci_port->ops->finish_console_write) {
 		sci_port->ops->finish_console_write(port, ctrl);
-	else
+	} else {
+		if (sci_port->type == PORT_SCI)
+			sci_port->ops->write_reg(port, regs->control, ctrl & ~SCSCR_TE);
+
 		sci_port->ops->write_reg(port, regs->control, ctrl);
+	}
 
 	if (locked)
 		uart_port_unlock_irqrestore(port, flags);

-- 
2.56.0

