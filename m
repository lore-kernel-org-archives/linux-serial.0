Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D12D3D3492
	for <linux-serial@vger.kernel.org>; Wed, 13 May 2026 06:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655094; cv=fail; b=BgzuPULnvKfgFapZhoBcMO1XGtoPAGTW/ZTbJ3BpzCxPLmdv3zW8cBsvKNHoqPcDcznILnB/2SsSKyrgZsmS8fyEMIRUljLmT4574cp+gXFwD/wi6S3YoNbZ/4rISI2228hg4QEeYbV8JtMGwO6J4pP6YcZH91XiafkqKdOS95I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655094; c=relaxed/simple;
	bh=2syMwWxGDKRcbXxWlS7akQ86RqNYwXxsmqR/lsa4yqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OoJRbH5hus4I0EvLlwQ0fzhsjjQxK1hqlVZBtbEmSeQd7bI08gun/hmb5YFirs/jRK0lVk4mkFigkJoGCO4DpKb05r1Q/hDZCX+fjixa9dcB5CCxzX4sDf6ii6YEuNWuHmsg7G9vFalFHY98lHPm2A6UJrnaBQ3pLlSVJ4nz+eM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ZMaHWg+t; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="ZMaHWg+t"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D3t2iv243653;
	Tue, 12 May 2026 23:51:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=6wXARDXyC2R6sVvXRfVpkj3KSo076vR2DGgjE/r+OFc=; b=
	ZMaHWg+tUk/HDGPr3rsLBL8y+jn/8t+9f6wRyQ1s8QSWCh12wtXgqWEMXQK4hcgF
	X1017uiUEWcoY//9Fy7ZVpV7YvyejfuC46oPYQlnklROEH5M7R8s4YtKPhqOgeff
	onM8lo0FP3XB/yuXyYGAUyk8HNulL7xMPdW414T37+9Cp30VS3xywT0/GnTkUiOX
	RdbWqOaZdMSGG0q/spmE8PfHyXCj++owgtTl0Pq4sXPXuzpT3bHkAkWjS7TdKvMM
	M5Bp8f9fvjzw5ws+n3tcCHbwsydi0655pvZYyF7kAXk8nP5fzXIjGQqHDRG4lXCp
	nQmic/iljD7vKIf7GAL0eA==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4ftb8a28-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 23:51:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Erfr/euTwvHTxkrnXaAt2f0PNbKaNr3abhkid364AeZLDF9nKatq0BHSQx2hjANUDJIPthmyXPG2IDJE+uu+pDrEvs70hzE7stD937vc4q6SkAZtyKIHLfdqNp7uxIq3g0lWjVXnRTKt9/wfE0HOLfwNgc6txcBDJisbmEkEisSRYbJ0ABTHYsmQbANP+kfE8uw12gQn8TAPpe7ITzHUv/j4etrscImnLfZQOLqOcbw7h7xZjqpDwnJqMm633zgrMEd9MqFPGvint9HEGVbl9ZsEKfXCJ3H6AUjXBleswAGeODjDoigihm/wv/IBo1dDb1EJN5KFJWvKsGzOS0Cm5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wXARDXyC2R6sVvXRfVpkj3KSo076vR2DGgjE/r+OFc=;
 b=PvOGwDhOlpucmyG9OUWLUxLK1d9Eq0ffEuPorvWuPPh2FjJwkymMVqAgnF05Cf3C4fls6NEJ0HjDd1G/0jr+j3ON3LJT7hCDXTD+wGnsMpq63iSNug59YilBAhv4HKn6aIEvrrpuMeWwpC/ZbmwGq6gyhL6o8XJiEXEokpHV0mi3DSKffHK0c52fkdED8n61gYPjmU4Z2P2xzVX4kk1m+zncKShdm7A6JRK9J/YRA1puTWtQqqKt1DdvXwALnqvk2KTU8RfXVq7WiEL7QWh22fh9G8a8enIf46iUguIIzv/trJsfL+nVQiGY6yELcVOf3v5ds1IFszTHM1yz+eRMnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 06:51:12 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 06:51:11 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc: stable@kernel.org, andriy.shevchenko@linux.intel.com, wander@redhat.com,
        chris.friesen@windriver.com, linux-serial@vger.kernel.org,
        qianfan Zhao <qianfanguijin@163.com>,
        Adriana Nicolae <adriana@arista.com>,
        "Bandal, Shankar" <shankar.bandal@intel.com>,
        "Murthy, Shanth" <shanth.murthy@intel.com>,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 10/10] serial: 8250_dw: Ensure BUSY is deasserted
