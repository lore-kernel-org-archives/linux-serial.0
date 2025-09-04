Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020118.outbound.protection.outlook.com [52.101.69.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191124F5E0;
	Thu,  4 Sep 2025 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756986628; cv=fail; b=RBKTDukaFR2WSBPGL/b4QE1qv7xcya8OAB5YSimdCWvheRiI4xXZZorLeimnYId3qMWNZs/Yz5rRsegRP6uoT9ZcL4d4ASud4rh9EZOrW/g1VHfOjbA4YatIj6DeExgfRndvgCKr1W4kN8nBlAGfOrighnqA/0N2BVf1rPCrHOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756986628; c=relaxed/simple;
	bh=m9ugOWve8xJs7Cxb2aY96OMIHju87Mw25K98BBHrA5g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TSCdlBHxi7b5nDixmrZVm7cuyiO020saDGZ6meNtKKIP+8Ux4KtAr9qG56GABJXm8yu3j1shx6wvQmGNJyo78w3Rabv1sx+H6bg5pbu0wgZFcyyUFr/rNZ79LGR2MYfovPT8o7TVvs4x88KxZsZ6rcn/01cWqNtllJuUzdU+rZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=OeB6NAF3; arc=fail smtp.client-ip=52.101.69.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="OeB6NAF3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDKzrCEw5MSa/CzkEmm4FvPUKKhdHmDMQ8Jq+7psuhUQSnf5TWdbZvpG7jvC1nRxEond6xnB6Hnb3h8dyuR0P4pNbFX2uWiPP+2+0J9EMR839rP2Q+HKS11gCQwA+a7jQAcUSywE0UP4uECml0XlefC+OtuWsVdie2ThtyjWrDIM9zjpvzO2+n5pGFx4YUtrZSdcgAEtRxpVxpc+qjtCUuMMlcJ68McNadJrVA7rT51JhD4sUyiCrdv1PnIoYQM7+kH7jp+fX0RYiyBiZ/HyLf7TFzxgKAPboVa6wsXCNgrv/u9Cdmh70Lo9R7UjqIslnCqlhjeaHqIrjwWFR1/KxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vziuSDtYi7BnGoNmZEzsVrsra7b4cyYaSW62AC8QrfI=;
 b=hdRGWkOpF/vXERKmWw4xS/VK/n/N68qF6660qW5sJRjRovsy0bqiKzo5bR0/N7LJJT/SIrrvN5FZjsKc7GqhEtd7P7po7a6klgjgiPmK59XJKm+npO2ogyEkIFeQ/KVN/WouANqjrqgqV03IUfyBUrsJz1OykXDz8mRmKSpvIJOfqpsk01umU68UjlyJPJ9nnwSgFamjh9lvGavI3maYyO11HA7513xKU034ZoVvI583jera25yT7CreRluyjY2QaJ3CfOZLomZsDawJi6AnEBbGUt5HDzlBMdr2/En4aw1Jwdj6YR94W3YeG7/eMze5W3iDJuS49gkiCBWC1yCrsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vziuSDtYi7BnGoNmZEzsVrsra7b4cyYaSW62AC8QrfI=;
 b=OeB6NAF3ml8LO+BVi/jYA2cc4iFPWfKpRmpQsNTQ7boaWBfCW6w1A9PQW7R0rDqe9ifWI3Q0UEbAD9prenR2TzL7U1x1Gxawdy9VrAluynNE1n9MpP5UdUnnfd3UGXpV/WTgmiHaMaYHCw1fm7yP0B23+4kOzzExpjkmatxW5Quzkaj9o4ukIUzIIoMDQ5pLQhH8hX7+qN744DFtrG93LPIgWrfHiV6JumPdqZDSbXU/f3bj8B89pXMNA+W48EBF71+h+/s0UUSlY0itHYtoveeYpHsciZ6Me4UZUYDBgc0JmXepEd0Dkvzzv2wJX6yH/GKBzq8G4xouuWK9E9tu5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by DB9PR06MB7642.eurprd06.prod.outlook.com (2603:10a6:10:256::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 11:50:19 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::f8cf:8122:6cad:4cf7]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::f8cf:8122:6cad:4cf7%5]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 11:50:18 +0000
