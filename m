Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341CB33A708;
	Fri, 16 Jan 2026 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577871; cv=fail; b=RpXW7GoS9mYRkuJfWDzMJC0XW1fSfuK6LQsEVlL2RnMhURrjJT2YxPstGt8O3l3fm43VViSy6cr8hN96czZND38oF326PnxNIG9I9i9tW2VTXfQAY2wy+IjeNK1EaGEG/6SfM6h96P1HSa3NtblAbr62VV3N/ezTOW0+YdzMnAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577871; c=relaxed/simple;
	bh=Xu8elWKh3lWc1Ls8gOuGvjC+KNpGYXV+teOW9h2ZCmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=otwi1cRPIvA7MVnZC26mXkYD/0ygUF+iOEplRNNJOslSTSEnSQt3F6QJ/FiwBthveoHKAurBagVR9Tpwt1GZY7dRptc2izKArq4w2ym7tYO7SKMBurTueluGjVh0WLC+wrSn3ZNfwbuMK/OSVszBphmLpQPEeYoovZx2p0yq5aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R8RXBt/r; arc=fail smtp.client-ip=52.101.85.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R8RXBt/r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ugz2whsil87GHPsK9NdWm6kGkJ2RroztZaqyuOCGstO6KGM8f1lK38svb2dBpP2++FLrcY3Oyt/kJKOyA5Ox2salmnMk6InX8Wkyju4YjGMW3/88tAuKb+++Kq8KQZOJeW5k7V1fIFGY/1NFNPPifbd4Zeb93JVE6wPok4I3S6Qrj2baySmfJtDKBkTeh/UEYvEGy1TpM9lc2LJs31bOsTLw2sv9nJOihd9ttonbpLH6WKTiYF2k4DMQX/1gM/XIUL1JQEUyQp+6SLgM5s9pJ4zlc5MBIjQzP1eC/UIS45GJHuWxdEv/MJ4fRevsKa7qJO7dNSsPw8W6625hzhYuOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/n0w7ccR0V45yzacRgOoDZiK8jBAitw90npZ7Q6IWEM=;
 b=GEGOuQIZQxXqI7d1GUH73ktUPe7lYUq2IbGrPmS2l/5X3ty1GGVYgjUcZQ3fmIkUrGncrSibk8TXWvWefEv5D/223dyXf3UPkvbJT0aTlYOagpCLFhGqffM0Ann3mUMy4FvHXapwWRrJWstzFkOM05JuKQuFCjyNTEFGcwZ3zJISEbqznn3CPB/zOxWREtJEjgEpVJIdj0/6Kd54E6SBwr2LspOmKCmcgPIvAl6iroxltAZpSfom3ArfbAlWkquf1ycb5bpvcPtVaS+jqHif9uqVujFr4xi9zO8sCnXmeKH43Wb1UhGZkXbEUhMy9nCQpyebUXh3ySR1AOwsUX1SWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/n0w7ccR0V45yzacRgOoDZiK8jBAitw90npZ7Q6IWEM=;
 b=R8RXBt/ryvz4nc2Cc3ykHmi1iMZxbMceOJptOUuoF6mW0DQzvkRUuKBdSxzjFvfhTtU3zFbTYUp7ArFwguaWO/b5MiSXz44zVUVsB89Np5ZAvVjhkqbYGY2rEm7phVMIMKSBee/aTelSrgmKmdOwNpfvPHXDXMuEKW4TBX+GRxE=
