Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2117.outbound.protection.outlook.com [40.107.249.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9053ABE46;
	Sat, 11 Jan 2025 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736601818; cv=fail; b=ZNiL/EaWQo7WzxXiZfhrLdb8BC7MpskrRs+EMCcw1mOr/5+tiBFfnLh1EquMrwkXsk+0ugeAQzHlnUqR0hxKAUxzd4q5QYFWzn0gYF0D3GU5stVl/IyEJsc4ekEjQcAj4qPfYoBirs8KEiX7yRogUjC0snghkeGhz3Pwj7nAJYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736601818; c=relaxed/simple;
	bh=NRl6SgF0dTTByTA5MmLpNuhTLtxC2FpcruzjX0m1/lU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WeufYNZ2lED/M1eSANVB07KhkuZq4tNuoNqmSpzd7HCl6weeoHvG0XGL/PLiesY5fJs4me/f5b+3KLAK6K1iAu+qSeKBYLBCKod2lIwN7BNCWwUA1X8rNjSX/D2GppJGB1HS6sSxENchlANwBOQ9n9IbYqa5DqfiCZcBkL7hH9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=Q9KaUStc; arc=fail smtp.client-ip=40.107.249.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="Q9KaUStc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cBb7XbENlGHDzXE8DE+nGmqdHa+KSEuLiGyYT0cZ5OVdbSffemJW549PpD8Hm5ik2WEaFfQDaPqVaBd3htduZjyuFUEXeLVES+5ORMVRyZEVZfpmVEeouQai12wMfQttTZ2PisOlb/X4nBZSn2uYpfgFXO8qONE7DCipjoL2K1G1cgOuLBytBlQPEt9YWe2piNynD4UeD6+nWDhw4Q5CW2Tfgl1M3y+Ib+3RXGVm8O0nVjowL1GPbK4pWumUBnB/DlWMjsEFrex5pw0dHpOY2+EchYEG36rldroijm6s1mbLC1RS7Nfh11TPO/6IIg+clyrzhopcBfVIYVT9RnFTBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3MOTMweoKnp4z/uzHTz+Qxe3KEnSDDkxdE6LpK0AaA=;
 b=YNTeW9Os7QfCDzTGXmEZo5hIwnOKUVbUKLVOcuXGY4xP2rM7b7A7TaM1EWFpBpy46WsPywWddI+TN8nO2y9Ec3oT98/sIxibCZ6ewrYvbpsiAiw+dcqzQSkq0GOCKYFE1fJtTIC/Ofn2Ss5W1rRS3+DvZE0Pnzf8+RhPJn6QKZ1X5fqyLHfXFjKl2QvuU+EpcX7yue05S7yVCv1DHFtlLch0F0cMnhvyi2o+/Z22YZxvjZ4w2Ds1ZS8uaDWqcMD5m/QMzzD9PVRomLAkd5FhMRDlckctZP3mpkqK/Tg7UcW1oNCQkQMzxvXI8JAssQBIWSBcWBTiJazykxrf5+I2dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3MOTMweoKnp4z/uzHTz+Qxe3KEnSDDkxdE6LpK0AaA=;
 b=Q9KaUStcsdHNwPOxVWa1cP9U+yDyJ04Vui6n0cbIDngX4yIOszqAjC4UgpuTELRqsn2WWPKSCAvfVzRzvRPZtHlA6DbevPK1vaoTY3WqzylBTGngkm++fNbMwZ6ZVdv0f8xJ5FMlSSsfuCFq23SxxJv06NQ/rLdhwhOIShC+UQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 by DU2PR08MB10066.eurprd08.prod.outlook.com (2603:10a6:10:492::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.15; Sat, 11 Jan
 2025 13:23:31 +0000
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42]) by AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42%4]) with mapi id 15.20.8335.011; Sat, 11 Jan 2025
 13:23:31 +0000
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
To: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ansuelsmth@gmail.com,
	lorenzo@kernel.org,
	krzk@kernel.org,
	gregkh@linuxfoundation.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>
