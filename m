Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFF53D4126
	for <linux-serial@vger.kernel.org>; Wed, 13 May 2026 06:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655070; cv=fail; b=RC0DKdwx2Rsibfovk7AaXSJyujug4Xc76zLT+FJXswmcKJJS6Pz3VQFqTCBvCiLCBrYym0CiIJ2R9hKlfpD457V6uQG7YjD2CxJ+m7VOa4ivj8OzpB3Fx8tMbgQ0/O3hsV/tsxdIDDtfhDx6kBtDUl4IE5eo+FF73xu+p2xDm5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655070; c=relaxed/simple;
	bh=HJ164E65OxE3Qp84s3157ztfUlpOxOlIwSCIfbcQjQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DBfNyvb2ZcqeFaaigY+DrWk/HzzI0GUuMp1Hx26Wk6Z8l9k+5L3Kl9uJMuIvvYv1DgFHp/Sg2vNZHpNjEJK2nFu/jsM+EnoBToLCbYuDZjuV8NlgA6lPssCaflYZ4ezyRWh7tsHbcO8+HqxlZiOZn7PGkRgaNY4Y//f1Y1+5z/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=n4DJhAJ5; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="n4DJhAJ5"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D3rO3S241244;
	Tue, 12 May 2026 23:50:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=3yhZ1e3cqgHIFZSNnC0abaOx7C2Tpuf6htAFckI++bc=; b=
	n4DJhAJ5Xn3mxolas9EV5WD76jZp8uRZB7KplGnkEIwP6fgll6qevTZ3/rhXyuQx
	3kYa5a9sR/2z+7OQTzPIP4aLHPW0q5ARtegFD+BtkuiMBNqvpAZV35FvHHCg8RY/
	Ey5x1crvff4tqJpCWEUdHEBNpP7ShUZosI8GL9/gVkS0unw1VOKD77GPzbRI0Doh
	a01q3nKka4C2/N7ofsivykpXxXaESz/ZAd9c8+PZRPfe8Mk5PjwK6vpM+FarrW1p
	LuuFnZT57WCnfgDZmmhwtfB0kZDKoYLlsX6eqJiXg2PZyJMshIPQtgLsOpradhuW
	WTS7lf9iZas9p+ILM0mbzQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013027.outbound.protection.outlook.com [40.93.201.27])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4ftb8a1w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 23:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XO+q5axjt5e9hxrTENxXbxCgBHCAyz36BVMIXIQf+rTPxWUVo2yJCKNXCy9j2UWjQfhRJKXbqFqrfCJqc1Uf/0hg7Maz2B9WRiOHA4tNvFX9e8rp9qUIwgdjiDdn6kMw7gsx4EZJOYTkQHHj4xSFk2Kw5MjeCquxWI71XCqeuqGfdpDhIPB1eUmb+6KVScFiEtRww1CgViNWY5b6vkzk6aVwbTshATVBR5qaV5esev3EGqtVfypyHn0fH7YdSmMXJc6h09fXTElGNA7+dfRO4HRcbgJkaKSfhxfAOkLU9mFbjpRDxPh0WHbu5zaoLwFX4x93w1yqYFlPhOjD/oWkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yhZ1e3cqgHIFZSNnC0abaOx7C2Tpuf6htAFckI++bc=;
 b=PB+hpQJQlnib5rTFBdCUobRr8xqgeAPMQPeZyAXq5KSa9dGCXGwXfcHEtMpbB460gugDResKR2xp3vcyaZLMMgI8hLgAKIXTuntXeoxIiATscJkCAcexVy4tAOXxqBM6C1Ntw4R7q2ESNd7gL5ICxr1zMV3NXBd04PNPtMAYenPdfPmrvyo6XBX84BELHKpppi4kcK0y+7YClji0cpEmSoPeVYV1n1EEUBE+4LatF0opVZM/5xp3kdF8jw/YxcCPXll2qQS0JwiKrex/xDfHiPbujD6hNa2DNiXPO9/Eg7XdmFATjps3i7wHCATVVtRbyX9goUi7HYvHcFlxsoEShQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 06:50:56 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 06:50:56 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc: stable@kernel.org, andriy.shevchenko@linux.intel.com, wander@redhat.com,
        chris.friesen@windriver.com, linux-serial@vger.kernel.org,
        "Bandal, Shankar" <shankar.bandal@intel.com>,
        "Murthy, Shanth" <shanth.murthy@intel.com>,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 05/10] serial: 8250: Protect LCR write in shutdown
