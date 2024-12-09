Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320DE156F5F;
	Mon,  9 Dec 2024 23:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786125; cv=fail; b=YKJGh5wqiJ3H8DeqgKiKv5Xh784/f2STdFjoOol5uuZS4igv4u1GYhgeKmyRH5E5dy5jJrlJZzTVN1mEwcAPs9mSKQ8k1rso5EYif5jqzI02lCX3/pqPtc7Zs2FQzWFmTFv/EeQxlnEfBrE3CKhdr2vApknhRfDnL62Ifb/uPFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786125; c=relaxed/simple;
	bh=u8SFrW4/u0dOHHswL8SRLuPZQoz1pjJUQDIyiDOZLIk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HfbmAW/IXf1Rp9yg2UHx1tNmaSsFvA5HPp2HMVgoVGYJHzcVWfE7oGHamC21v5CZydQN8YbjiKQtvCTZYx/rqqi1PGAOuTaIIUPdO9UtwtMGxFA6AMO0IXPW5jcqXdyUtMs0AEVJN/28UUlTb4z7pWV5+Xi7v3cRnCASgaLENO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B97K5HU008926;
	Mon, 9 Dec 2024 15:14:28 -0800
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx1u215v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 15:14:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YBSbcwqclyHhtNsCsflWW5ca/EAwndQSAZdqHrvZWfPGSlo1BOWQvtgzxwPo5IY2UxTlddAuG6WhXbvwMikSWH1W8hOFz3rtP/pO3OhKtZO2cAsD4gpFpve2+6nNulxFyke+7Le7RBmsiyv8HkDmYsj31BV2/u9IHOyMNEsFPY2OxniylQG8BwgKaTj5JYPGomulXEwxKQjn9yCsNe/piFgqMOTqP4j+cQovoiylmYpJRepGMRiqu6UmnEWguCTCFks50lF+AZfChbqP4LvQepHmzSOcP1+O6o6Kjqj36By1FDCNcCFu2hDTl7SYTgwMEU9ZRnN+MG9w7k4UmoGXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXh6MIm99aRkczA9DuETexFWOvBK/TDvEFk11ZH6bPQ=;
 b=p3eR8rNCC+DkBhHfZpnIEcs1b8yGzDsiXd/G0AN6nWKj9NnigAj4MrgMaCLVA4diNxOSG7SzD9u36Xf+mLevB9rmG2jdS19M6R4CyXwlucA8O1NWwevxlHLLdvtnAOeG7/m/ovsymz2Lldct7cZE2Pd0se5v8NALp5XouA+ioRSLOwxFwRnK71HsX+WKEBKHwlkupX6x6j0Bb6kErpVh9gZ/FwrWz3VB5aq0X8Iq76RJUK5w4EFtr3ZS02TvNKy1o3xrw28e102imQvLWoBAQU5HSQru+WSt7TSbpjP0+0swE0UJlUYNIlAU7ebH2+r+1FLwuCVa0AMIOI5642d+aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MW5PR11MB5764.namprd11.prod.outlook.com (2603:10b6:303:197::8)
 by SA1PR11MB7087.namprd11.prod.outlook.com (2603:10b6:806:2b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 23:14:23 +0000
Received: from MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8]) by MW5PR11MB5764.namprd11.prod.outlook.com
 ([fe80::3c2c:a17f:2516:4dc8%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 23:14:23 +0000
Message-ID: <c12f933e-d749-4fde-90c4-8fa46744c680@windriver.com>
Date: Tue, 10 Dec 2024 10:14:12 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: imx: Use uart_port_lock_irqsave() instead of
 uart_port_lock()
To: Lucas Stach <l.stach@pengutronix.de>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, esben@geanix.com,
        linux@rasmusvillemoes.dk, l.sanfilippo@kunbus.com, marex@denx.de,
        stefan.eichenberger@toradex.com, cniedermaier@dh-electronics.com,
        rickaran@axis.com
Cc: linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <20241209124732.693834-1-xiaolei.wang@windriver.com>
 <ea1ca102ab0ec5068d82935623fd9ffb0b9aade1.camel@pengutronix.de>
Content-Language: en-US
From: wang xiaolei <xiaolei.wang@windriver.com>
In-Reply-To: <ea1ca102ab0ec5068d82935623fd9ffb0b9aade1.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0277.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::7) To MW5PR11MB5764.namprd11.prod.outlook.com
 (2603:10b6:303:197::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5764:EE_|SA1PR11MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fbac4f0-f100-4b75-1990-08dd18a737c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVQ2d2FkNVBZY05oTGU5N0x5ZG56RGFINWVqRXhkbEVJb3dBQkh1TGpWUisw?=
 =?utf-8?B?K2l4aU5nZmIyZFE4Qjh2YTZJY0lreHl6N2ZhZUFCaENHQnk3cEZlZDZZdzg5?=
 =?utf-8?B?MDErVHRYM0xiVUpsZVRpNlpHcmQ0R2p0bnBmc1dKd1o0RHBBNWcreHJZcDBU?=
 =?utf-8?B?dU5jdlNrbWY1Wk1pVTB6bjk2TW53OGZpSzVGN0RwOUlha2R3UUQ3TnQ3OVJE?=
 =?utf-8?B?OGk1aUdPZzN0Tlh0WGZQdndBRnk4V282YmlHdlhhL3BFMWk4WEZuZ0g2STZp?=
 =?utf-8?B?TzNSdE83KytkVStDYkJHdUhRSG9GQWtXWDVtMVZxUmp4K3MrU0FYT2c2Sks0?=
 =?utf-8?B?eUZaT0pJK1NVdU9HT1VLdzVFd3FBQjZXaW5lQVdkZjI2TFpDRkNLS28zOTBB?=
 =?utf-8?B?b1ExNmxLbnZtU0V1Z2MvUGNmWUNyeVhvYnpXSEVNNHp1azNWaHd0Y0EzMjZO?=
 =?utf-8?B?VlBOSEpXcWhHS1BYS3BxQkI0TDUyRW1KTFkralRQRHdQNWpvTmpiWlJTYWZ3?=
 =?utf-8?B?OWlmbmt5SXRBaGtURjlRUDJGOU4rTk8rdXlQZXk0bWZNcmN3a1k3UDFWZUdv?=
 =?utf-8?B?YnlHV3lhNnBjWHJ2ODliUExjTzJ5QjhueHZhakRrMzFWbUdQRkJ4K21YMVZP?=
 =?utf-8?B?amdCczNPbmlGS1FRUG9lQkhNTFZvSnJRR0FKWTRPaW16aDE2bVl0Q0c2VzYw?=
 =?utf-8?B?S0RzM3B5NzRoWndFWnRQTWtOOUR4TEFzMVFOM2NoZjNBRk5Wd2JOcFd1WVls?=
 =?utf-8?B?QkpTb2ZtaW1rYThNUWJMTEF2K25NOUw0Y0FYVFU2MzlCdWZNMjhUNE41VDZn?=
 =?utf-8?B?V05WdTByL2ZuVXVMd3B5bjVFTm9OM0RxbUROVjBjZGZMSnNvZGloZlNJZXkr?=
 =?utf-8?B?dUhnL2lxQmJ6QUJDZnZIWEpVSTVHVFRZa296NlNobUEvcEprcEFZNzcxa0lR?=
 =?utf-8?B?d2RzeGRXeGVidG9aMmRLMUdkSENUb3BQYXNqOWFyb3h3eHpjdFFFVTVvanJD?=
 =?utf-8?B?MnJ4Szl2R1BLcjZKUXR4eWpmVnFhby9jUkhlUkFpRndPSWFJUTZFRGU2cnNh?=
 =?utf-8?B?d1RmWjRoRllkY3VuR1k1Z01BWEljZFFaYUVtOWUyeStpU3FYbjQ0VlU1bjN3?=
 =?utf-8?B?b0VlQjJWSTRYMXdPT1ZxdVRnOE0zSmg5cVpjOU1jMVU0MkY5YUUvd1B2aEp5?=
 =?utf-8?B?LzUvOTZ5TWlrbW9nZDUzaVl6ZGdMNGxrTytXZEh6ZXJMUDNrNlF0ZVhJWG14?=
 =?utf-8?B?QSs3bXhWbVNSNW56Q2Njckh5cWV2Tm5aZHJzQkJHU2FhNlAwa3JNRTYySG02?=
 =?utf-8?B?Q29FeTZtdmxSanVjaTBwT0lXalJGRWV6clVwSCtSeVZFUm1PYmE0ekRDUG1p?=
 =?utf-8?B?SmlSUDdJNGl4VTlDazdGb3VyeEdnd080K2NOTlZ6bGpoc2d6Z2VITkpDZEdv?=
 =?utf-8?B?MGVqRmhDaEdVMVF4RTR5ZU5UR2J4NWpMQkdlUVNEYmJvcDRWMzBHZHFZTEpJ?=
 =?utf-8?B?Z25TVm1NQ0huazdINXpxb0xmUWlrNFpCVEVXVEJsak0xTHIxeDVING9QeU95?=
 =?utf-8?B?MVFpTW9sU1J1TzhTcWFOMTc1MVVFdHg5REtLVzFsZnMvaFNUTG50OExYdkNM?=
 =?utf-8?B?ZmNVVUFUWGdWa1FGUk1Hb3RseGRDNll0TkY4SlNJcjA1TFB2TzZDdHF3c3ZY?=
 =?utf-8?B?SEY3NFhKZG0rVUhlbXhYUXJDWlluMkhodWRsdkpTV0xMVmhmSzZzUWNJRnRH?=
 =?utf-8?B?Nm1xR3d5WUNMNmdWd2s5QXUwUGhsY0VqVVZ2Ui9hNGlKRnRhVUlFK1hGakVW?=
 =?utf-8?B?cllacjFjdDF6MjFLbXEyUzExY1IxWkhEWi9oVEdQZFA0QzNrL2xoblpPaUxR?=
 =?utf-8?Q?TeBMUrfPTwmL3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5764.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTN0M1lSNWFIRWNuK2V6VFVSU1VJL29TSXVLM0RVZ0VZMC9sRUlGcVRLTldo?=
 =?utf-8?B?b1lxY05lNmZNK2VQMkN4Y3lLSFBURTZpTzRFK2NvQjVUSHRZa01EczlxTnNL?=
 =?utf-8?B?N1lIZlE3RllEb05ZYmFSck45VnZMSWdlWmxhU0JXS2ZKVytnMmljcnJsNFpW?=
 =?utf-8?B?KzVBUFVickQyNUhZSWRDRFIrdlVQSnhxcjRnWmRnemc4dys2TXVkeGxSRXpt?=
 =?utf-8?B?dnN2MGJqZHBheUZTMzJkYTllTFB5anpBeGNxMExSM1o1cEcyYWw4bms1V2lE?=
 =?utf-8?B?M0UwRnNBY1lxbWkxQzFxVEtZWUhzYlpGNVp1UVJvQjNPWWxpbGtuQmpXRWFX?=
 =?utf-8?B?b05NZGVZT2tHRjE5MVRsbjlXUHN6akg4d1g1ZW9KTW1QMHQybGRZc0JKdWFv?=
 =?utf-8?B?ME5LYkF5ZFBtWldBTXNCQThveDY5MnMrTUxzd3pvYzlCcTM4MzRxekNieGRu?=
 =?utf-8?B?TWNnWTVjK1k2MG4wVXY1b2h4b2V1TGsxekdVaWNyR20vU1dCZGY1UDdVU2sw?=
 =?utf-8?B?eXJYTTlVdGFZUHhuM204YzRrZ295TEhsRFR6Vk9VTEVqKzdFVEN3V1FEMks1?=
 =?utf-8?B?NkxieEwrQlJqM2kzTEIrajlLK05STmxOSWxUODN6dDN6YmNjLzI3bTJ4MkJH?=
 =?utf-8?B?VnJDd25tcGxLL3k4eUtuS3p5cXFVTk5ubW5VTnA1QmtRaWd1NXhvc3NrQXI3?=
 =?utf-8?B?MDdsOE5jcEh4c1J2N0xBbVpidllCRHpmYlZySXM4VW5ib015b04vcVpzNWJ1?=
 =?utf-8?B?czhNdHNoSHFjck13K0xxaU50cmIwTzhCYS80SjU3SCtjcEp0Zll0N1MxY1RW?=
 =?utf-8?B?THhzMlZ4V1JmSXBRNG5iMGJlUlMrWmxCSkt3RUZpYWNYdWZLbDFCWkFiU25L?=
 =?utf-8?B?dldpcWQ4OEhDb1A5S2x5bndTa1VXOWhZdnM2VnQ3NWlvTE1ydkNUeGVtVEFD?=
 =?utf-8?B?RjhMOWxBN1hjaFhCUDBRZWxML0NkaS9iN0hCOTBQc0JIMnJTZmorL04rbUQz?=
 =?utf-8?B?V0tTRFR6eGxPN3FDb2xOdUFjU29rNHRjeTFYWjJKVUZPVFh6QUZhOU5QWWhU?=
 =?utf-8?B?SXRlQlBUdE1IMWZVZjN5OEo0SlRKUVNhbHlMaURIVnc3Ty9vaTN5MnJmQnpx?=
 =?utf-8?B?N3pDWHBKelYreDltdXNwNEJhSzZHTlo1M2dmTGovSUdjbmtsUEE0WmJDUVA0?=
 =?utf-8?B?Zk5OUWZBUGxNektsTzliNXBhZmJxVmpLSWlyNElybVNkdkRtR29ZR2JPMzg0?=
 =?utf-8?B?c1JRUWg4SW9MYzJpdDJ4RnliVjBCSXIvWWsyd0w2eEJoWncrQVpWVlFtczRy?=
 =?utf-8?B?VllhckRQU1lWeVZqQjhVTjI1cFp3QTltdHpNMzhGd0F4dWNraUxrcTQ3MllK?=
 =?utf-8?B?YmdVTGhuNTVBZXRxeTRpL2RUbVlRbGhXRE1PcjRlbkNiZG55OGc0N3lTSlEy?=
 =?utf-8?B?bTNraFp2cnhNVW9uZVlqU1c4TmZ3QlFYR0RXUHRDbUdEaEdnRXlCRG04U2Q0?=
 =?utf-8?B?bDBqR0dRY2szWFJVY2J5dlppZWVmRWl2SFFaSXFjcGpvN2Nrb0E0dThrcURi?=
 =?utf-8?B?dER6WlM5MUk4aE9iYjMyWXNzUW9WMElVS0xoNkx3SFJOemFjUDdERXBpcG1t?=
 =?utf-8?B?TzU3U0F0YXI3RlUzZG1QUFZRbHJwSHlXZ3lXTGEranhHQU9pTUt4eUVKNHcx?=
 =?utf-8?B?NXVDQ0ZhcHU1c1d1aUFSbGFKZ0NuUXhvc1IwV093RVkweit3OWxmV1YwMDZD?=
 =?utf-8?B?Mms1Vk5KTno1Y3EvbEkyYkVDelM2RnFLVU14Sk9NUWcyTEZGaWovT09GSEFj?=
 =?utf-8?B?WS9qdGxlV1orOWRyYjdSUHpHN0JPbXkyeHFQWFRMMmxvMVRSZVRZWFVPWG5T?=
 =?utf-8?B?Zm56eURpZWFSc3REU0tleUE1dFBXMVBFSDhCQVk3cHBXZ1VBQ0FJSjFjZWlM?=
 =?utf-8?B?QmJCN1lTQTgxZm1RU0RMUXpQR3dYUUx4dGYyYUV4SmIwRDFjQm1BcDMzc1hO?=
 =?utf-8?B?bG0rbHZKeDI0b2FDTDhmbjUzR2hxNWRkRWxSR2Z0dEFRc2sxd2FCM1pEQTVK?=
 =?utf-8?B?RTJyMTAwd0xxWUc2dmEwQzZMS01tOVMvQWRGL3ZhVFdJcFZZbVgrZHFTZU1X?=
 =?utf-8?B?MmpnazNzdDNpZDhCY2FRM2VCWE5FSm1KeFhFa1dicGZUeitTYXVHaUwvZVBj?=
 =?utf-8?B?OFE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fbac4f0-f100-4b75-1990-08dd18a737c1
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5764.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 23:14:23.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kRP91AOw22v9Q2usftprGPUmRIloU+zHwx9+Z9fwS5nCuic/xY8Pc6mHAAil4feRAM4Ax0BPqAIm+TQGoDaUVDp8GKVVF5hFmBjnl226B8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7087
X-Authority-Analysis: v=2.4 cv=H/shw/Yi c=1 sm=1 tr=0 ts=675779d4 cx=c_pps a=MPHjzrODTC1L994aNYq1fw==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10
 a=t7CeM3EgAAAA:8 a=INFWBHpzWaVgGG1Mgi8A:9 a=QEXdDO2ut3YA:10 a=EgV5L4Ra9ea3rcF7PrT8:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: k1wWX8jtv5xKteEWgrCpjQBaV_7UBrWd
X-Proofpoint-GUID: k1wWX8jtv5xKteEWgrCpjQBaV_7UBrWd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_20,2024-12-09_05,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2412090180


On 12/10/24 1:37 AM, Lucas Stach wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
> Am Montag, dem 09.12.2024 um 20:47 +0800 schrieb Xiaolei Wang:
>> When executing 'ehco mem > /sys/power/state', the following
>> deadlock occurs. Since there is output during the serial
>> port entering the suspend process, the suspend will be
>> interrupted, resulting in the nesting of locks. Therefore,
>> use uart_port_lock_irqsave instead of uart_port_unlock.
>>
>> WARNING: inconsistent lock state
>> 6.12.0-rc2-00002-g3c199ed5bd64-dirty #23 Not tainted
>> --------------------------------
>> inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
>> sh/494 [HC0[0]:SC0[0]:HE1:SE1] takes:
>> c4db5850 (&port_lock_key){?.-.}-{3:3}, at: imx_uart_enable_wakeup+0x14/0x254
>> {IN-HARDIRQ-W} state was registered at:
>>    lock_acquire+0x104/0x348
>>    _raw_spin_lock+0x48/0x84
>>    imx_uart_int+0x14/0x4dc
>>    __handle_irq_event_percpu+0xac/0x2fc
>>    handle_irq_event_percpu+0xc/0x40
>>    handle_irq_event+0x38/0x8c
>>    handle_fasteoi_irq+0xb4/0x1b8
>>    handle_irq_desc+0x1c/0x2c
>>    gic_handle_irq+0x6c/0xa0
>>    generic_handle_arch_irq+0x2c/0x64
>>    call_with_stack+0x18/0x20
>>    __irq_svc+0x9c/0xbc
>>    _raw_spin_unlock_irqrestore+0x2c/0x48
>>    uart_write+0xd8/0x3a0
>>    do_output_char+0x1a8/0x1e4
>>    n_tty_write+0x224/0x440
>>    file_tty_write.constprop.0+0x124/0x250
>>    do_iter_readv_writev+0x100/0x1e0
>>    vfs_writev+0xc4/0x448
>>    do_writev+0x68/0xf8
>>    ret_fast_syscall+0x0/0x1c
>> irq event stamp: 31593
>> hardirqs last  enabled at (31593): [<c1150e48>] _raw_spin_unlock_irqrestore+0x44/0x48
>> hardirqs last disabled at (31592): [<c07f32f0>] clk_enable_lock+0x60/0x120
>> softirqs last  enabled at (30334): [<c012d1d4>] handle_softirqs+0x2cc/0x478
>> softirqs last disabled at (30325): [<c012d510>] __irq_exit_rcu+0x120/0x15c
>>
>> other info that might help us debug this:
>>   Possible unsafe locking scenario:
>>
>>         CPU0
>>         ----
>>    lock(&port_lock_key);
>>    <Interrupt>
>>      lock(&port_lock_key);
>>
>> Fixes: 3c199ed5bd64 ("serial: imx: Grab port lock in imx_uart_enable_wakeup()")
>> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
>> ---
>>   drivers/tty/serial/imx.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 17f70e4bee43..4470bcb3ef19 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -2691,8 +2691,9 @@ static void imx_uart_save_context(struct imx_port *sport)
>>   static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
>>   {
>>        u32 ucr3;
>> +     unsigned long flags;
>>
>> -     uart_port_lock(&sport->port);
>> +     uart_port_lock_irqsave(&sport->port, &flags);
> This function is only called from process context, so it should be fine
> to use uart_port_lock_irq().
Thank you for your reminder, Lucas, I will send a new version

thanks
xiaolei
>
> Regards,
> Lucas
>
>>        ucr3 = imx_uart_readl(sport, UCR3);
>>        if (on) {
>> @@ -2714,7 +2715,7 @@ static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
>>                imx_uart_writel(sport, ucr1, UCR1);
>>        }
>>
>> -     uart_port_unlock(&sport->port);
>> +     uart_port_unlock_irqrestore(&sport->port, flags);
>>   }
>>
>>   static int imx_uart_suspend_noirq(struct device *dev)
