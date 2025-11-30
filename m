Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022118.outbound.protection.outlook.com [40.107.75.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B3427FD4A;
	Sun, 30 Nov 2025 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499467; cv=fail; b=YfZHSqxUhFFCZZNDnKKgJjFD4B5/GnQFrkCx2QkvcvbbpeBor9MzrEIlMOm+NzYKwAi2X/4xrYvaURyu5FFKBTw1epoUwiaRXXrsaMiaXhquiqEgWV4b2OVn7Sr1pRAxbyXoRKkaIoTYgSnmlqPwAt8ZtFGK2CVDnQ2PTAHstNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499467; c=relaxed/simple;
	bh=jILPKtlGBiZU2YPh8FmPauMHsw7lTkxtxXMteYn3GnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fktbPZxCg7guYqKmgk62Eo9xnGXo31UGCEqmfk1T7d3iqH5xt4f9Nx0KaHLz+HK96epazZG9kLzHJILm3+beAUn8cQkDqx/jfagBfZ2GaUww+ssFEocqaDOVmTqaGf5x4NgBy78mcwKn0unM0Cz+T8P0zvLRKWKSXNR3c9iaw80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=dRrTWXfX; arc=fail smtp.client-ip=40.107.75.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="dRrTWXfX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XD+16lhVNZf0TElHYql3Mhy29Bz6rvAIjDIk0ver9Q4ouZhLfWVq2wZ3DWVTeuZiqO8Vw5Rwm507bhgTEtXQvCHFVa2qiMmW8A9ZwYOSbvpCN7RalZZ6Rzm2kVzLgpdhxf8rBhTt3ld1acS34/wTT+i/dlc9WfD+dFoSBek7P97UXZw6DPI9YVjt1kP5JdkOlYu875QE/7llTsWIzZHFsKfHo+Ij8MgGYixJ5z/xbHB4OT7uFVpGk8516umDvMrBzGj0LvrvsjVaOWoZUWyGHN5bQkqIF9nt+JF8Cnpe3mY75I7aboy3310PZmHpJjAdoA9A88VqOiMiierSiTACaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75pwBaaCCMlTUngx5bSKfm99kyVPjtRYbzwkoMzYs0s=;
 b=UvUR1B0K1sxPgofdFC0CoDqmNQKhFJ6+Pa92Hq19a2ltomr5p5FDZ64xQrIs5dyf8t9YI1nxlGPp4nGQtWQsQPPDIgdo4c+rJErdqDVU0Lk4r+BfXACTtS0NZSlMW180tkxLT7kske3GEWiGi/Fm0LjN1Gb01OeBzxz0d750M5cByzmyS8KksdJkUaif2RKC2E8iLugf8T+Z/whlmBKXLV+2vmapqZAMfgo1HjT0hDjoiMKsnNMdEqxLuAG2FauYsQTKtLGEMg4gfNzGhAAVhdq4l/vuwsL+dfZvSLOMrat4p/pR599cDJPzzD0mVX7JT26lc2rjKYoXA+WEPvAAyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75pwBaaCCMlTUngx5bSKfm99kyVPjtRYbzwkoMzYs0s=;
 b=dRrTWXfXgFebnfxc9r3m0p2NuxJEzYC+Kryun4lm40LW6ydDwnjR/uRlwK1Mq1eIz2fyatzYvjMo2R7yy301eG0wL7DHNTrbUrc2PZfc7YEZFZwsxGIDYTqEHBoQ4S0C9adZmkbwIxiBRxVa/c21+5BgxLkLYT/gWz7T8gW/YOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB4235.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:44:22 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:44:22 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 12/31] serial: 8250_mxpcie: enable auto RTS/CTS flow control
