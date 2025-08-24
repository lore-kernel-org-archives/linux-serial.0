Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2117.outbound.protection.outlook.com [40.107.220.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9AF2DCBFD;
	Sun, 24 Aug 2025 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756048376; cv=fail; b=jk2qz6HHlp5vt9IuZyf/f3Yx1sQ3+5DZ67JZ3ss4nUlSk9FmIOcbkFYbCDOrkgYbFFY8PMQyZA0tueNnN4klJORrVxR4lrDKeQza3WU9KI1Dr4kbnLqcVwYzefvwpJA4MV+BIetf0O1M+RA3R9gnFVyB1BiWj6HNh16bjf/vPqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756048376; c=relaxed/simple;
	bh=bLb4fZD5y5uI+DAQBleiOj6avwyOegBbrDJtj/irJMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=S6Z90E1Dx6C0rmMdHLhzrCTkYhc5woV2N5oJ4U+hJ4azTyBqbV7R1cDwyEvFsoMF9pYoeSGZ6a0K5D3JekaNm5JWmmx/PZiLc+bsr11eB+IYPqa6SOEMxwepYFAkXQWW9pz18Xcwf7A/mA614GpRLghfUErQjkWHCGcv5+q8epI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=KMIcRdNd; arc=fail smtp.client-ip=40.107.220.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="KMIcRdNd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ASUJaiZFXoGTa8IxFZQ2HCo8LmBS2ShQwkIGSUqxulRjsRePtuhD9P1Pe+I49YM6BpfgS09xOZW5XZGOLsDd8ZgkYUOCw3wg/cERTCRvUXVWKeQc/1LSxQRsju8FcRP50kFddCgKuF4fayaVsmEoCU6GiQI1ekxMkQA2EDpchm8p/G5GcRlTTQhkWQrQuAYrwqE9XGnHgH5/ar5+zME/kF2EXQoz/YV7k8fQr8SqLAIF1gcpudhcuGaHV7aOHhGONeH8IzDhq6eaEFYJuhQ8l49FUJRgJhVLpT+wcqD5zc6lrZtsbEl1vzZRn7HaJLJqho7dTznkRzVoUFIuJFsz1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KdQtkxA2/V0ZZAGVj8hRqpzghf/L12h2lG5grJ3rf4=;
 b=B5JZdmb5/o0HYj8ggQnW+EZUS6vF1p26TpyQiJ4Y2k7eBDOR1vzsS66WOmQAbRET2ORBlFO90z0qZ/ub8I7LyqAcqjwV6LXdz+dsI57r0H3iIWyPsTEdKgSNK4JMnUSoF2p2zK9v/YxS3xvas7IdW3xgBPS/7m2W0y/iUhYdtCJaRKX/kIAyW3/dBTTLI0JioG8yd8xKrBC/PZ9KSx8A4mb7s+JXaAGsV4p5M22fkBx0QMPGl5+srjLnsZdcyO2h7w+5Wr4+dGdMYjkVVWbyR1lloTn0l2oAd6/WceWlKdHogqBwqJfJguPzquaUW487yKbllN0vqfsYKFRTu7K39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.233.182.194) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=axiado.com; dmarc=none action=none header.from=axiado.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KdQtkxA2/V0ZZAGVj8hRqpzghf/L12h2lG5grJ3rf4=;
 b=KMIcRdNdAQZFPxQ3LZ6Zgj9InCcI+7hep8tO3tFCNvlH/0kRs4pqQFLMF0LN/gLbUu3LBEDt2JWLBVxNYVZHmkLdbJ7Q8B0FmFJc8jX+GgEbSokfO4Rhh/d4bPwdmXB2YG6gas459oP4htjme6hYKdpq8Q25Wo7nXy69jwqn2S3ySRY04zJsYAfVV8mcZPVYbq4MCJ/iE6fUQDTAmCm40sPmbHqQKlf9YbdqP+2Z7IdvwpNuOmRsIKdetV9HUQ+TAaldmUOO86MH/9KImEoY/Sm4hvZR+RaryIgJ7g4PEJDKl4OLRFXqm9pKyv+/kUa3FnE0bLLgrYwcfMK7L+DFiw==
Received: from SJ0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:33b::12)
 by SN7PR18MB4112.namprd18.prod.outlook.com (2603:10b6:806:104::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 15:12:51 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:a03:33b:cafe::64) by SJ0PR05CA0007.outlook.office365.com
 (2603:10b6:a03:33b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.12 via Frontend Transport; Sun,
 24 Aug 2025 15:12:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.233.182.194)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 50.233.182.194 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.233.182.194; helo=[127.0.1.1];
