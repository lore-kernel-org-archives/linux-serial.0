Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2139.outbound.protection.outlook.com [40.107.223.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87433101B5;
	Tue, 19 Aug 2025 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755636850; cv=fail; b=ERExDo2Zct52IUP8W1PL91uckMWHZVd8NNW7EW4S6EEFoEYgJEMoXvJ28MRNoq4SVxAObbx7Cmvbvi849KGHGw0kcaSMZQ5Rq0h7Scv/enaptJE3C4t9bzLrkkvqJFK+wqmnRr7SaMkgdakJlfMEWEvTbM5OtyvMt49trYMsDmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755636850; c=relaxed/simple;
	bh=Y2Opdp1o6OoPoJL5li05oXNCXNvTPCW2uCfS3Sn7Ky0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=vGc4AWPdpFz9N6otxFDdmxhIzO4Mivy1zJCMf3WO9i4zbi3rwq8FgO1KA1xUznh2Pph3/UuBzHZhU5h0zNy9Db6frX4n3TiAhH5qh8jUOcluayZsTKtfJQ0LHVS21oGj0D6wUC6aFA9B85nuE+/S2ppqmQ1ufIY7t/SxhFeZe2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=QJJ3e0so; arc=fail smtp.client-ip=40.107.223.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="QJJ3e0so"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wsXzhcsNvX2x6j0/h6lZwkmc9cN2szVGHRGyAIgFBGUO2Schci5Ii6ZB6BWRkGPmLp2iAp2alx/4wWwzC3AmrDH+c9uawoH4rcm2UaGvpv87GGlwVuXp1d1EWaE6q3doigT3hYKWf3S+ZqRac0RgiOh548vBjR+cmu57s5vxo2QcDqFUoQEtsFzpI1qWUIjys30NuYy0YJoYi0GhQfY6T6OJrPTi5cx8e2bWARGC0V3sp4YGUaMBwcA3csV3So8QopY3dkYFTP3+3G+A74IDhQR64pDW1zN7A4qt4cT3fVhBrAK9wqpMe3WqYSlWj/Ds3WkjdEi0lKNWjL97Kggd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0pz+Qxmrh+KZUwbo80WPQnJB8bCO58WrlryhMEXzFs=;
 b=s/PJ7TLNYlz5w58e6nNFXpIAOUec167wr9rFSt+FZfT726GTedwMguC6r9KYDsVfZez4z8HZdLy7B9EjobFRbdyoIrz62bhu5A70jD3rR9AeSGhmcYOICVDKaJShjD+oEPdZqZa5MJ22HgFwG4t3mDSmVdBglQnsrMh8xL5ilvzLlBBmROhqTJamIliYzwgJoOa0W7cZRG6MYkG9na02XGgOUym8HeumWAdImmxqpjV1U361XWCcnntD3gQH4/pFC6FKW5rSp6ykxHQh0IlO+XSy5Rw1wOVfC3ikoYp6FGK+RdVs2EqxJGFepBvxxh9O2c4MTZVNBOSmKyxNVL2gtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 50.233.182.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axiado.com;
 dmarc=none action=none header.from=axiado.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0pz+Qxmrh+KZUwbo80WPQnJB8bCO58WrlryhMEXzFs=;
 b=QJJ3e0soNVlb+WxDMfW6h1cZIBgnsJj4oe9eTXFQNfYD7arvD/twSDchXL3glKKtPjrQ9nMBKIPUQcji/OSHmqrJzLYGF55K/yyVyLHeryKQcjatjYO1ng5T2grz934AP/CKB59zjZw2YUmiYm9RxOAlofh/lo3k/q/R3nxFtJyj6K7UoG0tdPKdzYHB9GF6WQlVGfcsFWL75aGrtfDTTHkfJn5wB4UUHuewQFu378UP2rI+3Ow9wT1CCgRaneC9Pgla/6n8+fiNGNTQKjXUNZBRwhRDjaWyR3F6TQ6gmD/46ukZppgEBbBZsX9cmoiMQPDfvT3v1RHWDK2jbyffXw==
Received: from SJ0PR05CA0020.namprd05.prod.outlook.com (2603:10b6:a03:33b::25)
 by MW3PR18MB3499.namprd18.prod.outlook.com (2603:10b6:303:5c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 20:54:06 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::35) by SJ0PR05CA0020.outlook.office365.com
 (2603:10b6:a03:33b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Tue,
 19 Aug 2025 20:54:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 50.233.182.194)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 50.233.182.194 as permitted sender)
 receiver=protection.outlook.com; client-ip=50.233.182.194; helo=[127.0.1.1];
