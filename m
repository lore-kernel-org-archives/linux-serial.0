Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA2A21ABC9
	for <linux-serial@vger.kernel.org>; Sun, 10 May 2026 13:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420486; cv=fail; b=Azg02II7druQYFFYNSEr6OHsfW6bXk2Ojd6b2wSI1ZKkFMk4IfXcyq4zUBgiRy0Ky4sX7c4VXnpS3xQsR9Fa1uSkH2IgrkHcMcwIBTOi1s0iVOJviKlcyyXElNHvgak7BNaarsllbYqdR8Lt4yZyBk2+39qvP6rWSUuBhrnPwTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420486; c=relaxed/simple;
	bh=Clf9/7vFgQ1lvVyYCyLk2YMWw7+X/yG0OOt2l8AtNDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lSB71ZlhMQHAKXWRYMIdWU9f+zJjw2R26DVucLwb8wNtqqKunBtI/l/okx1tPLz5Yl0REGGvvkA0z8eI4BHgeP9jm5gV6cU7qBpKz/ANLiIXVmNAaNVtOMEpG0dX2TuOFGeUdrlSNsa04Ty6QiWnZ6y+w0/BVb1k9Y7I4hK4rss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=UClVMNYb; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="UClVMNYb"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ADbvkW3136583;
	Sun, 10 May 2026 06:41:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=1LLX8xpfMs3Ts6RixrE6S1HmALfF/XfQY8Yurk6/4KE=; b=
	UClVMNYb666OC4jSu/FCA/35WTu1WWuN/LktCFNd0OCq911Zu2ivI9hnTabGRFQ3
	ox+CXoK2xk8TUhfLKim2VdM9gs46cQp2OVpwjIt4DHNtoja+gvq/lGC9g/HWmOKp
	UBp2t7y7IsCDgomkNMlsZDu57q7MwsoXipmHdeVTRl0+GFDMngBuvq4eovlyNzRQ
	6gI5SdJnnE2j71YlEbsgwc/pcdtXi5u4S4pHSm/fVJQVxH2j74XettHW6kBIZDGM
	q3k5LE3brg7ifpCNQOozO1isGD4HJuEjQ2etlmcIiHeR51F1dkV2dn/h+0H9KGGu
	t/hctyp9pj5X8X8/lZlsxg==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e206xrvt7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 06:40:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuQPBa1lSpM28hsbs3omyIm9YrZMZjV1OcchZXj3cxxlkV7yq4h9C+SdVZi8RSXHIOn8EBsfaz12e6ekBwyRm3YhbaGcNDmqOqL8TWNgiebgw29KQBIh+/Fw2mqYi6fhuTAS4polQHE6OornhliLW7h3TO6+LGv9OF6dtZZybrRKgEw91C/rXZTmMQzd2rnLzkuasf/wMRtgGwUU8nNOqQUPQJxSRkFN4qjGhioF3iGKIoXghS47xvIM+fFntCO9wDbO0eSrOJT7+GeTgdq0bxffBbWZ/fkm+HheNWOSPQtRMdBBjhDPzQ+D35pm3nmMD49k/3Wtv8/nAdCeK+uzcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1LLX8xpfMs3Ts6RixrE6S1HmALfF/XfQY8Yurk6/4KE=;
 b=dzoSYlJ8JdMUHHszk/N6vh8q7bwOYbUxtnZpBn31milcfVvPWWjVSJ9djj8LDOTNZnF/DfprvDI8V8yh2Bcd8vT9i3a8IDo/gxC8GK7v5Da1JpBOJCFsxgagU5F39tUkl2VheVwMndqa4Pxyb4hE5bO/HQfWv+q367oUus8F0bwcLh8P6RUUSfaNoCWkEjtX4h5kgjUewHYV8cHZrXBwUFSXWzsp6IWYrtprgfneFkpz1koMPITE3V/EV9jfZRuWTYbhckvnulBieJXtV3V+JlCPcOn/SwILhEiY0DylJNpI85ls8W784D1aAvfvZzvVY8XxSyW8xPjxly3rn7ljbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SJ2PR11MB7454.namprd11.prod.outlook.com (2603:10b6:a03:4cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sun, 10 May
 2026 13:40:58 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 13:40:58 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc: andriy.shevchenko@linux.intel.com, linux-serial@vger.kernel.org,
        "Bandal, Shankar" <shankar.bandal@intel.com>,
        "Murthy, Shanth" <shanth.murthy@intel.com>, stable <stable@kernel.org>,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH 6.12.y 3/8] serial: 8250: Protect LCR write in shutdown
