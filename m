Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013014.outbound.protection.outlook.com [40.107.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D9C3AA9D4;
	Fri, 31 Jul 2026 07:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484150; cv=fail; b=qRUTrMS8Pi/JClD1pQ96/SJn8CrwUNKrgkJhUuyFDKvqD3xjcpsjzYddmr+vhHUCrWBZ7Kcz5hf8Xncpm2NB9YgJ4T58qQe/BfV6SQjyAgrBiJqFgm/cGDW9IPYTJY4VpDm/etQ6ujwuu74fpKV5eZ3Ekpb7iGd2UwYIDOVunuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484150; c=relaxed/simple;
	bh=uCdiRbs5O3vN1MRnIfu1lVnIyeSGgJF8LM3uYPM4oFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mYP5VxUj9C1mmnHr5HAbx6FsO9u4qFhFJWMJYhWY4BuSFnka6TS+VvFXPiJuQTyQa2raIVNvmkJqxMUi3xg7navDfZK9EBAgMxxiNuGTguSkTxVyjEvYiaXPOY6ixaZQ8/H8owkUG/LK+xndvqf+J8gvzaTe5i9wiGd467JSPaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=ICwFga0N; arc=fail smtp.client-ip=40.107.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="ICwFga0N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uAP1ah1VybIYZdZeX2945eVyi6ofWpwVh3yQ3N3kcSE3+eSKIER4xz18osjAiD8/v1anwdDKt1gQTyaXrk7RpPpO8joWNPFd1Njk2RwnUtzEEdvqa63l4Co3fHGGvOVivcXFEuqpC/foF4X+CWHETTYowsVcM3Gq/rAeNfX0CNAlzIx//1owmBeX9lHhvMMEH26ty0629jkxFlXFMs2EcxwprcB7n1Zu8TiwXU3849cp6u6wcd/FGizhVcAuK5m/RLg43MxiBqaetexppiojj2yVw8cG7LxKJISGnz99IIiwg8LpB5sBdA42xINRgJHJ6TGe0m/d+5+VnKjMumIGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZvGtqRal9/szdL0NR3rfAlA7P38EJBrmNuBTc/BmeI=;
 b=lA6+odBVi5Rh+ryT7+ygCIDfFa4+fApC0xjAE8/0k71Oaj55xx/VCS0AyFFX/zFcRboMesmuQN0d7Uy3LqqdbYHHK4MZXFdMKCv7wDK9vdLwcUtCZrkgEzS938Utj+HqdnPx+UwbOlnxOYWTUsjkWaUV6QaypFDZvTUZQhz5hX4b3NjZOOLOUzFnre4t609Nojem8vKrnlu31qsmEdSgNrc3K6VYdnaOGR53wkcGWRyyfOwJNUPwrrPzSEDRva17dpqunhUg8l+aDp5GKu9lcQBrTV6Ba6NAQp8stEQRSkJi24pxkBBLiYnXzMGoucXl3SyFzKsJQg/WN98HuKQS7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZvGtqRal9/szdL0NR3rfAlA7P38EJBrmNuBTc/BmeI=;
 b=ICwFga0NUSonEjjlv6fCLV/hbeaU11RJxHOwUNJ+njza5tukwqK4Owvho+wTzvzM+cpOfS99U2w6Nv1bmeVoe7/sHLuvz0U/wMj/oKnR66+HMF2fod2z6jfR+SxQ2crAMw0t2PGMhUOje+xsV0uXhwhguhUJbAt5gQk1Vwhss+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEYPR01MB4488.apcprd01.prod.exchangelabs.com
 (2603:1096:101:89::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:49:02 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 07:49:02 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	EddieSY.Lin@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v5 04/14] serial: 8250_mxpcie: enable automatic RTS/CTS flow control
Date: Fri, 31 Jul 2026 15:48:10 +0800
Message-ID: <20260731074820.735619-5-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>
References: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::10) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEYPR01MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: ccb34e9b-f1d5-4cff-9220-08deeed83013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|23010399003|1800799024|38350700014|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	isLxmpokm3MREaz1hHdMaZM14+ONnVjuFeAH2o7ab3bitZD/NE3cZgAXtW4UgTcfOUViqrguvxE/gfQN5oyL6aFWNUSRWpEqjZ4YIR/dPByLVvjfMNyHP7uQkJILAhQadg94PL+aOcvCxbKsKp72QjEYafD8SzK0VPGRnSopNxfV6QWD/4fFV/ApWui9pmmDTM88MqpOnqGjb2V1SqCky+l9wcY0WwXGyQHJTxLVYX+B/FuihjTSl3Soha9AyN0XjEeiS4MlETwgSdZ04xlA0yLw0Ude6bPL6N0Ynh48jUPxwMaYaus/tbFA14FR3tY/+rVY+dgpJYAoTloEwCd3NWJTYB76IFCp+2EuQYpKFKxyW1BUKVxnw+HZ4epxrkQrlDchUr8voD0p5Hs4ytS6MOw3r+++eUkhPBhLJUtz6r6qWFBDw9O8LbXwF88CzAq9/ImLjshedSGuY5vHW+NE9+uoMIDOv6YVOVJyJqE+3drdjD8CzkVAv/YNu1/MSX0gK5YG+SJDTDkJ3AoHU21xW5GTL81m0qnhuWU+G3cFbAKJUD1f8IlrY4WC07ZN+nZzVDhOM+VlaVDKl0cQIMwNsU/kw0fKvxtsQKaJ5A0ZD6A7zEUYB1MkE85surWHmOFrx06myVjmh4FhxJuM5JakGZrOftg+zY/b4r8rqDlj6lndrlTDv1Xrn8zstNs98e+mZxzeGCusgnU7ITf6xAZyZgv1gkOCH3xPeUSOzLoNBg4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(23010399003)(1800799024)(38350700014)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XvqeZOpJ4ipp/9pOo2W0oTUVelmabLlckbnj1JhIlBRDMjRLIrDv1+6AKRPb?=
 =?us-ascii?Q?9EYzy8+qTS+MbaRa4PZ6R+hhKQpJidGfaKjOhbw0KaYM7AegtjZh4WJ5wNd8?=
 =?us-ascii?Q?rXYQIFATXJfpPf628XZ6n2Hv1G9hEM9COQx7FMKijrzfSxlP5d3FiaMDBzTp?=
 =?us-ascii?Q?z83rjwWkUTsNleZKYwvLH3CxnYR5/CpsesbipKkI9fVhjZowJvLBgsbgYyQg?=
 =?us-ascii?Q?gQmJWbbDa0+26esQiYLwXohamfbI3AhIOcThyqGKvAQwTv1+MddEqNi5toVM?=
 =?us-ascii?Q?j51G1aVVV7I7vXcaZJ4yKTTi0iNoAIpWg6gud0Fw0hHilu9amkYtz3wGywYt?=
 =?us-ascii?Q?DJThKnA1hpwAggCZXIclNOYMtJFZ3twuPBQ61WgSwYEYKe06B6MLxPaiyO1w?=
 =?us-ascii?Q?+FB1Csj97eZWQT3eY/F5mmtub56Kxb5Qbjxg2lhytTjFEoGu/q6Kj2Z9zLl1?=
 =?us-ascii?Q?ZnUGD0ksVRdBmM426ve6K7RBTUfttmXfqPV46iwTPaQYTgT0OZiTgXrWDy8W?=
 =?us-ascii?Q?b+Jwwq5c+Btgemd9mRTFBYHWYDy5QFZSPQxE0YkIYC2Ej54u0nJS/S8A3smY?=
 =?us-ascii?Q?KNUuGeUt/go709HsmFEdvzPXZhpRMRYiGNmVSYwaK1LH5IDLGzOGT0my4eR4?=
 =?us-ascii?Q?ZBer51EGEM03JW7sczAHc/1ou3wLidANkq9cTf7tVY/g95Zysb+YqwHCtmQX?=
 =?us-ascii?Q?5yoTXFrNnVgFTooIy4PU5Hg1boGQy1Qg1DowN/E8P7iMXwpHDCFQhunmECyQ?=
 =?us-ascii?Q?ws+1hL/mhYoOksMx6395uOrBiyR4W7nU+IjlAFdHRo4kq6ETUCbNa+D9+DQe?=
 =?us-ascii?Q?HGiutmxQBHkb6sXjGrp/JBH081gn7uQfmc8d1XkW9Ft4g6AP8BAkj6RcRxrY?=
 =?us-ascii?Q?97hZwkPB5kJd8rxcxZAQPQviG3CKv6b0wkpd1eVCYEh/m6bVyCzC/OtvjcfR?=
 =?us-ascii?Q?chFXQHIC4nZHr8ymt0nmOEW2R7suWF9vmmWboGoYMpvhuRGidv1Z1vOCihuy?=
 =?us-ascii?Q?dA9XkjYYfgO9O6sCNueF8cJkOPJm1OBUa9jISp5PxddZ7NmAIITXNerX4Qxb?=
 =?us-ascii?Q?DJ0hGEL3N84ChhReOC9yuWXnQ3JFEvcZycU2vFlK+Pq4CDy3i17hEKxFYHlf?=
 =?us-ascii?Q?PIfSGQL3zxZ1NPkyM7/TMoFyjniiTOoDHHnp43sR6qlGMbEqTVdGCnmuhl8n?=
 =?us-ascii?Q?tmykSMlZH2HjJbf9AXBTQ8kjnGtTxP8/fGNaWQsoPLcimG2pHWbS/O+gUtgp?=
 =?us-ascii?Q?EpgUJf1kvATQgoLgZx2tGmGxKp0GwhdvTe/TBOnLq58la47ffuL0aSgOTCuy?=
 =?us-ascii?Q?RCto3wndDhWs2j4mw/8F31kn0n/vq9LEt9/vl5ByCfsbLIe4xoH9I5KyhRRt?=
 =?us-ascii?Q?fbqGPdDsX0LdqJpElDUFfse83Evc4luiqV6OjZyGnMq0EH2OCsU4QEuz/ODr?=
 =?us-ascii?Q?jKF8Y82D1bt2R9xYLnX5VHbegwh1sMO7w3raVkfZIGSqqnkZ9MVcxWu7XqmM?=
 =?us-ascii?Q?Pvl7vPe8f4NYN7z50W+94COw6fDXiKrYjGQary9TCMQOGGs85vekwo7wNsTW?=
 =?us-ascii?Q?t/zlONuLfEbYZ0IDUbZr7DMtPDoq/bInEqcMOOF5+cs0WkW40n5gBp5M0hiI?=
 =?us-ascii?Q?g8XuIDHHgLZd8uN6qzvmyjkFFcXe4CAZTieXpcvRk008VeUBj8H935vR2wBN?=
 =?us-ascii?Q?E87WHKBEj0miXbnNsWp9SqwrTvobkqN5jR//ZpB8lEKU1bfeIlaoORYswZeM?=
 =?us-ascii?Q?+gdl5ZFYCvNOBssdud/DfxsivTklOdE=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb34e9b-f1d5-4cff-9220-08deeed83013
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:49:02.2257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARGaiO7t2P1eaWUAgjI0w5GJAIChJsP1klszvx65q2igqnbz5ntSZq7+uznqCBfSrA6rhwrNjh6uAxgNIWdeglQGj90VTu/EM72Al6a+ghw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4488