Subject: [PATCH v2 0/2] Airoha UART support
Date: Sat, 11 Jan 2025 14:22:48 +0100
Message-Id: <20250111132250.3642694-1-benjamin.larsson@genexis.eu>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0113.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::13) To AM6PR08MB4215.eurprd08.prod.outlook.com
 (2603:10a6:20b:90::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:EE_|DU2PR08MB10066:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ef17ff-3292-426c-833b-08dd32432449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QqdY+Ik0hepgn3W5halmy4xPscJd2n6E/f3yZdEQxIAL8uC1gHv1PYdGkfhG?=
 =?us-ascii?Q?J8YYTbdaIbZh5hHSloDDkoSGHxiQyZ27ztl94YkCbwrl+4NLJrH/t6UADTSz?=
 =?us-ascii?Q?E/tPyet+Cv2d3mt/K49kiyFNvgvP/ua7+t27/BKMNHGp3K5VthVDAbRFc8en?=
 =?us-ascii?Q?pzuobwN4RLY6FyuuwzklPxxfzEYzmLrI40JZSh1IHPVsnFYPDOiYurpQOJI/?=
 =?us-ascii?Q?ELaTUUytbaQdcSWbgLHg21FOKQX2PS2U5GGVy7IoGyDmsy+iuw0DPGP5AhkJ?=
 =?us-ascii?Q?Ggdqo/EYrVuP8U52OY/sFBBcwKE8VcMetNLhcAXY/JVdGWyxt2sJI7UyTVzC?=
 =?us-ascii?Q?V1OziaP1vZWb+wRZQIS47G1RuXo/QmTSX6zN1OLyQm4o+bVLq57KsZvnYmfH?=
 =?us-ascii?Q?BInuQxyyCOetWYSDvfaEVE/UPxV3EVByDG5GJ+udBZzLnF3MRb9hul/bPWUV?=
 =?us-ascii?Q?S5eY0n+ieqFZ2Zh3dmbTwXy3L3D1e3lF79G0hJY9tbY22LsfRYi99rN8Es+k?=
 =?us-ascii?Q?lowyRZeNpyPZlhkAgaMQT9MAEUMZ8Sc7x3ayPQimgyZZEMrFSkppghG3cSJT?=
 =?us-ascii?Q?9ydSdvYUChcsTDkAOPvsH8BSMeaiBi5dkc3O3KSVSc7Q4+zgpr4DQZeCCV0W?=
 =?us-ascii?Q?s4a+CAdISN6ysxLgI6TyQHUG1MEXmFtLiS/i5XIdKjOKRl/SjjA8z6z2iuZ4?=
 =?us-ascii?Q?tlkLBDHujSy/jaJRRuA6cHNlpFfUFHF5pLCzvjxOhPNO8XN+3mK55ypUo9p/?=
 =?us-ascii?Q?zTAMHr9TYktCwXAxYBcNVDpWBvphHV24n7WTSlkECQaeHb9AZOuhUCo/om9Q?=
 =?us-ascii?Q?nk2hINusAM1Dgo+WRRbcIRRp6OgrWGQC7wvbp10yxHMWAFmKk7rwgssRkbuk?=
 =?us-ascii?Q?ubA9p4+5GJSTGeFj4XEKd15vCC7HeZE0G8n9IXFd+Fwps5J4LEmfbRI1ICk/?=
 =?us-ascii?Q?rKMGg/66hnKHsDnEMspUtQHUOl31yEvItffY+o5W9uLKAgmxDxopQvbPpKgD?=
 =?us-ascii?Q?LLnY/GlXDBqqZ+PF09nAsbGNJmd9KBV5XPsWeZDTaUbgh2o78DCMm6P15+iO?=
 =?us-ascii?Q?3xu66htw6DFzXNOioNquwn9s/Zj7H2H0UdA8l7uMG0BG5wt9fSVj5izWDLI1?=
 =?us-ascii?Q?uuw4sajl0ezjNfqhsAAu1sW4Nk2+4tngETB+KZH1KUT0BcxceHzxly30A4pV?=
 =?us-ascii?Q?7DqkVT5WIRd1CjLOE6oFQQWEUXLaFM+LK6a+1b/6sJTzql8p42EYQfxLhwpe?=
 =?us-ascii?Q?FA2oyYQILjFvVb9e0EGugtgMR5B0Vscyw01nugFiHTKlqV6v+ksex8mbAqsV?=
 =?us-ascii?Q?AeofzSZYsfL3HH7OHSSvUjNDw3YeSA/znZ0iUDS2CYFr+0OhbUvXVNTpNdCm?=
 =?us-ascii?Q?ZtuRf2OU6jWhpOM1BrJMzOokfg97?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4215.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xzzB0lo+JdHJg798+L0PjD3ENalsn2/gueNec6dc+7wcuS0iA4qi/FDXO7i9?=
 =?us-ascii?Q?cjXLGC76KyXpFKYbvHLAFNgNlYQcxdF7uMlnSDzzbIqq6DBcCdMBdx1nCTnP?=
 =?us-ascii?Q?h8ewe3ZsiT8rJBDkFmKAzmmKHpOMT5+Bs17ioltrcH3niaVNd/kbG1G7Jk56?=
 =?us-ascii?Q?D+tnaYa6hbGBVjpLdzIOAeRM/TPCeGip9PKCL6JPlGLm8lde+rQa7RaoHwiO?=
 =?us-ascii?Q?ylaUDGc2nhHWGzjAp1w2YKxYaVCfCEXNaQgFaqEZDyw6KLK4tkg8uxeI1aYi?=
 =?us-ascii?Q?fUB+DCQeMjIl5vmS8LmjMIypQo68iTNZ1Gp4glFvHmOqnaedSizXagCJbbQJ?=
 =?us-ascii?Q?ACuW9k9+p7WLsItp8wtjYap7Kx7KwORn4BDuZp3037AYhKxYt6dPFf03fSV+?=
 =?us-ascii?Q?wu6UF13csTvRGW6T1FsvJtLl6YD6R2Go9Em6jusKEeZ4bYrH+9gyMtG/ab/D?=
 =?us-ascii?Q?1CeMJXnd+OQvMOusH7mnDnKlOj1AwODwcHIJGJAm3PklJ+eQRGbIp60RZrCD?=
 =?us-ascii?Q?RKU2nffB2zsKDUjYiAAlJfI+FfmdH4m5Ywupvrq1DrMhec4w5whl4njqD7zB?=
 =?us-ascii?Q?ktsqeim9SHksVpjrAt3JiMXsvuhPWuFJ+eG3fRgI7htUtgecfLqOr5hxjNeN?=
 =?us-ascii?Q?cXszQh3q1zT0lXQmxDSQh6DXg0jhmalsmFh28bAzjGUQxNwEyjLcFnNUUCNx?=
 =?us-ascii?Q?PjpQxMollRrEF21n2b3tSDEMkYmv3H+F7PS14q8hGyT9DTN+OJMEe+zzRI1i?=
 =?us-ascii?Q?5AdG+kSHFjfylfXXv9T8vI8s/8J84i/rhamjowefv/Q175TwsQyuzTukcWaX?=
 =?us-ascii?Q?+UrKG+glyE04KO4yvKG9Lc+X95+iElXPKJfCzDppjwhz10yrZtmSB5197l2a?=
 =?us-ascii?Q?d6k5khiIKUk0mJWazbDpFsq6S+3w4eluNOnHL6eFvl7dA6IDumS61cSlrNqH?=
 =?us-ascii?Q?WjBqssWnVq1e9QF1dwHfu4I6jjB3pLw2oW7aTKO8QCSUzNFPu84ZfyRHOqRO?=
 =?us-ascii?Q?eYEOtu/cJhJKLiVOHFKviFhIwVG3bcP6dG8velrmOT5hjKUkjnPlLQIF7SA3?=
 =?us-ascii?Q?zcU3QmRzJZSdSuKsOk/iBR9EX2296QESewD0EE/ml31ZUHFvLBybpulvIA1I?=
 =?us-ascii?Q?zFpfowhmnU4c1KX+R/p/E77F1ozSADXg4bQZsXvXrVkF0v4v+Pk9xmUtL12a?=
 =?us-ascii?Q?wKAsyJZyzYQ46Ebeh060KXQyJEe6VX4GpoPpYKgicViRgMZ1JwypJJeR0BcD?=
 =?us-ascii?Q?hsgM2JUt+dPyBipxjajmutJ6oZGgdsyDwFzuVO1TzFSbirQxvuXtZU1aIyGi?=
 =?us-ascii?Q?7vsti2a2wUxfuQ8bU+eQ57MEFlvftOod2pxLIAkjWe/zn9Ic5Lr0fWHqlAmB?=
 =?us-ascii?Q?Pe1jtGBwz/7QvCCmepQd9c+KWbpn/mYOSjLmSiTLTDBigXJ8R24vBhdz9z8R?=
 =?us-ascii?Q?V/e3CvEBcGpm50mw+8hg1quMSDfge0Bhwm7L5W99QWP4TDgQB9fkwCwPRvy2?=
 =?us-ascii?Q?b0hL2fiuuvHRN7+pV+tkSTZNT92WxV5GHXbm4Qgmil11QfgK7i2VvG84smHy?=
 =?us-ascii?Q?8ZDgHBcgar0kQW+hehLM6I65G8nPf6hnTUklSNiw8idlHtZQF0Qit3bpc+aN?=
 =?us-ascii?Q?2Jsyq1g1rQ32vUALInSboMogirBNgsEh4+3pnm1ATLWXXRjxGMA1Toaj99Cx?=
 =?us-ascii?Q?G60O+Q=3D=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ef17ff-3292-426c-833b-08dd32432449
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4215.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 13:23:31.4285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: upcRuCL8EFVizB1k73slbmAn0q5xV3A5FEViJhbeM3nUaQJUNeteSMIUn3wTYBjvxvrHrhHCCMQfp1VOfmeIx8oVHHgDbt3JBQc/462ZQ6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR08MB10066

The Airoha familty of SoCs have a UART hardware that is 16550-compatible
with the exception of the baud rate settings.

This patch implements code for calculating the baud rate for the Airoha
UART and HSUART.

Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
---
Changes in v2:
- Removed ifdef use in .c files
- Removed uart port defines from user-space headers
- Reworded commit message
- Added code documentation

Benjamin Larsson (2):
  dt-bindings: serial: 8250: Add Airoha compatibles
  serial: Airoha SoC UART and HSUART support

 .../devicetree/bindings/serial/8250.yaml      |  2 +
 drivers/tty/serial/8250/8250.h                | 16 ++++
 drivers/tty/serial/8250/8250_airoha.c         | 83 +++++++++++++++++++
 drivers/tty/serial/8250/8250_of.c             |  2 +
 drivers/tty/serial/8250/8250_port.c           | 27 ++++++
 drivers/tty/serial/8250/Kconfig               | 10 +++
 drivers/tty/serial/8250/Makefile              |  1 +
 7 files changed, 141 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_airoha.c

-- 
2.34.1

