Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9777F35E1A0;
	Fri, 31 Jul 2026 05:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785477331; cv=fail; b=LYtc+D5ZF/1EM+ctDBIJvupkeB5Dd5VSks83Qrbi+DMK3F8rXvYtg161VtU59HilIKiBwLCjmNsd/u2XB31i8Wc9wvq71P3akDqOW9waUOWU66lxoVDkc/HXKKsC5im54lF5GFPpGhKgXMnPX5RMyKKuFiHYBB3svzboBtC6FVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785477331; c=relaxed/simple;
	bh=O7GYMq+CEMlaV06POJy2RNLkzR8iX3CwAcFWIZXWTBg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hli5OiHZ5TXCNq/ttR3gwTTJr1W6YozxiMe088UCXNTAkUusCT4o0G/1gfR1+ZpmPquMXJQ/OgBxAEKmVboUQBy+o/dm3+TtwhY7U2HuzADKPNNG6Z4NlHOpQTCaC6aixxFNcXxtLoTq+AlYgrNDiYz582SNZIbhMG0ZjjI95FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=RV9NKFI0; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="RV9NKFI0"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V4vYnQ1527721;
	Thu, 30 Jul 2026 22:54:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=UR40WV4z9ouLDdP5FacEZfvo2upY4ulMbb66HbroSRM=; b=
	RV9NKFI0vpkrNSgxZg0sXYDXEL1J1LlMhzFMVkPsCht0gEitA4MpgvRMXtzBUAYK
	Y7ZBJpXZuQ56CKC0kGGAUbcJoNngSvwVKAuNCeDvdRJFxM3qTnAG86MvbvxGYOor
	8q2i7HiOxBh5c/Qg/oM/w866zrILxBcH1mxs6nzJ9IiiIGDqRv8BAe7PSYJSKvD6
	YjjwV8ROihajMGLun9IyMKO32wWqMER1RfleWPsMlL9fEkqkoB4a4OSgD4ssIwpD
	faogr06vOyI4wtP6X6aNevqBofoNJKJ4KuxY8tDqAIfuSJ8maesxv/A4zR0j09Rx
	1JMuspx9xUCReMDpBBP6EQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010047.outbound.protection.outlook.com [52.101.201.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4frn2rr26t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 22:54:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N1BK6xZcDUSJnq9WL9JETh30FGrYYLIvfWwxwUreCF0RFgb5JNPGAGnt3d7COiNvxQJdLvZ+xTDZtcM67fCZDzONFyPoBzQHlHVEJKnN38LxOkqrC4rAidEVr4fOJPGpO//4o+va7rXu6QIQLWxR991CWIfopDDd9sUlOYBCGa4L4OkF9F9LfAF2P6yNWNxnPqVqP5xQQr/jCheSLMozi0L7K+jUY+1d9dW4naVbyWSHhsAC7JsFW/EqN16ygGOKlNoEfpXYWTLfyvXjp2QoMw8e04C/pJ89IHG9B34QcPBT75RRSRuEuYa8vL6YjzXWx4R4kcYX2tHTYOwkOcMYxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UR40WV4z9ouLDdP5FacEZfvo2upY4ulMbb66HbroSRM=;
 b=lZXTMxK8GqXHZhjPm6L014XcFvrHoiKU0HEjCls6IkR14pA8cnn5bs8qKFcba5OQUMQ3g6IrCNwVGYHX0G/P2EsfP5ts30WjIPMNyMg6EpTa64PJ18XbzIeRLE4ws9Y4GJjtcSOjFOwN0o3y3uQ/iqtXzzJanbn7pcKou8voUuuYUVyo/GU+OHyaCOZFJNhn2nNM2IwmW95mWpzP6f9AUBNWCSQp+AcEuLbUdIDVf2bLWCH6vngWDMoYmZ6JgUWFUituQTu3W+qACc8hzqthzu/kZjcrwD4T3YSQHRB1sk90JqbY6Sk2KCqW9Zd9d7LzB8YQqPA8U8lFTyWPvbo/Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH0PR11MB5332.namprd11.prod.outlook.com (2603:10b6:610:bf::17)
 by PH0PR11MB5208.namprd11.prod.outlook.com (2603:10b6:510:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 05:54:42 +0000
Received: from CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13]) by CH0PR11MB5332.namprd11.prod.outlook.com
 ([fe80::8f86:8d08:45bf:ec13%6]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 05:54:42 +0000
Message-ID: <ccbe9f70-8ec6-41f3-af8e-2cbf84b4d652@windriver.com>
Date: Fri, 31 Jul 2026 13:54:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tty: ldisc: fix deadlock between ldisc_sem and
 rtnl_mutex
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, socketcan@hartkopp.net, linux-serial@vger.kernel.org,
        mkl@pengutronix.de, linux-can@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260724084648.3879356-1-yun.zhou@windriver.com>
 <2026073027-nervy-imposing-0068@gregkh>
Content-Language: en-US
From: "Zhou, Yun" <yun.zhou@windriver.com>
In-Reply-To: <2026073027-nervy-imposing-0068@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0027.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::22) To CH0PR11MB5332.namprd11.prod.outlook.com
 (2603:10b6:610:bf::17)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5332:EE_|PH0PR11MB5208:EE_