Date: Sun, 10 May 2026 16:40:06 +0300
Message-ID: <20260510134011.618215-4-ionut.nechita@windriver.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SJ2PR11MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5da393-c265-4a42-9677-08deae99c45b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|10070799003|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	TFMKQXSDbhMWQEUPaCMfHcoAjd0AonPoBWTAq+Zjv88aYPdZTlaP+ttFjgTu+ygJNiVXE9fKgiGlNdNOzwBXAa86+G2VmCxzJ9cjc4gdxoQPt0gqTdL/2eHo4oYMNF49b0EnD2LVP8zGf1S7zTgDCoYgUvBp18zzYgYxc1h5nOwwfQKHcWRxmqifjjOFFR/ZecA40Ty3OCl1iW01BZYjjFMWhHi30Kjhx8AMYkqAIGAQT7JENb0mYEN+XROFNqfwQo0zVFusiSkdhyK7R2kzFgJqxi5CAPYlKS/6+bSb/iMYtiXGXZcm0k7jMNZXF7W040iJPeORzU7Ea70DLWhomPPQLKoO0zTwgW4psarFhnqd8LbvMTTyLjIGWNuQ3vDJ4JC5COnrxOn2hI/uv40C/VZvAQHbC8ZrA9BMsVo7PBXS+rOLtBzso3XcX3YX9CLSwu3DrSxCOrReq7QaRMw1r64L5nzVf3QYRe8nzPDwwaS1+OdACJiSy7h2HydmY7xUnCTg16XxWx5CUxJKObtqrJol7ln5vr220exGmAmmbWqXYmKcRJ3/xawqaDRGBTAuQEk1dB0OsAWANv7z/B6t+gaoLryr8GcvvRljDKxTr4bx1Om9FgMiAcOWcjWKg8FSnGzkMlKRDBpO6k1NIOFk3A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THIxVkVUd1QwOWZwNklVS0tjcjVKSGlwcHZsSm1jamMvVWpPMXlTK3hvbmZm?=
 =?utf-8?B?OG9lWXhFSE9qRmIyS0g1eFhWVzdDdzNtR2FHdUFsMnFuTkQ3VGMxOG12WjdX?=
 =?utf-8?B?M0l3bzNNbzJzY1VOanFmZS94MTBRVkJDZWFhc09BMFFkOVRYTXhKVkpRZmZG?=
 =?utf-8?B?OXVmRFM4NU45bDNndjI4TEtmTE1VMDhIb0dxYkpSMDljY05FMGswMFNWSEJU?=
 =?utf-8?B?YitOL3lOMStYZkg1Z2t5bEMzcmpYWmRIL2p4RkM3Z3ljMjRCWkxTSGZNOG41?=
 =?utf-8?B?WnhwTG85RTQrcHVFNEo1OHZuSkZXaks2QlMyRzB0WnpiTG1iSy8rTXFVbWJP?=
 =?utf-8?B?ZDBScmpHKyt0MFBVTWhHRW9RSzhHbFFyY1hzSHRoS2VDMWFqQ2pQUUJveEp4?=
 =?utf-8?B?dkN5bHNPM2ZzY2M4b2F1bWRaREtZUHdjN3lBTkRXRmJtTGMwVHR2aExnelo3?=
 =?utf-8?B?WGpwVjRUUEkyZ1d1NG1VLzFPa2xTaWFjcGRPM053YVBmMGNjcStGTVNOSWx6?=
 =?utf-8?B?WkNCWUNSRnZLYW9UNThYYXhYa0dvTFNicUEvUXpYdFI1UVVOWWJEZGp2NUNM?=
 =?utf-8?B?S1VjMzFGcld4TjRwRExmbW5WdGk0TW1tU0pEMjdwcjVreEgvRnNXaU9Ubys4?=
 =?utf-8?B?Zk9HdktsOUFERlJHTlJBMFJZTUJneHdRSk52b1VHS1cyMlRBT0hLbUcza2Jx?=
 =?utf-8?B?dFg2aWpaRXJoZHIxcTF3R2M3dllFWm1oTzJTVkpraldvMUpPQzhoZ1VjdDdw?=
 =?utf-8?B?YnQzKzVXN0diajd0V242dVBldE10Z1diSTY0MCtNRjJ3a2s5UGxLa1k1aURU?=
 =?utf-8?B?VzJVM0pINzN1clBja3ZNUHhZQ2d2Y0J5OFhoWklEM2txZ1p2eUVWWUZjVkpX?=
 =?utf-8?B?U205aURoUStVS094Q0ZPOWk4MHZySGoyZU9NNi9GS3JqTVdSTGtkblc1M1Rn?=
 =?utf-8?B?YXkrSzA2ZlkwTFAzWHhYSTBZM0t3M1FERVFiTVVOUS9RNTRRVEdhZU4yUHZS?=
 =?utf-8?B?ejBqQmhjWjBzZm5yYzhMS2p4ZEdYQ3RQT0dRYWNiQ2NPVUdnVHg5aG5mdmxp?=
 =?utf-8?B?djBkTU5HU045S21pYzd6bzUvRWl1NytVR3hHK1pKdE5ZL0tIblhHSnU0MzVR?=
 =?utf-8?B?bVpzU2NselVCMTRQclEyQlNpUUZERGIwZG9ic2xWVFBkQmlHQ2w3VC9WbVcv?=
 =?utf-8?B?TVdzZTlRWGVmOG9mUmRPMHhyVVRUOE1rTGJiKzVSRSt4WmluL0xVZUZXS1Vv?=
 =?utf-8?B?amVxUGh6ZUpaSjQ2TFVzbzJhWWJnUXJZaDl2d0Vwa241eW1BRlhkQ2hNakU4?=
 =?utf-8?B?eTZ0SHk5UHJrNnFRODFjc05WN2RwR3FFYVBLUXBUQmdwcnE4VU92NVgyeWpG?=
 =?utf-8?B?NWozSHdvMVNFS2hCQkR1YVR5NHd3azlMSmxwV3BrOE9ReE41d2g0ck1MVkhK?=
 =?utf-8?B?QjAvd1l5OVR0c0lGRlNvbHc0eWE0UE9EbFR3dzEvVW1IYmEyK2hIbzh5RmVR?=
 =?utf-8?B?Zmo3MmlvTFB3enNsOHdoZWxmMGJOL09oMkU0bVIrR3RiYVFxR0MrS1U0YUlV?=
 =?utf-8?B?T0s1RldFa3pua04xNlBkeVY3dDNwRjUrNE5pQzc0YjkrVEVKL0pQUVZ5NC9h?=
 =?utf-8?B?YUF2cFBDQyt3VWUvbmEwMG85eXdsZ3BEKzlNdUMyNlBzUWRaeTB1blkyc25R?=
 =?utf-8?B?cFN1aExiS3hSU1ZLVUcwUkt3bDRremU5R0lOSTE4SERpVzhxZGg1NkpMMkdE?=
 =?utf-8?B?dCs2UzRZc0I2dDVEZ3luMlZGODBLKzh1NkRrdThRN1ZYR0laRENPMzV6ZXZz?=
 =?utf-8?B?SWs2OFpkdEQvUHlVdkExM0RtdEc1NmlBazhjZ1Yva3k1Yys4TnJNZkUrWHl2?=
 =?utf-8?B?d3JVRUE2bzRsa0FEVGdHeXVmOVVHN1JONXFKQlhJT1lma2pHcHdSeFAxMkFJ?=
 =?utf-8?B?WXZLblpQL25SVjlVOEdqc2xOYVVRWHphck1rcXdtN0gzV0FpdXBYTTlLbkVh?=
 =?utf-8?B?c3NaNUltWnRNcUxXQTgzYUUvL3ZjdWphL1YrYk13UjE5RlJhZ0Z6OVpaWGw3?=
 =?utf-8?B?dEkrbk4xdGZIQm9pSlZqakFmUG56RG02cHg2RjdJT3Z4VHduSEdoQ3dyNE0r?=
 =?utf-8?B?ejNvdGtpdTJibFZKV3hXS1MrUy84bEg5bUlHb1Nzejk2NXRZcFF0U3QrR256?=
 =?utf-8?B?WElNT2dDUUJDUTgxTVVPdXRZQzN2RHJ1VXEwMnk5RXBhYlVaWGpQYmxmcUdJ?=
 =?utf-8?B?NkVyNGpxUEtVZ2dnRHorWVQrV1dBSmR5ZW5iYkYyWlA1WDQ4bXFPSVF0amc4?=
 =?utf-8?B?ZTdxV3Faa2JxWVJrUlAvb3F1bGdtVk50bTViK3ZjLzFYSWVwV290S01PUWpB?=
 =?utf-8?Q?V8baQgs5m0fejpfEZaGybAj+aYlHjfye/+yGdi6jeR9DR?=
