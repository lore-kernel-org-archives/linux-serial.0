Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDE985277;
	Fri, 24 May 2024 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716544155; cv=fail; b=Wul2q1cCgelY4NBiQrZ/HSjd0/xjryatSeeYdTvgUHBo6VILO8PWp8Nqg3dzX/g4mr2A5tMMYFQecA+97QQf/uNpwWJjOm73ZjlNsA8qgrLS0l+UADgm8zOofWjvk9MBFhP7c23o4qCdIIJqlcWYxuZODECHkSNQ3Po4uq4RE2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716544155; c=relaxed/simple;
	bh=qpHe5SAsT1s/g6i1PqJAJcUzPLeaHWOIxEnShVWtI0M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GW1pu2UoSnUApxSePmSWWjT1itvFDw1d3aOipiDI2Drzdjlkf/BgvwLLe3nzrXzYBkmq4sFbhP+nSGgPtPduyO/yJE4g5kw573qlq9OMgGoZ2ErJNeXtaFrGHUUFdvaHFGBgg01dN8bsHScnKOQ6CvE8nNRwgrqYZKK+q/egAoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uhg6LBgJ; arc=fail smtp.client-ip=40.107.212.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uhg6LBgJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9mDAlDjh1V9qpVRmXS4rVdleWOclU3kaCdHq9/BA8rUwY8Bh4ojTBy84cXhegf2ZV3llemrSxhQHAWoYG6x7A/drKhW8jZK8rjddjP/8X9ewWG1OZqvNNI1hbRqy9TNalyfaEKX6wfoUxnhZ6tC6781HUlibfpARsjh2ipRwX6IKjGNVqzLOrvj+vVrhlaHpfW+uUUjhaj7HloaAfrTQyvxxkNSXx0/b0j4j2XMpcpgcKhDzfjnmLtmsIklyEbsDUYpWub7hgrGSpHgvELDp6ga4mgdYa4rfE+MdvksOLe4J2Z3Z+Wh5V170XBkO0wslKOX3scDenRQuNATEsPqbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAA1TzzZvi6nH+HX0/vj9taSPYmmwDFk34emOqvc6pI=;
 b=Xke8mMvamMbe7zNsZU9pC1SXiTPTm1hKBzdXrU8Ky3wlOfkm5P7g274h3AaU50mwLV+p80jVRmJCX21scA5atsi0dn6FVnGyGigqQr+qy4jl3q1sS16nZmq6DmZP7hmJlVzp68H96yw2A3LdqKUVc85ySuFanokB8Lx8etb/iedxDVLGu9ChdUBRjJriKPkl3rgJKT86qsjXiTbDsIR+i3JN/7o9Tv1S2eNXpVQMTEKrdGEVidTBphXC20XDRn2AbiNtxhru47DCUb/I2iUq4PP2O+gTPN5XUVp7QBuILH/hUgcGrB31MR+uY+zKg2m4i3eGHNGRFIvWszILUOEDdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QAA1TzzZvi6nH+HX0/vj9taSPYmmwDFk34emOqvc6pI=;
 b=uhg6LBgJWbq90NDEc+TmGbVn4vJCWgFzRWHIqcmxFY4EAENFqzZjGhOGrf94IDkN/oqVdW1J+LsPUVtjXtTf4UapqZNRDJxHB3A5/lBT2wdZNizADUyHxLR9/I3r6zrYmJSp10kB5Gf1CbNv7RQ7NMXOO6fv04X3y6b38adtJ3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8547.namprd12.prod.outlook.com (2603:10b6:610:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 09:49:10 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 09:49:10 +0000
Message-ID: <6b74e8b7-efc2-4cf2-9c55-835fdf9a4947@amd.com>
Date: Fri, 24 May 2024 11:48:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/3] arm64: zynqmp: Add resets property for UART nodes
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>, git@amd.com,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, p.zabel@pengutronix.de,
 laurent.pinchart@ideasonboard.com, radhey.shyam.pandey@amd.com,
 parth.gajjar@amd.com, u.kleine-koenig@pengutronix.de, tglx@linutronix.de,
 julien.malik@unseenlabs.fr, ruanjinjie@huawei.com,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: srinivas.goud@amd.com, shubhrajyoti.datta@amd.com, manion05gk@gmail.com
