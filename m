Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C6F3D47AC
	for <linux-serial@vger.kernel.org>; Wed, 13 May 2026 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655073; cv=fail; b=ZbQF0CT5+ztWwiYJW+39av1kz5KL2Pu7MX22pZ1xxXiaA2jYYaUbTDjCEpxFJUck3oHpBLOQtu5gVudXUZYOF2dzoD8sjONSXBl9ayWy2IHaPIfZiIwGDSYTZL6a3qEKY98V9CCbYYFztjRhb5Gqj0lA+AR6NGrTuQP4DYN/Ptw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655073; c=relaxed/simple;
	bh=y8ZW2C56nF/yGjVmQ3y5EWEmfvAcKxVmca7eifjv8n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WIFxROWgp6+n1SvWEuJbNzJuYmHNOXC+9ZnUwTw7h0PrZlzMzW8u4atZGLf6+Q8NsQQE/yx6LkEQRJNXzMV8izWPiDQLUl8tDwZ2922wOO9tifNw1GsKhwEQm9BWMI8YB1HqiQDoRYKkOJezSql4mFn+7ydzUBT42uY/IECY/Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=XFkmfYSY; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="XFkmfYSY"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D1bveu009107;
	Tue, 12 May 2026 23:51:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=YVK/O9vSO+ydruKdA3xkWB1Q0O4F6yjHhNpdSvmrvZc=; b=
	XFkmfYSY9Ajz0TyKBsW+e2VZYnsLhD5fpWbUw5KdkHDgp+XxBfECsigdADyFCOEm
	88i3gdKwnbzsBQA4eyd0MsV2aSawyBU+Zfcm1btYD8crHdnYVSrxAUaRuJNQ/XzC
	+RSaQydfeJ2+5RwA60gRAJOaZCH8FC8pSEw+vM5ZKsTSrNuqrZ3RV2twaItKMvk7
	zqf20SbPuX8xm6htiGgfLTjTY98NDvHvnoq0wwo8mJD+2znVAkKAI+UKFDsMoWQh
	vQi+KWy5Ep09F2J0oW8K4sSYdHvpHb+iuswhop+UTiw/NePRqxibKhu9xU6or3QM
	dE3csFb8Rt7TMZv+GDbncA==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013013.outbound.protection.outlook.com [40.93.196.13])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4ftb8a21-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 12 May 2026 23:51:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTmG4kMesDosZWtaVerlGACeSiFTjxYEkyRdG3r3Tut3dYnemF4KZr69bPHcji6AQlopv/Tl9t25FfkLGbIcAVBvEyzG9HFFtcNkkPO/lG6DbYatWAlY/bEuCp+Gw1GcxU5V936WF4mHNpFqsn/dAXM0mrLN8KrcYo2HGKJOhHw9uF23rsYzl3ZHZFs33xDVLffEU6IBrsC14UVfPzBrc1fJeYWFDLBffZ0O2BQbNeRKs3/JFgLh2N84MaYRyiOxvy2GrhN5kF1m6vtcK+vIh3xds+tbc9GYHOM8lJlren2YTlPz7hVYxg7O/2k91jCcEOfTTaTZ7FQwBeA7Smo6NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVK/O9vSO+ydruKdA3xkWB1Q0O4F6yjHhNpdSvmrvZc=;
 b=kixA2tVoj8VVDlSiWwJc21ndwWYgVuPrRFpf4SkT2ARcpO/18KZy1dUitXn6e+xOqSrp9GJ7zD5AIYatPu/orZ1SZkCFTHvAG6BUw8wW3+StUnfr8/d8OEcn6oYVSxgce5uPTLpFLPC1nAp6q0WiKcW74UmiDc65dhkbCrbsjRHrjdZ710so8sgh5DBDQRqFjy3mMMwNTY68qlPq8pyxA9bIfrTfG6ANd/qHHYBqosD2f5QjHcVkt6svMSBterkL0bXxf1wZ4D13xsVQg734sd2tqZPR4tylWlJBCZilpxThAZpu+iaizJe2+47JeT2w38jsXJBhmvwsmb5DqvAIow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by BN9PR11MB5289.namprd11.prod.outlook.com (2603:10b6:408:136::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 06:50:59 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 06:50:59 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc: stable@kernel.org, andriy.shevchenko@linux.intel.com, wander@redhat.com,
        chris.friesen@windriver.com, linux-serial@vger.kernel.org,
        "Bandal, Shankar" <shankar.bandal@intel.com>,
        "Murthy, Shanth" <shanth.murthy@intel.com>,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 06/10] serial: 8250_dw: Avoid unnecessary LCR writes
