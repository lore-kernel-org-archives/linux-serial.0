Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021074.outbound.protection.outlook.com [40.107.130.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7FA481AA5;
	Mon,  5 Oct 2026 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206431; cv=fail; b=K4NmIoWA8nhg34rer4ezdCsMTqT/rtWH3Vs/5wuyehQwYGc/79IGpdy9LITqk8InOfJQ5MSXLRv1qJuh3TmONwMEiD7DwfNYx5ndeaLmNMczox3os2khc8yJ7apZQz8rJkhxP5eint0od6jauDG76vmC4oEf5Ep2YRW6xkcXdyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206431; c=relaxed/simple;
	bh=RHqD7p4OYhVlQ2581VGzI150BSdxaeiquLJ7sJSdBV4=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=VUJbuVPxmr4weFmW+xtyhfUPH+fwPzfI08PcfaIH5LX9dNcfmQjC9LygQddKUb2/x+wBq3QZLh/spJKAgT+2zKO1en0PaAA7t+9zG8CW15PhbMwsKlc54ht7b46bM7WaABQwJJ2OUyc1aMd+TtFvwe77miMQ5QWkbDhxeFIIAw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=XwgRDLK8; arc=fail smtp.client-ip=40.107.130.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="XwgRDLK8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WBjysSfMpRTTiuYUXtzzTbFWulFouDU30HbROCL4v+5D2/6Xuu7JeP++mrazClg5vVYj6oaYoFlAnCLM2duEi5EkP5fgC9+EqVz6sMKflA8GhNOzyuzeLEBbe7q2lIrSPHGt6pwN3E5vLLq0NcdDyHpE+6qSkwFQlmfTyQBLcyMhxjPM83YjU7Y1EbLzAqpMMW2rJDltKVGip9wC+LtjJhsErTbQMXdqM69E1CYW3hEoFo9eaVtZQeR6VAmmoGsmtOpFbN3cxMMkTJPA5UnY/4dXMC84DcHhGfs54O3tQ8xjR3elthD6PEvCSxMF3VHnxRZkaDg6ZTIXWuHXOvZ3dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpcTDMebs86Je6HljFBg564z9qSHGOyCywebogFWhZs=;
 b=Of5ybRlgcsDGrb+nBjqmt9jilM7KHdFz3HCxbOwFmLZZsAyctJWsWF/FN+fBHku1wgPKf7jdYVGoaR3AWxS1EfFNOrlr4TqTDpJ6ULecX43FrxKoofOWjENW5K6C/dLscqoCIY7dSVfly2AvHBDz1Io/M3pfU8JSTK9LwXlKECCAYO/3yEEwsCNONSttEwUqEaAdPWj65aLR6Mk1VpGAejoP4P2G8g+D+l2aCH/H6q1KjxHVBpdDj8Wn2JHzgscgKJCtyHcllZ9Qosd3SAY7enEiEkCfw8rcEJUmVLYUmAzokWqldpJOCRraDFl97aMTHuWOqiaM4MiYxyjJPlgdig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpcTDMebs86Je6HljFBg564z9qSHGOyCywebogFWhZs=;
 b=XwgRDLK8MjLUXYw9/570ktn0d3RdytNPj/MQWiTaXAO2pu3ecsd7FFLGekFsJHx0OEUPu6M9KLdF4BpUhvnZvkzDjsu+v1q9oYUz8DLLdKtYhGjyTT3vBLTqhdxKn/zVNiw7B8h/2G6zmIcN+10w3w1g/yLVJGi7W71KoACHbi+7wtCRRxekcjuGkV5EPen1JAPaRdOlOeEAupHa0EhTft4qDvHsCOmTjIGGv/O0eoaV5qkyW03s/CSbz14rmNR3ziv72M0SQDVTJjsdkQwdQ1fe7afoe+jyvLUJ4nCDUkRB3MaAPrcIvCAvprO0Y79rmmme52TMuIvg8FjKp95RIA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by DU4PR06MB10187.eurprd06.prod.outlook.com (2603:10a6:10:622::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 13:19:55 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 13:19:55 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Subject: [PATCH v7 0/9] (no cover subject)
Date: Mon, 05 Oct 2026 13:19:31 +0000
Message-Id: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOSjw2oC/3XQTWrDMBAF4KsErasyo9FvV71H6WJiyY0giYNVX
 Ifgu1dJoUlxhVZPMJ+e5iJKGnMq4mVzEWOacsnDsQb3tBHdjo8fSeZYs1CgLBgkeeCZEGY5Fu2
 NLF8ypj2fJRPY6DxFo4Kow6cx9Xm+wW/vNe9y+RzG8+2dCa+3P6SD0CInlCi10dwhbAM5fp04F
 97zczccxBWd1B3yiE1IVSiRVp4UGOfDGqI7FNA0IaqQiwpY17M1ag3pR8g2IV2hWL9kg669un4
 NmQdItXdkJEhO2nLPxlP/TyP7CyGAbkK2QsSQeqQUQ6K/0LIs3z2UyiUrAgAA
X-Change-ID: 20260513-max310x-rs485-sw-delay-a306d783d529
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206394; l=12707;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=RHqD7p4OYhVlQ2581VGzI150BSdxaeiquLJ7sJSdBV4=;
 b=Oh4Y3O8Nelia1WX1ue2yGGdG3axxfxd96gn9NKP71DvoHsLykRR4ld8b7z0n+rq8bIF4JsjVb
 zgsvadqKyvKD7uIskgQYLTNFDyVIh9hCAxM2oKXzZzqxpTnZ6MEocJA
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3P280CA0101.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::16) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|DU4PR06MB10187:EE_
X-MS-Office365-Filtering-Correlation-Id: b3ae5fe8-aeac-489e-cee4-08df22e35890
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|52116014|18002099003|38350700014|6133799003|10067099003|3023799007|260925022911599003|260925021311599003|260925021911599003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	GrVPg/6qPZyZ2d+zGBSwXW1DQqpEoOQNRX+x5ywIXlLI89kVkUScr/707Meh/6jo1tNpY6+lxwskU7Cy0SLI0blT84MEIdK3QavDpx2AARxRsavDta0D3WHCW/HmTMYr23hlP9I88xCM1RJWA8MJkvdNcABNq7g+A56ctG5ItAak8zptUOiMi689r/A4jmn+/6Q3r7B09R9wpUx7WqekmulGYsrYivCfp46F9o8vu3eOzmvT2VcYhTPdy3ZwUnmgmBbLGFYQKsUNHeIRrD4Dka9t231ruGkTB/NXKGL54az6tG0Y14y3YxsGxV63VBqlXNHFwdOZ+I9TDiSGefBdO4LdVMgE9pIfBrKGGDFoOXxwbFF+HnaYUTYYzGABnImjWX2sJfEYuIfb9ulOFYm6laYxjrfYn162VnyslEh1TikHymTImKJNKWJTWucC3nfEMNZr4U3ksMu1ia2ebGehA7xeKiOGwTLwwqhlunlOhI5YMDrNAcgTSLsg1KlY5yGiSnr1tOA8X0b7kIBqSDzZNvFMe5257SHYyY1psw8/yGD02xXq2RvlUwrRA4IJCtTp1t5uEt7yqlICX+LEsbyXGBqTVTXPQh8aJQkYqJ5Mu4oI/jEIETaeuBgAWj+FHhN3RGGOgfNvvIpXYnP/J7948MPeXY1kcZtDF4RQjhrFcnYpgaA/o3gTM4PsFCSuHFQv2wiPj+d/3z+EC8uRJsGlhL/w/fA7Ng9LYEAt2MoPqYM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(52116014)(18002099003)(38350700014)(6133799003)(10067099003)(3023799007)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ME9pTjJiR2h5Y3BUUnRodDVoWUZIRGxrOWFRZ2VxOTFuWi9HVHI1K1lkZFVC?=
 =?utf-8?B?NzlOd2pzbzRxSmh0dnNNRFlWTkI4bitBM2RwVDdRcGpuUVBmTWwvREd0cG5W?=
 =?utf-8?B?VHVydTRUTFIrTEFWSTVqckVyK2J0S254V213ZGJOTEMySVprNjRZWkZucXM0?=
 =?utf-8?B?WHBXdnhNdEp2dUFwKy9yVHVyN0V2VDJDVXpENWprQTZYVzEvbWpkWGhnNHZk?=
 =?utf-8?B?WlJjbGJNQzdsK1RYZThObnQ3TE1wVC94M2M0dkFQeGF3SU54UWYxQ2dIdWRD?=
 =?utf-8?B?OS96ckdpRVZDREhDcVR0YVB3SHNrSDJMU0VoMlozZkY3Rnd4ZFBWeE9FOFlB?=
 =?utf-8?B?S2JlN0cxRFhTQlRJUnU4ekJTOXMwU0pMdUw5a25za2pMM3RMTGh1OWxvRHhm?=
 =?utf-8?B?UGVVMmM1dG9sOXJHMU8vQ21zTzN3c0FRQUNIcHh2T0FoZjVaS0hEdHNrUm9N?=
 =?utf-8?B?aGI3MlFHN25xeElzNkRVTW9WMVlqM1IvaXpqT3orQkFnK0dKNnNYVFNneit0?=
 =?utf-8?B?cW40SVZxYVE3MUZJUFNnaXN5dEtDZWZWTGtKRHR2djcwTHFCdVhCVi8xc2Rv?=
 =?utf-8?B?S1EvM2NFM3NQS3hOOHpZUTcrcDNSUnJsb3dvQnBUaER0Y1VNcXhoV0NxbW5I?=
 =?utf-8?B?bkczTmtBSzUxTy82S04ySFRYbmtaM3N0MDNIcEJQUjAyNXpmQlZrRnVNdkVw?=
 =?utf-8?B?Y2FyQnVEYllpMmlFeVpVL1FBeEpYeC9KQWZtalNtUS93eUtmRFh3aXdoWkQy?=
 =?utf-8?B?RzcyK0NPdjNHTS9oY0VLUlRPRGdXaURlMnAwTWdLbkd4RHpnODdyRTY5ZWg3?=
 =?utf-8?B?ZTA3N0pacUtSWlhvRzViV0hud2ppekh6L1NXeFFFYzNLcWxZTzJyNHl2K0c0?=
 =?utf-8?B?Wko2QWlhdlI1Q21pMllmZkhibjNUMllEVEtLSzV5SmVQbERtNTU3OHJpMGV2?=
 =?utf-8?B?Rm9LZzNoVGJmY0xSMTZmYkZzb1VXcmVoRHNZdWZma3RQazVlZzJFc004NEpl?=
 =?utf-8?B?VFgwSlRwU1ltQXJONXFheU9iekt3dWowM01iU3VNY0lpUjkvSTBjait0dFFo?=
 =?utf-8?B?bzAzR0pubTg3TTgyb043ZE1BdnJaNDl0R3VmaG1oSTdJcUYweTRibVJvRUZz?=
 =?utf-8?B?THc4bkVLZVB5ZzdxbHJDQk1UdFQxZG1UcG50NDMxbEVXWGk5UGRFWnRoMEhN?=
 =?utf-8?B?VW83M3hWOHBDKzFYbjhyd2FPS04xZitiTy9YTFdWUnpQTktPczljMWwzV3hj?=
 =?utf-8?B?b2grTGVKSW9Oa1N0azMwOVhWOUp2UG9TaktqUElibWdQM2NiaHRZNzhUVENX?=
 =?utf-8?B?aUdxR0ZuamY4RkptK1Rwa0dHOUFRbHgvMTNEbUJPd2JXQVpXNGt5SHF6QU9L?=
 =?utf-8?B?YlphVHVqTVZLL2pVdWVmbmFzM1A1WktrazZBaWlncTZPOUtDVXVnQXFRcDk0?=
 =?utf-8?B?UXlIb2I4TFJVdlBJNGI0T3ZGUVJJUmdCSmxqQ3ZWWWVlRlF2SWF0Wld4QUFt?=
 =?utf-8?B?WGZ3SmRvOVRia0FFb1ZpSW1LWVRMT0hYSVB5OXUwZmREeXczS0pvLzZPYzJF?=
 =?utf-8?B?cjlNd2xLdTFOdDNEZEVudXNOYU5DeThlK2NHVE9JSnR2Ty9sK3NadnpQSEZN?=
 =?utf-8?B?UWllM1lwcHpSWVd0VmptODFoWFFPN0lxZ1Z5Tkl2R1NoWENvdTd5ZGdwSnRI?=
 =?utf-8?B?YS9WYk1pUCtHa09rWjVsM0h2WnJuNFppS0t5b2twVjJ0WlVFT04yN3NzZDRM?=
 =?utf-8?B?SFNaNUZub2ZBZElKSThUZ2Z0WEpvTktlR0p1bnF0TlBqZGRIL05kSzZiWTVB?=
 =?utf-8?B?eHVsWnhCMnpRVUdWaWRYSXlWQWM5NStMd3pjVlAxWWxSeVZkdXNDTU5kSjU5?=
 =?utf-8?B?VFp3MTZYQWl6ZU5kU1BBM1ZReG9Na3pFd0xkUVFiYWFZZDJ2U09FeGJHcFZn?=
 =?utf-8?B?bTU2bkI1dW1XZGNMMVNpSFUzRG5ibTlyS1BGYjErSWROZnEzV05FUENSWGI0?=
 =?utf-8?B?T3RpTTBjS0t5YmUrUWVIZ1hxRUJybk1HdnJLellzWDNaZlJmUGpjZkJ5ZFgr?=
 =?utf-8?B?amZVN0VlUnIzVS9Yek9FQ2xDR2JicklvQUw3cEZNVTZoQmg4ZTRqU1UyV1hl?=
 =?utf-8?B?YzFzQVd2L0dGUHQvd2o1Y2pXRkQ4bXk4cENsTExxczRFM1Y3eWlvOXdCN01U?=
 =?utf-8?B?ZmdBVmg1MG5VbUJWSEhMZHBMYk13QUFHUDd6Rm1LdDlZVGJ2QlArZGRMREFj?=
 =?utf-8?B?MzNUWEVwbjBGL3l1UllwbXdEZTJKanFETW93QXdyUHVXZjFSWWdoNCs4Q3Zm?=
 =?utf-8?B?ZTFTazNLSy91WkkxQkhxM0dmSkJRalhQSWhPUmZwdkdBVnl1MUpSd3NqZUNU?=
 =?utf-8?Q?r091tJYWg3bC9/lE=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ae5fe8-aeac-489e-cee4-08df22e35890
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 13:19:54.9953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q3ZdbzdjPKKqnHXf55f7cxh8evTzQXDpHaheDMWipRiqt3cYh+MvK8YgkYrhj0nIX78wfip1z8IF+ak6JL1fk6NQOBE0LZRPav3LZVbdCLg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10187

Changes in v7:
- patch 5 reworked: instead of draining the FIFO at line rate - up to
  fifosize+1 character times of uninterruptible sleep per close(),
  pointed out by the v6 review bot, and unbounded with CTS flow
  control holding the FIFO - shutdown() now stops the transmitter
  (MODE1 TxDisabl): the character in flight completes, abandoned data
  is discarded, and the auto-RTS release is given the configured hold
  plus one bit time before power-off. close() is bounded by about one
  character plus the hold, independent of queued data. This also
  fixes a bug the drain still had: a truncating close() on the
  auto-RTS path powered down mid-transmission and froze the
  transceiver asserted on the bus until the next open (reproduced 9/9
  on the wire: 0.6-2.4 s of stuck DE plus a corrupt character at
  reopen), since the drain bound could expire with data left
- patch 8: shutdown() gates first - teardown interlock and interrupt
  mask before any wait - and the envelope wait honours only the
  after-send hold plus two character times; the final RTS release
  settle is tightened from one character to one bit time (the
  measured pin propagation is one tick of the 16x oversampling clock)
- patch 8: a write landing while the envelope is in its send phase no
  longer rewinds it to the before-send phase, which inserted a
  spurious setup delay mid-stream; the teardown interlock now also
  fences the in-flight transfer adoption, so a reconfigure racing a
  teardown cannot re-arm the cancelled delay timer; and an RS485
  disable flushes a queued RTS worker that could re-assert the pin
  after the settle (v6 review bot)
- patch 9: the deferred-TX release in the rs485 worker takes the port
  lock through uart_port_lock_irqsave() instead of a raw spinlock
  guard, which start_tx()'s lock drop/retake would unbalance against
  the nbcon console handling (v6 review bot)
- patch 9: a write deferred by the reconfigure gate is restarted as
  a fresh envelope: the reconfigure helper's transfer adoption
  otherwise claims it and the restart pumps it in the send phase,
  skipping the configured before-send delay (0.3 ms on the wire where
  20 ms was configured; caught by the v7 regression run)
- the shutdown rework was re-verified on the wire: the regression
  matrix plus close/hangup/SIGKILL truncation scenarios on both RTS
  paths and both polarities, at the baud extremes
- Link to v6: https://lore.kernel.org/r/20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com

serial: max310x: RS485 delay and RTS fixes, software-timed delays

The MAX310X hardware can express at most 15 bit-times of RS485 RTS
setup/hold delay, while struct serial_rs485 expresses the delays in
milliseconds. The driver rejected anything above 0x0f with -ERANGE,
upon which uart_rs485_config() wipes port->rs485 and silently disables
RS485 - a device tree asking for a 20 ms setup delay boots with RS485
off and an unusable bus. The values that were accepted got written
into HDPIXDELAY unconverted, milliseconds as bit-times.

Patches 1-5 fix pre-existing bugs found on the way: a termios write
clobbering an active break; breaks never reaching the wire on RS485
ports because auto-RTS only drives the transceiver for FIFO data; the
milliseconds-as-bit-times unit bug (patch 3 first centralizes the
transceiver register programming with no functional change, patch 4
then converts the units); and close() powering the port down
mid-transmission, truncating the final character and, on the auto-RTS
path, leaving the transceiver asserted on the bus until the next
open. Patch 6
adds active-low RTS on the hardware path via IRDA.RTSINVERT. Patch 7
is preparation, and patch 8 adds the software-timed RTS path that
takes over whenever the hardware cannot represent the requested
timing, clamping the delays to the UART core's maximum instead of
rejecting them. Patch 9 fixes a reconfigure-versus-write race the
asynchronous rs485 config application has had since 2016, which the
software path would have made worse.

v4 was all of this in a single patch; Greg asked for it to be broken
up into one change at a time [1]. Splitting it meant re-verifying each
patch in isolation on hardware, and that re-verification found two
bugs v4 contained: a set_termios() or TIOCSRS485 during an active
break released the transceiver mid-break while the break bookkeeping
still looked correct (prevented by the tx_break ownership guard in
patches 2 and 3), and the patch-9 race, where a TIOCSRS485 followed
immediately by a write could put an entire transfer on the wire with
the transceiver released.

Tested on a MAX14830 (SPI, i.MX6SX) driving RS485 transceivers: for
each patch the bug it fixes was first reproduced on the wire with a
logic analyzer against the kernel one patch earlier, then shown fixed.
The complete series additionally passed an automated regression
matrix, grown during the v5/v6 review rounds to more than 40
scenarios: both RTS paths, both polarities, RS485/RS232 mode
round-trips, close/hangup/SIGKILL landing in every envelope phase,
output stop and flush mid-burst, mid-transfer path switches in both
directions, XON/XOFF injection at idle and mid-burst, and termios/
TIOCSRS485 disturbances landing in every envelope phase (setup, data,
hold, break) - each scenario checked both on the wire and against the
driver's reported state.

Changes in v6:
- every patch now carries the Assisted-by tag, which v5 omitted [2]
- patch 1: the LCR clobber is now described as "overwrites the whole
  LCR register" in the message and as a whole-register write in the
  comments (Hugo)
- the character-time caching and the shutdown drain-wait comments now
  state their reasons in place: both values must be current before
  the RS485 helper runs, and the tty layer's wait-until-sent is
  bounded by closing_wait and absent on hangup (Hugo)
- the old patch 3 is split in two: patch 3 only introduces
  max310x_set_rts_ctl_params() and folds the three copies of the
  HDPIXDELAY/MODE1 programming into it, patch 4 then only adds the
  millisecond-to-bit-time conversion (Hugo); break_ctl() keeps a
  single max310x_rts_ctl() call at the end instead of duplicating it
  in both branches (Hugo)
- one_char_duration_us is renamed to char_time_us and the shutdown
  drain bounds to tries (Hugo)
- fix: disabling RS485 during an active break left the transceiver
  driving the bus indefinitely - break-off only ran its restore while
  RS485 was still enabled. Only the break assertion is now gated on
  RS485 being enabled; the break-off restore always runs and derives
  the register state from the current configuration (patch 2)
- fix: a reconfigure that moves the port off the hardware RTS path
  while a transmission is still in flight - a termios change or
  TIOCSRS485 pushing a delay above what the hardware can time at the
  new rate - released the transceiver mid-transfer, and the rest of
  the data was shifted out with the bus undriven, with no error
  reported. The helper now takes such a transfer over: it enters the
  software envelope and keeps RTS driven across the handover, and the
  normal drain path arms the after-send hold (patch 8)
- fix: a break that begins while the previous envelope's after-send
  hold is still armed - TIOCSBRK waits for the output to drain, which
  lands it exactly there - was cut short when the hold expired and
  released the transceiver mid-break. The RTS worker now derives the
  line state from break ownership as well, so the expiry re-asserts
  instead of releasing (patch 8)
- fix: an XON/XOFF character deferred by the reconfigure-pending gate
  was never transmitted when nothing else was queued, and the re-check
  after start_tx()'s dropped lock did not cover a freshly posted
  reconfigure (patch 9)
- fix: a delay of exactly 15 bit-times - the largest the chip can
  time - was routed to the software path, because the hardware
  ceiling was computed in nanoseconds from the truncated per-bit
  time (49999995 ns where 50 ms at 300 baud needs 50000000). The
  selection now converts to bit-times first and compares against the
  field maximum, which is exact at every baud rate (patch 8)
- fix: a close() racing the after-send hold expiry could leave the
  transceiver driving the bus: shutdown's manual RTS release reaches
  the register, but the RTS output stage is clocked by the UART
  channel clock that the power-off stops - stopped too soon, the pin
  stays asserted until the next open (register confirmed released,
  pin confirmed high, in every observed case). shutdown() now gives
  the release one character time, at least 100 us, before powering
  down; measured propagation is below 50 us at 1200 baud, and the
  delay-free alternative (handing the pin to the auto-RTS engine) was
  tried and rejected on the wire - for an active-low RTS every
  register ordering of that handover drives the pin to the asserted
  level mid-sequence (patch 8)
- fix: a reconfigure moving the port onto the hardware path
  mid-envelope stranded the software envelope state: nothing reset it
  in that direction, and the TX-empty hold arming ran only on the
  software path. A later reconfigure off the hardware path trusted
  the stale state, skipped the in-flight-transfer adoption, and
  released the transceiver under the running transfer. The TX-empty
  unwind now runs on both paths, the reconfigure asserts RTS for any
  transfer it believes exists before auto-RTS is disabled, and the
  hold arms only once no transmittable data remains (patch 8)
- the seven fixes above came out of further review and hardware
  testing of v5: each was first demonstrated on the wire, then shown
  fixed, and the full regression matrix was re-run on the result
- Link to v5: https://lore.kernel.org/r/20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com

Changes in v5, beyond the split:
- teardown interlock (tx_teardown): shutdown() and the rs485-disable
  path set it under port->lock, and start_tx() checks it on entry and
  again after retaking the dropped lock, so a racing write can no
  longer re-arm the delay timer or queue RTS work against a port being
  torn down (addresses the remaining review-bot findings on v4)
- shutdown() also cancels tx_work, previously only cancelled in
  remove()
- the per-character duration is stored as unsigned int microseconds
  instead of ktime_t: single-copy atomic on 32-bit, so a torn read of
  the 64-bit value is gone by construction
- the TXEMPTY handling documents that the interrupt latches on the
  FIFO becoming empty, so a stale interrupt cannot pump data during an
  RTS setup delay
- new in v5: the tx_break ownership guard (patches 2/3) and the
  reconfigure-pending gate (patch 9), both found during the per-patch
  hardware re-testing described above
- also new in v5, from a review pass over the split series: startup()
  clears a latched break (nothing clears TXBREAK when a port is closed
  with a break still asserted - 8250 does the same); a reconfigure
  arriving during a break is now deferred and applied at break-end
  instead of partially dropped; the rs485-config worker runs under
  port->mutex so its break-guarded register writes cannot straddle a
  break edge; the termios-path idle settle re-checks tx_state after
  writing and requeues rts_work if an envelope started meanwhile; and
  the hardware-delay ceiling is computed in u64

[1] https://lore.kernel.org/all/2026092326-truth-unweave-c773@gregkh/
[2] https://lore.kernel.org/all/2026100116-saint-idealize-32cf@gregkh/

---
Tapio Reijonen (9):
      serial: max310x: don't clobber the TX break bit in set_termios
      serial: max310x: assert the transceiver during a break
      serial: max310x: centralize the RS485 transceiver programming
      serial: max310x: convert RS485 delays from milliseconds to bit-times
      serial: max310x: stop the transmitter before powering down in shutdown
      serial: max310x: support active-low RTS on the hardware path
      serial: max310x: schedule tx_work directly from the IRQ handler
      serial: max310x: drive RTS in software when hardware delays are too short
      serial: max310x: don't transmit while an RS485 reconfigure is pending

 drivers/tty/serial/max310x.c | 632 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 595 insertions(+), 37 deletions(-)
---
base-commit: 9505146e885b1a842118aa6410f737290c4a5a32
change-id: 20260513-max310x-rs485-sw-delay-a306d783d529

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