Date: Sun, 30 Nov 2025 18:42:03 +0800
Message-ID: <20251130104222.63077-13-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::18) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYZPR01MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: bbfe256e-39fe-46bc-ce93-08de2ffd6c3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZWR6+KV3KlGoaOyOj8K0FB0VWKAUlFirItn6HSU+GLL9dmgE/MmeP8YXnmSX?=
 =?us-ascii?Q?6mHQLrHYlOZWM8WQ/9n/GlD1SSPsemm5D2uij7z5P3u+Nxp8vSLOdhlQHpDO?=
 =?us-ascii?Q?kUudPOeq1n+nP+TuM7wk5Twwcq/1CLfY0RLo/gzIQWqudVEa3/hgdig822FE?=
 =?us-ascii?Q?0kqQq1RWmdQo0/cw8VUjdXoSwExOWSZqezuUELXjCvhm9XXnSOdUHx1kfpr7?=
 =?us-ascii?Q?86FGkSMX0ivGSQk5PCxoE7+9MwkJUM2ojeOMzqYjrevjJUOEZor/xXJWZsA5?=
 =?us-ascii?Q?wjJtnx/T8b2h0nckhoxBg+X4sA3RbZvQuz0fX1trTbAC6z+kITXZmr2gGx7+?=
 =?us-ascii?Q?T8s6iRgREjc9QzVau5ESSBcpRPsdEX6eu+/7lW2cS3R1A2eG7XwirTNg1g5i?=
 =?us-ascii?Q?RHZa7Vx6+AQ8zGI++lxftOL6ZpNXqyLQep5IxTnnRdF4G//vRegP8velpLY3?=
 =?us-ascii?Q?so2fBzc21VPx+dIA4t6rN+FUC5Yc+O6yYsK3en9nc3x/j//Lrjg5vmRgLtWS?=
 =?us-ascii?Q?q7fDN3wg3X79BsQUGOuILxyalaBfs+JpiHmH/RmIGs321mRs+wF1AwTP2EcN?=
 =?us-ascii?Q?zT1nV3AX4m7qGtjrnlejLEarCYrHP4UHohQhaXu90fbn8PhKH4DVgXW6jhvN?=
 =?us-ascii?Q?eZb+aDfq9lao9TCjGI+9qoSqCS19lWAw2Wnhr8XbFooUr6jh5yb7RT/6A9J3?=
 =?us-ascii?Q?HLNBPDBovRPs+xU5QHjEBeKRgYBYySGPfFWaAa570f9zNcv+1W7x8wJQld/1?=
 =?us-ascii?Q?JdMqoUil8bUfAsRd+nHedmkyVxfVtPmjPuIIl/drhKbtd4QoLbDz/PUKQUNx?=
 =?us-ascii?Q?SzpyRmMH9GDZ+k5wP5VzwfmoOnwy8Tn7rlbdEup9jgOHF1Pbw9/hdqVSdfFF?=
 =?us-ascii?Q?PgExG6sd0JhngqTCyxxailXzW2+XCiTnS47CCbnUr+G7b7F6kzdQzPmoMeby?=
 =?us-ascii?Q?mRfvXicwHXCQwMfqEZ7NykHT44hfGPWhs9caWtVflIzMgFFpxwYNOdoGKWPZ?=
 =?us-ascii?Q?1GizuOAqpEyoOHnRDHk8kTTUa2soz1UUfZlQjv6i3I3U6rwFRQXOaugQeRcH?=
 =?us-ascii?Q?rI6IF5Wx/NxggsOfeQglxdh7EHq/sSEBoTu6vrLH+UNVqrLq74oRM+1njEvv?=
 =?us-ascii?Q?kB8zW28aieoX0/oL3lGHndzNpb6SOc9v4myyJWcOeOPbR3upJ6PXIl0NQn8Y?=
 =?us-ascii?Q?Q84PoXJxcU1ZlhDMmD6lRBcbmyU35LcG4KgNAV/Q1lzy43yAd4PkHg7GXjYm?=
 =?us-ascii?Q?WCHFsbmcsOGC0pkFsiW48NAwlLPEcS9EvGQZ4AOelPfmXnVzjAlHdjf92WB/?=
 =?us-ascii?Q?QJkBpEayuwjuDtBvyIHIwEoCVos7WT00JJ+S+BeT9IvHjzLM8ZAx2l5NZEfp?=
 =?us-ascii?Q?XuS5d259uWXYgATETBT8JlKsFbARiJXrBq1+R12FJA9sbPSbolFS09kS3OXG?=
 =?us-ascii?Q?jKi5VMlaKB1BHSGkZOZHjq6Ww/bgctqZh/mFbV3x7YluTlxH0JeNQtvizFoR?=
 =?us-ascii?Q?yh62hO8ER0/KFBGYZo4lmPmp8NHUT9HaYfoi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q0DK9V/29/3m06WXbCMyXONk0Xqh6fgc4e6vCi1vKwGMqgm67WOOJlHhXMBC?=
 =?us-ascii?Q?CSb6wzfO1Ff9dnUpjYekIygnAVNJLi2RBmC7aAvRk18S5WyNIB5/GlEvL4Ci?=
 =?us-ascii?Q?r+E624N32ePptUmNy3jk79/tCzqIgF7rv3Gaa7kDOQdm+V8KBvuwm2sKFWWb?=
 =?us-ascii?Q?tgfskA+e2fdI4miCbKuZS2JQRoVvhS4+9v6V6sERV7xaySdD7xVyQJbDsQ64?=
 =?us-ascii?Q?kvt1DBSSc8h9N284kkBHkpKTrN9ml4TRLmgTJIK8YGRhicNbetJdL13Ej9GT?=
 =?us-ascii?Q?AYjezEdMtS6zNV429p8i+YTe2g0+mKjGDcqo+YfZkwK+wg6kNQiU6VtXNDda?=
 =?us-ascii?Q?4aL+BDS/kor7dZZa690CekEYV9wAngm4m3hXgX4sEnmrmQh0QALuH4TBLkhq?=
 =?us-ascii?Q?fKcg9hAnUmggLnwbk/frP2XK6RNX3PIjxncMwhq/Z3Gq67cm+kjF1Nvs7ahZ?=
 =?us-ascii?Q?bvoPVtj4YGxdjfYSzkyDwDfZhQJwk6NPlaYq6GfWOo//llHTjMFQU5LcrZRc?=
 =?us-ascii?Q?eBspSbHxwBG6ngrajKzzFshG2GzdNhWvRIF2PlPTlPVkW5Vb+m56wF5Dbl/x?=
 =?us-ascii?Q?jth/OTplxh04UoREjRKnAA4hEFaMsrSQ4dAmdia/6newuquLRwALMNGXcprw?=
 =?us-ascii?Q?xmDYkwOY98hqeRGeFmXEJBx4b45jOJOO4IuGYDoE4ST/h33xPCqNNWnwD6/R?=
 =?us-ascii?Q?dDUNqiknBhDdhxHmrA1Ba94+HaFC0j7EEGKXptRF4LTwpEq5pImmzI4iyIls?=
 =?us-ascii?Q?mTNqJBBQkiEA7He1hnQZocs1OI6ZddAYmdnzoSD4kaWK/DFHf7xNj+fyzc31?=
 =?us-ascii?Q?hhws0ZWMvqrgbtmNtmgmCKpCbCvpzqlxgp1jFT3Y6KBl59vmAHr7j7gNoRVR?=
 =?us-ascii?Q?q/BERVXVP31jutKKaJDrWd6ZBWaoHVQk3nWqeOk+Y1VS3yHHHWrhfkLTFyHT?=
 =?us-ascii?Q?4FyaPeWtfG37/RK70bediQoqtktKBTzwYf9qJeVjhx809UKyw4sOnw+PhXmD?=
 =?us-ascii?Q?AJ5xgcWRBw34QkqlPV0tGkgVrMk5xdUl1RWYeG3T6TJLm2/+2oVx7lhUoOe7?=
 =?us-ascii?Q?Y02d3uocPbRH+B9h3CAe05gFN1j7XBAxHwz0277JXGUbDs8HQdRtM7g8Z1LC?=
 =?us-ascii?Q?do1YVol3xUjYpcYVk4z4EFmRi1TYSRUKOtJp5PcFvGXxFFl0StJ2xbRrq/e0?=
 =?us-ascii?Q?wZzdRsAlJxTDkNRo2XivXH79Cc+rasESfJvVNml8EZeLym9+TwcZ9Jb8J9UA?=
 =?us-ascii?Q?qbX6gswkyD+aqaHw3dV6f1IDZr6oiBdfcRe+LxBmTfphTn9bmELIW13ZK1xv?=
 =?us-ascii?Q?4JyedlHjc1M4/dQoPRmnvt+hotQf8TptRxoK5q7fbALQD9bIPzIhnZdCv5Bz?=
 =?us-ascii?Q?2PvS1fhAsFSoVPmN8j7v+DJnmRd9lQJClFmw7316V9sVi5QIt4x1IowqJ0gj?=
 =?us-ascii?Q?CYJK7Xy/ps5iZsBReTZb2dqJ979T69keTIlS6DvbAbY+nVZuJ6UJ4G2xodAF?=
 =?us-ascii?Q?/UA/hlMWGOZ0fI6372g4Qv8LBYQKdB5ahz5a8uUZkSVc0gr+kS1YJzppQjWU?=
 =?us-ascii?Q?VlsStBemG2/P6vl15DJ/PFNSCaqGkQVlQ8oRHmLtnqJUqKnU3APXrC/wEvXt?=
 =?us-ascii?Q?bA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbfe256e-39fe-46bc-ce93-08de2ffd6c3e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:44:22.3615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2iHSs2+rmRGq774EsJtw+g5L+Wspgd15feh5nrIz/+l9D8w/rB4+k2jHSlyfwyDK/o7G7lpS+SWzs8aTwvSH9A+MNMsPMW9a/sZubTcFsc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4235

