Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022086.outbound.protection.outlook.com [40.107.75.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B342853FD;
	Sun, 30 Nov 2025 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499520; cv=fail; b=ueT/lZe3V2UKunn6R2Fxh45OPAmLlaIfvYqw/6r7fiYR76RT5+KkgNv16PnrkmmMPBieUDHsFepjCEqPzvTm04quV/AtcxxAHbezJIvznvgiEpSpF1XVU3nXYAhwgZZOagE+hTb3bBikDGi/az8dF/ju7Pv4Drt4N05RqiYGuqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499520; c=relaxed/simple;
	bh=cgwaDyOBQ4el34TaxOn0h/tN8eWOwWB3+b+flIkuFoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dy1/hXKdw0NPciy0Wyy7Bs+akMIqJzPvO+1BrU4k/6kgkGoF3jLjhpNfHdEblno48QLb2z7Hw2XLkbXCCAuZBAQVTnyoIkeas/tDixQh5LW/ShvTNlM7SpwIxcv457Gsnjk7UQStf+qZhm8+O3L+PlxU54QHwoZ+VXflG44ADGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=DojhNwHl; arc=fail smtp.client-ip=40.107.75.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="DojhNwHl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mx5tMDyBYQO5vRG3SIWcL857Z0owdr9R/sIvcyxiR8vTsktwGkNnxcGl1arr1zuj0FA1qnztmjvJyUkrVhTYoTGNIOLLhEuJRHOitX4eCmnhrp+Lhg5opDklqBklhA54G0gBiEOG2lJi4Y37z4Vr4V/vWQWQ+BbMS6Ad/+MoKBbF1x4KPTEbQkoCGijWJPTrRlQzwhnYEu6Ppz8qrRiVD/MTj3KKBjtu3+2EDv+awDWlSsl9fS1l72hkOJgbwztiebJbkqfyGPuCt/CeI9PPP7GD4R72hunN0ifUNP1doH7fyqIirDHI/owPV/7245nOdNteCLo2eaRgd68C+wp5dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=thx5u1ywBYeQkGbORIeAQAO4h7KcwM5+zifq7AJZkNk=;
 b=DsGR5c2aNb/S0l5T86mSNSyJQr0DRWTrtYPNDQr91tt6kdHxmGinSOsE3j7Vfsyf6adR9FsdaVSKIoe7/10f0sGTDvDx4XstAv7UVvq25ajfs02XYAf9ovFTC/2XbBIHd0LgeJ9hyukIed+/PJwBxOHiWXlOuUu0cXum/DUe/dy5aW2olWkScwSHpLJxYxjg+fBhMScY01QDieaYWEP4xPxCZ2l/yqS40w1GTp1mJAUgivIykvj9et0mladCtGJ3h6cANKkr3JlR3HJgLsBJxWjqLUDPfmQS9Q5YXwNEl3LPfdkvRSO1JRT0pu1o93YMu1hFOyCjaTwboUXDsaFnmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=thx5u1ywBYeQkGbORIeAQAO4h7KcwM5+zifq7AJZkNk=;
 b=DojhNwHlh4XWzLVHemFVTqFDyNeRu7x8G++nDxpI5EhDzdqtbFVAOYwO492MAa4o+TEt3UuVeCx3KknsEhpvVUpVlvvO5VykUBdTqIT9moK4soibqKJQWTWOwty/cdM/ETPYIRwTovaJHCTsl7oP5LWrr19azD1TimZeDSdNmTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB6080.apcprd01.prod.exchangelabs.com
 (2603:1096:101:221::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:45:14 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:45:14 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 21/31] serial: 8250_mxpcie: implement rx_trig_bytes callbacks and persist per-port level
Date: Sun, 30 Nov 2025 18:42:12 +0800
Message-ID: <20251130104222.63077-22-crescentcy.hsieh@moxa.com>
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
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ca0788-6fd5-4abf-2354-08de2ffd8b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NmNdS/S+owyO2jQTUHVHHdRS01qZ8e0DEMIODTav9egwfcyfJSd+IDonQqvu?=
 =?us-ascii?Q?gGU9mnj7AQylUv2G64K/tD1JoFnUZ9Sf9cDb4ytuDr3YNhChCfhRXQcR47Zt?=
 =?us-ascii?Q?BOFAmRETPw9y1ocn6X7vPRfkMSBj9YhQUv6R1382sWDYJrfrd7gpO4MBTP/1?=
 =?us-ascii?Q?1f+8T+oa1e8qtYvrcEfeZ2q1x4/BeDP+EC/u9u1jlezI4EbQMMVIM16iVwqM?=
 =?us-ascii?Q?dXpaVwPLFkQ5+a9c15pJgf3fAuJr0BcZ1fSlQBNorYw4xsBXW0nQ3TfI7Lo5?=
 =?us-ascii?Q?aM9pwZQPQ6CC1ynbv33QMEE/k7jWYwz4jDlHzrSG+vpPeX8oO6WGVFqIHDz1?=
 =?us-ascii?Q?/RaWdYfj9XuJBhTmrnT9MJyEU4YaWs3JcXUlPdQx1RsH+IUEYhoPpSJorOtF?=
 =?us-ascii?Q?zDX+6CZo7xvGdHoqsGI0RYoggcyHBnDUzIr2UxcGxbYt4TePwzeo2OPuarVy?=
 =?us-ascii?Q?yrsl/Tig3X33tl8xJei6c9hx63lDlypBRaigejt9Q8UbsmeyTD2Xkq8DyBEb?=
 =?us-ascii?Q?ClelWZ8/9dytqyZjGTxO4kjbtxJV/c40FXFle57IFCCrnQSSlLhC34GYA+ta?=
 =?us-ascii?Q?X64zN82VZ7QMWu/gsUIblRp1ilYCZvO9QnLlMFKp/RZCPPcB+4I7QpBuAukC?=
 =?us-ascii?Q?kTE/oM1842ff7vJPZXpFLpPbIK2G0dNvQXKI6DAozs48Bbj/YdKGcidKMOl4?=
 =?us-ascii?Q?ltQ4GsnWfiNb/mLhM7sLhaDtHYCWYLa+3qnvfjfT5aPWFLj02J4wmXlg8W/r?=
 =?us-ascii?Q?6nyV/dR/0wg8SEOSJ5Gnwts9wzlczs90wAh/0ugES+GAiPlz6qKSX+zR/dxa?=
 =?us-ascii?Q?HG4oYSMjsO31Z+DBmRP4X4SY628TkP+ogoFB13i2XnhLC69aH8yrLRwdgVCS?=
 =?us-ascii?Q?ghfWPBSMsas2oD90StD/rytDwsaRCwWFo9BoQVVbI79BiaJRG+MU8AFCH3hB?=
 =?us-ascii?Q?QgYGCKszi/t03z//CeCDvvOI0y6rLlIbY5Ph2uQkTZ0fsyuU2Sz6VnWZGEJr?=
 =?us-ascii?Q?CR/LynZnMCXdWxZWnFnx0QCsFklY2rVFePSFDczvk8vn/JiXevYCzoKoETdt?=
 =?us-ascii?Q?6KFFpWkaJKP/J+jmpGcz/PwU/iiFvRg1m3+GkMOjjsGlRs7fFolZO5WC3gXm?=
 =?us-ascii?Q?8mbi3KPWO4gRB8ZXeLDoX2dyF296SKD5+2zXFLT8UqXe5kVj9Mdk0H01maE4?=
 =?us-ascii?Q?IVeng+wa3APnqwWW0KVEzyA8uQRUIa3YFj6PahJ28KLnOIfql5ulqtq73ImL?=
 =?us-ascii?Q?i9abMNOUQKs068gdwu2KKjHKljgepuAuAIFeUi/1n50oYJ1w7pQapr0l468C?=
 =?us-ascii?Q?Yr92yzJCQpx0Uh7aDOMXANLXela8RNfYH8lY6SPMece2AQjycC/cH2d5WcXL?=
 =?us-ascii?Q?+hDjgZg0cL6hySelBXkWjiJJa9z/dhvyIpkrk6nAThunOG9dk7GWyoMkgJbQ?=
 =?us-ascii?Q?KM5fCjOi+4NTD2tu4U3biijme2dD2TG0Vg43ol5oxFhFaLrEnKsrGai3kuWY?=
 =?us-ascii?Q?XedzTw1sHBYCJ1bO7qT03ECI/W5s1fW09uuw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4XPcXYab0PVPE6sxl4+RBGFVmtS/OtHTtBxXMVEbLWjCSHuKIisRXJzu5lhc?=
 =?us-ascii?Q?rC8Nnlol2xwtR+8xZCjxNnxvP6X0PXM1n1zUXezcMIRTf19QD1idkc0oxGlB?=
 =?us-ascii?Q?1mNHKLBj+XMxjTvFk5hc0Q+rhUKpuEtplxWe+FGPTmo6r8Tzjvuwp6f3kTFh?=
 =?us-ascii?Q?TDYjb0eLMQSxty1JaNsq6QblLxX32nQlas74UUv1FvalNNnpx3nnM1kJi4+5?=
 =?us-ascii?Q?j3rdUUuZG4mV/b/jzntjpVj8haeY+3/1iSCPAmZLwUQbjUn8Ks/4HToAM6zM?=
 =?us-ascii?Q?Ep7RKKCHYQL1oXsWKouzLdbV1uuwOUAinJZ2hX1xlBEUcdjeJpyxq6NalBza?=
 =?us-ascii?Q?U06xa5A7dr6XIcm6AprX+hDSN8OPZ6lhoGpd4+EUPH+JE3DxM6xRIUWqJ9EV?=
 =?us-ascii?Q?/N54TXsLVqF3G+Jg1t6Tg6oJo0KC+yo+TJsFuXrWBBWH2y7VfXtTewOYHiL6?=
 =?us-ascii?Q?+T22dTYO7VGTCpvZ6KHKYLpkFZa6x/e0qyMSX/sUE719yOY0Ra8e4uhyAf2p?=
 =?us-ascii?Q?sFp++OUjXbyT+SH2Ggg3n4/Kf08fZYKtU51O0AyLvxvyGy8KzpiT+2gTXJn4?=
 =?us-ascii?Q?oknLDhK3gZ+7jubxkw2YiNIc1K5ExDY1Fo5g/d7meJdsptyfCtvkuvnbAW0v?=
 =?us-ascii?Q?S0bgXnGMLLbsoaG+TVnmvHMDwgLPOgJA47Vrob8TQR7i2aWkl8bpT4NMQQsk?=
 =?us-ascii?Q?g/CVwS/XtYCd0Jfratw7fp83QKCKIchr6ITOFKDpPmYgzTLBGAvspGqJ+2Qy?=
 =?us-ascii?Q?OHYw2PMVHM5fNSOgHYuAdXGYOyh6/eUpj2cijht2q/HKJ/enEWMiGofG7QeV?=
 =?us-ascii?Q?+hSKBu1MZbYemOkW2+XMxckojuDIEpPlM1/05O3c/ba1wxpDFtgBbgkOpJqv?=
 =?us-ascii?Q?3Ql3pJr+QSuaoPbBvdPT8VtHvscBGmbyPkzAO5p+ZqUhOIjVTgUrA5R4edj3?=
 =?us-ascii?Q?fhfIeMnEGZOoiuglZwJPOolpApheBsoMC9QgPMCwocuRtPoa1TOpVbPH7J9c?=
 =?us-ascii?Q?qIceFf00KVXkyXi6DgKTRmNeSohLsqshl+3yke10YJ6o7pDQnkz00SdDL0L5?=
 =?us-ascii?Q?M7WwtWtMm5EjwCxmiFkethNSLOUckAkqORaFKa/CDHSMZ6d9tc4SjPcGHHJK?=
 =?us-ascii?Q?NSHUR7WOjO2wR7rHPnH88uiw6M2DFKM3lb6HvPKR4n64B798e/DTyDdoSNmk?=
 =?us-ascii?Q?OloxQZUBHGZs8j4ciGJaQBJnyUxjL0KA9WKm80BaKzLzenM0IHoDuLDKwWdM?=
 =?us-ascii?Q?qJ8OJ/JpxN3vAkGi+P6gETUkyf4wUjsnSMrTWa+oLjhevlcFmVlCOyNpN6Xc?=
 =?us-ascii?Q?4iVtwAnzejjRUECojBa6CNtrYzacra+4ig7x3C944VpCgeLt1wOTMYSBDPpP?=
 =?us-ascii?Q?h4UYjEPvqbJDkq8m09OrSUTtZzzka3lPWJb4PsxpWr9a09iRheyJIYOCgADp?=
 =?us-ascii?Q?Qkp6sJXi1Xr3759YkRcdKgksklyopRtSHb65FoEbSvOCPMIDkTCXxLciFWlL?=
 =?us-ascii?Q?3NiDe7hiMUoVhuUqPwx0Dz/a0fcKZdwXfVC0Su7S1wkwa0Pa7R6/J2N/pjLj?=
 =?us-ascii?Q?t6anmzM/E5kAcmykGSnXdBV38GJozj7i5DnBdJAuSlI+6gQNtPsz0YtcI0aM?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ca0788-6fd5-4abf-2354-08de2ffd8b32
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:45:14.2826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6ppCun529/MkOMS9e8WLbeKNZNPVSy5dNbbIuaMQT9VX+FZEFKpUC/btaKYWSYAhVLSsiuxYxHEPmL4UAA2VjRjpOln++rY5evw02edudY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6080

This patch implements device-specific RX trigger handling for the
rx_trig_bytes sysfs attribute by programming MOXA_PUART_RTL directly.

Changes:
- Add a per-port structure to persist both the registered line and the
  RX trigger level, allowing the level to be restored on startup.
- Implement uart_port callbacks:
    - set_rxtrig(port, bytes): program MOXA_PUART_RTL and cache the value
    - get_rxtrig(port):        read back MOXA_PUART_RTL
- Use the cached RX trigger level during startup instead of a fixed
  default, while keeping the initial default at 96 for backward
  compatibility.

With these callbacks in place, writes to rx_trig_bytes update the
hardware-specific register immediately, and the selected threshold is
preserved across open/close cycles.

No functional change for other 8250 drivers.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 49 +++++++++++++++++++++++----
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 9ba171274221..04b9c9ff5cbf 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -93,11 +93,16 @@
 #define MOXA_EVEN_RS_MASK	GENMASK(3, 0)
 #define MOXA_ODD_RS_MASK	GENMASK(7, 4)
 
+struct mxpcie8250_port {
+	int line;
+	u8 rx_trig_level;
+};
+
 struct mxpcie8250 {
 	struct pci_dev *pdev;
 	unsigned int supp_rs;
 	unsigned int num_ports;
-	int line[];
+	struct mxpcie8250_port port[];
 };
 
 enum {
@@ -243,6 +248,8 @@ static void mxpcie8250_set_termios(struct uart_port *port,
 
 static int mxpcie8250_startup(struct uart_port *port)
 {
+	struct pci_dev *pdev = to_pci_dev(port->dev);
+	struct mxpcie8250 *priv = pci_get_drvdata(pdev);
 	struct uart_8250_port *up = up_to_u8250p(port);
 	int i, ret;
 
@@ -255,7 +262,7 @@ static int mxpcie8250_startup(struct uart_port *port)
 	serial_out(up, MOXA_PUART_SFR, MOXA_PUART_SFR_950);
 
 	serial_out(up, MOXA_PUART_TTL, 0);
-	serial_out(up, MOXA_PUART_RTL, 96);
+	serial_out(up, MOXA_PUART_RTL, priv->port[port->port_id].rx_trig_level);
 	serial_out(up, MOXA_PUART_FCL, 16);
 	serial_out(up, MOXA_PUART_FCH, 110);
 
@@ -441,6 +448,31 @@ static void mxpcie8250_break_ctl(struct uart_port *port, int break_state)
 		serial8250_do_break_ctl(port, break_state);
 }
 
+static int mxpcie8250_set_rxtrig(struct uart_port *port, unsigned char bytes)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	struct pci_dev *pdev = to_pci_dev(port->dev);
+	struct mxpcie8250 *priv = pci_get_drvdata(pdev);
+
+	if (bytes > 128)
+		return -EINVAL;
+
+	serial_out(up, MOXA_PUART_RTL, bytes);
+	priv->port[port->port_id].rx_trig_level = bytes;
+
+	return 0;
+}
+
+static int mxpcie8250_get_rxtrig(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	int rx_trig_byte;
+
+	rx_trig_byte = serial_in(up, MOXA_PUART_RTL);
+
+	return rx_trig_byte;
+}
+
 static int mxpcie8250_init(struct pci_dev *pdev)
 {
 	resource_size_t iobar_addr = pci_resource_start(pdev, 2);
@@ -513,7 +545,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 
 	num_ports = mxpcie8250_get_nports(pdev->device);
 
-	priv = devm_kzalloc(&pdev->dev, struct_size(priv, line, num_ports), GFP_KERNEL);
+	priv = devm_kzalloc(&pdev->dev, struct_size(priv, port, num_ports), GFP_KERNEL);
 
 	if (!priv)
 		return -ENOMEM;
@@ -539,6 +571,8 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.unthrottle = mxpcie8250_unthrottle;
 	up.port.handle_irq = mxpcie8250_handle_irq;
 	up.port.break_ctl = mxpcie8250_break_ctl;
+	up.port.set_rxtrig = mxpcie8250_set_rxtrig;
+	up.port.get_rxtrig = mxpcie8250_get_rxtrig;
 
 	for (i = 0; i < num_ports; i++) {
 		if (mxpcie8250_setup(pdev, priv, &up, i))
@@ -547,15 +581,16 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		dev_dbg(&pdev->dev, "Setup PCI port: port %lx, irq %d, type %d\n",
 			up.port.iobase, up.port.irq, up.port.iotype);
 
-		priv->line[i] = serial8250_register_8250_port(&up);
+		priv->port[i].line = serial8250_register_8250_port(&up);
 
-		if (priv->line[i] < 0) {
+		if (priv->port[i].line < 0) {
 			dev_err(&pdev->dev,
 				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
 				up.port.iobase, up.port.irq,
-				up.port.iotype, priv->line[i]);
+				up.port.iotype, priv->port[i].line);
 			break;
 		}
+		priv->port[i].rx_trig_level = 96;
 	}
 	pci_set_drvdata(pdev, priv);
 
@@ -568,7 +603,7 @@ static void mxpcie8250_remove(struct pci_dev *pdev)
 	unsigned int i;
 
 	for (i = 0; i < priv->num_ports; i++)
-		serial8250_unregister_port(priv->line[i]);
+		serial8250_unregister_port(priv->port[i].line);
 }
 
 static const struct pci_device_id mxpcie8250_pci_ids[] = {
-- 
2.45.2

