Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020087.outbound.protection.outlook.com [52.101.69.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ED53090D5;
	Mon,  1 Jun 2026 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780309561; cv=fail; b=Ho7WO4TyZOs9OZ7GMjdtakmDeNPUFa3OXAYfUJZBR/W483y+JiF3VRzW7g4KCERpALrlAnbePNtvqlrLRdacMIhecgo0sFylLONj8JoSRTCDGcYavne6u72KrjhumOtow5e01DAoq5oDChHT7bAp+p1w/PJOVmQ1rBYM4VXjmiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780309561; c=relaxed/simple;
	bh=5zPA5YrwC6Junc9WbpCMTRkntzfV5YD0VqrwMUQiWws=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=FmCwMig3oJrwlVkn0AxR2imxkVIa1FO7/VjqKLEs+QCTn3HonyZT1qA47T88nwHTWxPjYBY1hfq8Vj9sexx0Z5uWnXQC6GhRdgtwB6cinHeknGi4rDey8pMHJYahCXeY6jlZTk9uGA1eunQbgtzDYjHABGO6IOPXNecQym8uCOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=suMEckh7; arc=fail smtp.client-ip=52.101.69.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="suMEckh7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EU47Wyu4ci0xWLvwMQrzTnGvXqm3oUnJeVZJOUty89qE/KO5zjF0l7hHMAIXm39tXqSo0dHBj84ghtJhAs4BgGuciDWGabbnPwIfnKOD47g23Uf3WhVMYW8HJAl/4NYJRgdQJfgpiqXa+o/b7O/f3ZC0mD16YHG9xkvPOcJDgZlw9ztQoRnIsOBURsgCXQ5La2a/3dt0eQIF8LitwUWK2VwKgo0l2wOYpAhkmvI0oWMB+RphX+YH29hhCifOBqOTTFkysya/sfFcBOlSI2jxecGIshmALTg2R3DWwtWqhe6PSbf2KRwpt+/IpqBjoO3u65VDC7KFve1NmZhu8jvYGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4/8x5bfOzYGPYooO2vHuoBIMfYEh+gFvp6kdvkC74s=;
 b=NOh3Fw3IqbswZqMdIaiGUlxKqG6VOc9Kmzy/q7setz9+5rck07t/eOweeZGD0dfLb+vGcyyw8i8cYjjg5YL3gfBFPJ3tdJFTlCZfeMn0Cb2dQEOxUVTT8gIFk51hTjouQu1ovg0v4bP6jW2SzE759nzTN4fs53yZ7bTxKpgPK1mngb4WtPoW/RBCOy70sUv/AnrqLyD35RTJ/RefHhllvUCtflAzS6qQiWMtuaAKdFJJRSVYw43dqwbjRduX/Pa0n7wp20c1uyXwEuPezwRaYeP3yEOnkA59H07rXRVEjaKQgikLh4Pe8rS71vMtYnUOwULK2odtl2hFhIExPN9ejA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4/8x5bfOzYGPYooO2vHuoBIMfYEh+gFvp6kdvkC74s=;
 b=suMEckh7O3NC/ce9zAhTMfCPNHfQV6l6ooFjFT/DPql63Vc0pbKO/JHjUh3AEQF5Z/oEnGYOJgthxT2uvY2bXUc20DHUcPvsPaYhnpnPa95RXQC5sY+PTzOmF7t6oBXHMwlPy2vsYkzKm1uBAvxNT8XNwonamWEqhEzu3YQSjzkmhFYDwTCX+La8n/IpRUTyDcqzce/NH9WJ27oJfyQypXfKdrCW9LzsrcIIAlO/gJZn1RMV9RMVU+yIhTVte2WFV37m4u2/ZtedmQaJnF/QvjXYm9AjPo3YzA0WpM8FzbdlYuFUcJ4VDJLf5Ku+MJFgA8Abvu8uV7/CtmWKuETNHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by DUZPR06MB8775.eurprd06.prod.outlook.com (2603:10a6:10:4d9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 10:25:42 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 10:25:42 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 01 Jun 2026 10:25:31 +0000
Subject: [PATCH v2 1/3] serial: max310x: register GPIO controller before
 adding UART ports
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-max310x-rs485-dt-v2-1-a105105f8e70@vaisala.com>
References: <20260601-b4-max310x-rs485-dt-v2-0-a105105f8e70@vaisala.com>
In-Reply-To: <20260601-b4-max310x-rs485-dt-v2-0-a105105f8e70@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780309541; l=4078;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=5zPA5YrwC6Junc9WbpCMTRkntzfV5YD0VqrwMUQiWws=;
 b=OGa6SegfV9N+Ou3k2KgLVkWl4puVfhuMRx3Um/yFgrH3SYjWt1jRPplvG29foNx9fvkBzixWS
 Ir9rh5B0x0uDC664HcSiwht5wvWgCxjlBFQhoK3stmHDLyt860VdM6s
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVX0EPF0005F6F8.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::25c) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|DUZPR06MB8775:EE_
X-MS-Office365-Filtering-Correlation-Id: e7445f32-3cad-4e52-d4eb-08debfc8226c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|22082099003|18002099003|6133799003|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	XtQGHra0LV+k1noVbpBdBHjE5LZR/qTTI0kpmlnrRbmjMTUrpJvudC+/r2pzNCDLWgAEQu0YHNSRIJSHWYQr/MmLiIP7ESTcEfPZy+e19fFNrdW6oaVPOwEREc++LIdA0L5a2ravbJMQM5CQ3TbYBKyE0RS5kPqaRMELVXk2FPpj5RkAWZcTKTjZ0zrYRY7viC5Ur8m1iL3cyNefkyqdSCkxCxjCKFQlnXsKkzmclhheSbxAL9PdZNYcBPMa6erjQH/SjvO59o3KT31bAkzEgEAnBOK7sTCtlAPENXeirvA++Bc03tmuoGeCyizsJrOO08JmUe/GcIJFgkeIJgJ1+h6eUfl6VEr9pLS+yYT5SOAIq+5FFbwZ/Y/dWnQEBMbWrSydzF5hazBbtjf5neFWGZa49b5V5gYx0W3WHXVZtJXk9PEPAXnR67AxYZ/6BKCe3lORfeeqUg12QUjWGWwO3vwKOYGwWpk5A5638aqgbrZClefeYQA1HojpOt4+XJms1XpEFOtPInhXyEaIRO1x7Ibf0ADJ0eFCbVNPQif8BIDy0DquY15z7TfSBp/bAVrQh6q+5YW3tlNoI0lA6mLz+na35cgfedlCwQOcKB2/Wm9xU3JxTiP9ApxiUlRGaaSg3PmOglK/BlnamhSfD5rJNhRUauBgvJqPXgnmRTWWI7FsB6JUhf7gsGEngKzYwomQqtL9Zttcx4Q9RQq9Txjwwe9C2x1SCL2hIwA8jsytJyWnQMIVJjPccWz7Sn1Ow+pS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NkNnN0tGVjFYZUttVEJKZlRURm5yMzh2NGY3QmtETFNhMHN0MVFPckNFUjdO?=
 =?utf-8?B?amdXUDN0eXBCcU4rT2hXR3k3UnNrSHFvRG9yaEFKVGduN1pqbitYb3VWc3dr?=
 =?utf-8?B?ZmR0K0dZaytjTzBaVzVjSTk0VFIxZXJWRUJPM0RlbzlZQkJKaXFNWjdlSUpm?=
 =?utf-8?B?aWNTWGdlaFMzRm1RVlY1M1Yyb0pFaWZQTjNCRnVWRzdsRi8xUndoWW1SSU5z?=
 =?utf-8?B?cjlDQk5jS0plUlNNZ2FVY042WjRuQllwN1k1cHNraTBrVk1ndlZDaGpWY0pV?=
 =?utf-8?B?dmtMNm5nOTYrSkxiR3Y1dy9SaVJEd2p0TmhXYUxnOTg5ZVVUY25oOVpQdDlJ?=
 =?utf-8?B?NGRQWHF2OTFab0drVzVRR0tVV0UycnRnbVlMRGFNZlQyNXQza0t4OU9qeDZC?=
 =?utf-8?B?ZldpaWF4NXRBZWJlYVpkeHZZMW9MMlBEUXA1ZjhKVmg4ZU1oSlRnL1hHdGxC?=
 =?utf-8?B?ZUJyWU5YOTFFMVVMamgzck9KUkJWM2ovaEtRN2dVaTF4VEZLSjRlWVdCN3ZP?=
 =?utf-8?B?VmlVSVdMbXl1YXpLbkRabW9XaDNmdXhZWTBOWXUrKzZqVTBIK20vM2Q0OU94?=
 =?utf-8?B?TzZtamJwcFExT1E3aUI3N0swRVRxa0RkT2FJd09wRThDTDVBd3N0a2NRV2lV?=
 =?utf-8?B?MEJmeUMyNFYyVWI3Q0dtNDVsb2pzOHlUOGM2RkdzSVhvbHQ0T3lwUGYrZ0Nx?=
 =?utf-8?B?QWNnck1PWUN3Z2pkQ2QvZjUvRE5qWW1hanFCeHVXU0xNZ2czYXB6MUdpaUp3?=
 =?utf-8?B?VHpTWmZpRWFaR2ZUd3E2aUhuckxWMmhqWU40SkF4Z2w3dzYyMkh3UHhtb2wv?=
 =?utf-8?B?VzRpUjdodE1keHZicGttUkc1OThFMEtUREs3RUh6R0svWkM5RTh0dWZKaHFl?=
 =?utf-8?B?bDlGMHE3cHVSVHd1T2pWQ2Yzc3VjY0Q4TlpNWC9oSm1DRThKMU1mU211UGJT?=
 =?utf-8?B?b2NjdktSRmhhQXY5ckJaekZaMy9meUxZOUhRYnpYenEyYmQyUExQZDQ0cEl1?=
 =?utf-8?B?RDZtS2xoRXJ3RWhscDN1Tm5pMnA3VUlZQTNXWkJMQWtxdlRDMTlpMW9janpK?=
 =?utf-8?B?ZkRsWExkbW1LcG1UbmJMTVY1TUtMVCtQU1paK082Z3F0MmpMRDZHbjdxSmhX?=
 =?utf-8?B?OWJSNmRwWEFUanQzdzhMelNEblVzTjRVZk9tbWVtWVJpMDFSTlRNVmpjTnAw?=
 =?utf-8?B?bGdJV1lHV2crd21OYWxLc0psSHRma3JYT20xNnRUR2VPRGkzN29ONmFMQkZo?=
 =?utf-8?B?Tjc4QUJaRCtKYzZSdVRKUVRTSDB6bSszTGFjTCtSbDdTS29ST1Z2MVhrNS9E?=
 =?utf-8?B?LzlGQXkwa21Wbm9JYmozY3Rjb2w5ODFUM3JZU1pXRktaUEQyYlRPRjlGNkZs?=
 =?utf-8?B?NERGcWpKdFMwdDA0eWw4ekQ4QjlKR0creC9tZlVDaFc5VFo2dTdKS0xmcHVl?=
 =?utf-8?B?YTZGSmt6UjByenJaSE56RTJPdHFPNDlNQkJ3WU9lL3E3NTlxc1FjS0FNc0w5?=
 =?utf-8?B?KzJRZ0gwZFhiSHBBUVd1WjE0S0t4dTJRWVRua0ZlVzhmaXJ5ZXI5eDZuZHZ3?=
 =?utf-8?B?YjhEalBnWVRhMGtoS3E3ZFNsTlFFczhyWFU0STArT2QvbENKa2pNbW52T3lI?=
 =?utf-8?B?am4rbC9TKzFnRG9OSGg5WU1rckFTQzcwS25HWXQzcUIzb1ZVS0dUcmd6QWpY?=
 =?utf-8?B?OU1Mc1VoVmtkVjgxY0VqemM4K1ZXa1YvNXUrUVJPVDRHeHlBbytHNTd4MEtM?=
 =?utf-8?B?WWRPUnM0V3RXUjJ5czlnMGcvbVJUNnVWMXoxUGowWjZMTzFiU2piL0hlcis4?=
 =?utf-8?B?dFFkMnRnRUxwNHZPNllrUUhxQ3B5QXNFZDJrUEd1dkZpT0Y5UlljRVo2OGNB?=
 =?utf-8?B?cFB3K21vK3pJdTVEYXJuQkl5NWFjOStsSVc5eFEwMElxTE4yZkhqckdiT2g0?=
 =?utf-8?B?OHRkV3M4MlhaSjJuY0svUFBNUEVZUHNQb0ptaXpKaFNZSlpub1dUQUdWZERV?=
 =?utf-8?B?VGdidEFFR3d6OVdvaVBHUkxsWVR2V0dha0x5U25ha1RYZWVVUFZjRFBaMnAx?=
 =?utf-8?B?a1ZZQkdiWENHUG1IRXRaRjZzdENTeWEvSnh3cUlpZWJpUGxiWEcxckROV25s?=
 =?utf-8?B?MEJBelpReHZGWk5GME1pZzRXVXpKS0sxL3MrQWQ3TzFPRmliTTdzMmdqWnVK?=
 =?utf-8?B?OTV6MytiS2ExcHRTYnB0aC8vU3JKUlkzTHBQbWl2aEVEOHR5UnhMcVhQdnFY?=
 =?utf-8?B?MkxyUXE0SnRBS1MxZEpDSmNkam1GSkdxeVBLa2tuUk1PSTZlOGZzZXBheXdS?=
 =?utf-8?B?cjN6b3hMeTVqY0gwTTRpTFhvS0U4YWN1aGhiYUErbDE2MkErS3FPSmxVTlBy?=
 =?utf-8?Q?NypoCW/L1Go6rJ0E=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7445f32-3cad-4e52-d4eb-08debfc8226c
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 10:25:42.5931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uz1Qz+ZKUrAxxRVk5acB61Ggp+EF+L6eS0femlnyyZyqva2Zmf5uCXc4fy4wVfGC4TELsJ+3ITfcKBUkuxodgBMsi738mHD9h3VLqWaWKfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR06MB8775

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

