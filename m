Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.15
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794958884;
	b=dVll6A+W8s1i7HTQe4GdRgHSU1HD+D3VcvIELlRpWzknRBL6yF4+tOmBhUz3bxPORUeo
	 u+RzDm80Pr8XYQx+BAqMSyKHCrc9aDzxQ3HbGOd0G90xDjq08GLx/H/wptrkWKxin6mWd
	 tSE5hj5eacHmcQ5OZH306ayyoy2L+vTA7ZIL9zCb9sWYE995enTnb/xNl5sZM9R73Uu/w
	 O2kVGROa4nYu97ET2wIjizAMQgJ5+NZvc7r8WyLK2rwUbA4PyLKck6CLS0YMWJKBzQAfB
	 CdVymEpsxt1T8GYjhtAVB33A5DTL5ySFFo7Tah6GwPau929rK/9s4flLZxvmLd/kk1A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794958884;
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
	bh=McA31GKN2rOgKw3F0EjBjNgpGbDni9V3x+M/93xgigY=;
	b=Oypld01rYkJjMvo1AK/AiyTR8uyxeBRRqAEM7GBiQjAV2veahnJNg2vJIyoahOYknUrT
	 n92hzLbYs+16m7HxCr3AyuOC8thHXKhhvYAyDv7Ik1QyHbXa3osGazXR7Rf0hyeAt73MI
	 iObZbitZ6c5ydX6x0Sq8P96Y4If5EJCcOfj+9LSsjctiiE/g5j0j+icISKVcdMK3k0Aih
	 yw5FTDi3LxYv/tSfAyQ2DgvEYW853ZILtlGxaiJdrv/3JrRHHrENOOd/b+X1v9mCmCfs6
	 cbfScI6b58BX77WXWEc19XAPfTLH2pZFQIMgTrKJZ2se+q4sTUYWHwtTbq0okdutpLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=fBaKITpM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.229.15
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010015.outbound.protection.outlook.com [52.101.229.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADF0606A31C;
	Tue, 17 Nov 2026 23:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4ADF0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=fBaKITpM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYY0oNY1uxgiIysj1t+2Y4+8kdN8KiSSDQTt4eFwUpxMuOpjbxbMXt6T/oIavroVfLhaD6teRl/0Q144QjSO3kyFmptG/hPpguV6uU0AW6hOFuFloyKNSox1duZcS6BWzwB1xHJha6bykks9AIKoQv1k7oR6nB76EVQhrrKHJxwBW7jxFHRZEju604E8Zw8Bw6lOAow+Pf6iio8cqWS+Zceb4/KQ1Kc6OKlPwRaYvDYtzazFHNdk0SGK/sqfUKrC/CEFJjHC83nht5jwqBN6PTKZJFUOX5UPPhZP6b61hM9NewQvb+k/2AGqJEvp++UeC+sCBm9uyfeWcrBtozF1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McA31GKN2rOgKw3F0EjBjNgpGbDni9V3x+M/93xgigY=;
 b=aajVnatGrV4vt0tpTryxlhkHASaYolYQI57jxE8YjK8ilYcGItnG4ckyHgZDY/ZEYMPOROZfr9XFm4BZ4YNA0LqnLu/vg9PH8iDeTa5VyAbMY0lZiHOvSDsXHqdNwJX5FiMXDHqRB8yG5b+2T8j8uOCPQpvMBOru4KRa0CQvQ71fRJM0PtH8bEhZVUl3DjE4NZBstFCizoaNvUmaFNZsdQylpmvY06rjKfZ1ckL7J/R/Db+zuYQGDF3GrPpPcfEEz5/6XVs3EGeD7yqtBL9rngCj1WEsaWEoeLVHMsAcqoZ5pJpmnuAv05pB/ce7VXspKQfOXlZCvpJCMoLQ6aLNCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McA31GKN2rOgKw3F0EjBjNgpGbDni9V3x+M/93xgigY=;
 b=fBaKITpMnPDRK3CXn5qApgkacR3Q/38ttCnm6AFFXZv61blYkwbwRhVpOO17WHmIaUjCu0Wx4XfdCDDYAlnWWjOM1tOVZGuoYaYynkrMO3UonUirn4HoOA3BLjaxPN1ncq/QjBAl89ZadAq4SCU3jKtaFxmbWuG1NWX3UYZWvg4=
Received: from TY6PR01CA0042.jpnprd01.prod.outlook.com (2603:1096:405:3bd::19)
 by TYRPR01MB16434.jpnprd01.prod.outlook.com (2603:1096:405:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 23:41:19 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3bd:cafe::44) by TY6PR01CA0042.outlook.office365.com
 (2603:1096:405:3bd::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 23:41:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Tue, 17 Nov 2026 23:41:19 +0000
Received: from [192.168.1.82] (REE-0069499.adwin.renesas.com [10.226.92.1])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 7F0F83000F93;
	Wed, 18 Nov 2026 08:41:14 +0900 (JST)
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
Date: Tue, 17 Nov 2026 23:40:37 +0000
Subject: [PATCH v5 7/7] serial: rsci: Simplify rsci_transmit_chars()
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
Message-Id: <20261117-g2ul_sci-v5-7-30b58ea18923@renesas.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794958839; l=1730;
 i=diogo.ivo.sx@renesas.com; s=20240529; h=from:subject:message-id;
 bh=sQ0+H241ikIKKBwSF/TnZpBN0HSBNxxi+6pXhmnUqjg=;
 b=l512+OlMSpwhcqWl6tADwRVnQY4E+4SMvEHXuF3tJlbp3IEJD3MkVEkFgs7oXxWGPzX1Uu+wd
 V5bkNVH+zyhC2ZEGEfErJIluLFn7asm6yscD8uHvz30kIrln3jSPd8R
X-Developer-Key: i=diogo.ivo.sx@renesas.com; a=ed25519;
 pk=BRGXhMh1q5KDlZ9y2B8SodFFY8FGupal+NMtJPwRpUQ=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|TYRPR01MB16434:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ac3826-807b-4a5d-02d1-08df45044777
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|6133799003|261009223027099003|11063799006|5023799004|56012099006|261102123227099003|261021121427099003|261022075727099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	rGB+3c2/SbIo3WYqOfAhOoMmXKZTX4VlE27KwKP68K5itv6PEdFmsDqJyzIkzn3RaHAfP6zm19pLTQ7fScKekh6dwo8BUQlOczMPpDyBIR6mtQ6W3tg+uajA0S2p7UUvxf173dHfA6nbYR5Laf5IdrD3gt+XgvflE44MtlmDHoSeteIyz1SmWF82j6RNXJomU5MhKy7bXj10GHGNfBNONV20+7c9ITln7dJxSwjkvp6ZVcoAA0SOd7ZwEe9RW6lLJSl0cw2TBpnq9ETyxWxaxVoOgGtqDvt14PM7l27aHp8oKMwaS8wPlSzAskY+QfmDtquc+E7MCWTluBy7OQUZATGhUDlmAEds6cuBDl7KTvzs7EpMWwtLcyBYpTRrtH/bs/9/p8xyqMRk8Nl+CEqq8rpG7gbzVlvQqst83P8+dVUS/2+Z1pexT29RubpTGbsca/9ngnEOQMLqpSbPdY+IgL+2fvxBWEgC2SFTme8L8Fp2gd+IBHhclABPytza8FuyVTBtrhVsNXFZqZdLYPFMZepfvdv3oAr4ZBQ3fCVorPbzqNV3NH1mdKW2NyWz3jvF/+fnn+4qAdDJAAWW4OjV4apDqg87fk/HsVJ/YGf6vKkWOQ+RH24Ln9uVX/eFjbOHlogn8gyB0XMn+LfQ20r3RA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(11063799006)(5023799004)(56012099006)(261102123227099003)(261021121427099003)(261022075727099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XBESZF5kjeTlXMjkNCvjWwuKu0zq8mCg0ehNP6mL7zg+5Zq0xZ55gTgTaHNgJwk9bRAbyO1FXOupTGFBd7kaRaAB5WePckLRmL5Q8qupbkP1CvDI7wY+zhX3kYQxQLUMB+0OzoFaBlI8gOZDKbsasFsrwXQydZMAcqfsfKkBpG21Bg8SVs6YW1VQb5TwJQJDdYNa97WpNi0OCM15RLCIkrblxx5Oyxm7lb78jOqIjm5uUwe+1lknIWIaawm8Qj8uGIxJGGoZtNMfE4x95LaWeCsz4kEUIOu7c5kUeGVDKfKvhCaNOcdPXlMhhx+fOllLP0EU4MGMaM4GLzPSrmakh5GNGO5vkmIeDO4wG4+M0ZbjXY/RXcqzW76PAl81UmUYrKfYkoXvXm7Xh1Mhe8XbN7cTJf/tjLwuyAxS0w6fwohND2o+pJq2XrixzfcoaYsb
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 23:41:19.0553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ac3826-807b-4a5d-02d1-08df45044777
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB16434

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
2.56.1

