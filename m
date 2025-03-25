Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2136.outbound.protection.outlook.com [40.107.21.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979DA2030A;
	Tue, 25 Mar 2025 14:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913933; cv=fail; b=HTNGnXRRBHL6oN5n8wwb3U/kSPrrIUHf8rfFbXBBW6RUZLwwU7h+pLqrvKHawsn5Ien+cfRhjWdOMPleVdNm6PrSH/DJFov7mYGtNmqKlV3KWVkSKgxdofP3qAEV0MUtW6VGwBbk6Wt+PP8pZeBZdhWOclLqn2l8zPhw2+XITTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913933; c=relaxed/simple;
	bh=Cx3hvuJAHrm0zWkP1xNCI9gygSdKci0GcXTmM+qqHSM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fS0Jcst5t5C9MiPVqov7T3gFR/onV/vnDIxkLO+IEjYQmg7grrPAPMXCjz4AMpn+YmNR8F3bi1np4pcntPugRge45YibCfl8ss7Fvj0QZePUFl22L0UZ3+GqqP+ptOKNbxQHXZR+s8IfhvOPXjg/vEiNmIBqckdKwdKoCoFIcC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=KYtKQcJj; arc=fail smtp.client-ip=40.107.21.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="KYtKQcJj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TY+w92ni35fo89H0p5ifW8XfoKmB4CYZVIsyYK9Pr2OP4As+5jSLa55wjq8E/aFflHuJ0MQslnuy5LtL0aZadHjHgbLjoLVtX8HGWS1rTFZDdVotZsmphCXUSSEIUv/lZqb0QycUDoLjY7pC2ZnAkmidTTFCnOYPSl0MYEgwBjlhTgq3uSKele7KuoQSuj66rQyE9sjm2CEaFB6l+fneivR+B9XAU0l7AwTEtc1Hmssv/0Vl5fRjMd6EFcqLRQkWgwC9gaxmhjfLYRNEmrL2sAA0uq8dkdNG/IHtuFsuMp6ZlR0PNlQA4hlohJ+Ik47+qJa1xubDvhinS5Jq4E+yjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHTbyIWhYaAoAqK2eUyzeOcUR8AB6xE1bs7QiT7HUS0=;
 b=LLJ4BM/fFeu7kc2xwEyMP9/stMvLH3tUgsZyc2U3zFvvefWcsYsCLK4PjHZn/HvrHXHnGQTF84z+Bd5HJ6gFwf/vwTRQKiOHVwOQffP3hQL/RvbhhJi3+ROsg9sPsge4Lggj7afjgYXKFZmJGozr12SVMA/40G20m9yZUM7GTrb4N6e6L19x32CiXmYuKGoQlPT96O/wVlFrWqOo/ZKT/e60i3rCa17vL22/xMyugpxQHfdznPxGnbLXQECTSpOXBquyiAJoe/mc6u/I/sGGWfEsgMasPtZ0Al6N0EnNqrzNi5jJo4i8JsyFJsmFONcxndT5aERmDSrkW/KZfS2yMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fHTbyIWhYaAoAqK2eUyzeOcUR8AB6xE1bs7QiT7HUS0=;
 b=KYtKQcJj55I51pvgVODfFErAQx0Y2mZGX198zLXm+DaqFQl8jBwDdElC7E0JaKCAKBKrTRiZeXPr55nM+RgER6V3/ZvZ6TjoJ9VUorKSsyJsGim0w69MNgkQJ9Vgmpeiht3X4oMPTW8Qsn1otKwSzF6bTThE1wlFB7YYAtt1SIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 by AS2PR08MB9918.eurprd08.prod.outlook.com (2603:10a6:20b:544::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 14:45:24 +0000
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42]) by AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42%4]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 14:45:24 +0000
Message-ID: <75df16f4-3413-414b-b71c-ed64d4ad7b0c@genexis.eu>
Date: Tue, 25 Mar 2025 15:45:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Airoha UART support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, ansuelsmth@gmail.com, lorenzo@kernel.org
References: <20250209210241.2622309-1-benjamin.larsson@genexis.eu>
 <2025021019-overtake-elk-e644@gregkh>
 <28a3cbc9-53fb-44e3-bc87-d33cbc406c8e@genexis.eu>
 <Z98veiHLkQWlCdBE@surfacebook.localdomain>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <Z98veiHLkQWlCdBE@surfacebook.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0093.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::7) To AM6PR08MB4215.eurprd08.prod.outlook.com
 (2603:10a6:20b:90::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:EE_|AS2PR08MB9918:EE_
X-MS-Office365-Filtering-Correlation-Id: d0499ddd-a7c6-4894-f5a2-08dd6babacd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHYza3hkTm1mOFZSdjZuaDZmNnM1V2ZQWDkydWtLRWFmRlQ1SDVrWHpuK2Fj?=
 =?utf-8?B?R204MlNNVDRkdHZBRytHbmxFWlF0eWFjS1A2UHFJRVpreXZ1QjRHQkVqZ0dY?=
 =?utf-8?B?N3ZlSlpsOGJjaDNqNnI2cUdZdGtJaTFSTVNnWWg2S0VZN3ZxZkdiSXdpSHBz?=
 =?utf-8?B?VVlUZmVQZFFyd1l3U2pUaWRkQXZiK0hEeHo2QnAzRmFVQllMZE9kaFh0cDlE?=
 =?utf-8?B?QnVsWTNDZjVTNWg3V2hmaFRDOENPbDExUHRlczR4SHVxYjExUU91YjNjZlhz?=
 =?utf-8?B?VFYrUWx1L2FBWW93cUhXckpLaGJKU3NFMUN2RDc1T3NCMkVUS2RySE1zMDhV?=
 =?utf-8?B?eWdQTVFBaWZ1SklYSi9oU1g3TWtSNTJJNWhuQldVR0ZHdlF5dzNSbTc5UFBl?=
 =?utf-8?B?WUh1WUxYUXlhNWFlSHNBMkVJS0FSZSthMlFES0RXZmxMd2x6SENoa0pudHJG?=
 =?utf-8?B?K1gyKzBYSkZybm5qVmdlQk5QRkszOU14Q2pJaFQ4UjBaYXJmNml0K0Q0OWQz?=
 =?utf-8?B?dEpxMGVqb1pGMEdDVnI1dXRQejZYcDBsclVzTnhUQU1ETWZDTG5kemhMdy83?=
 =?utf-8?B?ME8vZnJldk1pbE5GWUhScUdabjhuME1wVzI5dzFyTk1NUTBPeVNsOS9vUUNR?=
 =?utf-8?B?UTVDYzEwUjRVaEFEaGZzSDE2OUFNZ1VoZWx1SlpFdWRyRUQyaEhZL1hKT1d2?=
 =?utf-8?B?Q0ViS2tES3VFOWJEWS9XbkJETmw3d05YdHM0dEF6OTFFTjJEU1ZtWkdvc0V4?=
 =?utf-8?B?OVBNMkpEMjIvZTBDY201Y3FsZmV2OVRzY2c3UXh2ZXNVU1M1anpFVThUeWVW?=
 =?utf-8?B?ZmZJRmlWWDhvOHV5d0hyZjJ0Z1VrbHpBaXdqS1l6M1FJQkR6SXQ3Mmt2cGwv?=
 =?utf-8?B?OHBLTDRQQ1Q3RXdWeW02NngzTTFZb0JVL3lWbkkzR3hWQUJEL25GNVArSWJP?=
 =?utf-8?B?cmRiZEJmTW5lMFROQlN0bGJxM0k1MnlpMHloeTF0dEFLdGt4RjgzZG41YTlT?=
 =?utf-8?B?bkpIMzBZWmZVYXdZQ3FqNEtYT3E1VGVMOTdPZWFIZmRrQ040eUhrckM4U0h5?=
 =?utf-8?B?bkw2TUdMR0diaFJleEk4NE14TURJb0FHU1ZRNlFVb2tVZEx5RlJUQzB0eW1J?=
 =?utf-8?B?MEZ4czhiTkZvL1pla1FOcTFCd211OGVVV2lUSm11eUlLQVllUGhQaWQrcFMx?=
 =?utf-8?B?R0wzeVRFc1NBY2FWcGN2TldDNEtVMFF1dG9wck5oTGF6ZEJzSTN5UWUzVDdE?=
 =?utf-8?B?Q1FJYnBsZVNyQlZENi9TUjcwbVN3VWFPVVFKZHd5aGFnekdSdWxqWnFxMy9M?=
 =?utf-8?B?M01EelV4eXYyV0lvV3NPQTVnYUJPcG5oSGtSaGlJTGpVNTluZjhTQkdTUUx4?=
 =?utf-8?B?ZDBWUUt4QUU5SXlMNHRjUk9UZ1Rwc1o4U3RxM2xxc0lHcDc1RzU1SDd2VHYy?=
 =?utf-8?B?eUUvMzJHNTVHSWFBc0IxVG1ib0hKY0NBMm5oRU1KbVQzQkwzcFB0Uk5YdmJG?=
 =?utf-8?B?ZXRLaytockNkdVBFZ1B1Zm5SSWw5Z2JnclRvNDMvU3FmUDdkWUNzZlU0OGlN?=
 =?utf-8?B?R3BpamVRRzROQXNhMDBmZ3ppYWI0dy9ybzAxSG1EWEQzOXBQT01od1JXdVpN?=
 =?utf-8?B?eExnRCtkTHpmTFVYWEtITURLVGFXSFdsaC80a3NPRldhNUNSWkZqWFJreVV4?=
 =?utf-8?B?NHlsaTZ2N3dWd3Vnem5uL0s5NnBkVXJJSENyd0RKVEd1cnZMOHJVRnRmKzlP?=
 =?utf-8?B?ektUVVBDc0sya3N0aXcyNDNibE0xdVR3L3g1dGE3aXBTTzV0Z2hFN29HZWcx?=
 =?utf-8?B?THJva21tREVVT2tZUDBDQzZqVS9ISTFVRHo4WWgycjJ2UWcyU1lCMmxwREww?=
 =?utf-8?Q?nAIw3MsovG5e7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4215.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K2Q1YUN2S1pSVlFhV3RTaEZ3MklTa3BDZW9ua3k5KzMyRFMxOVQxcmVTN2RU?=
 =?utf-8?B?N09CMUhlUm45bVlZeGZvdW0zckhSdDNFSGF3Y1YrYVZUV1MzRmNrelNTNFE0?=
 =?utf-8?B?Qjk1UWVVQTNROWsySVd5VGxiQk9neVBTYVFrY1owZUV1eE8vKy9WN3l4VWtp?=
 =?utf-8?B?M05nU2cvWEFjL3p4dHFtUUlKNERUYlVUOVhnT2F3NDRQWm1kOUxOT3g0SGk5?=
 =?utf-8?B?VFR3WHFpbEJUY2QxOCtXd3lrSlJtejJHR1ZLTjIyVjdjem1OOVgyak1Ud0ww?=
 =?utf-8?B?dTU4Um5LK08zZUM5bzVWanc3TVRRMjd6bDJJQlBVYVZqamdxNWpwdFBjTGNN?=
 =?utf-8?B?UjUzK2VwT1RDZFl0RExSTVBwREYzVWdtOFhXd09lamV1S0J6RWR3MGhHam15?=
 =?utf-8?B?UFlhaVJIczBmU0hRcDJCSDNPRXBBcTNWR2pEVEdNTENiSGltMkpGdjUzT0w5?=
 =?utf-8?B?WjMwY0ZQMnZKc3ozYzNKSDRnOEllU3M2K09rNGNoNTQ2MXFjNm1sZ1JUQVdt?=
 =?utf-8?B?ZWpvT3FvdW1yZ1Nzd045NGRZVGRlcHNJekhTV1JYNWZuZ3dWMi84dWtOQjdh?=
 =?utf-8?B?UEloTWNtSS94QzBxTjYwTzJLOUhsc3FRSHVhVDdrQVNNUG1aVXdpalFDd05P?=
 =?utf-8?B?WjJVUmRpbXkrMHBBY290WEY0Vi9RNGtRT216S0hCVHNSemJNaVU4em5OejBt?=
 =?utf-8?B?MERXMm9nY0J5WkN5MjdUbk9XV3gzVnh0YWdTTWVESjZKWE10SEhRbllyTlor?=
 =?utf-8?B?VmUyb0xmMVpwd1lHSjhPOGVPWkZBQi9VZXJBdlQzcm1kRGdmY090VTRybENk?=
 =?utf-8?B?S1lXZHNDT2pVYmpXYlpxZVNUY2FtdnkwS3NYRTd3VFptMzZsYVFMRVpkM2Ey?=
 =?utf-8?B?TkpKb2prZGIzaHlaVGZFT2VLUTB4Z0tvODhUSU1pOHVGL3VGZnYzRFRFblA0?=
 =?utf-8?B?VzBKdXVxUHE2dnpqSDgwTlVkV1BYVG1SRGl1WjBxMnVVSUUrcy9aUzg4UkdC?=
 =?utf-8?B?b1FVelFtRmt4b3FYWThiTVRjVEZKT1lEZXVuazIxTW8yYy92YUxVZk8xR3o3?=
 =?utf-8?B?ODI3RGRiZjMwY2ZVMGxNTVdpY0Q3U1NPbFQyUFdEZFVIbm1yZW5mVU9JU1Zv?=
 =?utf-8?B?SlQ5TFlnRjFaQkgrY2piVzFXY01qWFVEM2tuOTFWUVoxT1R1b2VSTFBHclpZ?=
 =?utf-8?B?UXpGVE5qSnBGWEg4cHZuWUlGendVbDlDME5Ua1NQVDNMeU5HeW85OUszbEYx?=
 =?utf-8?B?dktnZEx0aEVIT3hSU1ZDbGM1UlpPS0dvV3l0WkZtWTIyYU4xbzVKRzZYdEcz?=
 =?utf-8?B?bzVCNU9TaldWODdhcXFCTkVUN1BZV0ZiUjJ3aFlSTG81M3FrVFNVVmo0dU84?=
 =?utf-8?B?a2lHMmRYTWpERDNQcGYvTTNRTEx4MWRmUGJHdU01QUJ0VjM5WC9NSFhrc3BI?=
 =?utf-8?B?ZnZVUkpic241bENNMzNQbllMWENQNUhqTkR2Z3QzRUFEZzhFT2hzczdSaXhl?=
 =?utf-8?B?QjJpOEx6V0NpQ2oxSkVhN3VZNkhMRzIxbmJ5UlEwUlVEa2JFRGhKZnpJTW8y?=
 =?utf-8?B?dlJmd0NjMXg3Rm1RUkNlUEY3TEpYWHBNc25tZXJsbFpMaUJzQmFmQmFLYnhJ?=
 =?utf-8?B?WTBtT0daTm0wYmlkSm9iVFF0MWthMXRLVDByY1RuZXB0ck05RTMrUk4yYWM5?=
 =?utf-8?B?WkJHaUlnL1hHZXdjbUtiT1p6bFM4Mm04dlNvYzg1MTYvQVlGaTArQWpLVGlD?=
 =?utf-8?B?WVgxQTdIeCt5ZWNWVGN3M3lScDd6cXhoZFpEUVhhTHlVeGFuNGRnak9zbE1G?=
 =?utf-8?B?a3ZUYlpBa0tkOFAvcFNBWURsZlkyalhzZFpkeW5oZit2NW1sN21Ddko4V25j?=
 =?utf-8?B?bkFONWxsaG5Uc1ZIdWhaTVVvWHVCS1lpYlh0b1I2Wi8zeEYxTHpwM1lhRXU2?=
 =?utf-8?B?MUxibTRhQ0NNTlN4RUIwZE4xZ1pBUFJhb0hkZFRESlRtbXZ5ZUxTTXBwQno1?=
 =?utf-8?B?ZjBIRnA5NVRVWmR3V1ZhKzEvTHFtbkhoVEVxZnlRb1J1T3YzQjRCanhWV1NH?=
 =?utf-8?B?STJ5SHZRMEhhZStpSHppbFdwWWJJazFtd1M3bzRXbFUwUmIrTHFMaHJyNDR1?=
 =?utf-8?B?dWxkZnZ6aWllc2ZST2E5WkJ1eDBCb25PZmV0d2ZXaitlbkpVa1hoNEh5eURZ?=
 =?utf-8?B?cUtMcUpkUExwWHFEK2ZSSWFjRXlKRjBKcG5RRHEvYjQ3V2dNQXRYSVlpKytQ?=
 =?utf-8?B?WGZvUWxSRHA4ZndsU0NoWDZHS2tBPT0=?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d0499ddd-a7c6-4894-f5a2-08dd6babacd1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4215.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:45:24.0703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/ER7lwMfnLmkeTJ+sJVKlT1S2z+B3gZp8w4yILVUsfRjONBblag8rwjbuJc57M2V5ebLxdGlvleZvKXUJs5pULgn9NpRRamfTYECeI0j7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9918

On 2025-03-22 22:45, Andy Shevchenko wrote:
> [You don't often get email from andy.shevchenko@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Fri, Mar 21, 2025 at 09:37:09PM +0100, Benjamin Larsson kirjoitti:
>> On 10/02/2025 07:14, Greg KH wrote:
>>> On Sun, Feb 09, 2025 at 10:02:39PM +0100, Benjamin Larsson wrote:
> ...
>
>> I would argue that I follow the current flow of the code. In 8250.h we have:
>>
>> CONFIG_SERIAL_8250_PNP
>> CONFIG_SERIAL_8250_RSA
> These are historically parts of the main driver, RSA code theoretically
> can be removed.
>
>> CONFIG_SERIAL_8250_FINTEK
> I would love to see this being not part of main driver.
>
>> none of those enables COMPILE_TEST or the option to compile as a module.
> They all together may be compiled as a main driver module.
> Again, this is all historical and new code would need a very good justification
> why it can be held in a separate module.

Hmm, ok I'll see if I understand you. I should create 8250_airoha.c by 
using 8250_fsl.c as a template. Adapt probe for Airoha by replacing 
.set_termios with a wrapper that calls the custom baud rate calculation 
code?

>
>> Neither the Airoha code or the other code is not intended to be its own
>> separate module,
> Why not?

Well I mean that was my intent.


>
>>   it is to be part of the 8250-driver. The 8250-driver can be
>> loaded as a module with or without the Airoha baud rate code.
>>
>> Implementing COMPILE_TEST when the 8250-driver does not support it seems
>> tricky. All the ways I could think of would result in messy code and logic.
>> I came to the conclusion that a smaller patch that reuses the current logic
>> was preferable. If that argument is not good enough then I need some
>> guidance how to implement something what would be accepted.
> --
> With Best Regards,
> Andy Shevchenko
>
>
MvH

Benjamin Larsson

