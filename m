Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9511AA1E5;
	Mon, 18 Nov 2024 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944701; cv=fail; b=H/EHz8dUCImz1dLhGkmyZKAzD7Evn2PVtmareE45TQnLqozoLEQam2ZlCqxvUuP8xGR8zbHLsErnVEDwZcFUqdq6EHgah+jG/WlbRo9S2HLmmsC7mVtsoHOvpUapZ+KH2FljasS6P2SeTsD+yJo5YFDR84TbJQ0LUJTCHDylvX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944701; c=relaxed/simple;
	bh=gbSVMLexNNjr7WSJ01xKZ/fRYag/IlfQKqG5llfTlYc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YQOuoOMjE6WdqUHzxGZ3jX9q5pJ25OIT4BM1fAVlt0ocqLuy0b63YaR0+2VW2qpEB2DqvSMM2yfCfLutdeik3hVsEp0GTIUDn2l9F3vmGNIV/umX446yVrXct420Rt7CSElfnwzVGtZ0iGHGnO4N5JX7c2hLh+Co77J1faC4qzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=b1NRxHMv; arc=fail smtp.client-ip=40.107.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="b1NRxHMv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nSy76EExxdBUAdPaak9jyHY0cnHibwHbQtR5lGWmWuxzrkBVPUTPd6MF7lyQkZxeFLctl2l6UrsuMjxGVe1Hv1N1gVlpKwaoDfKlu6R9dmTGIqGPBijBnvZh+uPGbkobZ3x2IsImzxHB0DwMB0Q0uKx1DRSRfnzA5oJxHBmxtVgkNMkKrURML8vax/XCZkqaJzLYh6zE0cNNLR3WaEF4lHZ1XGtTYWdzH0t+VIAIusfO+PNdU/xq0qWhCFgAn+cUulT3mLOsy5/If3CBHySKlc0XHDktS3jL23fHaCkBTiX9CYwwS+g7mwdnzhgQfvt6KAobLftrJiCdNP3IG/pDOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFQWVCfq8bh6QP6irQZGnkCZquVGjURVDxs60ESnDzY=;
 b=kzqIMnCFTpU1RLc/6n4KIgxYWgyCVAWx4aMdcbFJ097AH25Xj62vOiJ4ulzjs+GBy4QltW76lMFKCwREdui5ccJlwoeh5taOhKu0iQawG3KpivRYUufyPfg72g5lHQgXpZNmrtyxPvWKuH9Z/l9WTAkLyVgG0GSPIy6YnBmOLGsenCopm4HkLkMVXJuAan2xFWrDeGd4tN89WfpDwPAWxs2X7Qj7bI8oWujHfVYBUU88eb+zIMUq3GMx0UnatInWhrxcaqGi3ZYZHXAGTOBOz8FuYOYmDE7y0IXUv+cgV1R8QAW1+cjadDBi8gdsTy84pikBhqSdN0D/jXdYTr5l2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFQWVCfq8bh6QP6irQZGnkCZquVGjURVDxs60ESnDzY=;
 b=b1NRxHMvpoX84mynUc/0Co8Z/HYi98zKpMVLUtoDbviOL+oL/uNl0XKZbDwpylxedFGgsddk4Hrr7k0nqqne9tkPFHcl757BDbyYHSc8eAW3ySrJucjXc0LQZncB048lG/ZMKlW6VvRnr3Il+PY3ldUrs4d1owhPPh0HoSctmSHOXYySwVxjb17MBvlcXi1Gr9YWm4xJL3C7sg3x/LHhH+3Nj4coZwIhjLtQpAFs0XDiofzVeiCG/6la5LBmubJytsn/S2RxlotFHnRMfki4mQ4Ga4bEbheEjdtO7rWnMukBRss+Dxbe4EvVbbyU91MXDEeEKy9+/qxQ2UBdYaPwgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM7PR04MB7175.eurprd04.prod.outlook.com (2603:10a6:20b:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 15:44:55 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 15:44:55 +0000
From: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chester Lin <chester62515@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	NXP S32 Linux <s32@nxp.com>,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/2] dt-bindings: serial: fsl-linflexuart: add clock definitions
Date: Mon, 18 Nov 2024 17:44:47 +0200
Message-ID: <20241118154449.3895692-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241118154449.3895692-1-ciprianmarian.costea@oss.nxp.com>
References: <20241118154449.3895692-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::7) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM7PR04MB7175:EE_
X-MS-Office365-Filtering-Correlation-Id: 622ba5ca-9991-4615-42f4-08dd07e7f2e7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUN0K0pGYmJBT2FWU0NaKzhLZzJ4VkRGZUYvNWRMa2tWZi94QmlOanhmdzE2?=
 =?utf-8?B?RmZRSTBNV3F1bjNqWG1UY0tpRllCZmJ0ZEMyZktwdm9aaEJXZ3BHbWtYN1Uy?=
 =?utf-8?B?NE12QTdyaWJ0ZUp3TVp5eElMTWl5RWpjZVZXQlBlejlnMWZxWEt5Q1BGNUFQ?=
 =?utf-8?B?dTFQTnBycW44SnVKSFY3a2NtcTlWZCtkRllZcmRSL2Uyb0U4bnRiVmxGbWQ5?=
 =?utf-8?B?b3NzN0dUcGx2TzlpR2RJT0dJNmRoMnJQUVdWZmFJbmxEQmg0eWphMmg2Zjll?=
 =?utf-8?B?WkFCVEE4WWh4ZWJZZmRkaFo1Y0xEVkdqSnd4TnVaVHVyaXAzOTN3Nng5V0U0?=
 =?utf-8?B?cFZjRUIwcVBuYmlVR09Gc2RPTjY3NVZQSmIrZGlZaE9KSE1NU29XVzI0Tkp2?=
 =?utf-8?B?VVpMMkNUZXVBbVBSTGNtMW1RRXJFb3JkblB5bnZZaFROVUZrb0g1Z0lLQWhN?=
 =?utf-8?B?OHh6YzZ6T1R2Z3dmZzJPRlYwNzluSlBiNzJCeVl6bzJEdU5Nbzc5S2tNVEdn?=
 =?utf-8?B?SEsvUVY1RGIrdXNLMjd3YlBMVFpVZm5rOGpHOGZYR0lxdW0zemIzQlZtTWZ6?=
 =?utf-8?B?UHJSdkhjWXlNYVNPNXNWUE50c2tpNzQvMGtWcFl0WkZXdWZ0aVpKSUtTZ2Fi?=
 =?utf-8?B?UElzQ1RlNXR5TzJkRzNWcWxBL2xjbnhDQ3k5R1Rxd0pXdElXZmhYU1VQREdS?=
 =?utf-8?B?ZkgyaVlwZ2lkUWlqTjhFZlNIR1hlcmIzTXRMYU0vV0FXNmJ4U1REeFVRYVlE?=
 =?utf-8?B?bStPcTNXNTFGcmVCNFNpb3pKeFRGanNxdEVHZWtPN1RNYnlZTXVPVmNtVitB?=
 =?utf-8?B?VTRVbWJqckNjdVBNOXV2WG1vaUxIKzA5dSsvVkE3b0E5K3FYUFliL1pYN1Zi?=
 =?utf-8?B?Nk04cmdndHZqRzNnMHRySkl6ckRrMkltVnlmUG5aRU1rd3hoMUwxaGluemNE?=
 =?utf-8?B?YituR0kvS3o5ZXFtZXRzbHVnb0ovRTR1eUZ6bU9rWWh0VXdVVFpyb0pqYW9H?=
 =?utf-8?B?SEZlRnJ6amxtUGRLZUNCZVRydTBmNEVnVHNqYjFxeEMvU1ZNSFNwZ3p5Nk03?=
 =?utf-8?B?RUcxN2tUODZUMVZCTno2VVpLd0FYL0FKSVFTMCthNVB3V3hkVCsyMlFmekov?=
 =?utf-8?B?dWJoclBZZ205b2tXTEN5cnRJcUgvMC9BZFFOUERUclBPRmQvNVlLL0lrTDJI?=
 =?utf-8?B?K0N5ODRTMjRrUy9zZmtXVWJNekR2N0xpSi9UN1o5R1EvQzNDYUIzYmVEelQw?=
 =?utf-8?B?QVk0VmxGSkthRjUvMjVBUmVEeHRRMlVnVVl3U2o3UjNyM2QzNWFWc2YwVFBz?=
 =?utf-8?B?YlY3VGlnVzIyNnlKQkZ3UCtTUEE4MTdZd2hEajV6Z1RtZzAzdEh4b0J4K2c4?=
 =?utf-8?B?QVRMZjdRUDZVc3NDUzhNWVNJeUNHS2ZrcWw0ckNlaXdQOGdGMjVJV3VXMXBi?=
 =?utf-8?B?ZXVjcjlJM1ovQ202N2N6TEpuSVhQalkwdW83K0lEUGZLRGV4a3RvZmNQZGVx?=
 =?utf-8?B?WTQzTFI1NzRiTWl2b3g2eU1KVytSL0pFcDlPeDN4M1ZOYWI5RHc2SDVaSm55?=
 =?utf-8?B?TFBiRVVmcFdIczBSWGhCWFdjNzZjRVMwNEFkYmVOaEJrc2hJZVlmZ1VVVDJt?=
 =?utf-8?B?dm5zVlFkZVQrRm50THBBeWVEMW94V1B5VXdBbFI2QjBpMG1yTEdjMWlvVWhX?=
 =?utf-8?B?UmFmRFhTLzNxQ3pjYUxRdXhZYXMyYUMvTDVqajFHdjVIdWhlL1NjWGZRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGhhYU56NGFlNTB2NWxIZDk4MUNZbEdKUzFzTm5oMHpjdFdvTVZkSmpNQmN5?=
 =?utf-8?B?Vlp3MUk4VnZtaDhQNG9BdFBpVTcyOG5PN2FKT3BGRWRldko0ZDFBODFBOVlX?=
 =?utf-8?B?dDZkeTNVSlhDRzZ5dWY1NS9DTFpjWHZ0OTEyS1BkMk85b0MyWVFzSDJyQS9G?=
 =?utf-8?B?WEovei9aL1ZZV2pWQmE0T25SdVVQZzlWUU1sbWNJM1pYN2tyWDZBVXFXaElr?=
 =?utf-8?B?dk0vcnNMSHlUeFUydXlHdExVZTZveVVzb2ttVmNHSHNubXVJUzMyZWxLZjE1?=
 =?utf-8?B?aGlQWWNNMmpqdDU3cUl2SHlvSVRBVmExRnRGNTRBQlJpR25UUERJaUpvN3JW?=
 =?utf-8?B?TE9hY1l5MWFFQmNFWW5UblRFRG95M21vY1FTOWpuMUVsQ0VOTEJsaUdkVkQ1?=
 =?utf-8?B?SjVsNCtnakRtbXR3WXlyWXlZUDVYZTE1cFBQUi9Ua0VVOXF5VjQzZms2aEJE?=
 =?utf-8?B?VXg4RmhqN05uRVZ2aEJhMmt1NU1VYkk3dGwvY2ljWVNMUDRtUUVyRGI4bTN0?=
 =?utf-8?B?b09BNzk0RzRkSFJvK25CWXYxbW10YXVxTWxzdnhxdXNEUUtjaGJBUS9tMDdv?=
 =?utf-8?B?dmpldW5Td09nL3poVWxGdlpibHBFemNZSWJWd2ZkcmJtQ2VRbDNFTHZreXA3?=
 =?utf-8?B?Z0ZPc1A3YVZTektLWExRYjJSZjUreWs4Y05WN2FIRW4zZDNaQXNrTlhxTEFM?=
 =?utf-8?B?Vk51a1k2MkF3Z3A4YTR4VDlWK2Z3eTNCdit4a1BiSVVpTklGTlZMS1hGUVpN?=
 =?utf-8?B?MnpZcFM1NTMyQ1IvTlNKM21MbEhPelRMQ0hLSzc2NU96elpMTHRhTjZONmQ4?=
 =?utf-8?B?ZnNqR0hQQ29rS0N1aUlJcGR0SGI1VkhBNnJncDA2R2ZSSkQrL2d1bHRCait1?=
 =?utf-8?B?ZGl0MmJYZkJVdWVBTGowZElUVzNKNnVuMGJRdnBWSSt2S2FxMXM2b0NiS1g4?=
 =?utf-8?B?OHhLWW96R2pwZnIvVjBTSGIwRlRYbkJVRHpvSG1vS3F3eUhPTWQ2c3RFRnZJ?=
 =?utf-8?B?WTNoV2tEc21icVNwbmhMYVdmQkFWMUZQekoxZnphcDUxR1krUlNXUm8wcmdz?=
 =?utf-8?B?a09tMGJkeHZIR0kwSnFpaXRsS3I3OUYveURWVjVabENWWkpsQlJKZ1k0VFp6?=
 =?utf-8?B?SGNtWHRUVnRIZFdKRzlRQURCNm95YzBHYUxCQmJMdnpKa2tSdGlhamwzdDRm?=
 =?utf-8?B?clFRN0VWQmhzN3BlSlVoa1R2dm1Mc3pnbll6U1FaT0FDK3NJc0dFNGQ0YndO?=
 =?utf-8?B?aWZGTnNzZWRPc2N2L3NtYlk5MEhrbEJyMzRLbDdVRFc4VnE5ZkRKY1FNNTVl?=
 =?utf-8?B?MVNpL0FvOXhkZDRTaFpWaFhNa2hPYmFaTW1xYm8rMXo0UWdoc1Mwbi8yVzBG?=
 =?utf-8?B?NGlQYlZIaE9RaU0zYUhRRFpyZWlBbEczVWNCdXVjUVZnUUdRcCthUHR5a1VJ?=
 =?utf-8?B?QXBtSjFIRkNaWTJBajNrUzNadU5wV0JJQlZiakJsQlBCdGxZSUhQZzZNY3NN?=
 =?utf-8?B?a09PNmdCSG5CbFBCS1draFBiK1NPRWFoRFRCRlBDZmk4T05MYWNpeGhJbndC?=
 =?utf-8?B?cnhSTWNWMWN4OWRFbVkxZ3pZZDE4MForM0JreVcwOTg1N1ZIdDJHcWcxeXJO?=
 =?utf-8?B?cVVQMlJEeTVpYytlQmx1UUlKVHc1Y0Z3SFRLcVg4Y283YTNMdnliVFpTRkxz?=
 =?utf-8?B?SWFSTG9YUC82RHdUSkorT2JPWTc2UE9oQm0rU3Y4WWllRVdXQjVOQ3Ard1E2?=
 =?utf-8?B?K3pUalRmaFd0MVFocEgzUGxFZHU3Rnl4cWtSRzJIcDBNV3JrZjA3Si94bGI1?=
 =?utf-8?B?angrOFF3RlNYc1g3b0JHcnBkaVAwVS94b0J2QXM5aEtjWTl5SHZtOVZhVnZR?=
 =?utf-8?B?MVNPdzQ5OG1XcWl6aFZNS0tQa0JzSXpCU0U4aXdpUWhCU05jS1NZTGFjQ1pY?=
 =?utf-8?B?aXJlOEJORTdINFJXekd5NzhybDBUQW93SFFFNUY5azNEcy9RTnZlY1pQdGtI?=
 =?utf-8?B?SXNhUDQrczRtVTM0TGsvVyt0NEZrSTBydHQ2NHdkeng0cnBiMHdFbk5QWlVN?=
 =?utf-8?B?dk1KWS9TWmd6SGkycjQvKzkyVTNsV1RHanN1QmF5Y2JCWGdPM2V5SjNGSU5L?=
 =?utf-8?B?MjFsNUsrQmRtZVhyR0crRlptUUI4b3NwSzNMamIxS0xORUF5bkwwaGpCNkI4?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 622ba5ca-9991-4615-42f4-08dd07e7f2e7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 15:44:55.2338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRZzb5h0PiG+8iI6LCkw26qGc/TuTDeCVtidcvyCcrc1YO3xTAezA8TkO1PobsRUOKH8ErzFaIJlCNAYk6D7tIDpYOBcqCroyUyqxqo83Pc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7175

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add clock definitions for NXP LINFlexD UART bindings.

