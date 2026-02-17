Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793CC2D594F;
	Tue, 17 Feb 2026 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.146.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365812; cv=fail; b=da9rGfsTXVsJyB144OEdG61tqvdt2biuzrApp6YhFQ9N+i5Tlr19ZOWE1WJdse2wgt7eLCbSeBnVWKrE6FAxpoS6/aIQrwn3ZfW9c4gb1iMEc0ZeFehJeMHsc3LMs0R/974csn2duoUhiJFXByzdwQzqXS/Kl0zE/SRwgsOT+TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365812; c=relaxed/simple;
	bh=07yvk/O1l5VzLCZx4g8L4d0RlLwjnGi7Y7nJecwhTqI=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S159HHh+Xt6EOuYd/nhvS7RuRlqdPc4IogNZS4C1LPwJ3utcfzW4ZljUoxUkY2n89I0145jQbhyTp9jr4270+EDkc9mHZ7mmYQ+sUhchNoVZYsqc+Xl6X1WldW3q/K2HW5OwMBMeSj4O1fNukcEfRA4qkzCkZe48oCI7yLgJuso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emerson.com; spf=pass smtp.mailfrom=emerson.com; dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b=frFhUd2x; dkim=pass (2048-bit key) header.d=Emerson.com header.i=@Emerson.com header.b=njXlArZs; arc=fail smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emerson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emerson.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b="frFhUd2x";
	dkim=pass (2048-bit key) header.d=Emerson.com header.i=@Emerson.com header.b="njXlArZs"
