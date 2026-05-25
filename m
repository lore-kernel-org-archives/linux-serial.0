Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020092.outbound.protection.outlook.com [52.101.84.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3663E63B3;
	Mon, 25 May 2026 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779702247; cv=fail; b=o33cXHSKfgXLhNf07cnzbyaex7DDSFNLiXhIhqBojmoVlZjfbht71KLgDll3EAO1umnYKeVDnVfY2WAp8ICo1c9TqjLWN3Y7EBPdcSKAOVBjLJ5YR2B++wVqi2MHec/dXjU2GF3wQuHiFETD36hT1E63sHiBVWjLYdJ+rO2vTwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779702247; c=relaxed/simple;
	bh=5zPA5YrwC6Junc9WbpCMTRkntzfV5YD0VqrwMUQiWws=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UnVQf4AM8M6EAJxnRtuYJ64YnNyTz1uJyFeBeQmyPCQj10eN83/AiTeHafLj/lbn1i5A9ftlyxF4wyqONGQyllTbiZBi3Qv4CSZS/v5D20v3iIRivhhbR4vX8vVX8zHduwbVTFkG1FBjiW3GMmLS3Qzb3Svr2FLeQMM4r8vOofE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=s6uK3G3W; arc=fail smtp.client-ip=52.101.84.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="s6uK3G3W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZDufmDhfonv8A2sqls6tcdNb+AE1G0xODeGxeY5+Hl0MKf6K2PL+Gv4GjZMRWIv3ohSajdDZAn9vRRHvsZROVlPQBD09tyGpMTdAGJCe/xwGTnxJXG8vJ4ey5tIoKlUAtw/KPxdlcoTzmVV+v8rW//yRPVWcSZZvU4jPt+WXGkQvVO2pAWzR4Un5quEH+OpmKcIlyh1UGYm88tzWXAkpejSNyHVUqlU1zmAo/Y7e7cWEG4Z4/c6TL66bqnbnOiECTQZcMtbbJGCceWqM+vQyAhRMVQEjVgEMkfejotPSRAne7i69i0pPzA+B6aZ/re8RZNtfd5qLtDGFWaQ9J6DsmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4/8x5bfOzYGPYooO2vHuoBIMfYEh+gFvp6kdvkC74s=;
 b=KXQ4bjT7ZjanMVEdq8WlrN1Tk+R30/+7jNnupNMWfr3KvMKJn+D18j78OiyKQKbButoY0MGClWn1h8I1BZoMTLvOLhJfZdjyuT1j5PIF2w7rnmRj/0Wn53CiAib46OE2ox7BCUFPBQJzMnibyA4JpztPd+f0cgm5eREmehWt2imaiq4s2dznrqjUYjPJMMCRglKWJ/3lX1lPKoZr1uT6WsnkmWKyTbu+1OIMRiGiF7+6keIaBznlLJf7lZZFkVuLJMHikPZOkq2tqsCWS7tBjka16bc5Yjkg0RB4lUWNrFS9vnDwql50cNBgc0kr1ugzLFdOEJUWiA4bMzqJvGUkPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4/8x5bfOzYGPYooO2vHuoBIMfYEh+gFvp6kdvkC74s=;
 b=s6uK3G3WDMoVIYh3ali+QgFL84nSZ4xH8eCy2syqxyok9Qbk7n7SgsAVpr6KFJod/Rdx1ixy1wOfcLF+8dpHoP2mZ9GLTqGWqsOFXI/RDSRR1NEVog9mv8ufFasWeiwVWOzGv/3OSjSVAI6kE2j609vnaDE+u8bIQW28aXcX7O06hUSe3VS1UtUqLzDoFi1MBuvSZiaIJnIQBeU5qNIU6bjTkW6Wu+8Wr7CcrZOjncm8ke731Bdlyqvpq97TShogG9Cf/NnulCmskNdQoUfJH9TdZioWdiR3O5yAnAWPASUOKODnkisLEG4RllUA8UYQmg4z74WNdExGMg0rRaQvEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by AS8PR06MB7608.eurprd06.prod.outlook.com (2603:10a6:20b:337::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 09:43:51 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 09:43:51 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 25 May 2026 09:43:37 +0000
Subject: [PATCH 1/3] serial: max310x: register GPIO controller before
 adding UART ports
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-b4-max310x-rs485-dt-v1-1-e6c19b4d5592@vaisala.com>
References: <20260525-b4-max310x-rs485-dt-v1-0-e6c19b4d5592@vaisala.com>
In-Reply-To: <20260525-b4-max310x-rs485-dt-v1-0-e6c19b4d5592@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779702230; l=4078;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=5zPA5YrwC6Junc9WbpCMTRkntzfV5YD0VqrwMUQiWws=;
 b=wxvquJtYJLF9Flgw6OGQdrg3xmtHm15Cy3v1jQhLfKte8ky+o3JfL2cb1+ocJzGvyqFFgAoK2
 yGwYTsPek9uDPaDZHryVe+pAwy0v6BZAAcMLtK8zVOBAPiFfhXqQqU3
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVX0EPF0004F082.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::626) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|AS8PR06MB7608:EE_
X-MS-Office365-Filtering-Correlation-Id: 2030f1ad-7c6a-480b-a33a-08deba4220e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014|6133799003|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	pWRGrGPOIp76BLHuWLOLALgyA/5sevDM14zPW0JovvhpEm1SnEhOTRFBEFDkwjsxCZDqtOcB8OEUOUlQTXpAlvk3x1NUwF/aRf8r/ptAa2PKjr4fhHOh7MR9QxiTcdEXf3O2RCJVVkUndrJda/i6VDvyLBiPFvMaCQ7NPDJePBNYE9ie0TZ+whtGCRyYGUOP4uxPuPcGHnwWK/OlGQM4zN90U0aC9AtQvMvAUHEDjCENn/QAxXDkZu1GoseIoo3j8Q1kwCpf7nCPBvUwTDn51WJmX5OSF1vhqDIdWSzmcF0eml/bsIKL3hRy3XBZc+RbB228h/v2ossPeuk0EDwkFjipxSyM7tKkQXXfSJ+4lr1NEQc+ozwAi41/wGaF4+QkDH9MPFoiblxHSWPuzErspEp4ow1GWDvFUhhsmXmf3HGOF9XbxuK4Eil/Z5sARdVEA8iprx1kVyFwQx3PdlReDW2CcwdkzEjpZhjm0fthOeKQfIjrfE9nV6in3rwBFWRDAR/XA+mT+wIFXL9QQlAASK2CwptdgR+kgPw2Jz6KDLIUQv3/skLNfqzapiNQ+2Vo4XaPsNTINKPmThkgESHPlhtk7xdcwMpS/Pje78HDR4W/4NksviOJV4XBapAuhtSLLu9zZtacEVtvnaHIjsSnfWROibQ8+z0q81UByXQujf2KWOgKxIGpSxEKOnBM5ri3r+hY2kyDJcYl91sLpaMBEdGx21xr1mKxGtiYhvMjPznsefW3+jZTF8xQrsAhxPtI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(6133799003)(11063799006)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?LzdEN2NsdFRZWlhpWjlpRXVTQ3pBNXVlWk04cElzcWc2VUhBaXRSa2gvR0hk?=
 =?utf-8?B?UVp5dzF4N05TM2plNGIwUVJ6cCs4RzJ1Wm9YUEphaTVrdVpzMGg5ZWdwMlYr?=
 =?utf-8?B?ekNEWmw3SjhNZzdmNks4b2RJMC9keWhOc3NOZWYwUlpqaWViQ3daUTRYbHVh?=
 =?utf-8?B?RmNLMGpzNEkxL1FQZzhZTTBLaUUxR0dKQjRHUkpySnJSTldSbWlPeGh2SjhZ?=
 =?utf-8?B?NWZ1ZExuc3V4c2xNMVVQbXU1c3N0QmlpSTB6U25iU3VEb3VyNVNhbzVBc0ZS?=
 =?utf-8?B?QjF5a2wzWkZpVVRmTzNpd0lkWnYxNHd4RDdZQ0VEVzJNb3RTc3l0K3ZyOFhu?=
 =?utf-8?B?Q3RIRS92YlBzY0YyZDF1eFF0ekpvdjR4ZncyQnFoNU5zdWVwNUdzM29VZzRq?=
 =?utf-8?B?bm54R3Z4NlRaVTlkREdEYnoyMDB1bmR5WVpsZlNjRGY1aFFiemUzY0drVk03?=
 =?utf-8?B?TFIxRzNNTUw5cmpnSFRjcjZMV0xzS1g3TDRyUkV3NTFPOW5oUHpqcWo3VmdW?=
 =?utf-8?B?VXNUeERzRTVuNFNSbG9COU9ocjZQVmFreVRkdFhkdGpCeHM1MHdhVndrc3Va?=
 =?utf-8?B?WGZkSU9zS1plOHhFdFAvZ2NDSG5VaVlmM2FraGxkNWIrckd0a2Q5ZFNnUUNG?=
 =?utf-8?B?MDhIZ0VBbm51YTdabWRrQXBHbmZOK0kxSkJuYWFEUW1PS0pIQjVwczl6eTUz?=
 =?utf-8?B?elhTaXk4SURRQUg3di90OGRTOFdIcDR3ak0yQ0pFWC9INThvUTIrYmNWWEgv?=
 =?utf-8?B?cWhDQ2NmdjBQSHppY3BsVjBoTlBKN0RzcC9MdXcxZkdpMENZd3FXbWw2Q08x?=
 =?utf-8?B?VzVEVFBWU1RSUnFlRHRNbUwzWFlPSkZ0Nm45SU1vT1BhaDZiNUNZS0h1LzVP?=
 =?utf-8?B?dmg1MjU3WkRwUDFYbG5GRXVGTldDUHVLU2hkQis1TDlYVnk4cFREaW1jQ3RI?=
 =?utf-8?B?NDQrS3U3UWltUlJwWDN6OTJ5Y1ltQSswSnk2NHpHSldFc3dhSTFsT2pURk15?=
 =?utf-8?B?TENIQy9aTk50dHoxaG9leW9vekM2S3Mxcm56TkpZWTF3NE5jZ3FBRWVXc0RI?=
 =?utf-8?B?d0tIa1VkbHFmM21UT2dST0NjOHJ1T3kweDF4YmhSUVZ6eWZ1TEQ4aXREdmJp?=
 =?utf-8?B?ZFdVaWxmWW9ycHNLT3hpdnZvTG5IZGZNK1VJSW9RNmFpNTQzc3ZvTHVvWXZY?=
 =?utf-8?B?dkdBN0RvNzE2TlJLb1BpUE5RQ1ZiYWlvTHlkWnZvQlVjVmRwa0xpa0JUdnMy?=
 =?utf-8?B?OW8xOUNGMWo1aHpDWlBkMWJpUzFZYkhQcDZYSXlROExOUWFqWWZyRlpDcnZq?=
 =?utf-8?B?NTFoMExQRFJxVmhPWnpsdFV1VDl2akNxNXNoS1dqWml0empRUDE1RTd1SzNx?=
 =?utf-8?B?WkNhUEZkQUptODdKZ3VqK2QyUVNxK25yK3Qyd3pmUWl5akhqRzFueXRRWW5w?=
 =?utf-8?B?NE04dmZoVWhza3RhMTlLVTRpWDhPaDYrT1JnT2JKbU03VDR0dnVJNjhOczZW?=
 =?utf-8?B?MnZVU1NRcU9rN2M3ZHhoV1h2N3RHYVc4bm1rQXlTeEdyVk9vWXhya0xYc29m?=
 =?utf-8?B?TEdvakVnRzd5ZDdlUnJObFJBcXo1T0oyQXEwbWNNbmhacXFtb1RZRVJmcWRT?=
 =?utf-8?B?SCtNbXhiWDNXU2Vyakg3MGR4VkdFc2x3WlZuazJyUUpvQ3VNWllnVHdtd3hn?=
 =?utf-8?B?SGEvdDhDQ2pOME1jK1lqb1JyVDNEWnc4RHZkUEtwWFMyK3BSQ0VIaTRSUERQ?=
 =?utf-8?B?Y1hURmIxeHZrcE5XL0ZEdVNXTTZlcmpGV0JrMlJORGNFMUlleTNxSDFwTmNl?=
 =?utf-8?B?RTJCRi9sazJpOGtrTHFJdTFmZVlLOWhhWFpnOWNiSU81SXppVEJkb1B6Wm9D?=
 =?utf-8?B?a2hnTlF0UU1xd0pUb3lzdzJsMUJSS1hIZHljNzU1STNYYjB1Z1dFSlVjdkJj?=
 =?utf-8?B?ZnNPQnBWdEhFOHhsRnVjQnY3KzJGS040RFl6QkMzSmFOaGI1SFFNQnViSFcy?=
 =?utf-8?B?ajhBVFF6UVpZZWpheXgySkE4VXp1UThra1VLVUdpK1ZKWmNKL0FhMVFvQnBs?=
 =?utf-8?B?V2l2QzhIeHdOaFhHbFl6SGhORDZBSHdaNVZqUU5rbzRRYW5iT2JWV0Q1TzA3?=
 =?utf-8?B?UmlibWFiQTdNL3Q0dXh3bVdVVHA1SWF2UU5WeXNlT1lQQkRBTUxHSWh2Tjgz?=
 =?utf-8?B?SzJBMGJ1cXhWaVBlQ0E3cTlZQzF5Z1BlbnREQnJmMWgxdmg4MmpLcHVzL3JH?=
 =?utf-8?B?R1EwUGJRZHFUS0ZVV00zeXNJeTZFMCs4OHcyVXd0ZWdUMzFtUTZ5MDd3VEFP?=
 =?utf-8?B?TlR5MzlKSmY1a2ZzL3VtT2R6T0VhRmY2NzRjVS9hRTFCeW90bG9CTkV0SEV4?=
 =?utf-8?Q?99eIUD1mYgMC27Fw=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2030f1ad-7c6a-480b-a33a-08deba4220e0
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 09:43:51.6326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6q/WuBDD1wXj2FsMFSPONph9edw6By99G6C56b6nKqZ7A7MjHFQke1p/RX0yFMmJeuPfN1H7x2kOJ16Ed1Ojnv3fuO+Rc+0ixMj9XPBmYrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7608

The MAX310x exposes four GPIOs per UART port via an in-driver
gpio_chip. devm_gpiochip_add_data() used to run after the per-port
uart_add_one_port() loop, so a device-tree consumer referencing one of
the chip's own GPIOs (for example rs485-term-gpios = <&max310x 0 ...>)
could not resolve it during port registration: the GPIO provider it
waits for is the very driver still trying to register, and the lookup
returns -EPROBE_DEFER on its own provider, deferring probe forever.

Split the per-port setup into two passes around the gpio_chip
registration:

  1. Initialise per-port state - port struct fields, regmap binding,
     IRQ disable, work queues. The gpio_chip callbacks dereference
     s->p[i].regmap via to_max310x_port() and become callable as soon
     as the chip is visible to gpiolib, so every entry must be
     populated first.
  2. devm_gpiochip_add_data() - register the gpio_chip.
  3. Allocate a line, uart_add_one_port(), set_bit(), max310x_power().
     Keeping line allocation, registration and set_bit() together
     preserves the existing "bit set <=> port registered" rollback
     invariant that out_uart relies on.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 54 +++++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index ac7d3f197c3a5ce3531d5607f48e21a807314021..5cb7d01e404663dc25b88bc7b4f8df61be2135ec 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1364,17 +1364,12 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 
 	dev_dbg(dev, "Reference clock set to %i Hz\n", uartclk);
 
+	/*
+	 * Set up each port's state before registering the gpiochip,
+	 * since the gpiochip callbacks will read s->p[i].regmap as
+	 * soon as gpiolib exposes the controller.
+	 */
 	for (i = 0; i < devtype->nr; i++) {
-		unsigned int line;
-
-		line = find_first_zero_bit(max310x_lines, MAX310X_UART_NRMAX);
-		if (line == MAX310X_UART_NRMAX) {
-			ret = -ERANGE;
-			goto out_uart;
-		}
-
-		/* Initialize port data */
-		s->p[i].port.line	= line;
 		s->p[i].port.dev	= dev;
 		s->p[i].port.irq	= irq;
 		s->p[i].port.type	= PORT_MAX310X;
@@ -1404,20 +1399,16 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		INIT_WORK(&s->p[i].md_work, max310x_md_proc);
 		/* Initialize queue for changing RS485 mode */
 		INIT_WORK(&s->p[i].rs_work, max310x_rs_proc);
-
-		/* Register port */
-		ret = uart_add_one_port(&max310x_uart, &s->p[i].port);
-		if (ret)
-			goto out_uart;
-
-		set_bit(line, max310x_lines);
-
-		/* Go to suspend mode */
-		max310x_power(&s->p[i].port, 0);
 	}
 
 #ifdef CONFIG_GPIOLIB
-	/* Setup GPIO controller */
+	/*
+	 * Register the GPIO controller before adding the UART ports so
+	 * that consumers referencing the chip's own GPIOs from device
+	 * tree (for example rs485-term-gpios = <&max310x ...>) can
+	 * resolve them at uart_add_one_port() time instead of receiving
+	 * -EPROBE_DEFER from their own provider.
+	 */
 	s->gpio.owner		= THIS_MODULE;
 	s->gpio.parent		= dev;
 	s->gpio.label		= devtype->name;
@@ -1434,6 +1425,27 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		goto out_uart;
 #endif
 
+	for (i = 0; i < devtype->nr; i++) {
+		unsigned int line;
+
+		line = find_first_zero_bit(max310x_lines, MAX310X_UART_NRMAX);
+		if (line == MAX310X_UART_NRMAX) {
+			ret = -ERANGE;
+			goto out_uart;
+		}
+		s->p[i].port.line = line;
+
+		/* Register port */
+		ret = uart_add_one_port(&max310x_uart, &s->p[i].port);
+		if (ret)
+			goto out_uart;
+
+		set_bit(line, max310x_lines);
+
+		/* Go to suspend mode */
+		max310x_power(&s->p[i].port, 0);
+	}
+
 	/* Setup interrupt */
 	ret = devm_request_threaded_irq(dev, irq, NULL, max310x_ist,
 					IRQF_ONESHOT | IRQF_SHARED, dev_name(dev), s);

-- 
2.47.3

