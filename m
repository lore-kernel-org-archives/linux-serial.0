Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023082.outbound.protection.outlook.com [52.101.127.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47612376E4;
	Wed,  3 Dec 2025 02:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764730505; cv=fail; b=GnOiA+6K1DR+9P96tHDtNBGonfsr7cr0JylJE22GLksOmxeRH8qSsb3iAOsX3hOWnvIEWzazQMwCt+2T6At3xw0K1dW0YqX8IjO/e/SCCg+SYw6fFrkKg0DuIzkI0xXL/E1wAOvSI9wI2jF4RcGCO4CD1VZSK4HleHkLmt4pByQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764730505; c=relaxed/simple;
	bh=eAP7KodlkMGIq6bchvUYg5HmAJZ4FYudy7A0Ju3Pkwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IffQU4mZAKQ/SStiPvPaTTGroF7umpsgkctcPt7Kjxz7nrikJgG+cVPBjHlyjpC9jSNafu1sOh0BCiN5n8XFMN4dtgejQNjgPKC7UgcCqpmAHSIaIBd5CTWLOfQRPPoUp1oyH3Cj1+3Y6BW7rBlIwsUOoOwkBBlWv9nzcAeYFYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=AFFtBAEm; arc=fail smtp.client-ip=52.101.127.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="AFFtBAEm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dGGpZgrtGuaqPIVAS34/hka7ke2RF8ljSlT61xdKO2bWOS8q2iMPWaaw0D/VlMk480qb3BK6vTO6SANgIuLwy+DJEVplOTLX6M/EyoPrSNM7O93K5j9RLeRn6P7+U280pQ19NU1AYsjJQ7D7TZz1MsLPswTqjpNIywh89qEik+eFHrbXG7JNKzPAharGIDlJd0SXGhuWJQ9VqpoLX0p7/I8oOSy0lzB3VqKo6ZIWyqhkAXOQ2NqjAU8jcwCsrJ4fHOojRDNmlSmk9WoLSeDhU/CnbaGZsKGYj0k93tui0nivFLdnLztZ1WehRQX2tzeyPjtjdkxbZxglGn4v+qPioQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPRXFNV+A3Kz/I/WFjCf7725oAvvfJ2kts5baHnEiqg=;
 b=WRdjVuM9POJVXb9qQq0Ne9TxGNg4DPXKBFFQlwXRB2ZbxyR5Ep4dnjc+lRxCiCkrosygtPTz0vvTclNHL4vq5vYDeTPfpWtDGI6Anm3jHvQyZEJkTiZ6fBnxEC0QFJ4f/muKtWYOoxNcNHPNXbitsaOPIVdb2gf3AfVaV+90IJUYWZHHaG1EER41Pw5nCAwnIVepGLV+a6Lz9cSjfy3MQYdDCTt6kkPq+ONY2HIsVLuSrDjn6Ar8izO8knbzroJxq7XI90kdj56xf88qeZ7zOcY0S24CGKUDPtedreyZJ/HANkTeVPfZSVtjIUDAQQzjJCUIf0W3YPvg/4mJNxBCyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MPRXFNV+A3Kz/I/WFjCf7725oAvvfJ2kts5baHnEiqg=;
 b=AFFtBAEmS+ikTC/FWPXuqBwDGuCFiUpCeGROSjGmztGVO0jnn/2ZWU14MVrBFMHOjgqOaDp1ocuBd1L/hz5+mOF6IJ4dDh1NtO07sdMlSbZE0QrOtE2PIx5J1lYDl6t/m0HNrAfaCy8cqvfYsSxFkEm9FYHWJ9tvyfjA1pEpxuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SI2PR01MB4417.apcprd01.prod.exchangelabs.com
 (2603:1096:4:1b0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Wed, 3 Dec
 2025 02:55:01 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Wed, 3 Dec 2025
 02:55:01 +0000
Date: Wed, 3 Dec 2025 10:54:58 +0800
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 29/31] serial: 8250_mxpcie: Add sysfs to control
 terminator
Message-ID: <aS-mgjAQXR3OgmUF@moxa-ThinkCentre-M90t>
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
 <20251130104222.63077-30-crescentcy.hsieh@moxa.com>
 <CAHp75VfAfd7Ubhh1YxYH2fYJMv3wXUvUzrJSC1=V6HQ-wczYJg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VfAfd7Ubhh1YxYH2fYJMv3wXUvUzrJSC1=V6HQ-wczYJg@mail.gmail.com>
X-ClientProxiedBy: TPYP295CA0052.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::18) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SI2PR01MB4417:EE_
X-MS-Office365-Filtering-Correlation-Id: d538b2e2-f578-4c5c-4a39-08de32175a11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEc1aU0wb3hWLyt2Z2M5SjVmQTdiM0RyOVlYcXQrUUNzZHNtMFp6LzlKLzVp?=
 =?utf-8?B?d2JSQXcxT1ArMCtCN2FVRW9nT1MvLzcwbFRkTFVRWENHSkJ3MnQ0MldKc1hl?=
 =?utf-8?B?YjUrRkwxMVVDODJRWkRTWjIreVphYldtRUhwd3RaV09Vc0I1bkgrbDVTazNr?=
 =?utf-8?B?SytBb3MyS0IwanZWVUZLaHV0UXl4UGIvb2xzR2R1QWZjU1ViQ0hkOE9OenFJ?=
 =?utf-8?B?Z3pYZ2ZSZWtLa2k5dVhSSlRJTjdHc0UvSSs0SnVTUy9CSDcyUDJISk5kTFVJ?=
 =?utf-8?B?L1lSN3pKQ3A2SkIrN2FHWkRobXRGTTJPdmRpeW9QenRwbm1mY1JreldoLzNR?=
 =?utf-8?B?dFI3ZXkzcTZjalAvQng0VG16SUtkd3VHZmt2ZFh0dE5UU0dZdjJRYndNTHpl?=
 =?utf-8?B?ZGZ6SHBRdFFQUW51Uk1IcXB2bEcyb3U0NlYwVElIVElKa0NuNDkrRVNjRDN2?=
 =?utf-8?B?bW5BRW1NdnRrSlVsbGhpaERKMnorRDVnZmc1TUx1dlN6ckV2NmM5b2wzQ0Ez?=
 =?utf-8?B?Zkt3dmVNbVV3b0VnY1VsMENEaFZzcnlSR1U3S0hQZEE1SUM1NUQrSnhMSmlk?=
 =?utf-8?B?QVY4VWJUalpXaCthUFhhUWlEZ0JESVlVeVdjRXpOZWt2K1dSM1NQblZ5aTFo?=
 =?utf-8?B?NTRlSTVjOXd2TTczWE1JRkxSZlZSN1NnbGg0VzhJWWx2dDNDSmIyRmFSbkd6?=
 =?utf-8?B?cnVtVGJDMGlLTml6L09jNW0yRnNvcFc5MlprQ2FxM2lYOVlzRW9zd0o4KzA0?=
 =?utf-8?B?MGJMMU1ZTWpObWJPZy9pNmgwVXFrR29Pd09NZzUzSWxjY2hJTGhTL2NlelBa?=
 =?utf-8?B?bkhLOG5sSStRQ3ZCaHo4bWE3Njh6dnhUMm9JcVg2WDRMU0FOTjBrbDNxek5i?=
 =?utf-8?B?czFDaEJIbksrbEZldlBYWGwrdDZYL0E5Z2JqbzBnUHphNGxtZmNVZm5lb3FE?=
 =?utf-8?B?TE9YK2VPY1g1bkd2NURaSUtKMitSME9HaEFXVkprYk1scXdOdzBSM0UwMVA3?=
 =?utf-8?B?YlUvU1RHMEREK21za0Jwa0syVFVyUXRId3RPSzIrdUQrREdLYkRCcGsrSEIw?=
 =?utf-8?B?RXlMQU5LTVZlLzF5a3F5L3Boc1BrREZVZlNjMzNpdjZXZk1xRkdWYzl3MytU?=
 =?utf-8?B?REFJZXZXUkYwdWFJdUljdGJHaytaNGQzclp1RGZ1bGZKVXc4YUJNU1Z4aXZq?=
 =?utf-8?B?ekY3YlIva25GMXVmOWVick1FNTdUZnVIRFQzMktobEJqN2xOZ3kxVWdaVE10?=
 =?utf-8?B?R1pzcHRYeDJZZU1DWDlZQjczZlZXck11ZGZlYkZMaGFoUHRuSE5LMGpORmd5?=
 =?utf-8?B?aHovQSsxMmx5bG8vV3h0UkY0R3ZRaDF0cS9mQU5nYTAwM25YZlFLRFZyRkNX?=
 =?utf-8?B?ZVRILytOWTNndGtTNlBhODRNNEFvOFhjVDdJWkdhc2wydkxZaklnMVNreEgw?=
 =?utf-8?B?MzhtWkplV3ZDaFBFNlF4SnZ2ZDVTcHcxTzZRVlhyTWhGR2d0R0VtQ0YxdjZm?=
 =?utf-8?B?a3g2RkQzRjFLOXZ1RGUrNFNIZjY0dWxEUVZJWnNPT0FNZkh2YmhSZmdnamRN?=
 =?utf-8?B?NVlaSmE4cTFlbVRkYzIzUDhKcThPZ1pSSEV2MjZxMy9zakhJVEw0QWYyMWhu?=
 =?utf-8?B?SnNwSmw5bzhVQjlhRFRMZzZ5Y1pVOE11dU16dXBBT1BYUU5UQnZXeWpUTmpx?=
 =?utf-8?B?NVdCYW9pQXpGUzV4Wk5JVXdsNjduVWJRNHdrS1NUQ1B5cEYwM3AvRDlxY3Q2?=
 =?utf-8?B?MmhrRFI2c0t5VVJaa2tzUzRzRG1zdFVJdncyYXpKS2p3M0NjNVlwR1ptZUI2?=
 =?utf-8?B?dzZqcGl3MjhOOTIyNnI0Tzh6V0hEcFNGTkhSY2YwbzlqZnh3Z3MvMG5nVzZG?=
 =?utf-8?B?ODBQZ3ZEU01tRnZBSHZGK1NwN1diZVhVQ1FFeXE2UjdFRUl4YUo0UnZMa1hG?=
 =?utf-8?B?OWFhVzlMeE0vandWVXZTcThBM2diNnlzVktPbnd4bSt0N0duc2F2dGxSU0tm?=
 =?utf-8?B?dWJmT0ZzL0xlcVhUcWVKaGJ0NjRaYWMxZ05Nc1FyWTdhbzFKcWZrb1FBVXR6?=
 =?utf-8?Q?YJXBlW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WThYM0ZKR3lwNUw4SXZHTDYrUVUrZ2V5Uk95bGJkTGk1RjhyQko4MWlzbjd3?=
 =?utf-8?B?WmtMa1h1YkxZUlByT1lOekowU2ZtTmE3Q3FNZ3hLMFBVYWwrSVcwOFp3OWlU?=
 =?utf-8?B?TWxrL3Q0MVBxQWFSZHozY0hnc3BUUkJhbDI3OCtQaUQ4emZneDFxREFjN1FE?=
 =?utf-8?B?SWZ1bDFRQ3llS1B5c0RzeDRYMjBINHVJa1dtTHZGQWF5bnE4aXhEdHdCZXFp?=
 =?utf-8?B?blZkcFFxM3pRRW9Uc2tkSE81NGpRR1R6YnJJWWs3eU9ZQ3pTejRNaFF1NkVN?=
 =?utf-8?B?SVRuTFdicEZPazZBUnRxNUxzMng2VlVvNTJSRVF6NWVJcHVZQThqSko4a1BW?=
 =?utf-8?B?SEFEb3dmVVJxUmRvMDZzVVlkZ2NjcmN2REx0dTdRcEZNZDlNeExkZ3RJa0hV?=
 =?utf-8?B?K09KbnVvMWRYcFU4bjhzbUdpQkg4ZmcxelgvcWgxdUVwS3Vac3l5YVFQMzY3?=
 =?utf-8?B?UHlSdTdwWHdLSUgxZ0ZJanFJVFk1MXdGTFFyNy9zWkJRcTJRaXVkV1FPcnZJ?=
 =?utf-8?B?NVQ0WVlSVTUyOXhkcUxCaDRkanVoUkhOWHdFZnIyUXNEUVlGdDJraVBGYmVp?=
 =?utf-8?B?UHU1QXhTQXgzOHFCQ0d6OEExK3BEU0hsY2hBMlBDQUVCdEFPZFlrODkwUERV?=
 =?utf-8?B?TGtnUkRKd3o4R1JyZDd2cXRMcGRXTTJWSnVwcFZjeUFqQk51V3hPVm4wT1Zs?=
 =?utf-8?B?djlHUGVhL21KS1Y0NzJNdXAwNzF0clpEOFQ3S3I4ZEE2aGZzQVd3UHhPK1NS?=
 =?utf-8?B?WlZjWnN5M1czMGVjc2VKaXJzY3c3SE5Ca2hDYitZNEdyemticG1MUkg1SVZN?=
 =?utf-8?B?Mnl4dXM2eW5NZEdNM3JzbWgrSDZ1RHZPQWFteU9LTi9CQ1lSeXVTYTNKZUF1?=
 =?utf-8?B?UTlObUZwb2FtcXBPMm1EUEVQbkU0MmVsM2NMRlEvYVU0NTlsYjEvZytvMkwz?=
 =?utf-8?B?ZGN6aGczelRuYXhlc1g0dCt0eGp0Q01PTGdET3gwTEpia0tCVlZVck85aXR5?=
 =?utf-8?B?VmwwY05jVUpKak9xaFpuUHZ1NzNWTEVQR0U3QVdTTXNyNWJNcGhsbjYzcUZO?=
 =?utf-8?B?bWNDay9IUGZpVUIrZ2JzZWUrclJtR0R6UGhUV0ZLb2RKMSs1VHpnNHA0NWd2?=
 =?utf-8?B?U2ttK3JJZTVRQXE1U1QyMHpIcWgxaUs4bDV1S3BBNWxOMXUzd1p4VytjQnNG?=
 =?utf-8?B?K0VIQkNOeHdkZ3ZCQU1uamJOOGdiWFM4d3dwRFVpMThIWkszNFoyNU1GZ0lC?=
 =?utf-8?B?eExmRFZXZ0gzbEdxbTNRNmV0WEpSdERDU2xpVXFlNXJTcmUxY2hLV0hrTEdS?=
 =?utf-8?B?YjNwaDRpNzVvdHJqZGhXNG1teWRETWtPRjloVmUzYVJYbk5NNUdXVkh6UmZs?=
 =?utf-8?B?YVB5ZzlBOHNDYXVHZjR2QmtKYTNsT3k4NGpwL29vNktWNGZLVDNtQWUzRVpR?=
 =?utf-8?B?SjdzRFdpNlBoOTlIVFduSE5DOUpONG8wVjBBMUlPRzI1TnJZK0IyWktzaCsr?=
 =?utf-8?B?QXd0RnYveGhlTUptL2ZHMHJaWDMwZGFsdnRWNVVWY2daS1E4VmtBUGRSY0V2?=
 =?utf-8?B?amlFak4xWmQxNFJmVmJVdEFINmlTZUpBdEZkWkVwcGhqZ1YrK3hkTC9mUFc1?=
 =?utf-8?B?emtIbUlFMjdOU2loY3J6MFRIa09FQVgyTElacFp0djMyVTFpMzhkUnU1bkl4?=
 =?utf-8?B?YU53aW04ZkVObUs3S2FxVE9jNE5iTTlrUCtCQitOY3QyZWt5dUJTOFVsYUUy?=
 =?utf-8?B?dUtxMmwvN0FQeldKUVFhc05RN05keHFOY1dxQ2lTUEQra0hMSnRSc1E1RGdY?=
 =?utf-8?B?enVvZlhaUzFCZitVTmFZbllKY2w1WXNMWXBhNFVHcmNlOFhKbElYekFiVHZz?=
 =?utf-8?B?OVhpdGlZcmZOdksvbi9Wd3N5NG9CVmxlVisrWU5BWXhZQmZBTDROWHhiZ3cx?=
 =?utf-8?B?NGlIRytKNUlndDZIVEx4ekNSclhNQ2tWaHE5S0ZEUzFTa05abW0yRnBSYmpE?=
 =?utf-8?B?b2ljQ1o1c0lrOVBuODY2VTduVi9xcVZ2dWtVeTNpNmF1ZFg1Wm5IQ0FkOXNY?=
 =?utf-8?B?SVpTZFVYeEN0V0lWVEQxRGVZYng5RGtUZHA2bVQwditPdkkvRUE1VE5LcGxZ?=
 =?utf-8?B?QXJ4V3I0M2NKeHdCN2xBem1CZXBHQkdybW5SQ2MyMlRJbGplZ05xZ0xqNDlM?=
 =?utf-8?B?U3c9PQ==?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d538b2e2-f578-4c5c-4a39-08de32175a11
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 02:55:01.0913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkgOlMdVsk/enKHOa/qjbU5pO5zKTZ4M8ISzXr5QCyAB3MAILag2CHqrLXPx9rbXC3pFRQaVVtWHTccRAx2ux0u9kuXGyGlJejzibXDcFM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR01MB4417

