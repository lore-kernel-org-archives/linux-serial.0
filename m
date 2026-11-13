Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794594656;
	b=rLVsUwQOe14IKfyG3Ly7CpSyYpdOpjxjrEodOAnfPnPFg7kx1FdPp5DFes0ZI6z3wM5k
	 aKLVYtqZMS7t+nWMDsXSNBBK3O4MMnHV8LsVT2MgfZUGkpVOU5ri5Pcngk/ho5ql0dNt9
	 neJhNIswct+OZvRntC3CyZ6birj6th+BJ1V1FmSWsond86GQxa6TzAzN2HjXAYFTlVc1I
	 wD9IfSEgYIrGnZ/GGWDphRfnoqfjleYIYZZnw94U5a/uHuAt0S4FZlDW1y8M9ow2HDdej
	 G0WKYFvi1rnuMqjeeIUgbQN8ep+UqJ/SIGOzRJ641lb3gXcXuaGahkqO3q+ro2lVxzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594656;
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
	bh=YTSElj2jdkxpuz95OPglG6YffdRKvn5KcVtiKLyIUaY=;
	b=ar7Ie2nv3Ovvz7tZ4ViOYAMy4jjtr//9rLXw4LUMuL/x4fH9/W3RVYcmmlxZ0B8O0fID
	 UWBfOYd8PUhG4xAng3kIUkgUHhVRQa9uupbJuoPB9D/q+4OaRQl9N7YJ4WF1OD09IX27a
	 L+oprz57T0vw5GaZyISix7tnzPeYn78uu2ewVtQULPn5YfCDwN6gLIwYXfRFiX+qj9Aua
	 j8TOcN1bUMdtU40xss3E+WuYph87EeoHPhznl5KlJNuWKfxE+lQavnHSaP6aOGH380meQ
	 oY/Ihq02GgxB0xzHK2e/AusvFO6C4pcjwn+dM/H5g7AWXQiFIBNYRkbp3CZGlXtT+Sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=I7M1AnNK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.35
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010035.outbound.protection.outlook.com [52.101.229.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2E2606D65C;
	Fri, 13 Nov 2026 18:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C2E2606D65C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=I7M1AnNK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=unfUT3Wzt/wM/zydhMiysvpROTiZV19YEPWLD/HCjryS5P5O6mrmgx8HJUhPbfFrp4wmkHeL6JdzYd5BP8GM32IH8eQnH6OCC9vuFdQgNCtUlaRhMxQUKEIWZ69H1T8qaaEXs8WEV5CeWk4j8R0HJkQNZFHNTse7gLjorEC6aylDlcLvmH+XU3al1n1ITsqOObeBJ+ZLzIAMVUQzKQkUTj9odkGbdcySidOG0xFK7qZu6Gm8V713vOtBf2ayZnIgxEPsdkSsExnr6vLSXattnMXQcNlytRWhesF1pFr+ZPDHJgrI2sOAaLP5jk7w+RrIe61Awji0qzhu667W+2eauQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTSElj2jdkxpuz95OPglG6YffdRKvn5KcVtiKLyIUaY=;
 b=HTXaSThj0kzJue1ykTyc5IobZdfU6CiJPmk5b9e5EqlJCbFx/Z8/zefXv3wp6U25iwIQAG6H0g6/ELwdQeRQ85qhsKCvOq96ZNqaI/1BLMpvjoGkyWoiwc05begBgSTEAOWwOSJIBq4gRobKA2r4tX9Tc1HYkAcXB3aBvkAJT50gCdt/c5FpPfr+dEifeiUX610g6JPzBcbwF1cfpgAuYzk47j3u1qrohhiJhmQbKhNS9mRc/LJ6OcVAZzr8r+tFz4lg5N19DljRO/RLa9MyF+hfVqxqfES5cknv51qoVf/5Qla1wFEi+e3m7UTE84epAMiPCyE49GFXKVVcWRKftA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTSElj2jdkxpuz95OPglG6YffdRKvn5KcVtiKLyIUaY=;
 b=I7M1AnNKXJKvwrEmtSnqjITqOza52Driz7XMGELj4zWefTq7F+7C78WzYYTBqk1HdcnsBCm5oenoDdMhCi9NidYQ0uWHSJCrmNHMDskHg3fyJxnbEFJ+WY/JbDV7l3V84xbURP6BxiARL0gdY3oho7dWDt6Ijwc6CDe1Z7+FDkI=
Received: from TYCP301CA0052.JPNP301.PROD.OUTLOOK.COM (2603:1096:400:384::15)
 by TYCPR01MB6881.jpnprd01.prod.outlook.com (2603:1096:400:b4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 18:30:52 +0000
Received: from TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:384:cafe::6e) by TYCP301CA0052.outlook.office365.com
 (2603:1096:400:384::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Fri,
 13 Nov 2026 18:30:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005025.mail.protection.outlook.com (10.167.240.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Fri, 13 Nov 2026 18:30:52 +0000
Received: from [192.168.1.82] (DEU-5CG2204K0P.adwin.renesas.com [10.226.92.17])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 60CCA300022F;
	Sat, 14 Nov 2026 03:30:48 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Fri, 13 Nov 2026 18:26:32 +0000
Subject: [PATCH v4 7/7] serial: rsci: Simplify rsci_transmit_chars()
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
Message-Id: <20261113-g2ul_sci-v4-7-6815e41d90c5@renesas.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794594615; l=1730;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=axrigT/XHR3TLHRag975wKOGC5riYRLffXBhzaw5qpA=;
 b=zmdgHlogCJDcQB7nBwlmR99a/OLQdPkcGFLeMwSOy22QtDMu8WY1+RJz39D6HlwyHwMUeQLCr
 C1HB8bT0bxbBha+D0I06d1kHrQC+vrNaGfagJC98kAX+Z0aH/33Hgy8
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005025:EE_|TYCPR01MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f69cbd-0622-48b7-78bf-08df41b43f79
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|11063799006|5023799004|56012099006|261022075727099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	QZDqXGEVYY6j8NCKIf3XTpY3J8+uz8Z5oo62FNK3skBjwxhC/AXCTZnVNwwGBHVGKkBUoFuqmt8yO0h+5x++y8BU+iGamlLu8yxy85icRwX5MzzLQgQbymh/BD32S2ymUKixmlcd86XnYI+OjNBMTxRFEhq095A3jT08kxCZDoHBDhc0bpwFKHkL5RP8ZgIbapaJEmDeA2j2Fwd2qD6LQ1usKzZG4FesT2OLx1ef2n1+G/ydoHghjtEsYORAz00e/mIT3tCmZN2KU9WSWWhYN1tDSKLQDvRGlQmt3qL5oJkoLzFCvHms9fcJ8uJULMpRguc7pJo5I9xnURbF1HTI/yfN+gUuwWtoBoiEBGy4h08snrTBs3/lr4t2hGSVj/WEpGrgRk+ggOv/0AX9KhfJu2BcTVVz8afDmpkuuT0BEXmcPBXbecJn3ndCAyzDfMIAD4cyjn/+1BSqN18wD0x46x/fp7gqTwXiWHRW6S53y/hMW35dSEtt3ttb2uumIme4dx45k7zzAe/whJvrbKYedKsfrG9Gfe/RExLGj0ZGEbSyEiRnurPmfLUVhixU1lkCZErueZzwgLhDPrREalX7hq5fit6EaETfUGBPn2Hdzy2ICEbliWbs3h6iq0WGfz4/i2cE/j/UlgyV6aL6VSFW8g==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(11063799006)(5023799004)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pDkotgIGX2dYHVCIoPFH34vmKqB9S4IZWog4/xpsAUVbPIz2oFwq8TvZfoby2VSmOVcxyltkNw7G6XZpVuOSuOcDmuEm4ilmk4v5PEfXq30475zL4KLvG9VFuy8yFznN0CyHAr4B4hD6bnXk9njTwJb98wRCzji67lZub4Ftkrpv+DtpKwY8n3DmD9cNQbwrgxuFh5ftmYhFJPv+f8cJA2RCFs/FCqCRiXM25ejIOr9PolAvS6QlRR+gh0LJTgQbTw2jfkwKJfj4ttpsni2MIHyvCc/+WXN3SNmr2jLjHBqsLtber/swfOYJmafISq9s6bpKkrt5i0VIyAzEOlafghJ84gC2pzUkq51zRj+ZUdF/oTlOoksM4kL0vHIHf7V6pzoGyZCoADvd3s2+PmhOnhk61aQ+ZoUAytzQgIv4vhI0EixseeMI/KVPObvvzCcV
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:30:52.4241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f69cbd-0622-48b7-78bf-08df41b43f79
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005025.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6881

Now that sci_er_interrupt() no longer calls sci_tx_interrupt() on RSCI
ports, rsci_transmit_chars() is only invoked when CSR.TDRE and CCR0.TE
are set.

Drop the redundant CCR0.TIE manipulation in the !CSR_TDRE guard and
call rsci_stop_tx() instead of open-coding the CCR0.TIE/CCR0.TEIE
update when transmission stops.

Signed-off-by: Diogo Ivo <diogo.ivo.sx@renesas.com>
---
 drivers/tty/serial/rsci.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 05703bb31afd..80087be11808 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -432,19 +432,12 @@ static void rsci_transmit_chars(struct uart_port *port)
 {
 	unsigned int stopped = uart_tx_stopped(port);
 	struct tty_port *tport = &port->state->port;
-	u32 status, ctrl;
+	u32 status;
 	int count;
 
 	status = rsci_serial_in(port, CSR);
-	if (!(status & CSR_TDRE)) {
-		ctrl = rsci_serial_in(port, CCR0);
-		if (kfifo_is_empty(&tport->xmit_fifo))
-			ctrl &= ~CCR0_TIE;
-		else
-			ctrl |= CCR0_TIE;
-		rsci_serial_out(port, CCR0, ctrl);
+	if (!(status & CSR_TDRE))
 		return;
-	}
 
 	count = rsci_txroom(port);
 
@@ -467,12 +460,8 @@ static void rsci_transmit_chars(struct uart_port *port)
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
-	if (kfifo_is_empty(&tport->xmit_fifo) || stopped) {
-		ctrl = rsci_serial_in(port, CCR0);
-		ctrl &= ~CCR0_TIE;
-		ctrl |= CCR0_TEIE;
-		rsci_serial_out(port, CCR0, ctrl);
-	}
+	if (kfifo_is_empty(&tport->xmit_fifo) || stopped)
+		rsci_stop_tx(port);
 }
 
 static void rsci_receive_chars(struct uart_port *port)

-- 
2.56.0

