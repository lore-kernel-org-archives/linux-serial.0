Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022134.outbound.protection.outlook.com [40.107.75.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D2A27E054;
	Sun, 30 Nov 2025 10:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499421; cv=fail; b=H8OhhOaPuCIraP4A36iSmyGk3bzYfevKjVoh6Vp9fAun31YydCYqUVnOrbvr2YkO49At5Z6a3+mkUYRNV3RLmUwfmm+nBygwnN45Y6rb4cZPIliQI/nUGaH/a7G/1fBGP/GZmvAthI+nCfAlAIGypHAYkIuqRu1cVzhC2mC7TkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499421; c=relaxed/simple;
	bh=4D6474JGIqUjWEVlP6NeuXJ8Ov7LPMUaZlwU31xlTuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XlT5xykxxrT1TeT86c9Pgl7f6ZWsjhKWSAADLvYuu40D9AC51URT2M9H+hF6pbRUcPJVy90mCkYjnlfqNGWoB3d/HOtWpztDFRSYxXGdyBnvJQ41AJQNOZqA4yBKccGoKeRJh0BAudpuZWMBvd9relY3fd8R3TWyY+xk9mA1eYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=hrRPEi/7; arc=fail smtp.client-ip=40.107.75.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="hrRPEi/7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uSLXPqScVeec8ahTfSAa1WciaRKsDKMwG5zfO1gSaP3+HLC4CWqEVqZnRlhdt+SBn7cpBwstLB5zgXxh+EROj2A7mtdZRciQ8hXqcnLPShu4SX3JnRJPCNhqJUSP8WNiQlFeGoSOG2L+gjoavd4RVSt5T+x8wByohozfMXFMsC2zdWySieeld401m4g0NwBHpb83QIMGDf2Jr2Gh+r15n0XAVaALUjg9JXllScrdU5fpOveW570degk2lxGTVuitDyDPyrwQAnFw2XXSogRDuLB8tk+iLWoLw8EWAGZBkWPpSkIVIEpqh+fc2Ynoz0Jt6aGv2R2+L1VbdHbp08htvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6SqGcKgOtTXeCrnUVmC4Zgfda0pLEZOYtMCW69BEts=;
 b=Xw+R/+tzaFMIuWKKratADBMyQwF6u1Btu7zr1oq8kgQ+0KLAs4+jNgIpD6zSQ6CriZiJ4uphCZ13kDxgp3x5EHBWauk/78QLvDQKJY1zO2B6CHoUKiHtSPuqNx3xkbcmxsA608bb3+Ng0yINuydbqP1scmy/T1qYLw5u2zIYDGgTua5d1BwCZpEjzqNJicbRYS77i4NQs3v0+i0NsBgJi5P12FTjDcMa8xgBSynQQK6id7Pxxbu0iePBUNiXdZlHr8xyesoJSquo3jEBna7ji9siJRc4FuNmqJWa/PCx9CobzieXnm81ewDmkVjHCkmk+USZ10rBzlFVH7zLIk/XcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6SqGcKgOtTXeCrnUVmC4Zgfda0pLEZOYtMCW69BEts=;
 b=hrRPEi/7gcz1x4GNWIaeLNbSk1O3HpOITn+uTHr6putXkiPyoZvR7dXdKh5y6ro5TL2Uvo5VOJ/BJ9Yw8vaEDF9/fQip3KViHDbPxzRynV/l73h3FcnnWj7rnXnqBzfbtbei5a6bQjAbMjsnG6Uqsa+VPxzGnMmKzOKRZ9jkToM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB4235.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:43:36 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:43:36 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 04/31] serial: 8250_mxupci: enable auto RTS/CTS flow control
