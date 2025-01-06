Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2124.outbound.protection.outlook.com [40.107.104.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED91113B59A;
	Mon,  6 Jan 2025 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736179137; cv=fail; b=WMzEYHKiJUByiDQTKufAB/+UGWhzGiS0XbgTaSL7YCwytYgkNOMWLzumAYDnazQAlNjC2n3tC5Xowxng1sCHYUgFQEFMZ9itJID/SbpHK5bKjBgHcTrQb8MS1Rem6M3N/0dCaVD3i7Tb+0ep0Ot/Vos20sCkIqoCl+fhRdF2D8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736179137; c=relaxed/simple;
	bh=6YpJWNyqaBD5Q11lSzP22zAHyXyy8VQUvB7+Yk/svY8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EBM6JP5LOYoBbJhKLF4a+Xw/hBONmo6JoilHSypP/nga5y9e1PwS72pgt6mmA3s2GIRUxfAtpbttyV7lebaHQUXrXGQhMMVCZ5xOXsB0Mxj4W8i8Fs5HGLYwAzYMEaIqVS7alc+Yl6ATlx8xFWLne3JzF05jehobhQWTaSwH0TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=NGqdkZog; arc=fail smtp.client-ip=40.107.104.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="NGqdkZog"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwyn+91PvCeYwg65QiJHrQby1n0rw/ARO+TvLnlzJf+6ls6RcqufsxOpVEw9Qi3a/dBXQEX+g7RbVSaF+gOCkNY94KQ/p7UHfSlWQmA0dHN57gEDxuEn98s/Jikm6NV0NGYtQcEK6ZP99w+7Ors/UnUCh4wCUoB2E+jPdH0NYUYEF+mHG7rYqYsiEMFibqNlY32+iQjGsnPk0HjGjjNQ9Wx7jIXINtCwwSxOMV/KcxXwBjlxhfbkNyU1odR8xJ/vxzpI16ah2Xi8wBbERJo71huAEepABWiW5IAbptB47wsqfa3tM6Tk+D1XYiJ45AFrzSjDbeRenJCcL/cy1VRVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmMzyvZkhAjd5n/buXlWzf0gohAK817o7N2CgcG/2PM=;
 b=N5mmZzeEzvFRZW7QH2PJeZKRLepXH6GK2hOPJ4DfcmZA4ZayeKU/JIWgrJqZRmf9p/lD08cCpMyE/ijyIu47/3X0UctV07z09Ggq8/zJM9mfeeRy8mFNpIjJN21TeGWTlQHbcQda+4+EotQR1/qf8UbY6BE+8NEtvXMIU5RxE233421kljkMS0DrEY0aO4PlJ/mqAn74eTMo3I/0dcIbn9Em22FhtvEQclYgEfh+Hwp2tjVeUmcwI56l0oKMkzaVbemVjiVIVE219KpQgL2t1oR7zwbYRIo/w+2lHV1Tps5KkG4OfVouJ9o1+FDE3vLYQukLQomAjSvhsCZMRdgpDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmMzyvZkhAjd5n/buXlWzf0gohAK817o7N2CgcG/2PM=;
 b=NGqdkZogHA7TSGoS/gr6SXQwE9/zEoLoxYs9gf57dqMLoRDg6p6IJ2f2M1YbMGd9VEDFu/38fjhqeiAHGVHkO3xlHb6ej6NpgemIhulvPldU2mY6oUqt738z4dg1wZPI4ZwXUHSRJWYVg3SqFDmW3bIHJppRDwYGY05YIQ0jKtg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 by AM0PR08MB5363.eurprd08.prod.outlook.com (2603:10a6:208:188::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 15:58:46 +0000
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42]) by AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42%7]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 15:58:46 +0000
Message-ID: <38c385fd-f1fa-4316-8023-a1f42c216ae8@genexis.eu>
Date: Mon, 6 Jan 2025 16:58:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] serial: Airoha SoC UART and HSUART support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 ansuelsmth@gmail.com, lorenzo@kernel.org
References: <20250105131147.2290237-1-benjamin.larsson@genexis.eu>
 <20250105131147.2290237-3-benjamin.larsson@genexis.eu>
 <cztvjlvaif4bh6xhd6ttbrbx2px7nebfwh4nuga4dz6wpz3oz3@cz75csyt2gfd>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <cztvjlvaif4bh6xhd6ttbrbx2px7nebfwh4nuga4dz6wpz3oz3@cz75csyt2gfd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0000382D.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:5:0:11) To AM6PR08MB4215.eurprd08.prod.outlook.com
 (2603:10a6:20b:90::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:EE_|AM0PR08MB5363:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f6ebabf-0031-406a-f6df-08dd2e6b0094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXo2RHlQbk1JS2FienJxVWF5djBrTkFGWjUveDBBT1E0aC9YUnlFMFdSVlFx?=
 =?utf-8?B?VWQwOU5xeEZ3N2twdG9xNlhNQWlGQzF0cVY3aFNvOFkrNlJWR2dtczR2Q1Bx?=
 =?utf-8?B?ZzVoRWJ3a2NlbFJ3TFU0WllndFlJY3g5SXNGV0o0dG5VWW9KZVRYZXM1dnRq?=
 =?utf-8?B?a3RRcXNLeittaDlsbHFFZHpuUkpDQ2k4WW9pTzBMOVI2azdZZUI2ck9lN3BU?=
 =?utf-8?B?RkduOEVKZW5hT085YXRIbnNKNEVVMXlTaTJMTHcxeDd1UzJhdTR6MzJDdXdn?=
 =?utf-8?B?NnJES0Fnc2F6OWNoNTR0YkhRSEtZNWxYcTZDVmhsbG9NNVhSK3dab25nUlVz?=
 =?utf-8?B?SUNSMWhFS3NNQkF0RHJoUHF3ZHcyZEF1Q0VDamUxVUx5L3Q5dU5hRzJUbHg4?=
 =?utf-8?B?L0QrcXhqbzFrTWhpQnhMVlZsRUsvM2JSbjBxTmhRdVBOb2Y2U0VURytjQktl?=
 =?utf-8?B?RitITzNEV2daNTJadW9DMlhvRDl0aGVOcFhYVnFqVEtWYXUzUTFPVUtSN24x?=
 =?utf-8?B?RE9yTTlsdmczaGhSRGl3WnBaL0drSFl5TGp2SHFiRDR1bkZtQzYxM04vbHRN?=
 =?utf-8?B?a2k3UFRGYzQwZW9xRncrY0tqZEFnWTc5enlrd1RRU2pRRWhaU0FRMG5YQzQ5?=
 =?utf-8?B?QjI1aExtQ0N0R0RKVGN4RHU5VTBwM1NTd09XbWYxSy9oVVArQWZuOGN2Q3Ft?=
 =?utf-8?B?aERmNGxhNVZ5Ulc5ZlFZN2FZellWdC9XaWowQ3YrVS9yd3NsMlk4amJYT21n?=
 =?utf-8?B?YmQxd2ZPVGhMZkllZjdkZWVQZzlhK0JjdDMyb3pjS3d6T0dNbVVFbXUyNWI3?=
 =?utf-8?B?Q3lOdHJlcnBYQnozSmRvdENnalBWTTd2VXZKMmJHcFA1MnA5cmJBUEI5SmxT?=
 =?utf-8?B?aHczeS9OOVZlWlJBcm5vUWppamhVenI5V3owUlUxQ0drdGFSVFp4dGtwQmxJ?=
 =?utf-8?B?eE5DUjB2S09nUGRpSXI2ZDYvNSt6V1hibEQ3eWNFUnMzRkxSZE5Ic0V6SEQ4?=
 =?utf-8?B?SHJrYWFMSkhlRGJkQy95RGNkaVZ0NmZNeFFSVjIvMHV2dWZyd1hqci9Ubi9L?=
 =?utf-8?B?U2YyR3ByTDVGTVcxeW9BUlVXc1BzSXNrdkJhWlJzVjZ5MEJuaWNGSXRsdXc3?=
 =?utf-8?B?c0VUMU9JcEladHdTbkZJcHQvd2hmdSszVGs5QlZTT1V6Uno3UmovcnRwZk80?=
 =?utf-8?B?TzFnZlJvd1QyQzBRUHBkYkZlblNoT2ZYd1d0RmpSellVMThIRC94ZFU2SHll?=
 =?utf-8?B?aDVNZWZTN1Q5Z1Y5TXpERlAveGtPcVo0NUJMczhJSU9DcEZpZGxGOEFFRDVE?=
 =?utf-8?B?TkxoTDJkTWRiaGZ4SHAzdC8wamZPclBxVDNQVEJnc0lHeHlZKzJRMjdsTnJj?=
 =?utf-8?B?ZVFJbjR3MVlQTjNIQWdINXVWcUlQTzcwN2daMWZuWVNmZGUwdVJROXZybSs3?=
 =?utf-8?B?M3AzbTVjRm00L0NBeURRTjdITnZPNGtFS0ZMVkQxbStMeGg4OWoyOEdhcjNX?=
 =?utf-8?B?Y1pEVkNyRk5FSmJ1VW9NdHNlSmNKSUFQOHhGQzBjUVY2OTk4RzZINWhTZWlr?=
 =?utf-8?B?a0hvTFFIbEtyMzJEQW5ZMUpEQ3g0cUtNcmJxZFYzV3FVUW5KeUZyWWJjT2E2?=
 =?utf-8?B?NnZYQ3FwYjJnS2pqKzI0YmtwSVVEVlIzdmc0UnNYSDJPMGdLQVR0a2NGR0VW?=
 =?utf-8?B?bmlBWWZiZDFjMWNBQ00xMk9TUmVXdE9ha3U4amhEcnA4UWRHY0JLNEowazJX?=
 =?utf-8?B?UVhvemsrZUJhalBGOEJLbHVMNWpReG0xblc5Q0ZqYnV1dTFKNzZ1Y1dHbXcz?=
 =?utf-8?B?U0F2cTZFVk5mOWlKaTdDeTF6OGhVQm52UjNGcnYzVW1rVHhWRkNpeTlRaGFh?=
 =?utf-8?Q?Gvw0tvZMVHUs9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4215.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjduZjV3YVM0ZFJVTHM4TmlGS0FTcFFMSkdXMDREN0R3d290cXJmaTFHQVBB?=
 =?utf-8?B?ZGRCS0pFTTJOaktWQmtpa012ODdtOERqS2RML0JwYmNaS3JuZDBPbGl1ZW15?=
 =?utf-8?B?WjF6Q01RZ3RxWGxDdDFVenlON3JuckcxKzdKNnhJMkJyRDJEZVVvcDh0NWk3?=
 =?utf-8?B?am5HMHRPSzRLYmxoS1lXOWJkWDRyOEpkU1JZQXlqcVFRUTV5NkNURjlDdGEw?=
 =?utf-8?B?UllINjJrcWJaWFJRMGFoQU1zZm9hRzNoU1VFbmlHRUp1S2t5UElrUFlNUzhT?=
 =?utf-8?B?WEs4V1o3czVVSXNDdzFEZW5XVFdST3VSaE9DbkxkMnRrdWdqc290WXd2NFM3?=
 =?utf-8?B?MXV0cHJ2ekl1QW5NbWcxeXVLTU5HUGRQbmpEdy9pdit4M1Myd0MrRW5sanox?=
 =?utf-8?B?aE5ydkpMWDhCN2p6K0hNRUp2T3BVb0lLWjBVUFhRVUYwQUlMV3VDNG5NaDht?=
 =?utf-8?B?TndLZXU3RkpwZVlLakJ2VHorcStBK01sRzZWZm9TOVB0YXNDK0tGL05YbGNp?=
 =?utf-8?B?T3RpUDh5L2w2L2hsdHdLU1E5NmlzU3RnbW5YaEZvTTQ0Q2UxaHBvQVVPVmpU?=
 =?utf-8?B?QXEzWlYxSXcyWE5lbCtiN1l4YUlVZ09KV0hKMGhSR3RqNlZ5QW5hMmFwM0VD?=
 =?utf-8?B?VlJEdEZQOHY1UzdPaFpqZWUreTZhSFY1UitHMTlXVXpvSkc0NEJZbW85QzQz?=
 =?utf-8?B?akdhR1YxSG1McWU3OS9XRlQ2OGhEdXAxUTJzWW42K2tNYW9kZ1lPazFGOExm?=
 =?utf-8?B?MmNZY1VJWEFkaEEzRFk3YXEvV3RScG54dFRWTnNwWmpDVFo0Vzg0TkRRaUtr?=
 =?utf-8?B?WnQ5Z1JJUTZoSjc4ZE5Mc0hjYTd6YlFRTXp5bVJIUkcyYUozWEd1elZENUJk?=
 =?utf-8?B?SGFkZFFpVXJGVjZQNk5KdWc1azVObVJ5RnpneVJOMjFBc2thUVhEdFdUVm5U?=
 =?utf-8?B?VmdVU1lLcmI3UEU5N0hkb08zck5JRFBucC95aGhNMGZOMExLdXZjNFJILzVl?=
 =?utf-8?B?bGdrYWhiUWNRNXIvbDF3V200OUQwdlN1QnArdXVVNEJwUTRRUWJEa21QYith?=
 =?utf-8?B?bEFjYjJIUXk5ZDBqTnhBRm1CUWQzRWJ0aGI4R01vajRBc0VBWWhBZ05Jb0NN?=
 =?utf-8?B?NDU4RDNsaGt0bnJ5U1BGUkd1TFpoT0JYUzd5MkFDNlpkMmljTTFENDJCYmpk?=
 =?utf-8?B?Y1NWT0MvRERkSTkyM3lJcisyUE5aWUtiK1h4NlJLV1dXTERkRXV3ZjFtUFNB?=
 =?utf-8?B?TE11TmZOMVYwNzl5aFZVdHNTYmtUclZmSFpzTUIyS1A3Vk5BZ05XQnplY01F?=
 =?utf-8?B?VE5yNjMwTy9rT0lXQzZsSTVabWsrUmMyOXZqVEdkM0hndHdqdXNlRWd5NGYx?=
 =?utf-8?B?YkIxQjNPY3UwK0U1Ynd4czBoWFZ0RDBYVklVUzY5OE1IdVhoTmEwRjQ0T2F0?=
 =?utf-8?B?OC9WRldNaDJXTVZIN3BYd1Zicm45M0o4OC9OSGJEMnNUS1NoZVYxdWZQQ1lE?=
 =?utf-8?B?VjBwZkN0QUd3d1BLUWljN3FIVUFBR3NXT042VWsvbVg0aWFRS2VEVEdPT2tk?=
 =?utf-8?B?MTY5LzZtQnVwSDhGUUgxR1lST2doYlI3M2xxQk40NWFFR09SUEFjWENQV2JX?=
 =?utf-8?B?MUN0Yjh4c2NUVjM3d200SDRaZVVmandtMVlpRnE2T1prOWRhSjlUb3ZaVUxW?=
 =?utf-8?B?R1RxYlJKWFpqR2E3S2krUUxMdTcwcUJjV2RZYlhOdmIrOHF2TjhOQzc1MDVn?=
 =?utf-8?B?dmhwQzJoaUd3T292Q3kveVNBVWdhZTdRc0QrMWlqVkdoWnZOekpVdkdaZEV1?=
 =?utf-8?B?cG53M2ppOHJMRllBVXIzUG10R0dWUndndFdlR2NGQlppQS80ZS9XdXpna01v?=
 =?utf-8?B?cVJMd1doQlBhQ1VVbFJOMTB2L3JaN1p5VGhpQitSSjVjV2xxbmxTaFVVTkxG?=
 =?utf-8?B?UDZUN0NFckg3ZmdxRWF4amR5RVY2cmVwSnpuTXBLZ3NndWRrLzdhVHBsOFBx?=
 =?utf-8?B?K2x1RldMVlloYzkxbFMyRmRXUDh0NmFoZ1JWY094WmpxU3pFQjFxUitSNjFZ?=
 =?utf-8?B?RDdhT1BSUlVKaXZtNXJkUTZwTkR3WVNNdTVMeHVRSnA3SHE5OGs5K0hBM2pP?=
 =?utf-8?B?N1AxUW5tU1J5QkZ4cU9VNWQwU2d2amxRcTMrdzhxc1lMSHgzOXRsRUJja0xz?=
 =?utf-8?B?VVE9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f6ebabf-0031-406a-f6df-08dd2e6b0094
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4215.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 15:58:46.4174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rAmc+9cSCkJ3aIfy3FadUFnFJuRTPdOvM/tmDwEwCGgykn6/vMRhWnJL5YYdzKc4EN042+PfQYp6FyGajnlQ6qL3xhMGLEzlXpKJJXcbo28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5363

Hi.

On 06/01/2025 08:19, Krzysztof Kozlowski wrote:
> On Sun, Jan 05, 2025 at 02:11:47PM +0100, Benjamin Larsson wrote:
>> Support for Airoha AN7581 SoC UART and HSUART baud rate
>> calculation routine.
>>
>> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
>> ---
>>   drivers/tty/serial/8250/8250_airoha.c | 85 +++++++++++++++++++++++++++
>>   drivers/tty/serial/8250/8250_of.c     |  2 +
>>   drivers/tty/serial/8250/8250_port.c   | 26 ++++++++
>>   drivers/tty/serial/8250/Kconfig       | 10 ++++
>>   drivers/tty/serial/8250/Makefile      |  1 +
>>   include/linux/serial_8250.h           |  1 +
>>   include/uapi/linux/serial_core.h      |  6 ++
>>   include/uapi/linux/serial_reg.h       |  9 +++
>>   8 files changed, 140 insertions(+)
>>   create mode 100644 drivers/tty/serial/8250/8250_airoha.c
>>
>> diff --git a/drivers/tty/serial/8250/8250_airoha.c b/drivers/tty/serial/8250/8250_airoha.c
>> new file mode 100644
>> index 000000000000..c57789dcc174
>> --- /dev/null
>> +++ b/drivers/tty/serial/8250/8250_airoha.c
>> @@ -0,0 +1,85 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +
>> +/*
>> + * Airoha UART driver.
>> + *
>> + * Copyright (c) 2025 Genexis Sweden AB
>> + * Author: Benjamin Larsson <benjamin.larsson@genexis.eu>
>> + */
>> +
>> +#include <linux/clk.h>
> 
> Where is it used?
> 
>> +#include <linux/io.h>
>> +#include <linux/module.h>
>> +#include <linux/of_irq.h>
> 
> Where is it used?
> 
>> +#include <linux/of_platform.h>
> 
> Where is it used?
> 
>> +#include <linux/pinctrl/consumer.h>
> 
> I have impression that none of these are used. You include some huge
> amount of unused headers.
> 
>> +#include <linux/platform_device.h>
> 
> ???
> 
>> +#include <linux/pm_runtime.h>
> 
> I really cannot find it.
> 
>> +#include <linux/serial_8250.h>
>> +#include <linux/serial_reg.h>
>> +#include <linux/console.h>
>> +#include <linux/dma-mapping.h>
> 
> Where do you use DMA?
> 
>> +#include <linux/tty.h>
>> +#include <linux/tty_flip.h>
> 
> Any of these?

My bad forgot to remove most of them, they/some where needed in the 
initial development. Will address in v2.

> 
>> +
>> +#include "8250.h"
>> +
>> +/* The Airoha UART is 16550-compatible except for the baud rate calculation.
>> + *
>> + * crystal_clock = 20 MHz
>> + * xindiv_clock = crystal_clock / clock_div
>> + * (x/y) = XYD, 32 bit register with 16 bits of x and then 16 bits of y
>> + * clock_div = XINCLK_DIVCNT (default set to 10 (0x4)),
>> + *           - 3 bit register [ 1, 2, 4, 8, 10, 12, 16, 20 ]
>> + *
>> + * baud_rate = ((xindiv_clock) * (x/y)) / ([BRDH,BRDL] * 16)
>> + *
>> + * XYD_y seems to need to be larger then XYD_x for proper waveform generation.
>> + * Setting [BRDH,BRDL] to [0,1] and XYD_y to 65000 give even values
>> + * for usual baud rates.
>> + *
>> + * Selecting divider needs to fulfill
>> + * 1.8432 MHz <= xindiv_clk <= APB clock / 2
>> + * The clocks are unknown but a divider of value 1 did not result in a valid
>> + * waveform.
>> + *
>> + */
>> +
>> +#define CLOCK_DIV_TAB_ELEMS 3
> 
> No, use ARRAY_SIZE in your code.

Will address in v2.

> 
>> +#define XYD_Y 65000
>> +#define XINDIV_CLOCK 20000000
> 
> And what if input clock has different rate?

On this family of SoCs the clock is fixed. I will add a note about that 
in v2.

> 
>> +#define UART_BRDL_20M 0x01
>> +#define UART_BRDH_20M 0x00
> 
> Blank line

Will address in v2.

> 
>> +static int clock_div_tab[] = { 10, 4, 2};
>> +static int clock_div_reg[] = {  4, 2, 1};
> 
> Why not const?

Will address in v2.

> 
> Best regards,
> Krzysztof
> 

MvH
Benjamin Larsson
