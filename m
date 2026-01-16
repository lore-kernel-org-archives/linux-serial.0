Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011035.outbound.protection.outlook.com [40.93.194.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D216332B9A7;
	Fri, 16 Jan 2026 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768593362; cv=fail; b=sasmd7ccVNJkYHxX6jy2FcasKNTdOP8SGUog4ZxMN7n4+6JJF7NN9DnoHkz2hIYadIqz6dGYop/jdsb3NOG0arKa5DGa9vyEGTFq29RQ4GeO9htdAfZxDZI5Ar5jMmxg8LEpevbrF4JDeX01RC31VsuCrb215WvXw3pXZJiWK/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768593362; c=relaxed/simple;
	bh=vmZZP9ijDUeS9uvDb0kGQ8IHCzOm3M/8nsq3WgTTteg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=U8MNfKLGZ64CmZix193v1OFyfzeBAmSf/RhD2aCyeaRIJmHbzYpiI/r2I37JpwlC2dMGDj+jGl4Jny5yAvETdEwufiDcZ5tk7WVUcs7T+X8GArRqvy4Ofqg+NTB1xqhCsoRUMB1GMS780WxzuzCM50NX7RRg/VQPLVBujSTiSfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=A6Om1h7O; arc=fail smtp.client-ip=40.93.194.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A6Om1h7O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XthJT1j6CMDvJZZ9AYnWH5VYTqkVNLLzg0ha0+PPjgL/M2kNKF7/A7Pw4WY3Sru/u0yDvfOcPzqGR1GLj/53kFuMkky+340NkdqV9MjcKmMtBNRTgNlH4WDiVJ0Z6ZJBRF3doWQB64nIbT/IFYyILVQNcGcscsdOvCE0ivdakAV8u/XLhCyIxXBZpf3R07LUbstv/vzeI4RwfooR8iWSDChQxOpKb9mQnwdVbJPi9RgZM6vSx75KdowOxHpfsAJnG2bVkiUl4F2RbCglv4a95ysOo+2BNCGTDX8e3mikWAJCXbPcgy7ZkUw+VGb+sbAlPHWjV4/dhcSU7VwfaXe4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAc1zKUxNWjvVZOGISROVrRXzLpjQUbK9ydHjA8dbKk=;
 b=oJl57cD51OQ8w5EWM+70XpxfQC+awfNxDqycVLmPwQeNxpc/9fAs4hjziAvl9LLH8sLhS3yjjmfqu1oZxCAo2Q+5CYpaFgWXQk8J+wFt3MGbzCxa0ZKtNABJAPF9YOiyuSUO58CENQKct5B5NPu7QuanMb8toVeiLbdhaNV7vJLYTy8Hi+T80vJOpP5NQ0RkE1EOrSGNzyDVtExKLBTCZjAEveLG7hn2a2NFFeW/gnLG+pYZzZ4v1UCXJwuNroGwxNZbJrtJTkv6Bms+d4Cd5kNXieJAktA5XsLExHLNsMqm/gbEhzrr39D407HfVvvy3dyBLBxa/WCWQzJ+z3gS+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=linuxfoundation.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAc1zKUxNWjvVZOGISROVrRXzLpjQUbK9ydHjA8dbKk=;
 b=A6Om1h7OzP8AOruydRzBR/DrZcViNz4vRjkF+M3jYGpQYjugM1LCC7tI9AV7mcULvuiMSWgPZxlwL/aF69QDdP8f7/Q6x2h9q7ejZ96djLO7ed8ZsYPvBa0aCTJzQgyQcZpMWKMxTj1HCFyipANsWjMuP8I2VPujc2w8oTwMMzw=
Received: from BL1PR13CA0386.namprd13.prod.outlook.com (2603:10b6:208:2c0::31)
 by SA1PR10MB997760.namprd10.prod.outlook.com (2603:10b6:806:4bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 19:55:58 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:2c0:cafe::db) by BL1PR13CA0386.outlook.office365.com
 (2603:10b6:208:2c0::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.5 via Frontend Transport; Fri,
 16 Jan 2026 19:55:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Fri, 16 Jan 2026 19:55:57 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 13:55:57 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 13:55:57 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 13:55:57 -0600
Received: from [127.0.1.1] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60GJtvVH3800230;
	Fri, 16 Jan 2026 13:55:57 -0600
From: Kendall Willis <k-willis@ti.com>
Date: Fri, 16 Jan 2026 13:55:49 -0600
Subject: [PATCH v2] serial: 8250: omap: set out-of-band wakeup if wakeup
 pinctrl exists
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260116-uart-wakeup-v2-1-0078ae9996e4@ti.com>
X-B4-Tracking: v=1; b=H4sIAMSXamkC/22MQQ7CIBBFr9LMWsxA2xhceQ/TBcXBToylAYqah
 ruLXZu/ej95b4NIgSnCudkgUObIfq6gDg3Yycx3EnyrDApVL1WLYjUhiZd50LoIRGfI2JPVuoN
 qLIEcv/fadag8cUw+fPZ4lr/3fydLUdc6OY4aeye7S+Kj9U8YSilfuRtwmKMAAAA=
X-Change-ID: 20251230-uart-wakeup-00faeac7c994
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jirislaby@kernel.org>
CC: <d-gole@ti.com>, <vishalm@ti.com>, <sebin.francis@ti.com>,
	<msp@baylibre.com>, <khilman@baylibre.com>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>, Kendall Willis <k-willis@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768593357; l=1645;
 i=k-willis@ti.com; s=20251230; h=from:subject:message-id;
 bh=vmZZP9ijDUeS9uvDb0kGQ8IHCzOm3M/8nsq3WgTTteg=;
 b=HhCKZjQjJH8EPSGnkejpoYvRI3aHDCrELrcBcn1KolvlWy3yBKuc5iMlaKrNy0dd7x9p/D3wy
 Cm2hhdNQItTDwjn5UbEEMbgB+c9o5/vGW6wmmaoTw307ClhBBXsruZc
X-Developer-Key: i=k-willis@ti.com; a=ed25519;
 pk=fQiPVFwmogfDAKdaAKq163RWSfgHZVE/MrsDzp0Xo1k=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|SA1PR10MB997760:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ce28815-4ae5-40e7-d8bc-08de55394454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|34020700016|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXQwUkRLcndNaW8zd2FnUkdjbDZ2V2VueUlib1FhS09XY0VORWRiWThZeFlE?=
 =?utf-8?B?dDU4NlUrc2ZGMkIydnpUWjNOYnlLTDdlZXRHd0FuQ1BDc1Q3cmlFd0JRZTM0?=
 =?utf-8?B?Z1c1YktYZ004TzVJeHNiSG9VeFNUNGxuWElPWWJ1UWlRT25RMW15S0lPeDFN?=
 =?utf-8?B?K09FNzFJTW1yQVhjZHNvajVqak1XejN3WG9BNXZocEdoN2tkcmpuandRekxm?=
 =?utf-8?B?QmtkWktDQXpUUW9wZkxBVnc1THBWaU10eFJYRWh1UVc4Z0RWWGMycCtUZW9R?=
 =?utf-8?B?L1IwTW05bVBBbTdjRlp2a0t3NWwzQkhaL0hNTllCeE9HVEtacy9SR3NRL0ZN?=
 =?utf-8?B?YVl4WUlRMjhZS0swSHJoaG1oMS9Vemo5K284aTE1NVpyTm8rSEVycUJweHdk?=
 =?utf-8?B?eEhDZ2p1ZENVZndmZWdDWWhuWlBoZkY2ZzBDQ3hPaXJGWjFqNmhQcTRUUHVo?=
 =?utf-8?B?cld4Nmw0cjZWbFZ3UTVBOFNiMm0xN2kvRDVzVUFlNllPeDgwdWUzSndVbmRh?=
 =?utf-8?B?UnVJdnRBMjRBSmdYU2VRVW1NM3lkZGx3Rnd2SXFoZE11L1ZwWFVDTkxiWFBM?=
 =?utf-8?B?OHFyNHV1VjBYUkljdEJpZ0I2THJxck5pYlVzTWxCK1ZnY21MeDdTeVZzLzVK?=
 =?utf-8?B?RUcwZTFTMjVvZEJVR0NFNlo1ZkU5N2JJTlNHQklieGoyazRtQjdiRFkrT1RU?=
 =?utf-8?B?TnRNbXZhdTdvU0h0SW0xR0dhWUQ2cHBpeFk5MDlPZTFLbkJOblFFVURuN2xJ?=
 =?utf-8?B?bnFjZUg5TWxvbCtiSnFHZHcwWVJNejVQd2w1Tnk1bjJld1dMMGh0RTVtdGhn?=
 =?utf-8?B?KzNzY3p1NHB0MEFvdkJVamJBYzF6cnhyazVrWFhWMUNvVjRMYkJabDZxVnJD?=
 =?utf-8?B?VFFoUVlreGNua2M5ZXR0VUNMR0FqRDBidG9EZ0NZMW9oVnVyQjE3ZnJFemFq?=
 =?utf-8?B?TFBvbDV4WnY3WTBoS2xBOHArMDVVcmtkRDNudjRxL1VoUXFCUThLdXkvU2Yw?=
 =?utf-8?B?bUl6Sjcwb3JkR1NsclVIWFFsL2NiWXNSeTQydVZzSVpLOE1VdlpzODVhM0RG?=
 =?utf-8?B?NHFrM0xVdXp6VnpiclMyTEFZa09NUkhROSsvVDE2Y0JDQUx2T0RJaFNQNTk2?=
 =?utf-8?B?ZTRyRmpnV2pjWmxOdmtNa0hUVWFUckR3bGZDbzJBVE12MXBFRjJXMWc5dzVR?=
 =?utf-8?B?TW1scVBSeEFoeFVBREVxTGcrYVIySmpYenJXOWhpWTVpbk1BNEYwWHp0ak9Q?=
 =?utf-8?B?RG81N1ZHL1l3Y3FMYTdvc1Q2ZFNqbmNQNDhoSzdmRXFWYnBmMERXQk50c1Zz?=
 =?utf-8?B?TS9tL3RMRWcvRmtQQ2gwcVVBc1o3WU1raVFJSTVQZFdScjFTT1JHaEpXeWVx?=
 =?utf-8?B?bWpEbnlpemtMQlpPeW1DaTZSY2FxNUE3ckZMbmZ1VjZUa0l3MjlJa2ppSS8v?=
 =?utf-8?B?RUR4cUlrUkRHRzRpVGh6V3FWV0Q4T3A4OWk1UnpkNURDZ3dwcjFXY0hsU1ZL?=
 =?utf-8?B?aXZXb21RR2pNeWxYSm9OaGQxNGxDTVpNNTNVT3BFaFNENWcyWXN0RW9YZkJO?=
 =?utf-8?B?bi9GazBEeVZmRnhncnJwN0ViZU1FL0VjM0ZWYXJVbHZOSEpQVnZodUkxV2wr?=
 =?utf-8?B?dFFENHQ3cHNrdW4rTXNZZjVlb3Fnd0dNTWF3cEFtNXlES3ZpMndSWDhmM2Ey?=
 =?utf-8?B?RFJ0WXYyZnUrb1dJbE13ckVHUXFzZXp2VE5WQVhVSTlnZ3Z6WW5mdnNvK05z?=
 =?utf-8?B?bGtQcnlDWW9yUWpYcjVlV0Zhb3NqRkNlb29LaFRXVm1aOEJuNWpHRjUzSlhT?=
 =?utf-8?B?K2Q5M2d5NlA3QmlMME1MMnZ5blpIVkMxWElkWmFGQkM5NmIwMTdvQTdGRVlI?=
 =?utf-8?B?aXJzdWxiSUJPT3c1TitGMHRmZVhpZXlsc2JiUlB0dkYyc2RvZlp2SU5rQ0Va?=
 =?utf-8?B?ckpCdjMvaDVQY1ZkWWZPcU1DUkZ2TmxzQ1BwaW80M2kzSkpYYWZJQThuUmxO?=
 =?utf-8?B?RXoyakk5Sjlyam1JWUptMnAzQzNIcEs0em9CSkVKSHZoMXROV3dBajNVUmhY?=
 =?utf-8?B?MUdFcWYxZWlXcGNSOVRrdGl2WG13dWNOVUl0R3k3YnBERTcvNGgzcnRvOFRh?=
 =?utf-8?B?YkVFTkMzZUFhR1lzeWhlR001NklJM0o4SkQwQ3ZZRnJYSGFkeThzV1Z1SG5C?=
 =?utf-8?B?eUE3RjFZaEtpWmlka3hBK1QzdUZ6MmwyTmdXTzJ0b1RabnRYUHg0Z0xJUE5x?=
 =?utf-8?B?WEZvdjU2Sm9rYkFZdlZJeGU3dk9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(34020700016)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 19:55:57.9834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce28815-4ae5-40e7-d8bc-08de55394454
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997760

In TI K3 SoCs, I/O daisy chaining is used to allow wakeup from UART when the
UART controller is off. Set UART device as wakeup capable using out-of-band
wakeup if the 'wakeup' pinctrl state exists and the device may wakeup.

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Kendall Willis <k-willis@ti.com>
---
Testing
-------
Tested on a AM62P SK EVM board. Suspend/resume verified with the Main UART
wakeup source by entering a keypress on the console.

This github branch has all the necessary patches to test the patch
using Main UART as a wakeup source:
https://github.com/kwillis01/linux/tree/v6.19/uart-daisy-chain/all
---
Changes in v2:
- Remove extraneous information about patches that need to be
  implemented to allow Main UART wakeup on K3 TI SoCs.
- Link to v1: https://lore.kernel.org/r/20251230-uart-wakeup-v1-1-13f1bb905f14@ti.com
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
base-commit: 46fe65a2c28ecf5df1a7475aba1f08ccf4c0ac1b
change-id: 20251230-uart-wakeup-00faeac7c994

Best regards,
-- 
Kendall Willis <k-willis@ti.com>

