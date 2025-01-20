Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2119.outbound.protection.outlook.com [40.107.22.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD34A1DFDBB;
	Mon, 20 Jan 2025 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737377956; cv=fail; b=qwxM5HVmk3439xVQSiU2xwZJ2mtu6L3/yllHhj97rOmJSUZ2SMg27Ax5CifketVULBgTQVT/9Cnvl/cR9JnA2Dqz5e375wm+tczjrn2AJRgfs3bo3tdW4qFczKF4d+RMr+9vLajngICjzCc7aiiDU92zODXYmulcMtcFDDgJQUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737377956; c=relaxed/simple;
	bh=xmH/iMELyRwqZ1x9tQ5htVzVt4yr/svc+lEHPephJfE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Oaaz57N727959AlNQ8Oho6FEbJUa31ej6VebsV3av1cbfF+I7HV+KrMiDOzPQUGdP5ygM66i5iTam2PJ7pu/R7N6eG04AwRuOOVtp9LbojHli6rS6ttc/MCBci29cYpyeIgbZ9kcJq2Z/sfrhOSHwvbkaI3NNGu5nrcT8gE3p0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=Aaqa9HEq; arc=fail smtp.client-ip=40.107.22.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="Aaqa9HEq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DX4H8s/4ODXZMetKferOCDjuUUNAZKpGud79jNOkauakIfTm5WqQ7DFcsq40EZ2QvoDMBiLuzdQWRwb0Skx+e1OMSb6PTtu8zcE7ihOfdxO7Erc8TWCY7BYL8xY7mSuGyXYa2ZSB6SKqBWvChzxvQjSUnJCD9NFCx3RDTVOkchJpxrAJZjQgg1OCuEoRWzdEnqdnhQ4Uoj7fbycA65FyNg7lceaoz/tk0g6A4GeVpkAF0ojNarb8ZtWojJdcYwL1PLnw9ejbeAzntMi/WjSQxtMLazzGrHLknZ/smREy+5CiKKwP6D1AVC4KjHtTc+vk87+3tS/v5dtawZjMjZQ6pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RgsHf/YpKc0Hv3o9ATKUkGxUMdr0KL8OEuFeFN427E=;
 b=MbOXtndfyZAEjD3LkxYR1MQUt+F8sMWehJI6lITk3EQgkrN9t+2tutJ9tIujysOKF+0sFYUXk7a06lm3fYJSUA5bB9W3jtEZgPqzjOSslDJUPUUdkK5DyiRmTIXfkY6GfkCOblUAfyhIxXYvdgswfgwNbM4/omKlNVzoUSFKRSRCCYKxZbbcWC/xqFpHVMV2mvw/dgiHbwM83r5fIWDAvzcQ8O/MSyqnkkPTFtQkMfxGCiLR47DIBSxMSeuV4ETBG7yVB6cln7HIMPMGCPmj4IBKrnA6EHUVx2g96hW8yiHn62RK0bGdERHGEV49LwMdFWiYjlE2oA+YMtFs7u6l8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RgsHf/YpKc0Hv3o9ATKUkGxUMdr0KL8OEuFeFN427E=;
 b=Aaqa9HEqyDxr4RNDlczDPXoyL3p/vCDwicxA6eOgxFK+bSU2kAfuKabetX8o2HaHNQr47FB65QXn0qK+RAuCiqWzWpWq9PNTJ+m4Jj6DxoxDpZrs76PSuvxWy02yqgcDxVu7dbg87HAa7CXSgTEMo7XfVkA/Po5xBHGkTOl/lTc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 by DB9PR08MB9850.eurprd08.prod.outlook.com (2603:10a6:10:45d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Mon, 20 Jan
 2025 12:59:08 +0000
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42]) by AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 12:59:08 +0000
Message-ID: <ba4b0ad4-e8ad-4420-be10-520efeba0c84@genexis.eu>
Date: Mon, 20 Jan 2025 13:59:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: serial: 8250: Add Airoha compatibles
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 ansuelsmth@gmail.com, lorenzo@kernel.org, krzk+dt@kernel.org,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20250119130105.2833517-1-benjamin.larsson@genexis.eu>
 <20250119130105.2833517-2-benjamin.larsson@genexis.eu>
 <20250120-flashy-nice-tody-afa2ae@krzk-bin>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <20250120-flashy-nice-tody-afa2ae@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF00014AE6.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::30e) To AM6PR08MB4215.eurprd08.prod.outlook.com
 (2603:10a6:20b:90::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:EE_|DB9PR08MB9850:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e87f1a-2124-4e8d-ca19-08dd39523a5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjZHUlE0VkxzUEk1UWNmeHJxRitOMGgrb1FhR25DNVBRdjhOeUY4a2lxUWlP?=
 =?utf-8?B?Q1ZZb2RIaFBTb2JkWDVKNDR2QW1LN01lT0xHTnZzazdZTmN2eElpNmg1RExK?=
 =?utf-8?B?TmtaU2RLRnhxTzVpaERhUGE1aWYzTkxLK2dHQkZCOTNNaEJQQm1YY2hEME5V?=
 =?utf-8?B?TktKZXhmbitpYjdxdnZKUFpXOWFmNGpwTXVaWCtLWmFqbW1Tbzh4aHNFdmR6?=
 =?utf-8?B?MVhORm5RRUxnTGRyaW5MbVhZTFgyOGpLalhVeWJUTVBmejJGcndZdmhKcDI2?=
 =?utf-8?B?ell2WTdQUDBmOXpvWG5VcmRQeHFGTDNkTmdJSTU2TTNadlNibEVUeE5vMW4w?=
 =?utf-8?B?RmdacFZLbXdXd2JyK1lIWFRPVStFQjk0TzRVUTRhaTF6QkFtZ2RYd25ScFpr?=
 =?utf-8?B?Q3NVM0NQdE9UQS9aZUJPWEpsWjlWVnFNeG9ySzdlQm52TGxsQVozdnhqb3c2?=
 =?utf-8?B?NEZqTklMUUVoVTFldGlqTC9pMGR3RDd3RGxhRkNjeDVwQUNDZjgyZFpoRUV3?=
 =?utf-8?B?VnZyVXZMOWZVUStFYmFzSVY4QWJwUTUzbDJjcHA2ZHVKWCtXRDdGdXl0Z3NW?=
 =?utf-8?B?aUVXR2xmeVRvZ01DTVJveERWbWU4UG5melBzdlVsQ29UQ1ExanhwSDdDQllZ?=
 =?utf-8?B?UzE1dTU0Z3IwWmRWWVJZMDN6TUZpMWYySFdlVjdoYXlReG96SS9KVkRtN2lo?=
 =?utf-8?B?REZpOVhkQWgvbHRPM1BpZmNBZHdPNFlBQldLeHdwdnFadnhOS2tjeERWZkE5?=
 =?utf-8?B?WmlpVVpINTc5RDV3M3huZlQ4R0RDUmhlSGRsQ3g4OHMrRmR3Nml3VVh5UTh2?=
 =?utf-8?B?Tnh0TWREOUR4a2pyUlBFSXJZZEYyZjh4TEdWQlk3V2cxNmZFZmMrL0ZqYmp3?=
 =?utf-8?B?OTRQUnpoMkg3TnU4R1EvdHZzc3lFVTBxV0p6WWhkVzUwNUhEVUFjRC8wNm9q?=
 =?utf-8?B?Uk4yVlZEQldhN1RUbjdqZ2I0RFZWeXI0SS9KeVR3UmxKbkZ0dWxzVDBrNGFy?=
 =?utf-8?B?STFmUXFrNkZqa1cycGxZNk9jM0xEbUgxcklJN0RVNFlyTEw1U2RGR0UxRTJh?=
 =?utf-8?B?Wk9wclowS0piVkUyTHR0TVJlR3J4RUNqWFpqb2VueEQ5SnpKLzFSNlh6bDJH?=
 =?utf-8?B?SHIxRjhMSlh4MU9FSFlDdkhkN1RIZzAwdDJzQ2tRa2VxUnd4SWN6VkQvRmEy?=
 =?utf-8?B?cUZNcW5IdlJVWG1lT0VGVEdvaHJLZ2lJa0lPOGJqSG16N3Q5VDY5dkVQU1BF?=
 =?utf-8?B?cUUyUFZEakFYbWUvaDdDWC94cDkzWXhta3RQeGNGYTNjQ0xSSHEwUWt3UFF6?=
 =?utf-8?B?TVhXVFB0ZmRUT2g1K2ljSU5yS3ZNZlE4bDFtaEE4QU5SMWZaQWhPbUpvRE45?=
 =?utf-8?B?cHFENVBaUmtneHdoUUs2R1dCcWcxRGxSa29SeWRlSGhteUJpeWpUK0t1dk5h?=
 =?utf-8?B?ZUlmZWVCWHRKakU3OWlZVTVVUFR1dmgvWVd5L1hjWk1uQWh5QVNjaTY0cDF4?=
 =?utf-8?B?a3FmRzhkR09TanhWaEpGUmpvb0VBeTk4a2x1bi9iSXhCTi8xTEM5OEx0RG1N?=
 =?utf-8?B?MS9XZ0tkRUVYRjRHNFEvV2V0MEVrWWUyV1hDaGY0SEE1WUZOa21QRFhmMnEx?=
 =?utf-8?B?S0pxZVR5RnRXUzI3ZnpTcmJZUUN4cmNRZGNxUklPRXFhdnkrYWM0ZHVmNFEr?=
 =?utf-8?B?ekN5YmdIMXRkR0JEa1ZRWVB5VjFyRUhsSk9iTDRqdUtzOXF2d3lPRGlQSmY1?=
 =?utf-8?B?NGlvUFhCckRILzU1SFJYVU1yV3JISk5TOWFtVGV0ZDYvSjB5YUtXd1FtQ1N5?=
 =?utf-8?B?NzdwaTJleEFhbzROUW5Xa29kOThyeU5VOGNPTUdFdlhxaGVLR3pQRlFqT0lv?=
 =?utf-8?Q?07OxVPo4K60mA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4215.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXVKWFJkNi9xRENJbmhkZXlpenNRdnBqYlBVQ2NlaUlzblB1YWRZRnVLNUFC?=
 =?utf-8?B?OUFBUW5YbnJSMUg3ZDlEL01TaDJRSnJ0WDBkem84QVI3NEtITVgvMk9TUjFN?=
 =?utf-8?B?alE2d3dXakRsVkdWbjlWUXJneFFCQUpja2FPeVJMUHJzMStDU0Q1K3R3UHVv?=
 =?utf-8?B?RW9KZGhWNmNqWndiNmM3S0hRVFo1ZmcraWg2V0NKdVUzNk9jc2Vuc1dLeDlV?=
 =?utf-8?B?QzZ1Snc2UFJTRUwwNlNQb0pjdW1sNlVhQ0lINTVKZ0ZmYkVzM1p1c01uYkpO?=
 =?utf-8?B?UGp3bUY2VVJsZ2k1QmNxYy83QUx1VkpBOWxZS2NZM0NRSEg4bUlUUEFkSHZV?=
 =?utf-8?B?QzdOc0NSanRZbzhVSG9uWExONFVFbzVZLy9EdCtvQ3M4YkhDdVFZdFBRWkVS?=
 =?utf-8?B?WkNBdHJBUDB0L0VVcnZhMlovRU4ycGtNbDNFM2ZYeFRDdDJmandoSGgvODla?=
 =?utf-8?B?ZFdOQ0dYQlJxWVFUbTNkdUlWM2c1Qi9neXJsdStVenBLRkl1VndBZmxSQ1NR?=
 =?utf-8?B?Z3JMVGpya3hwWUhXTzlDdjd3Y3hYMGk4YnN5djlrYURqRFZTc0JUcWw5ay9E?=
 =?utf-8?B?S3JvNGc5N2g1WGE4Yy8yMUQ3aHIyTkhsUWQ2YkdSS0VRL2hzUi94dVhXcXZj?=
 =?utf-8?B?aUVHS2FHdXNlVUt0MG1Mcmo4V0ZZeU9UcGVFc1lDMWdQNWt3Uy9wR3oydmpY?=
 =?utf-8?B?N0RxZjlJLzZnNnhueFN4OVVsYlVOc0dNOEYzS2lYRmlCdjRNR01yRE9hREYv?=
 =?utf-8?B?empQZmMrRFhEaG9CWnJKM200MGxRRkkxemFndnhQZnVFWTFldlBuWmF2a2VQ?=
 =?utf-8?B?Sjg5ZkpEQnNkVUVpS0RvWW5HU2RiQjgraGRLOVNhVmFxTE5OdHd1bTdmZUl3?=
 =?utf-8?B?UElvR1ZwMkxYdWlBWGErNkUzNXlsUFk4MUdhRGFRYVU5TDYyUnRpV09vUXhR?=
 =?utf-8?B?dVZqeUoxTkNEZXZ0Z00vL05Yd2NOQTNZczVQTmhkaDBtNldtSFd0aU1WWXQv?=
 =?utf-8?B?bkUyWlBXMW4zZzZXR0pPVFZ5QkE5dVVua20xYkNPaUg2UkVHQnF0VTRSU2dm?=
 =?utf-8?B?SS9mUFB4WnJ4V0dsdUUzZFM3Sy9ObEpMSXRLam12ZGNPRHM5bWs1UndOQ3Zo?=
 =?utf-8?B?MVlMU0FSR2NnZ0pzR05IWnhpYkJhMnhHK1VSdE5JS2g0dUlabTBieU5jakl2?=
 =?utf-8?B?QmxhbjZHdlhwellUMkV0Zk52MkZXWUEvZUhUQ0JGd0Q2NUx0Znl4Qm9obUF3?=
 =?utf-8?B?MVIrTmMzMHY3UzVxZDNxbHBuWDhwYXFqRjBqTlJscUl1akRoc3JnNHNYd2JL?=
 =?utf-8?B?U0ozaVY5dHgwVk9ydlNCemlsSXNTOVk0SEpjUWhJbjZtK1hHSkM2YTZPSTlz?=
 =?utf-8?B?SHFMQnlvL1dFakZnSUtIeUpIWHVpdHJob2J1dHY4d3Rac25Vb252eGlPcURK?=
 =?utf-8?B?dkhLejV4ejN6T1duQ1ZSNnhPNEgvc1lDSW5mTGhNVTFUN1E1RUVySlpqK01H?=
 =?utf-8?B?UlhlT0RkSzlWWUdDckxWcUJ3bTZKamtGL29IV1dpdFBtQ0lXcE13VjJZZE9Y?=
 =?utf-8?B?Mml1ZTdGVndTZCtyS2tPcHdMT0l0bnNMNTFwTUNKOWpudElwWWZaRHVyWTc2?=
 =?utf-8?B?RTF0bGE5dE5jTUsxOFJPNjZ4elhMbWtGdFZIWGZ1Y0gwSzdWL2M2TDZFZTFG?=
 =?utf-8?B?L0cvWFlFRHZET0hUaG9hNnZXRVdPdldYTmdhNjV1Z2Q2TVRiN0lWa1BuOEV4?=
 =?utf-8?B?WUxOVGJzV1Z2NU1iWS96dVN6TncyNWdUSWk3QktDUGpBak8wVWNHWDM2MnQ4?=
 =?utf-8?B?Tlk1WW5lVEhySjhHVDFhNHUxa0J2S2JQNVpxNU53NlNDZXNURi9TOEpublFT?=
 =?utf-8?B?SWQvTFBNSVc3aDJ0SW43d2ttTEZNOXRhcVBpSW82SWFBODloRjlwTzlkZThn?=
 =?utf-8?B?UDU5UGlpRmZlWmdUTk96bjE0b1dSdkl2Nnd5VXBjRDdqR2J4UnIvVno0UEtL?=
 =?utf-8?B?RmxoVXl1RWgwR1NXZ2NPL05qNEU1eloxblU2ZkY5SjdJYzNqQW5JMExIdUFz?=
 =?utf-8?B?NmlxbC9vU0ZKTGVzWmZzVWEzRUxYK1FNTnNqUlZtZzRpaWEyMlZiM0pBYmYy?=
 =?utf-8?B?UGlQc01IUC9MME5VdTJLb2N4ZmRoSENJRzFsVUdORjdlWDY5eGpVUWt1eWdB?=
 =?utf-8?B?UVFnM0tiUUppdnFVdkkyQ05hUWNDTnRLOTBTUFJZQkx5eUQxdU9XY1d6ZlNl?=
 =?utf-8?B?RFVtY3FFQW83TG5IM0RVTjRQWTR3PT0=?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e87f1a-2124-4e8d-ca19-08dd39523a5a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4215.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2025 12:59:08.7233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afWg8wg0ZGypl1iISXw8Sjh1z4mH5R6DhUcYmTgIjM3ho3MZXhLvedZWvFispdWZZX8Kv+7Ggo/dOtxKCl2pM43E1+dW2EjBHPeqfPI1Lj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9850

On 2025-01-20 08:57, Krzysztof Kozlowski wrote:
> On Sun, Jan 19, 2025 at 02:01:04PM +0100, Benjamin Larsson wrote:
>> The Airoha SoC family have a mostly 16550-compatible UART
>> and High-Speed UART hardware with the exception of custom
>> baud rate settings register.
>>
>> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
>> ---
>>   Documentation/devicetree/bindings/serial/8250.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
>> index 692aa05500fd..2fbb972e5460 100644
>> --- a/Documentation/devicetree/bindings/serial/8250.yaml
>> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
>> @@ -63,6 +63,8 @@ properties:
>>         - const: mrvl,pxa-uart
>>         - const: nuvoton,wpcm450-uart
>>         - const: nuvoton,npcm750-uart
>> +      - const: airoha,airoha-uart
>> +      - const: airoha,airoha-hsuart
> I assume you placed it matching existing order (kind of alphabetical for
> compatibles with vendors)?
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>
Hi, I placed it after nuvoton that was the most recent addition to the 
serial8250_config uart_config[] table that was also added to the 
8250.yaml binding. IIRC I noted that there was no clear order in the 
binding list. So the placement could be considered as random. If another 
place is better I can move it for the next version of the patch.

MvH

Benjamin Larsson

