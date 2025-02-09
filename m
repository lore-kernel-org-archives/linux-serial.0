Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2125.outbound.protection.outlook.com [40.107.21.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2E123F269;
	Sun,  9 Feb 2025 21:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739134978; cv=fail; b=TRgSfF0qAeG+Y5tQjZBfUPyaA9/1Om8ta2uH4QCGIwbFiEprtI2JW0rO+DMQQsh0LvYCmzpwYoz9yzUdPn9U8bixm97qX7o6UhTrT8+4Z7o461TQt0goK/wGF+0L7M4XPcDVKnNDu703/uii1H2O8Og8pYmIOl4W3SDBF4NBdW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739134978; c=relaxed/simple;
	bh=MAh3DARtQWHbFA6YVGpg4I67YVi70TSK6Wz/ZCTv1YA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JkzShpNTH+FNZDxK0GoTEP3dTEvyVHEb2f89rR9tG6PKa2AI9gsLRQTcQDcQizeelvRygqz8bzuETpT+5LcbvX6Ew4xghe8Nif9QqnfmsPlVv8S0jeCXJoE+DyOknjov+yUCWkIT5wq28NoxfEyADuhxdj3i452TySnxG1XqhJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=kDG9obqV; arc=fail smtp.client-ip=40.107.21.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="kDG9obqV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wiY//v5UAYGWyemDFKrGuK1nYgrdXkSYjLrnIoSruWbDyCd7FdOtR6FS62G4sdLhX472nw3jhTC57SLYpPmuL2gIjrUWGeKPFO5WsOwae30tVObhbkezZ+HCSYX9saygjJtipCLpXgrX2gVTjRvdOFHKnI7innk3SVxbZ80KFd9U+1j13PkfZ1lTNLjXTVGT0LAGTscTNcDes8ni8bx9+QXM/0+6rUxEO+Iec2dJOsW7nsKJ/z8X6AdeJP9v5fvcV8o0BYQFggILis0rYZirS5jusptNIJ2Nz1vM5ImEFQczpve7mukicolK71t7iXHJiRUaDd1Gx6aR7ER1TSzqcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTVOqWNJIMSQ9EKmZVaB7fBsj0q8R2cso/lfI5R8bdE=;
 b=Rzkdje95kwJBWcNd9VsWNmDrn8HG7+U3PYj/ge4vuQSI0XK2Z0/d/IagMTSykSf3TRkPmwHQotEu8J1YopLcAIDhXEppgBUhj2iTIUnUAln9X+4Mtefvd/1wqUVHGLPesRitIfcWa2FsdGUajsKRD+jS2clun1pHeQgau5q+q9zzQknaPYA5vKAilTFwhQbtwjUVshAVkwzBXi8ptmbItoz1hmeLh3Wi6EZk2mBRZ1J4Kzg6Pidi6YD+bQq+cF9xoGDgm/DTABGsuIuZCW7LYvWP7U/1wwCrEjV9Uz5wGwty4CPG1BOQw9BUFC9AVwuQOYPXh9jEyzbK3mI453j70A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTVOqWNJIMSQ9EKmZVaB7fBsj0q8R2cso/lfI5R8bdE=;
 b=kDG9obqVJbm0FvdPgDqf5xSbU51t+T6LDVqjyAJdjkm6TsNfQsIYqbaKGsIYrhEIE2udAhdbcO2cI/36/yhUWMV5qaBvXe3HePqxZb/EO+2xeECBSJKBBLYWzhH6tGqMubthVH1LzWQIbO4hRZgq9QGqD+0liKwAyMYH+fMadeQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 by DBBPR08MB5962.eurprd08.prod.outlook.com (2603:10a6:10:202::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Sun, 9 Feb
 2025 21:02:52 +0000
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42]) by AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42%4]) with mapi id 15.20.8422.015; Sun, 9 Feb 2025
 21:02:52 +0000
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
To: linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ansuelsmth@gmail.com,
	lorenzo@kernel.org,
	gregkh@linuxfoundation.org,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: serial: 8250: Add Airoha compatibles
