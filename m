Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2105.outbound.protection.outlook.com [40.107.223.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83D9393DCB;
	Fri, 22 Aug 2025 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755889112; cv=fail; b=mC7glstAiXaUcW4tzKo71baVsTAYXoohOPk4EodBn0wpc8Pl+Pguud1C0h1A2tGlDBDuJ/n6BDsAJWFDnpreNzXAGU95rejzRshOxTHVyLIGfbsjJ2sMVy/j1IuDQwGczQ2xIxO3XqT8YmEDQJWq6v4VR4ofkYToXeA/ztMwoiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755889112; c=relaxed/simple;
	bh=y1S+rSq+8xpLQva+s6FgAa3RwWXXJ/MNSGNfdJkQZus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=U4MfH7HinyNPs8ZuG8beshagFIGiSdumHjQqOSgJOaTaudZTtgFDLTY+JgcyRF+Hz6NgytZ13rKmDazV0Ca65PPWjt/TxzGPjZldFzljFGCRiF9qtrwnVGEnXQvTd/U4VNoUU5byMTdEQmpwgGk8sRIeNtAltJnS1GrJTjiF9m8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=ncWyh5Bh; arc=fail smtp.client-ip=40.107.223.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="ncWyh5Bh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZwmTferZqQSkYx4RkjTqwE7QgImY0iFGTwXV5ux8h9vL+R0+a7PZUb++aHo2SbgKMAt+1Pi+TSltBDBZRVlwT+1yd6dBK15mVMHK/SmjSUC5LqFzrzjhG6qIXACz2QQ55T0Hn+lAHN5+Q84zU8yLWm6v9cwgxz94rpX3w538L62i523Q1/XqjtNqJzpgBuZHCUg5BJSZX0t0Ms5H9pREzTGRJ6FHXVas75Wd5/g39629o7CmeF4Lq/LgzHzGu0L4UttT9tPf0lhvBzd+DqKIzP4CnAf/cFYFqx8QCkVGJvlhinuSpStKw9/fkuS5Nzwl3FhbYZNkQ7wZ1HbdUd83gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6RYCIM1m6GQJ1TadmLnYtOPqs43NRt5qNsoEZiWC+Do=;
 b=VJnhuOr9lZU/dMb9gxHXWAD3Ssa5zdBXzRzrdQPiDxBz5HDNrWbznZjYxtuFAOdF6gSdXqrFnUiODlIrVRgqmp33zAuXPgxDJqPVjpDbTSie5vvAQy8ovdvmP5/vaBicozZJ6oCdqSG6wMWgIuSu9iRjcTI7voQbwBiI8Jj0RvDygsvlF+erN9+lmiHhAwqKfBvV/kcRScfVDAQvh7ldpeYI58ENGJAzx99b+V7dW9y+Ru7ILSjDWCdyZll3xkMmXRwNLQg0WGgleHFpbBs4+BwfcxOFqgSjy0pFDAbzGkkyhtqnHJshBOtgw4Lh4FQdID9TuFX8FKdqVz40+yIdOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.233.182.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6RYCIM1m6GQJ1TadmLnYtOPqs43NRt5qNsoEZiWC+Do=;
 b=ncWyh5BhkGigcolr20RnzHrsVyQ+wqg6Mv0XMTNDjr/ffYmwnF2nY7tGvOv4C7mthdC2747LCk6JgyYSF560K73Up7XWMTOHffuWf2jUW1Ma7MoZSU/McmHZyl7OosTYofCyQve8LAVkpX3buGaWO/mvSi4bDoj+U16UDNPoXapNa5MobCi0snW5R95H2lRme6ZvPixYLc2ncp9NjmiB/Z1SLIA8+H8wX5Z+hQegI1AuKHxcF/mCKoPcUTb3VEy8I3LZjtqC5CnxbU0+PfLGDo5QgWpPYREx60aZkHjBS7H0ilHmGlZj3pz5nF3rPW8Sv+PUtK3PlTSDSdYQj3JUyw==
Received: from CY5PR10CA0003.namprd10.prod.outlook.com (2603:10b6:930:1c::30)
 by PH8PR18MB5311.namprd18.prod.outlook.com (2603:10b6:510:23a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Fri, 22 Aug
 2025 18:58:27 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:1c:cafe::b) by CY5PR10CA0003.outlook.office365.com
 (2603:10b6:930:1c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 18:58:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.233.182.194)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 50.233.182.194 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.233.182.194; helo=[127.0.1.1];
Received: from [127.0.1.1] (50.233.182.194) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Fri, 22 Aug 2025 18:58:26 +0000
From: Harshit Shah <hshah@axiado.com>
Date: Fri, 22 Aug 2025 11:58:14 -0700
Subject: [PATCH] serial: xilinx_uartps: read reg size from DTS
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-xilinx-uartps-reg-size-v1-1-78a5c63cb6df@axiado.com>
X-B4-Tracking: v=1; b=H4sIAMW9qGgC/3WNyw6CMBBFf4XM2jF9qKAr/8OwaMsAkyglLZIq4
 d+tJC5dnpPccxeIFJgiXIoFAs0c2Q8Z5K4A15uhI+QmMyihjqKSGhPfeUj4NGEaIwbqMPKb0Gl
 Lp7KpKls6yOMxUMtpC9/qzD3HyYfX9jPLr/0lz/+Ss0SJorWlPkihdGuvJrFp/N75B9Trun4AK
 cKsQr0AAAA=
X-Change-ID: 20250813-xilinx-uartps-reg-size-c3be67d88b7c
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Harshit Shah <hshah@axiado.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3100; i=hshah@axiado.com;
 h=from:subject:message-id; bh=y1S+rSq+8xpLQva+s6FgAa3RwWXXJ/MNSGNfdJkQZus=;
 b=owEB7QES/pANAwAKAfFYcxGhMtX7AcsmYgBoqL3ShANOd0sY/mLGDFmfpTBXpvmFcdgxiOd+/
 EEzjVYMJVmJAbMEAAEKAB0WIQRO3pC/7SkLS2viWOvxWHMRoTLV+wUCaKi90gAKCRDxWHMRoTLV
 +9QlC/91y0TQDRTk0HprpvLw8Bj29zFiJU/ksxXDbv3AZOKkVNuBf/2grP8jUfxNm/BlnoPARhR
 X9LmpM5y70IVJZ5EHxhSi+ryAu/ASeY5+/pqfrKd3qj8Z7Wh5bakDy+R/n4Hy4CYD/5mVrWDPtG
 NukN5XS//kB7xeN5I5kosFGR9bW0EmR5BtZ6gKu4bSpI74hkm7gCvLRFPw9QX4W+45vzYm+GPTW
 GC4zk/BpbKIC/TTqJXZ2KlI4cJROXW/N1dV13v81Z0c/nCJQLCz5+cqBcb6GGXE5I5QNuDIBjLx
 ndLwh1vgk/mf24J5afqZZUEh3ONXJF28J3K2i39x3qwyNrYyv9kf3Vo7xpmazvytQP9xNIIdz2A
 d3a34RQc8sA3xB7juY23/V2JWrcWCirRw4B3MeSWcmh78j+OunvAb3YSTJ6VqMRz/hxPRzBobSz
 fsQOAkP24oKMdumjQ+bOFkYEkoPGENk6JQ9FiYrOn+4jkMM0X5AeG9+FKsFoetFqiBf58=
X-Developer-Key: i=hshah@axiado.com; a=openpgp;
 fpr=4EDE90BFED290B4B6BE258EBF1587311A132D5FB
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|PH8PR18MB5311:EE_
X-MS-Office365-Filtering-Correlation-Id: eb43e413-ebdf-4205-12d1-08dde1ade0bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y0R4T2lKVmRpUnJxRUxiYjBwSllXbFhUWHozL0xObnFyS2MwRWlsVUljblNY?=
 =?utf-8?B?NjA0cFZLbDRHUm1mZnlRaGVCRzdPamFrckZ0b3J2dFR6eWMwZEt0bzZocE9x?=
 =?utf-8?B?MU15L3dxWWszNUZLV05ObHBBd25Ld2JTT3dRRUYwVnRJQk1ud2dCbGFvbVlU?=
 =?utf-8?B?dnVFKzB6UkZhSjJkb2JwWUUra2U3WDk4ckxoUXhZaW5qSEE4WThsd1N1empR?=
 =?utf-8?B?L0dod1ZadDdRSi8zTnprcFpZdDhiRGozcitUM2JrUnkzYW8yWDhuTUpSZGtU?=
 =?utf-8?B?aFpIMVRnR040eFQ2OFJlRUNnZ2dndEYzU1Jsek9kMmZxWG96VjlaaXJ6ZEJS?=
 =?utf-8?B?VDRFOTFZUE1WS2V5WkxIeC85TzA4SHc0UHBOTGpTSmF1VzhwS0Qrbnl1aW1n?=
 =?utf-8?B?SGo4dVBWOWQxNm5YdDZvdUZhbW5zOSt6WkQ5T2FxYXVIRkVWb3Q0RGtjdXhl?=
 =?utf-8?B?QXUwWE1sM0N3OHhBaUJqZkNIQ0FHU2ZydlloZlZ5a1V6cXBwRytvYmYyNG1i?=
 =?utf-8?B?RlFzY1hERVA3SE94V0F2ZHdRV0VOWVVxejNTcVBVbVlQeFVBVkZqUEV0U1Uz?=
 =?utf-8?B?VVQzcXFhNlliZHdmeGhPQnZ3WVNPK0dBQUtQVEduSG9DNzdzbC9yU2lhRUFS?=
 =?utf-8?B?eFhqNVBYZklBREJvcmY1TU1zZkJWSDJHQ21iZFVaaUJBQS9EejdvVmlvbDN0?=
 =?utf-8?B?REtzL3RwODhubW9sUHBGcWFaQ0NCSy9ISWhlVE1sT1JOQUNBaDR5UWlsYUZq?=
 =?utf-8?B?K3ArUTN2Vm9JNzlkMHkrR0tWUXMycWpmcHQ5bGdMRDBqeWYyTCs2ZS9yc0Ez?=
 =?utf-8?B?OHNWMjRwY0dFblcrbmJaZGZkUDF4c1Vxa3dLbWl3MmNSdUdqSHVsd2luRVUv?=
 =?utf-8?B?Ym5PSVZEVUN5QU13aGUxTHdzSFhmOXJUMHpiSEFzaVJURDBKNHhoQ1ZOOTJj?=
 =?utf-8?B?ZlVsQlE0SHFWSlg0QlFXK0JDcnZVMkZUU3lYbWJMclVVd2R5SHBaTXFpMldK?=
 =?utf-8?B?WUh6RHlqR2x1ZC9zOGdUR1J6RkE4OWNENFpTbmlaRDVoL3NPYXU0bnpWb2ty?=
 =?utf-8?B?ajk5T25ISEV0NVRMMmIxV3VtSEY5d2wzSy9sYjJic0x5ZitxY1RtQUlQdlI5?=
 =?utf-8?B?dDduVnJnZ0xSUHhxaDVRQTl6QzdUSUVyc2FKODk5dGdKUnV3ZlpRalVieG5S?=
 =?utf-8?B?QkgzeHZ3VEQxNDZ1T0txaHFXcWJyRGszL3dCd3EzWjRQenh0MlBSaHdySXBx?=
 =?utf-8?B?Sm8wSnJnSWMzaTVuQWJERVhkdFZEZTJqZlpwOXVwZUNYaTNlMkl2WVZ4a2t3?=
 =?utf-8?B?VUVaeHRPclUxdkw2UUhQNVpVay9aTnhtRUJleDVtOHd4NFJJTmcwTlp1THdK?=
 =?utf-8?B?Ym5GNUZnSWxIL2s4Sk93V3BLUzV4M2MzUmZiUlFxVk1MZGJ1OTFac1VaYzVH?=
 =?utf-8?B?ekxTdCtYY0MyWGdSU1UxY3ZFY29Gd1BtUk1BLzB2MFkrdW5sZ0hjM29LQWhS?=
 =?utf-8?B?aWJQME05SkdsRXBiVnloTVNLV1V6ZE4zdTR2eWZObDRuN2x3QmJVNVNIcmMr?=
 =?utf-8?B?WlFMdVJEVWdld0I2dXczTGdXRTZVTHBjZ2RqZzNXdkVUYVZRWUhaS0pDZGs0?=
 =?utf-8?B?UmJtajdBdDZucWtOMGN3VVhWQ0w1Zks2OXFva2I5Tk0wODA3TnE3eExhVGo1?=
 =?utf-8?B?a2M3NVZaSXhkWHIrZmJrclNCdXJnR0tPTTNFSXNPZktxNjdDemVkRUd3VFdK?=
 =?utf-8?B?VUczL0JTNTBPczFqL29kTnpqejh3Z3RCM0ZVT1VzM0RnL0U2UFNHODEyQ0wv?=
 =?utf-8?B?WndsVTY2LzFlb3NUK0s0UEdZM3ExV05Rb1BXWmRKQnRGZ0JzS1BhR1VWYUxB?=
 =?utf-8?B?NUlPUUREaWUwTk5Oemttci91SkxWbTl1WHAxTXNicTRLeWpSc2NNejRvelEy?=
 =?utf-8?B?ZWJxaldzRjZxQWpIdExUaWJXbnZMWXJwWnZwcmsvRVZVMUQyRWxIRTlLbldy?=
 =?utf-8?B?QkJ3c1VhWnpOZUlNY3JwRDlQZ0xEWkFIMUZSTWg3Z1NFWXlmUVdzQ3VvV0xv?=
 =?utf-8?Q?xGwUkf?=
X-Forefront-Antispam-Report:
	CIP:50.233.182.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:[127.0.1.1];PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:58:26.9988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb43e413-ebdf-4205-12d1-08dde1ade0bb
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[50.233.182.194];Helo=[[127.0.1.1]]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR18MB5311

Current implementation uses `CDNS_UART_REGISTER_SPACE(0x1000)`
for request_mem_region() and ioremap() in cdns_uart_request_port() API.

The cadence/xilinx IP has register space defined from offset 0x0 to 0x48.
It also mentions that the register map is defined as [6:0]. So, the upper
region may/maynot be used based on the IP integration.

Fixes: 1f7055779001 ("arm64: dts: axiado: Add initial support for AX3000 SoC and eval board")
In Axiado AX3000 SoC two UART instances are defined
0x100 apart. That is creating issue in some other instance due to overlap
with addresses.

Since, this address space is already being defined in the
devicetree, use the same when requesting the register space.

Acked-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Harshit Shah <hshah@axiado.com>
---
- Add fixes tag in commit msg
- Link to v1: https://lore.kernel.org/r/20250819-xilinx-uartps-reg-size-v1-1-0fb7341023fb@axiado.com
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