X-MS-Office365-Filtering-Correlation-Id: 745cb8ca-fb8b-4943-2a54-08deeec836bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Uol3qyNFcd/pEhpeLOFX32oAJStE34q+1SoEo1lyeNm1zYJbJt6eXFzXeFJnhQHALme9tCzqH71TITTVio+8VAGR/iIKVdob5CR+4vG1xuzaG7QMe+7Te2iuTC+fLKhMRjbGYFcodIUR+fRUZelu212bpup4Bq76lNmu+dKyAs9Dns0df0iPtr+65oZDg+29i4ojqpDLnrrOvhOPpcxnhk62Rk6+qGjPEMCQcNAmDuyKH46MoPlDq+3HU2r45/fa9VnTri07vVaIOj/dQWuVruK4gW8TeGr5MEPGTzbPIyh9t0R5IsksbxVzCM6dAWz4tAS+ENMGzg8mv3go17opxoCgTUYfswGgRk7yFKzK9pPFLn092ahkxe4y/vvT4DxJkQQfQQVkIbJTTNjTEDisW/dDbH3SYVMLdrLSVScEg6rE24vixY3WWpCqYY+a/KNZVRpnVIgU7oYWaHfssFTRSmaaSm8YSXYWjVwHGpE5VsA7peecGyiPjtxw/Ji1pM54C/x/Y3fikyWE8k5TwqTI5ETCGk1XvuAMcBXOMqg6l4kr1e7gy+4hwBIXECv7BRx6DojblFvk2mJckmTnNO8eCQNIOCvJ5L4hXpd0newf7Sw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5332.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGJZam5vbWQ1aDdZd2VMWGxWT09GUVJnVzRpc0dOZ3FnbWRhYnBoSlRRaDJM?=
 =?utf-8?B?dUdlKys2SEdQc2Z1bzFUaTgvYTNMU0syVllBYWhrZm1RS3U5TmlaNzYzNCs0?=
 =?utf-8?B?MWJhdWVHWEx3dFg4aGFRQ1AvTDlTdDViR3pUclIwdFBvSERQWmNITXdBTnNT?=
 =?utf-8?B?MEo4cmdtdVdXdjlHS1lIU1lKK2t1NFlCVVVuN0YvZkdtcXhqdnVvMytWN3I2?=
 =?utf-8?B?YzJxNEJYbUpwOXZIMUVub1FCTDV0QWpia01EcFJpckZFWVJOdFZLQ1k4UWUz?=
 =?utf-8?B?bEZBemVJRFdYdjhUSUUybVAwcVovS2hqMFlLaTdUczZ4RzR1Ui9VbHpJRWxL?=
 =?utf-8?B?SjdYSHcxMjhhOFM0RlBMYkpCTk1rWXlDNVduWVBiRkQwSG5ncm82bHN4Q0NM?=
 =?utf-8?B?c1E4WXNKa21lTFAyYmVqYmxyVmtleDFjaEM3RTlDdVJ3RjJtWjNDVFYyWTZW?=
 =?utf-8?B?eE5JT3IvaS9mSTFLdFd4cnNYRkNpMVlpOCtiM3dSTzFucW5Ia1RqSlAvUG5U?=
 =?utf-8?B?TFc4cm5YQit0MUdxQWZmSDNJUC9RV09KYTRiektVUGRYSUhOS0JSQWE1MUpp?=
 =?utf-8?B?MDJTV2I3ZU4xbEdmL05UQm04K283Mi9oaW1xV3dDUTRXWEtrNG1zU0QzQUp2?=
 =?utf-8?B?Qmt5WU1ha3JMNFBMbkVrT3dqSUQvNlY1VndLSHhDdVdBMFgzWm1ob092T3lB?=
 =?utf-8?B?bFlPZThUSHZIdHptMEtoSTY4SFltazhtVlZBUGVPOExPRVFTckdjR3dlTnpF?=
 =?utf-8?B?YWh3TEwvMnkyY05qdE5iZ1RHNHJzRDlrZTN2UFZFbXFad2dlR2RRY2VXZi9L?=
 =?utf-8?B?UUJSbnloTEdSRTR1UVlveHRVOHVrUnZnSTdDRW9qSmM4UEs2VkVKcVdTR3Z5?=
 =?utf-8?B?SDVYMGkvc08vM3BtazhQYjJnSTJtTFNwbU5XaVU1RFYxWldZM2pMam1VK2RE?=
 =?utf-8?B?bHljNkVTdmFBdHpOQ2RmTlZUSG9ubGJMay9EVzFKTm5PbFUza0F6RW5GSzZx?=
 =?utf-8?B?U1hWT1h1QTVtbjlFcDlBVVl2WDU0bUlBYmdHbFk0Smg5Q1JrbndWUENPOW5T?=
 =?utf-8?B?M3NuakJDVVZleW5hamVyVVVxQnY2ZnFIK0ROQjlyUXBHcUl6VDFXVHZldmF2?=
 =?utf-8?B?ZEFwdHExRG9NdHM5TVdLZ2w2RlZveHNvbDM1TGdLQk84aGNraUhPSU9VMHJR?=
 =?utf-8?B?Y2l2RllRQk1UbXAxUXVHVGVSbStTSEJ6QW15aWpCeERDeUdBL1lJSGpNQUNo?=
 =?utf-8?B?ZGZvbkx6Wm1oSHRFZjBpSFFUMG0zcVVIakFGT0VzMU9hUnB0WXdOdkUvVFpT?=
 =?utf-8?B?SG1JbFcvbmhzWHAxT2JyMk05TDZhV3lHeklkT2wzK2YvVHlyZWF3RFJveDNR?=
 =?utf-8?B?ZHgvUTlPQkRoVGxjOHRXdER4YlJIVXZvc25UNjFYcHZHd2xyZnpoWnNrcDhn?=
 =?utf-8?B?anlHTTgvUVU1eEpIbFM0SksxYnpiR0Uramdzd3ZmMHJ4bi81eUZvZk5yRy9Z?=
 =?utf-8?B?Tzl1cFVwM0EzZG5CdjZ5TEV2Ly9Mblo2NFhGYU9McWtHcCtnWHpWZUdVWTRT?=
 =?utf-8?B?aFpHcElPUnhGOUlLV2lkdTk3dVVaQUljWDFTKzdyN20zMEg3eWVCMzlhMS9Q?=
 =?utf-8?B?M1dyRkZqbDhmSGlZSjE4dmlFbXdCU2N4bWVIYXlRclpXK0podytFR0dOMUxR?=
 =?utf-8?B?eERSY0dReXNiVytRQWtUZTJiaXJsanE5WDExT3l2YmJLcjNPN2RIR2o3bjNH?=
 =?utf-8?B?VDFET0JtRGJqUm1pTnQwakpXbE5NR3VLRDVlcWZRSERLdk1CY2tYczFCTUtF?=
 =?utf-8?B?WWEyNG1RakMxVWl3M2tuSUFZOWY4R2pEV3FhNDdrWlVNT3ExTTRSQWo4UzRs?=
 =?utf-8?B?c2xFUXJXbmdPSkJkdGFIRXRFeGVpbDQzRmlRZDhXZXFEVnpmWHFPdU1vRTR4?=
 =?utf-8?B?dnhhVE8xazRsQk5lR0hTdnpPNVExckpEQS92MUpScnQvRFFPdjB1cHpBcExH?=
 =?utf-8?B?LzgwTGFKRjVmQlpNTTF4TWpZR2hjbmt2MlE3ZkFqZnN6TGpkaHM4ZUQrbVRR?=
 =?utf-8?B?Y2VCK2tPdXRnSkVWcGRCY05jU01Xbzg3aDA0RFlTQTNxMGhYYlREUXE1M1Zm?=
 =?utf-8?B?VmFlWW1xd2ozNmd4QzMxelU1OWg0NFdEV3VFS1NZd3dkRnFyMlpNZE9qQno4?=
 =?utf-8?B?cVQwNEdsaitmRENUSWFqMExrMEhYVS9GcXpESTBCNForQXZFcHBkUzk3WUt6?=
 =?utf-8?B?b0FqdjFxSEhncSs0OUZkT2ZSVEhJQWZyMjBNMmpMV1lMNWRFM05pMElnajhr?=
 =?utf-8?B?MVV5SEJCMldweHoyR3VrTk13M0t1c2tmZUpqVlBlWUYxb3J0cFRJdz09?=
