Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F8B361DB8
	for <linux-serial@vger.kernel.org>; Sun, 10 May 2026 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420485; cv=fail; b=KsWiMuYsYdtTiQhA9zW3XUbk/JelQVulENOu0KBCTJHCKOyKpLIro0ytJ0wwymQRLVws7FzYiE9jY4wLCuZc0o52qlbus9Sv6bvi8ylWW2F/HKt99pL8CemV5Tt6IKaRB70nQiTPTtY8dbVlYnI3Egh/4FmAhA/mknBKmMsYvEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420485; c=relaxed/simple;
	bh=5ySS+y74ECDJxBGoFMFPWL2IYbi564aY+AT0NESw/F8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VjdLAPd2UxnsVqA4LSNeH5yoN0XLhGnFgdzBwvOZ0cjNzrOh90i00LWu1GdShEN+TmGLlB3fpOjOJfPZIDZ14PJxSqh6BgbxJEbbpyztSNWHEgU3S1ujxlaALiR2t1cC3gCtaNrIK5x20SwGd+k6f09hri7AK9SLTNv4FeHLE0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=JI6HpWe/; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="JI6HpWe/"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ACcZpH3617658;
	Sun, 10 May 2026 06:41:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=7bFKEuffEqT2SGFVqfHr0B0v9gkmRQUHTJqUC4gHeXw=; b=
	JI6HpWe/03cUWlHXXRA6/h/bb++Tm/HYUKi2bmpCQaG2V59oHK49NraNxyRX9IlF
	7VFum9ZkoZqtmFzAKzF4IQIs4gOOAFKn9osO3TbQKZiTzF+S4ocBJ10TuEOJ8L2M
	JaAybg3i7qo8K9dnNBqgY7WIpzQUnde83THNxPP2XsvwXDCD5DoFlOSz3lezzv/q
	e3fvet8Iah2N+j6GVRp65UiwAERLD3dQaM6bNUlpobhPdgs+dB+Q8i4uOzHeCWmQ
	DzrZlZ94JxqlZfmz0Ga+wWoeK/z/HDWIaB/VU3sp1tU/eG9mrQka2qJhEID+LLim
	1YSiH92DKBX/YqJ6luN6jQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e24ee8qf8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 06:41:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUKQsPt0xeCcjN/nJ3yi8ydBDrDR24PpxaAi7ml2JGzgmxHAoUyWYchSspc3P7LhlQVxq9xMND3mE7JQ2kxTCHkvrRcfY8mobryTPYCteA+3cXXB90ROYvWSJ6th3Hldy+YmS8AZFBYawM1WsRjSTZTAb/mt8UfzLCuQ/GdTtdzoyPc8WQWIZVnkVYoQnmczGCMsz07Kptd5jEaj2eQWlglznkAmzrQnTTHhadXLTsE9t1lUUNk/6bxkFOWBw5QfSRfOTvq/g1j8VqbY8yudnZU5jLc3RntqdK6QN0n7GIWRB0jB6Jeuxsw0kmKzRuic5be0kfL3ZiylItdnHW5NXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bFKEuffEqT2SGFVqfHr0B0v9gkmRQUHTJqUC4gHeXw=;
 b=GDkPCyDDgMSrjHjeQRG7ujG2bgtvSnAdhbSx6Zucdi7HOF+WJ7YdbCeqnqS7QQZNyg4qvbjXhs8iKlhmv8ocvNwb9PFnlgBgaqL0DqGFTcFnceukUT+4ElMaVkbkZT5Ma192sYpH+SYlBwKzJwA5UrwhnYZo1cjtdA3quxG6+T95zzl1JoniGJTwgDTcRtSso5oAsaSxQexyHhSYLqbzWlmcAwvDf8grzD/kwSqeJtW3XxOTwa784sJELgkgeaeX66z7QBShdiXefxAM1X1fCBJz/kM1It4rYtPbPaSYdZdLGd0VyvFwk9hKwPiNyYLRKvNR3sDcxggeypscW5hTWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by CH3PR11MB7674.namprd11.prod.outlook.com (2603:10b6:610:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 13:41:13 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 13:41:12 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc: andriy.shevchenko@linux.intel.com, linux-serial@vger.kernel.org,
        "Bandal, Shankar" <shankar.bandal@intel.com>,
        "Murthy, Shanth" <shanth.murthy@intel.com>, stable <stable@kernel.org>,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH 6.12.y 6/8] serial: 8250_dw: Rework dw8250_handle_irq() locking and IIR handling
