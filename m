Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022111.outbound.protection.outlook.com [40.107.75.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF64828504D;
	Sun, 30 Nov 2025 10:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499473; cv=fail; b=Rq6hP+vhWIZvVLJ29d2A55scJypYbgX9/XrNlTxjrWGhpsfgYx56TO8i2syxJgblXiNLmvbTouRoOzU24f0FRlAogv3Usy6QPZgHqycW9f9ePcxnmTpIfk78xiICh1CHyAWt/lAIT0KO0oUrbbUWZa38wdMuDobWNA1xK4jPsPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499473; c=relaxed/simple;
	bh=AzJ/NEcKOScbA1tI0rQgdIo3DGZ11fT0j5YesWxcqZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EmRNzOUOktgQ21SMif9IaEE09CosAYdtxwUFWcdjEyL1+v/Mop9sitxODcK7zH2BRqQM09Tp54XSI16c7IYqEBD/M5e7Xafe3oxKXIxYri0uT4Plri40aSHjEppNIntvmQY4Np2h2Ql2oVPbJoskzYndkzzVV2AxbzaaljVAjQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=RdLO/LeB; arc=fail smtp.client-ip=40.107.75.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="RdLO/LeB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EwdUJYr7TaTOaaWEb0LGwvOl8AYFF9J39ZcwMos/cul6tXiZtiXiBg8WjaDq/8hFYLlhofqlRZRecZa8TQ4CCTpbHxVW5pSs0m6Bd5DP5hC97h2xwTD0EFhOHBMyq+JOT0W6T0U1qkqO68latKfqFSvbdjv7KV8z+aJxDYwxmIZ2KrHQM5/PK8ZwfyKZr/sho9doZ1omTykYvvD7Vd+srPTDas+AeGXGzxPe0ZJLANarYIhPHZ97QKZJSoBKgjiCMdWJniZJsJJjp0VS0aV+MBd7RMcUnHru1WTxofLRbLLebx3Y+dBYrV98rMgwLsSyMBuk6UuvKiUBZxcc60THuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgEfVglOQ3ykxJq73h+rB4bw+MEaDki9c9hxiBjN2l4=;
 b=nphrGeq68uiMroUTf5RIzlhUEWfr5KoSlEOlcmthwP2lo5yaeQ1mT9DSIKN9HWpKocw/Y+9ck8gtx32onPnFkjgXbR0tuZuwP59PIjOT3uY0i+mG5hLstPNEP/pWFMaEhiqZmiAhbMesHQGiLEZOX1BLod26HDgepmo6zHyd5gvhgH6PfgTJ1DxWAO2afvY3Juu5MSjpPDuRqAJwCH/R6ERh0+pKcRps49cwhG9vGXQHHAAnk3Sl+SifU8WfPMnSir23wOacmL3CpOtr0BB/KsDBCAhXuZUWj3OcMR1GwICqHwyLpIbVFgq5k7WPUSeI3zN+Xznd2fVO2OhuPf9LIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pgEfVglOQ3ykxJq73h+rB4bw+MEaDki9c9hxiBjN2l4=;
 b=RdLO/LeB19XZ2+wpZ/Sjej/MA5NGS63DfoIZGwNkJHJjTN1+ndjc7sg7PwDWAu2dfHjFkykpi0LTC+4xHpOfwOCupxi4U+6qEuqq1qpx9tHFjK1Z6JTyNefmB2cSXdp+9f6Eo+468t5G3fh9vJNmXwQtIKeX+yRBp9xYz6enbLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB4235.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:44:28 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:44:27 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 13/31] serial: 8250_mxpcie: enable on-chip software flow control
