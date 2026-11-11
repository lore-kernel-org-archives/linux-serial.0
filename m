Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.34
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794390657;
	b=Ti/ut/DZNKBTmfyXE7p5WTr8YztBm+V1VegnS4AK4ggqx0vCSLCbULlnKRDt28CAW5gH
	 +HLx2BxrA7nNdNLb+FfyeecNlRglXRy/1k/JKma1SaWaGi8/tVz3QfTIo4Bx7TJBywnxn
	 I0UXfDOABj07FWn2ncKSxrSwd1LjfjN9vzdkvmbyO5KEi5yLG3bqDpn+EVddsY6jzpdzm
	 4Rl+COHiGMNjhf2a+Ev27QnwmwaE4HU2N/IMtSwFcFsHNsf82mzr302BiW79mz+xpslso
	 sDPKyvk9UovpJLPy2Hj/c3gpug6pl0rDr+j6CU/gRzmUv70WaxbkIjI/EQ5ot8b951A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794390657;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=j7iZqE67eldTeECQ66TpmwgLBpF52JYzleGvG1epJ8A=;
	b=P9ArNXYXfeZqKf7Yv7v54y9cdBGkhv0s5RoA/4X9XXGsUu0EqyxApnm+kWWA299Dl6YL
	 1xp/SNu6KQsSHioNbAJZrfDnG4T5w97rY6eXE+O/5ZcMf74oqabmJnpK6UmV0UUvcNG+p
	 P9F5Hz0gQqCd8zSK/YFqQkZruKQq0S/LAUstcoHTGUwXc3w4gGhtgt5Xp6dwt+TMqPxZd
	 TgoqnzPEsAF/m61gCR/owLGz7VMuUyjWEZ6NA3LOcO1AHMyVqOTrk1DzkrleWkr9X3c/I
	 UUVLlSx0koEL3lKJ4h5mk6CIAeRK0fWAb9+uWvrVjle6X0MVPKShyawj9bzCXDCJXgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KYQJR4H6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.34
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010034.outbound.protection.outlook.com [52.101.84.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20FE606A31C;
	Wed, 11 Nov 2026 09:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D20FE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=KYQJR4H6
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1ltcDhN6GoBE46uzyqq2gBIo1x1P75ZWiTT/VD2MztICbK2lg9nHhsif051iF5gP4bR5fXvDqas1tpmBR2mxNViymHexxCZ3XyrwjOQoPve46AnfrerU1lXMlvIa+7XMtAJVYjmkrL+ghjl1Aozm4/8qUL1Z8yz6ky5UssK8baJZHp3TwozTScsGGDj6KthwEhH8HzbK/BU6DlIVMOpnDFVi1mJHpHr5iZ1CGp2k6Nx+DJOiGE0+wfBLiydYptYcYJ/M3R9etut2Q2e2cpMd0+3Seigyb88K72J/oWprfgDoB2LhuIaftVJ2diSVy1Xass8YvTiTv8R+nC44sMifw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7iZqE67eldTeECQ66TpmwgLBpF52JYzleGvG1epJ8A=;
 b=irZZ0MkoHPgQS8ggBTUxPdRVs7xtBkAkaSJbSksLMnmFbo2eFsw0jw60GndSmXz5hHbjuqW4J+GrD1nkby4tbYi2vH3+W3FlRHeY4+Zz9UPrQS5izJzI89M8QDL87ivlZLmPVEUHEVzFn80TH9XLZm4r7qtz0CpRHbard6D1gMlsYDHvaitz7vz/4Wl1kHNqzjZcsjlN9Z0gLVXmBgeMyCyYlWqXpfB1FNWa4ZgddAV00giEcjU5TuJVYuS1HWtHPrBXNGKGq28IihCWKPPZjolpMQd7g8sSHBxs7lK/ojSji1g7o4+ew22lZGCbB40purLzB13omcG9JwfEY+rI1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j7iZqE67eldTeECQ66TpmwgLBpF52JYzleGvG1epJ8A=;
 b=KYQJR4H6gcW8bcdeW5/X4fuNVuSExBCbku+GEHW9xfQQ8Cm53bthiZHit6lrisClELfHyEQv++uQiibJW39hn2hCKfWFHp1L8BMfYy9D/GjTTOGDnLPhAWO/xlnDFNrpotMctKY0e4DWkdoUMAB1ZqwOG1+FeaH0uAR06Dsz+keorQG/7JB8MNP4XLgbtXTy1OElr8cV7PunHk2Spo4PvZBPZWHSULQ6WfSgX7554EpCqOZsmxQofFtlsUXtyALFBPwZ6AL4H31k0nFUaqAbMF4OeWVEK8ymRzEsBtRsZh962fcYvbqm3PrwGJtWs1jKO1KNLoNCUYrXVqxIC9Mk7A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by WA4PR04MB000486.eurprd04.prod.outlook.com (2603:10a6:1d0:30::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:50:54 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%6]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 09:50:54 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Date: Wed, 11 Nov 2026 17:53:34 +0800
Subject: [PATCH] tty: serial: lpuart: Add port lock for registers read in
 lpuart32_set_termios()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-lpuart_port_lock-v1-1-5d332c51edfe@nxp.com>
X-B4-Tracking: v=1; b=H4sIAB479GoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDINDNKShNLCqJL8gHEjn5ydm6BoZp5impiUkmpoaJSkBtBUWpaZkVYCO
 jY2trAed7y2BiAAAA
X-Change-ID: 20261111-lpuart_port_lock-01f7deab451a
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Jingchang Lu <jingchang.lu@freescale.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 imx@lists.linux.dev, sherry.sun@nxp.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794390827; l=1964;
 i=sherry.sun@nxp.com; s=20260723; h=from:subject:message-id;
 bh=OqpwdwQRftdIYC+oWxGYN2zGiQKOOHHD+skIKbiGWjM=;
 b=RmSRWc8r37/VLQM2AxujrjQZ7rFspPhcFt3gjR3TpkevpDOYtvvXpRyV6t8myl68TLO5/rw+C
 9A+q2+1PeMwCznHrAqan1BcypiQu1UafpDxoEg6iOEdCpr1A0yVySBV
X-Developer-Key: i=sherry.sun@nxp.com; a=ed25519;
 pk=YnYnIFJ2l+5v951x9shBVfHhminNi+3LTfFa3PxSdnI=
X-ClientProxiedBy: SI2PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::21) To VI2PR04MB11276.eurprd04.prod.outlook.com
 (2603:10a6:800:296::7)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|WA4PR04MB000486:EE_
