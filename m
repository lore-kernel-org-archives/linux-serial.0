Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87371BC09A;
	Mon, 18 Nov 2024 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731944703; cv=fail; b=epm8dqOYJsYFg0t3BBIC4hxizP3hAq77vNZpjgaYJGatmnFxEGd8bDW4TlNop+BHxZElMgn0dsIUtyAMwDS4k8vxtPga25mrIHz9nWQ6ndKVvkT5cs1wMw3A0p54G0TbDZQD9emhG9ObrMLWIAaJH5a7ffqqAEvoDMGRiXJci+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731944703; c=relaxed/simple;
	bh=xB3YnWOPMf7vBRSv0QPmdkNaDPxOw1qbqN/0Mjto6e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C1A9NphXMNP983ijdT/G6eSfCklF7zxB10mq9Gza963xapu/aQP2urkCh9XnrICbsbCi7lOKU2TPstMgBUI/Yd+28zGexmy57+UmSfmydD1MWRa/qItb2xkRZsNInWKdyoL9l+pcN6o3GOevQbQtJP8nj4nwY/vzJufM/gZ2DqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=tWycAWsb; arc=fail smtp.client-ip=40.107.20.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="tWycAWsb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGgs1que/YFM7ao053+l6CZXUKGSoDPJGEHn/W5IATEQAOOOzmY3QStOdF89yOruXfHij7MlepucFvCNUux5OE4UzEWHCr7MNdkDBRvML41y/Vx07PxOWvSVoKzglv3JG/J6fUZO56YkjuT2r7xYYkdqVMggQ0vSkslFB7zPjOn7vpsXo9WZpxSKgl3vxdBj4WKI6zIxRlNk+d4ChP0gd/LidV1HFzKdniiOSYUuG2qqdKicL+gDcsXuipLKWdhEzWYW0sL/P6Ox9PG2cD4bDM5wBWeQhzbhDIbd4p9F3lWwijenmWKX4eRlZIb0Tcx1yRE0HIBB65YWteqq9gm5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qz6tK5jtgpStWq0dqpcnv7/5+iLJYfbGydSFQ++J7Dk=;
 b=gndISZECZQcz9Lf3ssboZ1GPS5z00W2BIW1Z3bNQfxx00LI8NXYVOomUvZl/PPOcyGyJlAk4aJGap6QRslE+qMGUKW4yOLGlLNjTepTLxOkBNde8DSyI7MzYrxSj1ULQxTNV31ClPkLZ59ryVGxEb5BwZOXXFjCDPiceumgx5eY1oqIDHC6yTwk8cifRkkR/SDj6BCpsZwBreTbo5JdT6I2coBHaDETUScJfvaJupN1CcuRz/d4sQypf+jxobLAIWNwzidGEuuu92YhyAUzMf2cXF/8vWGAdZK82IxElNMGuEfJe53Bsr9oct88WIdNS1LZlhiterVfzDE5uEjQc+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qz6tK5jtgpStWq0dqpcnv7/5+iLJYfbGydSFQ++J7Dk=;
 b=tWycAWsbVpU6s/3ebxbZ0dsW0oIvFKYYKQh/bwxgslBG31ySVK41po40/PZK+A5cVVH4OYAJMp0InPXPQT9C664qZ9BJEMg1BMy+6Bo3wa15+vp65OeCdvaQbbWuyj5O0VLEFk5tsEOKmu0462uaEnFMSytgXMq5xpmQviQTYJcrxMcGPPnGhJS0MNZjIu1FPh8MbF0jH0GKVOnkFiupb7u4kizElNBMXdXpwLp6SEXLgwnBVcKmOOxMQo74krdCf1frW39+nbWpuZQZRYGKqnMsyQgDcEhbZ8JqsiybRL9Dy0Ef5HD+jg7jJeN65hkt0zsolwHqjj0YbhLVHWE6mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AM7PR04MB7175.eurprd04.prod.outlook.com (2603:10a6:20b:111::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 15:44:57 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%6]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 15:44:57 +0000
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
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v5 2/2] serial: fsl_linflexuart: add clock management
Date: Mon, 18 Nov 2024 17:44:48 +0200
Message-ID: <20241118154449.3895692-3-ciprianmarian.costea@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: a65347ee-cc41-4325-dd79-08dd07e7f405
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1ZUc2llWVkzaGNZNUduVHVFUWY0M3dsTzNpc2xVdkdjUVFKakptYTFyRGhq?=
 =?utf-8?B?dDJ5T1YrZ0dTM3lSNXAwL0lCODdkSXZuQ1poK3NML1V1SWZyQ2tYNlFxcDla?=
 =?utf-8?B?ZENPUzBmVHc0cjNXMWthUTBucytnUnprKy9URmJHTUpzSkdCYVh1UFFud2h3?=
 =?utf-8?B?RWJEZ0FpSUxJSnRMU2t1T04wRnl1WU4xNFRZc1UvNFdJU2d3NExYaVBXckY3?=
 =?utf-8?B?RndBRDEzRnlKQnluZXpNNDVRSTFoU01xb3pnbHdWQTNUb1kzUDdZQ0dXRGJr?=
 =?utf-8?B?NHpJNEJuT1p1cU5iWnNhRXhMMDVTNEtiT09SWEpmT1BSdGMxaEkxcTMrSWFn?=
 =?utf-8?B?c2M2enU5Qk5abiswOEpZQmlLV1ZlR3lzTHNVYndtYnY4ZkdoQzJYa2ZCZENT?=
 =?utf-8?B?cWNKbnp4QW5sUzUyOUltU1ZReTlmQUhpSkdEcFFSUlhLRDdWa21nam50VkxY?=
 =?utf-8?B?UzlSbFhoRkx5ZkFRSDF0MXAyZ1ExakQvN1lQRkZkYVpwcVRkcGJXcVd0VnpN?=
 =?utf-8?B?VklMcGlydi8vMkxXb2dldzd3U1dIdEx6SXh4Q3BlblJaTG9TSXQ0VkhBbytE?=
 =?utf-8?B?MXJQVVFoZXJnU3I5NzVyOFV4M25CS09EajlBa3g2aFdKeDRMMENxUHNJb3Mr?=
 =?utf-8?B?SmRrb1g2UEY4VlprcXdja2pLRUs4dzJpNkdBcE1iNnBzdzBmU0dYQUlKemt0?=
 =?utf-8?B?TzQzZjhucHpmOGQrWFlOQWU1cVpPVk51NjhmZit2ZTRzYUNTS2NiSkkzdGls?=
 =?utf-8?B?RkNpYnhmeTZNMFBBaHVDTlpDUWJaUkZac2RqNVI3K25aNHVFcUx3ZHRHYUNt?=
 =?utf-8?B?djd1cGsrdDJ6NksvSUFtMnVDaW1tSU9Sb05SbEFVT3Z0TDlpQXdsZWpHTFl0?=
 =?utf-8?B?eUI5VHNvV3FSQStYMkNlTVp6cGZEL2xuczBGVkFrMmhMNkpTTk9FVjRZZk9t?=
 =?utf-8?B?Z3ZrT0lidS9BaitKT3JNQWtBVDZUZitmUGpzM1orNmM0REFGS1RyZVhTNysy?=
 =?utf-8?B?Tm12R1MyOEhMdGZ4cmxGVXh4bDZMUERBVEdSZ0pJWjdPY0huK0tvUzUzZjFx?=
 =?utf-8?B?dVh6K3EzSXgxOGpZOG5JUzdESzRvTXVQcklCNkphcDJrZm1XYXdqN1JBK3BM?=
 =?utf-8?B?amd3RThjd0J2cWo5WGZDTDYzTnhHSm9BR1J3UUxUSytOK3RHeGcxWTdRU2pa?=
 =?utf-8?B?QUVlTHR2VmtJa1lQbXNta0MvOExCemQ5WDdYaEF1MHlTSVhpWmIwbjV5TjR1?=
 =?utf-8?B?bmVHTXhFL3Jqb2tNclFZdmFPSzUvL3UwMU53amFpYlNRd3lnaXBtQXNjN05F?=
 =?utf-8?B?b21TQ1VSclpCVUVvWWZDTytYbjRlMnN2a0VFVEpkbTlxRzBUYXhLYnNiRnZU?=
 =?utf-8?B?QUh3WmE5ZzM4OEkvdnc5ZUtFdjB1VDlMcTY1TjNQYWhrS2RPQTZEZ3Q5VHho?=
 =?utf-8?B?U0pRaWo5MklOQjAyT1VEeWNpVHQ5SUxINk5zNnZOcE9TQllKTmlyenNvMlBj?=
 =?utf-8?B?VDhoLzU1RVlLcXZ2YjJjSDBkNlBad3JKZmJ5MWliNm55N2VNbkMwZ0lqWjR1?=
 =?utf-8?B?MERvSXFoYnJhQVdaYVNoK0NUVnBXY1U4SWhBRUkrdWVOZStaUm9JVlZVK2RD?=
 =?utf-8?B?MUpiQXk1cDBCOFlyd25OWW55c1o2ZTRJTnQrazZZWE1uTllWOTJMb2JnU2tO?=
 =?utf-8?B?NDVTOGE5QzMzVVU5c3NVRXNuS2JxcHUza2t0c1VjNi8yaWFpZ3h4aWFYVFBw?=
 =?utf-8?Q?4EYsjpGboHTY7Tzy/y6VJtiaOZOZVwiNX873oLN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXE1REZFd2FJMEk5RnA5YzZjaHJkdjVxOU12R0xnVTArcGh3NE1wZ0NmOGJU?=
 =?utf-8?B?NU4wdHJwMExWQW96VHdVWGsvemtNWjJCLytlK2tXRU9IdFJDTDdGU3VqamlC?=
 =?utf-8?B?Y3JnN3dzQW5UQVNFYSttZnFYNjNEa0tFUkJYZXBuQlVCelhOVzJTWlF4Ri80?=
 =?utf-8?B?MnV3dXJGaHJHU1l5TFF5VUFqS2hIc2JjOWFRNGpWMk9XRHJCYk01d1lBUHVl?=
 =?utf-8?B?UCtDMTl5KzMzN3lUU3lsdERWWG5DbmdXek5rY2VQRzAyclZIdlhFbE5nZGlp?=
 =?utf-8?B?ZU9LbVl3WXZlRmRSZC9UclJBaHNYL1pEM2VRRnlmRHk0U29EYnJRdUxrTEtm?=
 =?utf-8?B?ckNnUklxY3R3VzE4VUZ6RWRXY0FSMHZVdE5MMWJrVElYVkYzL1ZJamkwTVpZ?=
 =?utf-8?B?TjVjaEVDZm1JT1BsMkhRM3djM2xrMWtLdVNZbEhWd2thbTVBSXpkeGJZblhv?=
 =?utf-8?B?NXRGdWZla05DR01XM0kzN2w0OUQxYmZBY1M4bW5sdERoOVgvbyt4dUZvcjBX?=
 =?utf-8?B?NlF0TFRYVWxRVzFta1hXQVZtRjBWNjVsRWxZV3VtUmVkanl2dGJiVlJTOWV6?=
 =?utf-8?B?NWxEMFhMZW9WRXBnc3A3aXAvZ3pJbmxNdHp3Y1lBTnQwN0UxdjlPSGViZHVr?=
 =?utf-8?B?MWw3RTkxNnk4MGo4S1ZJOTFYWmtwZjltTUlZRHhrOUhSQlpuYWRNY3hDTVdD?=
 =?utf-8?B?VHdzNnJ5clp4VTU5bmh5amsvWEtWaUU1NlJXLzh5ZUl4a0lqNC8zcXZlWlJO?=
 =?utf-8?B?KzBiTktvbnc2OXBKakZpWWtsMysxTDEvelc1TVNNWnZzdzY2SWZCRkpvdzBX?=
 =?utf-8?B?Yi83WkY4cVY3M1ptSXBaQTV0NEFWVndwb1F2UG9oaEtXRUdRdENxWFV3YWgr?=
 =?utf-8?B?anB5RVFBZmplYjdqd0haZ1JWQWh6aDVaZE9TYU8yR3FYM2xkck9GNkVGSEpD?=
 =?utf-8?B?ZklwenFRTkFhQlJzWGZYMHFCenNnNTZDaWZiOWIzbHY1aUdvYXhLbGhiNnN4?=
 =?utf-8?B?b0FqblBna0ZKV1ZxeEVtOVo3ejl6V3BVM2lYc3hUVjFEdHBDNldPejNveWVu?=
 =?utf-8?B?WjFmUlhTMlJuRUFPK3FCamhBZU9BYjZEb0RtVTFJblNybE81NjdEVm0yL28y?=
 =?utf-8?B?Sm5OeVQ0Z2pqc2lHbnNzRTRtbEJQMHIzY2pZeXJtYlZoanBuN2VYQjBrMmVU?=
 =?utf-8?B?bXJzOXZlRkdxbkthRDBEZnY3MjNGZEF6eDJaOGdSSkJNMjdxQ0s0a0dGcndD?=
 =?utf-8?B?OFpkdExiVkVWSlVVa3pSYmVBNkFGQ1JOeGo1Nm04TnVYVko5TVJpMEYyVHJk?=
 =?utf-8?B?NU9kYTg5WkRLcXYxSVpSaGM0SUZpdEZTRlZhVFJLSkREMVJWTS9NT0tWbTNI?=
 =?utf-8?B?NFpLdi9NaW9wb2xsZVk0NUxxSm9VYS9ndFhJaG5WRHVkUkRGc09tNG43MUpi?=
 =?utf-8?B?MGRBalM0Lzc2WUlMaG14S01rckNZMFEzYWJYZ1QyQytyN2xBUlBxQjI0b2wx?=
 =?utf-8?B?V055NnVLUmtXTzhtOGM2QktaL0VlL01lSUx6bFcvRjRXZHZhWHRFbjZnUFlG?=
 =?utf-8?B?bUpFZjRvYXpFTG1Tekc2N2pyU0F0Si96bll2SW96b1IrcFJaSDkzU280NmYv?=
 =?utf-8?B?bVZJNFdXZThEUk51c1JGRlpONWt6TkxaT0pjRmJLNFFEbm9mZjRXN3lJTitF?=
 =?utf-8?B?TThlelU5cXE2VmNNRGZjUWs4bzBTYWN0YWp1dW1kNkZ0dHloNk9wNnRkM04v?=
 =?utf-8?B?Sks4ek8vWEltYlJhM3YvQW9ZUmlEWExSWnJtenJCaGJzamkrTStsNXV3MXZ4?=
 =?utf-8?B?TzhwR1pGTDRidEExZWZxeFlTcjdCdkc3RytwZmZPSnFIWWdQS3BJdFFOZCs2?=
 =?utf-8?B?VTBSUEQ5SnJaOTlXYjM2YnZkVExKQ0xOSmJwYWVWVEVkQUN3emk3dGJvd2R4?=
 =?utf-8?B?MWh3b1AwOWk2ZCthOHpnVFdhZnJuN2lCSlpLWVRlZE0yWlBuVUVTSG5FcmFn?=
 =?utf-8?B?TU52amlHVnJVOGp1ZmZQaXVEY3c5QVhJVzdXVFhrODBEVE1uNWlLN0lJdHBa?=
 =?utf-8?B?aWJvOUlxYWVERmRiTitGTXhMNjRtcDdpMnNlQkNaTlZzYzMrRDNHOFFaVGN5?=
 =?utf-8?B?VUxDSlFwT2hQWEdHbEZ6a0puRHVqZ21mNzJ0U1FWY3JsbFdtaTUxNzh6YTQ3?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a65347ee-cc41-4325-dd79-08dd07e7f405
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 15:44:57.0707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jjHugFCj7eGCMbZAZPsx1Hv0GM5b8hpO42wr3KvvDL92EjY+gMQqc6axPt9AHFv1Bqh2fuSlGF3WrtfIRDDHgJkc4RLzbaUU6JmJdS3sUgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7175

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add optional clock 'ipg' and 'lin' support to NXP LINFlexD UART driver,
which is used by S32G2 and S32G3 SoCs.

LINFlex driver should perform clock management and not rely on a previous
bootloader configuration.

Clocking support is added as optional in order to not break existing
support for S32V234 SoC. Therefore, there should be no impact if not
providing LINFlexD clocks and continue to rely on a bootloader clock
configuration and enablement.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 drivers/tty/serial/fsl_linflexuart.c | 95 ++++++++++++++++++++++++----
 1 file changed, 81 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index e972df4b188d..394c2f66d4a2 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -3,9 +3,10 @@
  * Freescale LINFlexD UART serial port driver
  *
  * Copyright 2012-2016 Freescale Semiconductor, Inc.
- * Copyright 2017-2019 NXP
+ * Copyright 2017-2019, 2024 NXP
  */
 
+#include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -120,9 +121,29 @@
 
 #define PREINIT_DELAY			2000 /* us */
 
+struct linflex_devtype_data {
+	const char * const *clks_names;
+	int n_clks;
+};
+
+struct linflex_port {
+	struct uart_port port;
+	struct clk_bulk_data *clks;
+	const struct linflex_devtype_data *devtype_data;
+};
+
+static const char * const s32v234_clk_names[] = {
+	"ipg", "lin",
+};
+
+static const struct linflex_devtype_data s32v234_data = {
+	.clks_names = s32v234_clk_names,
+	.n_clks = ARRAY_SIZE(s32v234_clk_names),
+};
+
 static const struct of_device_id linflex_dt_ids[] = {
 	{
-		.compatible = "fsl,s32v234-linflexuart",
+		.compatible = "fsl,s32v234-linflexuart", .data = &s32v234_data,
 	},
 	{ /* sentinel */ }
 };