On Mon, Dec 01, 2025 at 04:40:51AM +0200, Andy Shevchenko wrote:
> On Sun, Nov 30, 2025 at 12:46 PM Crescent Hsieh
> <crescentcy.hsieh@moxa.com> wrote:
> >
> > Some Moxa PCIe serial board variants support software-controlled
> > termination resistors on each port. Users currently have no standardized
> > interface to enable or disable terminator state from userspace.
> >
> > This patch introduces the following:
> >
> > - EXPORT a new sysfs attribute `/sys/class/tty/*/mxpcie8250_terminator`
> >   to allow users to read or set the terminator state (enabled/disabled).
> > - Implement both CPLD-based and GPIO-based paths depending on board model.
> > - Track runtime terminator state in `struct mxpcie8250_port`.
> > - Serialize CPLD modifications using a new `board_lock` spinlock.
> >
> > Example usage:
> >
> >     # Enable terminator on ttyS*
> >     echo 1 > /sys/class/tty/ttyS*/mxpcie8250_terminator
> >
> >     # Check current state
> >     cat /sys/class/tty/ttyS*/mxpcie8250_terminator
> >     enabled
> 
> This introduces an ABI without documentation update. It's no go.

Just to confirm my understanding — for any new user-visible ABI such
as a sysfs attribute, the corresponding documentation under
Documentation/ABI/ must be included in the same patch/series?

---
Sincerely,
Crescent Hsieh