Date: Wed, 13 May 2026 09:50:28 +0300
Message-ID: <20260513065028.112468-11-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513065028.112468-1-ionut.nechita@windriver.com>
References: <20260513065028.112468-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0105.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::34) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|BN9PR11MB5289:EE_
X-MS-Office365-Filtering-Correlation-Id: 54fa09ad-147f-46d3-d8f2-08deb0bc04ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|52116014|10070799003|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	yyl53tlAZxgvtS895kfTggq1SVn/+RDVtvYc7EVLwoEZNibGBZ/FyOAFDIfQ1olLRkEcqXARkoR0C39j4A1zIgPttLINH0cP/7lPnvUlaQFwS/h2ts1WkWo/0N8Q3yXSs8Kqlpl5lePeyS/bU4/cN9UstDWU5o/FpM2s/4cLzBdRQJbpFc4XEklpTy3wrSmmMT49YwpEEdrCGniwNGWm1m1pEY/bo3rZgW5DzVoUh1IS98QIDVFF3QnDtnJYbvuePuZxPAQv0bhlkAG5pgFF3X8ffCVBgf0Hd4OeJEvU2eGG2LMy7nIHOGeAYRnrnLuNLUVhSkhHcIuOMR1YdVYxYzT3Xi/XwDz/A794MV4VVQlOj8Gxw9AouNu9xbLsKgFzVL4J3BGaQWSbzD86QTIGdIlHTNu9aW5UPswPh7PZnfVYrpA4IUVMfvLdeYEgXDXk01GSi11/rAACO7qj8MZYpB5Zc+EYjgQB5tlyGwklWedKA2Jq+/uPsW5NwsNI6iqVxk+yjoJCXrpuhDtNYhOM/4a/UkgK0dlp8nfeGQoJFJnifjIKew8lCX8qEGM/bTs/4GHki42MTaisVv81yH/g8+9QWr3rvyKzLJD0eM0vJTerefD06TRmMgtfj9qyuEOJ3NG1DUf3FeQ9BYs1w4jm7g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(52116014)(10070799003)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OStRSlBkYWZyM1phb1F4NGRaa3ErV2swYy9uSk1TNnFBMHNrZmwxR0szNHh2?=
 =?utf-8?B?QzBTYmJiNzJ0dXVpbUJvSmt6ejBQYmJGVllRRkQ2MHJTekhnZi9paW5EeWlz?=
 =?utf-8?B?c0loN2tOeVFNcEhINFlMTzZXR1lLQ2xTcThIVE1jRWxxTlVqUDhNcDE5a1pu?=
 =?utf-8?B?VkhwOE1aWjlLNDBVSWl2RkZ0L3YrYTB2N1NublFFeTIzR3VBeGNFZUlxZ25Z?=
 =?utf-8?B?Y3lyek5XZjNCTEdhQS9Ba3FyRUtuYzZ5NDNKdHRRR2pSWnJTa2QwS2oxVnVx?=
 =?utf-8?B?RmZKNFBIWE1iV3BqMHZ0MGNGWGpLSVlNREpWSnpUSkpnem16eDRWdUpZdFlq?=
 =?utf-8?B?cTQwYVRoN0F6L0V6ZjJLc1RwT29Oc2syTDZSQ0x3NzZ0M2lPYmhuTHNyM3hX?=
 =?utf-8?B?cFdrYW1sQ0ExQVBYM2swYTE5QklHdnNoTnJLKythTnVxeks1SlJNM09ZVWFm?=
 =?utf-8?B?WjRuM0IrcHdZQVdqN2ZxRVFzYXBOQXc0Q2tpTThnQUVmTjJlSlhYL2FqVERx?=
 =?utf-8?B?R0x6Sm1hVS9tQjhWN3lFL2ZMRkJTeFdzVzhySFZGQ21iQWNxQVlocU9JczJr?=
 =?utf-8?B?eGZSNzN4b1ZqYktLZDdZOWlNU29iNHdOaDdXcGpiZzVVLy8xb20rcnJ2azZS?=
 =?utf-8?B?Z0tHTTl4ekpPVTBmRmJTU2pGcEp1MWdSRVBXNndES3R0b2g0WU84TzRaVzV6?=
 =?utf-8?B?bTI3ckRJT2JsTWpEajgzSWg0Slp2d3h3dVJhY011ZFZjdk45SmlVK2MzNWU0?=
 =?utf-8?B?dGhuSHpuN3FKc2VCSW1PWTY5a2Z6cUNkRGtyanByRzd0UVBTNmFxWUZpTGxa?=
 =?utf-8?B?cGhRTk1ZVmNhTDJVTUFyeERXL0VpZHlxazlJNEVQNVZyRUlsMnNPSExPTlcv?=
 =?utf-8?B?ZGNjR1BCTTV0SXRzN0xOamdSL0RTMzVyWnFzRDVjRk1JSWxRSXVLR0Jvbk9v?=
 =?utf-8?B?dldDVU9jUVhnbS9WcTFEbjJOU1NZWnpIa2ZKbVNGZGwrUnl4ZkpRaFYxQ0Vp?=
 =?utf-8?B?OXhCRXJib0RMTzdtc0FXQmcyMXd3cUtRSzB2NW4wSVpTQ3R2RGl4amNyRSs4?=
 =?utf-8?B?cW13ZkhscnhwL0dRUkxpR0I1WVBnWWY3bTVKdmM0K1JOL2R1a082ZG9OKzBQ?=
 =?utf-8?B?RUw3TzQyR3pjbG9aeExmbzRQdEEwNGhiQXd6QjZqbXYyQ1hmR2lEZGQ0UHg5?=
 =?utf-8?B?M25GbVAwY3lWSjFwV3hvdUJVd3JaMW9PMUZqdVZGRUMvMWN2aDlsdFFLRFVS?=
 =?utf-8?B?amFKUDZMNUVnZDlZWDAwYVpEdGRqY1pudXhBOU5Ja3VsazBXWmpTa1A5TVpG?=
 =?utf-8?B?czJ3TXh0TDhsOW1GVEp2bWgvaWNKSjZkWkZNa0FjTUR2Zm9jOVAyQVBGQkNR?=
 =?utf-8?B?K2hOS3JqdHBCeE9tN0JJSzltcDBPdzQ0K0tGWmkzZ3Z1YUdDNkNGS2NISzZy?=
 =?utf-8?B?bjhDek90TC9pK2J4MEJTeFJJRmsxTEdrdXdyRy80RmZJc2ZiWFhYU3o2cFRI?=
 =?utf-8?B?S3JQcmRHSnZqVU1iU3VEZzJWazFpZjZmbGRPSnpqRlVJU0RJOTNwcXU0ejl6?=
 =?utf-8?B?b2dzamtlQlN1UkNUZmJQcFFBeFZHSmpoVjUrZ0lNWS9RRlJxUEtUa1lNTHFT?=
 =?utf-8?B?a2dDZGhhUHpQTFpVSTBCUmhsOWpsbXBUc0dUMW80a0crL3kvd1ZQNGdMV25l?=
 =?utf-8?B?blpVNS94SmhTbkhoTlN1dm5Cc1JRZE5IZWZ1cW5zb2MzK2Jmc2x4VDVwVmFJ?=
 =?utf-8?B?bXRKK0JLdUFhV3YxMlh0RmdXUUlNaGhCdTdlWUYyN1ZHYUg4MnZZQXNyWjcz?=
 =?utf-8?B?bS9PSG93MDRDMjBoZEJZa2ZKUzVXTE9kZy9qZ1pKaS9lSVpiUDkwK0ZYeDIx?=
 =?utf-8?B?ZkIxc3lPM3lFc2c5eDhTR0x5Tlg1RStvRFUwVCtVa2tCaENQeVdMemdHSWRn?=
 =?utf-8?B?QnZuRnNpNVE5OEl4OXNab2kzQkFPWTVMM0Fsc2xMSzc3bXI1NkNjUG5pQ1Nu?=
 =?utf-8?B?cmFBVkVHVFlZcHRveFFWRkRyOXpaMW5VQlExNFg1anMrTFFEUTYxTWlVRUND?=
 =?utf-8?B?c0FkNVVvVHR4V1JTdFZPVXg4M0gyS2tOeDZhQ0lObkU5MHhzSC8wRCs5TThO?=
 =?utf-8?B?ZXFtT0dhd3lzTjN4ektvU3BCa0VsK2pUKzNzSzJWamJLVERtS3ZBSHQ2QWlN?=
 =?utf-8?B?Qmh6WVBNSVQrcHdJSUhheHNVL01WdWovS2NlOWhIbVlNenNRRzFQM3hFQkNu?=
 =?utf-8?B?S2d4LzROKzBDYTZsRnYyRVZYWVpCSG9XYVZ4ZmMvMm1aSE9RSkthRXhSMUFV?=
 =?utf-8?B?SW85ZXZBVDMvM0YwaEltQm1jbUxpUWR4bE1RcytNVjh4NTlkcFVvUGc5ZVFP?=
 =?utf-8?Q?MyqiKjS9S+Yiq5gADgTiOTEu9X3CtB5Uj8LDfflFyUNvS?=
