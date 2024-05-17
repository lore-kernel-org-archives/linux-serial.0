Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2136.outbound.protection.partner.outlook.cn [139.219.17.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6C7134A6;
	Fri, 17 May 2024 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715928587; cv=fail; b=dH3iHBm1cL9ng4UqGzGzaMGYmGzsH4b1u2RCepHXZUtK9Daj1C6LyBZV19BacFEwPJ7FClWNi3JKDNlCP3FsNUyIS0PhUXFNC5aMf5dd6tHqRsKVFlO3g2h2c+VSJd7M2NwcFamZwrLUlRnIHhEYHB9mAndh6/253x728ba9Vyw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715928587; c=relaxed/simple;
	bh=FBMXryltsDQ0E4UaqttoIfXugHGz4j9DOBZ1Q022AOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LRQmbDzpc3OI1rxi4Mc2uBGOCMJx9VHTRPq+WlBFRzz5thNgolXPvZPGVHCf7TVnT0hWzlwSlZlJ8CwwpSumY6h6RhvOCKf5R/UHjzoT6Co32ym5stFQy8IkfojCtnf0RcbL5ApxywDTbh+Q/qCDo9I4qsmjo8vdXhHkMBpnXCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NQZfegs6vJo4NrgvyG6dk9Uq5haFR4CsGyGrNvOTBIqYUkDajgHHE2W2u62L6RSNODB32/ieY+JOIX8GbGO6Rk9pyX4cLs5JzswWq8uZyGLGlwf6jFG4tJqmFGJR4Pm2w+ZhBlxM13DGWWwDQHkndhPI3lCFKupv+3h+DmM2OQreSJMdcia31ldQbNs9nMIG7qDal7atdFdZpJKDzJ3kZ8vKjXcWOv91zRa4BqimZI+ROJUHJNLn/BeoA1EFXKFzdzhPOsg2Kb9KC1AU5Qsbpf9ajGZUhLxVRgtrTF8PLDUFN0Msnncw3nj2BEowhz78gH10Cdz6mwdIJieMwyg51A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iywiVcK3AHiHK44mAq4wZFLNpsVPBgocKgFnFtTjkOc=;
 b=HxBNlyJVA1zRWOzm0F55O6Dogs0p1EyCR7+YffIOBHu8RopFM7ntUW0IV4y3c5WLiTyZg0MhRFYmxP3qfLd+UUmpQ0lV+DAvXswvf90w74SxmLy/KaN/Oey2t2bhjWSpUNlB8TBKT0GNr1KecuEK5N0orT8vQ/66Wmsj1rnVyQ7A9i7WxZIMKX11TgeUBzW6WU+xeVyDbD/oX2km4uzFez3IHj/mnN9EanJQdQl6X0cNjh2FNegH42FAffLuH/12JusO7yan5efEX9GIGez7uMFg3VK4sQo+FEKdJPNhF9Vg850+4ryoLhYC26ki5NorFCwUGtLTM2Q0shFq9OP8QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1164.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:12::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 17 May
 2024 06:17:23 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::5de:15b9:3114:4f45%5]) with mapi id 15.20.7472.044; Fri, 17 May 2024
 06:17:23 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] serial: 8250_dw: Use reset array API to get resets