Date: Wed, 13 May 2026 09:50:23 +0300
Message-ID: <20260513065028.112468-6-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: c902a1e1-3d8f-44fa-9e6a-08deb0bbfbf5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|10070799003|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KXgwOnjsM2ODeJy9+4ONtyAMgUZQhepFNfXMzf64ekPc7FuDd0O//Jym3Dk8uThF9tuUaovI5B0ywUoDCLunIvZgV4qcII0+XK6jNfGUTc1Gput3v+24Dxydp95KWmH+To6ofZYcAZDaLRUlcRWCI1mmB9Y9UEDyqI5Wx70MhULJa/+cT+xMSikkwBRIJx5JzBSaxEVuWvNfSiZtr+W9RlOPgkShomOTj1IXjc6j/Q3NO5IYgatvvf/PCHbgJi8nK7b+SJ9/X7X4XcWjqBjWJFy5b0OugKbChUQg9zB40ctvL0OR8H0URtJ6pH+btgxO/BqdWXop/el1XmJzncoJOhbiKco4SfSMzp6F9sqNT69aq4VmjtWrtX5Lbz3u3N/NJtFO9i3yshakaTGpEY6RbI27NAI0psa4aRkm3ROoZhpoEyYuWSzFSJ617zEytbEnkziXh4RUoDkLi9XnFuMg8EWlSP02Ziqwo4Tc3Ibh3VJlpv19GdqlaIArWQVkgRLatzj0XNJwX5GzYM4sAPYaGwYNW2JKp/1AW4GbGQ4udmsQHyg3SbwFC4/SAegP/tGTJHk1T0krcVk0u7YceSMyBu9VRP2B+x6BHIwcnzF25EW4du/YvK39wVG+FcxrdbJh6eYxHLioVcBD/OyxUKXocw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(10070799003)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zm4vcjhoSTFhMER2dENQZERHZ1NQZzdUZDJtcXV4Um9ENENHdGxlU3J1WHBE?=
 =?utf-8?B?Z2k5Rlg5a0JSeTlYell3cFprNHdZcTA4bHFrcktWb21oK2h1SXNiTHZYb1Nk?=
 =?utf-8?B?RnFqb3VBV2RHcElzdTJEcmpzU0p6TjJYTUhuK05JaFdpaWRRVHZsMEoyMGdM?=
 =?utf-8?B?VnEvNFFoT3hybURpM3FrQzJCN3NaVWNmNUJ4dytjNGoyRW5ZSDRmSUN4dEZs?=
 =?utf-8?B?T04xRFlXSHBEYWY4UFRPbVY3bjRObk8zK0tGRHc5ZFNwVnZPZnR5bFpSNHY1?=
 =?utf-8?B?bTBOdm8zRW13TC8wNHRoaVQyZ1JNbmhuSW00VE9NcndvU1BsV3JMKzJjd29o?=
 =?utf-8?B?TkhzSk95dW16aFhJYW15emlLWjNVd3JWdDBpOG5WeU9SZUx0ZlZpaDZoM0E5?=
 =?utf-8?B?VHQ4MlNUVnBjV3NpVld5em5vSHpGcVZTa0owdlQ5b2lWdDdnYWlCQ29sMUFH?=
 =?utf-8?B?MjlLL0pBV2xsMEc4VmJGV3NLV2ppaEJlZGcwclNjS29vVkpZOXJnckdvZ0R3?=
 =?utf-8?B?VWVRMVlZZi9IdlhjYnBnRkhMVTVJZUVyc2ExWEh5RDNqcjVlUjdObDhhQm5t?=
 =?utf-8?B?SkZMWnJPNmkyUmdhRitiWXBDUlJ6RVJWaHRvWWozRkhnT0hpT1BjZ0Jwb0Ji?=
 =?utf-8?B?KzNwZGVZTnUwWDRTZmYyUm5FdERETUE3MXdFS0xyZEhLVVF6aVlIbHZvUitm?=
 =?utf-8?B?RFNBOU0zMCtlMTFlSVpEQWdkQnVrMVlOdmRqc0xwUDg5VzFNRHRJeFBuVitp?=
 =?utf-8?B?YnNTWGMrUFY5WnBCTGtsSzRDcHR5N1ZqeVFQczluYTVzZmxER2RENjVscCs3?=
 =?utf-8?B?T3dhbXhCbnNCNmJsTjkwYXNIVXpHeXFHVlhMbk5MVWc1RDhNb3loaW9YNEoz?=
 =?utf-8?B?QUtkalhzQU9mTjZOV2lZUnE3c0tXU2FCcHZOT2FYVnEvR0t4SGZvZ0pCZVpG?=
 =?utf-8?B?Z2tIcGo0TExtVC8ySE83MDBHOFJ1RVljSElqdnlUazZ0Z0doQ3B4bkpvYUtX?=
 =?utf-8?B?SnNOQ1plZEI4M2syNGtobFBxQzU4TXpRbDVPdEhFSmZaWDg4TFI2OHZaT1Vk?=
 =?utf-8?B?UkxyRTZVNGhVcER5R3o5RjkwNzRMTmRpb2JxeWlZeWEzc1czSkc2aGJpRzlp?=
 =?utf-8?B?Qzg3S1cxUDUxaXFHSE5raldtNUplVGdVZnlqeWY4bGFQR0xMdTJaWkUra2FD?=
 =?utf-8?B?WEpHZHBGYmk2UGZmUHlqRXc2RUgrRU1RTnIrcWZHOGg4QTdseUFqK25yM2NU?=
 =?utf-8?B?bTlzVW1Hdyt6UEVVUU40U0g2YysrdlgxUlVXckdFVDV6N0FjTUswSjZ3WDV4?=
 =?utf-8?B?YnNVSVBZOWRTUHM0aFQ4VWdmVGU4MkNTT1RJVUhrWVBYUUhOb2loT3haWFRC?=
 =?utf-8?B?SFZ0RnM2ak1XUURqaTVKcnMya1FnNlF2WnFGWDVZOG12YzMvR1ZUaEl3L1hs?=
 =?utf-8?B?NThXMHBMOHRoZEt3SmRUSlZRcmJHMDZlQ2tqYzl1akY3YnF1LzIramtiR2ZI?=
 =?utf-8?B?QjRxVnliRHpSWlZwRWg1dXhmZlBvdnZMWFlTZUNQVTI3SWRNd3EvVUVrZGVJ?=
 =?utf-8?B?SzJSaVdhS1ZKcG9tZGNLeG43YkJ2NmRERzlNbEhNWEkxcC9CbGVkanh4NHVZ?=
 =?utf-8?B?TWI1OGlMTXg2amZGOFJYc3gxbmlDMjFYbkVZbmM4SzJRVUF4cEVkMWNUb3ZQ?=
 =?utf-8?B?UmhOTUYrWDAxOUJEdDQ1L0M3eG41aWYzMzNiQUFlUDlBdUlJN0pFTWVLUnN6?=
 =?utf-8?B?Ky95K0VpTmxUUjM2RVlMbWFpNmZRWDFYb1Zrekx3ZjVaL0U5OGRienE2cmhR?=
 =?utf-8?B?aEJ5QVFjdi9oL3k2N1AvWmd0SWZaeUJEbGowVm1yVDc5WVM0R0x4dHJJREdk?=
 =?utf-8?B?clozbThIZ1VhbVFFVFBUNHljMUFVbndMNjZGSEkrbjZzSmlNNUI0V0V5aGZ6?=
 =?utf-8?B?amRBZVY3WHpWcXFRNGxHS1cwVUVuanU3T2hhNTQ1SGZ0bjZoQnpJRTk1eFJt?=
 =?utf-8?B?R2N3REtPSW9sQmZ5SnVtQlRwOEVpMThNZlBrZE5zTk1LbXdCZVd5ZVFUYnY5?=
 =?utf-8?B?bkI2cEdjQ0RWN2J5Z2dNc0c1MlJVZXBPY3FaYmJ0WUNTRE56L09wMjVkYXJN?=
 =?utf-8?B?cUdzaWdEeGFoNFZwbnhXZVd1bE9LN29mODhNZnJ2MU9FQlFnRjlVLzNDZDB6?=
 =?utf-8?B?WkNESHU0UEwvaGtaejg0Tm5ScEFiTFBTSDlyS3paNDk4ZTdJTGRCZHFYODUx?=
 =?utf-8?B?OW5xNkZlRm5yS2ZYeEhYaFVYbFpBWGt3Nlg3bTBxbTVsdUlMcVBER1RNOHpY?=
 =?utf-8?B?aFU1ZFRqR1hzUEpEOHcvLzNBSVRMak5iUzRQd2tnYy94aTMzVzZZWWdaSlUy?=
 =?utf-8?Q?o8+gbL/0DozmuFpZWhhEy11Ji2sA5c6alvAULeCRJC9x7?=