X-MS-Office365-Filtering-Correlation-Id: d90c06cf-3145-4b96-0b6a-08df3fd946a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|19092799006|10067099003|11063799006|56012099006|261022105027099003|261021121427099003|261026140227099003|261026121527099003|261028144727099003|261102123227099003|261009221227099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kNsr+lTurqTS+z3pp7VrdC8bF1sskIGytd8yLL5/faQE/0liOAryqCMiwEP5ltgRPTlCXG3LxHIOXLOlV26zFdLi03dZ3v34P0swbVALvdoo/Y5dVr2nLe1NAp2fUkdFebyRAHqv4MKscLAMNtrBeILxoz45HkcdJ2Hh1Dtvquo55HYZw+FKb0KZxss96v8zwXYp8+Yo203dopv2EModnO3mdeciJ/PovS7sqSSJ+kaFr6GQZD7S5a4+EWCl06WZDN46kz1ajZPLcNCnRn7wVq0OuEhw1eD/BCL4ZFPIoXDPveMsqy56UnGnIgKb33ZvVMlZSGqlqH1Oo7AuIakq5LiGAObtwNkyK33YR6KEv185bE1Lot1VvFzB+zDws2FkpyGGQ1jdK2CW+TnUnUZz3d6uxsZs5mMLW8yqSVy07wzy/u5PV1nIloq1pXwyWrTcWwoRgP60R0pmpjLyRKrIU4Yo5pLEd1Y0oXyjuk1oV7JCDkxwVRtWiml3otysxinwtdDgRpRbJ9M3+TRokk4PkzNomwfa7lJeyecPC9l/JWpbM6yKS5zdG15RoGcveEIU7Bs8Qj6V/NDWC2scaORlT7U6sKLOfuuweN1mijy/i3NKaKL3HvqJJNOmuySJOMX3rs8IM0+vii8u8EMQ3Ty83OnexDIT7UY3x3dEKR7/xm0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(19092799006)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261028144727099003)(261102123227099003)(261009221227099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlptSVl5MUJDRFhWZ3BrcFZIL3hqZ1NCdi9YUTkydm16YU1NMkMrRHBLeXB3?=
 =?utf-8?B?TVYwMmgxVi94Qy95aGtQZjBZcmU1NDFuK0pvTEUwTXhNdWRxN2FXME5PY2wz?=
 =?utf-8?B?SDFsanUzRzNDcUNVb3Z6eXFHbjJtblgvSElzVDFHajdEU2hZNTBHSVQrOGZ6?=
 =?utf-8?B?ZmY3TGw3aXBicmNWL2grWnJFTStudS9yZFNBQXE0bWtLUkttN3AxUlJkYWVq?=
 =?utf-8?B?d2g1MHY2ZHdoTEJvdG8zM0psMldTSkliWVF2cXBVK2FHZGhnYnBpYkRFMXhm?=
 =?utf-8?B?OXZqOU5uZWNKRWRBaEgyeldGNzNJOWw1K2NXSmFOOFowQVZmM1NmVVk0UEl0?=
 =?utf-8?B?Y0ZtcXAyUzhwUU5qLzhwMVpEUlE3TXpBR0lFY1JYd2NKeWg0KzB1MitucUMz?=
 =?utf-8?B?SXc4bkZNbkZQYTlVT3FVbUQxZ1F5SFlvWVRrRUl0SVJpdEhWRG9sRUF2NXBs?=
 =?utf-8?B?ODM5Ujd6SC9pZEN2cVVjUjF3RDZjdXUzNkdwTmhyTmQ2RHJtTEdaVDAxeFY2?=
 =?utf-8?B?OUJTdHl5VCtJQzhUTDdmS3B4cjFNTGs3dW9PNmxJNWMxdWFuZzI5L0RsTGp5?=
 =?utf-8?B?ZlBJVlNXc3Z5T2Fib1NzSm5tcUt0U0t5V2Z6TnladVZNV05rRGxHYXUvR2JZ?=
 =?utf-8?B?bDhsL2NCaldJSThUWUpsMHErUERjT3RQbXNPdnJka0trMzIyQ3ZpV0xUTGhl?=
 =?utf-8?B?ME1VNTFXRjlRUlp4Wm1kL0orQmJrL2o2ME1lREJOZTR3dEpDbDhhdmVoTEhv?=
 =?utf-8?B?M05oa2lmWFdMTlJteEozSWlOWGVxbFh5V1dveUo1YXByZ1ZYT0YvUjB6TTVQ?=
 =?utf-8?B?T2YySG9IS1Z5WjVMK1N2MTJqMzRIdkltd3lOTUV2VWdPWW9xUVNGekw3ckNU?=
 =?utf-8?B?Yms2bCtaSFV4cWJ4NWxUWGJTNHRDMmNneEx6cTh2YWd6aGl3dUhiTTQxeW8y?=
 =?utf-8?B?dkpDcS9RVDFvTVVFTXRqVnlDSjJjMDEySVVGdFZwRVMxVTF4cVBlRS9NYThV?=
 =?utf-8?B?eGlSZ1l0SzJ6TU11Y29IRHFFQmYwS0V2SmVLbjFqKzB1RVo4SWxWWGdNek0y?=
 =?utf-8?B?RTY3c1lpZlBMeWxnQi9QM2tVY2Q4YTNOd3RZRDVoTkhSZHhxejc1TUw0N2FY?=
 =?utf-8?B?NEFuOElRK1VIY1pTbVgwRjJWKzRicDE0R1Yya3FGcHQ4MkpORm8rd2FyMThM?=
 =?utf-8?B?MGV5aWpRSW1kU2NXN0l6eWk0UFNNdzJDc2JMOG43dS8wKy9xdlVWRlhndUlx?=
 =?utf-8?B?L0R5RmUyZWZMK3Q0MjBhMHJCNnBvZEEwL25jNkV2cDVjL2VTU0YxUWxyLzBS?=
 =?utf-8?B?OTRhS0NBZHNjVzJsT2dTcjRrVk10RFpucGZ2NDZvTVFJT1puaXZMa2xPZXVU?=
 =?utf-8?B?WkdoMXBVNW4wTm5OaHEwZm9TTHkyc1VlbXBESEVDWGs4Ny8vQXQrR2Zsckpl?=
 =?utf-8?B?RWpZZE1pZWV2TDl6dUtHUXRUeVZoeEFYYUowNDhNODVKSk5vbkYrUW02VlJI?=
 =?utf-8?B?VWtMLzFTRHIwQm1RSmpvY2hUL29DSkJkQUk0bzRTaEhKQ21IYTRZVWcwWS8z?=
 =?utf-8?B?ZGdyQmlzam96VUdRKzV6RVR1b2RsK2Z4NHVWSndmK2RvVTNnS2MxQlp2azI2?=
 =?utf-8?B?RGZHTWpJc2hlV05FMXpwdElmQ05uWFd4cXl5V0owMGU4Z3F1TkVQSHZ4VEpI?=
 =?utf-8?B?Y0U3OG1mWVhQTmx6dHRqWnZBSWhITTRDTTJzSlF3ZjcwNDAzc1ZoM0N5ZHRt?=
 =?utf-8?B?TjljVm1RYVExWlo5OVpYQjFvRWdkZDNucGw2cnZBYjJ6T0dTenN2YXdCdHl0?=
 =?utf-8?B?QkpkVGluUStHdmNCblhLMjJoYUJUdDlCeERLVGhSOTZ6RHpDOWVjc1VIUXI3?=
 =?utf-8?B?clZmWHk3ZW5uT2ZYYTBMMFl0azkvNEYyMTFVajdoWnJmUXozUmFIYmptUzFK?=
 =?utf-8?B?SWJHbjZid2F1TXZRSW9BWVdZdXUxeWx5ZHVZTUhPY0tvRHlsL1h6b1F6RVpn?=
 =?utf-8?B?L2RJMHhoU1FoSytkWGltbWlnYTRKUzNTdmN0dFBPYmNVQ1JNcVYyK3hUcXpS?=
 =?utf-8?B?SHBiYVBhSjlEK0themhkL0xQTzFqRTh4ekp6ems3cUtsMzdEOHBwOUYyeDhV?=
 =?utf-8?B?QnU0SDVrY1JqSHJmV2lGNUFrMCtQekR2bTlUVHMyV3JZVXBPTG5sUGVxbllx?=
 =?utf-8?B?OTRsUlFxL2VzdEtMMU1yb3pEaUpsS1lYOHYzaGlmaUNzalJpcFR4WXZGdVdS?=
 =?utf-8?B?NHFkc3BFWFgwZXROYzBabGRCbzcybFhQZ1A1R1RaUDNTMFBCaHJHTHBQK3c3?=
 =?utf-8?B?NlBuOXk5L3I0ODFQR1U0bVY3U0ZiUGhoWGxQdWYyekdBRk1ZbUR3WUtrVy9s?=
 =?utf-8?Q?yfc2aNm+6ZQYpOtMi6jbkQVl5XItDiaER/2jf?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d90c06cf-3145-4b96-0b6a-08df3fd946a0
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:50:53.9037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwoQK0vV08M0dUez2vSMjbamPDxfEGAM85SG9zKdsq53Q4jznw1aFLJquE1XF9T1MAzDJJrz1s5N7ad2l8KMYJtBRu4QB9047j0QQQmTJj+GH/1DKDa5mLXMxzq1j6tT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA4PR04MB000486

From: Sherry Sun <sherry.sun@nxp.com>

lpuart32_set_termios() reads UARTCTRL at function entry without holding
the port lock. lpuart32_console_write() can run concurrently on another
CPU and temporarily clears the RIE (Receiver Interrupt Enable) bit while
it polls characters out. If the unlocked read in set_termios lands inside
that window, the stale snapshot is written back, permanently clearing
RIE. Once lost, no normal code path re-enables them, so the UART stops
receiving characters and becomes unresponsive.

Add port lock for the registers read in lpuart32_set_termios() to avoid
the unlocked snapshot captured.

Please note that this only fix the normal printk path, in the
oops_in_progress path of lpuart32_console_write(), when trylock fails,
RIE is cleared and old_cr restored without the port lock held, there is
still a risk of stale snapshot, but it's acceptable for the post-oops
state and the trylock-fail window.

Fixes: 380c966c093e ("tty: serial: fsl_lpuart: add 32-bit register interface support")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index cd2575a3aef7..7c249b9371ae 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2241,9 +2241,11 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned int  baud;
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
 
+	uart_port_lock_irqsave(port, &flags);
 	ctrl = old_ctrl = lpuart32_read(port, UARTCTRL);
 	bd = lpuart32_read(port, UARTBAUD);
 	modem = lpuart32_read(port, UARTMODIR);
+	uart_port_unlock_irqrestore(port, flags);
 	sport->is_cs7 = false;
 	/*
 	 * only support CS8 and CS7

---
base-commit: 793807ca13bf3072fc6d16ce6d90e9ab9beff2a5
change-id: 20261111-lpuart_port_lock-01f7deab451a

Best regards,
-- 
Sherry Sun <sherry.sun@nxp.com>

