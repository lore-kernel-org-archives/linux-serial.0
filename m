Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022072.outbound.protection.outlook.com [52.101.66.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B27A3DD86A;
	Mon, 15 Jun 2026 10:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519284; cv=fail; b=NCHIQBMXu0+OFOQ8GGVGxAgZZ4seeKcPSzYgroiurM9ZA02Ptf5PDVLqaXXmGGhCsYXtDd81C660SqKDJkzx4eIBkRpd5mopp7XzKCnK/bLNT53p4sgkt195EAyrK4vzOHH2zhWVH3iSMAqbEDmQWy8I/J+V1a6YaFKS+jww53g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519284; c=relaxed/simple;
	bh=5zPA5YrwC6Junc9WbpCMTRkntzfV5YD0VqrwMUQiWws=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Zr9w70Pipt1DrRiZlgrN2p1ZLc7VqCZQaaqIp5Js3lygjw09XNUlLr/cdwfTIBYhwyMUbKqRTpNwLpYDqoUkSj84ILdx+zhk4ONdSbBewjo1c5J0DEqwd+EGt9ebzJj4peey/+puiOZwhAS4kk2eHOOKbyBii0TM/LxaKslo66Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=EeTuyCzr; arc=fail smtp.client-ip=52.101.66.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="EeTuyCzr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpUg3GeIDiCXOAM0Z6nM/w1luNCfobjXAw3cnPmocwHhfFchHnDd297WAGCq2Ghfra2IH3jwQ9VHVXdC+opQjtZbNofVLT4+NkoBJen3yWrPgj419RgN54WP7cNNfPcjkcWIgbv7yb9lkAM40N6sC7pI/sbymA+uLDBBXolmN0pn2dvbhf2WgvYn00YkKVvtYp4DOwsORLBvpcKpQ17LOJMNQrEzNnuc0GxomrOliQd1OxNV0DIr3i1jNcwX6LOlPBhXw9m7IGoLHqWkVqkB/vjOVW8ym0Ks5jV+v6hOu9LsX0PcXVQr3hfdCCLTqreLdjojpW0lZRTgTpJMaDYyRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4/8x5bfOzYGPYooO2vHuoBIMfYEh+gFvp6kdvkC74s=;
 b=Ip7mV7JaKcfXRJxmU35R8JfLsnvXLFWmYOJrjmYoU41rvVfSj2413htoUmJ+RYs60AjkdCfCL5tQ2YmP6I3wagN37D85qwbATczt6xZG0q+EFLaZCLMYBdbqWVTg8iSlFWLvPm1EVObXYKHqcqHm53c7blWZsrwTnpKpxx7c7p7hJS5olPCIDAs3HGLgQymlSXCnN0gXp+f78fN2e71cbkOxkEbHVHxe/O7AWEwzjColJZ2zx4pb37wVSnkPgqmxkxvjX96cPjaE7ptMt9MxgPmPe/HqTU/6PGH6WwuTbXRqpcOfbsBFAVkQy4dbNNEZbNp2TahMPegaTXJFCekIzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4/8x5bfOzYGPYooO2vHuoBIMfYEh+gFvp6kdvkC74s=;
 b=EeTuyCzrfMVUozjRnFIz+BcZU228abIAfrbK1HiJPh8Kd+fdqjTQaJ7g9Gk5l853FUj+MSLOxyWzw7JbOZnzm5ywrYRRvQWYzvOGtqQqh9DUvqVBHRkx/wbxj19Yd1wZUosjkO1VCse1d9tbqU3cgi90nugi/JjQSy9MxOgUMPh6LBCe/OQDZeJCyrO0BzZv3xnFhtT1Mq3YpvEQjEVB87jnLQU7l5SSUT+cKB3X5lG/iWK1JM0NoncKWzMzh4L/fbPUEZrGYnrtjX5E3sLwX+f3Sca7So5wQ342+I/JnGqmqOVGKc9TTkEFF9XG9S88177zEOxk1Dh/JXRci6c3tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by AS8PR06MB8005.eurprd06.prod.outlook.com (2603:10a6:20b:3cc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 10:27:46 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 10:27:45 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 15 Jun 2026 10:27:35 +0000
Subject: [PATCH v3 1/3] serial: max310x: register GPIO controller before
 adding UART ports
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-b4-max310x-rs485-dt-v3-1-7e79f064bdd7@vaisala.com>
References: <20260615-b4-max310x-rs485-dt-v3-0-7e79f064bdd7@vaisala.com>
In-Reply-To: <20260615-b4-max310x-rs485-dt-v3-0-7e79f064bdd7@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781519263; l=4078;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=5zPA5YrwC6Junc9WbpCMTRkntzfV5YD0VqrwMUQiWws=;
 b=NilZbHMGIaeDSCJ/q1bR5IDHGR038ghMTU9mP5b43ycWuLwgV8I5gLulHgs3279lzTRYL3bxW
 JXDmo2MK9uCAobdFv4i2iaWsFQMGDSmphAB3cJTkoGZ5yCFeTwT1bXW
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVX0EPF0005F72F.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::2cf) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|AS8PR06MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 395d0d3d-801a-4369-c7ae-08decac8bd30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|376014|366016|1800799024|11063799006|56012099006|6133799003|38350700014|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ePpEprlybJA+bs+TG2EeUE82glz6HWn9Rm6cAJ2cdyJw/0lEWdLngfv0HyDMlpDxQWGo+NwSNbqaWoOqIwnnuvtUjke/rwsbR86kIElgCZXD/LQZsUm7aunILcZ27/OFFx8Bhvj96N7VLnfRJa4pub19gl2BgNxccjwjrkG43CVMQwy7XLkudtji+3b5mmRWasfD9HhL8yfJPCPZ7Pwg/dDZnUpTx0UGkirJTwUtMXGVEWgjd0fovykdftEbrzzSHx/j1Xt2iahZAL1UGvxP0ElZXuzgM6JTIRYpgNggRr+++ZjMp6LJ9kLZd2EZCNUdQgHADhSiiPf6FK5r8U2kjogne+489avzlAyqTIM/CouHRQuqQNdQEhu2g9GE8smJN1VgQVU5PycMlt1wifQHqBfc4quCJ2FoEsD3tf90iEX8mhiMEQi3sqY9zcfpzP7bia1Lr/08Awm4cngcebu6utPYYQ8TOK8414lmh33mkvPM0PAUB443WxnXpbCBEjQ5DZ7wID7tQsIjJgFTzPWmwZ89Iwo5bwo5FNSO8e3el+u2624W0rQLy8/dnGKXUxurfK2fODgcA96P0b7hU+WMokoM3WKdKkGjfwkGik6z9gC06GYRwznj1pxNZOfsXahYzNWyGK0A5NvPywN/V5bYUDDF8sRKUixK3r8XyYOnc0rqflJJmcCBKyT3lPtEfXob8eYzU886amsL4u68JktY3I7Tu6m+BtsJyVzJzLk8au1gJNmxFEhNek6x6K0mVkV0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(376014)(366016)(1800799024)(11063799006)(56012099006)(6133799003)(38350700014)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWdQdWhNSHp1VS9pSGRYcW9KcmlCM21KSXNHL2xLY2NzbG5OZGRubTRCdnlS?=
 =?utf-8?B?KzRsS094VmdZREtoSmFPbENVK09WbFZZVVZaNURZRDFhYkQ2c1pNLzkrbTQ4?=
 =?utf-8?B?WjZ5TmMyLy9BTWcxcW81OWFOMUhoZWhkNEF0VWNoSS9zSkkwUTBpZlZLR2Jo?=
 =?utf-8?B?dHU4SStJQ0N0NG91aG9DZE1lOVIwcWpEdUlwVXdZUk5tWm4xa1h0NU5JWjdp?=
 =?utf-8?B?U3BjcXZrZFlyeEp3dXZlYmUyNlQxUWxvUHJMUm5xRGdKMHpGOTBjSlR1L2cx?=
 =?utf-8?B?Zm1MKzF3MlY3anN4OGU2a3lIbEoyYkZqWkZHQ2tJeGxnbC9hVFB1UGZtM1N1?=
 =?utf-8?B?VG5HN3FYOHF0dVo5NDlUUTExR0hTV2RiSW93ZHlRcTkrRExNMXhFODFVNHg5?=
 =?utf-8?B?UjFPL3lNVEc2SlNtM25rWTNCUFhKakJBaEh5LzZNY0lJR0dBeXNjOXNnUFZu?=
 =?utf-8?B?RnFzMjl4YXE4M2o2STROTXJpcWZ6WlNhaFg1dWw1ZWQ3d0ttQ3Jsbzg2S3hV?=
 =?utf-8?B?bS84dlBCbVFDSGl4cTJOV3ViTE9mSzFjM1RuZzY4YnJ2V1RTaUFLMnRzSlkx?=
 =?utf-8?B?YlJpQkRnbkwyTnJWa3JhSktKTjZpZ3RURU1sRmtJNnFQS1RsSkVsOXBHQXE4?=
 =?utf-8?B?cGY1SFlSdXJjNVRNaGdadWJzNVR0Uzk4b0Rpbk8wMmpWUzFWUmJEU3hVNkZG?=
 =?utf-8?B?YUhzdTdaWW1hQ0V3ZWhuSFdpcjQzU0Z5TXgvMlE5Z3lHdlNsWXY4SzBXaktv?=
 =?utf-8?B?NktGNWtoRENkQ3VweWROTFRTU29PbjFYMUpyb0x5RzRJUG5weVZvVncvekE0?=
 =?utf-8?B?d29vZmg2cDRZRlJwSnZIVjhFbkFEK1A4VUZOR3ZML0NBWm1DRVJUZDFKbUsv?=
 =?utf-8?B?WS9vUFZOcE9kMnZ3QkZzVjNzakJiWEQ4bmRhSjUxSWdNWWJ5eTE2RTQ4SklE?=
 =?utf-8?B?VE9na0x5SDFYaWlSTnNMVUE5eG9wU1ZiSDhuYnFGenJrQ1BuQjhZMmRNWlFN?=
 =?utf-8?B?aFZseUlWUTZEd2VkY09lL1o4MHNxUEgzSU5yZVZKZFhiT3oybFFYVnp0dkRX?=
 =?utf-8?B?NCtQVVYwaFlwa0V2U1hUY1A4OFVwUkZWa2ZwUFFOZHVoTDl4d0ZrbEVRVVBk?=
 =?utf-8?B?bnB3bStPY2s2cHBqbk5kRjFIRWVGZzlOVU9IOC9VdVZseEZGZlFvN0h2TGtU?=
 =?utf-8?B?MHVQZ1pCL0JjVW5aanVCZDBSeFBWWlZ4WDJPeTBkL0R5VVVLTFcxMDVDVm55?=
 =?utf-8?B?VlMrTDg1UG1vZEg0Z2tXZmp5ejRsVVl5dEs2YjQ3RHdkRDROZE1oSDUwTHdl?=
 =?utf-8?B?cWJ1Mk1DT2d1RmE0N2xKM21MWUFKN2VOSEkwMTNLRktXSnMrU0lXUEdjTS9r?=
 =?utf-8?B?cFZaejJySzMzMEowekIwWlVURnRZVzNJYUZRYUU4ZW90cWJRbHpHaEhDNXlj?=
 =?utf-8?B?MjNhOVVERjVOcllTc1NDR0F5Wmtlb0tpNVJRdWU2eDZGL1AzVDZQOHNUWUtm?=
 =?utf-8?B?Z044QTVrazJBekkrVEZXalgwWE5jSUxCU0NVVVpUaENzNjJqbHNiZHdrK2l5?=
 =?utf-8?B?WE1KNGxveWdYeFphaitVNVpnVHg4bFp0YllmQ245WWRsWGpna0JOeG43bkJo?=
 =?utf-8?B?NElJaWg1ZFVIWVFSSVNnL1ByTFRHYklONmVIcUVmNVM4THJQMzFpMzdldUVO?=
 =?utf-8?B?TndsamJWNnhmcjI1WUJhbjViRDd0bkNCS2prRnUzYWZTeWRwKzVSR0N6ZVBm?=
 =?utf-8?B?RWI4SkpCb1ZXOFRSWWFiSDFyS0dlVGJVMk9SSksyMDdXZFphbUFVb3hXbHM4?=
 =?utf-8?B?aUJMVGEvRUtwWE4xdkI5THNidXlBa2ZpM2hteThadUpSbUcrUS9KUE4yNWlm?=
 =?utf-8?B?ZmR5WXV2MXBOdHRMZkEwQmZ5K1JCUFg5R3Q1K0VocnlJa2g0RVpiRHowWUEr?=
 =?utf-8?B?TDZhOWlDKzhRNEVYNkJ5RmhGMjFDNFA1RC91T0cyd2sxek5KaDJ4cnlteVlK?=
 =?utf-8?B?WW5nT0hRQWJ6Nk92WXJadWozYXFtbFRteDJIN3paZVFSa3dlaXozU01qeEJI?=
 =?utf-8?B?QjRxQ2pudVJDTTJoWTYyN0lHcjJ3OVVLOUREN0pjM1ZnMlgwVXk2VEs3dUNi?=
 =?utf-8?B?SGpKM3lkcVBLWDd5U1VWMmo2L0FuOGJmZjBXVlQwK2Q3eFFFZFlrTnd2Q1Mv?=
 =?utf-8?B?MFFVU3pSaHVLUHpidHBnK0laY0pnWUxIK1pjSUxFeHpZalNqTE5vdmJQVHE0?=
 =?utf-8?B?M09iYVN4YzBDMEE2cFp1bTVHdnE4cW5ndi9WRGNpVHd4c1UxcU82d1BtTlUr?=
 =?utf-8?B?ZUVXZE5TMlp3d28xSFJzZE5zME5CUFMzVTltQzJsdm9vdVJXL1hENjNoVTJu?=
 =?utf-8?Q?oNX5a1Yd762RNyg0=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395d0d3d-801a-4369-c7ae-08decac8bd30
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 10:27:45.0507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2gCiSNo7zhkyLJY0Q5l6CPecal8nUUi2EJkN3qNI+U4fpjZZnijH5L8bxwTRWB91Ca0qT5bX6nImaifwKVK0QRNpFe7yLKApleLCTbJRaA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB8005

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