X-MS-Exchange-AntiSpam-MessageData-1: 1KwUuEvVRPD+Z4BgIgexoYSFyj+hKwDuDyc=
X-Exchange-RoutingPolicyChecked:
	SrWsiC1L1/ddcWM0CfwQbUE+wfKM5GpQb45Yyr0sdLkMdcp7HClvvN/57Wc4ABY5SVsKYzY2l+Ks4ScF/iZImu5qCdPP70R0rlfM+5y6tN2UskxDXJvnr4esvW+kRZMiGCnhfOxfVgRKoUbJzPPTP9J6ATx4vEUspA1BAPfpqI9NNIBahkboU83iBgwxCr4wYlBr5/WZC+MW3/M63iFdBQToqgyZ8+o5bidd4Q3TjKUvSvB//5DRpvpbUcsyUwjP3xqSq/iWwcz5/XP7mr/Szy3MzyjI/S5bvlUPjYfEzwmRQI0lqxTsSl65ElInXT+bbjDkP2vekagrvyV4Hvrq5g==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fa09ad-147f-46d3-d8f2-08deb0bc04ea
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 06:51:11.8327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 434axOMg+8OjCl5tPhhjdjQz3a+7Ppy8piSyi7wnjDZNpf9rJPuLqzNgO3exW24pnz6daBA13hb3n81wyBk1Mwsyu69ySLMGTOVo3RVAP/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA2OCBTYWx0ZWRfX/b38+KHdyrmj
 q4nvkuQU9eZipcvUJEWpaETgr86TcGtFCNq/LDDxKKrZ6j0j8SuOkgn7cZRt1UETE89h8Pkmvu9
 5S7+50jqOq3uP0dh3nljzM0honNQN0g+bBy/vRHyDComPyJSfyX4XsBejrx6zrRZDQw76KhJk6E
 j7IYF5TcuD7cvpDyHGWaCS5GFJP78ceGWGW4fQch2ZDsab+dn6xr+dcYLYEWKamJWASn37Tyeub
 4YwUKf8h5IGHk9oqu+8Vo8qx4ikXwfJcUr0T+J1YbRemo2p8uBk7mcUR8c5hLm+czsn8MAWbX9H
 EtjpN4EoZz5TbvEgMee8F4OZwJtm933hkGvF+Y3vlzIudxCI4Xr+soFYtBC1zF+K8cze4WX1FTb
 +QP0rKcdRtz6XHuQ9bHjNds0dCjb3+4rUnbzoTF4973XEiljms2sst2pKqC4mDRltN6JN4WTOof
 fd1LsW7HUNNiJBQ0scw==