Date: Sun, 10 May 2026 16:40:09 +0300
Message-ID: <20260510134011.618215-7-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510134011.618215-1-ionut.nechita@windriver.com>
References: <20260510134011.618215-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::15) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|CH3PR11MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: e83d1e17-dc10-4d31-3d9b-08deae99cd11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|52116014|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	TSrhuntWDQ3LzL1/MtJC+hhq2EJtghshn5t/2cLBXbUEw/MwHyIgvQxTpJs+YCQfHxO6CNhJ/TtHUSH9uKG2BU9hZDrkQ6k5ws8nMlxO3T/tdBL0P9YhkQYPfFWCgOLYh6tYi7M3q5DHLsjow+EvIaMjWCjZYWpC8PJVLTs1aVytGfEgf9qZhUshRtFpeT0iY3SjK2JwxJz6L1MmLkVsFVa3AhVl6Cewprk5gZB6FMCtcrLgQRBz+i/4aEgfOQGRnEjRvWWTPerGlqW6E4+W48OSHbDOVB6oQPvKYhjSKLjz1rYks7xciZ9jv58B/XvG+huzAlBbE/gBXxaX477cbIbhAhpIqHN/UitCtrbBpW0upjGiUmRaLIRcoOZBgJrQp0xFMpxJwlYOcUYPwe57oy9UmlQ1lY8tQGEOsjdEpoHwDjTtHImAcxOxa1NE5WezeAei0vdhKDG+rULSIiJL6x4YcEj4WqG64KQmPK1oAaM97s8j5kO/meLqVN0dWAVUQ2K9GlqHP4AvOtQLt0vS6bgHY9xh1Z0M1KcDOENsQoXzvPI7Rb0LO5fP7FG4ez2LavyVipyLRQSWvm6u0ww8DGGZ1CNdk6lP535xHEhB8IUVywjx9fLSg+IBoIPXAP5RStJdHVv1HCou798F4gaYWQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(52116014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Skxkc01WTWgzekZDbUhucmY1VzRCUUJVbTVBWFp5T2xxbG5qK0poaTFkZUpx?=
 =?utf-8?B?ejNoWkZrL3VqNHVJbFBqZ2RzOUpEWmFYTjRvWG5jendKZUQwdkdkTzd3eVgv?=
 =?utf-8?B?cXFEODROdWR3Z0JiNjhRL3JRQWhuTnlZMk9ndzR2SmlUN3BlVUpGWisyUHBC?=
 =?utf-8?B?RzdObnlQcHZoT2JjWmtqckpqWWZoR0tPMjI0YU1mdnM4RDVVRmQ3bkF2SUdE?=
 =?utf-8?B?WTIwNEhkUmxYM3hGMXJqZlpWbE82YTVhS3VncWlHS0lRVnMzZ3c1cnhtV01w?=
 =?utf-8?B?bFdRUFV5eGx0eW0zd29HM3ArYmFQY01QL1NNSnpUYnlOKzZrSFVVazc1bXlI?=
 =?utf-8?B?M2pIM1hCM3lGRGxTMk4yZVpONUk3d3RaV0dYZ2Q0WlZ1NXVURGE0UnQva3Ez?=
 =?utf-8?B?VjdaeGR6TG5QSzAvU3RlZ2U1UmJZUjFXUnVjRUJrdnBkOEVMTFEvWVhicHpB?=
 =?utf-8?B?dmFZanlYcFJOUzJqcVJBNjU1b2xybFlPclEzL0wyK2FpWU5zSkM4VXpXOW00?=
 =?utf-8?B?NjEzTkpYcDIvZWI2Y1N2Y2xxQlE5c1NCc0h5REk4VlJKRjNHVUNOQVNhWm1n?=
 =?utf-8?B?bGhaQTFGRkI5Z1F0c0Q1eXJSV0VWRVZtaGFmT2QxdHF5Q0ZLWkJaNk02YzBB?=
 =?utf-8?B?NStYVTJQWHhDcXhVZEI3RlYvSnVOOTN5U3hBLzl4WWthZEpHTmpORzltRHZZ?=
 =?utf-8?B?Qko1SWlnaDc0SUxxalNubUhvK2tpZ29vTHl6ekxZNGFsUVBvbWlKUWhTRG1r?=
 =?utf-8?B?aEcyMTA3T0lrYjZaWk95TFE0UFpPTmF6L3dFQnJUekNoUzJZQklsNk5hY3hU?=
 =?utf-8?B?T3BjNDFYT1N2REhtajY2a3l3Qng4d0ZvcVowd1cvdG1Vd2p0eXltRGZYeW5w?=
 =?utf-8?B?UnhoY3pudDJjWDRFZ0Mwd1VBREl3a21tdDd2RGNiRlZtcmdUY3NGcHp0M3Nx?=
 =?utf-8?B?M2FzME9MQjVuS3JmRnRpNzF1RUNHTFRWRVZkcVRnOEZMRWl0a2x4MjVHRHJr?=
 =?utf-8?B?YUVGRElCWWVwRWEyTWJ0SWE5V1FuVjlpUERETHcyLzdvTHp5VFZIU2hGNC9P?=
 =?utf-8?B?dUFLVGZqNmcxRTNzQWxCZHozSXFNUFhEZVRtU1llNzB2elJ3VjB6amJhWHZl?=
 =?utf-8?B?UnpvR2RweTlyYnRTVVdWVlY3SEt2TXNaM1k3S0ZMUmxkbW45Q1loOWFpRGZH?=
 =?utf-8?B?dWxadmh5TnN6ZmxYYXg1enBZWGxLVWlPZkpsTU9FUkFNT3lSNkpQbTVjWjdh?=
 =?utf-8?B?amMzN0plVmQxMjNxbE0xVkdhNGs2RDJpaUtPc1NWaWxWcVpkR3ZSOWx2enp2?=
 =?utf-8?B?SGR3MjFIeXpqcTB2Q1dDQndsL3hYTkJOMTFVSDlCR255ZVE5ZklvTE5UMUhO?=
 =?utf-8?B?SnlMZVRoNVJRWElRM1VRSjEzL0pTd0RoVFlNUDFpbTVvb3lsc2I0SHc0L0g1?=
 =?utf-8?B?bHM0NWwzS3VBYUFGUWpzNHppU29QRGpuUmF2ZjJkdXErNlArVkU2RlJIaUZD?=
 =?utf-8?B?SEZMLzhnWUlscWNGMFBZZGNjRWdPZFVpenl6N2tTMHd2bW04WlNJVXQ4UzRs?=
 =?utf-8?B?NTRuREU1MkxJeUNsL0wyQ1pNcHFjNEhXeVoyQVVRWmduK1B5UlRJN2krYjBm?=
 =?utf-8?B?dWhJRDg5cXM5bGM5TWoybXp0WktUZTgvK3hLcDF3NUtWMmtZbm13bERER0JE?=
 =?utf-8?B?S3dQS2VJZHNiTFI0bU9ibWoweHc3cVNscEVibFNacGJFL01MY0Y2V1E1MTJz?=
 =?utf-8?B?WVdRMnp4TlFFMzBaZzNNQkxHS0k1aU9KM0xEMHNhZFNOZm85TU9ZSTV1VDVQ?=
 =?utf-8?B?eStwUzlhblBIRmpMZ0hQcXdaVEV5Tm14ZnZpaWYvYWdwS1Z1NFJINWJtME45?=
 =?utf-8?B?MmowZWJFYkViVjJMTTlXSHp0YzJFV0Zpb1M5WWxZVFFJeEJHZHd1YVNBMUZQ?=
 =?utf-8?B?ZlUzWmdJZENEeExSRjZwSU9jdEx4T0R0MlZoVWlZdXRzUFFsOUMxcE5kbXh0?=
 =?utf-8?B?UXNwWU5EVTJocXVMY281VlVpMUxwazVROHBrV2YrMDMyVUQxYUlmMEJMWlBw?=
 =?utf-8?B?Z1FWNkZ0V3BKUWtCU2lQeXhhVkpodXdpN1NCUWNuWmRpcm1WRDBlUk9LTG5L?=
 =?utf-8?B?dEY0WTFGNEhFTHJNNjlzbEpFL2VzRTg4QzI0SnBXcGNVbTVrQlNFZEtFUm1j?=
 =?utf-8?B?SjZ2S3NFMUZxUE1UQ0owb0UrVGthRHhjVjRva1ZMS2Jud0lpRHd1NXFkdkRG?=
 =?utf-8?B?L3RBLzFzeDJvbENyUlIveWpFVGdjRDJjdTd3U0JaR0xQWEZvR3EvUmtKbkgy?=
 =?utf-8?B?dkJ4Q0lBc0hIa3BOTVRKUE1HOFhuWDB5dnA3RkxzRFZTQjF5UndjS1hQL1Jz?=
 =?utf-8?Q?rgyhrIM62ohwOGmVZ8dUt4TQgrm05lu5GQq1ZbLRweQO3?=
X-MS-Exchange-AntiSpam-MessageData-1: UDtUI3poD4ZPJZgSDVaahAypfZ4Z8/ris+8=
X-Exchange-RoutingPolicyChecked:
	p3Y3s90OFcIhQE2JDlqf2g55Xw2yOUwd2/8nSwLqWufmJmElFCWB7VtiImPQhBl0X7KdepQjzPzTQ1Ve7PyNRiRDx8c49NjsLOrKD2sfKW4B6Dpcqld2bOdG1hCXrUUOWB0nA2HgL29H2tGldQxhtwr//VSkFRYa7vZ0sQGCKvPQo11lKTsUdxLy4yWG+TouXral5h5Utj9bdFJV5Q1BvoAJm2Zp0Mk+L30wM5RCeXJjYAJP3hOS24xFFudHj+82Uk8/ZZg48XG1k354sujsQKczBlLcq4YtJfKwlIpO7eJiNbckOy34abWui4vV1jaqpzU98SejFVHzupyF+zDyPg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e83d1e17-dc10-4d31-3d9b-08deae99cd11
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 13:41:12.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1WVn4bG6Ow5mhyIJOS+/0NNYJKNFb1jfN/VlNdsjIxPxrHiGhjiS3bjlvDNm+6+zLW60JNhopxu38HXtEybY1BpZ+wpqIPfC9vug6dvgNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7674
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEwMDE0NSBTYWx0ZWRfXweih72rFV6RN
 Wjz5zq48hP5LxJTAadv+oYK7EJUhqPTyYi0NpRT/H5f4DnFd732CpezDdgztxiafo40Zidd2Ull
 nMtrvUFK48A73DT6WZ8S0TmKNXczJswH/M7xqBZ6U4uEUxToAuzZZvpa/WGwYaqdwKfiwYeiqS/
 iYtNO5l9THUzqRenVwyKBkpSgIPwQBJltF/3OG3BMhY5ZNozRTf2VUJNsFeuhb3+YfqaRUDeWXA
 mhMfJNKFWPgvhK+J+CsVAinVJkmS7gajkNC+COMiyRGGYd+7FvdP/8WXpJDFybaohQFVzvcusOH
 EWjvImUf5j31UvMnP9qdAfrstUg+Hb8s6eR35+qn6v+CUs+fzSiVJ+dawscFO0VuHxYjJEDpjxk
 4N4gb3z7rNqcDbp2NRB229rOs4jusNaXnuhODZLJXoQxmLVDyaSkKR4W7eva5Nr0CrSqgKAuikS
 0BThSLCw4vKUCGEqK6Q==
X-Authority-Analysis: v=2.4 cv=H/TrBeYi c=1 sm=1 tr=0 ts=6a008afd cx=c_pps
 a=tYxZZT+6B+k9mAKHHpnGSQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=bC-a23v3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
 a=t7CeM3EgAAAA:8 a=TH5hbuvlEemxXucXooAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: vVsJneyqwZZ-j1-JT62_M7hJFN2BDlxW
X-Proofpoint-ORIG-GUID: vVsJneyqwZZ-j1-JT62_M7hJFN2BDlxW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-10_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605100145

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

commit 883c5a2bc934c165c4491d1ef7da0ac4e9765077 upstream.

dw8250_handle_irq() takes port's lock multiple times with no good
reason to release it in between and calls serial8250_handle_irq()
that also takes port's lock.

Take port's lock only once in dw8250_handle_irq() and use
serial8250_handle_irq_locked() to avoid releasing port's lock in
between.

As IIR_NO_INT check in serial8250_handle_irq() was outside of port's
lock, it has to be done already in dw8250_handle_irq().

DW UART can, in addition to IIR_NO_INT, report BUSY_DETECT (0x7) which
collided with the IIR_NO_INT (0x1) check in serial8250_handle_irq()
(because & is used instead of ==) meaning that no other work is done by
serial8250_handle_irq() during an BUSY_DETECT interrupt.

This allows reorganizing code in dw8250_handle_irq() to do both
IIR_NO_INT and BUSY_DETECT handling right at the start simplifying
the logic.

Tested-by: Bandal, Shankar <shankar.bandal@intel.com>
Tested-by: Murthy, Shanth <shanth.murthy@intel.com>
Cc: stable <stable@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://patch.msgid.link/20260203171049.4353-5-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Ionut: adapt to 6.12.y - replace guard(uart_port_lock_irqsave)(p)
 in dw8250_handle_irq() with explicit uart_port_lock_irqsave/
 unlock_irqrestore around the post-switch body; the cleanup-based
 uart_port_lock_irqsave guard class is not present in 6.12.y.]
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/tty/serial/8250/8250_dw.c | 36 +++++++++++++++++++------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 05e45b63e5f5..1076b72c120b 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -9,6 +9,9 @@
  * LCR is written whilst busy.  If it is, then a busy detect interrupt is
  * raised, the LCR needs to be rewritten and the uart status register read.
  */
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -40,6 +43,8 @@
 #define RZN1_UART_RDMACR 0x110 /* DMA Control Register Receive Mode */
 
 /* DesignWare specific register fields */
