Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258903D525E
	for <linux-serial@vger.kernel.org>; Wed, 13 May 2026 06:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655077; cv=fail; b=kW/Ch2G/PPB1ITuFrGd72kHo1r+AQIfzesMYdIVCN4W4YCVyxNSfbBBuejfreDGnTSaYDYdpipjzZfxLh2l8jgYwc9YRj7pOUNdMJ8iQNcCtKREDAd1FMyvw/aXLNgQongnRGWvMwrPeLymZ82MoXzDy+ydEtWJDdSJkgYql3RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655077; c=relaxed/simple;
	bh=h2rdCY4X0CYZGPwBENZlUSo0+XXMLPUIwcH2UJNA8qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IzHqjUqMBCJ4Wkd/N5hQ/nB6yb4KPoOhxMqq+ruFekDqNLEjbMmqRFZGrAwMbnGHjYgvJSTl+ns5Z48q6NnpI/SRZV01+MDMgq7WW3Stj0hkZMz3SQmplsUerrajP/PNGaa6gWCgnDfgZYeo0PK4dzRhdFi7nfyP2l7uNfQNCYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=iyAAReZC; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="iyAAReZC"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D3t2iu243653;
	Tue, 12 May 2026 23:51:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=ma6LARVqn5M/hLA6RnXH3d0fovNQEWzDrHi1hU/7MEo=; b=
	iyAAReZC1XGZGZbOqAxJk1PtAEed5zZnbgBIZydl7+dKhWPT7HSkg0R6eJq2Uxfx
	kE2IybFGe5SV0si8lkz2KuFRsGRUfTU97er3JF7Vo+FHYG7VuWa5vjGNXvHRLh1m
	SkI2G61PYhlWz1MHb7sppNkwYhKO/BMD1g8IV7mLRJkwzOrqDlBkH372JD65e8Ni
	xNiQushFD+jvfEEHV1EZvdQPdR3sdZvMxztVCcCFcojg3u6RT8dP6X1ANB51wGie
	/7S8Js0omJ6r6Ksv4EVH4nJifELPwzKqAOHtpo1KqDDEdSiiYc3tyjk0iFqcGQEl
	3pUjYybAgSvnAaKiOSw0mQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013007.outbound.protection.outlook.com [40.93.196.7])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4ftb8a24-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 23:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jvwm8V4/gwY6DBuSxbhlfdEsnPupgaZA57yMJB/y4k7z8By5qkOLmeNt1Tx73q3/IfqSeu0SzTsE5BQzI7ZLdjehCXw08UmGLae43SKk7bYgXOhMhb0SQoezd3afDVkDD2aUk+uyhU9clgIYzsYFtr9ip8RHCGzs4PUu77Hr+0uYz890LvqVo3+GTj+l7+E0hxH8oOMxAwikCYiLkj/UnRwEhrUXInVkNi0wsM8mr51ZT3zHabztlZ54BaXh5NcxEDwyUNuDuf9dkcGJq9R2v/2p12Yj0tfcmMXcZoPjhzcuAEVE6pob7XNd1DVaPKHUKb/T6GNfZDg5BYntYq1QpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ma6LARVqn5M/hLA6RnXH3d0fovNQEWzDrHi1hU/7MEo=;
 b=MmQhC7R0XHL18itN7eLL0J2Cu5l3O4Sw5TfxYNnb1ww2dqL5bBC7HLU4saOnEe7MqrQGNM48qdxiFoVWRRUzPvOKOb9haC2mISfG3mREyQYLiyn/r7nDW5B8N9CMqZoE3X6mHZWYu65a9Wq34tKQ8OYJ8OYvKRlPWCw9EOSUlFF52Yll5PgQoM7Y+ex1cOuLsXzjY8fV3NI/Pw2l1/HHl2RGTlIkGtEF7rPHpGL5O/22hLs2CadlAZJvSlLoXSobtw5eOTEXsIka7Z4Fj7hA0BWSdBWGy5PNeTpro3/sm0Ie+2opO2Yh1NgbkJfv+GzsG87QjEOegNF2fo0lg//Abg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 06:51:05 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 06:51:05 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc: stable@kernel.org, andriy.shevchenko@linux.intel.com, wander@redhat.com,
        chris.friesen@windriver.com, linux-serial@vger.kernel.org,
        "Bandal, Shankar" <shankar.bandal@intel.com>,
        "Murthy, Shanth" <shanth.murthy@intel.com>,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 08/10] serial: 8250_dw: Rework dw8250_handle_irq() locking and IIR handling