X-Proofpoint-GUID: t2t0StbAG7vByUkFGIjPkiMMQAJwXsud
X-Authority-Analysis: v=2.4 cv=du/rzVg4 c=1 sm=1 tr=0 ts=6a041f61 cx=c_pps
 a=f333RhXzhOQaWIE8hCCRDA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=n2GhSfulAAAA:8 a=bC-a23v3AAAA:8
 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=FEdSOl-n94fBr2OEgZIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=9NqWk_7B-uqI6kdQTXIl:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: t2t0StbAG7vByUkFGIjPkiMMQAJwXsud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130068

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

commit a7b9ce39fbe4ae2919fe4f7ac16c293cb6632d30 upstream.

DW UART cannot write to LCR, DLL, and DLH while BUSY is asserted.
Existance of BUSY depends on uart_16550_compatible, if UART HW is
configured with it those registers can always be written.

There currently is dw8250_force_idle() which attempts to achieve
non-BUSY state by disabling FIFO, however, the solution is unreliable
when Rx keeps getting more and more characters.

Create a sequence of operations that ensures UART cannot keep BUSY
asserted indefinitely. The new sequence relies on enabling loopback mode
temporarily to prevent incoming Rx characters keeping UART BUSY.

Ensure no Tx in ongoing while the UART is switches into the loopback
mode (requires exporting serial8250_fifo_wait_for_lsr_thre() and adding
DMA Tx pause/resume functions).