Date: Sun, 30 Nov 2025 18:42:04 +0800
Message-ID: <20251130104222.63077-14-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9f3eb1b5-c0d1-404f-80c2-08de2ffd6f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rYwhjeJbTmhwLXY8/r71+89w8BoBZfzTm76YEpruqQ+qBjhBTpWqHcTpuX8k?=
 =?us-ascii?Q?Y8CGvTAoJfui0eMOQfj0vJ+0z1OgPVfKC7kg+wgLdkI8hEqk5FI1xeGEWr3F?=
 =?us-ascii?Q?ByW9xj3pEHTFRvRdc9rj3hP7roB3NSQMY0+Bq5jsN5xLEQM3QngFJH4nXx8r?=
 =?us-ascii?Q?Nb3jduxNiHCnv/R8GjccmXAuIpDwB7ZDW0daf1dMMYQU62+JrE0RVRP+aWak?=
 =?us-ascii?Q?/HNQwJQXsWyBPZzKfI1NsDARPDEFzDhT8XqlxVKzjmWjNKsxaHjxEABlAqHU?=
 =?us-ascii?Q?h1/zOBwPH8gy2fJ/utxkUeKf7MpNwUac/vvuBPk2USxbzbESJ2yMjD5o+W6D?=
 =?us-ascii?Q?/Sepb8PrWzFiHnQU5/dXjEn+mFVPwkbWyN9oPDjAV4MZKGSbChRUcUzX9lOn?=
 =?us-ascii?Q?a0cpWjeSm9f4JZ/4vyEpScCk4l/JdxYD3PrfJ+9TXUuwEnnzjXP9oyqFhyBk?=
 =?us-ascii?Q?251aeYMaL7r4/olUk7QgKzm4uQ+OSRK6s1uuvkeRzShO/Mz0hj+Bjq6ZKmoo?=
 =?us-ascii?Q?NDnFuMmEvewNuKSuF4K/3fVweYsUYWsBy7Mjo80enNHQQpb1dc05SZY70dcC?=
 =?us-ascii?Q?RH3ZWD8Z0/XSRbFCzWAWQcqfUeiQWWS+Z5mPro2TZH5I2bNm62gaQowN47+H?=
 =?us-ascii?Q?PuEzu3pFO6qPmVS/GEwivsGjUkSluWXSKIcLnKouzl9uujyKum7HeVIFir73?=
 =?us-ascii?Q?X5EUXZ1jfHM0Gsf6/Q3duDS39i505y2gquz74PVB4wXIATpf6yIpSxvRM42T?=
 =?us-ascii?Q?scLQmHYRkZXrMu3T6O4LIwrggSIaS93dwYyi/dVT+s0Edsiu6yQj7kJX2Jkd?=
 =?us-ascii?Q?6RG/Dch8G61mkukar9xjjcsf7c5SQruEWZpeWSGGQxo7VA4839CqjkyLXcjE?=
 =?us-ascii?Q?RePFTxal4vN19wABt/ketwdgAtJ5Fb373h6NRk/w4AvEQ/84q9uIj/hve6BO?=
 =?us-ascii?Q?qbWnQp12L8II9gL1eMOXCggL35WnCpgiPpGYbOR23YzP4FSMzc6LHpid0ZoJ?=
 =?us-ascii?Q?R93txA1nbY7NrHVGkFAv7DeoVGhlZlk+9km07Qv9KaUFpZ4W3KObS4xtoqY8?=
 =?us-ascii?Q?jtkFDpnEAvfhol18bYFsFTpCdF9zuU+LP594zKSpTe76sw/9IvQauEsMrPws?=
 =?us-ascii?Q?gDrw0YsAxyeKKfxWUWIvbDAh9UQ1q8Jhyopv12P6l2gW+trrT9KrsgeDOlQB?=
 =?us-ascii?Q?efff5xQucCL3SZ8R0woxUl4RljmhhVldGMBkuSZ9FM6D4KFoBPtD5ysrv3MD?=
 =?us-ascii?Q?/JYAvL25Cc066SxSbu2Zfkj73JdL89qv3UUTahFSExycvasuuQOPMrn9AOXr?=
 =?us-ascii?Q?e+xfjqJ/5ZygcPSWMxVtHqN79005XqGlHSlGoOZyeNKiQYFZsc8TwXShytMv?=
 =?us-ascii?Q?1Mw5+5zDWbS2CBEt2096yG765kbDskbQkthsCh8BBi+mTJoQxWNVWlH4dkhI?=
 =?us-ascii?Q?9RZ3znyi9zmaDfcb3ONRebXXNaJuiSJDQJFtAJLFWwYzwyeGnRqCqZbA/i7X?=
 =?us-ascii?Q?5BQuYkp8N0Wzw4vhHq2w/cVY/RCltqLRrKcJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oKd7GD1+sXxbYPn6NpOkrZUEp4+rdP4K3aMkwPVrRbLHjRGRH4a9cfVAI84V?=
 =?us-ascii?Q?BVFcf0oD9y+OIFvf3QMrTtnOHmHqXAOv2TCPtQeTVvmRBrY9E2X2fHeYXoSL?=
 =?us-ascii?Q?mje/dv7sp//p4wN3xCVr9/JWU/b1d4auhcCgjfpNjcMCDUuwpIiHYxsrpQMp?=
 =?us-ascii?Q?VlfbJMff62UbXPcrqq5N1gClGTuOMSnvXVrm+cZvn1nUzdIHNg4J/hD9WumG?=
 =?us-ascii?Q?f2aUKUTLGy2yBQCVazXNG+AoKKbFUbDWd6mP9+B6gWQBpw72dunrWIbfYdPC?=
 =?us-ascii?Q?cLRJNUXdv5tjOKmApeSEyOXyOtAUYbz/vtUS3ie1QSnea4HqnS48OvHjJVmn?=
 =?us-ascii?Q?u5LO2bN34f233bkFeFqsMZwf38eCRAZ+VLhSx54zZbyDdVx4SrEM3GlAL/Wi?=
 =?us-ascii?Q?LEp/42GEwC/1B6sVQTL0lwNILL4WF/A+8bhcHBgN2ClKia5Idn5no61MpL9L?=
 =?us-ascii?Q?wMghWFdTzFKoMpliXzpmfewqj0rvZMwJRPe0sjszKiVSIMa5ziPJZCGllmiG?=
 =?us-ascii?Q?HOrgOxwtaE2yY+lwH6MGj9XxLLD5hvjlCtDWUKf9f1YyoZ4OeU6YvcMRSSyJ?=
 =?us-ascii?Q?vNGqqEeNAG/yBMyK2vfGNU9566dWgOPogui+YTZMIVD4n+r3L7lRQsjK8ORy?=
 =?us-ascii?Q?cTGo4aH2uHGhhsJJL2ZEuFYYuLBeEMIFulNW6pLIS9L+EqeexCXpUyEu5jcS?=
 =?us-ascii?Q?TPpywLMvSFvOHZTL2/sC6j8xmpWSH95/MldYf2Ya85lOEU+5FoBz6fYBA0Kc?=
 =?us-ascii?Q?7uCqQl5aoBM7T7lmhFRK7tIyPHz40KgfvP+4G9mQ0Q0yYKeWtXO52ybj2rgN?=
 =?us-ascii?Q?qPe4W98bh9uLX/YPpcUmXkMh8xSsSznv0Bqn0vEgW8vu7Q/Qj0t2FTRyZgRf?=
 =?us-ascii?Q?ZRWz3KCS8bhMXTrAdPJEVFmDKZL03VlTg1zC012Om0Fg5K8xH7WPFXsXNw/S?=
 =?us-ascii?Q?GD0T7jh/O24L0+dpo2DSBz68+WrF0P52zulPiblBgtIIks3btaDhRtC3my7W?=
 =?us-ascii?Q?bObSiernYVXn2uPiSLZCbo/Z+cH5iOOVQ+OEiJ1gHqoC9h+ZccqxdtbzyfEV?=
 =?us-ascii?Q?OJHqoazu7aUdPL/NZFakne6DH0xkZVsujjmnhr5Uenrwd3gUtvCGUCmzUiq0?=
 =?us-ascii?Q?3uRJh2hSvNbS87lHz2YsvIvrZdnqF+iq1f3GChfu0Ws/Zs+FrY0nRW9DTz3Z?=
 =?us-ascii?Q?QImJgY7MEz4Hl2vg5uNUIxPHQ+/eFZAYZYVz0M9caRFAD/IL1XIggi/1qEJH?=
 =?us-ascii?Q?sZY4+O27aAst341g/FT8o1HcnLcVufQbEXLYDFBttZBBPhBNmP8sPT3tg8EB?=
 =?us-ascii?Q?5mQMK8llcF0+g1EEOk1TWRSfHEl04vccfYywTNafqb7s+TD1vfDov0LW6Nof?=
 =?us-ascii?Q?vAxy9sf5j2/6QHQBt/ieXu0MOHrZZ1mD2xSeUwpauwZ1UENU8u2PrPPqhHpX?=
 =?us-ascii?Q?D9wL2H80/ez8gP/ZIlPjo6WckuCAuywMOD0ibP1CzGApAs/4GDxWEBJCs7Sw?=
 =?us-ascii?Q?Awpqc4AdS3tDqdWdSkCHoBMxOGAdwQs7NeP9jMRJfW9F4YzI6/Weu7LIKRl4?=
 =?us-ascii?Q?GD90QWnZNqJsR4M+yajLLMurSI8J5Wx6LziaRhtREYwlD4G689ju7oGx21IH?=
 =?us-ascii?Q?hg=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f3eb1b5-c0d1-404f-80c2-08de2ffd6f96
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:44:27.9586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6t+gOAzk9V5prdq665SFedDTXlVxYMk6H6HVbNErdQQkCT+R9MAN5wYbdQFP+QP9kzYvVm1DINjxWkgrSW7W3Q70uTK+u3+MLzDG3e4CsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4235