+#define DW_UART_IIR_IID			GENMASK(3, 0)
+
 #define DW_UART_MCR_SIRE		BIT(6)
 
 /* Renesas specific register fields */
@@ -314,6 +319,19 @@ static int dw8250_handle_irq(struct uart_port *p)
 	unsigned int status;
 	unsigned long flags;
 
+	switch (FIELD_GET(DW_UART_IIR_IID, iir)) {
+	case UART_IIR_NO_INT:
+		return 0;
+
+	case UART_IIR_BUSY:
+		/* Clear the USR */
+		serial_port_in(p, d->pdata->usr_reg);
+
+		return 1;
+	}
+
+	uart_port_lock_irqsave(p, &flags);
+
 	/*
 	 * There are ways to get Designware-based UARTs into a state where
 	 * they are asserting UART_IIR_RX_TIMEOUT but there is no actual
@@ -325,20 +343,15 @@ static int dw8250_handle_irq(struct uart_port *p)
 	 * so we limit the workaround only to non-DMA mode.
 	 */
 	if (!up->dma && rx_timeout) {
-		uart_port_lock_irqsave(p, &flags);
 		status = serial_lsr_in(up);
 
 		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
 			serial_port_in(p, UART_RX);
-
-		uart_port_unlock_irqrestore(p, flags);
 	}
 
 	/* Manually stop the Rx DMA transfer when acting as flow controller */
 	if (quirks & DW_UART_QUIRK_IS_DMA_FC && up->dma && up->dma->rx_running && rx_timeout) {
-		uart_port_lock_irqsave(p, &flags);
 		status = serial_lsr_in(up);
-		uart_port_unlock_irqrestore(p, flags);
 
 		if (status & (UART_LSR_DR | UART_LSR_BI)) {
 			dw8250_writel_ext(p, RZN1_UART_RDMACR, 0);
@@ -346,17 +359,11 @@ static int dw8250_handle_irq(struct uart_port *p)
 		}
 	}
 
-	if (serial8250_handle_irq(p, iir))
-		return 1;
-
-	if ((iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
-		/* Clear the USR */
-		serial_port_in(p, d->pdata->usr_reg);
+	serial8250_handle_irq_locked(p, iir);
 
-		return 1;
-	}
+	uart_port_unlock_irqrestore(p, flags);
 
-	return 0;
+	return 1;
 }
 
 static void dw8250_clk_work_cb(struct work_struct *work)
@@ -859,6 +866,7 @@ static struct platform_driver dw8250_platform_driver = {
 
 module_platform_driver(dw8250_platform_driver);
 
+MODULE_IMPORT_NS("SERIAL_8250");
 MODULE_AUTHOR("Jamie Iles");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Synopsys DesignWare 8250 serial port driver");
-- 
2.54.0