X-MS-Exchange-AntiSpam-MessageData-1: m3vajY8lx0zhEjvxaFEVMHha3klTiu7TCTY=
X-Exchange-RoutingPolicyChecked:
	g0jMqlnqoA7FNnJuLNFiBLca/O18rtOaottUgwV+zY1Utrxnau0UdK46mB+zJZUEUmOrRCiaXAnviOaxK7JXTY+c6ObRI5Gh1GGVtfPjFLoFJarYrHConTmNTGQbUGIzklyBA4r2fRN27GDYJrL/8a3j02XM8FGPjhYs0Ql1kX7ohp5UyI+hE3hOSpMOI93JV6uS1Ip6gf+DpkDvs1uUra9c4zNvp4qitwO43UzQjqogvP4I7NrWsDhpKXWuItZ99LykDGfB1xwQMYl9HELgcC1n1a0wvCPwUI1I7LjwhhuVJ0soUBTG37FNwSOiokv73fIB9J90WIay2zINCaUW7g==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c902a1e1-3d8f-44fa-9e6a-08deb0bbfbf5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 06:50:56.7186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q4MoKOziiGnpZk6/s2Z8/w9wJkGZlMq1SIvie7W255wqznV4xhkT/skmkULL8jFFZPbcFsnRtQMsl7rtXIkrEIGJ9Sw8Uuj1f529oSSjvpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA2OCBTYWx0ZWRfX6k68NgPh9RRT
 V+xKUZkYl7OEoq0837rJXEobMJwY4e9ANZ4jFz9H9Xzl57e4FAxHbyOC3nQkDRKdJvhg2Kircp4
 GpW9b2IldPSqgPWRK8aUh8AnwCXPIPEoxvT7OFfw3gu0yuYSz8l/W09NtelCFFkWmrDO7QlaPJJ
 79M2rheenyCFOv0iQhmOpcMTx4Vaohi2nUhsZeARGXDlQjfda/byUyhCrXx4x24PK/Vy205F8QN
 Od1+UKnaP109VUaFJVq+S2ExtSiF4M8rmKaCURXncXXL9VoSdULzZkN7sDcDb1x3SqWBcG8as8M
 /9KbZfIuJJnKw4goa+cUO86fXUry2DZArlC9xLT6lE4XRLCM2FcEpzd9dm+dtYUc4tlPHjoqUOt
 wBvXQH92Z2GHgm8dumh/R6QWM8VsJNDbZ5Z0A1wiZ6X8SspPifsJtVJ+qq5duHhJ6hd+e61nind
 NNSGlInWZbHhvKgtCGg==