Date: Wed, 13 May 2026 09:50:26 +0300
Message-ID: <20260513065028.112468-9-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 096474e6-9c56-4ab3-2936-08deb0bc011e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|10070799003|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	08D5rzPZwJ3tzQyWBYCZ0pD+BIIHMUgvTsHf41Qd6vwsd2913qwR0wFLzLVEXo+dan2ouz2Vl8y97hyGO0z9Bi0LB6lv0QtM9kny7e0kRyR2cTNX5vMNRB9Z3VtGbunNLvfK09qXMPLWtefzuxhjzvDHcNrvl2tamHqc7LgJKqgaeVBcgaelItT5U+hV516QHYPcT7rPaW7Rl9anBorK9ErbrUmSb5EP0YCWLCF8Ml7EGO5T2TKhxFoI7U8HQJTW65l4/CkF1r1UdME+fLdUjTkVq++Pn21vwSs+x/nv1jlqtNPDwpqUFPalt/QZITL3ZqrqPsNImlb5SLNoBhjwi0lvhtxtvJq+zwzrUBY5zaKIdsP03al6eOVEimyKsLWBuqJ/KrJoR+sGSZvC+b4BinpL3EcjRa7j1ayd1r47AokAdFnF7Pi7Ib5nkTVH3BMteHG1MtbPjjjAHh1zYqRBdU+0wnIhbeDOFIRik6VtkK9/UgdwVliVB1h0HlvpRnhI+HAVJNXg/EGntfj7dbR2Mf1E9+8UjRSMpmXfbwNo8de1B8Cy/nugWAGq+OdU2zFjsDFmXhBdhNdTCCEHlFqbgn4foeEsW/Y5LHc8U+G5NGLxjLdtr6Zxn+bL9pQdqXrErvaJbmP3sc5rYHue6MSlGg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(10070799003)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzRzNmlJTHQrVlF5Z1BYRWg5dm5WZWpTWkM3WHVQNUpqMXFneWlhUFp2bjZr?=
 =?utf-8?B?SC9aRDVRUVMzRm9kMVJQbDUzTEprbEFRb1l3dlRneEFobkVud2k5N0xnRS82?=
 =?utf-8?B?WURmRUNjRjZWVDFOWFUzMHdNOFRPbW05ckJqZDAxTXVEWWZVZ3gyNXpEWEhk?=
 =?utf-8?B?UWYvTWdRc1d3cjNacEFLVXZ0ZlE5bi81RUI0N2lEUmJ2SXJlT0s0MjNRVzN3?=
 =?utf-8?B?NGtSYnlaMERmaWlsdzVRNW8xZFA0aHA1dDlTRzJaYlhhaWVROVVVUlFucFVY?=
 =?utf-8?B?ODgva0dFaWY1R3N2SWRqUzNPUUk4cDBtR0ZybGlWT0VMVG9yOGJQMnlpSGpw?=
 =?utf-8?B?ajc5RDJPb2I1TDJLZFVVQkZ6Zm9hUW8rQUt4UUZxQUh6eWxaZ3RHMk9yNFRM?=
 =?utf-8?B?V2ZiOW5NTWVVcGFsUlVoQzhheCtuS0Rjem85dEo1MHZZUFhaUWN0Myt4VmdQ?=
 =?utf-8?B?RzcrT1NXVlA1Ym1mU0NGRzBjcjdYeWU2bHl0MXpJMC9kd0xpNnZKT0tpcEhy?=
 =?utf-8?B?MXpIVkZoWTdXaW5qNm9pQ1lHTWJnL3oxS2xKOC9lV1dBT2o1bFpWRDVoYjJr?=
 =?utf-8?B?SWc5OG1RTW9TMGdLbG11Y1ZtZG91b3owN3EzWTNqcjg3cE8xazQyYUFGNDM0?=
 =?utf-8?B?SXBJMGFqTlJ5WVlHdTFucFJvM2Iyd3dqSVlqdlJRZ1A0TkVSaUtBN1ptd083?=
 =?utf-8?B?OGMwTXpDU0lHVG9TUHdCcFJ0S1Q4WmgxNGtheHpYNzRmNFZqYVRRY3NuOXFF?=
 =?utf-8?B?ckgvb0hQeEdNZVMzcnN6RG9HSFJNdjJGcm5TZmxERzJjdENwUkwybTd4dW9k?=
 =?utf-8?B?RCtUaUVvVXljSW5sM2RMdDZrRE5aQm40OWV0R1pyWFpnU1pWUGhYenpRVDlj?=
 =?utf-8?B?b0VvTUJxdUVpdWNpOEhUeHRsV2ExNURWL2RNNmRQNHcvNnpEaFhpbVdSTHl2?=
 =?utf-8?B?ZXNWRnRVaTNPVG1wNWVKdzB4M3I3enpSYlBTSE5wdENsOVdFU1A0M1VwbEtw?=
 =?utf-8?B?M0V1b2VuY0pWZlhVK1hubmNCdE1hWnhKc21TalN2RDBIa2RxZFA5b0RxaEZQ?=
 =?utf-8?B?NnAvSjIwaWk5VHluT3hZMXlPaDBSQXA0Q3dGMDRQYjQ5OUsvYlRMeWxxSTJx?=
 =?utf-8?B?b2w2UVFVOUwyUGlrQi9jUm9lOWhqSW16SjZNRnNuOHVYVHFmTDFVZFBaMGcv?=
 =?utf-8?B?a0gxQzFXdmlZdWJMZ1Ivd1o0b3dtTTlIZDVVd1BKSWdSM0ZNZzZiU1cxWTla?=
 =?utf-8?B?L1k5Ty81MUFLOEVCb0RqV1YzS0dNY2NIelpteFVBM2VWSkd1eXM5VUtKNHVK?=
 =?utf-8?B?YkluSkx0djFLaS9pMWM3cHFYSnQ0dnhxU3o3OVYwMGlWM1JkNm4vbm8rVUtq?=
 =?utf-8?B?NW95SUxYYWhZVzBLK1NHRTZRbzdJN05DL0x6RzhmYW1peGsrbDZwTUJRZUxP?=
 =?utf-8?B?RTBpRFRHdUpvVUhYekFaaS9MdndESGZ2ZkM4ME8wdTFQcElhZGVYZXR4SmJv?=
 =?utf-8?B?dnExZlN5aFBzOC9MRHdNQlQrRm1FM1FwZUQ0cWZlV25yM1M4anBPUStCOVdC?=
 =?utf-8?B?OFA2clltVmJ0WTFtRmw1bENJdzBmNmZaTEYrWlhMSlJNRjJCY0Y0MG8yOEx3?=
 =?utf-8?B?VWZxSHVhVUF3YjNTWXFycVB0NHFFSWZISDU5b1hzaXBnV2I2dEJGOC9Qa0dW?=
 =?utf-8?B?S3Q0UGwya3ZidnBVZzJMWnFjOG1YV0RUc3NtOGlMalR2M042TDhRMG05L1lz?=
 =?utf-8?B?dlhEMytnOEtFVVVKS1Y4TTQzSHU1Q1JCWW9oSDIvUEN3SGpWd0VlOHJkVytY?=
 =?utf-8?B?R2N6ZlZKY2REQ0VBMDJqelZOYVRUWXJMM3drdjFUcjFVeFhubk1IZWlVOWhj?=
 =?utf-8?B?clNPWkpHQUxrbDhVTi9CWDNOUHlxOGEzYVY2Wi80TEZxMVlYdEVpU2VoTzdr?=
 =?utf-8?B?Q3dQeElDaDRpT3FEaFdSQ21hSEhjL3FCOUI4Smg3VjE4TS90MUdPSTlIcHIz?=
 =?utf-8?B?N1BhdHhiZ2FDQk11VldkYjRqa3U3R2k1UXZtT216cmF2eDdaRXhFdGFuZ0Q1?=
 =?utf-8?B?Y2ZCc2IxZ2h3ZTl1ODA3aWMzYWwxVnluUnBOUndFVXhNa1VWOWxjREk2RkVF?=
 =?utf-8?B?eUVYQ3hSaEVUSGorN2REU1FkZVY0TmZoM1JidTMzMHQreVpHaWVMUWNpem93?=
 =?utf-8?B?QW4wNjZFcGYvT0xQaWE5Y3hDMkprazlIU3lyT01QM3lSbytxVkx4N2VEQnpk?=
 =?utf-8?B?WFI3Um1aa1dwTUlPbnhBQ1kxNi93OUl2enlySmkzVjBsSk1HaWhkNk1RS3hv?=
 =?utf-8?B?Y3VWNVluU3hlSWdyTUVVZzlvZHBPVFh3dmNrTXBVNXFMOVBHa2xQek56VGtN?=
 =?utf-8?Q?M4sgeTBRQjx/U+NRX2GULKGj0nVAjSC9dpWhjPGFEo/vL?=