X-Exchange-RoutingPolicyChecked:
	LC69U7SU6E6+CIW6VyXfN9a38fxXPlW9CMS1nlBMj0lrWjQJ2/ilPnxTfA0Tss1+/O+n5wXwTTvt3QBafD77iO5Jhb3saX2TzqgxcyBy0nDcgi5YfnC5tAPEVoshal4t/Bm8UgGMhOLohmq48hJJFJuWO29lNqs910ksgGihDtdkpnBCXa4y72O8Gy81rssJ2mvv5PLFHfyf0uEX8c3zQj7bR1ef8GPCI8lsCxQEshLja66YXrrEhSMOFtkzJeFcVxmfNdFJmJhruhE+EXzRunhX9fcf4+hD5Xw/TjgjuAQAt+OdOELHj4MHch37fH7bWdc/K1pvGmhUcSS2EnJbUQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 745cb8ca-fb8b-4943-2a54-08deeec836bc
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5332.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 05:54:42.1904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hp2X37OiGZOL/SM1n8ksAjWo3rfO6zbjXbNr6WcRSdIrUK8aQYBd4mFodG1WQfo48wLnN4AutGl+ecL+YT2Y4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5208
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDAzOCBTYWx0ZWRfX01YbMGgmmCRX
 hPFCEDIajrtJi0zzGeqkRy9AviBWQy1FKk6vCdiqxFUHqz3zInxl7R2qNJd53PbJh4n+HhCmmmP
 GeRmeJ4xQqRJdwrdNMse79FbSKtTaHxnO9n1Bq/Phzcc7Zbw7unP
