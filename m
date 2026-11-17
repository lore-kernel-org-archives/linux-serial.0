Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794958878;
	b=j/SJcQTaCmBKbubB28WWIaBrY8vrdYFKLhn2/gWuzvfa2Kb75faAvYo7vgk8zWosRSr9
	 F1nNZMPjkYtqz+mj2myhtb0HNvEtOvb7uzbSCBh+YnmuL2UnUeitWimks1Tzb3zLzc14O
	 OOycThQAfmHUoTOspGXhctGq59Dk3hSaXpRCn6cgu2jmfAesiAwujYWcMIkW6pGKFHSQW
	 EbMvZtnZCeYYUCmo4sH/4/jNF5ZgGIWkTpcIZym5mdEwSe3gVcBNaos3c8uIDsLHP5Wy5
	 2OyCKDEZHBk2gWNEo+rbh6zhvURHQjfYKRqwq8ZLcxJMx1lcH6QbDRcNyXfRrZTRDig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958878;
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
	bh=i/mbN6ss28Qp8rk9L174RtW7ybkTuPSmDMTXIezi/0M=;
	b=vsfPB94qWwqrZn6m0OoYVnRxNskvmPOsZnXagoxbM397Wy7HoURPqOv7MyuFy6WsAr3H
	 4AYFglnb4AElBenUsP7EGzGe9e6E8ZaQHO+JMo4gcK+e9y4P2z17CzC6MM+L1h2S+34tL
	 kb4F3pC8mg0nzvzQP+QpEM5OMmURqhy4O4r9ItUAesxmWPtK864F0mAJSaPdPR5qWRTXq
	 thvBMPRIs8bw+8qjC+VvK4smqCv+O51XwrmEDIt5wkukKyYyLEvuyhAdpQPhnwxvRScO9
	 5NywK67fEYFLgwU563knre9plfNuCvEjmhhX7HldwgPO1ZZGROPk2KeOXNfJSXXLWXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=kGN1y0YY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.125.47
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011047.outbound.protection.outlook.com [52.101.125.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D11A606A32C;
	Tue, 17 Nov 2026 23:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D11A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=kGN1y0YY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ieo1kH5FyofQGTz3SY/AY/wC42n+UmZnUw5coRmzL9BDrTot/xLYwbfcgVYfnZKeztKI58on2xQWBmk4TTUDl5gzf+7FWG8GxpaaGvyOionVojc6+j+mLGyhgYicFRm7xVRc3LJ2zYwaPfN82ke/c7xKudFq1nsKZHuswVZE0GuOM0HZ3XFaYluhsrA/+c9j74dR/Pvn6V3pwQE9leVWsXeyNTsnrVk0zjC/tb3BF7537iPV+8ZqdaEfG65/bPFx9gQ1h+ezH/7UQFAejCFsp1evvy7JSoS7cDLMVOHh/U1LFBQEjXpfwpXJn/h6NHTskazPaRKYNXECYqucm2/NZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/mbN6ss28Qp8rk9L174RtW7ybkTuPSmDMTXIezi/0M=;
 b=VusJRxnLXnCHu9vAuy7qceUk3Z938JRfemCmXmqYP5FZtQ5JJkJB6xb6W+yC0504pHfLbHll3K20P0Enc3Eg74A6ZCj2LGg0wof3QAbOTyNCAZ8cokv6AUTT1CMYR4cjDnuXvIDaDKGo5jGuYZgkxTpuIkVQfttXpOvjturUc/6olvUtbLoPzsTn25nwN7r9dQSXfbvTkEVKR/of8xl9Um9jZzKgi2qjV8GiOkAbq5b5Pp6KXtjc5jlTnPW0deIajlOSSBLSaEJUbUPYVF8e+kpHkdyvPWbmXzuic4mrkUEjrzDypemPqJqiwcXAOEU06Etl1Ioh3RERRuz0VozP2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/mbN6ss28Qp8rk9L174RtW7ybkTuPSmDMTXIezi/0M=;
 b=kGN1y0YYkPAqh7NVMqfCqv9soIp0igHLySKmn7XSHT9KIEgPPbNYJU1ywH3X1xOeiOZV5pC1J2/aBYUBI/FnUn/h/8y3wjLIExnnFh/bLU3WuG5ygPOufBj9sdf5rAoHTYh/4UHPVG77JB/iQfch35pQDeCQEopZaVWnZU7SfAA=
Received: from OS3P286CA0036.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f5::10)
 by OS9PR01MB17878.jpnprd01.prod.outlook.com (2603:1096:604:448::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 23:41:14 +0000
Received: from OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f5:cafe::53) by OS3P286CA0036.outlook.office365.com
 (2603:1096:604:1f5::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Tue,
 17 Nov 2026 23:41:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20E.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Tue, 17 Nov 2026 23:41:13 +0000
Received: from [192.168.1.82] (REE-0069499.adwin.renesas.com [10.226.92.1])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id ACE82300025C;
	Wed, 18 Nov 2026 08:41:09 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Tue, 17 Nov 2026 23:40:36 +0000
Subject: [PATCH v5 6/7] serial: sh-sci: Toggle TE when restoring SCSCR in
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
Message-Id: <20261117-g2ul_sci-v5-6-30b58ea18923@renesas.com>
References: <20261117-g2ul_sci-v5-0-30b58ea18923@renesas.com>
In-Reply-To: <20261117-g2ul_sci-v5-0-30b58ea18923@renesas.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794958839; l=2241;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=8nlWEYWe2a5oIY6NZJWeOeYcEiZkiLDyU9U1AI3xKCI=;
 b=uVGyqeWAFYFZ5C7GKMRKbVVfraG1ozxj2h0Y5yK8nlW9qbVcHz4UCwaBE+Dn9XoptXQtpmF/H
 lJhbU87gpMcCC+YhKYeh+09LrXonJLfdUQ97+1iGWHlVcTeNk5qZjqV
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20E:EE_|OS9PR01MB17878:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a209fb8-4908-440b-8b78-08df45044471
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|6133799003|22082099003|261009223027099003|3023799007|11063799006|5023799004|56012099006|261028144727099003|261022075727099003|261022105027099003|261021123027099003|261026140227099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	Ch8f/sfu8ePQd7KLchEv1BgW2pyigoCQGw8ZH499H52WBbfgJLn9A3gNuvXXmPuRci1dYub2/6Q700o2ZxEekxqE7wiY6wWeNsO00WjJawwYlvPx9LIfgIbgEOiLB2ciyx6TU24//+iD18MmEEkqetRriHULav4fz+WDvpadTO1AFD7ZBqZOhNm2ym3Ie0Nwn1ELjNL5oz9BnFD0uW2qhPlJx+4dNG802ZnK6rv4ufpq7T4Vhen3AnJYoF5ZqVqATfIcDbchz+iAlA6cLr4Z0nEgyzQKgY4KiEUaZbNJIMHujaYz1qzfAKM3cnzezGtJpW4b9l3kP+y+ZU7dip3gFUInZzEjOVsTrvnbVLfYCVC7HEdFobC5F42PkCzX1nhtkd5WyfVYHE1SmaTbAHDDMm2U6L1hCIC7s5VZAHGgZgNbRA1x+SrsjkJpEfSQz0qZ7JM91dNz8H0RsPwacQ+M3UAT22dZek+JSOkzZNJnySsuT9UaHwpd0ciCTAPZIWEWF96MsEtjMENEu0SNdYRDRuo1RgNjurYM+oZfQ97dU3EW5cvVyLe53YgXW5k78w+Sct1/1WdVXMcC8Rs0cq0XJXmUsGBiEtuM6JYvMM5GZnOb1XUXr/66VcjRfYQ5c2YeNXduizKR2lAH8Cq7ZDhITCjf5l/m4WyByQhPsdWqRIKsnf1ifm8eckGgPrwZyg6PPFl/ylSWG7Cv3g30sYDKQA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(6133799003)(22082099003)(261009223027099003)(3023799007)(11063799006)(5023799004)(56012099006)(261028144727099003)(261022075727099003)(261022105027099003)(261021123027099003)(261026140227099003)(261021121427099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UzP9grPOW7hpldaEv1XHdycodV2Cop+YGCJB2G1o6B3QXWFv50YvDN1UttLSnI/H43cA2ludz1Hy00CcSuMpDywXjClSwdJGh66x/f8AaQg0SrPBIfYasPYrx0xnQ7nff9arQrGp7y0a8T/oS47qTUDnAaWEJ1+W4Sh3et9dUp6cL3nsARAAESwGwwBrx7ltSDT7/iwoah7WVPpr200w998jw/KykdmY+EzCvKI0UI7VnLFIhEurkj1Vu6v082qhRg+xadQSLv5n4Ra+NG39NqDpKV4fRDit7fqljd/UTumVxU9X/DFjS7pY+BBrB2X+0/f2s9yRwQerPQmzs9et5BpIZcdXeuuZnXcVWQWCTjiM6vT+RnDzNnV9jFJDwH95WhiDOK3rOPlknRF/7T/9fL7OzM/J+oTk4PqMeK0PJdjGoC0VWOCmudiLVy6c1k8a
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 23:41:13.9752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a209fb8-4908-440b-8b78-08df45044471
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17878

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
index 93440fd8c2bf..f5194cfa3364 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3452,10 +3452,14 @@ static void serial_console_write(struct console *co, const char *s,
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
2.56.1