According to tests performed by Adriana Nicolae <adriana@arista.com>,
simply disabling FIFO or clearing FIFOs only once does not always
ensure BUSY is deasserted but up to two tries may be needed. This could
be related to ongoing Rx of a character (a guess, not known for sure).
Therefore, retry FIFO clearing a few times (retry limit 4 is arbitrary
number but using, e.g., p->fifosize seems overly large). Tests
performed by others did not exhibit similar challenge but it does not
seem harmful to leave the FIFO clearing loop in place for all DW UARTs
with BUSY functionality.

Use the new dw8250_idle_enter/exit() to do divisor writes and LCR
writes. In case of plain LCR writes, opportunistically try to update
LCR first and only invoke dw8250_idle_enter() if the write did not
succeed (it has been observed that in practice most LCR writes do
succeed without complications).

This issue was first reported by qianfan Zhao who put lots of debugging
effort into understanding the solution space.

Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaround")
Fixes: 7d4008ebb1c9 ("tty: add a DesignWare 8250 driver")
Cc: stable <stable@kernel.org>
Reported-by: qianfan Zhao <qianfanguijin@163.com>
Link: https://lore.kernel.org/linux-serial/289bb78a-7509-1c5c-2923-a04ed3b6487d@163.com/
Reported-by: Adriana Nicolae <adriana@arista.com>
Link: https://lore.kernel.org/linux-serial/20250819182322.3451959-1-adriana@arista.com/
Reported-by: Bandal, Shankar <shankar.bandal@intel.com>
Tested-by: Bandal, Shankar <shankar.bandal@intel.com>
Tested-by: Murthy, Shanth <shanth.murthy@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://patch.msgid.link/20260203171049.4353-8-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Ionut: adapt to 6.12.y - two adaptations:
 (1) in dw8250_check_lcr(), drop the trivial conflict against the
     pre-existing 6.12.y "while (tries--)" / "int tries = 1000" retry
     loop that this commit removes (per Ilpo's note: trivial
     resolution because the conflicting code is removed by the BUSY
     change anyway, see commit fc9ceb501e38 "serial: 8250: sanitize
     uart_port::serial_{in,out}() types" not backported here);
 (2) use bare-identifier form for namespace exports in 6.12.y, i.e.
     EXPORT_SYMBOL_NS_GPL(..., SERIAL_8250) and
     MODULE_IMPORT_NS(SERIAL_8250); 6.12.y EXPORT_SYMBOL_NS_GPL() and
     MODULE_IMPORT_NS() apply __stringify(ns) to the namespace
     argument, so the upstream string-literal form fails the
     .vmlinux.export.c link step.]
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/tty/serial/8250/8250.h      |  25 +++++
 drivers/tty/serial/8250/8250_dw.c   | 165 ++++++++++++++++++++--------
 drivers/tty/serial/8250/8250_port.c |  28 ++---
 3 files changed, 162 insertions(+), 56 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 10a706fe4b24..1fe8222ffacd 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -184,7 +184,9 @@ static unsigned int __maybe_unused serial_icr_read(struct uart_8250_port *up,
 	return value;
 }
 