Message-ID: <e88f3c74-2ea0-4266-b5f7-62b87a1987c5@vaisala.com>
Date: Thu, 4 Sep 2025 14:50:16 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: max310x: improve interrupt handling
To: Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Shiyan <shc_work@mail.ru>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20250903-master-max310x-improve-interrupt-handling-v1-1-bfb44829e760@vaisala.com>
 <214edb7a-2631-4f7f-9516-a38a3796cc0b@kernel.org>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <214edb7a-2631-4f7f-9516-a38a3796cc0b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GVZP280CA0006.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::12) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|DB9PR06MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a621e55-09b1-4b1d-2473-08ddeba93843
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3JHRTlyb1pzN0pqbW5mUDJrYnU1ajA4WXQ5cFV0Q0V0REtseVdKQUNicTU0?=
 =?utf-8?B?cFJOTEpkdFE4R2l4eVVCbXlwNkRkRFgxR0RlOEtkNE1QQVVWemwrR1U3ZkxD?=
 =?utf-8?B?aThhMmFsakFHTUNkdmJNZXNIaFMxcW5rcHUvYko2ek13dFU1YWNYY1RJWjBl?=
 =?utf-8?B?UlhSRHlodFlhUmVWOFFYZjFoZitCbUx5RnlYYUxIRWFudiswbHRSemxPMERM?=
 =?utf-8?B?eGFDYmFNUlpBWUpHL1pQdXVDc3ZQUlhncUJpQWx5bThyTFFZaWpxeVBIaWR5?=
 =?utf-8?B?NmJGM25MLzlwTWRSVXdZdGsvL1JxSkZUYU4vRFhMTGpzcnVieDhkTVE2NWI4?=
 =?utf-8?B?Zk1IR3FyV1VUNncxMkVhbjV0MDEvTVAyYmloNENjUmdnQWxrc0VrL1VuVVlo?=
 =?utf-8?B?RlJNNTNTS2tFaXdaZ3lidW0wbTdvRTk1aXRabU1leXRkYkJCNlNsS3hiaUtq?=
 =?utf-8?B?MEwvSytKOTE3ejI2VUgwN0VwVjl6SU01TDNPakpjTlF5NFlmWVI1dFBpdUQx?=
 =?utf-8?B?allEWnJuaTYxUXMyakFiUk9qY3Y5WjZ4MFdKV3JNK3dlZm9aRUcrdlJRNm9B?=
 =?utf-8?B?dTY4V2crNko4TTY1eWREdit6bTNUWUV2cHBUajZyZ3VuS3NuN01iN2oxNkZL?=
 =?utf-8?B?b2JOTkxCN3ZPZmx0RndwSlJJU2dhNnJSU3Y4NVNINnlmdlVORzlwKzlMQjVG?=
 =?utf-8?B?em9BQmdNdGdLeGV2WnIwajJJU1YvQ1Y1ak5RdXJEODVjM0ZmRmNBV1ZDMlZG?=
 =?utf-8?B?aVp5S0VPYlBkOGtRZGU5YmtQQk5yRW1Yb0VwdTNBWHdjdTEzTUx2WlBUTUVh?=
 =?utf-8?B?MytiTVhrSEFIV0VJUzcvZWRnTmt1c05ncHF2RzF2cmhQQ1ZTdWs1Ty9UQjMw?=
 =?utf-8?B?c290YmRsSmJxczJGRXM1dFpZcGtLMElBTjlnUzhnNmJHak9TYm4ralVhMWZt?=
 =?utf-8?B?eGxXUTlaTXZWZDY3OUxFTmZtSkgrRDNKN0E3elQvSXJHTithR2R4enNKemIr?=
 =?utf-8?B?ZU5Ic25UTnVXWXpVbFNBS0hmYnNFNFNUVUNza1FrQWs2NDVOUlBEckdLZEc5?=
 =?utf-8?B?R1gvcVgrQlc0MmJxa2dLWlJCbXZLbEpCdUZJR3NZSlAxRlVtYXp6QXZDZXZl?=
 =?utf-8?B?ZStlZUk2NGlFQmNWVEIzUnlxWjBhM0diTUp3N0dUQ1Jud3dhaklBQnpkZUFV?=
 =?utf-8?B?TUdPQ1Q4UDJjTGNoVHY3UmlHT0xDSTYzcmhLZ25DdmNRZ3NML1luaVZrQ1Jm?=
 =?utf-8?B?WHozTWovV3BaRUpGblBoaERPZmhmRjZCRStrTG5OUFBTR0paMGcrck9qL2pk?=
 =?utf-8?B?ZGJYTGVHdXFmK3hETjVNT1JiNlJDZ05QQW1KajlXZ3hKVG5MZjArNXhwUVUz?=
 =?utf-8?B?akNHNU1LUHZsdnBPUkxYTFFpY3pjWktMRjJGdEVRZFh3TTJzR3BtNHJYZVZv?=
 =?utf-8?B?N0tnR21rU25STmFrZlAweWIrVHNDd0JwVFVJenhGTkZ1NjNGUzZNRUtRb21T?=
 =?utf-8?B?U09ZOUMvUlArQnVxNmJNNkFBbjU0U1FtMGpXa3ZDY25pRDlrc0g0a2VzU1J3?=
 =?utf-8?B?cTJ2bDU5RXFVVkV6NGpkUnIrWWY3Sm5TaHdpYVExaFlha2Jpb2tJV2Y2K0Nx?=
 =?utf-8?B?NDkzb0Zxcy83Ymx2R2l1Mll6UC83ZC9zL2J3T3FidGxmV3VNNlZWYXBPYy9w?=
 =?utf-8?B?TFlLVFNXT283OVl3MGhpb0lKT01oaUp6SjNXZ1V2OTl5K1ZmL0R0MzczdUla?=
 =?utf-8?B?Z3NzVE5mSEd5ZkE0aUZiQ053RjlWRTZDVTdhWTBXbVJKQ1MxMUtaNWozajgy?=
 =?utf-8?B?dXZyMStKa3NQckx3OFd6NTd5MWxZZVMyaHVTR1hhMEYzRlJPRmlCWHd1WTVw?=
 =?utf-8?B?SkZJL0ZOYzFIUnlVSDhwVDhmcC9lYkFNTEdCbGNpM0tTY2xjVVVRajhsam9P?=
 =?utf-8?Q?RhUImaz0Zhw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2RhMEFXUlNwejQ2TDV0SFZOZkwzRHFCUEN1ckMyVDgrZDZNbGxWbWJKRTRv?=
 =?utf-8?B?Si9sTXN3dnNHTjMvVm5UWnZ1amJSbjRtUHZJeWlmUHh6ZXpvZHpzZXZKQnk1?=
 =?utf-8?B?L2MvWVczSlVEOFNQUmk5bldtTk92aWRxczRtUEplOFBLMnRpalR3eE85bkx4?=
 =?utf-8?B?YU9zZUhmc0Fsb1pYSlAxNkNHZUFFSXp2L2J6cUxzUXo2M2N3dkZMTWNpNlJt?=
 =?utf-8?B?K1Q3Y0dxekRtci9wK0NieVE4MUx1ZTBpK2ViaHV2eEl6UGE1RytLUlYrZWt3?=
 =?utf-8?B?MFB3V2ZHNkFjUHQrMjhBV3dzdWdKVzNXa2ZXYmNpbHh5eGtZRWY5QkptYjlI?=
 =?utf-8?B?VWhLUEltTHZTZjZnSnBieDFoOXlEVk1WL0R2bEY4SWhNM0FxcHJ0WlVxUCtJ?=
 =?utf-8?B?L2JtVXBrWWpGVEhwU0FSemRsT2VuWUkwYWsrb09ob3RkNFo2dGhBUjlLbVdN?=
 =?utf-8?B?Y2QvUklEbjNsSnlKRW1zMElRM2ZCSWpzOVg4dkNVajBCTmRQWVVGb21BbitU?=
 =?utf-8?B?Kys2dCtQRGt0TW5LWXBqbUVEMzJtTkZzdGQzdE9IZTNTdHZicVhxR0k3dEl1?=
 =?utf-8?B?SXhoOHZybFRGTk9LbDA1THIyK1hESVR5QkUxdU5PR1o2NTVQemxENVdNcDV6?=
 =?utf-8?B?OC96KzVpdTR4S0dERTdCL25YckttbU0vSlRGa284c05TQ2d0dm1zOEV0MVYv?=
 =?utf-8?B?a3V1LzU3YVNXVUp1b1l1TkgydmEvNWRjM2ZlSWZGc0NHWWM0enlnaHBmWWRt?=
 =?utf-8?B?RHVHaUtieSs1Q3Bnem8zZjN4MTFsS0hxZklRY01xSG5PY0FJNng3ZGxBeHEz?=
 =?utf-8?B?WWR1aE0vbE9NNU5yNjlpOWJwdXNhZVN4V2ZpRCtNOW5YUzNVbmdtWFFXRGZB?=
 =?utf-8?B?WDc0d2MwUHRaaDFxd0J4MXNzdDJFaE56cmpYL3dwUHQ4ZVZDQXFRTU1PYnZq?=
 =?utf-8?B?aFRlS3B0akJ2WG13YzlxK1ZrTmJKaG9kSGtwSDc2aWhFajRLdm1UL0Y0Vk4x?=
 =?utf-8?B?T0ZLTDNYWXE1OHg3b25BREpxTnh2R3lHMnI2WHRWcC9Wc1pBZ09Sd2x4S3R5?=
 =?utf-8?B?TXIzTnNRTnlOUEtwV2NyNXdnVlZudUtBR2tZWDlocm1QWWdNZEkxeXJ2cExM?=
 =?utf-8?B?YmtmWWpreXdUTE03NmFlMzV1dVJLMElWdDZ1dm02UkRydzE0RFRUSzYxcHpH?=
 =?utf-8?B?c0JJYmNndjc5Yk1TU1NvSU9QL3RiZjU0R29nM1dDdjY5WVk5YkNLMkFJYVNH?=
 =?utf-8?B?djhsK3h4S1BpNlJwMjNxdXpoelRxQ28xRlJrVUNBY2Jnc1ZDdmhBT2tEZHIr?=
 =?utf-8?B?aGZvem5PTkZYMVExcUV6RFRId0MwNXExVVRLWHF6d0FINlhEbFE4RUhaRUM0?=
 =?utf-8?B?RDN2dk5lY0lGbVhEVWFLQ253dHZLOW1OclNKazlxZUErbXQ4Z3AyZVBNaElW?=
 =?utf-8?B?d1hjZ2gyVk04cEtUNEdwKzRWdzk1akk5RHVwQWs5V3pzVzdzeUJVcEh6ZUwy?=
 =?utf-8?B?ZXAxNzFHenE2bjlpUXM2VVhpdWRVUlhRQjROZFY1WnN6akZZWFVpZU9XSWVI?=
 =?utf-8?B?S3BEWlFJaU5pSzVhUm5vWVZmL0ZQOFZRaW93Rk5oSDVRWlllZXhaY0svZHlz?=
 =?utf-8?B?c1l3aVgrMEEwSUFlTWR3SERiSS8ySWxSeU15SnY2azRiNmQ5eEh5TDB2UDJP?=
 =?utf-8?B?blpTM3R0M1VBYlFLLzc0eVA1RHJMcGVSRW9hMnVrbXNwOW9XR3UzUFZhdVdQ?=
 =?utf-8?B?NS9xL2lRbW9IWnQ4SGFGZDdZdW9kOUtySi93NWtCaFhncVJDV3hDdFg0WW5w?=
 =?utf-8?B?bU9Oc1BCUkJ4VDBHc25tbHBKdTBpQVVGSWw1S0NTQWRLUU5acHVvckNHVS9J?=
 =?utf-8?B?NGVjc2c2S0l2cGZ1OVA3eVFhUkdPOCszd2RWZ0VkTTEyb2FiYTRBanN5VWVM?=
 =?utf-8?B?eTZGMTRHMXNSZzFsVzJKUXJoMHIzcUtqVk9ESWVsOFVPa3FnZ2VYZGpLSFZs?=
 =?utf-8?B?RmMzMEh5UjFlTytYdnlNVTdZQ2p0SlRrVUNYQ2xxTjZpeFRLUy9nVHhKYXFj?=
 =?utf-8?B?enJUQVpLbXVHVzAvVXE1aU9DelNRWWs5WmNGcEhTTHg1QmE3LzYwa3U5eGNG?=
 =?utf-8?B?Zzc4MEpEUUlyd0JrcUQ1eDd2eE1aQnVqTllhV09wSjFMQ2E4OWE2QVNraWtZ?=
 =?utf-8?B?cHc9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a621e55-09b1-4b1d-2473-08ddeba93843
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 11:50:18.4022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cE01dpQ2XJs1JBSxyqvGtLWo6NPe75c14JWjV9I/4fYIBusMRW5FUhUyHNKLDmwt9M4YNjqMuW5gBuWogk5TdFXbtqnaO6j4w1yO3rsBhXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7642