Received: from [127.0.1.1] (50.233.182.194) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.0
 via Frontend Transport; Sun, 24 Aug 2025 15:12:50 +0000
From: Harshit Shah <hshah@axiado.com>
Date: Sun, 24 Aug 2025 08:12:49 -0700
Subject: [PATCH v3] serial: xilinx_uartps: read reg size from DTS
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-xilinx-uartps-reg-size-v3-1-8687f64a72de@axiado.com>
X-B4-Tracking: v=1; b=H4sIAPArq2gC/32Nyw6CMBQFf4V0bU0fAtWV/2FY9Ak3UUpaJFXCv
 1swJm50OSeZOTOKNoCN6FTMKNgJIvg+A98VSHeyby0GkxkxwkoiKMcJrtAnfJdhHCIOtsURnhZ
 rrmxVGyFUrVGWh2AdpC18aTJ3EEcfHtvPRNf1kzz+Sk4UU0ycqvmBEsadOssE0vi99rf14u0z9
 tevhSx1xbWqjPv2m2VZXoc4dov9AAAA
X-Change-ID: 20250813-xilinx-uartps-reg-size-c3be67d88b7c
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Harshit Shah <hshah@axiado.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3285; i=hshah@axiado.com;
 h=from:subject:message-id; bh=bLb4fZD5y5uI+DAQBleiOj6avwyOegBbrDJtj/irJMQ=;
 b=owEB7QES/pANAwAKAfFYcxGhMtX7AcsmYgBoqyvyWeWY9370cvyRty5wy5JCllZVJZFw0I4ie
 GuWHiYgNkCJAbMEAAEKAB0WIQRO3pC/7SkLS2viWOvxWHMRoTLV+wUCaKsr8gAKCRDxWHMRoTLV
 +65sC/sFHoGs+dTeSpd7INek9PTu3V2ZBtj8xbqRFYCYPmtao430Fja18PgkmXYxAcfvBS630Y4
 uu4JjxrueUIyXMeiEHdXa9MI9ZzdKZMKPYh19NuS6dZUXXNNdnToduhloURukvamO6BMBoAuOVo
 YYa+aAxWQyZ6WWvSWzacIvO9oosgnSubmGYCqEXRGQM6UZK9WYMGHx5LaynI0gACVaZAouEcuTi
 u9PDGFc8MDgG1zEet+3yU4aYZPGK7AuClzD6N5V/NH85ZffkuG2vN3EPqTVZjUEtQcpD2Yd4DaX
 qqqUv4YWqK5kVZKm1HhXOoFcWSwGSICRho/P75nz8ajVhr9ypM/vIeMXPI5JhgalUakA75zgWB5
 z8B4SgtOUkBTgfJLDfgYCVL4dBjVR0qs5+MdYf+Ermcpf63pvY318wwbceop2cXtiiQs+MJCdP+
 HkgVHZCD7mo1tMqB45y+De8KeXSrvK1UX/oJLPt73TejSFiHzLWBHECE3ebP8uiNbfxPk=