References: <20240425062358.1347684-1-manikanta.guntupalli@amd.com>
 <20240425062358.1347684-3-manikanta.guntupalli@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240425062358.1347684-3-manikanta.guntupalli@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P194CA0025.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::14) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8547:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f998ffd-85ce-4356-7efc-08dc7bd6c2eb
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|1800799015|7416005|376005|921011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0lreS9Oc2hha3UvRzVIYVVJR2U2Z3pxK1BmNWVwSWxtbTZFcWFCUGhBTjBy?=
 =?utf-8?B?Ri9CTlhSYUJJdXp3SGlSVWhuOW52dWZ0R0wzVlN1ZWhTdDlPRTVFeW5YTkJ2?=
 =?utf-8?B?VDlLTmN5TkprYURzSVRlRjB5bUlDZzJvZ3phNmtZQzRob0crd3dpY3JGSHF1?=
 =?utf-8?B?Y24zTm9sOExjRlBKRFQvc1FFbE9zOEE0S2d2VEdTdlkwOStRU3lwUEtDbEh2?=
 =?utf-8?B?bk1CTXp5Y0dVM1l4NUlydnRFOFBvVjBseHg4d25FSVFKaExneTVTY2Y1UGJ4?=
 =?utf-8?B?YVlGSzRRRmNBa09JK29lVkNPRWEyUE1tbWtQUE1qMXV2ZFRMRU9IMUl0dWQ2?=
 =?utf-8?B?TTA3TjIzQS80akJ0YTlVNk1BeE5PZUVuYk1mOXFzeDhLMGp5b3Z2bnk0OHQ5?=
 =?utf-8?B?QUtlUHJpZ3A2eCtTbGpzN3U0UXI1cjQrYUVMWkNzMU9zbWoyUnVlbHJPdUZW?=
 =?utf-8?B?NmhZV3U0aDlId3RPMnFQUjFjRWxPZCtWVVB2U2ZOTlN3TzdOYTZPaXZ2MnN2?=
 =?utf-8?B?WnpUMWZ6MDlzVnpzaWk1QjA1dEp0Q08rZUFodFM1cm9mdkdlbFlSdldURkta?=
 =?utf-8?B?YkNqelV6RzZTZEthcEM4TWhQYzNHQnl6TnBVVUJ1cVp0Wk5BdXRsOXpaQWZC?=
 =?utf-8?B?QkJ0QkNOOVVCNXpvc1V5VGdwd0hzM0o4NkljTW53UXJLM1ZBTHVWSVVEVWE5?=
 =?utf-8?B?Q1JWTUpCMWRRK2R2UHJXQTlGQzlCc2tSRldkd0thYTVDNnpCMTFnTHJjeE5E?=
 =?utf-8?B?blNlTUxIZzdvQVkzTXRXMTAxaEtkTUJxRGlDZm13QkRMcm8vL3BTMzFZWWNV?=
 =?utf-8?B?d1V0d2RrWUZhN0xLV1FGWm52ZGdkNTIwSy82ZTZLOUFSVlcxVmRUYmxxZThi?=
 =?utf-8?B?WkRQVWRHWG1DUTUvU0t5ektubHA5eXJ4NGx0T1lqTXlEYUk4T2g4WW4rWU9U?=
 =?utf-8?B?MDRVR280Vlh5bnRDMUtiellVZ1B3cXpkYzRUaGV0dXZqVmJpUEFjc25IS2hT?=
 =?utf-8?B?SGZIZUgzeTdkSFNzZ1N2b1QxZEIxVkJka1h1SFlHSWllWUZFQ2NqeDZrZWo1?=
 =?utf-8?B?dTJNcE4rRkYzb2o4UmtRRmprNVROTXd4NzVDK2dDYVpNb2phNmFic0U3Qmlm?=
 =?utf-8?B?ZnJlS1pnZWRkbUhBZk1oa2RxL3licmUyMkdjcTc5SGY1ZmRwbkpCRWZQY1px?=
 =?utf-8?B?dW43OWFwanZBNENDT3JEd1Yrbm5MdGdsRHloTzRCTEhCOG9xYURCVVhJM3JO?=
 =?utf-8?B?VTNUS25OcFdWUkViZElhVVNKRlplRUZLQzJEd2lhODlXakxRZEMyekpOTE1u?=
 =?utf-8?B?Z3BxbU9Ed09FUUU5aGl5Q055L0tsTS9WUWlISElNSDZ3Uk5NYmpaNGpISWY3?=
 =?utf-8?B?TGIwQWdhNk9SazdYWEoxVWRQcVRYUE9kRStQTG81STM1V1AxZ2hlQjdKbUZz?=
 =?utf-8?B?djBZNy9oK1NyVEZaV3JOQ040MXhZQ3RJMHVqUE9lVFBEcHcvcUwwVno1ZDBH?=
 =?utf-8?B?NU9yN0pIWlVhRXM0Um1lS0FZSTJzbmMzZGd2UXZ0bkVldDZqZk1zbTBqb1E0?=
 =?utf-8?B?ak0xNVN6YzM3YVNZb1dRYyt5QXhCMHcrM0RrNm1aYnhiUGhSNGdOVGRSU3FV?=
 =?utf-8?B?SWd0RFQ2WnVkbGNGdnZXNnpnZTI0YWZWRHdFRDNaYmtwMmxraXdRZW4zQzg5?=
 =?utf-8?B?RUJFaC9JZVVJNTh2eHQ0RlJQL05mRjVqQnFOZEtOMUFHU0Q1QVp4QllSUWNG?=
 =?utf-8?Q?blDEE7/CX0vOfWykSC7sV4vO5kRg0YTlkf6SptR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YXZXbnNUK2ZPV1AvT3BZNGF6eUlZNVlKcnFnYU0vRzFVZnkxM28zbjlJRWRM?=
 =?utf-8?B?TTdkUC9NUDBtVUdUL3QvV0RRSHQ3R0FOQ2QzdjEwSDA5SEhmbjlRWEROZFJr?=
 =?utf-8?B?S0tuVmVMN2tmR0FFZ2ZjVmhqYit3SzFLMEdGTmpyaWRtT3A2eFo4RGtINGxo?=
 =?utf-8?B?OGJqQlJ2QXpZTFVWR0QzR3dLYWJXN1J4MHd4LzJwNit5WGY1T3Z2WnpEc0tK?=
 =?utf-8?B?Tnk3c201UjRXQk5kK1hLZndKZnJZeU1hVG5NdlZQa1BYaFlLTXdSWitvN2tL?=
 =?utf-8?B?WjhiR0RtcHRVbUFoV2RMQzdPYjBYb0w2VkxLblJMM0FsMUliUEd0aHM0b1Fz?=
 =?utf-8?B?ZkR6S2pIRkpHZjJBN1JFNW93RHRCSmhBdUxEU0FOdkJhbklJRVFXWUx5UmJq?=
 =?utf-8?B?ejZ3M2s1OWpFVi9tZ2l3QjMxSmp1SjJaRmpxVDRrRmszR3hQaDRvYUNON0tO?=
 =?utf-8?B?MWpEemFmbG9VUk5FTCszQ0h0eU5Md3l5dURsU3NUbmpGODNTc2ptSUtRQWc3?=
 =?utf-8?B?aTlyZC9Pb1RQYU1Bd0I5V1BPMnVFamV2N0d4YkJQQTZ1azJPdXdycjRqTDBU?=
 =?utf-8?B?OWN2RDdQb2FpQUhNMFl0RVZjMzVvVmpQdHhUaWZJSWdkUjF0MU9sWUkzdUY3?=
 =?utf-8?B?aVZUZEg5VVpuOG9COSs0ZzU0MzRaSzN3TzlaUjFrYXZsRTUxaW5lY1haTXBi?=
 =?utf-8?B?dVg4WEd5WW90L0ZMZmo5VkJibmo5d1FoVGxvb0JRZDB1ZGNLZGpxc2dZWi9a?=
 =?utf-8?B?RkxvZ0FWejZtZm5NUjBEWlcwc29HeEViMTlRVFdvUjkraG5Ta0VFT0NiVHhN?=
 =?utf-8?B?RDVmYjdGaVExdHREdnVXeW15LzUwWlEzUkFzTHMrdXQ0Yk4zb1hBTndIWUdG?=
 =?utf-8?B?UTlJdTFEVHNld1VCRGZldEFBUHAvUXFWZ3lMemtvVDNEMFQwTHRubVA5Z2JZ?=
 =?utf-8?B?aG04b3RObDRLWnZaUlFTazNsd2MrY2Z4cW41RUp5VVJOLytDOSt1bWtWajBr?=
 =?utf-8?B?MFZnVkFweHUzZlQ5eUZNQWtWWVpnYytJVE51NlkvSkduVUkySGMzSndTRncw?=
 =?utf-8?B?enJLMXB0UmxEdklLaTZTUllmc29tWG1jaGtJdGRDem5BREpVZlZVbGZpNXFU?=
 =?utf-8?B?eVh6c0t1QmRJRGNXeXlOR2p3Yitlcjh2dFNKUmZ4K2cyRDF1WmlIcmNYVGRB?=
 =?utf-8?B?M29HbnJrNFdidjNZUyt2NlJjL2l1NUpDUzFjVGVnM3pTUDBzMCt5bFh3dHR5?=
 =?utf-8?B?RFQ4NVREWS9hOFBOdVptNVo5cDNGSFFodHJ1a3VvTjdVMFlVZHFjdytMTldL?=
 =?utf-8?B?Mnh4RzJBQlNHWGpJRVdGZjR4UHVoYk4yUXRBVm45a2NZQjRWdmsyRUtMWlhF?=
 =?utf-8?B?Vy9Mbld6T0NiV3ZxaXFhYjA1U2ZKUzh6cysyVTA3Wmg2OHhSR05QMVJqL3p0?=
 =?utf-8?B?VTVTbUN0SDNqWm5MTmF5RTdxZnJibm16eTZpUjVCMkplWmRZZm00VkhGeHJX?=
 =?utf-8?B?ZmFReHVjWFJjZE5UcXpnRVk5eGZBMXA1ajNmY1Q3NjQ5Zll5cWgvbzJZRHdE?=
 =?utf-8?B?dXVhNkpQQXR3MlBEVVZIVk8vS1Q0TUxBbjZjeUd5SmZzOUVvRVpYZ0Ntdzl2?=
 =?utf-8?B?SVpUNjhhU0cvM090ZGpzaHN0aG9lWWRzQU05WTcrZ1VJV29nWk9KY2tFLzlu?=
 =?utf-8?B?SElSbm1iN1NpcWRTaEp1d09TcUpvcllZSlpsK0gzcmUvZTFHQWg4QlBSWkxT?=
 =?utf-8?B?Q0QxWmw1TERTZ0ZMbDFmTUljVmJpdUFlNHRha2pYRjR3N0F0SkRrNEpSRHFi?=
 =?utf-8?B?clpEUlkvQmV6NjZkWXFDUitTK3lCM29KTERNMk9jSmJwaXNicml3bUt5TTFV?=
 =?utf-8?B?YTZEcjZOQnZlY25ORzNqc21DRjZDcE5YeVh0dGhrN3MrbDUyZllYcjlHT2c5?=
 =?utf-8?B?T0dTcy82V2p6YzVSdmhKb3Z6VzJiM21TTk1wSlVTYjU4SDdaY2dJK3NCVjN2?=
 =?utf-8?B?NEk5N3B1VlFDN3NrL0lpU3R5aVAyWG1LOGxKMlNWSGR3RGltaURuMGt0d0Mx?=
 =?utf-8?B?dk5Oei9kaGpNNTdUdEVVcjAvSjR0WU5oYzRnOXM4WmZqcThsUG5hZjBYWkRp?=
 =?utf-8?Q?abNovgKnKYfIp1sXjnHOVIQ2m?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f998ffd-85ce-4356-7efc-08dc7bd6c2eb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 09:49:10.5778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IP3ePxre0AgHmNthra4Hkm657TWGs/r3+TCb/D73/UJ8BSSAXVRUKJRWhKTVVWNg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8547



On 4/25/24 08:23, Manikanta Guntupalli wrote:
> Add resets property for UART0 and UART1 nodes
> 
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
> Changes for V2:
> None.
> Changes for V3:
> None.
> ---
>   arch/arm64/boot/dts/xilinx/zynqmp.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> index 25d20d803230..935504424ec6 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> @@ -906,6 +906,7 @@ uart0: serial@ff000000 {
>   			reg = <0x0 0xff000000 0x0 0x1000>;
>   			clock-names = "uart_clk", "pclk";
>   			power-domains = <&zynqmp_firmware PD_UART_0>;
> +			resets = <&zynqmp_reset ZYNQMP_RESET_UART0>;
>   		};
>   
>   		uart1: serial@ff010000 {
> @@ -917,6 +918,7 @@ uart1: serial@ff010000 {
>   			reg = <0x0 0xff010000 0x0 0x1000>;
>   			clock-names = "uart_clk", "pclk";
>   			power-domains = <&zynqmp_firmware PD_UART_1>;
> +			resets = <&zynqmp_reset ZYNQMP_RESET_UART1>;
>   		};
>   
>   		usb0: usb@ff9d0000 {

This patch should likely go via my tree but if Greg wants to take it directly 
that's fine for me.
In that case here is my
Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal
