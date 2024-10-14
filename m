Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2076.outbound.protection.outlook.com [40.107.20.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497201AA797;
	Mon, 14 Oct 2024 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917114; cv=fail; b=Oe5SHvLTXoBt108JHFj8gy1IjbEptFFKQX464gq0YPMBc/I2yr2c8qzqssH2hkJ4YH3vILhGLsCvRfy3HRhU+rE98pkFe3bxWdRbLBuIfaYi5ZbNT8KnDKfU/OeOU1rP9yc/+LFjfiHMhbzxlLoVsbInKWx0rrOkJWUtc3tMYc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917114; c=relaxed/simple;
	bh=4w6PO35DMimRhNwszjrRtDMyeUDniXGpwxZ9q7hny78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=crtLJIKpbr4j0qLqx3MaT41fcnqqFYTdh1fCFK9yTFJoavrgKAw1mGhITcV9fMvTCuRx3ooGOwiqKG+ZDcy8G0bxEUpAkY9ib9zIJ7lPTMriBAVD+XH+0fh3/wAeph7hFPDeIXIQrLpoWm8GlJESdDR3k34N0WKeKVAFHV0FI88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=cqrj8XKn; arc=fail smtp.client-ip=40.107.20.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cqrj8XKn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJ+M20FWtRdyyiVC1PGe1IziunG5xTueWgAoMHMz9eyjoIGy1B3WpwfvyjAdMIv4yi96vh3Ikt/ZffTMC10QmCp8Ci+DHWx7zpRjeikT1arBu4Oc/zFb1Shw1gB849ArNbNx0yvZuBBrXmGE/2pjmS69gBFjzbCxZZ0txK+0Gxt7JgJe5xIS8sMpN1YAZkJADhKRlo4TjZBNyNtfm04a11U9Oatlhnzl+gWWqvDGWomb+NE5T/WLj7qog+uYceWFIBwz2GmNplizuiHjUJpXyazAeVbnM/F6PRu9qsci+aRojAusYgFkvmdnytnfkTxxz+j9v3HTvzK4lL+/JgaFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89Wqi+Wi58q90XXcq7RFwUL8NRFn2moNyrqZl9vyiL8=;
 b=aBvA8VyC3Dd8Lk9WPftr/qXZXy/1ahw8HY2TpJOxgpZ/JMT4EW5uNYWDC9X4AXwZ2HQJhRvZwFJZ56i3l9d5A7pltE3szrEYDDXHEw8M5VOq/1CnrGnewd2nLIR4AfERYzqEkYhRXoT43WoEXP3YuHShisGz9xCjWE4CYS+PGeErmo9GHtS/oa+Cxtik/lhVDWU8RIreOEm38QLWzYmq6cLYbM90gc3UQ+zKitVrJtyMbtdXJjXrTCAynGD4ZmZEf0lfh7yq+RJuZ4F4TR5C2ALDQBL96rTq32h9Nh8dInmWLyyxF6eWkGQMSLUjnmwd7IY4n2W4UqMVtjj9qLUxww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89Wqi+Wi58q90XXcq7RFwUL8NRFn2moNyrqZl9vyiL8=;
 b=cqrj8XKnjHNjqPJ3Wp3zsnNPddolqV/K7vkUk6gVgcrm8RQm3zsbg/2XCoDc2R5xRqVIjU1H8qK2/8mW5p4qskur6S4i8ldOhyOVr4rBJPABPjhtCRGQe47kzgKzAHOO1ScYroOqln5v1uqL3Un7f8b5WXTp7O2OdbjPLCFe6RlZLqmr3SOf5PzQhQnXI3O/XU58OV4K/M7iCHHr0sphVmUdaZYJkzT0J28ehbyH4h8uibzLdLbsmGfvrKhfPQ12zrY/UUObyX9v6bh2noDxSMkyCHOOG+cKWt9dFDLGQfH82300n9Yj2nLKbuQe5WQX7oD8HanA204Z1walmIuT7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by GV1PR04MB10275.eurprd04.prod.outlook.com (2603:10a6:150:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 14:45:07 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%5]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 14:45:07 +0000
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
	Christophe Lizzi <clizzi@redhat.com>,
	Alberto Ruiz <aruizrui@redhat.com>,
	Enric Balletbo <eballetb@redhat.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Subject: [PATCH v2 1/2] dt-bindings: linflexuart: add clock definitions
Date: Mon, 14 Oct 2024 17:45:00 +0300
Message-ID: <20241014144501.388050-2-ciprianmarian.costea@oss.nxp.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241014144501.388050-1-ciprianmarian.costea@oss.nxp.com>
References: <20241014144501.388050-1-ciprianmarian.costea@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P250CA0006.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::8) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|GV1PR04MB10275:EE_
X-MS-Office365-Filtering-Correlation-Id: 0900ea63-a87f-409d-be32-08dcec5ecc27
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MDF3a2FOay9tbTVtMXp1MTJ2SlFuVVFwNnEwN0dxRzE2N1lnVCtER0EzZzFC?=
 =?utf-8?B?cDJkT2ZVN0VlcFVhdU9NVVUreWwwSDg5WklXWEJDeCt0eHJlMXdQWnFYNDU5?=
 =?utf-8?B?SERsS05Kc2VpODh1Y3cvS0tjSURhMlI5MnU3Ykp6TUJCNllaLzI1MVhnbjlQ?=
 =?utf-8?B?VjVOa1ROdEtwTFNiTy85bXdHOGJTMnBwclR6eTEycDYyZXA5Q2RyVUFMWFU5?=
 =?utf-8?B?RXlvejdhYkZZOHhuY3lEMHVhaUpqVnJxWVI0NXkyeW5ac2ZaYXFyQWtGZ1hN?=
 =?utf-8?B?THBmOUl1eE1JRlhQODRuS1FJaldpc3ZkeGxQdFZsdmF1ekNuYm9JTW9vWjNX?=
 =?utf-8?B?SWtFd0lMTGJOeFdWLzdXSTlFTWJxbWRtZHY2WWxrRWZqaHZraVNnWnQvbUhY?=
 =?utf-8?B?MjJtV0U3SlFCZ3JyZzc3OVpQaElwNjFUbzhyREkxOTBqVWF0N1VRTVdTSlVJ?=
 =?utf-8?B?aHdsb2liOTI2SGVoQkhVRFFKQzFjaCtaYXN6UUU1OHFKeTZWTnVySE91blB1?=
 =?utf-8?B?SitiY0Z1VklKLzVVZWsvU0U2RWQ2NEtEMWpCTWJaSlNCOUZkVEFoMTgzQkZP?=
 =?utf-8?B?SWJNZTJJRkhFNFo3Z2x5ZUV6S1E1cUhlQ2dyYXNwSTRBZzEvTHB0OHNwZ3pr?=
 =?utf-8?B?L3YwWFNFUHRlNkFQSEQxS2p4b0RGQTkxTWh6NkdOMVJXNUszRm1ZeGg0WEhL?=
 =?utf-8?B?T3BXL2d1UGlkd2ZxdFZ1N1lSTTNmWGlPRnh3SFdoanIzYlJmWGV5SWt2aWxl?=
 =?utf-8?B?SnJ0Y2wraUU5TklwKzVKTkE4UUtaK1NzanBDMG5qTXhiWkt6WEliWE5MMXE0?=
 =?utf-8?B?M3hEL1RPQmE2YmhVeTZab0ZDdEplUENpQnYxeWhEbWRZOWZ6R01qcVBsRERU?=
 =?utf-8?B?Qyt3dnJlNnY3QWhXaFlHbG4zOUlXK0N2R2ljMmc1ZWZMVXlBV2FoTlkzUEYr?=
 =?utf-8?B?dVFMOFZIZUZmSGhZTkNKRWVzcUltQ1RRZlN3TDc2NGMxd0Vmb1FGa01BWlRN?=
 =?utf-8?B?bEpzS1ZaK0IvaE1KOUNjTTVrWHd3M2ZGOXF0T29pZHRIQ0ZLQ0VtL0QxRCtE?=
 =?utf-8?B?Q0diM0JkbEVxc1hzRHdmREZseGZCZWdkaWhPQi8vQ1IvdTRJSmlxcXY5WmU4?=
 =?utf-8?B?aHRRUjhYTDY2TURzZWx2QjFJOHZUZjFVQ0RwZEh4K2dJR1VnRzhObW8wRFFw?=
 =?utf-8?B?Wi85dnRsWHRGSHp4Ry9ZMm9VWUZ2LytHemx0S2loU3pMRU1qVkxET0xNVEcr?=
 =?utf-8?B?QUl1QzBjK1R1L3UweUR0WlZ2Zkd6OEVVT0NubGJING1QYWhLUEpRN2FRY29M?=
 =?utf-8?B?YTYyaW5WczRWTGtiSnpES1ludUd3aW9PUUVyelY0V2owLzNtSjVkZ29WK0Rq?=
 =?utf-8?B?ajJXcElDWTdCSTY3VFZsaHc2eTJLaVF0VktGUDhuOXBFc0x4MjNENytvbFh5?=
 =?utf-8?B?Qklta0dsZzFwczZhR2dlejJLUFd6ZDVYQmJrZVBxOHN5QVk2TjdLTmlpVzFC?=
 =?utf-8?B?STZFMVRZYjdFZUZmeStGZVFLTHNjUDVHTEpyRVdSaU56VG9nNEw0ZmhNMVEw?=
 =?utf-8?B?OFhZRGZQdzUrcjFKNkVVUXNxZEpxb29Gbll0a2pVYWFjbTJDUWVaNXJCRENV?=
 =?utf-8?B?U05tUWJ3V0xxZ3N0OTYyV1dBYzM3S3FVZ1dXaXJCdGFzOVdxZjU2dkp2Uk9Y?=
 =?utf-8?B?Tk1ER1JtMWdoR2JybEN2MCtHTW9GbWMzdkEyZjl1VStTaHl5d1l2YlF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzlQU0I2dzd6NU93YUNZYkRoM1FVcjIydXBybWU5bEMweHFGQWFUQTFqZTFx?=
 =?utf-8?B?MUpYZm9rQWc1VnUzVVBHczdPNlVLMDVwcnhvVVlZeUovTVN1MzQ0MmZPU0x5?=
 =?utf-8?B?NWpsbitzbS85S0pRY2ZyR2swTzBpWGNOcmVPbTA5UldRRHZqRThVeTQveEt5?=
 =?utf-8?B?OTBIbHlHWTZiVmtmeGdDeTRxRTNxSnNjVnlubE13b0JNZ1RzaGR0WHBlSCtU?=
 =?utf-8?B?ZkVxbURWYldiQVN0ellzakx3emVnSzcrczliTWRrL29BdjJONjIraU4xbGtN?=
 =?utf-8?B?V0RVY3VZWExVMzFvRXJqWVZNMW1rL2VFSW9UYzJGRXBhRGhmdjMwK1l6WVdV?=
 =?utf-8?B?KzNYcVI4Zjc2dEJ3ekRQcGtwWE02dm41eW9sVWZ0TEQzMTBWdFBuTTc1eXRv?=
 =?utf-8?B?N2lzMDNQTlE3aGFhZ1RZbGd0eUlDMXVUVVRWbVE0SWEweFI2RTFHTUU2bE1v?=
 =?utf-8?B?M2hXQTI2ZmMrbmpjMUl6Zndub2FWaDFoN0dVaXdXMkFuNG1KeTF5c2s0ZGFV?=
 =?utf-8?B?S3Vld2F6VFhwMXVsQU1WVlREU2diNkt5bHp2SE5NcVp3R1dQVjJSMnVBcVhK?=
 =?utf-8?B?NTVyb0JoOU9BTjk2UGo2aGtBTVFCYzE5ZFJZOExSU2lwc3ozYWdVMHJCRmQ2?=
 =?utf-8?B?QjRyN21icWZ2R1pockRpdmx0b0dKUDZIL2xGQldsQzRhZHkwSnBHbzEvQ2Rj?=
 =?utf-8?B?QnN3R2tWb1c1Z1UvODQxOVpmRTcrRzF1K01YNDAycG1nTXF5ZnhVZDhoTUt6?=
 =?utf-8?B?RklqMkVLSTJtcjk5T2l5MURjMlQ1cEN4enRWTTBPVXIzdmxDekVGRHN5TzRi?=
 =?utf-8?B?KzF5Tit0Y3ZpSUhuRGNGaysrNzhaUWxTbkFBOVUva3YvSzYrVEgxdzUwQzVI?=
 =?utf-8?B?K1BjVUhNNE8wRVI1VjlBWmlIU3lzZU5PRC9qTHBaVURCMFVINEx0M3VqNWJ0?=
 =?utf-8?B?M1VSd2tRMUtUejhDRnE5R2E4aG1KOEROcXRsZWVrclVPYUtQQ1FwYVJFVml5?=
 =?utf-8?B?N3pLVFlMS2FUYnpITkQ5bm4wRWIxQ214U2c5WW1CV2JncTgwZFhScDFDWEZq?=
 =?utf-8?B?aUNwUVBNRW15TDJvdHJ5YkNKSElvV2t3MU80VExRMnNNNVZsalE4SmdMb0J4?=
 =?utf-8?B?dXAzUGxIZnBheUF1TURacWNPamtFNUgxSFhQb2E1NWFqazRoMW5aV1JlaVJh?=
 =?utf-8?B?ZXE2ajNCbG9yYTNvQjlyOHN0SmJOVkh6ZG9FN0RNMlBVUXUzRUgrTksxUDIv?=
 =?utf-8?B?T3Q1K3NNWUNDbDg3dnJKUmltamdxRUVRZWYvQ1Q0RDl1WkZRMTZ1aW80alFD?=
 =?utf-8?B?b3BjTHY1U2Y3QTVnNzB5UzdTNStReVhpdTN2MERpbHdtVUkrSnFuYlVRUkpv?=
 =?utf-8?B?eXVpeUwvckJsMkphcFE5S1NYNXN5bTlyUW93ZjBTV0lzUnVQUlU1NllkdjFo?=
 =?utf-8?B?aDE2MUtBbDN5OFBpQkZaaWw5cjJobUpsM2lYeEdMcGY1Qnlac1FQRUE4WFVU?=
 =?utf-8?B?cGw4U1ZQcDVnVklrTjRtek9iY1poRlRCWWV3REkzeHhRYUxKamJaM0ZZODZ4?=
 =?utf-8?B?VmdkcE14bnoyRlhRQXBVcC9KSWd6VGErSEZHRUhFQ1NrM2p5Vm9MTnBLbU84?=
 =?utf-8?B?aTR1d3ZCK2kzRlpnblBTL0htMWk4L0ticzBKOVo0T0dwZlNaaGJ6Y24xV2Fo?=
 =?utf-8?B?ZEMrRU5tcU1KeU05N3RvdTlxZjM5NTIzUWF1dUpSL25MS3RwaHVseSt6c2dW?=
 =?utf-8?B?R3Q3WFFySGNXS0N4QVdKS3pBWW5UU3IrOUNlSHNzTWxoM3pYb3ozN2pna3lU?=
 =?utf-8?B?bjZHaHFxTVdzSndqK1BFc2xHbkxWY0tzRGwzTU5NbmZ0Rk5OWkdvVTVyYUNr?=
 =?utf-8?B?aUQ2TjB2QVVLUEpEcENUOTM1c0JMSFRBdVJiNURkcW1pa3FPbUV0ZHpPR2pm?=
 =?utf-8?B?QndQa2FmclE1TmdUY3pNdnB5L2FJVkx5R3RkL2UzNG84WWZJTnVYKy9JQUNY?=
 =?utf-8?B?RTBqMmx3WkE5cnVCbHdnTmQ1YS9semdkWVhERU9FUWRHbm1yQzZBbXg5Z2pC?=
 =?utf-8?B?K0pkVmRNc0wwYWZvL0pBSEsvekphQW11clpNbm1JcDRDeE1ncFBYbjRRL0po?=
 =?utf-8?B?ZWNKL3F3OWNVSDkyblVlK0NiOGdXaDRnVWk2OW90QTBORlJSMDRSVDhTYUNs?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0900ea63-a87f-409d-be32-08dcec5ecc27
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 14:45:07.7292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4gBidIWAYFu2uvZ54/TVVDia6p8DFX+eUomjOKJRC4ToK3Qt8KJ1zKUABexaAm4Z6IHlQUqEVNjxC0OYRhTDg7CJWas9McHwWCwhdNUO/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10275

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

Add clock definitions for NXP LINFlexD UART bindings
and update the binding examples with S32G2 node.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
---
 .../bindings/serial/fsl,s32-linflexuart.yaml  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
index 4171f524a928..7b2ba14297f9 100644
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
 
@@ -48,3 +62,16 @@ examples:
         reg = <0x40053000 0x1000>;
         interrupts = <0 59 4>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    serial@401c8000 {
+        compatible = "nxp,s32g2-linflexuart",
+                     "fsl,s32v234-linflexuart";
+        reg = <0x401c8000 0x3000>;
+        interrupts = <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&clks 13>, <&clks 14>;
+        clock-names = "ipg", "lin";
+    };
-- 
2.45.2

