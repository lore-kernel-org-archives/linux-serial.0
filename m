Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012050.outbound.protection.outlook.com [40.107.75.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583B0289E13;
	Mon,  4 May 2026 08:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884599; cv=fail; b=DHr2ICGM/aUBafxe0H7EauJ2gR5UzB6FqmOt8K7mvyfpE+ffepoUcJPtUIAzt0qbl5jdVj+99RO8FegE4WjnTKF/a6avQR+5Q548YQx0eG1xIuCG22E3T3crHYThOlLJgcavixkqaXuXixsl2RHP1pmmdeV/n3QtVZ963OOBG1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884599; c=relaxed/simple;
	bh=Q2NPefM+XTAlTxFpry0yqkUDQjQzXQiF2XYIUziT6Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mxZnC6PaKHG6EghZUDCXObDLXnSEACnybkbHR+PhuRMXZhAeWPR6Tiqrl9k8KVZH91eVoeViJOD2IgvusmkTBmmI7vrvPe5Yu07h+4Dr/8aBFxJ7TXHr1o4w/7OeCUHc6KdxKQTU16opAwX1dvHE4p6ChO5zUOx/NtNAWvaH3sI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=hlHUZJvz; arc=fail smtp.client-ip=40.107.75.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="hlHUZJvz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmDFMBawkXHe1mXJUnuplF7fm6xAmwmmdmCufe/aM0+l8MRQBAa6EoVrA0zMNKFKzv7/gGMzLQ94PuFkSgjeJAkKvfpA+0EVBlRiwO0u4xgmcUADfvmAzLyzdAPWl2yZBeKpPYdB8yLBN9/exZV9PqpuUkfCXxitjYDusEnshpAo+CeziM5f0jt+h7B+s3Ax/MUZac+l0jeEhIlcbwCv+79KZgkwXiybuov3EkTvIMsXUde8Jc+urh6m/tquphOHoVqfzBfVK0+b5tq3afLE73xvBrjLtkNy5VPmlKWsf98MAGSwyaVjCb+IjU4z2LZmTP12rEoOs+pNLsXTlAnh8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tq635nznzQtPAcBy5oMtd4det9IAJRxHaNajiZFYBwo=;
 b=AeqpdzbiPQk+4EFUT46+MStKi2zm5Ow4DX12ZsRMsoQpiFkdSqCE3FP8R4CKZkAYrOsY1u0RjW4/jzLqDBAkh+9CeK/NpWaqCpq6+lCXTf50e8koRkO2tc0WnSg4jzVzj0hVam3gl8R+8nFx1kgypMW5srTyiE+HjIE1c/wM29OceyPj2st6j1m9hqR72FTINBpu2tFs0zh0AAVOCcnKOUnrzu+b1+f3Yigk7uFqA+PkCYzk5AH8jpMpiBkS/IpNNxOt30VMTlgNnaoonKhjMKmL0Ry/nZdt/sYhNbYtsW+quqcM5uY0yjqs0rjY3eEgeaDEjrPY9culFu07xlcgaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tq635nznzQtPAcBy5oMtd4det9IAJRxHaNajiZFYBwo=;
 b=hlHUZJvzxD7bfHeUUauGlm+Sxsoo3ScjKMiSJUPcTblH/MS2MfuFIHos0b9wQpIILfz6IRZxlgEAYJhqCayRFGzdgUJNBG0c4vlXHFE11UwoUFkCElKkU0DqRXKhAxc0F+M7F1hkUtz64ol/8EA18rfBX7k4Ccu6IRv+gsOcgZw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by JH0PR01MB5516.apcprd01.prod.exchangelabs.com
 (2603:1096:990:13::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 08:49:55 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 08:49:55 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: crescentcy.hsieh@moxa.com,
	fangpingfp.cheng@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 03/15] serial: 8250_mxpcie: enable enhanced mode and program FIFO trigger levels
Date: Mon,  4 May 2026 16:48:48 +0800
Message-ID: <20260504084900.22380-4-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
References: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0040.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::13) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|JH0PR01MB5516:EE_
X-MS-Office365-Filtering-Correlation-Id: 93580102-d7c9-4316-4fa6-08dea9ba1d16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	72Ec5+isOeefyE9aRKjjGv7NtA+IA1gr+VCn8kR4JHRq2B+YaNjpEXGSUno9YDhnUS3wMgv4KX4WFyELwjK5M3JNtFh8hiW9/e+S6rOYUC6gf9f36kk7Ogjx6M3p+ORYASxxKRkA8+D0nrOVgSoc70aUBGUtCi9/456v8fLv2iPh5UknGzpBBOm6QixY8VbQvuRV367W+bXk8G1CSaZ2njyevSFJbISSJMHE5XBtQrLN0LPvNmlK9zvRSM54L7eH3a1KhQkscYv+Rr/gpVErgjnTj4lLaHDLFhgvXtOshhWv5HVXX9XGQqe+YVRHv7Z7coXWJ/FShWTKl/yubYPvxGqF+ocVxQ1sJnoDGacdByaeVNHOJLpneWHOxdd+4hKsB1GSGdDH/VtswLzUSV0hRTIb75LCBkbF30ripbViHm/zwh/ZS8oEhiXYBv00G1orjiCZkXJJinlQNBzff15FI5U77NRCZd7xY66gwhIht80AQh1L3PEiOaDTI8m8R0kFjyUjh7dnSSnHAao1so40SoPvYn8RLDtXsFzXHA0mQhnkNmU6phsKZp0KhhVBv2vn+0eRq0kCZwYABeDrYXMLa6PtRUbjE56y+32qhDrnCGfQ/WFPbTJFzaOWJONGZ67/+2RVNdh3ZFzjuadziPVkrZPBJ6T+Y4MFuBR6SUssTeP+kvHaJKQYkYx7wLoMByv8akUyF9emuzOpeCLwW53V8Xn+ykZoHL5UX8NJiziveikKCGIyRJIWHnDZcklOSOM7
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gd7GWLHAMfC2/VKyBIi9TSkfNmty6zqQ9c5xxbPW+kUDri6R6g5qfzSeRP+t?=
 =?us-ascii?Q?fYNcRW3T+5D2XA64RQNyQBURHfNolP2PIfB9z1PS6/dU6Vr0hKqFudCK6Ry8?=
 =?us-ascii?Q?9koaakeUE2pP+WOpDIuvLvUuzpqVv+bVAh4r7/FPcdEeIJNFB0oxiwWh4k6V?=
 =?us-ascii?Q?9c1+nEuFM1+C2edBP/YLxu5smfQNJDy0v8lSC1O2GQQfUn+zAhQlIME3rOVm?=
 =?us-ascii?Q?T2hMDXJK5Ft6jdJIRfIeBJCC8JSIPlVo1G+LS0snesa9XNb7fOpipYXAgV6u?=
 =?us-ascii?Q?8iya/kXrIgBzX8MGaJ58cNeRGqOZiJrMpryNWeOFWuisHZol7K9rq/82D1gc?=
 =?us-ascii?Q?enIKX4SDpVtGD4rH5IUqAZf4h+8vQKCGSDelMdM6Tam4uJMhht2Ba5LQKP8r?=
 =?us-ascii?Q?BtjJNnJDUmZDxEi/66Rc1nqP/qNal2VLA3CocItstz+EDY64oh0U23wYDFjF?=
 =?us-ascii?Q?slOorC2icrA4GNcA7C8k/seCwqQvmSDUcFIC2LAu4BkOCwZife0hsEW8bJlo?=
 =?us-ascii?Q?vv9AEa5VKSKUq3v0+zFm294hDymyLZpXDtLZv7m46x6Hise4J21oOgE6curM?=
 =?us-ascii?Q?TM+xuepXhKum8a8+DgzaRhpyaPlEcK8yNqnhVpMIfnDsMRJGEbpiEnVflqgc?=
 =?us-ascii?Q?DuH/UI6mNZVOWLZtMQuAfr1F2PyKEMdmLYtbL9rKBEMnPu3ioKEvQMhU5VlF?=
 =?us-ascii?Q?x/rI6pzVR4KeY+F5sLZkSaSxjUM8tTQY9LJNllXyzxdSdSnAQTrqQye7x0i0?=
 =?us-ascii?Q?kDlxqTYO/0/rEYn0Xl5gt+k54bUzScXzDYcQ3Rjuk/8B2l5/UnALr+C5FgrN?=
 =?us-ascii?Q?Gt06d/6IF9o678+thxFJ8LjAiTiU0EytVRP+NK6RACKMSO/t71UkWSYz6nPd?=
 =?us-ascii?Q?aEXimo6ek2vKF/dbk3MO+7DWMdx/wLuH/ELUvOpFlzWYvKBzGhuY+sCcNe4v?=
 =?us-ascii?Q?eTuMY+NxnxFCWXD/2Rf2YZLUO7ZIzwnlfxJ7rLS10I6V109hQ0AxU+s8Z8bx?=
 =?us-ascii?Q?JcJABUsVWN+XaXmA/j+sEHRnYK8A44cXNiscUoamNeP12d1rizBrokIEfsWO?=
 =?us-ascii?Q?KkdqfoEtmk52RKBm3ZMjH9Nd3PIreekGdtS+PvLNzd4c74uHimqpScqbcR36?=
 =?us-ascii?Q?SN/KMbDLRpo16nsAjXDMf6IBkEjT+/LOT5lyZKWbqjKj30OOdzfmRWfWIhG1?=
 =?us-ascii?Q?vJFbruVW4mqGWsW359K3xxNeYnfgUr9yoXOnFJuSeaTf1DrDcxdtF/UHjiKV?=
 =?us-ascii?Q?4/ahzINQDQMHEhPZDq7xtIuoX2A9qXVjgRkxMYPuP2v4rgzWewiGYY7W48Kf?=
 =?us-ascii?Q?5L/T2e1uN6LK3DaEKvFs9/jMOowDd9gnt5V2PAL9+uc+s2Ly8jiKmp1mnC3a?=
 =?us-ascii?Q?NUOrmT0bXNIG5+TSha9y/HBhoQ7Kq8EeV5WK6PVwChI+Tf8iVR4qUmJ6L5hQ?=
 =?us-ascii?Q?7FmQLsChK2G2q5NwnfJPiSs1CjoJ6t7NHnvi3O1hgvPdAyk+mbYtUGTOIoNL?=
 =?us-ascii?Q?E3j3J3ohzKZANJTnO+uyReIis1vsYWgoIrVIRdjKEk1jE+s6r5VnFs0s/U1J?=
 =?us-ascii?Q?8wvV1LUVRU6s1iDjGgnMfvC/V6PCggbpka8JFH0lS3Zl642tjjjlIhanvAtM?=
 =?us-ascii?Q?s09GQuLkT0ALizt23vXcpKAqCyMlKnnKfLD76Qvj/lew8ufTtZYDBNlQdFcm?=
 =?us-ascii?Q?Nsd2KWufMBKng3RAEX+Atw4q9ZXPVhUBQnqt60uIYyROnqBLxl+seVhzg6GY?=
 =?us-ascii?Q?xUdXQ5ZHiFLgsCnBv0biWl8N3Pji64s=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93580102-d7c9-4316-4fa6-08dea9ba1d16
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 08:49:55.1846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUuHJL/LlKC6/4esH8ZzILg6rIlmZgUomNnBzrdPd39gNRtHnnhB5d1JC0gCqKiu2QyWBVTVMn+hB5/qxQCAE72TwHM5O/8ps5uTrzepWyw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5516

