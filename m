Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013064.outbound.protection.outlook.com [52.101.127.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C2C2E6CB8;
	Thu,  9 Jul 2026 05:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575242; cv=fail; b=QCjgKnzS6H+dy2gd/Yf13f8NQIlWfEKN6ePykUxWclr+IRyrl0IA9LG63/U5DvmoGpcj1ZrZqm7NdbcpcNTrkh1fsTFlD2nSS3AEFcKacR2CUFwMVMIVhwYK7pm+vNA3cv1TC+mSuE7hj1yj7qz7kimivoQ21HKQXdVmYbop6A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575242; c=relaxed/simple;
	bh=cnCbMMCDOrcK7YaxO2R4jtomu9oNBRcxIA9psjl4dIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lyj/jdpHSuE03vNTRy8fc7cBLth1dd5A6GpjLo2scaTMIg/+/aBfmMSG2QN+vWVCHS1/nuPrPEfZVWvEgvulRp6EWW0k/1XBUZNRsFy9kDlzaStM9/RvhDzq/8nYryGB6A9IsW1ojwlXCjIi9AP/k89lu+3y5hRzWtASr0DDz6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=CSKolW3c; arc=fail smtp.client-ip=52.101.127.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="CSKolW3c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aW79xFqZUlx1yWoBad8BdjXx/FEn1fNokOvdoO2h95MEpPMHxwueX+vqPAl/b9xHyIXqzsrH604KIFknZILKeeptHWdmas3aXENvNmJKqRIZaNI9mv5gRsI0DiCTkJ9V1k4KyZYRZXmkHwEYeKcafsyMNX7eeC6bTbMsiYPwCpqbiw7Hp/cux+HAgdFxxNAscPxfN4xAFBYox/5qbkYG1DgMB6hF/RgDYo3HT5YjzqyiHyKYrM4BGdRvr+OYMic9cs4sH30sw0IRIvxUZw8ctl641fgCubysoKLAqU6uOUxfzYWXrzp23qe+Oi6iuxHlSC19XQ/K9q8tb4W8r6A04w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkN/xVOZayd5ms78+Zpi3kZiisN9jpJR7USHH9C+384=;
 b=qcQElxaVnV2zmulPJPrhvLXz8vGDfEW0LTqjJLaV24t7ol0Xa/yLfsr9JvWJoVirilnWawtu7H8uwacDd8sNbhoOGXgBB10QKgQHBtcWHoRkW85zY1oeEvuPKaTihCA5o4gTwsOMUVqthmnyv7PDIcZZf960BCcFAAC44eik9+FzK4FflNmfMdwRitDqpxH+BNJlmRy/lmf/Qw790s/ZqiRs+Z8aKjxg35TCaG4KR+xSSoHsNjIzUmU6KtlXPmA2wUKqbM/ByYQn0i/oWQm66dbPmLuM08Me10ZUAsZIyagqq4YiA8Y673jJXquauSJIVC3T0Uc84jB159ByxmiFHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkN/xVOZayd5ms78+Zpi3kZiisN9jpJR7USHH9C+384=;
 b=CSKolW3cauRCt879jvJjIYzk5BIWehZ8VCnyMTRzrFBWIdGfw2fILCYBTIXtI4GSBOHBL+xsmjzrysGNKV1/HU8i0tCc6Gc5N+m/bksOGbd6c5mdfgh3hbNUm0Wq8zsIdV25B6HjVJzhzy3yZaHglM/M/xuOfpUq3y68fn38Di0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6) by TYZPR01MB4610.apcprd01.prod.exchangelabs.com
 (2603:1096:400:260::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 05:33:54 +0000
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec]) by SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 05:33:54 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 04/15] serial: 8250_mxpcie: enable automatic RTS/CTS flow control
Date: Thu,  9 Jul 2026 13:33:03 +0800
Message-ID: <20260709053314.435629-5-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
References: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::7)
 To SEYPR01MB5387.apcprd01.prod.exchangelabs.com (2603:1096:101:d8::6)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB5387:EE_|TYZPR01MB4610:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cc06238-f7b3-4fec-b19b-08dedd7ba991
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|52116014|56012099006|22082099003|18002099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	o0p2ZVqlp6zXJaRCu1bdcEVeNY+mndgTKE1K/ML1H8KJWmLw9s7jhXr07ZQ7IQlLDfNtsMzhoHzix6tmCdlDZ+WqiCGJd+tAu0cNY1QQk4XOFyYJVkvk4Re7RHN671gmhE2BM9dQlzZujY37iUgfmR14MAIWJP0Bu0MdW4HlCmqUzk+6Wa5I1h6yASiTh+YXdUeX+gGWpmad3ZuBa/f+BX/pp6Ef2kfOzZp2WMDH2DDufqgp7mxbGK4dytGIJOpqdu2eOgo6jvCdPnpIqjzGbOTPUB58qL5LnhfWUl8N0tIUuwNM+Dgl7n4eHkbU6KFotBvtx54GoWQBNH2UaednVExuXP6G6c9cv5D1k7ru2uxMOET2+O5eA8Ou1O+Xyzdk0GmwTAZddha9V4NGRddHyrgAy8YtQ/dEIQ9Ee08kOLKpdDDjS5+qW+HooK1mWDhF8c+k8Mvcw0qlLU1CZdmwv0p1wSkbgQNiNBgioeETin0dNdz5in8N+efEeN3Q1MpyQsQxo9QsoYoI9Fj9FQDZ7jrVu0Bf3YTvq+1H19OTHtcMOyOuQk+WgpeX77S5O6VudHN//TVv0LEqmH7W/5yHIYqWf+ci9ln+GeDxm9jygtniVNc8HjPqQbL2vgHhYBXWhCawIHzE9ZNArBBKHnI+ZR6wVLhNPydT4+vZ9ZBeCKfX9L1Ci7z6ukMu52AURsNoeS9HYo9Q45odUU7JCJqK1/Min3qjb6768A9enne4wAc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB5387.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(52116014)(56012099006)(22082099003)(18002099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gM90Ct/T8vvksuFWB8HSifFsNIizJkIYhvBQBdIi8/DfHHjVnm1cCjjDw8co?=
 =?us-ascii?Q?crYsBeVlhGKhkJlVEbuJFs2DOK1XehPs2vINALQZteXehlRRixMdQn9VuJsu?=
 =?us-ascii?Q?Bg/24HSSJhyZutAtQqzrjjAbE0SWo4lmblvDoBmhf5LhZ7xiJ/seDpnOHitm?=
 =?us-ascii?Q?zxC0nxGevRbQ0PMgnv8HiVAdz3H+LCegwRScP586UkMMflmG64MhgGA+ujAq?=
 =?us-ascii?Q?uvej0fN5tomJ+jrTG8hbLtJ/FN0PZuozvWqSCMFQlgWixMCQYXGuRUauD0ZS?=
 =?us-ascii?Q?/ueDc46YgubnwjZy6GXqSrtiyEeLp/8c2xNIlFY5nTisbLgZfbqwFYSaMVp9?=
 =?us-ascii?Q?xplLt1PlxdxmVKgCidTuP6JuL24Co077aBww+oGpC6Cpp8WoZEtAu4y85T0D?=
 =?us-ascii?Q?d2yREK1Qhv1w41bXBs+xNLBi3bzhC4C/86fTd8Iw934FEPb3V24r92chzfk3?=
 =?us-ascii?Q?BQehnjKRYaULmB2xbc/Q5kzw694vbcpxhBaDQMjJWIbdVIRY6z0o7y4f6upR?=
 =?us-ascii?Q?x/D9Kw06YMn1p4hIZixy+cZkkJp7cKWRqu84xWCj3OXEZEKhOEDIxejqsnp9?=
 =?us-ascii?Q?DZBXrh1pr1OKmQ7Hv1xSei6qhmrABx7sAinHCx/Z7fxtVgJq7EcZPX2w65qP?=
 =?us-ascii?Q?Wo5tqG6rqo3L+SdibHOVhdJflWtx3J6mQG8q8NrX5iwFRIvVXH3JECBjh1Zd?=
 =?us-ascii?Q?oSjnWu+LxyoEXcaW5sB5EYZwLYAo2CHoQQOwyjl2SXh7v+lICPJjA/hJ/nIS?=
 =?us-ascii?Q?VJvo58QInKDlr9gJcs7nhZ58GE2Mti9koLNOEqPiTmFuSRu+a0Ths/AjAA9o?=
 =?us-ascii?Q?cDxGurn3Q4wcKul/uVLNHKRrWj9CEy27OK+ubeXYKYjb5QYYOQTejATQvrfD?=
 =?us-ascii?Q?qlc45Idy9KWnJtXL/fLyFumpS+qvaokiCmrWLKKTeIB56p1jhEa2Tcj7/zmB?=
 =?us-ascii?Q?5EibyzAD+2ZWOefpkjH2nAQCkjVFmzpl67oVSBoK1ElbTCsda2YRGtzZfTY0?=
 =?us-ascii?Q?SGUtL9kKStNIjDSuH235O6WgLr/F6z/jYAVVe0dCFZIhMsLlaVMpzjiD7Xny?=
 =?us-ascii?Q?985/OvpArNd6PTzqyG7NyHA1pfh0mdPoyZk4IN/6OtHE+DiWXiEKpkiFvM5s?=
 =?us-ascii?Q?DnCelIuS62n2cQKfPHKBcb7qpScRGkMhUZv7mn0knFPbyT1qlP7sVuOpR2vq?=
 =?us-ascii?Q?eFcxy4ukf4CqMb+8g6Iabu9hzXL611/7yf/PgQk5nIW2xaj9QS7+YL+lYG8I?=
 =?us-ascii?Q?SA0J1KDRCtgbE4vG4klD6RJ53+gvbJLnK6SYfnMsIAPpG1FqgUmIuDcVJD2f?=
 =?us-ascii?Q?zrCq15iqjnAU7NDULlXcQ68J0SyGgPQb34WoJdAYpv9/JR8UEmARWzb1ZKVm?=
 =?us-ascii?Q?3RUR4D8BjtPW2GV/vk5Izg/e1h1ywzq2dm/GeHZMXXwhcvruI2QNh92yAc2C?=
 =?us-ascii?Q?ZG3hOJ3xC4O/CG7/9+YRXzN20pJXsS9Ay4NBJn3DH4vg39L8Xoj5zfVSrKqk?=
 =?us-ascii?Q?djHnUwVpiOdrWHmciGxHGyNHfXUWfBxsO5VX1InJI8JiCvk3k3rksQaKCa5a?=
 =?us-ascii?Q?eMxak5+saN29m5w154+YLcEjDwjxNoICA3MuhKUkSFMxBd5EX9IVjkpES5Jb?=
 =?us-ascii?Q?vNub0lWQkrvhmLMYecg5dbGDHBS6bMI8iXr6pSfM0y92wE0NYtMJd6ZdNEUR?=
 =?us-ascii?Q?XlzvCQLMwLVnnPO6/DVGCngwD8LGu/JwLvpyZzaj2S2suR8R3ZVcVBW3kAqq?=
 =?us-ascii?Q?+bPgN9FXmJhG1O1M4QyQT3MQ2KS2lh0=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc06238-f7b3-4fec-b19b-08dedd7ba991
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5387.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:33:53.0791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LYHW6wrNKeba2leJr7F5f8WjSfeAoDP8sxTvmyFVjJYTDkoeGnyVTUSq8O3KTi3ePWbKIPJv/QKcx9y8Q98eGgLjberjmB4Ldf0dr2V9KxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4610

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
index c1fc5eba0c58..0f5323581bba 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -55,6 +55,10 @@
 /* Enhanced Function Register (EFR) */
 #define MOXA_PUART_EFR			0x0A
 #define MOXA_PUART_EFR_ENHANCED		BIT(4)
+#define MOXA_PUART_EFR_AUTO_RTS		BIT(6)
+#define MOXA_PUART_EFR_AUTO_CTS		BIT(7)
+#define MOXA_PUART_EFR_RX_FLOW_MASK	GENMASK(1, 0)
+#define MOXA_PUART_EFR_TX_FLOW_MASK	GENMASK(3, 2)
 
 #define MOXA_PUART_TTL		0x10	/* Tx Interrupt Trigger Level */
 #define MOXA_PUART_RTL		0x11	/* Rx Interrupt Trigger Level */
@@ -145,6 +149,29 @@ static void mxpcie8250_set_interface(struct mxpcie8250 *priv,
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
@@ -282,6 +309,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.iobase = 0;
 	up.port.regshift = 0;
 
+	up.port.set_termios = mxpcie8250_set_termios;
 	up.port.startup = mxpcie8250_startup;
 	up.port.shutdown = mxpcie8250_shutdown;
 
-- 
2.45.2