Date: Wed, 13 May 2026 09:50:24 +0300
Message-ID: <20260513065028.112468-7-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: ced2e111-4481-44e6-4e8a-08deb0bbfda3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|52116014|10070799003|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	i5NHLb+qKE6DiaEqv0cmBvJLBu0WVdsjf3bNF2g+e742HvGYjT9CpFBm+yq1qP9prCqx/M5npnUOKfzeQ0ts6b28ATZut5hQ6ks4btD50Ans6TkTezicU3HWwNjCdu/Nse2EYFoAoznGccQuCuz5Zej/7rpUkHVWbNZhxpn4+BtEH/7W2eCKJJyYcwzmfKbl1dqvn+963bEtEPgjBAUz1AZ9/VEsPVUVwDw6moPCXaiKjGQk3E90NigUkFmK6yc7/31LsqPxE+SUMX0XrkxAO7auQLkDwLi66V8cZIa8UybdpvmqNixuPVwLp46mn8DGni2BbQYTslz93UGl3a/2Q+tK48fhgWLgFdYFL/KIAmdRMPhfTuprQiFn+BpqzhB/sx7u2zkL0bFLRuhRY08NvJxhfrnByUjBuFBKhm1DIcECKvsUHGcQd0p1mhVadWvL3arumzPypsMyKltpo5UKgy81S2SWdnsZxnInQtqeiaPSFB8ldTG8yhkSMjEuR66650pMIRgxpNP2eLS0bt1OgVbBml4MsSXuYeUGj99Bu3o+loHTIAFqhDIE2G+QfO54PgWJNmGeQn4ev2i/VlDMg6AbpT02mAwHckodbRnAa8jpiWke09fce0kJ7koONByldl3mk5lRZftGLWeUdsjLWw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(52116014)(10070799003)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHVVTW85ejJvdVM1Wm9Hc3pvTTliTFJ6U25OcEs0V0xIMGY4dHhzYUd0ODd3?=
 =?utf-8?B?NGdlVllCZWNZNjEvT2JHbDc0aE5IYVJjVzM3ZnhkQ0YyeTZocTNmSU1odmhH?=
 =?utf-8?B?NFpOVEV1b3NZYStFbGVzUk5xaUl1SlBDbTRlanpENG13eFUzVHlBS29rRGta?=
 =?utf-8?B?OEducE80ajlnY1NoTGlXZ3pmcXk5cDJLUVVtdU1MY0RVcUN1OVN0MHl4Vjlv?=
 =?utf-8?B?dE5naDIvSDd4clZlc0Nyd2FMeGo2OS9mWW5MMG8zQkwwTVAydzd2TjhaVEow?=
 =?utf-8?B?U1dQOU50VkR2U3FFZGFsZ2FHN0FuZCtXVmtYREo1Q3NaRnAwdWhiY1FBK2xj?=
 =?utf-8?B?WDNURHJRM3JjTE1lU3UveXc5cCt1SnNjeVJFa0pQZWpOb2FSUWJQdU4vRFlk?=
 =?utf-8?B?b1kwSDUwcTl1N05MaGJNY2tlQThvTGRETFNoTG5ZcmFGRHpvaGxwcDVLVjBk?=
 =?utf-8?B?M21nUndOSzNvODhoUy84dU55Nk9iWWhvcmZ2RmxOdDRXaU1pZFJxT0s1Q2gw?=
 =?utf-8?B?V1NZOEcxUXNDbUJaaTNlTmlCR0hTRFhPVkk2elJ1akpGWWpRaGYydU5pYVl3?=
 =?utf-8?B?TjkwM1hvUG9oWS81emw4Rnd0dG02S3ptVFVSQlNmbUZqblhTS3FTUC9QV1Ar?=
 =?utf-8?B?aXh4RWpBQUJpcU1XVEorMUdpaGhlSStyT0dValcycWVVclI2OEJUcE5kNHp6?=
 =?utf-8?B?ZEhCalFXRkNBWGRzOGFHQkV3ZmNMbUY0a1Nia1dkQ0kvaXdOSDhNajZiSTBI?=
 =?utf-8?B?TnAvdGFMS0lUcjZzRkJmMk4xSUJSNU9VY3JYTTFKcC9FdTVkdlQ2YnJKaGds?=
 =?utf-8?B?WjdlUGZ0Y3BGMlFPS2h4NXI4aEZWUnFWVGU1eXlReGRQUTQvTHIrODd6S2lS?=
 =?utf-8?B?ZGs0RHRVOGc3UnhlZGRQODhyT09DS2ZOSXlyaDRReEZ2YzB1ekdmdVl5bHhF?=
 =?utf-8?B?dTk5SlNmOUR5MlNyNDhuOTlvUHRyTmpPeUNJMEJJNlhDR3dSMkE5eGwxOGRt?=
 =?utf-8?B?TlJqTDdKeEFxUUxKZ29UQmt2SUhPZjVoekticzJUTURwSFVnSkIxT0F6NVpv?=
 =?utf-8?B?Z3dwS3gvb3BhR3lyNnNrd1RrK1Z4UGpUUE9EYzFxdEc2aVhQTzl4V1ZZSzlF?=
 =?utf-8?B?MWVTY251Vkdzd1FDeHYraGFYYjRJeDlOUHJHRHVHQzh1MnQzYUk1UVRValh1?=
 =?utf-8?B?NjEvUmM3OHY0UHVtdUprb21RTnBTT0Q2dzVtdkRVU2RFZVljV25TU2dDeHFl?=
 =?utf-8?B?N0krQ2s5em5YUDBWT0JhK3VqeDhrUEgvaXZjRXE3dWFGL0xIbHp4OGZKRTNv?=
 =?utf-8?B?MmswTytMZ0dqdVJBMi9FY3FvK2tnS01WaHhoZEhxREFOYmphek5OMlBhN2Iy?=
 =?utf-8?B?Y2h0MlBtbVo1eVQ4bnVEYlVrSW00NXA3YzI4Z0VDaTBQa1JnNFJEOWhQTDFE?=
 =?utf-8?B?WmVaSWJnZWFNWDJzOHFwL1drMHFIYy9sQzZETWsxaHY5UnVEYXdhR1FPVVRq?=
 =?utf-8?B?QXJ0YTZ3cjcwbk1qNnVGajFVRmRvS1JJdzJsekxqeW04ZFBWcno1cmo2Y3la?=
 =?utf-8?B?dmNxR0RYdThzZmx1cko4NlZXd0FPQlFoU2Z0clNPRjA1K2FDL21idzQ0RGdw?=
 =?utf-8?B?UUNvYU1lbFR5OTZmbmtDUmorL1RJNjRIZEU5eXZlR1hzdnYvUzhQbVQvbUpG?=
 =?utf-8?B?THh6dGxpZUNQMTNIZWtNclVncERldWk3MnhwZE9MU2Z4MEdqVXFRbXcySjEr?=
 =?utf-8?B?VjQ4NzBMZ0tCTGI2dlZwYWZQbVJYbWhwbzI1UEg4NjFyK2V0MXVEbkpBdkp6?=
 =?utf-8?B?OWIybk96SDJsaHUrYnpkejJJV3E1S1ZXRnpNdC82eVA1eElRZkxscTl4bVp1?=
 =?utf-8?B?MVlXTHV6TWhXdnZKVEwxczFxT2laeE9yL1dPZEk2N0RPaXp0UTQwaWdhb3V1?=
 =?utf-8?B?eGREYlBFYUNkVjd1dHNmeTJqaGY4UDM3RDI1cG9HSkcvWVdjd0tTN04wRmhC?=
 =?utf-8?B?NjhUK29jNWhtVUZqUjR4bE1TWmJvVW9sTWQrYVY3aDhrZmRZc2JWMGpJanR2?=
 =?utf-8?B?TWNZdFUxRWFZSHVaVDU0YTBueVp1L3ArM0w3bkM1VGhkOXpmbE9FZFNGd3FC?=
 =?utf-8?B?alNsRlBBbXdGRWxSaXBRVi9hS1Q2ZXhWdzdzQjJmaXVWYmlHRkhlSDlBMm9q?=
 =?utf-8?B?RlVXOVNUdWl4SWlPRkFXMDBld2FyUDNSL2hCUEl4TEFDZERWUzNlSWpVWVp3?=
 =?utf-8?B?MzdPbVQvcTZwZFhvVEZQL2gzY2hnZGZpazRwNHFGUG9uVUpPVm55MjE1eUth?=
 =?utf-8?B?U0lSTGtyNjVnY0g5SFVFVnY2VHBYS3hZNjJJbFVvc1prUHdNVE1MM2V0dU1h?=
 =?utf-8?Q?cMc4a12/RW84P0TOWS8UHpSNpbZD9oJ6q79UDc11MBqP1?=