X-MS-Exchange-AntiSpam-MessageData-1: Dtc8DroSiigJ0NhPZWCvcComWaLQIVeaPYM=
X-Exchange-RoutingPolicyChecked:
	NdrkJif2yKdN+buSnmeL1QBH1HMgwZ1WUiL3stoBirTJlumTzq4qJDM4EirSZ0R4ZpYbCLgP5hWzTRvksgT2EBo4hfn4GMslwg90MYVUoXbzvfV2Lgoul+QjNDyR7XPjL2/kPlQPYNr9T7IVz5/Mh/VP8xw7v+BIYsm3vgUJbg6+PZFjJH2BtZ+JqBW2TlHlthuY5ipAmd89ZW4ZKwhPjIvq7SfBGXw+CyCapvN7AWJ6cJkFdv2GRCujr7FrPkdvIV9FuhArlVrRDLfecCnlVnkqd2WKgRHFQyQVyYcqDGJuvY9qOXHmPZp09Hm1UTE5So2q97U0C9NycdI/bWj/kg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 096474e6-9c56-4ab3-2936-08deb0bc011e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 06:51:05.4157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tio2b9JApUhpNfK946oe2RVPz9hfGnX9LRidZ5SWow1mKlXS2zyWlctD68VMpOVj70hQHnwA4FOA5rpKbTKTqK8L7xo44xS47T6qpxfhNeQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA2OCBTYWx0ZWRfX52qu4sZawdJ0
 SpuWmdlKD9R0zdsjb+LoILDQvUntqXjEB/SuZdGGgAWtAasjhD65PRef79MPjEGac63Dsi1sp+I
 OA6pJpYDsojcOGbNL8uQgIrOLCdvOKdWTY7gDzmyuKsx5pmVPWkFHIcoXLF/7OzISIPf75Na7xf
 1ocHZ0E0rllQF9Ap5dtBsBZ2tuN3fLx/w5K6iAAQulwz9t1wcePBJ+hQBXiO4Li59PKs6W1d7CY
 I7tSwXzowISFZhox+91hkFygzBuHcXzWM9qdMeUKYUAuXAWmGwPMNVp5PEns6Bf3Z2iaJAEuIyI
 l3DNGDSVFqkiNHAKUDWaysRz7kVbcvNTsc+moGsTilFYMwCQBKh0MEO5uwA1ihUoYIINLWLLn0I
 fRqOwSLOQ0Yx0aI/bChNIosaMUgyPp6fFlQ5CIkirw6i1yFhQnoVeHZ2dUl2ri+p848UFiuqLEV
 hkldQP3k3oINMtvPuCw==