+void serial8250_clear_fifos(struct uart_8250_port *p);
 void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p);
+void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up, unsigned int count);
 
 static inline u32 serial_dl_read(struct uart_8250_port *up)
 {
@@ -402,6 +404,26 @@ static inline bool serial8250_tx_dma_running(struct uart_8250_port *p)
 
 	return dma && dma->tx_running;
 }
+
+static inline void serial8250_tx_dma_pause(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+
+	if (!dma->tx_running)
+		return;
+
+	dmaengine_pause(dma->txchan);
+}
+
+static inline void serial8250_tx_dma_resume(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+
+	if (!dma->tx_running)
+		return;
+
+	dmaengine_resume(dma->txchan);
+}
 #else
 static inline int serial8250_tx_dma(struct uart_8250_port *p)
 {
@@ -423,6 +445,9 @@ static inline bool serial8250_tx_dma_running(struct uart_8250_port *p)
 {
 	return false;
 }
+
+static inline void serial8250_tx_dma_pause(struct uart_8250_port *p) { }
+static inline void serial8250_tx_dma_resume(struct uart_8250_port *p) { }
 #endif
 
 static inline int ns16550a_goto_highspeed(struct uart_8250_port *up)
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index c24659f0b309..13cc7db10327 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/lockdep.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
@@ -47,6 +48,8 @@
 
 #define DW_UART_MCR_SIRE		BIT(6)
 
+#define DW_UART_USR_BUSY		BIT(0)
+
 /* Renesas specific register fields */
 #define RZN1_UART_xDMACR_DMA_EN		BIT(0)
 #define RZN1_UART_xDMACR_1_WORD_BURST	(0 << 1)
@@ -89,6 +92,7 @@ struct dw8250_data {
 
 	unsigned int		skip_autocfg:1;
 	unsigned int		uart_16550_compatible:1;
+	unsigned int		in_idle:1;
 
 	u8			no_int_count;
 };
@@ -121,78 +125,151 @@ static inline int dw8250_modify_msr(struct uart_port *p, int offset, int value)
 	return value;
 }
 
+static void dw8250_idle_exit(struct uart_port *p)
+{
+	struct dw8250_data *d = to_dw8250_data(p->private_data);
+	struct uart_8250_port *up = up_to_u8250p(p);
+
+	if (d->uart_16550_compatible)
+		return;
+
+	if (up->capabilities & UART_CAP_FIFO)
+		serial_port_out(p, UART_FCR, up->fcr);
+	serial_port_out(p, UART_MCR, up->mcr);
+	serial_port_out(p, UART_IER, up->ier);
+
+	/* DMA Rx is restarted by IRQ handler as needed. */
+	if (up->dma)
+		serial8250_tx_dma_resume(up);
+
+	d->in_idle = 0;
+}
+
 /*
- * This function is being called as part of the uart_port::serial_out()
- * routine. Hence, it must not call serial_port_out() or serial_out()
- * against the modified registers here, i.e. LCR.
+ * Ensure BUSY is not asserted. If DW UART is configured with
+ * !uart_16550_compatible, the writes to LCR, DLL, and DLH fail while
+ * BUSY is asserted.
+ *
+ * Context: port's lock must be held
  */