X-Developer-Key: i=hshah@axiado.com; a=openpgp;
 fpr=4EDE90BFED290B4B6BE258EBF1587311A132D5FB
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|SN7PR18MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: c396f91f-4856-4a1c-a831-08dde320b146
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cVhFd2RNSDFLMmxuRlpzYzhGN0JpVVZOZW1TcS92TkdWUWxucWM1TmZMNjE4?=
 =?utf-8?B?R1NJVDVleEVjTW56RnFYMGZzcjAxcDNTZFZPVk0vRHhvaFV1eCtsS0pHU3FV?=
 =?utf-8?B?N3ZReVVUNkNyUlV0eXBrc2FCdmVYZmxTOHlrNU5kQy9XWDJtVEdubDgyMXNI?=
 =?utf-8?B?c3RlMXBmejFReDIrL2hXY3RZWUlTYTRxT1dKcUFDUHp4TUtkc2NGclVPTSsy?=
 =?utf-8?B?RVJDMHNYY1VlK1NiN2ZicEFxR0VldGQvSW93VWVZaG9kT0JTdjUvTm1XczFj?=
 =?utf-8?B?bmViYzRINGtFc0gwS21EK1VleDltdFl5dUUrTW4vdjNTS1B1aUo2K0xUN1hv?=
 =?utf-8?B?d3lud1gxcUJXMW5CNlVaSFU5RWhhSjJKTGtiOVdPbEdaam9La0VDVHBQWFRH?=
 =?utf-8?B?WkYzaHpLWGNZZDBLd2liNm5ZQlFodnAzSDlpbG8zZld4dU9rQ2xOU0hLUVBO?=
 =?utf-8?B?SmhnQUIzU01hQWFKNGVsTFBaU3g1d05EOXk0MU9Ha3ZWT2ZqZlhuanJzbjdz?=
 =?utf-8?B?UG5TcjBLUUFCZXA5bzVsREI1eTZmWFZZSi9OTFoyZGdUbkJja1pOSEVoWWo5?=
 =?utf-8?B?Q1pOelFSbjdJZXYzWVg4eEprU3dSNi9qNldoOU1GRTdsM0drc05FRWorVHhm?=
 =?utf-8?B?SUR1UVlyblY5N0VSQ05aUFNqeHJNbmNDRkhqQWM3QUtVRVQybXN5STdCSTBP?=
 =?utf-8?B?elJ0V0tTcDY4aEczZTZMekl4TjMvcXc4TG91Z2l0eUFRemZaQ2hsTUNiS1VX?=
 =?utf-8?B?VFhERzRia1RtUzBWVUg5WWM3RnUvN2dqQy9RU2V2Nk1HMWVSTmN4YmRXNFA0?=
 =?utf-8?B?WVV5aDNSZDBzTnd2TXRXODFtcTRkZXNSM1ZGczJBU2xCRE4vWkxzYnl4U1BH?=
 =?utf-8?B?M0IvbE5DWC9JSW1qMkM0NWlZekRnZVpDZzQ1ek9JaWdPYldvcTB2cmdRdkF1?=
 =?utf-8?B?VEErRGZ4T0tYajZVZ01BTVF4QzdSTnlEeHA5UEZoOGxxSXRaRW9xMG9DRVls?=
 =?utf-8?B?MVA2OUIwcUdZUXFwZmxGY3M4b0F4WXBYc2xlKytSc2x4LzBOR0pkbmFuRWJ3?=
 =?utf-8?B?c014dlozRGhzWEpDalB0ZEhWMEhMckQrMmZKQ1VhR2p5TS91Z1I2TGx4ZEln?=
 =?utf-8?B?UEJqajdIbVZPNysrUm1GSmNaQm5LdUh0NzNUN0VoR2JCN2JuU3NOb21mdWYw?=
 =?utf-8?B?R3FqbURCM3VzeSt3TTUra1BSaWlnMEo2NkIzL3BPd2dWdlcrMEtyQ3dWdkVC?=
 =?utf-8?B?WDJWSUlMd0l0dFlLVUdwNmJWeDBDVVg3bWh4VWFqVWJOclVCcFBFRGl4RTFI?=
 =?utf-8?B?M250RVN1OFFBQ3BadnVuQ2ZHSHJqSVJWbndiaURsdWhOTHFwYmZ0bTU3NW9s?=
 =?utf-8?B?Ymt6a3Ric1JlUDdCbDFQMkxLS3htem9XdFZEL29Ya1M5NjB2Z2tuT0FTamNr?=
 =?utf-8?B?YXBvTENMMFBPSEtoUjFDb0FxdmMvblhHRzdhVGt2MWtScHVZcGQ3WG5QR2N5?=
 =?utf-8?B?aFRMYTlVc1JKUUowOWR4M3lpRDlEVnkzNXI0STVUbmZoenNkdzBzLzBxcUsx?=
 =?utf-8?B?L2hMREtiL2RqOHBrcHNXTUZJNWZRajNZV21ObjR4d3B1cy9ZZ0RTK2hLODE4?=
 =?utf-8?B?eUJjOFA4Y0RXU1pEZnNIeXJGTlNpL0s3dUNGOWVGZldQYUZ1dXlQc0ZaVUJE?=
 =?utf-8?B?VUQ2NkdGVG1DMlpVS0pZNU9LYlBibis0UUQ4RFZpOUEzdVFRR2pBWTN0Skc4?=
 =?utf-8?B?NzRWbmFPUjI1SmhVQU1Xdy9KWE9pNHA2OHNmbnMzTTBmOE0yd1EvOXZhTjBy?=
 =?utf-8?B?aU1DVVBVNGpFb2NicnBKall2WjBreCt3SU03SXFNWERSRkFhK2JuWkVSMFNZ?=
 =?utf-8?B?b0NUaDdYbHNlVEtDaGZTMmdUYzRXZVRkOU9mMzJBUkdoMzJZYjVkMWVNUTR5?=
 =?utf-8?B?YjdyN2RGZjFIcjFTZ3Q0aHhCTHRxWm5RcUZjMEI5aGJmRFNScFZJK0JvYkJn?=
 =?utf-8?B?UFpHTkNQRUVBNTJmaXdTSWs1aU9hbjgyTUpyQm0rTU04dUJ0ZTJKVGcxRVVY?=
 =?utf-8?Q?w9YP2G?=
