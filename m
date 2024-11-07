Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4D915B0F2;
	Thu,  7 Nov 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730979982; cv=fail; b=BIZcM67GDn41Yz95+YN7XnWJOhcrnLIyB1Bm/WpVkbI1NhovXThGM/GhRzvRkh75FTBYd6uAzS9rx2EYklvb9G4hSr8By9+pWWMv4AtzrHc/tt0DHZoqNx/3c9F2MnmeWOywMJxtTB8ObevUH2ctEEwiQFCuyg0CPFDwwBYZBvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730979982; c=relaxed/simple;
	bh=PtLkWFwqmMKP6+XNTjkkWgxrmF0QOiasGgzDX/h6OnM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=nI4i9lX5akR01hIKLpsF+E8S6f3M65jpYfniwp/iPup8qiJjy4DU9+t3iATEcFnJ7jVhwrS1T4WvBiPEKWemM2YLiyWI5zF1dEOTnHp7dxqXU/cxE1sB6q5IXmViC8J/RWAQgD36BlmJkkowiB/LHIxJ7FLTPHhazoAGjhwuI3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Y7eBBivd; arc=fail smtp.client-ip=40.107.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Y7eBBivd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=moyxr9Hx9N2USDmy2tifi84dtgqoNCDXajkwJSaePJdcF6e9ceCCVkaZz5cKAJByMbxiMTthoOst+bz7ANJHmxR/ow320o8kwcMwrou7P8+XZl87VkZ3EOOHAd+ZwkDjydjdvDtydUQwB5wW5xyJW+xKvxRhufD3/lMu7CN0V3Hhh6o8Tbc0wCNICoRi6QCQPQweHMtJe+R0J+73zj9TyqarZs4cxcDbBrH02V0pET110TNuoSPf22QcW5XgL1wgZCsjc48mVcKfOcOasnv2yW+2KYUbEnN/tHBVp9txzUzDWCjRifTQLf2SPuG1X1O8RtOxj5oKPYly94Dt3Z7dGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qyNWW2hzWfN3mghtzxjEl0om7rFkLqTn7bOJHqAL7yU=;
 b=NIc9KNjwRpZVOaK2sVIHjkF96cWGJPDDKG5Im0p02EcwhWjc2S3iWO1ETIOvffxHf6sOUjPXDYcWy75sF2/Mv6izWdjnC2m6A0QC0lDVOOXjAZ91fooSNkWHatkIpFNzC/4puCzQa/c+QvnvfWrlXsr4TGZBPrWBhHJ9M4DKmurCEEKgCu7J/H/LZTcB/mBplE8YDLAXH49rh4d0NduCaw1YE+qjbKMgD2+HNkYieBRveOOpSEJfMoiPZSCRGaA0delhCxacdc5HKCoKN4CIMF7OeMF4wS46H6M3JFW/FOSyXTTFCf18fN87KFo29nzlIjL6lTmrRrkE8Hv6aBVhYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyNWW2hzWfN3mghtzxjEl0om7rFkLqTn7bOJHqAL7yU=;
 b=Y7eBBivd/f9F4EcunvaBq9v6jceqe+1O8SBdrlkx3Pdu1FxD0BhpudyYOI58I+T0VBGpyeeBihzNVFKnrG54UFDMrBY7sUGynC+KRGp4JTe88ud5ZgDPNL599S3Z8RVgketYI4aHG7vjJG+OqZtKkWHrmtGOtF5Lm06/rL1gBs/pRWMeGqNSWhHY8WU4DbPElEzw2Y9vMZ1gcNM9DHLxwTlKyusTb4k9mBWrIL3EtyhfMsCoAlbTzvhL6rkO14UPoaAx7jfzVlkstm/FOAb1ZIVZDqzwjXtQ7OtP81MFgK6Ga/auht9LUyhQROjA/AyCckumfwX6aMe1wzS1KNYtxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM9PR04MB8762.eurprd04.prod.outlook.com (2603:10a6:20b:409::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 11:46:16 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 11:46:16 +0000
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
	NXP S32 Linux Team <s32@nxp.com>,
	imx@lists.linux.dev,
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v3 0/2] add NXP LINFlexD UART clock support for S32G2/S32G3
Date: Thu,  7 Nov 2024 13:46:09 +0200
Message-ID: <20241107114611.758433-1-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0120.eurprd04.prod.outlook.com
 (2603:10a6:208:55::25) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AM9PR04MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 7926d866-68f9-4372-8107-08dcff21c968
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnpoMCs3d2dFZjFZVHc0YzJuN3BteHdvM3FQOXdEY0o2MTlHRG9jUmhhUnlO?=
 =?utf-8?B?QlVjNU1aYmpaUFE1OFQxWWtINjhGcVVMd3hvem1uNkI1S3J2VFJObFFvdE9N?=
 =?utf-8?B?L3ozZnFydFNzS2IrR0theWhpVzBVODdrb3ptMkY0SU9BMWRCRktoQldXK3RT?=
 =?utf-8?B?N3VYKzkyL0VFeGI4eXhlZHRaUDJ1bURzRkQ3d25SeGRUY1RBYzhoa3p2M3do?=
 =?utf-8?B?SkhqTEp3cHduRVNzRm5Sd2hVSjFXWnBPUGhlOG1YSXp4OTN2QUpKTlJ4Ully?=
 =?utf-8?B?M2tyVnpuTUZYTnRqUFRsZjV3ZU82SVd5SUJaU2t3ek95UVdKUUlQMkF2WlVL?=
 =?utf-8?B?ZXV4eituUXMxZzZSbnU0eXA3K3BLOUp0aWg0WXRXcWpvclBQWkRDY1J2NkQ4?=
 =?utf-8?B?YWxETDNBZDZnc2Q1a2pwaVlHN1BSN1JLd1g0WXpjd2lWU0RxNVRjTCtwbmdm?=
 =?utf-8?B?R2x0WUFMUTlYNDNqcm5UQ090eXFrTThIczJHQkxhRHBwczVYNUN0ZW1ncWFC?=
 =?utf-8?B?aGtBcVdqcVlFVjJpWERQKzJUWCtIK1pBY25QUGY2dVQxWmVsNUVmTXJmM3FP?=
 =?utf-8?B?TGFTZnowTW9leUFGV1E1dWQ2bDcweFZwSzRnTjFZOVpJNkNOS1RVMW9HY0Zx?=
 =?utf-8?B?S2tqU1lEeTFGRktsUFhEYmlYSTB2UXF1R1Z6QnA5V1JOT0FIZWw3QkdobHdT?=
 =?utf-8?B?M3ZZYjc4Q0puRTkvaFNQbHAxR21PL0V2VWFpMzVxVjZvZDNPdzJueDEzMFpE?=
 =?utf-8?B?elMrTnpLTE5lT0ZWb2pIU2xSdkUrVElYU3dLNlkyc3ZoZktaNzVEU2YyUWxF?=
 =?utf-8?B?L2NUUkpCbDFHMjZYTUF2bTBFKzFiL3ZLaHJGZG1OR1k4aHdtMkhDQ1dTSitr?=
 =?utf-8?B?clZMM2xpYUtaVmNVKytsVXNpOGkzS0kzZzBOVEtMVUlUNnNYV3kvWVN1R3dF?=
 =?utf-8?B?YlZqeE43MTR2SjN6NkJvZXJTNnF6SnNUdUpSRE9OYXRqaEE3R3R0ZGtoaTRm?=
 =?utf-8?B?blF3TUgrRXV0U09KTWtLRW92R0F5Wk5EZFJFMnpvODBTSDU5YlJiOVhSQlZK?=
 =?utf-8?B?LzcwcmlVaDdNdElLand3Mm5TZVlhVXEwYkVWL0hYaEk4RlFzQUhlSldsTUR5?=
 =?utf-8?B?QklKTjEwckNOOVdYZzljdFJvejdQN1M3ODdBZlpKL3hEYVRDRUlJNnhPM3lP?=
 =?utf-8?B?cThpNEI2YUpJT1JmN0w4d08rWHFHVE9nMWtMbllvSko0WCt6dzFFSGU2dG9Q?=
 =?utf-8?B?UWZPL3pRS2VDK1dvWVJuVk03YXNEWGpnMExHUy9zVGpzRlFidWZjV3BzSFlP?=
 =?utf-8?B?amFmbXVlT3dhaVlqQkY2QVRDS3E5Zy9xM013OGpvODFnbXVERllLTHp1V0RH?=
 =?utf-8?B?V2M1NEl3MGxnbmpZdXMzZ1dpL3N3b29XNDlQblVEZDVtd2Y4cElEMXNZY1BO?=
 =?utf-8?B?VnpjY3BuUEtHaHpMcVZhTGlYTXZHY1Z0M0wzak5VcTdLQ3V4OU1Ec2RKZEE1?=
 =?utf-8?B?TzdVN0t5Myt3NFozek8waE9qK1prVkk5bVIvSzYrbFQ2bVpyZm5OTFNTSEEx?=
 =?utf-8?B?d09JY1dLSm1WeTVvYWR1RXhidXU3d29XSmhBTXZ4OXBoMTgzMzMzQWpZalM5?=
 =?utf-8?B?amRDVXhlNlh4OXgyVkMwRHBxdmVJSWk1TDFMZEJaWG4xMmtZaWV1endqN0NO?=
 =?utf-8?B?OHdKSnN0OEcrRjRyVjFBMFR0QzVvY1VmWDdEc2dQVzhKak5NR2gyUjYveEhS?=
 =?utf-8?Q?HqDC9e4N9VemZB/n3Wd95P78W/2Kz4yKk7uF3xs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDE1U0RSVkNCbVVEMWZTZUFGVlk1MExrNEoxenpYVCtTdHNtV1llOHo5U3Z4?=
 =?utf-8?B?cDNnRVZYSUhINGtYa1FrMFlyb004anRWZzczK0MwaFNXVVU0WnlKNDVZMXMx?=
 =?utf-8?B?VDY4dk9ucERtWGZwbDB5UUVHVEZlOEVXcnk0UUQ2WnBJL3RZRkI2RUc2bndK?=
 =?utf-8?B?c2s5TmNXVXQrMkRSTXJHWHMzZXRjK2NBbTY0MWxTL1RESHppKzlRcEk0V1R3?=
 =?utf-8?B?VThnejNZWVgvMU9XNXRkK1VmaGtRbWp1WW9Ua1p6eEdZY2h0MUxXUHJsNzJK?=
 =?utf-8?B?SHdDNWMrUXIrSDNhVnk2djU4RkFXUUdDK2l3TDBzNG00TWszakhlOFVVOXow?=
 =?utf-8?B?OFM5cVFJTmJLb0dsZ1pyc29DSmxLUTI1bFVJcUdFNkFuNTRpR3ROZHluUWlq?=
 =?utf-8?B?bFNldDJ2OUNwRkh4ZHkrWkJ4L0ZjMVM3dXJ1cTJ4NzhEaGxSRFdaMlZsTDBl?=
 =?utf-8?B?dXJnTjh4cE1WSkZSL3dXTGgzWDFJbGR4a0FtbW45N0hpRHAzQy9VeVNrU0dM?=
 =?utf-8?B?bENlckxkc28yTkM4MUJ4dmdKRmZOOFR0dU5ZWGZFaG9GWHNGMHlMZDMyVVU4?=
 =?utf-8?B?TVJyR05HaUowRFNDVVU4OENGeTlTVzFHTXJpTURYb25PT1BqMVMxU2F2RnFL?=
 =?utf-8?B?Tms0SjJyWXpPVEtrRmJEWDJZbmlzNGl5a0JYdkVXYnR4akxZMWZ1bGJWdXF4?=
 =?utf-8?B?MVN5ZVMraFBCOHUxT3FmM1VoV3hQblg2bTZFMzgybWhydmlrbjZ3aFltSitj?=
 =?utf-8?B?M1cwZGpTUFlOekNSNHk3ayt4dHphMmdualVPeVZLNHNGZ1RZd2d6OEk0NC9T?=
 =?utf-8?B?dkVoM3JyWVZZT09DTHQwUEl2Y1NzazNSK3hITytSVmp3VXV2VHhyYkZRTG5B?=
 =?utf-8?B?MlFzOC9RcW9jL1FISjJXR2dDK1lwdTg3aDRQS2pQb3EyWGtma1lkRmxuQW1N?=
 =?utf-8?B?djEwN0N2akNmREk4UldzVlNDMnk3dFdGU3ZhOERQWUY3SHpJeTNWVi9uQlcw?=
 =?utf-8?B?eW5JbHhBdG56NXBtOUVzVW91Y0NXRngyNUxFcW5JN3h5K04rTUJUN2ROVkFp?=
 =?utf-8?B?R3VPWUE1QVhWejZsWk9KejNGcUt6NWgrT1V3a3dYaEhxRmFsS2U1UDNiZW9h?=
 =?utf-8?B?My9vcElyN3AvdTZxcWFVUWdlWTQvREpLQjFGc3VlTGhmbVJaNzRqaEhjSGhv?=
 =?utf-8?B?MjhXc29ZNTRyTHpCVTgxRy9ZTk1PcUJXRDVXczRrOVNQRG4xMytjeSszRCtO?=
 =?utf-8?B?b0hnTmhkVG5UVUxMSVIzMC9nNUdCL3FnL1RMNXZJSVdGWTlEZ01uTW1kTlhp?=
 =?utf-8?B?Tm9wTjNHeEJxZFdMeDJFbmd5a28xNXhoUUNZOHk0US95SzUzcjNtelV3Mnhx?=
 =?utf-8?B?YkdGbWQ4RFBKSzZIcnNtTlcrRVQrL3N5b1ZtVHV5VXRlU01Kb2R1MzZhWG9Q?=
 =?utf-8?B?L0lsTFBkU2F2OHMzaGM4bmpkdlpKci9OdkYrd3BhU0RzUXd0c0l4UFJSVU96?=
 =?utf-8?B?WlNsMStPL3VMU2c5OXpaUGE0TE0xVkxXY0pldjZXL3NOak41aUhzRm44TWMx?=
 =?utf-8?B?UFYwZm0vZ1FOcElra01iTE45R29TMVZ0dFF1bTRXemdQMHhFZVYrNVc4dXVY?=
 =?utf-8?B?ODRrdytFWkRVUVRReW9NNUs5YzdQRmZ2MVZ3OExadkowc1ZZQW9mWTJXc0NI?=
 =?utf-8?B?TlNvazNyK1hkMVBrU1pmbkV5QUNzaDN5WlFxVFE3M01wSmorNWNFaG5ZSnFq?=
 =?utf-8?B?RnJTVU1sVTU0cTg1YkU5ejRQdVBXT2FMcXlPeHhkNm8ycjhjbDdIODY3SFRl?=
 =?utf-8?B?dHlEUmlqV0dBMk5TcGhZMHJySGZMVGx6c2FQa1hwK1NSTlpCTTZ1dDF6SlQ4?=
 =?utf-8?B?amdFTFdMUmlaL3BjbG9xa1lqaTZjSFEySE1DZ2p6UHdDdG5JcW9BQTVRYVk1?=
 =?utf-8?B?c0JCNlg3NWtCakd6NXNITngwd1kzc1Zvc0dLbnZYWnR3WGhnY1FjbUcvcksy?=
 =?utf-8?B?M2x6VWU1YzVnVVdiNUJpSGVqK1kwTkRzS3NPeGF2S1o2L29LTmF4TWZjUFZk?=
 =?utf-8?B?NEI5Y3lPa3NPUDE3aG80LytITlB1KzhMSDNjYkYrTHVPeGk0d3BNaFduTWwz?=
 =?utf-8?B?UkF4aDRvalU0TkZSVU1Qd1BGMkQraHRUazBCWWhqYnZzK1lGbDBNU0xsTFVC?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7926d866-68f9-4372-8107-08dcff21c968
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 11:46:15.9985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1a86mEAg6GGnML1XZwuWADBi5V90AbVxrk8jf05Y7EC/2QFra+B+OvDZZ+2rrMONI1pWA0+2WfRfDfeQ4o0hpuX7mG5hDrGdnGgBsxGlnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8762

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

LINFlexD UART driver is used by S32 SoC family.
Add clocking support as optional in order to not break
existing support for S32V234 SoC.

A separate patch adding clock definitions to
the S32G2/S32G3 based boards devicetree will be sent
for review.

Changes in V3:
- Fixed an error reported by 'dt_bindings_check'

Changes in V2:
- Updated bindings by adding more information related to
required LINFlexD clocks

Ciprian Marian Costea (2):
  dt-bindings: linflexuart: add clock definitions
  serial: fsl_linflexuart: add clock support

 .../bindings/serial/fsl,s32-linflexuart.yaml  | 29 ++++++++
 drivers/tty/serial/fsl_linflexuart.c          | 67 ++++++++++++++-----
 2 files changed, 80 insertions(+), 16 deletions(-)

-- 
2.45.2