X-MS-Exchange-AntiSpam-MessageData-1: T3SK0kT8nstMqQAcvQkNZgb0WgKeXTa8+qI=
X-Exchange-RoutingPolicyChecked:
	RtNMrDRD7hkJRGHHWRidROXARYPxq5o79F/MVzKdst/35bHb84SkmTTAXaxsomtZRmacmhIYQVTL/Hom3dbaUhdEx6P4svVcAcX4zaDsltJgU1geuZeZIhT/EHz138UO7iv2o6O34caA0ZWuliLIh/gk5xeF5KBJwW8OiIlX5tT40bJckK6jYli8pEnClV8ZXLRxKWhBdTukkIFv1Qvk5Zt3VZbYq3X50lheIgTMybosjvvovBymLQSbgwF+wIhb0gX4TObi9XFYd7lYndJG0RK/2a5mvteopYuo154VAZN4OUMxri+/gFksaOGmXHZLpwW87uXYMhC60d+3UVRKog==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5da393-c265-4a42-9677-08deae99c45b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 13:40:58.2201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88jufBH4NLnQpgMhtQzPBoVddSlq4uaA/n37D6yPoPt1xcrrn1KEvvXmMHp3Mzyl6pNA9cOsBmTsH29U4mbP/SmLAs6et6hdR4ZVkjqpHDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7454
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEwMDE0NSBTYWx0ZWRfXzWzDOHQjK8DZ
 1aBEZwwH76xYuQK1+YuhyzgDLjnK7RvP171pXrkAOrsbeSeOO1HewgLlVLTGPcvjK0JbEL9KaHe
 jYu9y0/8/JWZKNHHlBbxY3XOunBVcWl35ZdjXRE4WqHs14HxapLBcGA+2j4yjO9yIF0CXzzZu72
 C6UIZpSXEDA+ckjVFysY2YOfzpZdSwnyLPRMZedq/6fAO17h5TuYP+qe+kF3QHhDq6Hx7102Yi0
 3ZoWffEEJL4czPFLeOzjq58lpIT4RdTERWopDpFFOjjq2Jc6Kvt+m7bds5oVeJORse+CCpjlhwM
 KXMqSjhsOVxi610TwuTyAjAk5cgoODq3GFREKXNX/pxKZBy1s6iG5mlEuO+zo1thDkSiNvlNAZx
 7HBIjD/vRwzqI7Y/xat2JfefB0BDuXKzGAiV9smwRgUftYtoz5Aihgf5cITsS5I3d0pz2v8eCk1
 YFsgTytNotlAhVHnaAQ==