Date: Fri, 17 May 2024 14:17:12 +0800
Message-ID: <20240517061713.95803-3-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240517061713.95803-1-hal.feng@starfivetech.com>
References: <20240517061713.95803-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0012.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::24) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1164:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf3d6f1-9d86-498f-0cf8-08dc763903e5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9qUhFl5xqH2hLvAOBqL3spReauj/x6dugwd+LoXJuSRgaKIJQu0aS4bFIKBBZUIch96FpOilQm7CHBFpordiRBei81EisMytXotJ/PCirrkht7J0es67xS1v6TZAd44+wn2HLFBhO7KOamTJaiMGhrnV/GypZWI3V88jCRYtlnCOKifCWWSlpTcIB/0cBRgDCfBeZzXn0s6loPeaxyHOgDcUWu7+hyN6qwcsnzyR9sgP4+AGVYchO1vj4r6FHhQuk2NNq2JLVr2Uv7H7U8TOYG3nhhJAVEbyk8qS07bJ/zljS3z80zG8DL6SE/bBikegdGyboTyBJVtDraW0Dh9ZnOfNvYTCperpN59kahb71jxCnLvG5h4IthqcVdP/03y/e/6XbZ6r21THDLaY7R4+Ix0hde/4Imw9IRUzHTh5O9sBQHLXXyPENVwQAAfLo4CIUnPZSlTrWG6nw7aOq5KnrBOhz4UkjIkJQgtUE3dZ55uTCBzzGIlHXhq2gefAFN3scNbQoasRZ1npwTycARXMzV94usaEWWekQ2zN+FN5Bf4sqCibIw/ykbOotvC4Qp22e596CKScujuktZVMxhoVU8jO36kxYxWSe4Xz4YWdpXfybDCKbBlXkKZlHZuGY4at9jMlYVFsk4UUwRQfOQZhOw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(41320700004)(52116005)(7416005)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WwynA1XeOwqYIQlk4bwdz115e9uH7mUg2pjUa04Lsui6HK1kxY1H9qcAV1ft?=
 =?us-ascii?Q?OtW/76xGKT28bYeDfB73+Zi3hHosXWabyw3LxUB1NGQm7y4DoumPXNhgTxb9?=
 =?us-ascii?Q?wxm1W23AtQJl1181CkB9nhZWzy69jCAO1U191BhfEYuiQHKJWmpvy3cKfxqE?=
 =?us-ascii?Q?Lfj3SyF1hq5sOrFYRVGdnnTeSb90MIbFcBpWfYp/gJvIi5987i3D6KDDTQmg?=
 =?us-ascii?Q?4PhBzVe280frsVg1+KiasOnAy4T5QHjI9j4qGfBLqBvbTLD2T935C7lGev27?=
 =?us-ascii?Q?aNsGmDbKnHWfvlInpklggBAG/tlvrkJlh5JsxhwXA+/fra/KKoCeV76HyPoh?=
 =?us-ascii?Q?i+r7S6dJXlt+fCVI1HsWe/snjzSfGAbvubwt963PUW47hMnH8HOQOAkB5BPF?=
 =?us-ascii?Q?asuFz3y1Ff7L0PYxwPCxz0E6b5dtFuTeCoekD66U5R765w4RL+TxNwh0t01b?=
 =?us-ascii?Q?oQSEOlhmxckodYkd0UD75sxOxe/VBVBMPsWHOX86SFVoUSgvvqOHgEw0aSgH?=
 =?us-ascii?Q?kh8aHZNq4iG/+yA3zC0PsfDID5yXP9BWcoF3BEcYZoEQF3E/03CUUFh7YDJi?=
 =?us-ascii?Q?m218A6qnn4Hd+mhVLT01g/WF1RbEcxURcIkkQ4cva9YvHh9a2y4+BwSC+OZB?=
 =?us-ascii?Q?LrTQiUr+tiIIPv7FSeTbjGDdm1CWO2U9al6zK3ayOUv0sjQWJzaDiPWEHxWx?=
 =?us-ascii?Q?BZwAJwVxa1zT7l8bzlvMCKT7JISbe5bmzs/vfa9l4+KrVSDcFq5h4kbxV0ko?=
 =?us-ascii?Q?8N+1Kux/kkpEjqdOfbJNqyr8RRJVj+ZS043D6BDTDZ+vCesl0LU7p39x+yyA?=
 =?us-ascii?Q?NM3bFm1vnRj3EcI5x50rYKZYinQhV0xmi3wL+19GUf1eKoHBm8lCvaSdIr8L?=
 =?us-ascii?Q?GNRXy8x+ZNveey2eD7MhDT1TvalRmxCSkelFxZ0660IdodB2aGtZ1oIlYeuO?=
 =?us-ascii?Q?svlb1bUFZBvLgBBU9qMVQ/h7Q7EEL5VCflW3HVJJiWANOyNjhMDKIUrpQeZP?=
 =?us-ascii?Q?eSnCrIk2+8nRvyznZDpP40WOEqd77vt+OzzBH5vmsRJDhoFpUcBB4r3T8jAu?=
 =?us-ascii?Q?zqv+KdiWBbmpkB9UzwvS779LBervQJg4R/QkxOJX13oxus8Chf00z6HSrudp?=
 =?us-ascii?Q?O0Lswb1C3qDJ373otdNZ0m9b3la7/Jp186cP7608rCttVEVX+e/1X19+AJJ9?=
 =?us-ascii?Q?vKUAN+G93EWz4LYH194ecVmP6Ut+6viECKqBIXZLOxS9vEvrTG0ffIOGKoWN?=
 =?us-ascii?Q?hErmjin4aN/dSnzDRdC+XsC6g8PFTauvEsDD0HGy5NlCQBuXyrvTvSW7Ba3v?=
 =?us-ascii?Q?ZivaHnS5Pwwk/QcCZYu89fciwb54CEKzsFu5v5Flb1A22PBVkrQg+FVTaGei?=
 =?us-ascii?Q?f/otKQ/hEisi6mnna60wIrdT5GC7mHpDJAE4Ii4yCtZ6RyfdirXqkGwoPTrW?=
 =?us-ascii?Q?6l06m7hUy4I41ZPPzgwO5Mbg2NLWzZ4xmHkt9MQCWsyxDa8/oPZFbYZCOuSH?=
 =?us-ascii?Q?m7F8SVhOkJv1YypidACZGrc52cL/Gq9lZbqxFQhmkBOl1KFOame26QoM8RxN?=
 =?us-ascii?Q?q219IcI6Dh2uBSnVrtoGv47Yw5tq2L91Zr8ivDxv6u4EIEMHvneL265YI34y?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf3d6f1-9d86-498f-0cf8-08dc763903e5
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 06:17:23.1810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e93wJEifSYCBgHX61X91B9oY0PIYUOWjuE5HCNBCu+G8V2CBLdklE4au8s01HCOxFKMFZf3jCpCgOMz/B3FIH1e0G/WHvT9RvYMzXz7JmfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1164

Some SoCs like StarFive JH7110 require two or more resets.
So change to use the reset array API to get resets.

Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/tty/serial/8250/8250_dw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 1300c92b8702..425a63b67f1d 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -597,7 +597,7 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (IS_ERR(data->pclk))
 		return PTR_ERR(data->pclk);
 
-	data->rst = devm_reset_control_get_optional_exclusive(dev, NULL);
+	data->rst = devm_reset_control_array_get_optional_exclusive(dev);
 	if (IS_ERR(data->rst))
 		return PTR_ERR(data->rst);
 
-- 
2.43.2