X-Proofpoint-GUID: 91IGptwGA_M4AX3nocxhZUGMXJ2oEi2R
X-Authority-Analysis: v=2.4 cv=du/rzVg4 c=1 sm=1 tr=0 ts=6a041f52 cx=c_pps
 a=WwHAhc24fKszT02xmrP0gg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=bC-a23v3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
 a=t7CeM3EgAAAA:8 a=aP9QYQIr-rQUShFI9YIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: 91IGptwGA_M4AX3nocxhZUGMXJ2oEi2R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130068

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
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/tty/serial/8250/8250_port.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 21fa7907c0d6..4252138ccc3d 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2461,6 +2461,7 @@ static int serial8250_startup(struct uart_port *port)
 void serial8250_do_shutdown(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
+	u32 lcr;
 
 	serial8250_rpm_get(up);
 	/*
@@ -2487,13 +2488,13 @@ void serial8250_do_shutdown(struct uart_port *port)
 			port->mctrl &= ~TIOCM_OUT2;
 
 		serial8250_set_mctrl(port, port->mctrl);
+
+		/* Disable break condition */
+		lcr = serial_port_in(port, UART_LCR);
+		lcr &= ~UART_LCR_SBC;
+		serial_port_out(port, UART_LCR, lcr);
 	}
 
-	/*
-	 * Disable break condition and FIFOs
-	 */
-	serial_port_out(port, UART_LCR,
-			serial_port_in(port, UART_LCR) & ~UART_LCR_SBC);
 	serial8250_clear_fifos(up);
 
 #ifdef CONFIG_SERIAL_8250_RSA
-- 
2.54.0