X-Proofpoint-GUID: Qx-OQsV4w8n2twtpN0zOtkpkZMPsaTnB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDAzOCBTYWx0ZWRfX+cVNqlzyIaKr
 0/y05DsEKOMhDFEJPDC3HScj+YJyDqQhaVBgddY5Ue0jS280o6+GwxxWnrybP+mdd8hHY0+xAde
 3q96d8Jy4o/8NCqKDcS/Zr76HRhOQ3CqBnrkMAK4KvzCr5fZ/cJ5Dq6zUCQhqQMKxr5iDzEAvRS
 KSvMTywA4+AFkik1XliByhSgrT1l3m/DZEgvmP4YmASY5Ho31NR82UQmNBUvimFPALX/xyW21sw
 n4K7xNhosWTlNdO6hlMQh3wFTZZS9eSJ5DeGSdC9IA4wH5zmvPtHw8Q220HrOSadla/UCcQuNFA
 knZfSFVB3+AvymaMMKcJe2Ahd9ohx48b9iS4HCH6/l606h52S7aX0jvX8QN/eBDcFxrbnocwugj
 rqNwMJbyoLcNcREmUjLV+FmndjVrYtgNkF4OkHJv7onz2RQal4NnfO2eJagZpER+5cjtEPmhrgj
 72wHg2LokGxBGkaBiMQ==
