Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023110.outbound.protection.outlook.com [40.107.162.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA1184E07;
	Fri,  5 Sep 2025 05:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757049086; cv=fail; b=k36qkttcwWNzPMhDGAhLMFoAqzqgRzJyVlVEMh1WwKQumvSbtlFY0TByiEvGTSleOte2KE9VcSnjPCHv9kyNCROSXIVDHqjuU9zeQeAnZs3kx79hWw5ZHKeaGDGCsVjsv2GNXcQtUcPVE2P7yOrYJjHB6PVjYddiTQz4TCpBNNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757049086; c=relaxed/simple;
	bh=Rer118UZK4rGpeNFBigkWG9R3OrPj6WcA3vAq+j7Jbc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RUkxMD0iIts/lm4v893M8zh4eB4OM3OsTE8GkHi2+kXRIKpVTgNXTVAVc2YqYXsBMRf5dVUCc5PPU48xEnz0wNirogB/H/gltGZcc5+OwNPl72YWjTKersgGiCIdjtdSGjw1RbAx0Ugtzb7TeJhAtJsBmRnEccwScuT9ujYOTLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=ceLIZiT4; arc=fail smtp.client-ip=40.107.162.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="ceLIZiT4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dcxb07vmAuYwYEls9htDGfkP64LGEteGdqouQ8DYoQ9psO7hIJzgLjnKbLeICtYokp5w+Ld+NWRiE/gkweOe91BtmTNn8PjTPXy9m9eepdQLDJpQSuADxqQYzyIlkh1t8H1fg1UP2jrItbwIU6cnIqkKjdkK1c882CVgf7EEhZ1zyOeRPpQSZjRQR5FhIlIX8uLUGuQV6qWOcj5IobImnT8gDIvtOLL8CwUQZXpjIhlf7xp5lJQeSHWCB7UpzELIxdpHqKodU/wDhjeO0JB3z4xvLVW+Od2gycpYovq5m/B8dj2gkgDfni4tp8nP55Ge2xnlE/7pgszL/3fL+spwmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUT27HElFM6+wFcFJH7K9gvnKau6bnyzfA0jJKc6rZc=;
 b=LmC43qyQ1vQD4kGvPQQhilT1OzYlv3EAIvUI352HVx8jrpi1MnvteNyfteqTDMNedrYddppBaKSOYXw77G3qVbv5luOeY1+dV8+PeqG+Ulv58dd4xLGrhgnIsBU5QCEJ2Di8bWcmGWwRNxa61ky6swOgTt5QJ1LpFTUMpXV/r2Y7d7KFD7wWqMGDeoD1eT6cI1IE4qdgsm4tDejss/OWOAvhHCBGKw0W9oCRnULHbTwW3sRgeNTOc37lEpvXrS8TZv1WjMkz/SiE8ZSXyUtz1WWCe3lE7KY7Q9JIyWuvJXvdeLX5ESXGmychcYAuD3z1Dw5MXZOBB8vBF8PfddM4uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUT27HElFM6+wFcFJH7K9gvnKau6bnyzfA0jJKc6rZc=;
 b=ceLIZiT4YEvJ9px1EEgBDkc+8u/XeJZ39kzIC7ZeCCQJQ8jFTcDNP/xxrg/JOl88PxZwPDgk3TKX4kJx4Lb/bLkkOe71+rbzOlQkqigk2ADV8Wa8f9e+rT2Yu94lU5/A8Xvv2qLJC3KwL6oyXplk77cXhvTBxzka8MhkhJUARt+b1/xKP0aeV1kSl8Rq5JttLEs+Ufe1BOKeGNpbhPEHL07LCho1Se7fJOE2spVPZDV+697DQeYRqGM/TZ4sFnq1yKSl9EPK8rZ3kKPvnp59smxhodfOa9neTKhAAsiqe7av+rQtQca6/Wnw+XxyAiaDPP11Ggze+eXHTPKC8amj8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by VE1PR06MB6909.eurprd06.prod.outlook.com (2603:10a6:800:1b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 05:11:15 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::f8cf:8122:6cad:4cf7]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::f8cf:8122:6cad:4cf7%5]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 05:11:15 +0000