-static void dw8250_force_idle(struct uart_port *p)
+static int dw8250_idle_enter(struct uart_port *p)
 {
+	struct dw8250_data *d = to_dw8250_data(p->private_data);
+	unsigned int usr_reg = d->pdata ? d->pdata->usr_reg : DW_UART_USR;
 	struct uart_8250_port *up = up_to_u8250p(p);
-	unsigned int lsr;
+	int retries;
+	u32 lsr;
 
-	/*
-	 * The following call currently performs serial_out()
-	 * against the FCR register. Because it differs to LCR
-	 * there will be no infinite loop, but if it ever gets
-	 * modified, we might need a new custom version of it
-	 * that avoids infinite recursion.
-	 */
-	serial8250_clear_and_reinit_fifos(up);
+	lockdep_assert_held_once(&p->lock);
+
+	if (d->uart_16550_compatible)
+		return 0;
+
+	d->in_idle = 1;
+
+	/* Prevent triggering interrupt from RBR filling */
+	serial_port_out(p, UART_IER, 0);
+
+	if (up->dma) {
+		serial8250_rx_dma_flush(up);
+		if (serial8250_tx_dma_running(up))
+			serial8250_tx_dma_pause(up);
+	}
 
 	/*
-	 * With PSLVERR_RESP_EN parameter set to 1, the device generates an
-	 * error response when an attempt to read an empty RBR with FIFO
-	 * enabled.
+	 * Wait until Tx becomes empty + one extra frame time to ensure all bits
+	 * have been sent on the wire.
+	 *
+	 * FIXME: frame_time delay is too long with very low baudrates.
 	 */
-	if (up->fcr & UART_FCR_ENABLE_FIFO) {
-		lsr = serial_port_in(p, UART_LSR);
-		if (!(lsr & UART_LSR_DR))
-			return;
+	serial8250_fifo_wait_for_lsr_thre(up, p->fifosize);
+	ndelay(p->frame_time);
+
+	serial_port_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
+
+	retries = 4;	/* Arbitrary limit, 2 was always enough in tests */
+	do {
+		serial8250_clear_fifos(up);
+		if (!(serial_port_in(p, usr_reg) & DW_UART_USR_BUSY))
+			break;
+		/* FIXME: frame_time delay is too long with very low baudrates. */
+		ndelay(p->frame_time);
+	} while (--retries);
+
+	lsr = serial_lsr_in(up);
+	if (lsr & UART_LSR_DR) {
+		serial_port_in(p, UART_RX);
+		up->lsr_saved_flags = 0;
 	}
 
-	serial_port_in(p, UART_RX);
+	/* Now guaranteed to have BUSY deasserted? Just sanity check */
+	if (serial_port_in(p, usr_reg) & DW_UART_USR_BUSY) {
+		dw8250_idle_exit(p);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
+			       unsigned int quot, unsigned int quot_frac)
+{
+	struct uart_8250_port *up = up_to_u8250p(p);
+	int ret;
+
+	ret = dw8250_idle_enter(p);
+	if (ret < 0)
+		return;
+
+	serial_port_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
+	if (!(serial_port_in(p, UART_LCR) & UART_LCR_DLAB))
+		goto idle_failed;
+
+	serial_dl_write(up, quot);
+	serial_port_out(p, UART_LCR, up->lcr);
+
+idle_failed:
+	dw8250_idle_exit(p);
 }
 
 /*
  * This function is being called as part of the uart_port::serial_out()
- * routine. Hence, it must not call serial_port_out() or serial_out()
- * against the modified registers here, i.e. LCR.
+ * routine. Hence, special care must be taken when serial_port_out() or
+ * serial_out() against the modified registers here, i.e. LCR (d->in_idle is
+ * used to break recursion loop).
  */
 static void dw8250_check_lcr(struct uart_port *p, int offset, int value)
 {
 	struct dw8250_data *d = to_dw8250_data(p->private_data);
-	void __iomem *addr = p->membase + (offset << p->regshift);
-	int tries = 1000;
+	u32 lcr;
+	int ret;
 
 	if (offset != UART_LCR || d->uart_16550_compatible)
 		return;
 
+	lcr = serial_port_in(p, UART_LCR);
+
 	/* Make sure LCR write wasn't ignored */
-	while (tries--) {
-		unsigned int lcr = serial_port_in(p, offset);
+	if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
+		return;
 
-		if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
-			return;
+	if (d->in_idle)
+		goto write_err;
 
-		dw8250_force_idle(p);
+	ret = dw8250_idle_enter(p);
+	if (ret < 0)
+		goto write_err;
 
-#ifdef CONFIG_64BIT
-		if (p->type == PORT_OCTEON)
-			__raw_writeq(value & 0xff, addr);
-		else
-#endif
-		if (p->iotype == UPIO_MEM32)
-			writel(value, addr);
-		else if (p->iotype == UPIO_MEM32BE)
-			iowrite32be(value, addr);
-		else
-			writeb(value, addr);
-	}
+	serial_port_out(p, UART_LCR, value);
+	dw8250_idle_exit(p);
+	return;
+
+write_err:
 	/*
 	 * FIXME: this deadlocks if port->lock is already held
 	 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
 	 */
+	return;		/* Silences "label at the end of compound statement" */
 }
 
 /*
@@ -629,8 +706,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	p->type		= PORT_8250;
 	p->flags	= UPF_FIXED_PORT;
 	p->dev		= dev;
+
 	p->set_ldisc	= dw8250_set_ldisc;
 	p->set_termios	= dw8250_set_termios;
+	p->set_divisor	= dw8250_set_divisor;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -923,7 +1002,7 @@ static struct platform_driver dw8250_platform_driver = {
 
 module_platform_driver(dw8250_platform_driver);
 
-MODULE_IMPORT_NS("SERIAL_8250");
+MODULE_IMPORT_NS(SERIAL_8250);
 MODULE_AUTHOR("Jamie Iles");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Synopsys DesignWare 8250 serial port driver");
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d05254fb115a..aade663b46a3 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -478,7 +478,7 @@ serial_port_out_sync(struct uart_port *p, int offset, int value)
 /*
  * FIFO support.
  */
-static void serial8250_clear_fifos(struct uart_8250_port *p)
+void serial8250_clear_fifos(struct uart_8250_port *p)
 {
 	if (p->capabilities & UART_CAP_FIFO) {
 		serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO);
@@ -487,6 +487,7 @@ static void serial8250_clear_fifos(struct uart_8250_port *p)
 		serial_out(p, UART_FCR, 0);
 	}
 }
+EXPORT_SYMBOL_NS_GPL(serial8250_clear_fifos, SERIAL_8250);
 
 static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t);
 static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t);