Hi,

On 9/4/25 10:53, Jiri Slaby wrote:
> On 03. 09. 25, 11:23, Tapio Reijonen wrote:
>> When there is a heavy load of receiving characters to all
>> four UART's, the warning 'Hardware RX FIFO overrun' is
>> sometimes detected.
>> The current implementation always service first UART3 until
>> no more interrupt and then service another UARTs.
>>
>> This commit improve interrupt service routine to handle all
>> interrupt sources, e.g. UARTs when a global IRQ is detected.
>>
>> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
>> ---
>>   drivers/tty/serial/max310x.c | 21 ++++++++++++++++-----
>>   1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
>> index 
>> ce260e9949c3c268e706b2615d6fc01adc21e49b..3234ed7c688ff423d25a007ed8b938b249ae0b82 100644
>> --- a/drivers/tty/serial/max310x.c
>> +++ b/drivers/tty/serial/max310x.c
>> @@ -824,15 +824,26 @@ static irqreturn_t max310x_ist(int irq, void 
>> *dev_id)
>>       if (s->devtype->nr > 1) {
>>           do {
>> -            unsigned int val = ~0;
>> +            unsigned int val;
>> +            unsigned int global_irq = ~0;
>> +            int port;
>>               WARN_ON_ONCE(regmap_read(s->regmap,
>> -                         MAX310X_GLOBALIRQ_REG, &val));
>> -            val = ((1 << s->devtype->nr) - 1) & ~val;
>> +                MAX310X_GLOBALIRQ_REG, &global_irq));
>> +
>> +            val = ((1 << s->devtype->nr) - 1) & ~global_irq;
> 
> This is horrid. Use GENMASK() (or BIT() below) instead. Likely, you want 
> a local var storing the mask (the first part before the &).
> 
val = GENMASK(s->devtype->nr - 1, 0) & ~global_irq;>>               if 
(!val)
>>                   break;
>> -            if (max310x_port_irq(s, fls(val) - 1) == IRQ_HANDLED)
>> -                handled = true;
>> +
>> +            do {
>> +                port = fls(val) - 1;
>> +                if (max310x_port_irq(s, port) == IRQ_HANDLED)
>> +                    handled = true;
>> +
>> +                global_irq |= 1 << port;
>> +                val = ((1 << s->devtype->nr) - 1) & ~global_irq;
>> +            } while (val);
> 
> Actually, does it have to be from the end? I am thinking of 
> for_each_and_bit()...
> 
>>           } while (1);
>>       } else {
>>           if (max310x_port_irq(s, 0) == IRQ_HANDLED)
> 
> thanks,

--
Many thanks,
Tapio Reijonen
