Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.59
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794453443;
	b=2IdlgUGgKy/vLK8yJNvpSNDOeF6tmCQhrWmsZuQq91Q1/tqgNY0n1ZR1DHhhduUtwhiI
	 9o34ilD7GQVl8LnwCua/SIqq9POv9ti69Oq4EMdvQm+KdenU2M4SmeSZ0zxziDvi5aOIg
	 gmjOPZ3/nc66spDFNNxqm0wtCwEvNcwrd6UuPR//9jAIGZfDInfLpzTP9mjwfNIXEhOxf
	 zo35aM+nYq4RFaU560H3f59pYRsfCtZ3MiaiHgBZaiG9mqL9tIEMXS3/Sa2jSvoUvqiUm
	 gAXQeyZB7zaWSyNDxRbn4FSK8sBIYzm95CVLVIZOHv0MQpN5FTyMRhJrgYVLi963IcQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453443;
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
	bh=EztPb+1f6Yc04EkRk5SnwdoKZdrOQRadr4l9D1pWDx0=;
	b=rXkyK1vOMISLzNbQxpeE7fmoxWEmxcRK5XZr/F3louzuyGI8k8JmF1oLQNu9V+NJzT1m
	 Ww3UcyefdFpdW8bGKmpHhn8l1iiuDN1vA1FMsUUmfdUaSi3N1DCZYnM9u7/r05aRI5N9r
	 Nzj2jq1BEPN5mBe6SI5KNXzgQxSjqpLXCOlSMMEPNisL+JeH6fKgVX+laeRxwYG5vhwSo
	 SO1cduzdnfdxCe/eCLOYU7xxA6Q1jCbHKtemMKj9k6jj9S3lZRMgyrHv/ISrzm9jtNv3G
	 0rIPJBlJFGQS35e6FovYEZrEm2J323gyLE9mRPZY7jM9ujT+z1b/p8ZUQsCVqXr2DyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DPn7MU7R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.59
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4E0606A324;
	Thu, 12 Nov 2026 03:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF4E0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=DPn7MU7R
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h4A8MnIEdG8yjEfshn+uvofmT36cpiIqNwK3Nln1bBCte7HgY50eZoLKpjdVnsn5DOfaaMR6FZDuTheUG03MON3puX+5VhRHY5z9xwXDevn/pl0vLKB8PzGMsWveaLxXQiNLFVdkOkS86LWOHBM+oOFz4BfdibtFDqQulgATUsSh3a11ydcxK5VbaF/Vp0Qdzc/NbJwQGZEvqhMl6BGrVDzWiIWoo5bpU5lwIcAi9/8hbBJSYeNaCQPg39Z5Am+ZfumqI/k01tjzT6E7r43tkfV7pORszrNSMhB8UTbmqP9Vv0FOQ3y7ufSIXiQfUMFXrJiCG0P4feYF5Xqh/GXYyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EztPb+1f6Yc04EkRk5SnwdoKZdrOQRadr4l9D1pWDx0=;
 b=Bakki47uAyI7CUKXDtkoVcap9cHyBhkjqvEB9CxYExIAWNVrviv9LmgcQjI4XjgDqVD6ND0rTMYCSrORQCitpcPy4zvfAMpRL4BzQod1/Psgb9rxoNL58B7AQMX5m31BaMjBWLBv4vHHeQ058N4t3093cjYvF23n5kHB/ItZC0BF4E0REh15BO7e3tHObIgWx3hcGGuFHmKa7w25E1nDQnyjqyYUjo8dVMEbT4n3knzLfQyY3CPovRK3sFGjewEBRRcZMskuDjvy6EBNbR7uHBRh1/KCpdeIYh2hpl1OGy8DGasmrwIhqn/yL++oOyl/Egvxm22J+PDdoBlCFFnuBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EztPb+1f6Yc04EkRk5SnwdoKZdrOQRadr4l9D1pWDx0=;
 b=DPn7MU7RyYTOwkBfHjOz0dV3GfScHWPAnVnGjv3H/w2Tav6LTw8+aWth93Z81reabK+KtQqCFycuD0HIWNBKnl4CR4XOCeQqRGdcRVPduZn3RYK81sqQs2psBjWVMn/6uWm5qhTYX/MJbqU2iBX5INuRaGFNJ0+7SBU04TwF8gTkZpqaGRdKkc1uPrYXXb63PcnB2NJigz1bxKqzVEWq6aY9ytHgmk6ya6RilBM74xnpvmACJ2yxY/53lgdZcEZjj+Cl7Zwg3V1xarNNJQD4jVGe4D0VWHXAD0scn1A+zofAFASa9OEa5ViUmtqz+MaVCf5jLX7PRGlC5iktApCbHQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com (2603:10a6:800:296::7)
 by AM0PR04MB484290.eurprd04.prod.outlook.com (2603:10a6:208:a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 03:17:20 +0000
Received: from VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be]) by VI2PR04MB11276.eurprd04.prod.outlook.com
 ([fe80::60d7:a8e5:eb88:9be%6]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 03:17:20 +0000
From: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Date: Thu, 12 Nov 2026 11:19:54 +0800
Subject: [PATCH v2] tty: serial: lpuart: Add port lock for registers read
 in lpuart32_set_termios()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-lpuart_port_lock-v2-1-e1d914e52660@nxp.com>
X-B4-Tracking: v=1; b=H4sIAFkw9WoC/32NUQrCMBBEr1L220g3tQp+eQ8pEpONXaxJSGqol
 Nzd2AM4HwNvYGZWSBSZEpybFSJlTuxdBblrQI/KPUiwqQyylUesElN4qzjfgq82ef0ULdqTIXU
 /9Kig1kIky8s2eR0qj5xmHz/bQ8Zf+mcso0DRm66Tukcyli5uCXvtXzCUUr687cOXrgAAAA==
X-Change-ID: 20261111-lpuart_port_lock-01f7deab451a
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Jingchang Lu <jingchang.lu@freescale.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 imx@lists.linux.dev, sherry.sun@nxp.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794453613; l=3766;
 i=sherry.sun@nxp.com; s=20260723; h=from:subject:message-id;
 bh=g40SSppfMXm0M2/b62H+BQ1q7ai7NmDTk7UoCnLto5M=;
 b=s0rWongkHIe2KPC8guRjTYL8ku0D4h16KdgelkqqJZifiMBR+JdL9ppkIlwazzpkkU67P9klP
 Nap2flmy2/UDXjJgDNqiv0v8Yk0fKrvxTdMWGfC2n5EpebSHz1ngF0z
X-Developer-Key: i=sherry.sun@nxp.com; a=ed25519;
 pk=YnYnIFJ2l+5v951x9shBVfHhminNi+3LTfFa3PxSdnI=
X-ClientProxiedBy: SI2PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:195::18) To VI2PR04MB11276.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: VI2PR04MB11276:EE_|AM0PR04MB484290:EE_
X-MS-Office365-Filtering-Correlation-Id: 390e758c-6f0e-41ed-e576-08df406b765e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|23010399003|366016|1800799024|18002099003|10067099003|11063799006|261026140227099003|261102123227099003|261028144727099003|261022105027099003|261009221227099003|261021121427099003|261009223027099003|261026121527099003|261021123027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	ALyikZN+txoHzJyRz6uJwP8QOvzPlVJTbsyc17rzRbhseImbJJ6mq+8XX2z/pssDaPSawRRlw5M5a39KyPOGLDPWyxIxVWGkPix0N5maas3NeWqm1YxHpcir6TyVMwvMxbvW6c593TAiI0bY9l5WKCL3d9D3NETgwMInSAtnGQu1aMaW/BQpI2NGJn1Oy0EvJNxuJO9I9UdU6sGq3Eb2mQ3nf8Al5QGF/rvcFtcOBjXeW83Mc0kaka/Uf23XsGGx0XGDTLdbKxOEr+32iA7S076xnGngJ8p7KnWdz3NBTi8YQna3Xlm7v4LCSDhhE57Dq0PLyIT2HwWvw5yZFc1F9WLWOf+ZbIF4f97GmYbQb6GM5uJlOi5lTgp34/IPCq3ONGIyaog4thfVNsjKhJQDXnh7uypoDe2Tzf/JOjgQt4OD7AgYj9/xfhAnL/6TuI1fUL3HdzSqL5SXt88vQeUKcth0V55FYmbg0P0YHWNskk9xZY6/ceSzJjmDtUYlYmjcK30neCZh5LS5Le3344AQ7na0YS93E2gFzwmSPJ+7jP7ih8v2HShdhTDgzOv/ky6FmDG2em9HPZcJ2dDmDGee0+7JOd+eDbyOVW9YkIPiejlGXv+N/R/P++rX2K41vpey
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI2PR04MB11276.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(23010399003)(366016)(1800799024)(18002099003)(10067099003)(11063799006)(261026140227099003)(261102123227099003)(261028144727099003)(261022105027099003)(261009221227099003)(261021121427099003)(261009223027099003)(261026121527099003)(261021123027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SG52SFJaNVh5alR5TkowZ25qdmIrNWMrdWJvQ3NmVFNGN0FRaHpkTWprV2lr?=
 =?utf-8?B?ZDl4NFJCbFRIUU1DblBaZUNyRXRRMlZMK0xJQ1lxUXhTcjlLZys1akgxeU52?=
 =?utf-8?B?aTdBbDJ4TUlySWhSOURiYnZPS1JQUS9KV3VYNVBlMG5tRmgzaThTQnJmeCtF?=
 =?utf-8?B?cjNTMmNlQVgwMFM0VTNBWTNiQ3B3YzRVdEgycmY2VHVYenlHNG9ydldEeEdp?=
 =?utf-8?B?eFRublhKMzl4OWFvQjZYU1NjajBybDFDRzg4YU1sS3A3NHRXVVowZ2ZRcXFk?=
 =?utf-8?B?bndNYWZDTE9GOUxYbUhIdGZLcGV1bFVWcWlvQWEzelJIK2lxYUd5T0xUZFRr?=
 =?utf-8?B?M0QvUSt4eWFzc2pWODBmOUlRWnJJYVVwVHJwdklPSytNTjArbFdjZnFzTWFR?=
 =?utf-8?B?emJtRW10dUdMUzZhQm80TmhhdFZZenhCc3N1Y0dqUENKSXo4OWtHMngxeVNp?=
 =?utf-8?B?YkNhRWFUL3M4QmJVZVRVRE5SbG03Y29ETUN6VlBYZ25iOFllcnpTSUV6QWo0?=
 =?utf-8?B?N3lSVlprMFpJUUxLQmRKNVErb1ZRV1pndUJ0ZHFXdU5YeXFNZEZ1Qy8wc1Y3?=
 =?utf-8?B?aW96MEMySnBETkY2SVhNSkJkQ1R4OHdxcUZITG9EamVjQ2hNTllRQ3ptYzVj?=
 =?utf-8?B?VkVUU3lWSmdqbWtPZXFvcS9hWldXN3B6eXBxdldsY3g0WElFRzFaejFSbVN2?=
 =?utf-8?B?d0ZMVStoNkFETHQ4LzZjQ1k0VGZNbDBMYVNGcHpOdmNFQUsrZURlRC9RaElY?=
 =?utf-8?B?WjkrekFwTHhhQTZxb1V4aENaWURmUU0rNFVCUklySXlZVHo2T05sZGhzVm45?=
 =?utf-8?B?Qk03bWwybXFJRE56NjVNWjVZZGx6a2U5MGkwNW9KL3JPTmFFMy95b2NJZWti?=
 =?utf-8?B?Ri9Rdmc3TDJtMGtmclBWNi9Zd3FMTDFBL1JSWm5NMVJnMEYxUllNVFJDYjE3?=
 =?utf-8?B?N04rRk1iZU1qa0E0a3hsRjI2K0dxQkszSE93UkF0T0Z3d3UrM2pMM2xOYTYx?=
 =?utf-8?B?YWFxVWt2eTAwWlpIT21FMVRXYjdvdVlRQmJtUWJvRENlTmtwbXRHT3d4blUr?=
 =?utf-8?B?aFRsclkvNU8yczRIa01KMXRleEliTGNNNWZNVHA2SWFVTFltV0N1RWR4M01a?=
 =?utf-8?B?bU5GUWFrNGxvZlhnZTFhcWJxVVFQem8xRFJnWDMvWnh5VjZMYzQ5dlJ1U1dS?=
 =?utf-8?B?ODdyRGNiaHEyNllvR1k1cTZnU2RJclJyTU5YRnlWMUlRZEFFVS9wU1FQSk5N?=
 =?utf-8?B?UDFlZ1FOQUYvMUFjQ3VkbjFKNzZUNlNpTGlZbGZnMUhCT21FLzFDVWx6MkZM?=
 =?utf-8?B?cDFyQ3BoSVdkYUdOdWhHK1p6STFhMjAyeWVtWCthdk5nek83RFhVRElVYkd1?=
 =?utf-8?B?UzRXUmNJWmVLSXBRM2dhMTVUQXAyZ0c5aFp0UWFEOExXSnI2VEc3dTNVcTY4?=
 =?utf-8?B?VTRtOGFzZlNVRG8vQWpBY1Nsc1V0WUJidEZtUndQa2RGZjR1ZHd0RG8rVkh5?=
 =?utf-8?B?RExjRVE0ZW4zYWtMbWMvZjl5ZVhidkZzUnduaXBjYXZQeWZ4STRYZHV2dFU0?=
 =?utf-8?B?V1VZK3JtSDVneDFPZVU5Y2taQmwwOElzcGpXZXVxTnpFVTI4bDRlT2htRVhR?=
 =?utf-8?B?YXhyUFJ2ZDdTMTVyOHdNMUVsWG11czRmSUVia1Rob1V4enZCL0VHYmdBeDIy?=
 =?utf-8?B?UHBUL1Y0bDd5bUFwdHBQajRBRGVOdUZFeW8zK0RLcDRYRTdPOFRGVkZSR3RZ?=
 =?utf-8?B?amxtSVhRLzc0di9YcHMvd3BWMlVRaVBYSThxK01GcDJ1NHpOVk0xS3p1MUhK?=
 =?utf-8?B?aU1lT1lDSzhBYW80NXBLejFlTnZONDBOdytYaDJud0FmQWJ0MjJxRGMzWXpM?=
 =?utf-8?B?RE9nUnVCelVtUVR2cDltOVpmVnd1dHZQU3hXRWkwSGp4TTdNRUo4Z0d6L3M3?=
 =?utf-8?B?eGE3Z2R4VHhBVDR6YVZONlNjNk52enA4ekJHZ1BDNkJUcmVLSXlpajFGMlpk?=
 =?utf-8?B?ajVUWURjYUFxcEp4R3FNbldXZ0VVVU1HVmc4SEJuRC9iUVlNSmhQOFZFSnNJ?=
 =?utf-8?B?QVphSTZRTnlONFA1cGw1T3F2L1RyRWFkbUJmZlgwUElSS2VQTy9KNXF6NVhp?=
 =?utf-8?B?YUdmWjh4MGFpOHlsNjVFdmxCYnRIcElhV3RGUDdRdzVIckJJQzJKSGRwNXpo?=
 =?utf-8?B?RUczaVQxc1lYNUFSNFVRVEZZTUk2NnlGWWEzd1IxN0FCeXYzOWFtSVdIeDdM?=
 =?utf-8?B?d2Y1QnFlK0RmaXl1ajZRUFE1bXFCMFV2MGF0Szc0VWxxRmpSNHcxVGs4d2NK?=
 =?utf-8?B?NFpIQWY2c0ZUZDZiV1oxOVVWTUxZUk9MYy9mRVUzTjBMMUliNHhNNXlBM3Zi?=
 =?utf-8?Q?n13CH9NzX5VJFJdNHJPwlri7E+FzGNGu7GciG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390e758c-6f0e-41ed-e576-08df406b765e
X-MS-Exchange-CrossTenant-AuthSource: VI2PR04MB11276.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 03:17:20.3400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDfDsSSqVGI6CpyxUUjpQ6nDFm+stx7f2o3sth6ZincQO7ZDd3TnWyq3Rh/Qa3w3QCZuWMALI5WeC7ToCHgsrnMhWRNVtb+OaxZl4XFKqz+W2/0XzvCB3saO5kG6jiRf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB484290

From: Sherry Sun <sherry.sun@nxp.com>

lpuart32_set_termios() reads UARTCTRL at function entry without holding
the port lock. lpuart32_console_write() can run concurrently on another
CPU and temporarily clears the RIE (Receiver Interrupt Enable) bit while
it polls characters out. If the unlocked read in set_termios lands inside
that window, the stale snapshot is written back, permanently clearing
RIE. Once lost, no normal code path re-enables them, so the UART stops
receiving characters and becomes unresponsive.

Need to add port lock for the registers read in lpuart32_set_termios() to
avoid the unlocked snapshot captured. Since neither uart_get_baud_rate()
nor lpuart_dma_rx_free() uses ctrl, old_ctrl, bd, or modem, the register
reads and bit manipulations could be moved into the existing
uart_port_lock_irqsave() critical section after lpuart_dma_rx_free().

Please note that this only fix the normal printk path, in the
oops_in_progress path of lpuart32_console_write(), when trylock fails,
RIE is cleared and old_cr restored without the port lock held, there is
still a risk of stale snapshot, but it's acceptable for the post-oops
state and the trylock-fail window.

Fixes: 380c966c093e ("tty: serial: fsl_lpuart: add 32-bit register interface support")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in v2:
- As suggested by Sashiko, since neither uart_get_baud_rate() nor
  lpuart_dma_rx_free() uses ctrl, old_ctrl, bd, or modem, move the
  register reads and bit manipulations into the existing
  uart_port_lock_irqsave() critical section after lpuart_dma_rx_free().
- Link to v1: https://lore.kernel.org/r/20261111-lpuart_port_lock-v1-1-5d332c51edfe@nxp.com
---
 drivers/tty/serial/fsl_lpuart.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index cd2575a3aef7..074bd9d42f84 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2241,6 +2241,20 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned int  baud;
 	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
 
+	/* ask the core to calculate the divisor */
+	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 4);
+
+	/*
+	 * Need to update the Ring buffer length according to the selected
+	 * baud rate and restart Rx DMA path.
+	 *
+	 * Since timer function acqures port->lock, need to stop before
+	 * acquring same lock because otherwise timer_delete_sync() can deadlock.
+	 */
+	if (old && sport->lpuart_dma_rx_use)
+		lpuart_dma_rx_free(port);
+
+	uart_port_lock_irqsave(port, &flags);
 	ctrl = old_ctrl = lpuart32_read(port, UARTCTRL);
 	bd = lpuart32_read(port, UARTBAUD);
 	modem = lpuart32_read(port, UARTMODIR);
@@ -2320,21 +2334,6 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 		ctrl &= ~UARTCTRL_PE;
 	}
 
-	/* ask the core to calculate the divisor */
-	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 4);
-
-	/*
-	 * Need to update the Ring buffer length according to the selected
-	 * baud rate and restart Rx DMA path.
-	 *
-	 * Since timer function acqures port->lock, need to stop before
-	 * acquring same lock because otherwise timer_delete_sync() can deadlock.
-	 */
-	if (old && sport->lpuart_dma_rx_use)
-		lpuart_dma_rx_free(port);
-
-	uart_port_lock_irqsave(port, &flags);
-
 	port->read_status_mask = 0;
 	if (termios->c_iflag & INPCK)
 		port->read_status_mask |= UARTSTAT_FE | UARTSTAT_PE;

---
base-commit: 793807ca13bf3072fc6d16ce6d90e9ab9beff2a5
change-id: 20261111-lpuart_port_lock-01f7deab451a

Best regards,
-- 
Sherry Sun <sherry.sun@nxp.com>