Date: Sun,  9 Feb 2025 22:02:40 +0100
Message-Id: <20250209210241.2622309-2-benjamin.larsson@genexis.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250209210241.2622309-1-benjamin.larsson@genexis.eu>
References: <20250209210241.2622309-1-benjamin.larsson@genexis.eu>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002BB9.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:13) To AM6PR08MB4215.eurprd08.prod.outlook.com
 (2603:10a6:20b:90::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:EE_|DBBPR08MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ac1d2f-d3d6-403a-233c-08dd494d1dc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6g0sFCo71mKKlO5orGWirKPZo3JCjKj0SA4kLAnjnajWG1WZ3QtF9bI/kE+v?=
 =?us-ascii?Q?USKWSFTmuB6hvwko+ozgUoLRPzFJnxcqv0QYMgNKx+u5Hsdbz76L0wtTBYm0?=
 =?us-ascii?Q?/CwXQb1FI0rEb2OYPKSfiL/1IzWUfjiDPmD/RxM/tLc6fiSXSG9Vti/04smJ?=
 =?us-ascii?Q?HvU4UoYyB+mPkIBhcObYOvh6ldsfD4eMl2pEVuxBDaCMeJrsYZZDFGHFlqnV?=
 =?us-ascii?Q?fIIPJ64qh3TOaGrhz+5MsX25DeBUNldYW2VLd3k9DxXcR/0++Zie99xV2o0C?=
 =?us-ascii?Q?9ZakZ8KPdBvPl8kywngGKLagpVnVI3Mg9oS9zQoGAKqqeF/+3iaRfAxB9npy?=
 =?us-ascii?Q?kEDqB1emUeO1T4pviaOy3hnULEbAwYRZBjrYmi56wZ8vT2pax2CCNn2GBwiC?=
 =?us-ascii?Q?66CLEcdu50xq+OTLtNQAmiji3CrMrQU8CT2Y9RPAJSGOcSsyqYW9mtxhKFrC?=
 =?us-ascii?Q?7z/Rs6oz8cBaPYOqe0S0kQq2Vc/Vdug9rK2A/BKFj+Jg7511sMO1RoNIErNv?=
 =?us-ascii?Q?ARyaUw0h432wiFKe1GWdoDLttveYt/pztMMZ9LobYfcmQrnmVQNsj/uvhQue?=
 =?us-ascii?Q?VML5GKqej303u8e8v23GFFeGcbYuTVCCESvr+Wqu3TQE2zFdMf6osm4EbUEU?=
 =?us-ascii?Q?CNNBKckmzJkXEoeCqcw+0+3ANMV0toy2i2/Vm79dQ5KiFFbPRot3iGW1TjL3?=
 =?us-ascii?Q?aYiGFF1wzZznWbpHAdTfPPJV3qWnZpzuzDHitotYRHR7bevGKpJBgMYiGXEm?=
 =?us-ascii?Q?Muy5IJHmTsx5QxDzfVFMp6qd4ukdugdWtcHCpV4ppUlpmrbCr3BRwNjvFnPi?=
 =?us-ascii?Q?4/ph/2N/JNtOiOCCObtE/txSJzJBpfWkn8zOvNzRK86TxC/K6ME/IGK6lWka?=
 =?us-ascii?Q?utcd2UzD1ifhtFc0M0IBVSEco9V5o6hmI1EwLhIHKDuNWpIoU9bTR3ggb/MU?=
 =?us-ascii?Q?6BJRVzapfDGs8kAzKLTsS3A6HobPHuQQP3SNwYNyQ7q4+G4wjH8CW6EFWhqq?=
 =?us-ascii?Q?/Rw4+/KKbyX/q85G+KaHu+E6Nel6Sj9hPqQDXXL7KU59ZFCaLjYWQyhRmKeR?=
 =?us-ascii?Q?EbHDWnbpLiwua/7QFBoFqDHgR6Et/yAfJHpWJ1rGtf8hlV/Ar4vbZWl7JldC?=
 =?us-ascii?Q?B/zV2lbeTZ4MvMFdme9X673h3sjbCD8wqiT5qo6F/EqXatVqh+KDOQke7cNp?=
 =?us-ascii?Q?pEJtdL79AndQtEZPTicvHSu10Hk2tsmaqA+BguSLj4R9LzBI7urZdftFPUEr?=
 =?us-ascii?Q?RGKNOvPk6hbHXbY2mvLurUn7d6x7D4wClMznOdP9Ta9Nd8qo47r+Jnb78dV8?=
 =?us-ascii?Q?N/yMlcjv5K4vgqJqzQS/Apc92ItyBwfwKJ3hZU/r0i3v44KZYBPgJvLoWe5V?=
 =?us-ascii?Q?NCE7uwtVXCOKJQfGiUAtysWAFji6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4215.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bQulhYYS33d5FZUODGEYfTkBA4pkvq5dTum97zURnjaS2jmjfJhpILu8wqrL?=
 =?us-ascii?Q?MWqUymOKRF9vY+tAvWbDiPwcyMoOsgbxsbObzcMEzMV4K9J2uZPkVZEXBFC1?=
 =?us-ascii?Q?mVQB+7jNJsb+xWJ93jQTSNT1amMHcmQCHuKFZ6LS8gIySJ33v0fWLxwd0fZg?=
 =?us-ascii?Q?qc9Y8X7Jipv8rj9TPs2N3+GE+and83UJ3a+ibkJskQ0Sj1xU3k9JPLEz2Iy/?=
 =?us-ascii?Q?KlSU6g7fXFYVZRVThdyN4QmFOlU2iZRClAVH1GVdMLfZRGGH8juKAzRHAuKx?=
 =?us-ascii?Q?J4oZLpK49Nd7Rh17atEgOrxN2jDed1EqqchqlHs+f76g5cviKf9Ld9/h5+Cu?=
 =?us-ascii?Q?GEGrJFFZ2uMA6OH4JIH+HesRW/Ws6sgwHHkX3UFcEYn2MqMmVWg7NQC1S8tP?=
 =?us-ascii?Q?30wg/Uw9eNfmU8w/UtSSGZVdDHNJrwJKVotfNmzJw0xlZsOAzhWTP/lYGYwY?=
 =?us-ascii?Q?tcJzrharGn6zKKOYZ2iTun4qnzjl+4wGUHb9RhLphqXagcdRcg9op8yOa7tV?=
 =?us-ascii?Q?FP/8ci8DkLZFELw+o5rq2ouxoSKOnJEH9S8gwBAUbMaL+vQakwWfxLBrWrkN?=
 =?us-ascii?Q?yolCshmtcX9zmPpxDe064oKUyRRsqitECBUM2Nw45VFxlZXjNEdB7IUHuof4?=
 =?us-ascii?Q?Idl/5qNCWAuop067Fq2X9RpSFn+00bDyerEJw9hFncukzrJHjI3TaenYVc02?=
 =?us-ascii?Q?db8OxqAwMBz4vgX7MTE+pbNCx4VIK0xjiWpmthkV+XhIXRsxpvfD806rM/wo?=
 =?us-ascii?Q?4qtPIGrZMJHacKgmU0TagC8jzGjuiwopKceHo9ie3uNBGC1IoUrgG5+PKkED?=
 =?us-ascii?Q?7rInCpVSOWhXJot3ULTBA4+uTq7yEtECduZ9zMFpYJGfYuQZoFPua+LTTTxJ?=
 =?us-ascii?Q?YE6TBTIBHwoUp0AkGbTnq5a/EEmFsrlTwSF0E+kuWfo0xVWLmho3jUief55u?=
 =?us-ascii?Q?uN0+xn3SGj5dAnuMvM+SONoSbCFdFpC07p+UD27lpO8I3ZxIKxw8fXjLvxsA?=
 =?us-ascii?Q?BxQ2s7Cgio7Y5qoJXN9M0OqZdBF9VSeJ+p8OcQUnfIDtAY2MtsfKFnsfHc9X?=
 =?us-ascii?Q?acZ9AkLOkddG6w5GClUtXNSb8XoTvoduQp9nNoyfnEHicwwdMdOx/ElWS2Zc?=
 =?us-ascii?Q?9uxAg6J33pzNdyqh0vua97k8qaHZX7u72pdXKs3zDy2728UJIr1SmKIi0X6B?=
 =?us-ascii?Q?RIjOQe77soISlMojBKy1KIibwjLy2TttHiYJIAzaWFa146D3Laz+pUjSea47?=
 =?us-ascii?Q?W6rlK9aqIw8QZA8QpMyVtROXjqtA/nzY0eGogWbPdCGnEzBv77uymi0t/ktg?=
 =?us-ascii?Q?jkFwJRnOH1IhVDOSRUhwhpR2z4dIuqNwedWVjzCFsICzrXWgA+ruqiBBdPw0?=
 =?us-ascii?Q?VIsfMx8pnBCTtQ8A6erpPGAuO/oTjNplRxudDsMZRSWpPTSC34K4lSJGNkx0?=
 =?us-ascii?Q?0pVa80Z2TvZCq0nKvAp6njxY8PVFj2gf6eeBuXqCAQDcxP5nctc9EX1T1Yej?=
 =?us-ascii?Q?lh1FCqDp/wdk3lGfq39uPGz9FmYPWxfVUw7Mt3SJPtIG1Kjxil0n/AwN+Xwb?=
 =?us-ascii?Q?aRXgjyy7+HA5gtY/yc/TSAC6LP5S2CwnrUJX7iqT7xi/h7F6HIS7lrW1QnK+?=
 =?us-ascii?Q?JCUD4ngirxDpw4KwelQUB1J4kT76h3S60slnZY8Z7aJNAejh4rgIOjTOHAaK?=
 =?us-ascii?Q?Kg5l1g=3D=3D?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ac1d2f-d3d6-403a-233c-08dd494d1dc7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4215.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2025 21:02:52.0371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rmxyX1lwX5efNq+y1wi+Lq680RLNItCKmTfZVWkwfgL8MrQ1zOwpwjTM+RhAdSP2Oz0PVf5eSYH7P3f6TaJreedwK9yAamM85o+AL1xoiNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB5962

The Airoha SoC family have a mostly 16550-compatible UART
and High-Speed UART hardware with the exception of custom
baud rate settings register.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
---
 Documentation/devicetree/bindings/serial/8250.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index 692aa05500fd..2fbb972e5460 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -63,6 +63,8 @@ properties:
       - const: mrvl,pxa-uart
       - const: nuvoton,wpcm450-uart
       - const: nuvoton,npcm750-uart
+      - const: airoha,airoha-uart
+      - const: airoha,airoha-hsuart
       - const: nvidia,tegra20-uart
       - const: nxp,lpc3220-uart
       - items:
-- 
2.34.1