The MUEx50 UART supports automatic RTS/CTS flow control via the enhanced
feature register.

Implement a mxpcie-specific set_termios() callback that enables MUEx50
auto-RTS/auto-CTS when CRTSCTS is requested and disables it otherwise.
Keep the 8250 port status flags in sync with the hardware configuration.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index e1d607b607e8..25ca43225e7a 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -58,6 +58,10 @@
 /* Enhanced Function Register (EFR) */
 #define MOXA_PUART_EFR				0x0A
 #define MOXA_PUART_EFR_ENHANCED			BIT(4)
+#define MOXA_PUART_EFR_AUTO_RTS			BIT(6)
+#define MOXA_PUART_EFR_AUTO_CTS			BIT(7)
+#define MOXA_PUART_EFR_RX_FLOW_MASK		GENMASK(1, 0)
+#define MOXA_PUART_EFR_TX_FLOW_MASK		GENMASK(3, 2)
 
 #define MOXA_PUART_TTL		0x10	/* Tx Interrupt Trigger Level */
 #define MOXA_PUART_RTL		0x11	/* Rx Interrupt Trigger Level */
@@ -148,6 +152,29 @@ static void mxpcie8250_set_interface(struct mxpcie8250 *priv,
 	iowrite8(cval, uir_addr);
 }
 
+static void mxpcie8250_set_termios(struct uart_port *port,
+				   struct ktermios *new,
+				   const struct ktermios *old)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	struct tty_struct *tty = port->state->port.tty;
+	unsigned int cflag = tty->termios.c_cflag;
+	u8 efr;
+
+	serial8250_do_set_termios(port, new, old);
+
+	up->port.status &= ~(UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
+
+	efr = serial_in(up, MOXA_PUART_EFR);
+	efr &= ~(MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
+
+	if (cflag & CRTSCTS) {
+		efr |= (MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
+		up->port.status |= (UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
+	}
+	serial_out(up, MOXA_PUART_EFR, efr);
+}
+
 static int mxpcie8250_startup(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -285,6 +312,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.iobase = 0;
 	up.port.regshift = 0;
 
+	up.port.set_termios = mxpcie8250_set_termios;
 	up.port.startup = mxpcie8250_startup;
 	up.port.shutdown = mxpcie8250_shutdown;
 
-- 
2.45.2