Date: Sun, 30 Nov 2025 18:41:55 +0800
Message-ID: <20251130104222.63077-5-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6ab7b2e9-3b7a-481f-36f4-08de2ffd50ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FN4eGu0kAgXm3MdlcC4ZFPkYiLgdqOJaS5zk9UL4YGDuys0nscqTLh4/thBV?=
 =?us-ascii?Q?qmr4GlZUsdH7/TpQzbCCkI/JMSh2VbAsuZiYC+9Sl9YqUnvZmwyFHSu9BElv?=
 =?us-ascii?Q?pbZxkixO3bMNsG+NcIoxGoyOhq/C9Vjo8kVdz/mSc/88qPKo8fmYgs0HpaVY?=
 =?us-ascii?Q?WLMdWXtEHZS7+9TI0Mm6ZHJxjlWBgKElc36j3d8P3EH/Iwk0RjPl68MduYz7?=
 =?us-ascii?Q?EvKyUk91Y61dErdPFH5Dn2enyfPNtL3NpxrKikoE9XYXiijKlxyyWcEhku6l?=
 =?us-ascii?Q?/aS9wARHn6oU5rAcdJeF03eQ+LDh19lBlFO+ycoSqgTH5HBaU8EgyM88O/H/?=
 =?us-ascii?Q?zUC3rptyVYcJVac1Wz29Rxh/+PMkYfOreErHsOxoa1pA+ZPQKb6DA17xy6p5?=
 =?us-ascii?Q?xuN9sdGmDQzEQiS66k8C3Sb6HfEjdXZhB65FBxPTf8w3cjoMTgUosijLbCZR?=
 =?us-ascii?Q?v129BvzVajVN2l1JrQZMyxbCUB3VETzgcbmE1PXW2e8UQ31viDzMovDoSzqw?=
 =?us-ascii?Q?LuXUyu9FKoDCjV1pGRl8RmQMbRq8CusA5d/BA1g2s/Nx5k9mR9L3kFgDHLPj?=
 =?us-ascii?Q?eqMi8xc52QlRD0c+w0Yq+WESoZzkVGXVKr6gCj6ovJz5D6NnNOhpu2MQVOqn?=
 =?us-ascii?Q?TBsN0I8We8sbAfE19qBjWR+QTmMdbs9YemGh0F9ddh39zLAEuf3FZnPgAUj2?=
 =?us-ascii?Q?EegvU3JpE4rSUMyqWo0LkKtZrjbMb9qeGEcpBd7nxs9zWIki3f5UkF5rutDt?=
 =?us-ascii?Q?qhB1Nv9tRWdlHSHqG0mGwuXbjF5BB2ZaTv1VYC0z70NNS4IVQoKBcchqGRDB?=
 =?us-ascii?Q?gPZvzDC0YWh0jcwfEKvrTeW6U9EDxSsYC0rGUMEEqzLT8Vy78nQHrp21hEXg?=
 =?us-ascii?Q?hDZQyxPgLWZEoczQVBD7ngeIGNRDaXFV/chCe7ZrHVwsUp6NlmZM/bDMSfKk?=
 =?us-ascii?Q?n388U8K820esataJAde/NVtSt/fdo+5I93NGIYnbEiwYSNoWrCU74gG9QAts?=
 =?us-ascii?Q?2tx9BLWTbqJUem5rgvxKqX39GsOxJrj+p+ALc7pdrgshDhOcaaeFuE01jdZ7?=
 =?us-ascii?Q?5wH3WM4KxLvbhUnd4+a9Adv+qlJtHvS7rUa79eV9M3PG/iBUR0hTouQUatX6?=
 =?us-ascii?Q?AolvRy9kAywY+2h+codaB86rfpO3o5dsl2MnbiYmv6x2BzkEEHzk5Rf4y46z?=
 =?us-ascii?Q?F+2qcLDd6JhnWKzYR9CSQEMJsu+71S6uikJ14B/FKbtBBBiW4z06p+sRX1Fn?=
 =?us-ascii?Q?t5hxBRhpjlO+DfMot6SUzqXbZaoGWk8CoWW4zeJABIcxmE4LGeB7FdinYRq5?=
 =?us-ascii?Q?r7gzR1Ra1YJqiIndpS5QxjwFp+a6y7+G5h0eyw9hAw1LfU7WWFYpAnfSxOAp?=
 =?us-ascii?Q?gW+xvS4U2pvVxLjAWAWsIOdxIS7/f1isfId5h0Icknmf6Zo0E8lbgaKNGoSA?=
 =?us-ascii?Q?BjGaNoIY+j5TqdJ48H1ufx2E4dXMTwmL77TruMEWiyX7gX47y0t8qiR0bEt5?=
 =?us-ascii?Q?DBGuXZ2uoycO3fh1oLz03Rr6/Y1ZYflmjC3L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CgGlwWp8nv/l37SOibGcrlKn1xyF6WGfswb9Cw/kfw5AmZCVhAVN1gWU1nBn?=
 =?us-ascii?Q?VcwhUcT0YuHvwSZ5x5y33UxVeNzMbC2N9c2p0ojDCdX3t2dmJ9CheJR9CnAS?=
 =?us-ascii?Q?dl5XaNKQ4jSgExAJQ2NRbU+Q6vKqCQUbtnKcVOGUxxPj9oY3qCceBH8JTLRz?=
 =?us-ascii?Q?Qw9MQF9oZa8QGQz/GYfCwX7AOE6Pv2m5nmXAIHXN+9Uj3ZnNocDQ15WHCA+z?=
 =?us-ascii?Q?jAmXhtRNrodqW9DyLgvcrukpBfM9bYb8bLOcGv21RZIMCJ+htR1/f06GmCiJ?=
 =?us-ascii?Q?yVWTpg5l2uybWGeMvYUhg5x+FyM/9BPTLk7SdCEd3cnWefaf6JMGMgamlwBN?=
 =?us-ascii?Q?gNUD/x8T0kGh2gQHOqvPM56O2Pq+8R+kLZxanFtT+cQ22lbjY9J733/YA91o?=
 =?us-ascii?Q?/E4j8xB66+2qyfZ/MWmVKzHyAvcLUvO2Ay6cHMeR1dWoazqJxE+vIqdRvqzG?=
 =?us-ascii?Q?oRVZ1FAGP+7lWmmuzKXlTA9GlxTXSmmF4VU36rio+vfZbttoLgmoGMJzRUq5?=
 =?us-ascii?Q?Dk9Mk57v7ByGK2aUDitksvmyTRizHptch1EZ1+LxvQB2EnBBwf2OW8osDQUR?=
 =?us-ascii?Q?fI1rF3f8nJee6n31HkVagIRLAF2H0vmsdygAi3NBqJ5C4V5LcmF5mBGmoup6?=
 =?us-ascii?Q?EmRqN5l9EjQFmcPIMt+BEATkQky05BzLLpaE8SX/0xgzaGvBnWZjDYmK03WY?=
 =?us-ascii?Q?T7xIhLAyaMQ5d5Owgi5HvhNDRAzQpDYcfN1fMtrolvLoIrp9gi6iFleJz3pF?=
 =?us-ascii?Q?m4FpcdvuXZGw75TV8dQBYu9sBJJWl5d7ItcObvDYlYQowtXTaEHOEwB+oJzO?=
 =?us-ascii?Q?U/quC2pkgdyZx1srgxZHDiSXMdECHYuKIWEReIIF6M85tWqFeKiVyvO8ppeG?=
 =?us-ascii?Q?noxhQD4ZIJs9D/DiXKpBWdZvAXNVghIE3bDuYNsmOt04PLP6T26WJpKUr789?=
 =?us-ascii?Q?Fa8CzSx1dxBHGijgxpPxPEbWxzketHI2sA7buLgBC6wjvtH3UFIIHsr1Ez2o?=
 =?us-ascii?Q?TgGkymc8HMjWlt4pHGltqNp/T7adYu3yztpvCocWQrJFMWpEppDiMvU9dXNn?=
 =?us-ascii?Q?AATiWmgxyx5xi0GN9VyhxHmtHVzSStGaucBxvYbAfWKQdYTKI0ufYKSKQH/b?=
 =?us-ascii?Q?KWMIxDkVw5qwjhb3ONwco5H+GptWjnPpNHlDSTNCONiLejt5E2gYPvtov3L/?=
 =?us-ascii?Q?dEbhj4poLYGrI6jezgEr8X/91ONS0bH1qUpWadbkTlD2n3IEAACTq8iz9/mi?=
 =?us-ascii?Q?z7m9R+dprK4uLcadaK16p6lb2wtIUkUBKVnfzaXUgxrtepR7sYS/6+Yv2Uwk?=
 =?us-ascii?Q?BLbnbZ9QbbOmZ/nKi9ZxHhH2SUmameefsjixGvn9toyrUWwlRY/jeDWJs4ji?=
 =?us-ascii?Q?CwXtvHfKuQjcrjy4J/IPNFRFJg/D7ZjJSunN0NT/5T+jEbIUxpEAMFqmCydo?=
 =?us-ascii?Q?uW/t87qtUkmL41RJ4Hn25SLUJ9mm/KlHiMtayQ0gi31HiMqIgezBnnWGILaV?=
 =?us-ascii?Q?i6A2YfqG/iBafIfPfsfi7U/sPIUfsjMHocoMVLxJ6/9FVhmpA0dQLpuZ4uUF?=
 =?us-ascii?Q?meNqcgrO+2ldWtgn2uN18zFjUOL6GHGidfGRt00A4T6rBuaeK/OKdouvm2wn?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab7b2e9-3b7a-481f-36f4-08de2ffd50ce
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:43:36.3055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2utK8bS5qaBp1IHBs6aX/+aH/gBjG0g/le0IqPQZQqA6AbFFPFzb0EfJoGuDGWIS7qBvLjFXsUWOU5aZArO7r0zJn/HO0r7mFaFDoeSPAVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4235

