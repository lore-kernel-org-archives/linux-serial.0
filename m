Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013043.outbound.protection.outlook.com [52.101.67.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BB81A7AD6;
	Tue, 24 Sep 2024 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727189584; cv=fail; b=sXyjU+sG7GDYi1fBXrg4URvZu3GGrTsvEMfDPxOjEOyhZ+kn0RWpkqp4mS5OVYh4gkQm9PSr8+9z8H+uzoANqkRz75yMBpq/fwM/dXcGQkvkelKRcDC/3zmxd5+PyXb/dnR5I2pN/BNt6BC4kb5eA/JoWLE3E9J2oBiKkAwfeTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727189584; c=relaxed/simple;
	bh=/ur0A8LEMNMif7nxigKq1lmA/ibPproVJVXCfgrVl0o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vFczvBmzSIhrBAx/TO73uBR937d+oWaXPUjbzj1KzcKJ7QC0Gwn8Wi+wsqpxgrF8lWh1jQdQh3gN1gLUwrOFSNX2V5NUVwDjRBlSLE7TbLoJHVZtU5+Ra9h99n5X9s2zvMc/4mYsPAxsu70kV+h3pXE40TzRNMPMwSqlq1TNYj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=vefqnhs8; arc=fail smtp.client-ip=52.101.67.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vefqnhs8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/bDXVF9wMq7RqeaNm1syMEJaD89ZVsOucmSCMjjZCyKUxNUSkMFHBDs6Ohmf0alaxvxaekrlF4ZwzfPMmRSHAnbBceWvKutgPA132nxlwv0S2uVS0WPe2M28f4381Ki7gwQAyODzpi00BGXM4H3FFr54LidkXQSpoR1DRSjUj5EBwlE3+jVhq1zLhgz+GLTmx9YbidyyXEArAlva1Fp8Kfpofp/q+IFZWx2pHEj9ZlnlINSU6q7yAvH3Qkz+UNOUIQYdsNcJZG0Oq1yQbOq9UrbKKnGtgBAxRbEVQlSAgXhIVpbVE7Pg61h7T6xhzEiCtaMMvDVQPcR0DUx4oBOAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gn4GyvuPIhgl6gCL2uEK7+Ushe4sXGKav3qAKr7/yqk=;
 b=QA3JYsViYNc9fJNHpEaqBjZ9Kt4kzkOhTnMIMkkMNJhX092xR5MOXPUxaaRHy2YiEUEr0K+3inMf+XnYXzn+cfz/C6a/E8GNhFgCuh0ENSGU+SKk8+yjy/7toTj0D8KdWvFQK+pR+lVQuPEQBnWKwoSJThh+t5SnPWxdBC1G8X+51fZreSAkLMb4UQ8PkwJ717ogWBKql+TySaxZIzXaFZgLY+iKIBfGRg4oRV+44uhv16nDZFBS6IN3zSR152/Sj/zcwyXKmKh/j3aRQMq3LRdIc429c2FPtlwWKTcDEmobXdfWArx2fKPsVHeRx0RO8x0Y8XzG+BaR3DrooDbRIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gn4GyvuPIhgl6gCL2uEK7+Ushe4sXGKav3qAKr7/yqk=;
 b=vefqnhs8fLuWKBeVgcN7DZQ85Yy4DT/2hQfigLPziuDxwiW86yAqiptEJDtXss7h7fFCfMXRVcn7aYDuYWtWqJ6RFlaMSB7kvSqFkr6lmG6njlw22T6TPkvISorqeUkCq9CksZPb/l32a5cvVdiHmSbFq1qLrTlZO5EjjM9dDRFjXYt5FifwToBCStROJzBOiJUzRfSMlFHCCqfExqLHBPkNTC21UXPMG3VwoMF4ZPF5LEt+gpqakDmdRy9ZYvTOTDW3QGekOx28PJiH7lWNdTKz3hNfho6UbpgBVuMFArxcg1/oI1g2s1Zc9QSC/9TQDI0i7d5mWJtn4G+fwxmllQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com (2603:10a6:10:352::15)
 by AS8PR04MB7669.eurprd04.prod.outlook.com (2603:10a6:20b:29b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 14:52:54 +0000
Received: from DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd]) by DU0PR04MB9251.eurprd04.prod.outlook.com
 ([fe80::708f:69ee:15df:6ebd%7]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 14:52:54 +0000
Message-ID: <b8024c74-f5d7-4b56-96ea-dee5d8dd9a98@oss.nxp.com>
Date: Tue, 24 Sep 2024 17:52:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: linflexuart: add clock definitions
To: Conor Dooley <conor@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chester Lin <chester62515@gmail.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org, NXP S32 Linux Team <s32@nxp.com>,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20240924141247.132455-1-ciprianmarian.costea@oss.nxp.com>
 <20240924141247.132455-2-ciprianmarian.costea@oss.nxp.com>
 <20240924-twitch-embody-0ffb3ab7fd26@spud>
Content-Language: en-US
From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20240924-twitch-embody-0ffb3ab7fd26@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P195CA0016.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::21) To DU0PR04MB9251.eurprd04.prod.outlook.com
 (2603:10a6:10:352::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9251:EE_|AS8PR04MB7669:EE_
X-MS-Office365-Filtering-Correlation-Id: e0cae846-a1fe-4a32-2791-08dcdca891bd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0UyZjJrT0hGazIxek5qQ2c5eWRNdThnejdDa2JqdG0yUXN0anlaVW1TbUdz?=
 =?utf-8?B?OXBLamxMYjBuMGVDd3FaQU15UGVoN3dNZ0dmL0VuT2F3cTFLZG00ZU1JNlhi?=
 =?utf-8?B?ZFdvS2RFR1RpTWg1bE5iT005SmhXWUFrT2RsUy9hbWY3VmVzVlBaekZIT3dk?=
 =?utf-8?B?SGhuSlF2SHlmL3BsaUpKMEJUdFVET3cxUzFpNzl5NithSGhVMlpFWmJNcHFl?=
 =?utf-8?B?ei96U2FJS1FOdEtwWXpDVTI0Q3B2NHZnRXFHZGFaVmJFTnB3aVRDSGVyU1Fx?=
 =?utf-8?B?dHdUOXRxaEJlLzYyemJ4WGk2RDUwTFdqQi9TRWRMc0hHYzV5Y2J2TkxyWjl1?=
 =?utf-8?B?S2U5K0lDTENaMGs0UlRIQk0rMTAwWkxBZjhHR2NxWnh4ekppMHlxWjBsRGtk?=
 =?utf-8?B?Q0F5a1BaUDRYY3BEMUFtYWRwbE5jTFNmbloyN1plRVBEbGdTdFlaWFRuRTRL?=
 =?utf-8?B?NFAxYWFneDN2eFYyUFBBZUlvQmJTMHdzS2xlUmh6Q0Q5RVI5QlRNU01MTCtZ?=
 =?utf-8?B?ZXBkbUNCeXczN3hVakJRc3diR24yZDFRNStnamxKT1dTbnU2OTRvMXd1a2xs?=
 =?utf-8?B?S0JSNS9JOHpOVVBrS000d2FFalYyNXZvNGY5RloyU1dNRDJlY0s4SDFveWow?=
 =?utf-8?B?U29mMTZiOW9QT2tQQk03ZHpyNEllVCtYZ3hqWFVWK0ptcGZ6Szd1MmdhTmJI?=
 =?utf-8?B?TTJDSE9kMTNUbmg1Yi8yakFzRVh5cXgzQkxRbUJuOHQ1Sk9BSnNhNVBJSHpa?=
 =?utf-8?B?ZjRydk9RWlhHaUhTTVp5azdTN1N4eXBuTTluY2RWQ00xS1RZRitiY1BFOUg2?=
 =?utf-8?B?Nms5cStUdnVQZkdYWWg5ai9YV1ByRytmem55OHhnemVvSkVCRS8vVTViK0pw?=
 =?utf-8?B?Y08zUjR0ekk1TnB0QkQxQmpwQVZjeE1IcXZyNTVzVlVHMWU4VElrbEd2YUZp?=
 =?utf-8?B?NmQ0eHZyRWgyWmZ5Y1VRVnM5N2hQWC9wWUxNa3lSZ0VOUXhiOTRqa1RZNE9o?=
 =?utf-8?B?ZEVPcHEvdU5pejZxV1I5VUQvaWVqSWF6NUZHZ1pjNHExS0tkL0pSRk9LcHVC?=
 =?utf-8?B?YUUyR2dGNCsxT3BZZGRMciticUVmNDJkTlZxR1JiMWJwajhCeHFCNWFzVmNO?=
 =?utf-8?B?anh4Nk8wcVY5Zk9vQ0k5UVhNTkE5cERCZGhIenJ1SUcxMkxoM3hqbytDRkEy?=
 =?utf-8?B?Q0liR2J2ZzNFUHFVTGF6L1ZqS3p0RlVIRHZRQkVYbjJHdWVFNjBpRkxmbVBa?=
 =?utf-8?B?VU03TXAyeDA5OWl2LzZONlh1TTF2THlydEJudW50YThrd3RjQWEyN1dqV3pH?=
 =?utf-8?B?VkM3c2tjdGNGSFhBdE9IdmxINHFVemZaRVRoVFBrUnVzUFNwT2ZoZWhoc2lC?=
 =?utf-8?B?OUJvUEtVOUlxOHp0RHg2YzRPZVdnKzdHb1g0Ymt0SFVvaGdSTnpzNjhiQmow?=
 =?utf-8?B?LyszMFdvRnR0TXBqWk1iSzZvcVFoa2NvaGNFRjFxbTViWm9DWXRWcFAyUEVL?=
 =?utf-8?B?M0tueE0zMmFyWGtjR0NLbXFleVl5em5KdGNWR0ZKMThldkNPc0tFeDdNTUth?=
 =?utf-8?B?ODVMajhEOTFhVDlNcjV0ZGVxNUFwdE9oeUQ5K3pYa2pxazFCSUpOUWg0czlv?=
 =?utf-8?B?SUt0UERiQkttd3JaaFFLa3BId0d0YlZnVmdKWDNpZzFJcUxwckkxVVRWRGFL?=
 =?utf-8?B?Qjc1QkdOYW82ci9HZ1ROL25LbHBwQno0Szl1NWVhQkQyTVB1Z3pmdFdON3Yy?=
 =?utf-8?B?RVczVmFtY3JqVkFJalo2RVpkNlFwcGFtVnB3N0tlVVJvTmh0RktlV1k3Rlhm?=
 =?utf-8?B?dkFYSjRIaWthYTd2Z3dSZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9251.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OE5vWG5CQ0E5R3NNdldHRWpmWFl1R0tTZXdjSUlITTdobWFzL2VGaGs0YVly?=
 =?utf-8?B?SjlaL3NUUGxoanJLTGRjczZodERxMkVSVkZQeXBROFQ2RzMvRnp3VUhYbks2?=
 =?utf-8?B?WlpXNkk5MFk1WDRwb01OSWE1Y1V5OGpOZWhDY1B1UHFlMU9JWTIvQUl3SzhE?=
 =?utf-8?B?ZFFySUhFU1NoNmZpbWx0cFZkTSsvaDFBUktFTjgvbjhDMUhtdCtjbU54QlVx?=
 =?utf-8?B?UEZNNnBBSWl4ZVRXc2x1R3BJbnJyOTJUandrS0RDVW00d1k2ZDA1cVRwb0Fq?=
 =?utf-8?B?QTJEdWFFVTJNY0Zqd2JEaWdMdlpLdUFKNXh3dW1wVlFEZlVPSDNBdzd1RlVD?=
 =?utf-8?B?M0U3ejNrZUxVUFdqSTJlL0tGRzhLZ2RmSDR2clJEaGo2bzBrUERDVHhJRUs5?=
 =?utf-8?B?dXlkeFpTWHRBbmhueDRldjhTazZlSjA0WHlXcHlMamZ0UGpvNDFtTHVxMUI3?=
 =?utf-8?B?ZmJvWjVYUE4rSkljTFZmTDkyeVR6WWdmb1luMXJ1MjNXWnQyNmliSi9Md2xH?=
 =?utf-8?B?bXhkV09LTHBFZ1ZQTUMwTms5N2Zpc3c4WUFqbXVTbkFXc3dzM3hCZyt1WFFR?=
 =?utf-8?B?eklYdmp4a0tEOW9VYXJCWjBDUTBuUmpxU0oyRzVVUFFqdU1YN1RhQVg4Ykpz?=
 =?utf-8?B?ZjlDbS9PUGcrbEpvMTg0RDNIeEpXcmR1RnFpcWRSRnkwQ3dvSVFoR0V1ckJ3?=
 =?utf-8?B?cUQrenErWDZpVHpXbTU1cU9HM3ZlK0k0MldoT2tFZ3Iybm5USFZrc2Jncy9B?=
 =?utf-8?B?OURiWWZsb3djcVBxbzFHOWVJSVRuczhjSW93aFhaZUVlTUJQY1Vnd1pvbUdR?=
 =?utf-8?B?VmZmUHhaNGJtQ3Z3U2lNUFpnazRpZVYvRUI5MVcvN2Q2V1RtTFM1c292TFcz?=
 =?utf-8?B?ODR6bldISmwxYW9DazNMS082UjhYR0I2WE1XbDMvbDJoQ3RnR2VVUGpvSklh?=
 =?utf-8?B?VmhvQ28yRzdseEl4bWhtcHBMRkFPcVVsQ3hzdzlCVWdxMjA0UUY5c0h2K2JH?=
 =?utf-8?B?dytLcFFxb0Jsak5rSUtrUER6ZmVpV21kQUVkbjA0TEcrNDNiSkdSL0Y0ZElI?=
 =?utf-8?B?TDMxQlpycUdqYzc0YVNqNEtaUVAyUldPY1gvUUlNZmIvRzZCdkxhbkJQVXZR?=
 =?utf-8?B?eXVjays3MFBJeGM4dEcwZVdBNHdTNmF3ZjFDcGVwRTF0ZHEzZEZDUlJsdkdN?=
 =?utf-8?B?NUV0bjlhOE40cXdDNnU5aWZubkdrVGJCTHo4T2tjVVVSWlMvQWY5SThMc1ZW?=
 =?utf-8?B?NG8zdCtSdkoyTEFJSzg2L0VwRnJEbSt1VFpxMGw1YXpnMXZLbzJ0WWRjSHZ1?=
 =?utf-8?B?TDB5c2U1akdqYkhScnFKa2NKUnVmb0FySUtod1pZT2NFUjVGcG9xeHZlVmZ4?=
 =?utf-8?B?eGZ2T0l3bkgxVjBXejM3blY0MC92QUxyMWFoOFo2c3Qyb3RzcTBpMzNBdzF3?=
 =?utf-8?B?V0tGbERpdU1XWkpjamxyWFJqbU5MSXRVT1FOQXJaZXZtOFVoVUphOUtVdHlt?=
 =?utf-8?B?L2wzb254TmYxbFNyVDZHdFJuM1NFYzBaNVhoc0I1MXRHZkVhYnJPMklzUnFV?=
 =?utf-8?B?cUVtanRNcEJrT1padm94KzZxMFlRVWJzTU9SeDNEWXhzcmtnS1FWeFBTTEZZ?=
 =?utf-8?B?Q2wwRG93L0c3SXF4dklYYys2NjFENldDbERKSlpWRkhFcmVxYVdvSlhYRExR?=
 =?utf-8?B?bzNQSy92NE1YbjJtU3g1bC9QWGU5aVU4djI1cWVKVnNtKzJ0OUJldVl2VWtm?=
 =?utf-8?B?bUw1aVcyeHljcnZoYUpKRFZqWWszdlBYR08xVzhJMHl5MEM3ZHNLeHlESEpW?=
 =?utf-8?B?U29ueFRJNkFuWitrajFBa3pzeEN5VTZDN3hNazZpUGI3NUdHd1JXOFdYSS9Y?=
 =?utf-8?B?TUcvcmh5cXd1NjFUK3ZaQnlyT1QrUlZSUlUvcW96bFNoYzZVK1BKd2dqRnJa?=
 =?utf-8?B?eGozQzdHaXhGTGJWVzNXSUZNY284Wkh1YllDeXpBVGFKMDlualNlWFQ2Zm1r?=
 =?utf-8?B?K1psaWh1OEhDMXFZeVQ5RlBlb2lVUzhJRXlPbHdPZ1hUODZMYmpMMldmaDRU?=
 =?utf-8?B?U0J1MHp3QXpaWlNLOTJ0aUE3OE01eUpONE4wYVI5aEh3S0l6cGtreTRjUEkw?=
 =?utf-8?B?d2QyRmI2ZzlXN29MNERDd3B0NDZXd2ZpbzQvcEh4alM2WlZlNzhYK2FMdmZp?=
 =?utf-8?Q?bo12hEKRmYsAGNDC8rwXn1I=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cae846-a1fe-4a32-2791-08dcdca891bd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9251.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 14:52:54.0032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BH8U8gW9Y/00ivZdXHCoyskAU/QIWnvJKFtf4Gw9QelfoDCdr+PeR98edwwR5iHzf3vVbvAIG2ypq5sncVhU7Z2jF7PwqlQ03nTX/yS3R0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7669

On 9/24/2024 5:24 PM, Conor Dooley wrote:
> On Tue, Sep 24, 2024 at 05:12:46PM +0300, Ciprian Costea wrote:
>> From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>>
>> Add clock definitions for NXP LINFlexD UART bindings
>> and update the binding examples with S32G2 node.
>>
>> Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
>> ---
>>   .../bindings/serial/fsl,s32-linflexuart.yaml  | 21 +++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
>> index 4171f524a928..45fcab9e186d 100644
>> --- a/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
>> +++ b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
>> @@ -34,6 +34,14 @@ properties:
>>     interrupts:
>>       maxItems: 1
>>   
>> +  clocks:
>> +    maxItems: 2
>> +
>> +  clock-names:
>> +    items:
>> +      - const: ipg
>> +      - const: lin
> 
> Can all devices have 2 clocks, or just the s32g2?
> 

Hello Conor,

All devices (S32G2, S32G3 and S32V234) have 2 clocks for LINFlexD module.
They are: "lin" which is the frequency of the baud clock and "ipg" which 
drives the access to the LINFlexD iomapped registers.


Best Regards,
Ciprian

>> +
>>   required:
>>     - compatible
>>     - reg
>> @@ -48,3 +56,16 @@ examples:
>>           reg = <0x40053000 0x1000>;
>>           interrupts = <0 59 4>;
>>       };
>> +
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    serial@401c8000 {
>> +        compatible = "nxp,s32g2-linflexuart",
>> +                     "fsl,s32v234-linflexuart";
>> +        reg = <0x401c8000 0x3000>;
>> +        interrupts = <GIC_SPI 82 IRQ_TYPE_EDGE_RISING>;
>> +        clocks = <&clks 14>, <&clks 13>;
>> +        clock-names = "lin", "ipg";
>> +    };
>> -- 
>> 2.45.2
>>