@@ -776,6 +797,14 @@ static void linflex_earlycon_write(struct console *con, const char *s,
 	uart_console_write(&dev->port, s, n, linflex_earlycon_putchar);
 }
 
+static void linflex_disable_clks(void *data)
+{
+	struct linflex_port *lfport = data;
+
+	clk_bulk_disable_unprepare(lfport->devtype_data->n_clks,
+				   lfport->clks);
+}
+
 static int __init linflex_early_console_setup(struct earlycon_device *device,
 					      const char *options)
 {
@@ -807,12 +836,13 @@ static struct uart_driver linflex_reg = {
 static int linflex_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct linflex_port *lfport;
 	struct uart_port *sport;
 	struct resource *res;
-	int ret;
+	int i, ret;
 
-	sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
-	if (!sport)
+	lfport = devm_kzalloc(&pdev->dev, sizeof(*lfport), GFP_KERNEL);
+	if (!lfport)
 		return -ENOMEM;
 
 	ret = of_alias_get_id(np, "serial");
@@ -826,8 +856,14 @@ static int linflex_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	sport = &lfport->port;
 	sport->line = ret;
 
+	lfport->devtype_data = of_device_get_match_data(&pdev->dev);
+	if (!lfport->devtype_data)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				"Failed to get linflexuart driver data\n");
+
 	sport->membase = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(sport->membase))
 		return PTR_ERR(sport->membase);