Message-ID: <8bdd7f5f-971c-4d62-8fad-b790ba756d5d@vaisala.com>
Date: Fri, 5 Sep 2025 08:11:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: max310x: improve interrupt handling
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Shiyan <shc_work@mail.ru>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20250903-master-max310x-improve-interrupt-handling-v1-1-bfb44829e760@vaisala.com>
 <214edb7a-2631-4f7f-9516-a38a3796cc0b@kernel.org>
 <e88f3c74-2ea0-4266-b5f7-62b87a1987c5@vaisala.com>
 <20250904123642.c8dd7bd6bf693ccbb5f6989b@hugovil.com>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <20250904123642.c8dd7bd6bf693ccbb5f6989b@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV2PEPF00006627.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3cd) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|VE1PR06MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ca031e3-01b4-4957-cb02-08ddec3aa36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFRDQVpjRmJvRktJSkluZGZYTjRnajhKbDlVdy9jN3BwNDNtdXRFRlVFdFlq?=
 =?utf-8?B?b2NnQ0lyY1Bxb1ZVWHpucWR5R3JzZTNqTHR6TjRLRGdpa1VxUjJZSUpDUjB2?=
 =?utf-8?B?T1FLZWVyd3BDZnFEcUl3YnUrYnFMWGFmYzdURmRPeUZTYWwvbHdZdnVJV1lh?=
 =?utf-8?B?Z2ovR3RvODVNRDV5UTdncnFacWhjT29MRlBGU2hxZXM5ckNRVzdncHQ0U09H?=
 =?utf-8?B?WkV2NXRndVNOY00xRCtHSFYvZTl4VjZLYzhET1VuWmRoMmg0UWQ3Y25tcXBL?=
 =?utf-8?B?eWpRbU02aFdBc25mQXNBSUFERTBWRmpjREViazBabjYveGZWT1NodjdwUDBn?=
 =?utf-8?B?M0tJcUxXVDNQRnpucjZ6UnRUZFlwZ01paG4xSjljQmhaTFlQcHFVVS9uQWha?=
 =?utf-8?B?OER2RVk4a3JPZjNqcUNNSUVzaTN3SW84bC9ZbFBxeGlIRis0UlY3SzVSUVdF?=
 =?utf-8?B?MnRuZUloeXp1NXJqeVZnSEFTNUNLTFB3TytvUEd4YjhFV2VydUd6T3ZkT0tP?=
 =?utf-8?B?aHNWbVFaSGVqYzJ2eWVQWkVqRGZkWUtZY250bGpnOHYvY1pmK1hublNCcThV?=
 =?utf-8?B?aktvbW9zNjJFRTQrQ2hhMXBHTm8zRHBwdzl6aGg3b3k1ZGRFaWtNQUFFSEdp?=
 =?utf-8?B?WG5SVWx3c2cvWEFvUHRVTG9FZEdvY0x4YkxEY0tncUo2Z0dmVGJ2VEpUS3p4?=
 =?utf-8?B?YXdkR3Z3Z0J5MTl2bFBXK215SDkrWXppSmpiRUdjOTRFK2N6OHFYbmN6dmtk?=
 =?utf-8?B?RTQrUSt2bW93a0ZQcGwvc2pLQkd6U1FJVTJ6Skt4cnhrV1Z1cXdJVU5NVmN0?=
 =?utf-8?B?OW02ek9ib2RmditkYml2cGRXRXFCaEZsaG5sV1luNDJ4RE9UMm9EbFJGbGkr?=
 =?utf-8?B?Y3ZOckVaYTE3THhNSzN5VjVZb3R1VkY2YVMwOU50S3lzS3JPdkx1VThyVjRh?=
 =?utf-8?B?NVRjaHB1U3ljZUNpYmNodXlINUx5TXM0VEJhY2tzR3FOMXF6dEpuRWo0UmJz?=
 =?utf-8?B?N1BPN0FoRTQrS1gxNFp3U0VkMzdjWGpzRHpvaXF0UnZJa3Y0ZHpSOU5CaXFj?=
 =?utf-8?B?MG41bHJxYmtuYTNiUk8wenRxSDBFWlJQQVd1QTg2OFBPTzFBZFJXRGhyNUt1?=
 =?utf-8?B?ckNlRk5DTWo4SFBEdGd2WUtNZ2VYRll5dzhIVWtpbDVEem9HYjIvWnk3MFhS?=
 =?utf-8?B?OU1tQjU2SXlyUm1jdkJNdEp1ZVRNVEJUTWxPanA3anh4bTlCMDVTK0FCQTVv?=
 =?utf-8?B?d1BGSXp6YllJaFV6Q3VERGltV3hhMzUxZmJjRUxSMTZEb3lhS0I3S0h3ZFlN?=
 =?utf-8?B?eHZSbS9rRm4rV3FEVHY5RTFFclBCSXVDdVFwOWgycTZrN3pjVTdkVkp1Vm1F?=
 =?utf-8?B?QlhzT3pFaG5rZHkydUk1RDFHNm43WkpwaGxWbmZ4dmgvc3BGWlZhc2ZZRFlN?=
 =?utf-8?B?RkgyeXM5TnJHWVMwK21sVnpTVFFVMUwwQTc0bkNBWGhITkNMbUpHZzRmaGc1?=
 =?utf-8?B?MHgzMkF1eC9kdmtOdlNxbWFiZkUvVFFwZnRSUlZidDBSeVJCVUN4b0N3cXdO?=
 =?utf-8?B?em1MRFh6dGRzeDkvMUJkZGNBcktNUmJ3L2l0VUlueHFNYzZ5eUZKWW52L2R3?=
 =?utf-8?B?dk1YR3FzdmtId2dLK0s3T01SRExaL2djWHh5cU12L0YzUU5NSTdkRGdlZEdR?=
 =?utf-8?B?a3dUc0F6QTVXaFduWDQzR05kRjNPK1BUdXhKUU1OMkpmYUVMV0VwVmhFTG9h?=
 =?utf-8?B?aDB5SVVaNFpaVVJVMEhidVlaS1RJdWpKQjdsZTF4RVkvYStBSkFuTVVRV0ZW?=
 =?utf-8?B?UGtrR3J4WFd4enhzNjdMbmtKYUlzWDhITDFKb0g4WDhxOE45a2lCd2JFa3Js?=
 =?utf-8?B?OEdrTHN3blJXZ1pzYXVUWTFjZVlTd2c1bzBXRHZCSVpjYWNLeno0Tkp4TlVT?=
 =?utf-8?Q?mvRyoVFA4fA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0tpQ0o0eWw3dnQ5cHhkOWxGR3BRTmxXbCtHNkY0aXUvYko3Y1FqTEdtWnA1?=
 =?utf-8?B?K3RyeWFNbWh1VFVVRjFJZFB4STVIQmhYbFpHMThCZWFEOUd6dldLS1FDQ0Y3?=
 =?utf-8?B?TklIM0FnbVF2OHZIdVg4cm90ZEhmSHpzbkFWdllDZkVSdGFra2ZBNzJIYjk2?=
 =?utf-8?B?UjRXS0ZYS0M2RU10VVlvNW81U2UxbVk0anZFaFMwdmhqVy85cDJnMDlGWTB5?=
 =?utf-8?B?QldndndKQktIZGVwNzk3VzdGMy9BRFgvZE15M3p0MTJGa3o3WEVFZWZNM3Bz?=
 =?utf-8?B?YTFqcG1sMitNY1c4ZGRqVjNsUytGVjVwamtxa2Q4UmtXVjZmSkFBMkxTc0p3?=
 =?utf-8?B?ZE91Q2o3T2JBUnJXczE5SE92azV5d1RVcmVDcXp3RmpJNTdXOG0wWWpVWkY4?=
 =?utf-8?B?OTN6Ukw2TUJLU2lBUGFNeUV5ODNJMGE5bWsyVHFDaS9aSWpJbldFazk5cTlp?=
 =?utf-8?B?dm00K0RGZlJxVGxLSm5aNlRYbldsRTdOSm9yQVQ3WXpDb0JocFhJTWIwTGlQ?=
 =?utf-8?B?Smd2MjNVQ0V0RnJJUlFKdXIwcHZWeHAxRklUQ1RjS0E2am1EcDhkcGZ0RFdx?=
 =?utf-8?B?TmE1TWl6Qkw2LzFJZFlXSVpiQ3RZbTFVSWFrZHd6azdlcjIvcGV6YXpIZ0xj?=
 =?utf-8?B?RnFoZUlENUdzOHRzaTA4am1GaGVURzFiVFVzWm9pbVRWZXFMYVhJQ3poMEl0?=
 =?utf-8?B?U3RWekxzVzFUY3A0cTRsbzZqTlk3QzBsN2JhcVJLUDBqSURKWEdENmhxM2J5?=
 =?utf-8?B?RGpweTNCQ09CZTFBY0RGVjRGdFVBS2FjeFpmMW9pTXQ5bWJYV0J3TlpFbmVJ?=
 =?utf-8?B?VVg4T2czU3U3VkwxenpDOTU2STZZaGZ0RTZtMHlpclQyWVFuWENJek5QcVV5?=
 =?utf-8?B?OFcxRjlJOU9ZSWp2bTYwd0pYRGMwdmx2YzdhamFCaUlvUVllOTNkWU9yV0xs?=
 =?utf-8?B?a2wwRnoyZ2NMbXZ2TWFCaThCbmd0ZHM0UnBWQS9oVmx2SURHWE1XeTJrMHRw?=
 =?utf-8?B?TmpPemQ2UExZOXFqNldXUjBZblMyczRoUXpUSlA5akY3VkI1UU1YL3RzQ3di?=
 =?utf-8?B?T1VQWlBiYVRKVnpaMTBTY1BCTmVsQnYwUm1uVWtNUTlDQmFEdmxWclhLaXdv?=
 =?utf-8?B?blZOUkFNTE1GOWlPMFJkQ3B0TXUxWTkvZzh3QUU0TUI3TFQzU1dsRjlaZGNh?=
 =?utf-8?B?eVhaU01Pd3B3UUw4UklSQWRsdk92a1FwNkFzSW5GWVA5MWREcmNvT05KV3Fz?=
 =?utf-8?B?eml3dUVLWHI2R1FQczRFV1cxUWZrS21HTStIcmZYU1BFaHQ1MXRxM0xBZDVS?=
 =?utf-8?B?S0w0ZDBSRURxenJONDgyR2xtUkNQWS9rSmVOUzhzTlBvMjJrUGdnV3hmMjVB?=
 =?utf-8?B?ME15RDJLQXJLUUJjQ0JJN2tZQ2hBT3QxK05aREpuUDdIbkZNSkIzcXBWSFds?=
 =?utf-8?B?UHJSNjJIKzNhdlVLK3dQTU1yc3Eyc29mRnVpd1N6OWZaZjVHMDV5WUNxRDl5?=
 =?utf-8?B?U1JqeTNOQUVxNTFFWlVZdXQ3NVRBb2JQZkd1VkVsY2xOZHNaVThrWk9ZWmlh?=
 =?utf-8?B?SWtFczFWUU1yS2wvaGhxakRxSzZRZnlkWFhkUWNqUTZEWHp4bnlOOXUrK0lC?=
 =?utf-8?B?a3F3TmQvL0VaampUWEloQVNOL0F4UFBaakgzNkp5OHFYYUQ0SVlGUUdQSG5G?=
 =?utf-8?B?WFc1NUpkMGhMNW03OWQxZThJRkhBQTduMGg2dkpRZUJxQVVpbjlMT0pWc3NT?=
 =?utf-8?B?WkRnVC9WY3lEM2M5RUZCMFFnUENNTVVZUkdlenprWDJEY3dIUWVSTDEyNmZl?=
 =?utf-8?B?V0N0OFlrcVdUSHEyT0JVMnZ3NldMaGZJRVF6TDdDU0ZkR21YYWJIemFSS2or?=
 =?utf-8?B?SU51Ly9CZ1BFS3Y3c3dPNUJ2RG04RERXWVUzQmdCOE5GTTR4N2ViMFpzL0pz?=
 =?utf-8?B?NGpxQTBTS0RqUEJrSW9UUkpibmUzb0ZYbmRxOVB0SkhySGJuQmJHRllSa00z?=
 =?utf-8?B?cXpNZXliSGY4emtwcyt3UmJjdFpmSjd4YjB2YjdlZ2xhZHNML3JMNm1tMG9J?=
 =?utf-8?B?VjZIZEp6aEMyWVdDNU9nN25vMmJoRUpaYVBYeVZ5YUVLQWFXNnJFUGJBNVpz?=
 =?utf-8?B?dGExakRoYUlVRnN6TDYrbllYazVjQk81WHA3VlZQQ3JudzA0RXY2NHRQT01r?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca031e3-01b4-4957-cb02-08ddec3aa36e
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 05:11:15.2140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xB/M1dzDFJ9GPYx/tbPJNuiiUjDpG9UlME6nh1soI6lU0UT8jNsplf+n9+CWVspC3//A25MAlXnCt/deJsHSN7dNx0me1knGzCZOKyUjkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR06MB6909