X-Proofpoint-GUID: VYbeZPeIZ5Pgt_LBRdt1vcEVjATEVC9x
X-Authority-Analysis: v=2.4 cv=du/rzVg4 c=1 sm=1 tr=0 ts=6a041f5b cx=c_pps
 a=B1kIKGfTVomdQYahC0fm5g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=bC-a23v3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
 a=t7CeM3EgAAAA:8 a=FuLT1wuRHgro8dZZ4aEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: VYbeZPeIZ5Pgt_LBRdt1vcEVjATEVC9x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130068

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
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/tty/serial/8250/8250_dw.c | 37 ++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 05e45b63e5f5..1460eaf2a3a3 100644
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
@@ -312,7 +317,19 @@ static int dw8250_handle_irq(struct uart_port *p)
 	bool rx_timeout = (iir & 0x3f) == UART_IIR_RX_TIMEOUT;
 	unsigned int quirks = d->pdata->quirks;
 	unsigned int status;
-	unsigned long flags;
+
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
+	guard(uart_port_lock_irqsave)(p);
 
 	/*
 	 * There are ways to get Designware-based UARTs into a state where
@@ -325,20 +342,15 @@ static int dw8250_handle_irq(struct uart_port *p)
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
@@ -346,17 +358,9 @@ static int dw8250_handle_irq(struct uart_port *p)
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
-
-	return 0;
+	return 1;
 }
 
 static void dw8250_clk_work_cb(struct work_struct *work)
@@ -859,6 +863,7 @@ static struct platform_driver dw8250_platform_driver = {
 
 module_platform_driver(dw8250_platform_driver);
 
+MODULE_IMPORT_NS("SERIAL_8250");
 MODULE_AUTHOR("Jamie Iles");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Synopsys DesignWare 8250 serial port driver");
-- 
2.54.0