@@ -844,37 +880,68 @@ static int linflex_probe(struct platform_device *pdev)
 	sport->flags = UPF_BOOT_AUTOCONF;
 	sport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE);
 
-	linflex_ports[sport->line] = sport;
+	lfport->clks = devm_kmalloc_array(&pdev->dev, lfport->devtype_data->n_clks,
+					  sizeof(*lfport->clks), GFP_KERNEL);
+	if (!lfport->clks)
+		return -ENOMEM;
+
+	for (i = 0; i < lfport->devtype_data->n_clks; i++)
+		lfport->clks[i].id = lfport->devtype_data->clks_names[i];
+
+	ret = devm_clk_bulk_get_optional(&pdev->dev,
+					 lfport->devtype_data->n_clks, lfport->clks);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				"Failed to get linflexuart clocks\n");
 
-	platform_set_drvdata(pdev, sport);
+	ret = clk_bulk_prepare_enable(lfport->devtype_data->n_clks,
+				      lfport->clks);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				"Failed to enable linflexuart clocks\n");
+
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       linflex_disable_clks, lfport);
+	if (ret)
+		return ret;
+
+	linflex_ports[sport->line] = sport;
+	platform_set_drvdata(pdev, lfport);
 
 	return uart_add_one_port(&linflex_reg, sport);
 }
 
 static void linflex_remove(struct platform_device *pdev)
 {
-	struct uart_port *sport = platform_get_drvdata(pdev);
+	struct linflex_port *lfport = platform_get_drvdata(pdev);
 
-	uart_remove_one_port(&linflex_reg, sport);
+	uart_remove_one_port(&linflex_reg, &lfport->port);
 }
 
 #ifdef CONFIG_PM_SLEEP
 static int linflex_suspend(struct device *dev)
 {
-	struct uart_port *sport = dev_get_drvdata(dev);
+	struct linflex_port *lfport = dev_get_drvdata(dev);
 
-	uart_suspend_port(&linflex_reg, sport);
+	uart_suspend_port(&linflex_reg, &lfport->port);
+
+	clk_bulk_disable_unprepare(lfport->devtype_data->n_clks,
+				   lfport->clks);
 
 	return 0;
 }
 
 static int linflex_resume(struct device *dev)
 {
-	struct uart_port *sport = dev_get_drvdata(dev);
+	struct linflex_port *lfport = dev_get_drvdata(dev);
+	int ret;
 
-	uart_resume_port(&linflex_reg, sport);
+	ret = clk_bulk_prepare_enable(lfport->devtype_data->n_clks,
+				      lfport->clks);
+	if (ret)
+		return ret;
 
-	return 0;
+	return uart_resume_port(&linflex_reg, &lfport->port);
 }
 #endif
 
-- 
2.45.2

