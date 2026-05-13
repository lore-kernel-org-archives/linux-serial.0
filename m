Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB86B3D47CF
	for <linux-serial@vger.kernel.org>; Wed, 13 May 2026 06:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655069; cv=fail; b=m9aZA/FYH6nQPMax/n0MenwDqeQw8who6T4cheN3sQoA1y5X5p+bc11Q+iYpJMWN5PSiOuDPLevaM7J4TsW1HhoTRiqQ72dPm8iOoROXL8QOVUvdHqAjSjFSXhablj7RMf2JI57ZYVyoACX2cc00ChuLgHuiia3Uum5fOqSdPNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655069; c=relaxed/simple;
	bh=2sM7pMx0TynYMj6cl568UC77vJ9S6WKVbSNeRjLIR1s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=iBI+4U85js9y3aZ6fUtnJCznaSCXvtpFg+xbJ4Ulq03DE6N41ORuQJDGFx/wu0XT/mypBDTnzBmct8Z5110oK1g6Nd78KA9S2amVE5B3lt/yt1naTMn6Jtb/NfXgBNMAz71V7VJ4akIlBd76bmZcx2WyDLqzDYCFBJlEVeYVoxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=pk1KQAfW; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="pk1KQAfW"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D26opw016166;
	Tue, 12 May 2026 23:50:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=U7Y6s1Oyo
	F+GfPCGXGO9BXzQvKwqytlWFjR7LiA6Ruw=; b=pk1KQAfWvJ7M3lIykU3pcpXJ3
	I89t/Gc6uZaZbbnJM0F1GfWHLSD081d9Moy5WzOZAbiLvPlkshnw+7myv1uNqVyH
	vmITu0cg+7MLJlYO8XifL2O0HOTpY2Yvtb7ny3JNYQChWSSdnQJHlJFNPP/R+Fdj
	qqfViFKzWdhMLs0+dkh9j9d1QfgcGDZbdBoUR9WElBY1KJp275pENIi01ykMmCAE
	b19zYL+Wb3kZfzZ8cl54fsFxIdytKbFsbayHFP21ZXfoLs406au+USqwiQYGuxbW
	MmdOu/e6vpIGG419OYd5OVSf9gA87Ta3xUI8XyQN8BkSJdpF6LREAwZsUXupQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4g7g88xq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 23:50:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLfDdAYXf8PlM7hVa5HDeGQkJizwUHoZgEEBxJoSdkedacME97i3FatIalGoQh1DE3JrTivk1bYkf1HOHYnJitZrQlWyFdCMOmAKiz7u/Kzt1KvMT0swcyIkYmvV3pO/GpBNp0fofcbaX9yyEiiXCtryhhY+QwIp51P7Aq3nsvMxjeV2CNd9Krsca5jeEPstOekzR3KIsa7rQy8aKQwsMeM5wgx+CWn6HqiG7KCror+Xv8lBirJAqA3FxCfRJ8SVFR9bED1IQlDxI5LvYsiCw1Usm57PRpe73j9SJb6ggye12GFjHdUTd9SD7MAtnzYawJ6Hw6bKnZ1pwEExswrDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7Y6s1OyoF+GfPCGXGO9BXzQvKwqytlWFjR7LiA6Ruw=;
 b=lbZC1TJ7VfOyeAZHUbbvwSNAQ+rI+0mpWk+JhembUXnogWf/ilRaXp4rni0U9ItKX4bcXz63vRF7307JqQHWDtqiaoEgApfVbAXvjZk6aqVx6DB9qhyqjJ+V7D62D8lcCR74WkkjqtqmWV6fBdjZxnw2xY5jMHB2euUZZDqdCyieFvd6uovPviOP1d2JpC5Ac18gHZJL21HdFZsuJYMOK1Qt/LEMnhL5cmNH5+zfM4juxbpmusGs6o/GDDAGwwyO2zursHgRSB0jJaqwM/bP++J0paTR8fSdVbZV/mI4SdZ7d6WH4ggTv0Rn4F/hFD01agG9jwThgPGo+z4C5+NTKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 06:50:43 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 06:50:43 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc: stable@kernel.org, andriy.shevchenko@linux.intel.com, wander@redhat.com,
        chris.friesen@windriver.com, linux-serial@vger.kernel.org,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 00/10] serial: 8250_dw: backport BUSY deassert series