X-Proofpoint-ORIG-GUID: 22j2lKCTiVuo2tct47tMBG9T1vxrTQzc
X-Authority-Analysis: v=2.4 cv=CJMamxrD c=1 sm=1 tr=0 ts=6a008aec cx=c_pps
 a=cMwMxZTj1NM3F6QoWJDe6Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=bC-a23v3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
 a=t7CeM3EgAAAA:8 a=8aktdrjY7Nj1izGWPaAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 22j2lKCTiVuo2tct47tMBG9T1vxrTQzc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-10_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605100145

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

commit 59a33d83bbe6d73d2071d7ae21590b29faed0503 upstream.

The 8250_dw driver needs to potentially perform very complex operations
during LCR writes because its BUSY handling prevents updates to LCR
while UART is BUSY (which is not fully under our control without those
complex operations). Thus, LCR writes should occur under port's lock.

Move LCR write under port's lock in serial8250_do_shutdown(). Also
split the LCR RMW so that the logic is on a separate line for clarity.

Reported-by: Bandal, Shankar <shankar.bandal@intel.com>
Tested-by: Bandal, Shankar <shankar.bandal@intel.com>
Tested-by: Murthy, Shanth <shanth.murthy@intel.com>
Cc: stable <stable@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://patch.msgid.link/20260203171049.4353-2-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Ionut: adapt to 6.12.y - keep both 'unsigned long flags' and the
 new 'u32 lcr' declaration; place the LCR RMW inside the existing
 explicit uart_port_lock_irqsave/unlock_irqrestore region rather
 than the scoped_guard() block used upstream (cleanup-based
 uart_port_lock_irqsave guard class is not present in 6.12.y).]
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/tty/serial/8250/8250_port.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index b4c8388ea6fc..d0f2e634ac30 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2462,6 +2462,7 @@ void serial8250_do_shutdown(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned long flags;
+	u32 lcr;
 
 	serial8250_rpm_get(up);
 	/*
@@ -2488,13 +2489,13 @@ void serial8250_do_shutdown(struct uart_port *port)
 		port->mctrl &= ~TIOCM_OUT2;
 
 	serial8250_set_mctrl(port, port->mctrl);
+
+	/* Disable break condition */
+	lcr = serial_port_in(port, UART_LCR);
+	lcr &= ~UART_LCR_SBC;
+	serial_port_out(port, UART_LCR, lcr);
 	uart_port_unlock_irqrestore(port, flags);
 
-	/*
-	 * Disable break condition and FIFOs
-	 */
-	serial_port_out(port, UART_LCR,
-			serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
 	serial8250_clear_fifos(up);
 
 #ifdef CONFIG_SERIAL_8250_RSA
-- 
2.54.0