@@ -3284,6 +3285,17 @@ void serial8250_set_defaults(struct uart_8250_port *up)
 }
 EXPORT_SYMBOL_GPL(serial8250_set_defaults);
 
+void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up, unsigned int count)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		if (wait_for_lsr(up, UART_LSR_THRE))
+			return;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(serial8250_fifo_wait_for_lsr_thre, SERIAL_8250);
+
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 
 static void serial8250_console_putchar(struct uart_port *port, unsigned char ch)
@@ -3320,16 +3332,6 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 	serial8250_out_MCR(up, up->mcr | UART_MCR_DTR | UART_MCR_RTS);
 }
 
-static void fifo_wait_for_lsr(struct uart_8250_port *up, unsigned int count)
-{
-	unsigned int i;
-
-	for (i = 0; i < count; i++) {
-		if (wait_for_lsr(up, UART_LSR_THRE))
-			return;
-	}
-}
-
 /*
  * Print a string to the serial port using the device FIFO
  *
@@ -3347,7 +3349,7 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 
 	while (s != end) {
 		/* Allow timeout for each byte of a possibly full FIFO */
-		fifo_wait_for_lsr(up, fifosize);
+		serial8250_fifo_wait_for_lsr_thre(up, fifosize);
 
 		for (i = 0; i < fifosize && s != end; ++i) {
 			if (*s == '\n' && !cr_sent) {
@@ -3365,7 +3367,7 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 	 * Allow timeout for each byte written since the caller will only wait
 	 * for UART_LSR_BOTH_EMPTY using the timeout of a single character
 	 */
-	fifo_wait_for_lsr(up, tx_count);
+	serial8250_fifo_wait_for_lsr_thre(up, tx_count);
 }
 
 /*
-- 
2.54.0