Implement a custom set_termios() to configure RTS/CTS hardware flow
control. When CRTSCTS is enabled in termios, the UART_MCR[5] AFE (Auto
Flow Control Enable) bit is set to allow automatic RTS/CTS signaling.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxupci.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxupci.c b/drivers/tty/serial/8250/8250_mxupci.c
index c4fa52de8962..54e50cd3f472 100644
--- a/drivers/tty/serial/8250/8250_mxupci.c
+++ b/drivers/tty/serial/8250/8250_mxupci.c
@@ -78,6 +78,26 @@ static unsigned short mxupci8250_get_nports(unsigned short device)
 	return FIELD_GET(0x00F0, device);
 }
 
+static void mxupci8250_set_termios(struct uart_port *port, struct ktermios *new,
+				   const struct ktermios *old)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	struct tty_struct *tty = port->state->port.tty;
+	unsigned int cflag = tty->termios.c_cflag;
+
+	serial8250_do_set_termios(port, new, old);
+
+	up->port.status &= ~(UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
+
+	up->mcr &= ~UART_MCR_AFE;
+
+	if (cflag & CRTSCTS) {
+		up->mcr |= (UART_MCR_AFE | UART_MCR_RTS);
+		up->port.status |= (UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
+	}
+	serial_out(up, UART_MCR, up->mcr);
+}
+
 static int mxupci8250_startup(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -152,6 +172,7 @@ static int mxupci8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
 	up.port.type = PORT_MU860;
 
+	up.port.set_termios = mxupci8250_set_termios;
 	up.port.startup = mxupci8250_startup;
 	up.port.shutdown = mxupci8250_shutdown;
 
-- 
2.45.2