Implement a custom set_termios() to configure RTS/CTS hardware flow
control using the Enhanced Feature Register (EFR). This enables support
for automatic RTS/CTS signaling when CRTSCTS is enabled in termios.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 28 +++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 39a178dc0519..197d016354c9 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -43,6 +43,10 @@
 /* Enhanced Function Register (EFR) */
 #define MOXA_PUART_EFR			0x0A
 #define MOXA_PUART_EFR_ENHANCED		BIT(4)
+#define MOXA_PUART_EFR_AUTO_RTS		BIT(6)
+#define MOXA_PUART_EFR_AUTO_CTS		BIT(7)
+#define MOXA_PUART_EFR_RX_FLOW_MASK	GENMASK(1, 0)
+#define MOXA_PUART_EFR_TX_FLOW_MASK	GENMASK(3, 2)
 
 #define MOXA_PUART_TTL		0x10	/* Tx Interrupt Trigger Level */
 #define MOXA_PUART_RTL		0x11	/* Rx Interrupt Trigger Level */
@@ -137,6 +141,29 @@ static int mxpcie8250_set_interface(struct mxpcie8250 *priv,
 	return 0;
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
@@ -254,6 +281,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
 	up.port.type = PORT_MUEX50;
 
+	up.port.set_termios = mxpcie8250_set_termios;
 	up.port.startup = mxpcie8250_startup;
 	up.port.shutdown = mxpcie8250_shutdown;
 
-- 
2.45.2