Date: Wed, 13 May 2026 09:50:18 +0300
Message-ID: <20260513065028.112468-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.54.0
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
X-MS-Office365-Filtering-Correlation-Id: 9ad1f9b1-dd86-4ac3-2959-08deb0bbf3cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|10070799003|11063799003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	SGb1Z+8fRB6OoxOK3l0Hfs5FZfShGzog51jkbksceYv9LfHdr7j8RhfK1SMnJM2n0IQhX+FtKjCanDOzFLe87EZGMBB0PajCEp1wCz8kPAQK1RGIy+ySBhVR3OYc3hC9ol8EOcs8h9h0jZPhvY6PHZE1NSo5yHd5wRceWISCwzATB7urI818SH4wtoJxwrdD/sNYIi9JKFpmN233nkVwOSQ3xwaVelodGimGZJo94QMiddQN4ktDGm7XH6AY9vbrLyzAkSKlurkQT1JosT1is05rc+pW7+GC/H9YWAGVOasxYK3wiqa7pIh2oWEhLGin4OVZbe7wefOuDz08MwMeC8D/QTG/eCiPth1VJNhBsuhSJI3Ya0/DTpXptoQp4LucPZo3lPRlMAjgNm35nSLmSyDO3skRmen4/g+8FxAn9Ry5UdRMKUi8HduIbR2yYkAYrK8a6CDDL7oYxtM/+bPM76tsv73X1gMveXRf7NYJOlPRxJ4ay/CN68Z4BrtbnoJ2BE+wybI4XrKoIi2xJW9vMfdV3EN4moSTF9CvmiG256AWY52BviautTZTnRSk6cnK23rO7dCJ2FnPoD5PQF/Bm9DpGqKj/nzM8zcE+nKROta+jEa1SJFmj3ZtIaE7Rv+OujZVtRzWrpswQBqVIbSQSsHhbY0qrrke7tbodzpiOQ+pCgJhM1Z+Plcc+rt3ryuJ3fkvlZcSaZ712Lc+agibPg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(10070799003)(11063799003)(18002099003)(56012099003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eVdhdlBxTkhad3c2dnRvanp0R2hOMWFqLy9KSkxSRm8yVEs5RXk4TjdIaEti?=
 =?utf-8?B?c25STHdlRnMvWHVrR1BkdXZNUEdxV3cyQ3ZTbEM1WXNhMWVoR3hEOVdCUzNK?=
 =?utf-8?B?Qm5ITXZUOGdaVUdNQ1ZaVHNlZkpBVHFwNzZXWjd4MXdtbEQrUmZTbjU2RGwz?=
 =?utf-8?B?eDJ1WG9jR2NPN0NwQ0t4Qk1yZDF2TFl5clBxczZJUkhPYldQa0NoQ0VHVlZM?=
 =?utf-8?B?d2J6TW1nVkxHWUNZVlBtVXJaWEpPVGU0cENzQ0hQZmtoRG9QdDlIeStIdXhJ?=
 =?utf-8?B?MXd4dmlURmRNY1ROQ2hoOUNLWWFSQXl5M0hNb1NUN2duQ0haWVhYWThxcS9m?=
 =?utf-8?B?UFVTbkl3QWZ6YUlMZXdhN3BnZ0VnTnl6MXFlY2VhT0xzNzN2c3FTY1BEMVVs?=
 =?utf-8?B?QUdPRFZreERyK3o1WTRCN2lWUWM3eFRlQjdkRFpEa1ZmMFVxdGpNVnRzZFFD?=
 =?utf-8?B?SVNTc0JPUmZIQzVDblE0S2xrUk0yVW9HWkJlcVRMd3Ixc2dyL1FwbEs1MVlp?=
 =?utf-8?B?UGh2ZHgyWUliLytwUnBSUW1qYURNR1dzdFhSSVg2QUh2enNSYXZ6bkdtOWcz?=
 =?utf-8?B?UXNPTHdzUHdLV0NMS2hxcDZmRDhWaCtHKzFVbDJDc1h5NGxwTGU0aDVZRTJx?=
 =?utf-8?B?WTlXb0tHT3V4bllZb3VVWHd6VjN3OForSnZzc3hETHh2RnpoV0ZSVjNxTDlX?=
 =?utf-8?B?NStNeWtkV2x6NUVZTlhnMVBkMVptOTFFVWhDa1R6VnlNclgrQVZPNjdHazJX?=
 =?utf-8?B?eG1jMmZoRW1TNk5vN01LK0wrMm8zYkxFS1Biak81Zm9XSHBqN3dWczdoRW9K?=
 =?utf-8?B?ZWxIQXI2UDVmaE1FNXBBcW5ucDZYTWQvWHRsR2s2Q1h1YUNabU0yVGFoSE5s?=
 =?utf-8?B?ZkFwa3VPd1cvcjhtdUVhNWZpbTU0UXV6TlhCdktnZWlHWTNaTEJQaW5OK243?=
 =?utf-8?B?RWladkhVNWEwZDcrRFdyVTl0RTY0ZTdJcDJ4dE91SVlobnpjd0VWVldqQWRU?=
 =?utf-8?B?QnY2UEZFdUdCeENKbzZMbVFzU0U5TCtKdHIyUHpWTzdZU054cEZIeTZTWmpG?=
 =?utf-8?B?ZVBGRVd6dGRWQjdYZnIvWDc3bnZyYVo3ZXNqdmlQWmRoWlFBZmVRWXNvejRh?=
 =?utf-8?B?WnRJV0gzRm1kbTdUWmlVY29jZEgwQllXbHBodGYvbnEzRjRtcDI0K0krNjQv?=
 =?utf-8?B?cFpYR0lQQ2FBQmFxQnZzMExuK1RmYkcwc3I5eGFTeGpDMnFtYlBKbEkydTVI?=
 =?utf-8?B?MGE4UGdwaXNldEY5VmlwRVF1QkZGRkNSMVh0emFMdGFVcmtDLzJqNjZ3QVJL?=
 =?utf-8?B?TkwvdXBwVm9ENlZzN1FvYUtTTExJSWlHUnljZVJONm1wMVV4aExidWdhT2Q5?=
 =?utf-8?B?UEdlcTBMQWgrUGs2T09VcEdOR2JBVTNOREhHTDJWUTFpQmlwc3V3a2FmU0hD?=
 =?utf-8?B?Z3NQcUtCVVFiVXdLMm9OZmFRaXlQZTNPRVpZaDg5ODFqSWpKc0dzL0NoYzVK?=
 =?utf-8?B?Z1FLdC9BNmxEdXhFSFc4eW16QjdsZXc4eFlSQU1hNVdjOVpUYWNxZXU3WVBT?=
 =?utf-8?B?YnQwMkxWbHFZU3l1MU5xdk5oUk9uem1MYUFTRW0wbGFoK2RaUEVsTU5XV2p2?=
 =?utf-8?B?eGg4NnlOWTEvaXU3TU00SDJ0WERYY0doSnZJc05SSnk0UUdYVHlqeW8ySWwx?=
 =?utf-8?B?RXlVa3BYREQ5b0l3R1RCL0R2eWJPQ05LbUZEMEpXcGRiUnhOdEl6dGtrM2hW?=
 =?utf-8?B?emtoOThvWmhzMzh5Zm9HbkR2V3VObFJoYVpHS21sSVBoTGEzQ2N0OU9qaGl0?=
 =?utf-8?B?UXNDRDd3NlN1SnRxdUppNThEQ1FFQmlCZ2t2aC9UNVZudS9ueVlFRUVwNk9S?=
 =?utf-8?B?TkllV3p3QXkzdmJaY09wOUkwSGFkN2JDSTZ5eUp3OCtNdlJmbE5XNnhZVHlW?=
 =?utf-8?B?MzdXZVMzd2dzZVdaZFp5UWEyZVNlVmdvVFRLNHE0STFrSzBCQmVhM08vRnVz?=
 =?utf-8?B?bTMzL09aK0pINC9FMEF1Ti8waGxJcUFVQWFFY01lNFpETXNrU1lIWE82OHpi?=
 =?utf-8?B?bzdsV1N3QUhzRXhvK1VEai8xaUh4RUx0Smw0TEw1WXdxeEQvQkhPTlVmTkht?=
 =?utf-8?B?RlYwRUsxbjgwL21JVUc4aHo1TVRkanFDcTFyemlCN211QWdGTFdhN05QcDkx?=
 =?utf-8?B?dms3T0pnN3dka0k2U2dXUHZmcTJSTGJxbDJQb0IySmxNNW5PQXp3T21LbkVa?=
 =?utf-8?B?RFRROXpOQkNzdkd5ODhQY2VjSjhtYkNwc1FOMy9raWRLNmloZWZwWWJsNFUv?=
 =?utf-8?B?d1BncmE3MXJzZUUzS2IzbGh1Z25TMTgwQTdSRzVUZStGcUZRRHBxSFpQdDBQ?=
 =?utf-8?Q?7lJde4WjCcNbLzyRiMYj/Z29Zahu6L886eE5/rZlbmqG0?=
X-MS-Exchange-AntiSpam-MessageData-1: 7s1b9Dlyt6ANBHV1pk0uGGRHq9GIcBp0PVE=
X-Exchange-RoutingPolicyChecked:
	RFrL+Z3F/xq5eF7ODNjy6UKeUvQz54hgZlLOWdFfjhaNouqMogrhb/PZuo4YP1WYv8+2zoyO/TVOjIzp5GR85/UAaD+ip89U+3FP/3tY3VjxB9a+8N4v6OpUZAvZdmdqeuulfKMEEzE2+XzZf+Xq4sZSYZ6IS0TlwpqtSFZBicJsKGjDgmyzt6mJ6NrX166CcfnO+qdJX1VI3RObbiv5SUZjG52k0bqx+aHjK1yR7nsT+GS5aaKBgT/aBLi0y/Dl8EifNXyJnFC4CE8iL8xi9wKJQcB+miWhExlE6MMSYeOzLqIs7l9lYiq7i+1wK0bGiYMlhCRZV3xnNAl/UK0tSg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad1f9b1-dd86-4ac3-2959-08deb0bbf3cc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 06:50:43.2038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUCUwkdwvuinM/DU5e7rvAfRpQYTJpBE2XDHDphjj273NnN+JdrZDUf/MJh81wY3LwFEcB1gFG13kF7ws0qTm5xJ545fbq/8Ba1dl8pxh+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA2OCBTYWx0ZWRfXzeaf+7IWochS
 p6RyZanMok5Hc8WBzsvdyI2FSpqLLQD5pU4cxS3m5PWZX7T9qEsjySnRomax5y/7NUr/P2DEnE3
 bvrXgq05FEoOL6wQLhvV5istyxV8NFW6r6xc+n0NYxW8mVHWZyY6ER/c7xllFWS8317kXQrRM5j
 SpujQ2FE/lKBa18n3W1x9fr6tHkJvDUBDmeZ9hW4o4dWt01IA1/beVU8+VMW7uDMJI4dfAu0BVh
 KJLVjH7XQwiPrZ4w6ycvHpd5bGkLQt8+7kNNL7Ni5xCWii8uy8oSkT5M40XzG8ffdlahIu7eRYV
 4NKnC1LlkRnKTVNUjt3JYtrB7xC23oZBV124gDnoHvGKgGQuBkY3WxggKrMAQPnd9GJPTnoDJDU
 ef5/uf9YhzqAmfQVewDAjW50bZEBvMb1KuU65CMI+oNnIYrHuQ8i6q5swf9N2pS22IHM1pzFpoN
 0ptWUwoaJJOmSGtNZgw==
X-Proofpoint-ORIG-GUID: 5EPOkZQSpjezEkn7HttqQMZDHItUlQB4
X-Proofpoint-GUID: 5EPOkZQSpjezEkn7HttqQMZDHItUlQB4
X-Authority-Analysis: v=2.4 cv=Q7jiJY2a c=1 sm=1 tr=0 ts=6a041f47 cx=c_pps
 a=4PCWzz9QFLYZoRw/GV/NtA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=QyXUC8HyAAAA:8 a=e2ktS5nUjp35XiIGSnQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1011 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130068

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi Greg, Ilpo,

This is v2 of the 8250_dw BUSY deassert backport to 6.12.y,
addressing Ilpo's review feedback on v1.

v1 thread:
  https://lore.kernel.org/linux-serial/20260510134011.618215-1-ionut.nechita@windriver.com/

v1 review (Ilpo, 2026-05-11):
  https://lore.kernel.org/linux-serial/d4b4e4db-505f-4400-c1b9-fe589786456e@linux.intel.com/

Changes in v2:

  - Keep guard()/scoped_guard() from upstream verbatim in patches
    5, 7, 8 and 9 (no more explicit uart_port_lock_irqsave/
    unlock_irqrestore + goto-out adaptations), per Ilpo's review:

      "By doing this you had to add some gotos which makes code
       control flow more complicated than it was in the original
       changes. From reviewer's point of view, the code is more
       complicated without guard() than with them."

    To make that work on 6.12.y, two small additional prerequisites
    are now part of the series (see new patches 3/10 and 4/10
    below).

  - Stop replacing guard()s with explicit lock/unlock pairs; v2
    diff against upstream is now significantly smaller.

Series structure (10 patches):

  Prerequisites (per Ilpo's original guidance, plus one implicit
  guard-defs prereq):
    1/10 serial: 8250: use serial_port_in/out() helpers         [dbd26a886e94]
    2/10 serial: 8250_dw: Comment possible corner cases ...     [bd8cad85561b]
    3/10 serial: introduce uart_port_lock() guard()s            [0fd60b689b0d]      (NEW in v2)
    4/10 serial: 8250: convert serial8250_do_shutdown()
         to scoped_guard()                                      [partial b339809edda1] (NEW in v2)

  BUSY deassert series:
    5/10 serial: 8250: Protect LCR write in shutdown            [59a33d83bbe6]
    6/10 serial: 8250_dw: Avoid unnecessary LCR writes          [8002d6d6d0d8]
    7/10 serial: 8250: Add serial8250_handle_irq_locked()       [8324a54f604d]
    8/10 serial: 8250_dw: Rework dw8250_handle_irq() ...        [883c5a2bc934]
    9/10 serial: 8250_dw: Rework IIR_NO_INT handling ...        [73a4ed8f9efa]
   10/10 serial: 8250_dw: Ensure BUSY is deasserted             [a7b9ce39fbe4]

Notes on the new prerequisites (3/10 and 4/10):

 - Patch 3/10 cherry-picks commit 0fd60b689b0d ("serial: introduce
   uart_port_lock() guard()s") unmodified (13 additive lines in
   include/linux/serial_core.h). It introduces DEFINE_GUARD() /
   DEFINE_LOCK_GUARD_1() invocations for uart_port_lock,
   uart_port_lock_irq and uart_port_lock_irqsave, which are
   required so that scoped_guard(uart_port_lock_irqsave, port) and
   guard(uart_port_lock_irqsave)(port) compile in 6.12.y. The
   underlying cleanup.h infrastructure (DEFINE_GUARD,
   DEFINE_LOCK_GUARD_1) already exists in 6.12.y; only this small
   serial-specific wiring is missing.

 - Patch 4/10 is a *partial* backport of commit b339809edda1
   ("serial: 8250: use guard()s"), per Ilpo's original request:

     "b339809edda1 ('serial: 8250: use guard()s')
      (8250_port.c shutdown hunks)"

   The commit is authored by Jiri Slaby (SUSE) and carries the
   upstream Link/SoB chain, plus an explicit [Ionut: partial
   backport - only the serial8250_do_shutdown() hunks from
   b339809edda1] note. The remaining (much larger) refactor of
   8250_port.c and 8250_core.c is not needed for the BUSY deassert
   series and is intentionally not backported.

Notes on the BUSY series itself:

 - Patch 6/7 of the original mainline BUSY series,
   commit e0a368ae7953 ("serial: 8250: Add late synchronize_irq()
   to shutdown to handle DW UART BUSY"), is *already* in 6.12.y as
   commit 0bae1c670aa8 (Ilpo, 2026-02-03), so it is not re-sent
   here. Functionally this means patches 5-10 above land on top of
   the existing late-synchronize_irq() fix.

 - Ilpo's other suggested-but-not-required prerequisites remain
   *not* included:
     * commit fc9ceb501e38 ("serial: 8250: sanitize
       uart_port::serial_{in,out}() types") only causes a trivial
       conflict in patch 10 in code that the BUSY change removes
       anyway (per Ilpo's note);
     * commit c213375e3283 ("serial: 8250_dw: Call dw8250_quirks()
       conditionally") only causes a conflict in patch 9 around
       the dw8250_setup_dma_filter() helper and the conditional
       p->handle_irq assignment, neither of which exist in 6.12.y
       and neither of which is needed for the BUSY fix.

   Both of those conflicts are resolved trivially in patches 9 and
   10 with explicit [Ionut: adapt to 6.12.y - ...] notes.

 - Namespace export syntax: in 6.12.y both EXPORT_SYMBOL_NS_GPL()
   and MODULE_IMPORT_NS() apply __stringify(ns) to the namespace
   argument, so it must be a bare identifier. Mainline (where the
   upstream patches were written) accepts a string literal. Patches
   7 and 10 here use the bare-identifier form (SERIAL_8250) instead
   of the upstream string form ("SERIAL_8250"); without this fix
   the .vmlinux.export.c link step fails with "expected ':' or ')'
   before 'SERIAL_8250'". This is noted in the [Ionut: ...] block
   of the affected patches.

   Only patches 4, 7, 9 and 10 carry "[Ionut: adapt to 6.12.y - ...]"
   notes; the rest are clean cherry-picks of the upstream commits
   using the standard "commit <hash> upstream." stable convention.

Build:
 - HEAD of the series builds to a complete vmlinux on 6.12.87 with
   CONFIG_SERIAL_8250=y, CONFIG_SERIAL_8250_DW=m on x86_64. The
   .vmlinux.export.c link step (which v1 originally tripped on
   during development) passes cleanly.

Testing plan:
 - Same as v1: test on Intel platforms with DW APB UART
   (snps,dw-apb-uart) running 6.12.x-rt (PREEMPT_RT) to confirm
   the original symptom (LCR writes silently ignored under Rx
   load -> baud / framing mismatch after set_termios) is gone.
   Will report Tested-by once cycles complete.

Based on: linux-6.12.y at v6.12.87 (8bf2f55ef536).


Andy Shevchenko (1):
  serial: 8250_dw: Comment possible corner cases in serial_out()
    implementation

Ilpo Järvinen (6):
  serial: 8250: Protect LCR write in shutdown
  serial: 8250_dw: Avoid unnecessary LCR writes
  serial: 8250: Add serial8250_handle_irq_locked()
  serial: 8250_dw: Rework dw8250_handle_irq() locking and IIR handling
  serial: 8250_dw: Rework IIR_NO_INT handling to stop interrupt storm
  serial: 8250_dw: Ensure BUSY is deasserted

Jiri Slaby (SUSE) (3):
  serial: 8250: use serial_port_in/out() helpers
  serial: introduce uart_port_lock() guard()s
  serial: 8250: convert serial8250_do_shutdown() to scoped_guard()

 drivers/tty/serial/8250/8250.h      |  25 +++
 drivers/tty/serial/8250/8250_dw.c   | 296 +++++++++++++++++++++++-----
 drivers/tty/serial/8250/8250_fsl.c  |   8 +-
 drivers/tty/serial/8250/8250_omap.c |   2 +-
 drivers/tty/serial/8250/8250_port.c |  90 +++++----
 include/linux/serial_8250.h         |   1 +
 include/linux/serial_core.h         |  13 ++
 7 files changed, 338 insertions(+), 97 deletions(-)

-- 
2.54.0