X-MS-Exchange-AntiSpam-MessageData-1: shokhZMASwbPapxN1iMLoIcjooEyNBV1MF0=
X-Exchange-RoutingPolicyChecked:
	bj8h8/sO9KdQTYmAv6b8v+hwmMNokcCwxPEbP8cnGxQBSpVmouCbiY+HwCPrvi/usiAp8I6mHOTGgTjeDm+VpRfFVsFCiIuYBUEItAXhoopygyqk+3+zxRFi0szy8OwbzfPUYRsulZlx3CEgBN1PmKeD+rTRhFSsmEPsW+7qa7oRqCv22nE7SUGkY3Cuz8dr0sJ4djP5mAjtNuMBuslakXHe0XqEF1yJoweNKZe/3fc/6NW1lh8imiZlDN+hBHWE6ak1Tvz3O0HafjpgcV74cSOno6jTC66eBiQ22lC7v8T7KsT27151oQ60LuPgLihMwMMNGM3L9D3vNLEn3EEujA==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced2e111-4481-44e6-4e8a-08deb0bbfda3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 06:50:59.5224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOQaWouupw+snZGd+w7i7sJauyVo0Dsyc1LsLZ2V/BydT2p/56WEgt0PzQp3VjLdwqOkMTefd2P0H6UZLPwWq402RXubaQCuMw6wLZpwQrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5289
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA2OCBTYWx0ZWRfX6EaF+3agkQO2
 fe+t7VTpDHyrJZ8NCbIbwaP7DJEzvmUWTWuVTw5tjubxneIH/57SOaq+jFPGuovE9O35j/8fuc1
 IR4Aeg7+0f5M23mbq5qmMykw0OKgxNcs18q/OE+n5NRInA3oVnmBQTajfhsWR64DvUq8TzXjX9H
 wFnHWx5bF2ZrVbI7UjE/cEDsDopCVoM63Qn2dDJ8FtgFkXs9M4Qk46HbV4tuokpHYo7+o7/l7lD
 BOuFYZXc3qId6FbYPy1sCoxEY/Sisc0/vgV6cYWdRRVu+/WgteROG+JY5PMp4mz9JlwZ9Z2PKTq
 SvlFUN+AdyqmiLuw14lGSW8V2axn7YLuVMev375uoMbc+f0ZI/i3ZQNUuGzkHxx+o/Us4OgWJUj
 FEi1CV3pSotIM+KzHVbr+sA8r/2b1/dtsvy7Ytkqc9/iPc3p58sJn6D3C9DQRicwzAd/m9HMza1
 uaVpqk3niFv7D64AAkg==