Received: from [127.0.1.1] (50.233.182.194) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Tue, 19 Aug 2025 20:54:05 +0000
From: Harshit Shah <hshah@axiado.com>
Date: Tue, 19 Aug 2025 13:53:58 -0700
Subject: [PATCH] serial: xilinx_uartps: read reg size from DTS
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-xilinx-uartps-reg-size-v1-1-0fb7341023fb@axiado.com>
X-B4-Tracking: v=1; b=H4sIAGXkpGgC/x3M3QpAQBBA4VfRXJvyEzavIhdrDaa0NIM28u42l
 9/FOQ8oCZNCmzwgdLHy5iPyNAG3WD8T8hgNRVZUmclLDLyyD3haOXZFoRmVb0JXDlQ3ozFD4yD
 Gu9DE4R93/ft+S8RcC2gAAAA=
X-Change-ID: 20250813-xilinx-uartps-reg-size-c3be67d88b7c
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Harshit Shah <hshah@axiado.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2820; i=hshah@axiado.com;
 h=from:subject:message-id; bh=Y2Opdp1o6OoPoJL5li05oXNCXNvTPCW2uCfS3Sn7Ky0=;
 b=owEB7QES/pANAwAKAfFYcxGhMtX7AcsmYgBopORtzaHqLCe5A9T8k0Lo3ytnkIMD8LRp0iQ+n
 xpe/9PxeY6JAbMEAAEKAB0WIQRO3pC/7SkLS2viWOvxWHMRoTLV+wUCaKTkbQAKCRDxWHMRoTLV
 +x8RDACZYFbn1m89GT57KjPuyE15Kgu0i3QkTMSPHqHdZ7lE8Ypf9Ok1UAIvj/1kP7rlUFzSL7f
 xU9C0mADa6sNI7fAp1QBuUe+itCHXjRzPjvVUkm7UAt4t7/I6ArR4a4oT0XTCazIkaZ/PqU9nhI
 bWQLUq2dExVcbapB3Gv4YquMUphQuQWVMGbN4akdeazsbpeKqRA8bIcxM300AijFCqlP9o2FhG9
 fxYQD0oYPsacOKY+YEoR+ePJjdaqB1y0S6fVVHvecobG5j3sNDT/Ha+qjiKqdDg+2qS+/384HHA
 7r35fkF2f34iBKqBd1CGU/2cgs2kKtMVex+NPLPafY0EXdjX9F6HvBGixS04ILMutVbxC7IEo4P
 QzxBernWZNAdprTovl4NF95GLDZro4ufPvWcWO2F7bUU+42LRgHUbu5K9KDdzEAvgCqEOc44DH8
 XIsne1VWq5gCV/gvj5LC9Sv8g6emIk7FJn2iPNgnw2CLIueKJuf4uKvnEfzj4Vc69QoH0=
