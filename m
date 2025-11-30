Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022086.outbound.protection.outlook.com [40.107.75.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D024E28468C;
	Sun, 30 Nov 2025 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499517; cv=fail; b=QSE67U4bhO2f3YoFC/BcNCpA562jhW8Gna+W88S1+fyJK8u1WGE+D869Ou2HRTpCGSIzBugZPebrTBcwTICuECIbraiwYARpu9qkc9dENiqaRjQYdm3wyhs0sBuXNdrgpFPnQVVephXz29QfXY2pK0DeZ0Yzuh3Jo09feRDtg9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499517; c=relaxed/simple;
	bh=8Z32lV1fxEbNTkEXbFJMeyttQIGzZtp8KnuP7XAZtSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nqmZfVqms+aC5RzwGked0QqUKoipXluH801QQiVRftIFN8BifcHJXQxZYdGAoywkrjxD8uPcqpJtUZHWPhZ7YEV254u4yEjyrYU57GMrcZuhCwg9b6v2vutfcVyT2FW3owl5ggfL5KBw3SI9sxo/W5kTNoeEq8ZhMt/VJv/3qBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=LB4UYcaU; arc=fail smtp.client-ip=40.107.75.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="LB4UYcaU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLSWcfXX7FLmTfFZub2kpatmERL6J1Fsu5//j4nQ4jW8wMmwztXPP9UXoF5LkhYyyiCAM9sJy4jMubvLfMeGPoBLf5WOFrL4dPzX0RZA9VFnFOW/FeMlnZY9G7K+htJQUl+6Xb0rCGxviio++y00AKd2En3j9KBJE0YySHz+8I2+AyIMh5K7fWWxTEB6fymIB+Je6S8MOOXV3sFkaZmBIUQbMWlLyU4qjQ/CK5YvSd3oUiRRbbzOwdFd9V8Qe3Spl/GK/ZoeaE8rVSsH8ViE0gPdDHzmO4UwWzGD79qO2lD7OaUhh+Kf2jH9bGV2K4SNhUqp/DZaqNLC4cSbqHkEeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EU61xCX3WvHXF6+Yfg08x8/jiixFt14u4n3cNzEgQKE=;
 b=tiuMcV7wnX5gUX08p15ix16aS0lLbdHMpQuZq0BDjjs2ayJWlG7kub6bNrLzQ09SBiBynur1uUevn7a+HG1aYolxyzNqqHCRfEHd/AG8BEdBXW94vn8Ksg9SSZf+ZLMgp/0HNGx2+0jr0P1ykVHc7gaMbD0OGVAmWwBn5JLTqJwmQNloRHI0vkncj3s+6iKkmGwaMMEVffoOlLgj1O1sO/9s73t4YB456TiwefIuqU5cBNzDW6XFiG3AEgA3v2U+ft6vsUiZLngmCSxGkGrWFrZLyKXNqUrkt9X2iycv0BESXkCSOSJ9ueKnxxwLg6q4qi+k0DiC265Ke2nY+4PO/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EU61xCX3WvHXF6+Yfg08x8/jiixFt14u4n3cNzEgQKE=;
 b=LB4UYcaUvY0xJvVH6QgOXfDvLuMUMoGvcLTofmKFJOltcP4GckVQ4IYmXeIOCM7aYp2voSXaKh+4GTA9XS7eYt/m0SMPXjT3SN3lVcgUY5uaZArN1JF8l44EjgF0UvDrwluY5yZmDVoK/2KfXLV3tyZxPvGF6EzRJJbDWnBk7UE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB6080.apcprd01.prod.exchangelabs.com
 (2603:1096:101:221::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:45:08 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:45:08 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 20/31] serial: 8250: add optional callbacks for rx_trig_bytes
Date: Sun, 30 Nov 2025 18:42:11 +0800
Message-ID: <20251130104222.63077-21-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7d892f69-ee3c-4a26-8d3d-08de2ffd879d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H9TUPr36jBA4SSa27Gukn3rkjaBNMKmislkzyazxMb9x06t+W/K+ha7b7ayj?=
 =?us-ascii?Q?1iIpIkJSfg4pmlNceQ9GAaBU9LhtVA8rDhYv3tYL/SmTG82aJqd6REWUkLxk?=
 =?us-ascii?Q?gG3MeOG8OOSE2fQKfZ95cJd8QgUI34KfmpOnFQ9fhXAQQgBCLbQVxAS9uWaT?=
 =?us-ascii?Q?fNePg4R4FbSso7j1R8SFaj8PO7nPK6QXrVtGFoIyOtZ06wkze9YZJN3HgTky?=
 =?us-ascii?Q?DMWl9hwRvZBAb/tlh8qMBQ41F0n4AKgF5pkwSqhTL7i9Knox7/eVK1MVjjfa?=
 =?us-ascii?Q?y/hd15+NgZ3lfitOxtPLvrkaDnwDXetu+nj7+LkXMmnazNiKAa6cIi1jYVUC?=
 =?us-ascii?Q?xMMsDyt5jmSS6uNwNElUu4DFy2D6BKCbMO7bzy+R9KapZHrptMFn4DgSfbkn?=
 =?us-ascii?Q?lAHwhXUBt7WfOoROqevJAYvu54Yw+SNf4ntzaaX1LqJHskTb2hiAZJqjhZ60?=
 =?us-ascii?Q?MOdMZb0c+45WHDtW8G6xEaZXGe0MsIUlai/F8jLxEnsVm08JCdB35AxQ2Izc?=
 =?us-ascii?Q?mXGR9R+ZpcnWTCo23AyqKk9/C20nN1HoEQrHHobA59rFIDVfhkyjpfqq1Mx4?=
 =?us-ascii?Q?+p4CtZxE849j6s1+rQjr1rdqwK73BOfaTTlLY0+spnERdbHnAxMEMDJoD3pp?=
 =?us-ascii?Q?rJTOG3bNfr2cZYXCNyp8N9iczxmxGDHt0Rfnw8LZL/PC8eL5bfWQifMgV4ac?=
 =?us-ascii?Q?G9ux7oiSlEUDUaKw1/fJBQQdJfjr+mh2J/TjKLvtJJaEogvUw94xalW5sH8G?=
 =?us-ascii?Q?Qa/zzBeMGh5aN/nW0/WY8reBC9qUTBJacbcfa0JNEQ7ZyRKSTBXZBKuxsW57?=
 =?us-ascii?Q?zmpnDJV9ucf/s1osTCNmJhFsTlHPuAkqmiHqNsnFN4YkpGwcnBZLkLlAKm+Z?=
 =?us-ascii?Q?qxfmr11L8v3/FlvIpvX3P6cr3zgl3OaEGFLYgO1MLqRtkTdDF+kbToTQsnE+?=
 =?us-ascii?Q?q8fxBNEFwmkzP+MkTsx93elxgov7NojVvJ6nPXXutWGdt4ttu2L0OxNdOHBu?=
 =?us-ascii?Q?9fmiMn+g0kIyaoBSlT605KypXiqfujtaRNIva+wdi+3Rnrm10776p+dCHPNt?=
 =?us-ascii?Q?oOs9Q7m4GMOwSowjOczHnNvoEI/DAGS16+MitcNmU7WzLffb2IXjxM+nKYnG?=
 =?us-ascii?Q?lyljHmF8XXLSkH4UaVAbA0/KcXlvSZBOGNMiZVZLcO7vtoAzragC2QcXSYLp?=
 =?us-ascii?Q?SNJoHykCUyq6j5iAOjDte0E4G1VI6yfZHNOdp9kOn9KIEscm3b/pwWQD7/5y?=
 =?us-ascii?Q?Lm3oIXkij9SS9BiqefkSxAo1DBWLDCp36JE9KFo73rtz0grLLBKB/fQQjXSt?=
 =?us-ascii?Q?nQ0c/maN0nlTz4l5DL9rkcKMqCPUoftPOlnlqrGAISpBVean0gHpbf6GWx2v?=
 =?us-ascii?Q?OygfVfa4om8dxACO5YUv2ltycI9daaVMzjsJP8+lRl159DKOWiUKZedTyTaz?=
 =?us-ascii?Q?+Ym/zoRhvpaAbZAIvFzWRXd3EPqfm2JBqHEoHJwOMx/etbHP99sxfhFurtrd?=
 =?us-ascii?Q?1LMlcE/zfiZEBTR9aWBeP0iByzrtmvrR2wgf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yRk+/XG+A7aDPUeYrCEbvau3ca/ulXiPwXt3VzLYwotEe89/qZ/dEoiPTz1N?=
 =?us-ascii?Q?Q+kcvGX56uhC9eZxqyzyK9EGKtbzFKdd9zu+mTvXfb7ctJbxgz52gIK1+txZ?=
 =?us-ascii?Q?BpEfCuNIOWGoljluoXC+PBjhB8Tm5F0eonKhhofREWkzsjGPfn4I0FlOBHMe?=
 =?us-ascii?Q?HZ2jos/2i8YF6/qYanpy3pTKPaTCdV/r6yQdpQWldlzl8Ot9MsDZ5YHw97Xz?=
 =?us-ascii?Q?XUkn4tQeel4kMURRHOtWfvT93TjUtuGYgF/NKlthQ8Eki1yDLx/0Kjfg+/eC?=
 =?us-ascii?Q?mXfjp/u1IM+yZu730/gxckd4MKyNno8lLvHiYknRL35oTN19Oj1+P9l3G20k?=
 =?us-ascii?Q?y8bRQFq6xxYiIAbi8STLDmosGt29U3LLfuEHDRlzTnoWcUC/3216Gzl9g3FG?=
 =?us-ascii?Q?WpJ6g4riEKH7dmAZUvyexgtNtUocuPvNxMxDgbYaMKl19YsNCFSJTfNXo9WY?=
 =?us-ascii?Q?1gMAsb2IvDNsSVJWwW6YYWhAR83osEW9Q+U8XuSMgtAWE5zkul1QKPJB96R7?=
 =?us-ascii?Q?f698MJiKV7RQ2hgQNtxFogujuD8eDMVJO5eMCca7et/0tfpQzyC7gwdowe/o?=
 =?us-ascii?Q?Pm66gXTBXp1TqTcTGlBFA2xekRvpWqayZnHT/ZbR4/E1ZwfriZuaFEQ6BIjM?=
 =?us-ascii?Q?AyogNzsXPzWURxOjMeEifYI/F07Sk6n8XneoN8uhBkVgTaQ+uqavh/1S6otx?=
 =?us-ascii?Q?scVDKT0+FeMNhDuSsubGCUuRWR7tchNdc+fJrug0OaRcKjU3UUOEj6uumAZt?=
 =?us-ascii?Q?/lUpobKyjbM8JlTm5YFOWIgDYuYleQqW9kSUEOeKeJG5cicotnKni1zjJEvG?=
 =?us-ascii?Q?IghxwxCdBsiyuXuKZhN1UqQ56r5aHRfRra7JGLWoCu80StrUYZYUbMUPnxcc?=
 =?us-ascii?Q?0jde9O/r81YYHoYQ2ULHsGpFKuDRw6JIikkR/2jksq1FB6P1f0DEptnk3eHh?=
 =?us-ascii?Q?gT4TMMbLPJ3HI3DcAQA9kLDa21hxWbaPHgS3oVtkYxwnhkiQDJJuVvRi8Mxr?=
 =?us-ascii?Q?SavP0xnfh0A+8uNXMx2bJig1vgJD0+vkPmt90q/WHWkFaloBvKdFf5Kcg4R8?=
 =?us-ascii?Q?Mu6uKBQekeAiYZr29bs9m/qwG85KGZ5mSkUBi2PMbUpM/tPcbs1ZOZQ0SjhA?=
 =?us-ascii?Q?G2tpT0M98Kg6w6BxqES+O4/ugEKXccTeQZlrohXiXVm29WjgdGTENu8ZlCAa?=
 =?us-ascii?Q?4zrkNufDeNoZNglauMqRut3Jc7dWaseBvQWqnwxFDUAZLOyL+dH0k6UwLPV2?=
 =?us-ascii?Q?bjizprpcslAyCuuY6ufhSRm8DsLiMiXjEHqYQtKtCeJ5ZFob83F9NY2TxK/2?=
 =?us-ascii?Q?TiH5AnTTEHDimGAPcjecoXK5xZwHTc4No/y+TXVG6WAlE8T32VDWeUFE0pgB?=
 =?us-ascii?Q?Oh11cv39yTwEgPRyRz/1msLqF3z7/ci2YmwqpIQC3jMni3Z7jMqWJwyp3HGU?=
 =?us-ascii?Q?kh/c7lA66dnegLmrH28UbJV3XEWssJOr7Y6/bXzfvkKZfSODXf2dY6Y/lXd2?=
 =?us-ascii?Q?KN13aC73MNePXeZTmCn3hqK983hCXT3jDD7we2237V5fWs699JyTW4me682N?=
 =?us-ascii?Q?5MXJMxAtKtwlDyrTrmwFIVUr8rW2aWV89la5J9+977to5rj72/7PDWCkELlb?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d892f69-ee3c-4a26-8d3d-08de2ffd879d
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:45:08.2526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0wzrbMtirXnWsh92c6i/YBMMc8E2UD7q7+oVZpDHDRDWruyluzzyjGF1NvhkFRyL9M+OfpZA7aGTR5QQyP+iOxhfbGHnVnH81wu1YFcQxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6080

The rx_trig_bytes sysfs attribute adjusts the UART RX FIFO trigger
level. Some modern 8250 variants require programming device-specific
registers to change this threshold, which the generic (FCR-based) path
does not cover.

This patch adds two optional uart_port callbacks:
  - set_rxtrig(port, bytes): program a device-specific RX trigger threshold
  - get_rxtrig(port):        read back the current RX trigger threshold

When these callbacks are provided, the 8250 core will use them to
set/read the hardware-specific threshold. If the callbacks are not
implemented, the code falls back to the legacy generic path, so existing
drivers keep their current behavior.

No functional change for drivers that do not implement the new
callbacks.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_core.c |  4 ++++
 drivers/tty/serial/8250/8250_port.c | 16 ++++++++++++++--
 include/linux/serial_core.h         |  2 ++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index f642e8c77911..3d8575874759 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -808,6 +808,10 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 			uart->port.pm = up->port.pm;
 		if (up->port.handle_break)
 			uart->port.handle_break = up->port.handle_break;
+		if (up->port.set_rxtrig)
+			uart->port.set_rxtrig = up->port.set_rxtrig;
+		if (up->port.get_rxtrig)
+			uart->port.get_rxtrig = up->port.get_rxtrig;
 		if (up->dl_read)
 			uart->dl_read = up->dl_read;
 		if (up->dl_write)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 64896f37b75d..d7baceacd4ff 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3104,9 +3104,15 @@ static ssize_t rx_trig_bytes_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct tty_port *port = dev_get_drvdata(dev);
+	struct uart_state *state = container_of(port, struct uart_state, port);
+	struct uart_port *uport = state->uart_port;
 	int rxtrig_bytes;
 
-	rxtrig_bytes = do_serial8250_get_rxtrig(port);
+	if (uport->get_rxtrig)
+		rxtrig_bytes = uport->get_rxtrig(uport);
+	else
+		rxtrig_bytes = do_serial8250_get_rxtrig(port);
+
 	if (rxtrig_bytes < 0)
 		return rxtrig_bytes;
 
@@ -3149,6 +3155,8 @@ static ssize_t rx_trig_bytes_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct tty_port *port = dev_get_drvdata(dev);
+	struct uart_state *state = container_of(port, struct uart_state, port);
+	struct uart_port *uport = state->uart_port;
 	unsigned char bytes;
 	int ret;
 
@@ -3159,7 +3167,11 @@ static ssize_t rx_trig_bytes_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	ret = do_serial8250_set_rxtrig(port, bytes);
+	if (uport->set_rxtrig)
+		ret = uport->set_rxtrig(uport, bytes);
+	else
+		ret = do_serial8250_set_rxtrig(port, bytes);
+
 	if (ret < 0)
 		return ret;
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 1aa07c5187d8..96646d3f2943 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -456,6 +456,8 @@ struct uart_port {
 	void			(*pm)(struct uart_port *, unsigned int state,
 				      unsigned int old);
 	void			(*handle_break)(struct uart_port *);
+	int			(*set_rxtrig)(struct uart_port *, unsigned char);
+	int			(*get_rxtrig)(struct uart_port *);
 	int			(*rs485_config)(struct uart_port *,
 						struct ktermios *termios,
 						struct serial_rs485 *rs485);
-- 
2.45.2