Enable on-chip XON/XOFF software flow control via EFR[3:0], and configure
XON/XOFF characters using dedicated registers.

This patch also implements throttle() and unthrottle() to handle receive
pause and resume based on software flow control.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 62 ++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 197d016354c9..ceef6a5e677e 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -41,13 +41,31 @@
 #define MOXA_PUART_SFR_950	BIT(5)
 
 /* Enhanced Function Register (EFR) */
+/*
+ * EFR[1:0] - In-Band Receive Flow Control Mode (Compare XON/XOFF):
+ *	00b (0x00) = Disabled
+ *	01b (0x01) = Recognize XON2 & XOFF2 as XOFF character
+ *	10b (0x02) = Recognize XON1 & XOFF1 as XOFF character
+ *	11b (0x03) = Depends on EFR[3:2]
+ * EFR[3:2] - In-Band Transmit Flow Control Mode (Insert XON/XOFF):
+ *	00b (0x00) = Disabled
+ *	01b (0x04) = Use XON2 & XOFF2 as XOFF character
+ *	10b (0x08) = Use XON1 & XOFF1 as XOFF character
+ *	11b (0x0C) = Reserved
+ */
 #define MOXA_PUART_EFR			0x0A
+#define MOXA_PUART_EFR_RX_FLOW		0x02	/* Recognize XON1 & XOFF1 as XOFF character */
+#define MOXA_PUART_EFR_TX_FLOW		0x08	/* Use XON1 & XOFF1 as XOFF character */
 #define MOXA_PUART_EFR_ENHANCED		BIT(4)
 #define MOXA_PUART_EFR_AUTO_RTS		BIT(6)
 #define MOXA_PUART_EFR_AUTO_CTS		BIT(7)
 #define MOXA_PUART_EFR_RX_FLOW_MASK	GENMASK(1, 0)
 #define MOXA_PUART_EFR_TX_FLOW_MASK	GENMASK(3, 2)
 