X-Developer-Key: i=hshah@axiado.com; a=openpgp;
 fpr=4EDE90BFED290B4B6BE258EBF1587311A132D5FB
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|MW3PR18MB3499:EE_
X-MS-Office365-Filtering-Correlation-Id: 819dc8da-9995-44c5-2a1a-08dddf62890c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cHE1cWlBcmg0aUdpTFZ5K0dEUW10dWI1MjRJODNXd3IwVHAvdE5sMnJJa2s0?=
 =?utf-8?B?OHJHUHNhdU1Od1hwaDZSakx1eXN2bnFqYjd4Z2tjYlBFajRGODZmOTJzSHZW?=
 =?utf-8?B?SFU4THhSK1luUUxId3hndWRDb1E0d29pRmFWeGoyaThYTVdtak1wM2NCRDNm?=
 =?utf-8?B?TUJFcVM2NTQ1UFkyNXRrM24zdG1ZWm94VkVwZmtRc2pMMDNkR0ZRWHVIL0lq?=
 =?utf-8?B?a1E4ZUdRTVZLOFQ4SzhlU0J2T01sd3pIUnRaSmhETUhmamQ1LzZFNk1ZeFQx?=
 =?utf-8?B?Rlh0V3VDSk94YktDaEFqSy9PTHFpb1Q1dXZsSmhMQzliSy9wZDBMalFDNjll?=
 =?utf-8?B?S2lJSGp2U04zRkw5T1hrVFEzRXlqcnB4ZllpeDRLVEUwbFlzalZIZW4zTVNE?=
 =?utf-8?B?WG5lU3h2M2Y2dWxCQU1CMTQyNmpQSHp4TmdDOU5SQnB1VzlDYVZEZkE0S0NP?=
 =?utf-8?B?YVRHVHJqVk1UMzlOMktaK0piNmhDSjVabzZOM1J5V1IxUklQVGJXUkM2cWJG?=
 =?utf-8?B?VkVRdk9hL0ltRVJNT2p6UE1QTkVWYmpqbjJXY2hHK1JqVFpEQldFc0h2ZFV3?=
 =?utf-8?B?UHhPSVBFSDJXMExOZW9BbGM5R0NYaFBCVk1sbmFUc2pveHVQZHl6bUtBQldN?=
 =?utf-8?B?NjcrWDVvajlZSk1Vd3lYWVlwK2xXc3Fma3R2bHdua2M4NzRTK0t1d09Vb3U5?=
 =?utf-8?B?YXA4RHM5WnhhZlFLZDNuL2psTnNhOTh1MnF6TUplZkQwQkNIQU5vUG5XdXF0?=
 =?utf-8?B?a3M5ci8yb3ZPVEFFeXVxWm1hOEcxMTI4V1BkTFpkQzZIWC9WakZOOFBiRWhw?=
 =?utf-8?B?VzVVQ05NTkh5N28rcDZUcGRqZCtGR0xYTjgxSmhVRkc0VEtFSHB1a2VlZHVM?=
 =?utf-8?B?UXVyVHMzRUJLRWlvYVN1M29oSWNIV1htdmFWblZrT3RYenFxeGtlZzFJVzRG?=
 =?utf-8?B?bXdGYXlKVmFzOHErbDBQc1NEeTNoeXBjYVBpaFBlVVNoaExBZUNvQkg5L0hY?=
 =?utf-8?B?TmRXczk1UjJWdDM1bG5Qa3dTdnVMaFBKUGdLQytlUlNzOXI0ZjducmpOaHlp?=
 =?utf-8?B?UHJMd0Q3TE9rNW9UNk1kdXVrY3E4cTlFNTNuckhGcXphMHpIOXZPYXkyVE5y?=
 =?utf-8?B?VitZR2hKM08wbmgyQy9hQkovQ1NQUEF2TDZRa0NSZTlQSXd6VzRPajA4WXl6?=
 =?utf-8?B?bTdvdi84bU9VN2liUDRBTTlZUndlOFNqR1Nidm5laklhUlR1dEpQdytzVGo4?=
 =?utf-8?B?SHlZejZvK2ZXeU4xLy9qT1JMdW8vZWFoSkdDNjRXYzRNME8rL0ptWDk5ZVZw?=
 =?utf-8?B?N1VidERML21NYzhSck9vNlBvYitYcXNPVVVsYWc3SjEvdG52ZzBRYXVLYnYx?=
 =?utf-8?B?ZnRUbUV5VXlVaVJ3Yk5Xa3NLcXh0MW5HbGdmUWFwYlhMTXh6bFNyUFBoUEl5?=
 =?utf-8?B?SnZOS0lMakJOc1YrWmp4ZTdTRGVrWUlsQUhaeDM2YW8wd245M3JXcXp6eVFi?=
 =?utf-8?B?QXpoRUFvRkkwRVcyUHExQm9YOXZUeWd6TXRuS0hlZERzZDVEenVCQmlFdXUr?=
 =?utf-8?B?QngwRUhDQ3VOSG5GSGpvL2M4cWdlMzZKejFiaHlqd1hNT3ZKOTVvWnBaZzJr?=
 =?utf-8?B?aEFPdkJoY0F2RE5zVWd0Ri9JK1Bja3hjYm9NcG1mdm9GZXhkNTYzdFFPenNl?=
 =?utf-8?B?N2l4NHI4bWt5eTFCTkJNeFlCbjRwMitRRmhMYlc1K0FIeXRSclFXbjl5YkxH?=
 =?utf-8?B?c1VNZWlaU2lVd0M1RWMxQi8vbzZ5ckQ0aUpkdEN4R3ZENHZ5VFA3ZWJwaVp5?=
 =?utf-8?B?aFp0d1Fxd2UzK25YTHVUcktWRkUzUFkvSm1ZQ0Y0dzIzM1l2NlpLWVZBUFFX?=
 =?utf-8?B?MTJaRzZGUmtYN0ltdUo3VE14MDg4cDhIbzFMdWl1VHhZd0gwK3M3L0p5NDN0?=
 =?utf-8?B?aXNrdk9aWnM2YjFleDBmdkhIVkViZDE5V0wvdkZOcHR1bnhpVnhjUDZ3UGMx?=
 =?utf-8?B?NnJiY1JVaGNJTjVOaHd3OHFHOGdJMWlNVmcvOWFrOXp5ay9iV09KTFJxTTVQ?=
 =?utf-8?Q?dpLaHi?=
X-Forefront-Antispam-Report:
	CIP:50.233.182.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:[127.0.1.1];PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 20:54:05.5108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 819dc8da-9995-44c5-2a1a-08dddf62890c
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7;Ip=[50.233.182.194];Helo=[[127.0.1.1]]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR18MB3499

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

Signed-off-by: Harshit Shah <hshah@axiado.com>
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