The MUEx50 UART provides an enhanced register set and programmable FIFO
trigger levels for RX, TX, and flow control.

Enable enhanced mode during port startup and program the MUEx50 FIFO
trigger registers according to the configured port settings. Clear the
programmed state again during shutdown to restore the default UART
configuration.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 50 +++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index ec91db1a3008..7ba96a954bb1 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -49,6 +49,19 @@
 #define MOXA_PUART_BASE_BAUD	921600
 #define MOXA_PUART_OFFSET	0x200
 
+/* Special Function Register (SFR) */
+#define MOXA_PUART_SFR		0x07
+#define MOXA_PUART_SFR_950	BIT(5)
+
+/* Enhanced Function Register (EFR) */
+#define MOXA_PUART_EFR			0x0A
+#define MOXA_PUART_EFR_ENHANCED		BIT(4)
+
+#define MOXA_PUART_TTL		0x10	/* Tx Interrupt Trigger Level */
+#define MOXA_PUART_RTL		0x11	/* Rx Interrupt Trigger Level */
+#define MOXA_PUART_FCL		0x12	/* Flow Control Low Trigger Level */
+#define MOXA_PUART_FCH		0x13	/* Flow Control High Trigger Level */
+
 #define MOXA_GPIO_DIRECTION	0x09
 #define MOXA_GPIO_OUTPUT	0x0A
 