X-Forefront-Antispam-Report:
	CIP:50.233.182.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:[127.0.1.1];PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 15:12:50.6511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c396f91f-4856-4a1c-a831-08dde320b146
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[50.233.182.194];Helo=[[127.0.1.1]]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB4112

Current implementation uses `CDNS_UART_REGISTER_SPACE(0x1000)`
for request_mem_region() and ioremap() in cdns_uart_request_port() API.

The cadence/xilinx IP has register space defined from offset 0x0 to 0x48.
It also mentions that the register map is defined as [6:0]. So, the upper
region may/maynot be used based on the IP integration.

In Axiado AX3000 SoC two UART instances are defined
0x100 apart. That is creating issue in some other instance due to overlap
with addresses.

Since, this address space is already being defined in the
devicetree, use the same when requesting the register space.

Fixes: 1f7055779001 ("arm64: dts: axiado: Add initial support for AX3000 SoC and eval board")
Acked-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Harshit Shah <hshah@axiado.com>
---
Changes in v3:
- move Fixes: tag before Acked-by (Greg)
- Link to v2: https://lore.kernel.org/r/20250819-xilinx-uartps-reg-size-v1-1-0fb7341023fb@axiado.com

Changes in v2:
- Add fixes tag in commit msg
- Link to v1: https://lore.kernel.org/r/20250822-xilinx-uartps-reg-size-v1-1-78a5c63cb6df@axiado.com
---

---
 drivers/tty/serial/xilinx_uartps.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index fe457bf1e15bb4fc77a5c7de2aea8bfbdbaa643a..a66b44d21fba2558d0b2a62864d86d3b73152e26 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -33,7 +33,6 @@
 #define CDNS_UART_MINOR		0	/* works best with devtmpfs */
 #define CDNS_UART_NR_PORTS	16
 #define CDNS_UART_FIFO_SIZE	64	/* FIFO size */
-#define CDNS_UART_REGISTER_SPACE	0x1000
 #define TX_TIMEOUT		500000
 
 /* Rx Trigger level */
@@ -1098,15 +1097,15 @@ static int cdns_uart_verify_port(struct uart_port *port,
  */
 static int cdns_uart_request_port(struct uart_port *port)
 {
-	if (!request_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE,
+	if (!request_mem_region(port->mapbase, port->mapsize,
 					 CDNS_UART_NAME)) {
 		return -ENOMEM;
 	}
 
-	port->membase = ioremap(port->mapbase, CDNS_UART_REGISTER_SPACE);
+	port->membase = ioremap(port->mapbase, port->mapsize);
 	if (!port->membase) {
 		dev_err(port->dev, "Unable to map registers\n");
-		release_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE);
+		release_mem_region(port->mapbase, port->mapsize);
 		return -ENOMEM;
 	}
 	return 0;
@@ -1121,7 +1120,7 @@ static int cdns_uart_request_port(struct uart_port *port)
  */
 static void cdns_uart_release_port(struct uart_port *port)
 {
-	release_mem_region(port->mapbase, CDNS_UART_REGISTER_SPACE);
+	release_mem_region(port->mapbase, port->mapsize);
 	iounmap(port->membase);
 	port->membase = NULL;
 }
@@ -1780,6 +1779,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	 * and triggers invocation of the config_port() entry point.
 	 */
 	port->mapbase = res->start;
+	port->mapsize = resource_size(res);
 	port->irq = irq;
 	port->dev = &pdev->dev;
 	port->uartclk = clk_get_rate(cdns_uart_data->uartclk);

---
base-commit: 8742b2d8935f476449ef37e263bc4da3295c7b58
change-id: 20250813-xilinx-uartps-reg-size-c3be67d88b7c

Best regards,
-- 
Harshit Shah <hshah@axiado.com>