Received: from pps.filterd (m0484887.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 61HLRdF4002173;
	Tue, 17 Feb 2026 21:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emerson.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=email; bh=SOsh
	V8CiI9YwNAyAmSgRUbJsaGxByFVVLpx/7NSzgj0=; b=frFhUd2x6X4Wc+Scb36y
	pxgIxrp3uIdMfwHKGE6hsbc68wwkFzeA+D63FeOwc9pPHrOxRC5GxadHpWzUDnto
	P/xvxaLODpaJ9reVSByhx0csD9nkvoWGpTvRTUDY6Zy2lNAVHPXeaC0FJEyt0BWh
	uUGkNA/9LENhoeb2+FjP1GRMK1SKOSi0VHHdvUpwczB1KSQyw/zUZg1T0FD4JMno
	Pk4r7EPp9LmOVaa+c1VYp3rlWFB60JRyOnBT2rUv9XHIB7WAAnXz/VB/9Am8PHJe
	un60HhneA7wp3YfwIFgbdUPUbczN2PF9uEro2Jl/3oRO7AppymdV7dNgK6qwyiXO
	og==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 4ccb00gnqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 21:48:12 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRNo18RjdDPdrxz03G28oCpdToH+E2VAeksV7NyZUH6Jm1bM5MUv3lRQLzZ3fL9GuVpQinshpgyl7fL3YD3BXcMCNSUoCoBYVWoH4pcX//ZNE+IEaMB0q1SZD1ussIaP1rgqX7As7Q95oSd2SkNq3uUAqRCZ2HgJ+JpS51paeCmRAMjnlMZ2fkyPNUZVwzI9P8dB6htTRneCoUrEQI6CXb6Ey20jtEOIqtWpzh6kTZal7RkUv/LYwZS93LnEzdknf685TvBNUfjGFgVubSc9Tcks0d+dRTAGuwVkBh9Q1hwDIO80m6EZXAygmrLoPmd2RxHzKBHPj9e2G47oQrtrKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOshV8CiI9YwNAyAmSgRUbJsaGxByFVVLpx/7NSzgj0=;
 b=BEAwkYGMbcOTlj1udOkm/JGCcWb3Vhhj5y93c8kXr6ALT7ccH26hXrZUmYoEn5O1shFjXNYATKz3do5RB0LRBnrFzZy4XURDxvAyTeP/3PSh67drDqmMbpF8iAY8xqw+KHNEH/XxzgK7oWla1zHNHU/jPkIZtTed7QkwV1DH6kMEEOgqgEekDSDBieAKp2E28OxN4UZqGDcygDUFCiOxYPzOHNadmXG9DOlGw3JOe+d4zgtIgkvbrHCnJBhQyhPv99cY/6clYx2fz40GUMphcl6xy1I9/ZHxhhgdsXv7JY01QruWcf/b8unq4Na1lrAF9gzzBYbjL621v3dbCOkNzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emerson.com; dmarc=pass action=none header.from=emerson.com;
 dkim=pass header.d=emerson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Emerson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOshV8CiI9YwNAyAmSgRUbJsaGxByFVVLpx/7NSzgj0=;
 b=njXlArZsadzrxd3HAEuSqqGS+Q1tdrwXPa9/0/et9k9hZUzv28EqGXOGN9DWZMsa1VzPiOK7YDXRNS3CsxdJ064fAshjG5GXOmNYRXNok2u0axI6z6+VKZqLknB+sfHPxvwZbQwkA61IjR/PlVFlDwyOvdVbiHlsptxOXB3gwRmrIXXyEbpHVK6izA8QSdz53JBJcWpztplMtguIqqqsX4rQMWuJPEoT52xOnfX/BJEuZN0SE40ECj2hzoeZgqJcyEcQig6aiLrs71cu/Jd11cTDC2SooAhSGRbTCL5gq/mdthiiP9IqZES4U50fNACXdOUSKxH/ExKvB0DSKo1lIg==
Received: from DS5PR10MB997728.namprd10.prod.outlook.com (2603:10b6:8:343::24)
 by BL3PR10MB6164.namprd10.prod.outlook.com (2603:10b6:208:3bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 21:48:10 +0000
Received: from DS5PR10MB997728.namprd10.prod.outlook.com
 ([fe80::760b:7033:70ab:741b]) by DS5PR10MB997728.namprd10.prod.outlook.com
 ([fe80::760b:7033:70ab:741b%5]) with mapi id 15.20.9632.010; Tue, 17 Feb 2026
 21:48:09 +0000
Message-ID: <454a61d1-9269-49cc-aa59-0842acc32710@emerson.com>
Date: Tue, 17 Feb 2026 15:48:07 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_ni: use kzalloc_obj() for allocation
To: Pete Connor <pete.connor@pythcoiner.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260217031913.1166949-1-pete.connor@pythcoiner.dev>
Content-Language: en-US
From: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>
In-Reply-To: <20260217031913.1166949-1-pete.connor@pythcoiner.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:610:52::35) To DS5PR10MB997728.namprd10.prod.outlook.com
 (2603:10b6:8:343::24)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PR10MB997728:EE_|BL3PR10MB6164:EE_
X-MS-Office365-Filtering-Correlation-Id: a110fdf7-7647-4520-2688-08de6e6e3da3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c2p4UWhYWUVzVDVLdzdLNVE3K2NSSnNFek1kVG42bENPaGRNTnVJSnBQMnEx?=
 =?utf-8?B?MWxYUy9lS1VNY0V4MVZvR01BTjliSVVOVUsxaG1tWno0WWxNUGlpb0R6Q1BV?=
 =?utf-8?B?UnN6TXdCTXFoeDFUc0xuY3JuS2xkS3IycEd2amNKcFdtbTVuVDQwZlowZVNh?=
 =?utf-8?B?ZDdXekpIRUlnZy83UlMxYk9QRXVXQ083YnRhTEFwU1ZHa3VOT3hqL2JjS2dC?=
 =?utf-8?B?Qlp0dzdWYUgvR2JHTFMzNTZRcmhyQUpnZnBJZDRVYWZRNStSTzRqRi9HSjdR?=
 =?utf-8?B?R1NlMEQvZ2FHYWFKRVpEMDEvc3J5QkxIRXV4YjZLaG9ZOU1vSjZudXhYUzA5?=
 =?utf-8?B?UEtVY1JxZ0FvQ25pSzBtQStZL2FRNS8vejkyaHh5UFFieDFiUHFnWVBUaWtE?=
 =?utf-8?B?eWdtL0w5NWhMQXVZU0VibWp6U0VEVXVZZmtSQ2Q5NmE4eVJIbVVtdDNDNUMz?=
 =?utf-8?B?N0c3a1NBWWhwN3dDcXhVS1luVTRyMThuK3dPQVVtZmtLU1VvbkMrL2dsaTFD?=
 =?utf-8?B?ang2SmdRdklWWXRJQ25memRzTGlPOXRqcm9ySlhyTFljUzFPYzhaNGRxbVdF?=
 =?utf-8?B?TXZVbkExaE8wakgwcnFIWmlia1ltRkZsSm5obHNBN3VhOGlVcmF6ekpFYU1H?=
 =?utf-8?B?aS9ib3hNRmoxVGVBYU02YVIwbU5YdGpnU2wyLytyZDdXTGxaV2pQMDhnalV0?=
 =?utf-8?B?UFVXTjZXUjc5bnZKT1VJRTYwaWh1d1pUTDlkS3BoenYweDd3aWhDQUtiTEdR?=
 =?utf-8?B?NDdJbVp4ZmMzSGExdzdPeFVYZGZlNjllNXd0bHBrbmQ5SC9wVXYrdUtqb2F0?=
 =?utf-8?B?SndLUlprTXFORGYxR0JMM1ZOTllaekt4ZVphVmtNWFl4VXB3TnJwNUx5RTFR?=
 =?utf-8?B?Ly9mclNmdVhWb3FLZzZRTDVjU1BJeEI4blJuSjdGWWxXRzJCN2NxYXlUa1pG?=
 =?utf-8?B?bkh6UDc5WFl4OE1rMXBZdkcveXlaNjRqc0RGWDFSMVFwamFwUzRaUkF3QklN?=
 =?utf-8?B?VUxBZVlKeXNaVFAyWHN3N1QyMkEvWmhKb1JXb1lROXdkWjZkUnlVQzUzbGNr?=
 =?utf-8?B?Y2xLWWFJL2pycE16MmtxeXZjZHJoWE8vcEU5TU5qZzhmb1BZZjFNZFZkclVt?=
 =?utf-8?B?eGhMUHdiVVlqOXdNanpESjQ2ZjZtbXN3NEs3N1dRR1hNdFlsWVdaOW5BMHFS?=
 =?utf-8?B?bmVUaEIvY2RBa3pDZFA0blhPUkFwaGFFaWFEU0tzTjN0L1B1TFdYMGswM3lG?=
 =?utf-8?B?a2hZek5VN0pTaUl5ZTNPMWdNQjVyalliLzFqT3RxbUN3d0RSZTlpY0dNS0Mr?=
 =?utf-8?B?MWlDclZQcTE1SFhyTGpGZFU1RG9WdGY4MzQwUExuQ2VpdUpkZnNXVDVXT3Fk?=
 =?utf-8?B?MjY2NklGV3htSXQxb0VsRGpkTUg5aE43aFl5bFB3aENuUFZveE4zZlc5MC82?=
 =?utf-8?B?Ri82QlhKUGs2MmJvRkhsWVFLeDlhREpSSWlKOEFUUTVXZTFxT0NseUZmbTgr?=
 =?utf-8?B?UHpLbHJqV3JFM0IvckFFRkZKRWx5TTQ2SjlrV2Y2Q0dQS0VTbm52Z1I5MldX?=
 =?utf-8?B?YkQyc0ZiNG94SlRvWXVtTzBpYzlQYlp4bGpzdmJvNkFGM0czd0VuK21oelBS?=
 =?utf-8?B?L1EvNlk1UG5va09TVzcvUVhQRC9zdGQ1aFNxTVhqVzBaT1JsWERaSVV6cG9q?=
 =?utf-8?B?V2VmTW1xV0pxWTQ3Nnpoajg2SHduRzFCampyNXUzNHVWYjB2cjV2TUxDbkpJ?=
 =?utf-8?B?cmNWUitrTWl6RlJCcW9UU1lMUUoraGhBTklxN0FNUHNNUktBeUdsUUcxYlda?=
 =?utf-8?B?MXphS1FMeUFGa1FGdkxPaFlRbEtaeTNkakJ0UHJzSEkvNkNDOFB2cUhESFFG?=
 =?utf-8?B?UDdTcTczOTVJMWFBeFAzT2R5Yks1VkxkVTVEYklUWUZsazF2UGtsNUE3UnNH?=
 =?utf-8?B?N0x2ZEhWNGdDY3EzZE42bERtQkFVNW9aZ01IUVR2OTNvQ2s0Q1N1UlJRMDBI?=
 =?utf-8?B?THNuUXNzQ2dPOTEvUkNGR1RFQmUreDNBT2xXTEIyc21hazJMb0Zub0R2R3hC?=
 =?utf-8?B?RjErSmgvTGJDcFFCR3pxbkVjbXUvbXNFWmFvSTRLVmJFeUFHclNvd3N5SEVB?=
 =?utf-8?Q?VkUk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS5PR10MB997728.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SSs0NWd0NlZKNVREMi9QZHluL0ZQeHpQUHJIcklIM2FvWUFQVmJvYzBkWUNW?=
 =?utf-8?B?M3M0UTd6SG9qWDVrTnJCUGUrakRPN3RlbUhpOVUybzRodTBKMmlkeW5DcVgz?=
 =?utf-8?B?OVJpWWRtTmRSbjdyck11dnRNYjMzcWVvMUNMWE11WThvRXFMWFVTZ1hHMFZK?=
 =?utf-8?B?QmF2b1dTaDNEUS9vMmhEcFd2c0pjaTEvUVpPTG1SSDhhc25DakltazNiQjkz?=
 =?utf-8?B?eEcrb1JaRjJ5VUtYUFdqaG1kTFRyM0dQMXc2YzJIdzRwMzlDUEhGeXlxb0Zt?=
 =?utf-8?B?OHJ3K0l2dW5YemVpa2FheU9ZWFE1NW1UUFBiTzZMRWRDUDBicnZHdWlDQmNt?=
 =?utf-8?B?cW41WkNkakpyZlRRMjY1RzBOMFE3MnJQRlpVemR1d1dkN3A2NkVWZEJEVmVE?=
 =?utf-8?B?NFJFeGtCZVhYSGxyZzRQWm0vQ1g3SkVLQ2psYmlKeTc1ZjZGN1lrSlUzN2ZG?=
 =?utf-8?B?S29TWFlpTGh4RHZVYzA3TEV1SU1hbGkyWjdWVjJqOGo3cDdrMlpwUzBLTTZk?=
 =?utf-8?B?Y1RocW1qaXYvYjZxbmN6Y0dQTmkzRXZRV0FHWW5iWEhvNkF3MWdaVFFBRVBE?=
 =?utf-8?B?eGEzaVVRaHNBbUZGcWZ3TVYrM0ZYeXRpM1Y2UmhoekJkK0o2UFZ0a1NwNlBS?=
 =?utf-8?B?TUZndlF3eUN3dUtJWkNNZ1lPVTIyTDNONXpDU1BjUkEzMDcyRDVyc1VlZGor?=
 =?utf-8?B?ZzR0dmd5LytMKzYrYXJzMnRlNitUSGNTSEhBYW9xdzFTQ09XUm5INFZSc0w4?=
 =?utf-8?B?TXZEOUhUMDJ4MmlzL3JaRlhFZ3FQR2wxSXFyZ09yZDdWRDJaYkYyRFlQMkRn?=
 =?utf-8?B?dXcycEZZVHRNRW1ESjA2RExvWTR5eWcweDdPQlIwOHlzQXVYcXZEOFc1c0Q0?=
 =?utf-8?B?M1YwRi9Fb2xrMGthWkZvVnhCZm45TUEzeW5oRTJlVlFHZFd5RWhQRkd1Z2Rl?=
 =?utf-8?B?a3N6S29NMm9HN2paeEVWNUNGeS9HUVlNZ0h5Y3B6Z2dMR2ZFTTBOd2RFYzV4?=
 =?utf-8?B?UkRJa256QzUwcExpQndGMGVaZ054SEFpRlRtaFA5WnNSQ3UzMFlhV0ZZM0hZ?=
 =?utf-8?B?ancxeDFpaDRRT1hZaU5QaFc5ZDkwZDQrYUpnamlmUGdKQUE3ZGsxWEhpa3I4?=
 =?utf-8?B?MURkKzVQbVJXVFJ2a1ZjZjJpeFZ5ZkxVd3N6WWtjVWM0REgyU1VCamU2MVR2?=
 =?utf-8?B?ZFZpQU40NXExMXg1WUUrQ2t1UDJpd0Q5NWs2alZaaU1vL2lZL2JCZzhma1hT?=
 =?utf-8?B?Y3ZsSkwzaVRIVGtzVEdxTGRiT3AraUR3eURLeGNmK2N3K3JtK09zMFNtdGY1?=
 =?utf-8?B?d20remJXMHVRcXNjVUc2VWRVMloxSTBFWFhhNXNERnEvU1pFUExRRkh1bzhZ?=
 =?utf-8?B?VlJuK3JGS05VaU5BS1NhN213U05DSUxiM1NwcEo0WkdnYUJHZC9YRzJrZUVO?=
 =?utf-8?B?TjRndTF5ZUpIN3dQZ3FkdkN4bWZPTDRjcUp6TVQxVTZMMGM3bEU2bFRlSXBh?=
 =?utf-8?B?Zi9YYnFWRU1ha1g3OS8yTEJiY2xUenFhdjZ2UUFqdmVISVA5WkNCUU5takNN?=
 =?utf-8?B?dUtnYmdVUGV1NXVKbHc2M05HalZJT0kwc1g0emtCaGVZTElRTW5pQVlSV25h?=
 =?utf-8?B?cmdibTRQS1RYMkJXbWljckg2QldkVS9pUGZHV0t3SXJCK2FEZ2I1aWo2VWZs?=
 =?utf-8?B?enJybnhQZnZDeXhqVjF5YmVybFVLS283WlZJNEsxaUx2b1NaWmVXSzhNYjZa?=
 =?utf-8?B?OGQ2Y2xjM0dQLy9aQVhWeFFSVWM2UDlWMlpJSGFHZ1YvODRpQzczdExRRHVJ?=
 =?utf-8?B?clpxVnphMFlmdzBpQVQ3dTRFczJIUzNaTmpHWXdRMU5MM1JQTktiVXFuTi9R?=
 =?utf-8?B?QkJwb25uVFUraldOUVdPVHBsWmw2TUJQMlY2Uk1BV2xGV2Jld09wRzYxZXBL?=
 =?utf-8?B?c3M0UndnWmNHeG5SajZGWkhLMWlPRnEvWnlVTjZ1clR6RUxsR1ovM1l4V2l5?=
 =?utf-8?B?Qk1FVDIvbVBxT3RmeXd4aDEwMmhVOThKWnVpQUhrVkVGcTBKMG9jQzdVZ1Zs?=
 =?utf-8?B?SlJWWlFYRG56eFNoajhmcUwyUXZNNnRmK0E0TkZZRXZpTnFncmJldzlLbDRU?=
 =?utf-8?B?V2V2R3RRdnhncG9QemNOb21KR2QyWmVYK3VqTlpLQWRRRGx4eXMyYzJnRDRW?=
 =?utf-8?B?VlRRNFEraFl3NEpuc3JXZmNpeElYOGRDUzNYWlk0R0g4UFlITTBnSXFxc0NT?=
 =?utf-8?B?Sk5FTE54QzdBTDhGbDRhNlBDalljVTVUSTRSY3BoSGMzZDhxWFU0R2hPd2Fx?=
 =?utf-8?B?SUNSV1FvN25NRm1QMUJ4RisxdjJBUUZtdlNRWHdEWDRLYjF6Tms2K0hTeGli?=
 =?utf-8?Q?JFR1BlGfy9hh6X5c=3D?=
X-OriginatorOrg: Emerson.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a110fdf7-7647-4520-2688-08de6e6e3da3
X-MS-Exchange-CrossTenant-AuthSource: DS5PR10MB997728.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 21:48:09.3708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb06985d-06ca-4a17-81da-629ab99f6505
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HSBBs8PQOn1c7YyjXJUOWnAxfloOo3bnWTrQDrkTgIWdoqUIyzCJWQku/tFdKOiQ5reUsFoxW1rcqNg3FdmNUjqXtTk1yhpXtZz0oizmRPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6164
X-Proofpoint-GUID: bC34kZRxFswTQy2HqurkiD57Ktuh-1O0
X-Authority-Analysis: v=2.4 cv=TbmbdBQh c=1 sm=1 tr=0 ts=6994e21c cx=c_pps a=bMPlUhRHxnpMMWJsejB1Eg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=ZPWZ4rD8_x8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Ps6gwBxKFAOpZu8f3VnT:22 a=YzFfMDytZQSzZALhj0jU:22 a=0OM-fblktJyitGNSXagA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: bC34kZRxFswTQy2HqurkiD57Ktuh-1O0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE3OSBTYWx0ZWRfX6aiQFJScvulg P3KTPhKtwgkWVW/17iDWloeOmVHGdE8DYY4f0DBmwRiXI5NgiV1y6zk85MH9+5h7o69snhP99rP 8LHOgXSQwcHGtVIKf7GGqVquVcPsOg/YJAglntuqoDgbC7/s+QvwBbEeub/LT+umxRh9w4/4INA
 cC0Oc1xzrUaUpWOs234nyQRNfxmkcJ5DF+1DY2mOmBsnjU/v0hMMUctFv6fy+IaWhcPaBg7jjBY Am/0sokhczOchznCrboYpz+eiMDjbM4TvK8PPHNrnQP//2VGILv8Yz6Fg1B9/O29mDtwKjo1+wZ 923iSuNH3hIjq52Udg4HNFdeTniXn3/MYATMukcjoO/XKN994KdcOBOlB+3mG/jOhEXllXUOUVv
 KPF/5Fccv86h2VsxaQ6QlFT4M+snMAB1WSRpjC70niQ2EZLkCPtJoHoAx3IEkc7w1mHyMQYxLBP MKi/MmFmzclZF8LZFvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1011
 spamscore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2602130000
 definitions=main-2602170179

> Replace kzalloc() with the preferred kzalloc_obj() helper
> to address a checkpatch warning.
> 
> Signed-off-by: Pete Connor <pete.connor@pythcoiner.dev>
> ---
>  drivers/tty/serial/8250/8250_ni.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_ni.c b/drivers/tty/serial/8250/8250_ni.c
> index cb5b42b3609c..3f3dac694e20 100644
> --- a/drivers/tty/serial/8250/8250_ni.c
> +++ b/drivers/tty/serial/8250/8250_ni.c
> @@ -285,7 +285,7 @@ static int ni16550_probe(struct platform_device *pdev)
>  	bool rs232_property;
>  	int ret;
>  
> -	uart = kzalloc(sizeof(*uart), GFP_KERNEL);
> +	uart = kzalloc_obj(*uart, GFP_KERNEL);

tty-next doesn't yet have the commit that defines kzalloc_obj so this
fails to build. Will have to wait until tty-next has kzalloc_obj.

>  	if (!uart)
>  		return -ENOMEM;

Regards,
Chaitanya

