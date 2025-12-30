Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010030.outbound.protection.outlook.com [40.93.198.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077331607A4;
	Tue, 30 Dec 2025 21:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767129902; cv=fail; b=Lb3/rS7E5uatu03O1UPGnoWiKkfD5kpEcUmxQDGYrWCNQtiqcHdp2C1FByMO4Kbulh9edSXldsFMH2cshrLp/TtQN2YRDKayknARhEWpvL/j82M/RherqrqBPs3lpL7gBrqtOsK09xDL4kjAIf2SlSvwMtPcx9VeVhVS3LZjoNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767129902; c=relaxed/simple;
	bh=XHlPK8WRBqYDlpismKCIPR6URDu0V7sS2Yo6akefQb8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=M12NbvWJTGsusSZ/DjABN28jDoDfdVF4M/rGdqaaaLM8j1GL8JDL+0d54ZfI2z0cmMsUx16aCpiwg6v8acNzFSHZhOWHQ7jOJHlQ/bcUGTQ7CKv/kvEPT4xKUEeGuGwu7BloM3s5vj7Q/rpmcnD5GhspbR/FDPZwW1H43rODXZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jm3m8lVS; arc=fail smtp.client-ip=40.93.198.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jm3m8lVS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDWLl/EHRZPJ0BSQ+AiIy3G7by39cU6F9GddqiS0I9/WEqnZUEEYGul4zM5SZTeo2aeHDPyEBxO7Aq6HX++zrLH+vyCm55Z2JggtehdGP8VWej71+qL8ASqtRXLCXyCgzIdE4sNE+9D3YXrQ5kZt9fN6Jp0atUnPWLBGLIE32QwerLbr21WY63/Qtc+vy4F6iR3iOc6ryGKS+pKj8lwHesvhV6TWrmnZ2hZthAWH8Zi8oyHWqjPRrCMl/ei5KeRWNGrgc4EN1UF6+TlGsVmyLJyRn1Wf3vkdmNyIkwN09DI3FP7Wlfi/AadtEQZEsOQwC4b6KxuFjktVgCH1TKd2Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4aIoVth3m+DGfATvk+FoGlpKStRliMHLMNW7YCLxY8g=;
 b=ulZoV37DUomdzbjFVBbHgk2/xZrWwbjIYV5YOWD9fZzgUJh7umlPP6kEqAxWoagcf0Np8LRaer6Z0WaA64+YHZBFsHHG4TIQcRC/lFeAfhG60zOw9vgNwxVFAaGSU5x64x4TdrufKgNdZo0mOoTMh/4A6FqISUQJeJEMfXXQXNojjclqUNKUD2KQkBrtaWd1qGdK1+b8uAsytiDmCINlGc1691OrRz9dsiOFf1TrTLmfMwLYA2sdqjs609Qcjsr/BzCWeX8cfL6FCk+/EYnNgT7kvkKcYSP6SywO2VIFo3ufs0m7Fn3PAlspXE0IS6krwJtEdfaXL2vtxGkKgjsG9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4aIoVth3m+DGfATvk+FoGlpKStRliMHLMNW7YCLxY8g=;
 b=jm3m8lVSK1ReAn33tpcdpQ/GqNMP+TdScsMV72YFc+QSiVNEOe1RtqPXJjVdvgezxJ74U1M905BRAscrW3UHnRWLHL7Y5PHuUWofupsPexxumwFT16IQcDqcf1dJNMYQB+IxuaXnNdyoDpFDPcdQ50z7qb1ADjEnF4vKMDbx+5I=
Received: from DS7PR05CA0073.namprd05.prod.outlook.com (2603:10b6:8:57::27) by
 DM4PR10MB6909.namprd10.prod.outlook.com (2603:10b6:8:103::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.14; Tue, 30 Dec 2025 21:24:57 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::9a) by DS7PR05CA0073.outlook.office365.com
 (2603:10b6:8:57::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Tue,
 30 Dec 2025 21:24:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9478.4 via Frontend Transport; Tue, 30 Dec 2025 21:24:55 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Dec
 2025 15:24:54 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 30 Dec
 2025 15:24:53 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 30 Dec 2025 15:24:53 -0600
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BULOrp71383806;
	Tue, 30 Dec 2025 15:24:53 -0600
From: Kendall Willis <k-willis@ti.com>
Date: Tue, 30 Dec 2025 15:24:51 -0600
Subject: [PATCH] serial: 8250: omap: set out-of-band wakeup if wakeup
 pinctrl exists
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20251230-uart-wakeup-v1-1-13f1bb905f14@ti.com>
X-B4-Tracking: v=1; b=H4sIACJDVGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI2MD3dLEohLd8sTs1NICXQODtMTUxGTzZEtLEyWgjoKi1LTMCrBp0bG
 1tQCNVjxVXQAAAA==
X-Change-ID: 20251230-uart-wakeup-00faeac7c994
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>
CC: <d-gole@ti.com>, <vishalm@ti.com>, <sebin.francis@ti.com>,
	<msp@baylibre.com>, <khilman@baylibre.com>, <a-kaur@ti.com>,
	<s-kochidanadu@ti.com>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, Kendall Willis <k-willis@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767129893; l=2259;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=XHlPK8WRBqYDlpismKCIPR6URDu0V7sS2Yo6akefQb8=;
 b=PF+0VFPgi9JAoUmBGnzRqX7kiOcDwUbYj/CMhklnNZY7KbqWtQxTgWtE+8jAFD5oHkbYht7/L
 vJ9buqx/zedBkd9bzoaHlIRoBeop7f3aMtN2LiZJLSg3W9Yi+/sylpm
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|DM4PR10MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ef368e0-b78f-4021-c1eb-08de47e9e0cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nms2YllvVHV2M1NKREQwWHlWMlVueDNTR2JZSnBXeGswN1JxWG91clNoZGZ2?=
 =?utf-8?B?T1NOR01QeC9Fdi9IbDhtVDlwdlV4SGdFeU1SQXZTb2FXUXozWU9BV1ltSWpl?=
 =?utf-8?B?eUNHbkRZbUtUbDNyeHBZYUtZejllb2F1Y2NPODNwYkFBeEhRQVpRcC92SVF0?=
 =?utf-8?B?T3BSRFViUE9FRHBkZExyL3RoUXVzZE4xWGdBRkRvNDhaUCtCekxOWG1DdWxi?=
 =?utf-8?B?UXMyUWg3WWpRWDdjK3RUQldqUjFhQS81Z0hNWW5xbzlnTGdvK0Q0bCtTV1cy?=
 =?utf-8?B?RzQvdGdka0xFRzRnZkdyQnEwVjVNYkFiYkp3MUNXbmFQclZkYWRZempXZWNY?=
 =?utf-8?B?bTkrZW1jTlFpNG1TNzdWNk9IOXhzeTA0elp5c2x0cjRPSnZocWN1NnpSMk5C?=
 =?utf-8?B?ME1SQTc1dVZvM2x0d05PZElRM0cyYzFGZVlCeXJOY1hSMC9zNDhZanB6U2xa?=
 =?utf-8?B?QXVQaHp3dHd1MlFCNUpUY1ZtbVUxdC9EL1RSTXNjeks3eThEYlYwTThDTEhC?=
 =?utf-8?B?VjFlOEVpSWxMeUtvSkM5djZkRWc1ZnZGMVNQOUtkcXBCc3lRUDR1NzF0cjM4?=
 =?utf-8?B?V1lwL2R0U01rU0lmRmtWMXduZW9rUy84b0ZqOHNhMG91MktFVlJ5RlBIYWFh?=
 =?utf-8?B?M2JxN3JScmFqSmdpbENjUkJOVXpCaDdqbTVYd29HaEhHZE9MUU1GdVNpTXNZ?=
 =?utf-8?B?M1ZPNytCWTBtR0hsSEpiRHZ0aGZibklaR0IyMlJZU3kzNUI4eW9nRXRNd2J1?=
 =?utf-8?B?NHFqeGRsTEtQekhxYXhRYUlFK1k2NVpFV0REUGNHcTI1Vk9VVW9lM0RqTGVz?=
 =?utf-8?B?cWx5b2Q2MGtmSFV3SUQ4MmJ1UzdlSUtFUzhZdDhxWlpVWGplMlNwSjQ0ZXNh?=
 =?utf-8?B?eWJIV0lCUk1NbDFPZmFlK1FzcWdBc2NTejNNejR5TFI4Z0hnM24vZk1YSEh4?=
 =?utf-8?B?NnZ3UXMvdGdQcGlObGlDV3U5ZXZRQUp3YU1xWDNaVEtubWRLUjVpNjFZTW9Y?=
 =?utf-8?B?WDBJRzc2bXJMdmtwLzFPWGQ5aDBPdEdKV3BNRG4vblZ5alphVnQyQ29oUGgz?=
 =?utf-8?B?NXUzUTRIcjNXUyszeTJqMnhWd0lYaFVYbEg5TkdMS0NLTkFDOWI0aVpFeHhz?=
 =?utf-8?B?WDgwd0F6R1l3eXFqRXVDK1lPRUVVbHM1RlJHNURTY2RSTVFiV3ZFWXdMVkdk?=
 =?utf-8?B?aDhsV0l2TEJQRUxBRjJYVzhPUWlpODdhRmhxNUsrREpPN2ZCMmhHcVU1d1kx?=
 =?utf-8?B?d2wyVE10Rit0QXJXTVVXOGVid1ZaN2dlajFMckRoWW13SEZDSjhWMDRwOXI4?=
 =?utf-8?B?YUpDMisxUVRma2dDSWkyUEZOTkJQU1VBZTlmNkVzUVhtblFKbXBvSW1xQzZZ?=
 =?utf-8?B?L29pZ1I0V2RWdXhEVUs4SnVxOGNuSzl1UU1QaGkzejNNb21OZDJSUk1NVSs0?=
 =?utf-8?B?MXRIclJDTWFMZE1EckJTN2gycHhTdUVUOGlmbFlFU3MrdWFxRXFDK0dHblFy?=
 =?utf-8?B?ZUJnanA2RDQwemxpMGZpaFBXb1JoNjNVUDhMc1FiR0lETU9NQWIwQ1FVYmZF?=
 =?utf-8?B?bitJcW5VeXJvemNoVFMvdWJaeWtwQXkwOHpVanFkUk93NFJ6ZXlmTXpPS1Jq?=
 =?utf-8?B?Qkh5aExPZnB1aGIxaDRuVFlOeHhpTkFzZmtDbTBiQWU5Zjd4REYvNWRLSFdv?=
 =?utf-8?B?UXdMbHB6L2lHTlhJVGdEMkNhVkpNd21WVUwwVVpER1JYaW5rd2VhbXErUFJy?=
 =?utf-8?B?c213eFJEVnJaL2hmS2t6c09VamtMSmhOVndGTlUrZTJxRGJaemhxVFJEQm40?=
 =?utf-8?B?VVNmYkU0VnBvRjRRUXQrclZ4dDdEQWVoNGVYd044M3BIKy9CNlZpTm9rd1da?=
 =?utf-8?B?VEZRb1BsY21OYkJNMWZ1TjhJbHY0ZFVWTEJEakwzMkpjVzRQb0lDRHhZSmRP?=
 =?utf-8?B?dVZ0KzZrTi9ZOUFYaUluR3psR0wvaG83OGZyL1U2aWpiMzlBUmJCYTBhU2pk?=
 =?utf-8?B?cUlwZW1lekUrZTJIWDZ5MXRwR0g5Z1dibXVaMzU5SVc1aGVvUFNxRjgzYjNC?=
 =?utf-8?B?eGJPaDBhTUhNWnloVXVYZXptTlAzSjhkekNqLytndThTWEhYa3A4VXcrVklq?=
 =?utf-8?Q?1BD0=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 21:24:55.7409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ef368e0-b78f-4021-c1eb-08de47e9e0cd
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6909

In TI K3 SoCs, I/O daisy chaining is used to allow wakeup from UART when
the UART controller is off. Set UART device as wakeup capable using
out-of-band wakeup if the 'wakeup' pinctrl state exists and the device may
wakeup.

Signed-off-by: Kendall Willis <k-willis@ti.com>
---
Implementation
--------------
This patch is intended to be implemented along with the following
series. This patch has no dependencies on any of the other series:

1. "pmdomain: ti_sci: handle wakeup constraint for out-of-band wakeup":
   Skips setting constraints for wakeup sources that have out-of-band
   wakeup capability.
   https://github.com/kwillis01/linux/commits/v6.19/uart-daisy-chain/pmdomain

2. "serial: 8250: omap: set out-of-band wakeup if wakeup pinctrl exists"
   (this patch): Implements out-of-band wakeup from the UARTs for TI K3
   SoCs
   https://github.com/kwillis01/linux/tree/v6.19/uart-daisy-chain/uart-wakeup

3. "arm64: dts: ti: k3-am62: Support Main UART wakeup": Implements the
   functionality to wakeup the system from the Main UART
   https://github.com/kwillis01/linux/tree/b4/uart-daisy-chain-dts

Testing
-------
Tested on a AM62P SK EVM board with all series and dependencies
implemented. Suspend/resume verified with the Main UART wakeup source
by entering a keypress on the console.

This github branch has all the necessary patches to test the series
using v6.19-rc1:
https://github.com/kwillis01/linux/tree/v6.19/uart-daisy-chain/all
---
 drivers/tty/serial/8250/8250_omap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 9e49ef48b851bf6cd3b04a77a4d0d7b4e064dc5f..6a5722b722650c1710e79fb76fc1a01cdeccc68f 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -1363,6 +1363,8 @@ static int omap8250_select_wakeup_pinctrl(struct device *dev,
 	if (!device_may_wakeup(dev))
 		return 0;
 
+	device_set_out_band_wakeup(dev);
+
 	return pinctrl_select_state(priv->pinctrl, priv->pinctrl_wakeup);
 }
 

---
base-commit: f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da
change-id: 20251230-uart-wakeup-00faeac7c994

Best regards,
-- 
Kendall Willis <k-willis@ti.com>