Hi,

On 9/4/25 19:36, Hugo Villeneuve wrote:
> Hi,
> 
> On Thu, 4 Sep 2025 14:50:16 +0300
> Tapio Reijonen <tapio.reijonen@vaisala.com> wrote:
> 
>> Hi,
>>
>> On 9/4/25 10:53, Jiri Slaby wrote:
>>> On 03. 09. 25, 11:23, Tapio Reijonen wrote:
>>>> When there is a heavy load of receiving characters to all
>>>> four UART's, the warning 'Hardware RX FIFO overrun' is
>>>> sometimes detected.
>>>> The current implementation always service first UART3 until
>>>> no more interrupt and then service another UARTs.
>>>>
>>>> This commit improve interrupt service routine to handle all
>>>> interrupt sources, e.g. UARTs when a global IRQ is detected.
>>>>
>>>> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
>>>> ---
>>>>    drivers/tty/serial/max310x.c | 21 ++++++++++++++++-----
>>>>    1 file changed, 16 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
>>>> index
>>>> ce260e9949c3c268e706b2615d6fc01adc21e49b..3234ed7c688ff423d25a007ed8b938b249ae0b82 100644
>>>> --- a/drivers/tty/serial/max310x.c
>>>> +++ b/drivers/tty/serial/max310x.c
>>>> @@ -824,15 +824,26 @@ static irqreturn_t max310x_ist(int irq, void
>>>> *dev_id)
>>>>        if (s->devtype->nr > 1) {
>>>>            do {
>>>> -            unsigned int val = ~0;
>>>> +            unsigned int val;
>>>> +            unsigned int global_irq = ~0;
>>>> +            int port;
>>>>                WARN_ON_ONCE(regmap_read(s->regmap,
>>>> -                         MAX310X_GLOBALIRQ_REG, &val));
>>>> -            val = ((1 << s->devtype->nr) - 1) & ~val;
>>>> +                MAX310X_GLOBALIRQ_REG, &global_irq));
>>>> +
>>>> +            val = ((1 << s->devtype->nr) - 1) & ~global_irq;
>>>
>>> This is horrid. Use GENMASK() (or BIT() below) instead. Likely, you want
>>> a local var storing the mask (the first part before the &).
>>>
>> val = GENMASK(s->devtype->nr - 1, 0) & ~global_irq;>>               if
>> (!val)
>>>>                    break;
>>>> -            if (max310x_port_irq(s, fls(val) - 1) == IRQ_HANDLED)
>>>> -                handled = true;
>>>> +
>>>> +            do {
>>>> +                port = fls(val) - 1;
>>>> +                if (max310x_port_irq(s, port) == IRQ_HANDLED)
>>>> +                    handled = true;
>>>> +
>>>> +                global_irq |= 1 << port;
>>>> +                val = ((1 << s->devtype->nr) - 1) & ~global_irq;
>>>> +            } while (val);
>>>
>>> Actually, does it have to be from the end? I am thinking of
>>> for_each_and_bit()...
>>>
>>>>            } while (1);
>>>>        } else {
>>>>            if (max310x_port_irq(s, 0) == IRQ_HANDLED)
> 
> Combining what I suggested earlier, with Jiri's comments but using
> for_each_clear_bit() allow to get rid of the original horrid mask:
> 

Thanks about suggested clear example. I'll test this in HW.

> ---
>          if (s->devtype->nr > 1) {
>                  do {
>                          unsigned int val = ~0;
> +                       unsigned long channel;
> +                       unsigned long irq;
> +                       bool read_reg_done = true;
>   
>                          WARN_ON_ONCE(regmap_read(s->regmap,
>                                                   MAX310X_GLOBALIRQ_REG, &val));
> -                       val = ((1 << s->devtype->nr) - 1) & ~val;
> -                       if (!val)
> +                       irq = val;
> +
> +                       for_each_clear_bit(channel, &irq, s->devtype->nr) {
> +                               read_reg_done = false;
> +
> +                               if (max310x_port_irq(s, channel) == IRQ_HANDLED)
> +                                       handled = true;
> +                       }
> +
> +                       if (read_reg_done)
>                                  break;
> -                       if (max310x_port_irq(s, fls(val) - 1) == IRQ_HANDLED)
> -                               handled = true;
>                  } while (1);
> ---
> 
> 
-- 
Many thanks,
Tapio Reijonen