X-Proofpoint-GUID: msru6wZaw2rAz17NtKdwN4JU_LHbp1LN
X-Authority-Analysis: v=2.4 cv=du/rzVg4 c=1 sm=1 tr=0 ts=6a041f59 cx=c_pps
 a=fOo0+MOGfjr111H4QC4BGg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=bC-a23v3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
 a=t7CeM3EgAAAA:8 a=FexixdgSPsgHR1urB5AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: msru6wZaw2rAz17NtKdwN4JU_LHbp1LN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130068

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

commit 8002d6d6d0d8a36a7d6ca523b17a51cb0fa7c3c3 upstream.

When DW UART is configured with BUSY flag, LCR writes may not always
succeed which can make any LCR write complex and very expensive.
Performing write directly can trigger IRQ and the driver has to perform
complex and distruptive sequence while retrying the write.

Therefore, it's better to avoid doing LCR write that would not change
the value of the LCR register. Add LCR write avoidance code into the
8250_dw driver's .serial_out() functions.

Reported-by: Bandal, Shankar <shankar.bandal@intel.com>
Tested-by: Bandal, Shankar <shankar.bandal@intel.com>
Tested-by: Murthy, Shanth <shanth.murthy@intel.com>
Cc: stable <stable@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://patch.msgid.link/20260203171049.4353-3-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/tty/serial/8250/8250_dw.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 88c55336d50f..05e45b63e5f5 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -181,6 +181,22 @@ static void dw8250_check_lcr(struct uart_port *p, int offset, int value)
 	 */
 }
 