X-Authority-Analysis: v=2.4 cv=IJsyzAvG c=1 sm=1 tr=0 ts=6a6c38a5 cx=c_pps
 a=6zE/HbjXcl5L3wBq6eN3xQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=edf1wS77AAAA:8 a=c92rfblmAAAA:8 a=t7CeM3EgAAAA:8 a=hSkVLCK3AAAA:8
 a=RadySJ7YTPp6nKeyy2gA:9 a=QEXdDO2ut3YA:10 a=DcSpbTIhAlouE1Uv7lRv:22
 a=GvGzcOZaWPEFPQC_NcjD:22 a=FdTzh2GWekK77mhwV6Dw:22 a=cQPPKAXgyycSBL8etih5:22
X-Proofpoint-ORIG-GUID: Qx-OQsV4w8n2twtpN0zOtkpkZMPsaTnB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310038

On 7/30/2026 10:50 PM, Greg KH wrote:
> On Fri, Jul 24, 2026 at 04:46:48PM +0800, Yun Zhou wrote:
>> syzbot reported a circular lock dependency involving tty ldisc_sem and
>> the networking rtnl_mutex. The full chain is:
>>
>>    rtnl_mutex --> nft_commit_mutex --> ... --> ep->mtx --> ldisc_sem --> rtnl_mutex
>>
>> The last edge (ldisc_sem -> rtnl_mutex) is created because tty line
>> discipline .open() callbacks (slcan, slip) call register_netdev() which
>> acquires rtnl_mutex, and .open() runs under ldisc_sem write lock in
>> tty_set_ldisc().
>>
>> Fix by moving the .open() call outside the ldisc_sem write lock. The
>> ldisc .open() is initialization of the NEW discipline after the old one
>> has been closed - there is no need for ldisc_sem protection at this
>> point since:
>>
>>   - tty_lock is held throughout, preventing concurrent tty_set_ldisc,
>>     hangup, or close
>>   - tty->ldisc is set to NULL during the window. tty_ldisc_ref_wait()
>>     waits for the transition to complete. tty_ldisc_ref() returns NULL
>>     which callers already handle.
>>   - tty buffer data stays queued until the ldisc is installed
>>
>> The sequence becomes:
>>    1. Hold ldisc_sem(write): close old ldisc, set tty->ldisc = NULL
>>    2. Release ldisc_sem(write)
>>    3. Call new_ldisc->ops->open() without ldisc_sem
>>    4. Re-acquire ldisc_sem(write): install new ldisc (or restore old)
>>    5. Release ldisc_sem(write)
>>
>> Reported-by: syzbot+de610eeef174bd59a8a3@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=de610eeef174bd59a8a3
>> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
>> ---
> 
> Sashiko has some comments:
>          https://sashiko.dev/#/patchset/20260724084648.3879356-1-yun.zhou@windriver.com
> are they correct?
> 

I've already responded to Sashiko about the "New issue" - this scenario 
does not exist [1] . I'm not sure why my reply didn't CC you - my bad.

https://sashiko.dev/#/message/3894bbdd-1930-4ad4-8b28-431a162aece0%40windriver.com

As for the pre-existing issue, it's very hard to trigger and practically 
impossible in real-world scenarios. If we really need to fix it, I'll 
send a separate patch series for it later.

BR,
Yun