+#define MOXA_PUART_XON1		0x0B
+#define MOXA_PUART_XON2		0x0C
+#define MOXA_PUART_XOFF1	0x0D
+#define MOXA_PUART_XOFF2	0x0E
 #define MOXA_PUART_TTL		0x10	/* Tx Interrupt Trigger Level */
 #define MOXA_PUART_RTL		0x11	/* Rx Interrupt Trigger Level */
 #define MOXA_PUART_FCL		0x12	/* Flow Control Low Trigger Level */
@@ -152,7 +170,7 @@ static void mxpcie8250_set_termios(struct uart_port *port,
 
 	serial8250_do_set_termios(port, new, old);
 
-	up->port.status &= ~(UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
+	up->port.status &= ~(UPSTAT_AUTORTS | UPSTAT_AUTOCTS | UPSTAT_AUTOXOFF);
 
 	efr = serial_in(up, MOXA_PUART_EFR);
 	efr &= ~(MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
@@ -161,6 +179,21 @@ static void mxpcie8250_set_termios(struct uart_port *port,
 		efr |= (MOXA_PUART_EFR_AUTO_RTS | MOXA_PUART_EFR_AUTO_CTS);
 		up->port.status |= (UPSTAT_AUTORTS | UPSTAT_AUTOCTS);
 	}
+	/* Set on-chip software flow control character */
+	serial_out(up, MOXA_PUART_XON1, START_CHAR(tty));
+	serial_out(up, MOXA_PUART_XON2, START_CHAR(tty));
+	serial_out(up, MOXA_PUART_XOFF1, STOP_CHAR(tty));
+	serial_out(up, MOXA_PUART_XOFF2, STOP_CHAR(tty));
+
+	efr &= ~(MOXA_PUART_EFR_RX_FLOW_MASK | MOXA_PUART_EFR_TX_FLOW_MASK);
+
+	if (I_IXON(tty))
+		efr |= MOXA_PUART_EFR_RX_FLOW;
+
+	if (I_IXOFF(tty)) {
+		efr |= MOXA_PUART_EFR_TX_FLOW;
+		up->port.status |= UPSTAT_AUTOXOFF;
+	}
 	serial_out(up, MOXA_PUART_EFR, efr);
 }
 
@@ -195,6 +228,31 @@ static void mxpcie8250_shutdown(struct uart_port *port)
 	serial8250_do_shutdown(port);
 }
 
+static void mxpcie8250_throttle(struct uart_port *port)
+{
+	unsigned long flags;
+
+	uart_port_lock_irqsave(port, &flags);
+
+	port->ops->stop_rx(port);
+
+	uart_port_unlock_irqrestore(port, flags);
+}
+
+static void mxpcie8250_unthrottle(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned long flags;
+
+	uart_port_lock_irqsave(port, &flags);
+
+	up->ier |= UART_IER_RLSI | UART_IER_RDI;
+	port->read_status_mask |= UART_LSR_DR;
+	serial_out(up, UART_IER, up->ier);
+
+	uart_port_unlock_irqrestore(port, flags);
+}
+
 static int mxpcie8250_init(struct pci_dev *pdev)
 {
 	resource_size_t iobar_addr = pci_resource_start(pdev, 2);
@@ -284,6 +342,8 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.set_termios = mxpcie8250_set_termios;
 	up.port.startup = mxpcie8250_startup;
 	up.port.shutdown = mxpcie8250_shutdown;
+	up.port.throttle = mxpcie8250_throttle;
+	up.port.unthrottle = mxpcie8250_unthrottle;
 
 	for (i = 0; i < num_ports; i++) {
 		if (mxpcie8250_setup(pdev, priv, &up, i))
-- 
2.45.2