@@ -133,6 +146,40 @@ static void mxpcie8250_set_interface(struct mxpcie8250 *priv,
 	iowrite8(cval, uir_addr);
 }
 
+static int mxpcie8250_startup(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned int i;
+	int ret;
+
+	ret = serial8250_do_startup(port);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < 5; ++i)
+		serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
+
+	serial_out(up, MOXA_PUART_EFR, MOXA_PUART_EFR_ENHANCED);
+	serial_out(up, MOXA_PUART_SFR, MOXA_PUART_SFR_950);
+
+	serial_out(up, MOXA_PUART_TTL, 0);
+	serial_out(up, MOXA_PUART_RTL, 96);
+	serial_out(up, MOXA_PUART_FCL, 16);
+	serial_out(up, MOXA_PUART_FCH, 110);
+
+	return 0;
+}
+
+static void mxpcie8250_shutdown(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	serial_out(up, MOXA_PUART_EFR, 0);
+	serial_out(up, MOXA_PUART_SFR, 0);
+
+	serial8250_do_shutdown(port);
+}
+
 static void mxpcie8250_init_board(struct pci_dev *pdev, struct mxpcie8250 *priv)
 {
 	void __iomem *bar2_base = priv->bar2_base;
@@ -227,6 +274,9 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.iobase = 0;
 	up.port.regshift = 0;
 
+	up.port.startup = mxpcie8250_startup;
+	up.port.shutdown = mxpcie8250_shutdown;
+
 	for (i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
 
-- 
2.43.0