+/*
+ * With BUSY, LCR writes can be very expensive (IRQ + complex retry logic).
+ * If the write does not change the value of the LCR register, skip it entirely.
+ */
+static bool dw8250_can_skip_reg_write(struct uart_port *p, unsigned int offset, u32 value)
+{
+	struct dw8250_data *d = to_dw8250_data(p->private_data);
+	u32 lcr;
+
+	if (offset != UART_LCR || d->uart_16550_compatible)
+		return false;
+
+	lcr = serial_port_in(p, offset);
+	return lcr == value;
+}
+
 /* Returns once the transmitter is empty or we run out of retries */
 static void dw8250_tx_wait_empty(struct uart_port *p)
 {
@@ -207,12 +223,18 @@ static void dw8250_tx_wait_empty(struct uart_port *p)
 
 static void dw8250_serial_out(struct uart_port *p, int offset, int value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	writeb(value, p->membase + (offset << p->regshift));
 	dw8250_check_lcr(p, offset, value);
 }
 
 static void dw8250_serial_out38x(struct uart_port *p, int offset, int value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	/* Allow the TX to drain before we reconfigure */
 	if (offset == UART_LCR)
 		dw8250_tx_wait_empty(p);
@@ -237,6 +259,9 @@ static unsigned int dw8250_serial_inq(struct uart_port *p, int offset)
 
 static void dw8250_serial_outq(struct uart_port *p, int offset, int value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	value &= 0xff;
 	__raw_writeq(value, p->membase + (offset << p->regshift));
 	/* Read back to ensure register write ordering. */
@@ -248,6 +273,9 @@ static void dw8250_serial_outq(struct uart_port *p, int offset, int value)
 
 static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	writel(value, p->membase + (offset << p->regshift));
 	dw8250_check_lcr(p, offset, value);
 }
@@ -261,6 +289,9 @@ static unsigned int dw8250_serial_in32(struct uart_port *p, int offset)
 
 static void dw8250_serial_out32be(struct uart_port *p, int offset, int value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	iowrite32be(value, p->membase + (offset << p->regshift));
 	dw8250_check_lcr(p, offset, value);
 }
-- 
2.54.0