Received: from DM5PR08CA0049.namprd08.prod.outlook.com (2603:10b6:4:60::38) by
 LV0PR10MB997614.namprd10.prod.outlook.com (2603:10b6:408:33d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 15:37:47 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:4:60:cafe::10) by DM5PR08CA0049.outlook.office365.com
 (2603:10b6:4:60::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.7 via Frontend Transport; Fri,
 16 Jan 2026 15:37:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 15:37:46 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 09:37:45 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 16 Jan
 2026 09:37:45 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 16 Jan 2026 09:37:45 -0600
Received: from [128.247.81.19] (uda0506412.dhcp.ti.com [128.247.81.19])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60GFbi2w3492119;
	Fri, 16 Jan 2026 09:37:44 -0600
Message-ID: <f7a2e47b-a37e-4735-91ea-4fcac3217186@ti.com>
Date: Fri, 16 Jan 2026 09:37:44 -0600
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250: omap: set out-of-band wakeup if wakeup
 pinctrl exists
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Jiri Slaby <jirislaby@kernel.org>, <d-gole@ti.com>, <vishalm@ti.com>,
	<sebin.francis@ti.com>, <msp@baylibre.com>, <khilman@baylibre.com>,
	<a-kaur@ti.com>, <s-kochidanadu@ti.com>, <linux-kernel@vger.kernel.org>,
	<linux-serial@vger.kernel.org>
References: <20251230-uart-wakeup-v1-1-13f1bb905f14@ti.com>
 <2026011620-clause-gecko-2cb0@gregkh>
Content-Language: en-US
From: Kendall Willis <k-willis@ti.com>
In-Reply-To: <2026011620-clause-gecko-2cb0@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|LV0PR10MB997614:EE_
X-MS-Office365-Filtering-Correlation-Id: abb409d7-c959-4ed8-98f9-08de551532e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|34020700016|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFJ3amU4SDJlR3hYZmkzWU82QXh3bmw5SjNXUjR3RTVLS0IzeThsWEV6MTJT?=
 =?utf-8?B?SjNnbzc2aFNySWVnd0NRbTBXR2RqWS9yWFN6R0Iwa3ZDN0NQWHdpWDB2eW5R?=
 =?utf-8?B?b3pjNUl1a0laU2pzL0YvS3N4QTRXM01UUmVnTDIvV0tiWkNFMUhjZ256STZ1?=
 =?utf-8?B?aUE3SUZwazBCTFB4WDNHek1QTlU2WE1VcHRZaUUyT3haNGtaY01qS1NEclVI?=
 =?utf-8?B?K0MyY0lvNXNCMEpCQjlDSWhOZzRGVlFLeEVNOW9ibTI1VEIzS0tqS2ZQUHpo?=
 =?utf-8?B?U3ovVkI2TmJqVnRQUFRPYzJ5VWhTSXlNYU4vRkpsVzk3a1pNbXNmZzdpQ1pR?=
 =?utf-8?B?ZE8zRUhEdXNqblhPYSswaDJSYkdvUEY2bUJUaHBjNjl5M2NCdXJxbkQyZjVG?=
 =?utf-8?B?ZG9pTWJJNmpVWUx4T1hpbGQza2JvVnB2N3VUK0pVTzNwRUR0M1RJMUUyTGVO?=
 =?utf-8?B?V1hZNU9IcWRkM250L3lReklSQTVWUStFWEJqOWNRd0JTdDJJdFJlcHBTSHYy?=
 =?utf-8?B?dVlnS2ZSdE9Yak5QcUQ3M0U2MVdEc25EZnpudGRndGZWTGgvdEgxSUw0OUVj?=
 =?utf-8?B?Vm9ZNEIxT0RJclhjUVgwanRhcnZsSFJaZUE4aXhxR1lBVFI1NTJoWFFMSno4?=
 =?utf-8?B?N2plSnFaR3JiSENiMWc3QWRkTmdPQ2NrQmxCTjdLVVE2L1hpOG5qQkVBKzRr?=
 =?utf-8?B?dy9tcnA3ZXE5VFc5WXJIajZhSHkyaFd5MlV5M1IyVXJidXlmZEdRSEw5VmdQ?=
 =?utf-8?B?Uy8wNjFQMzZ3UzV2UnlXN2dMb3NvNFpxZ3dMckUzZHZqdXN0WUhOUVFxVzVZ?=
 =?utf-8?B?bEljbit6RCtYNTNYQkVhZjBRa2MzV0dYMFIxSEhMaHlSTXdNN1JySlY1MjdJ?=
 =?utf-8?B?aitGWEt0OHN4RDRORjdyaEdSZkFZSk85Nm9yV2lIWmtjRzRqcnFYK2l2ZWVz?=
 =?utf-8?B?YUhyV21Za25BaGRHY0N0N0tlVTM3SGMySlppcnN0NTZyODZUZEF3NDhyR0tK?=
 =?utf-8?B?cjhVd2JBK1RZdmF2NU9qL3dYUE82cVBNL1JpNUFFeWVrSllPQkw0czlVcWVY?=
 =?utf-8?B?Zk5ZeWE1dlV4bHNsZnpKbjZ2V2tNU2lzZTJNVk1JdDFOSHpvVHBTQUhqdGpJ?=
 =?utf-8?B?QWc4endYVXJJZ29GMW9xUm8xQkkvakwxbEJTaERqY3g1SnFpejRNSm5OR0Fp?=
 =?utf-8?B?R2JqL21mQkFNQzlDNGUrRTFNbXBQb3laYWt1cm9MWkFVdHdpL3RBWWMzQW9W?=
 =?utf-8?B?ZnN3a0ZmTTZJRHA2dWs5M3ZFeE1UbkgyMW9OMkZCZmQxMEpTempFRGJlU3lz?=
 =?utf-8?B?cmRuN0tQcnRKZUw3ZlJKUGhjQlZ2dTA3SW1xVTJOZzU2cS83eWJScm9MZmVH?=
 =?utf-8?B?R0pTVGVMQzcxMzNUSUg4NFZ1NW00dWxZM00wRzN1dkc3UnZmRk1iS3k4QkFI?=
 =?utf-8?B?aVlydUU3ZEZEcUtVZFBjYnh4bnIyMG9hSytGT2pXV3FndTFvdXJOR2RHamJp?=
 =?utf-8?B?K1lnNkJjeHEvRVRHbkpBNkVabmdDbk1acTJpMm9Tak5IYzNidjhIYXZnbXRV?=
 =?utf-8?B?dVdRMktEVWg4Q3ByNXg0UDdUZGM5alpaazRmb3ZGak00RjNEZWJHK3BnSWxw?=
 =?utf-8?B?WUR6STRpQkw5OVVVZE83TER0WjUvTDRZR2hXMC9DT0Z6S2VNWE9ORjJmbTR3?=
 =?utf-8?B?OURQVm5GSjY3aTlxTnlOVENWczNzRXRXYTlSWmJpOHdXTXpmYUF4U3RSZmxx?=
 =?utf-8?B?TnN3ZmMzYTJ3ZU5ldng3VUp1L1dVcUU5N3EreFMreWN6SEowV2pCcGRlUkZv?=
 =?utf-8?B?djZlandvZytCOEovdXpKc1J6S3FGWVlrbU5meVMyYnBOMzN6VVc0clIzMXd3?=
 =?utf-8?B?ZklEcEd1V25WOCtQazljKzNaNlVvSWRPM3ZGeEhaRnovRUhDckRRZTluWkdt?=
 =?utf-8?B?WVVrRS9tUVgwQ1V1ZW1CbVdnUEsrVy9mdlJiTHplbE15ZHkrNUdzQ2ZVNGQ5?=
 =?utf-8?B?UWwwWVVSdGg3ZmhZRTJRT1hBWVIzOUwyNjBnT1FIRVI3aFJLejVqKzg4cUJS?=
 =?utf-8?B?MHo2ZUNrTzROQ1NFb3VxNlhBZjN2S0JKcUtENlgwUVQ3Vnl2ODd6Qm05M0tv?=
 =?utf-8?B?c0VZcDBvZEJFRFJPVVk3ZnAyMmo1TmpzQUdVc1JwbldFVk9Sd2FmNXNjSkVI?=
 =?utf-8?B?UDVwc2ZtNk5YNFM5NVVJZyszNGM0b3hqUVUvNXhBeHU1aU9FRzFUNzZFQWMx?=
 =?utf-8?Q?JElahW55XKcgZGcycOzX1pmXupPJCKZVMiO1R/q1ag=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(34020700016)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 15:37:46.8514
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abb409d7-c959-4ed8-98f9-08de551532e2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997614

On 1/16/26 07:16, Greg Kroah-Hartman wrote:
> On Tue, Dec 30, 2025 at 03:24:51PM -0600, Kendall Willis wrote:
>> In TI K3 SoCs, I/O daisy chaining is used to allow wakeup from UART when
>> the UART controller is off. Set UART device as wakeup capable using
>> out-of-band wakeup if the 'wakeup' pinctrl state exists and the device may
>> wakeup.
>>
>> Signed-off-by: Kendall Willis <k-willis@ti.com>
>> ---
>> Implementation
>> --------------
>> This patch is intended to be implemented along with the following
>> series. This patch has no dependencies on any of the other series:
>>
>> 1. "pmdomain: ti_sci: handle wakeup constraint for out-of-band wakeup":
>>     Skips setting constraints for wakeup sources that have out-of-band
>>     wakeup capability.
>>     https://github.com/kwillis01/linux/commits/v6.19/uart-daisy-chain/pmdomain
>>
>> 2. "serial: 8250: omap: set out-of-band wakeup if wakeup pinctrl exists"
>>     (this patch): Implements out-of-band wakeup from the UARTs for TI K3
>>     SoCs
>>     https://github.com/kwillis01/linux/tree/v6.19/uart-daisy-chain/uart-wakeup
>>
>> 3. "arm64: dts: ti: k3-am62: Support Main UART wakeup": Implements the
>>     functionality to wakeup the system from the Main UART
>>     https://github.com/kwillis01/linux/tree/b4/uart-daisy-chain-dts
> 
> How am I to pull any of this into the mainline kernel tree?  If this is
> dependant on those out-of-tree stuff, there's no need for me to take
> this now, please submit this all together properly.

This patch has no dependencies on the listed series. I listed them so 
that there was a full picture of the feature implementation. The 
"pmdomain: ti_sci: handle wakeup constraint for out-of-band wakeup" 
patch has been merged already [1]. The "arm64: dts: ti: k3-am62: Support 
Main UART wakeup" series is posted [2] and has a dependency on this 
patch. Sorry for the confusion with the GitHub links, in the future I 
either won't add them or will add lore links instead.

[1] https://lore.kernel.org/all/20251230-pmdomain-v1-1-3a009d1ff72e@ti.com/
[2] 
https://lore.kernel.org/all/20260106-b4-uart-daisy-chain-dts-v3-0-398a66258f2c@ti.com/

Best,
Kendall Willis <k-willis@ti.com>

> 
> thanks,
> 
> greg k-h