The LINFlexD driver was working because the LINFlexD clocks were
configured and kept enabled by the downstream bootloader (TF-A [1]
and U-Boot [2]). This is not ideal since LINFlexD Linux driver should
manage its clocks independently and not rely on a previous bootloader
configuration.

[1] https://github.com/nxp-auto-linux/arm-trusted-firmware
[2] https://github.com/nxp-auto-linux/u-boot

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/serial/fsl,s32-linflexuart.yaml     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
index 4171f524a928..ca3146d9b872 100644
--- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
@@ -34,10 +34,24 @@ properties:
   interrupts:
     maxItems: 1
 
+  clocks:
+    items:
+      - description:
+          ipg clock drives the access to the LINFlexD
+          iomapped registers
+      - description: lin is the frequency of the baud clock
+
+  clock-names:
+    items:
+      - const: ipg
+      - const: lin
+
 required:
   - compatible
   - reg
   - interrupts
+  - clocks
+  - clock-names
 
 unevaluatedProperties: false
 
@@ -47,4 +61,6 @@ examples:
         compatible = "fsl,s32v234-linflexuart";
         reg = <0x40053000 0x1000>;
         interrupts = <0 59 4>;
+        clocks = <&clks 132>, <&clks 131>;
+        clock-names = "ipg", "lin";
     };
-- 
2.45.2

