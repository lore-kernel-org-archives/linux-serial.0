Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11020074.outbound.protection.outlook.com [52.101.84.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E4639CCED;
	Tue, 29 Sep 2026 07:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666001; cv=fail; b=uiL0i1owTH8nlwjQt9Wb41xpzqIc+N0nHYfieyb0ig/+l6fvJ60TSZnq7OEAMkUfim2f374JqJ0ILq5hNIRm7ehwk95lffWJdkTe8JcoCBdfG+BK8LSmzWmM/KFdPQABWE9JWGG6SPioFsCcJawtvXd80EZgnDTVJElb0OLFx2s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666001; c=relaxed/simple;
	bh=DOVySxW/M/aaRInAlTC4eXe/vjjCiAYvn7wBnnM1T00=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S5+XCmGrbtRzInXdwGvjLmtZ0ItLuus9tdrDH4qss8093BHj3hMhdqpiz7acOPX01Qd9Of2VmkMD405WCN9UKiRxRcYMTzYOdnBU5Ld/Llx5fkTJXWYPoneSfu5aTC81/wRZTCS4gIy5CfAO5LEDj0z5uLcxNj2tvj54hwWChgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=sDko/Z6H; arc=fail smtp.client-ip=52.101.84.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="sDko/Z6H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vi3sUeJ3l0HR8eWumFrawRWP3sSAAyWlEsWjjQQac5n6S7urgpCUXYX8jjQwTJsHyaMw5gP9+NeU/rN2wNjItjrjrI9he9ujHILmYsiJJVkXs91RczNad0DD8fv2if4fy0bxc0sBxcUQb6zcwJAjHA5jXzPl1MbB2OMyTFbZOgQTjiH76RlWrBi9t/eVW4+aJOGEMjqvHjcEegW1oO6fgUkimWF+4VO+y2oQALd1kbti8tDGD6OzdgXI4jOfnjPvGYFwsLYo6u2TCduRc33JnIh69YbJvq5cQQFEtHY+PgeRDi/NgqH0KfDI6YMo9eyqlEmHLdA/usdZh69ODrgdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOVySxW/M/aaRInAlTC4eXe/vjjCiAYvn7wBnnM1T00=;
 b=uJAdSyCM6I2wlaq4cNXysNpsE1UVJpaCdfKQy2Pp0p0jkQTLdLBlsAl/yBRt0JRHJEgXxaUm6jSF/N5CB1Bbv+HMpqU4n+vrcFihRkVwJJ0SOpj3mVtTgOOpNocIQFqBdJb2MzZSabyaFtvJK8+nFeFagDxfd4LdNge9rOHKPjB4ZTECEk+cnmLbo/v6WGAIBbe9Z6XCPblqu4CeRS83LSAcdMvuxbkE0L3zsHnLHXJZRyGFhgCiIjHufROTo2B/xZ/6X6YF4dkBqb0JZOcxYlxe4eAq5Qw2noQiMnyFwaiWWJ4QK37vJlByz7QST26oNMA+i4SU3q+ukKxVLlV51w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOVySxW/M/aaRInAlTC4eXe/vjjCiAYvn7wBnnM1T00=;
 b=sDko/Z6Hufebnc4RnV0WVYPoxJ+buwNeZo7DYOn0rXp6ECrcPW1GdeEzZ38cVCn12ttdIc9BE+2DnxtEKAIzsidvkRiAfgYmAQUHgQzcEXXiBU0J9hWdv/c59I5tbktaee9ZVOe9a7i9grveazOJ24JWQu0paNSgxN0xf5S6ljhzoAQsurNSIBLYQ25WWICF0CndY53p2Iagb0+vR3r9lnHYF1tMgUQtATkvEGzfGnJq/rOnhqN4QLn+FQmG4r1xPU8dXRG1DDTq0Jq0HLPdPxFSgJbkfUNKRgq8sKD8+lH//wI1qZYKCGUjYq2Wbt3bejUw8fN4Le89FZxpoy9qUA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by AS8PR06MB8345.eurprd06.prod.outlook.com (2603:10a6:20b:440::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 07:13:06 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 07:13:06 +0000
Message-ID: <97b4259f-7438-4d6d-8dde-2f1090e425e5@vaisala.com>
Date: Tue, 29 Sep 2026 10:13:04 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] serial: max310x: drive RTS in software when hardware
 delays are too short
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>
References: <20260916-max310x-rs485-sw-delay-v4-1-d37a694342cf@vaisala.com>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <20260916-max310x-rs485-sw-delay-v4-1-d37a694342cf@vaisala.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVZP280CA0007.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::11) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|AS8PR06MB8345:EE_
X-MS-Office365-Filtering-Correlation-Id: c3ba5ed7-8bf5-4969-0c91-08df1df91bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|56012099006|5023799004|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kFHpc6XeSTYBru+PDmZxEZ2KQ7ZHD1iXx3T6f3mnSIZIwvjyO6oRQtfts1BtkuT9OEUChzoXQmjlm+dSMBYV5f+CtAenyy+kOkhx/zTvUajFfFJ+GbD1tb3f+Tns9O3KgmpZRyxTlMcpNWFSdaAXzG4W3EwGAi5/2MmIoOXtlO6bo0dk7U4G5wVS+N/1HmH0y6+T/JrCrMIZmMSt1KLbacOXuN3QWjtvp1tVOYW6NpReoRfTqAExlCvYuCtEHbrsISpFHkXv4e0HfDS23d/ovQ1pfESnldPTI+jKw43sCVVMWguLPGQUXfZYdWATwYfXkpp6Vyz9k369yTLLruh6NP3SsUvIrI8EZbRZLQw1hjfiZ60NXlfZBkTHzaAmUJ5C8t32KCNetDHPQoVk2iq9cHngt5egIUatm+ZJGRPTj7VtdYz3vF9Y+Deg4UnZrcAGkDcJNpiPRW8xZFuKpjJpWnVxaXKZYv+lJOxoe6km91SKpSSAye4ZVpBndBKPu6X2QXDCHdS69FUYXr/cXjhG5A1Tluh1xiflmmtXXpLF30BKGytEjHw6xbKUYFsxkPK7esHQ/l7Rr8mPzUTF5li5qzlqC+yJ98hRC5zqu+zuY3VVXPmVIP0Y2xlk8E6NaRNT/favlN56wpvBYnS+BR7ObB31VplkUm62km798ODGkEw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(56012099006)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEU5WGFSbWk5emNUMDdlWWtGNTcvaVl4bTVpdEF3NmdnYTNDK3FsVkVKeGNE?=
 =?utf-8?B?eU1TcnpCQUYxYmMzdEIvVU1iQ0t5eXI0Rm1BMmNnajA0L2ZKc3NhOXE0eWpw?=
 =?utf-8?B?SkIzVERDTEt5dGZId2oxTURLc05hUzUzd3JrK3lTZVRMOVluc1Z2ZnE3ejFO?=
 =?utf-8?B?cXJoYmw0YThJZnp6am5MS2VLMytGZTlySHFWdE9kMXNSeWl0eDRLWXF2YmlT?=
 =?utf-8?B?eEJkcGdtNnBYOVErMm5yZUxWWFZNckEzM1JlOWNTVVNBOGVmZHNiQjFnNmUx?=
 =?utf-8?B?T2g2R3NTcTFpZnEwMnpwSlNiMURWVElaR2lQZkoxeXNkbFZISXZoQ0J0UVRa?=
 =?utf-8?B?WDFaQUkva09hK0t2ME5WOWFncmxabXZrK0k3VkpxWG5xWXg0YjRZU2lxU3VB?=
 =?utf-8?B?Vit3NGdkejhBV0JaN25ORlZOUERRTGdXaXlaT256UzBaRHlpdmNxYzRqZUhB?=
 =?utf-8?B?UHpQMDNiS1I4R1VaMkhPSVpNRjNHaGNIckhZTVRIaFEwU0dhKytoaE9JVE9h?=
 =?utf-8?B?NU8waTR4bC9sdVlXcEZiN2lYdUQwOENDZHVCVWlpYmFGZ1o4TVZGWVAzclE4?=
 =?utf-8?B?S3NtSUMrbEY3Y0pSMGpIaWQyWWw1MGxOc1piS2VmdDhnVmVobHZ3N2VCbVZp?=
 =?utf-8?B?bDUrMzZvbHp6K0Q3VDlOY2p2WlMwOE0vdGxpUzZyYmdSRHdGWGN0a2RzamVh?=
 =?utf-8?B?WmdYNFRqM3Y5eElSSGJsRm1IWFdadGFPamtXTkw5eGdtTXpBaFBJNUlXOGEv?=
 =?utf-8?B?NStlL0dxaHhFaUl0anpBdzBpckY1UTA2Y3U5ZmoxYlFnQVNlMSs1dkNpWEpU?=
 =?utf-8?B?QkhXUW5FSy92QlVGUnRjcGRPZ3JNRy92KzJ0U0ZYZUp1R3daOThzK2lON3VJ?=
 =?utf-8?B?U3h6djlFckNHa2lGb3pPNnZWNVMyTDhYWGwzbHd5TXluODNFd2Rma3AyRlNL?=
 =?utf-8?B?b0dOSmVMRGxyL3ZLQlV4U0RLQlZMcmYvZU94NVhmNTVHclZVTC9Zc3pSVlVK?=
 =?utf-8?B?NDRyZ1l3Q1RLWDRQM1YvZHZIa0RWMERobmovbG4xRUx1YU5VeDZKUE5DaDJ2?=
 =?utf-8?B?QVpVUW9TYWdQSFFyV2Y3Zk1zVzA3T2o0ei9xZmxkYzI3dnNTVVl0YStOV0RP?=
 =?utf-8?B?dWRkcWNIMFJ3aW1LaWkzWnN5WTVycmxwbEUvYlJucGY4SnVkZ2FzNSt5WUJk?=
 =?utf-8?B?cjVHd3RYeWhQZnZiS1ZtT3FSaUQyVWNTb2F1M2RFMzcycXg2Rm1Zb1NtTEUx?=
 =?utf-8?B?eUVSeEF5RU55MHRjL014cm9PL1BHUDl4TXprSWJUK2tJaW1pdG4rVkkyalpY?=
 =?utf-8?B?TEthTjBoRkhGaGZ5VUlzL2E2QkVWdWhzdzNCTmdBYlJyM2FaTzRYOVlDakxp?=
 =?utf-8?B?cFhWVkllQkJqSWFlTXEvdWFIZWhDMmhTNGRGa1pyZFR3ZFdLVlJEOWMrdGF5?=
 =?utf-8?B?UlZiZHQ5cm8rOHdOajZsU09XRGN6eW5NaDkvdm80UnFrdUc1dkwzeXZPWlQ1?=
 =?utf-8?B?ZjVDYjdMRXQ5bFdNV0xEUUp2VGFsRHhabWlXWG42SmdBOEsxNG5YYjdQWkFn?=
 =?utf-8?B?OVo1QmxZUjQwV1gwdXlWS3JlSVpQOWFGcEVIaEM4blB4TVlpVlU1dDdiZkEr?=
 =?utf-8?B?UXpOZUU0aVJ5Ni9GblFZY1pkSW9yR2JFdUJIQkx5Wk1CeWtzdmNiNE5Sa1pC?=
 =?utf-8?B?bnZzWlR3Z2JwR2JIRGpqN3U1VVVqVlBpK2I1bTd5cHBtTk9nMWt5T1pySmNn?=
 =?utf-8?B?blJXeFVHR1g1dUdFRzFNOGNwODY0ZXkyV1FRWkdVWlRZLzJkaHE5WW01dmYw?=
 =?utf-8?B?NlNiOHBlM0MvZDdXWDRIU0JTVzU2R3hwNzdHM1VqbmtQb2N1NlNNb2pXK1lK?=
 =?utf-8?B?NUVNV2JuaDZOY1JTUVNSckptbXBKVEFNNWJwTW01Z1NwZzc4WUZNc08vcGYy?=
 =?utf-8?B?Mkx2R2dldTA5VjR6bmxUZDZEdytmT0NSM0FaZ00zTjdDMVQ1L3ZpM1ZYa1Vk?=
 =?utf-8?B?RWdSMk1jcUlTSjlNSjEzdUJERWhwZGp1TXV6R0l6TWFwN2x0RVlENEdTTStn?=
 =?utf-8?B?VEgzZGJBOTYzWlB1Yk1KQ2tHUTFnNU5CUDFKQ0g4Tzl1OTdUMjc2alkvM1BB?=
 =?utf-8?B?VC9RM0JUK0syaXNsQkd5QjdpWVZKbHUyb0dMMUVhNTU2dDJsTzh6azN4SW04?=
 =?utf-8?B?Mithdy9tRitBOUdtakVCbFlyNkJ2MDU2Nm0yaDNybTh3K2FiUS9ORDVpdGZK?=
 =?utf-8?B?WWNzVmRqS2ZhNThlRTEyZmxHY0VacnNUdEh3Q3FBbUMxZnpJVUJsM0tVa2lu?=
 =?utf-8?B?eTBscE5YeVIveWdIYnhXblhpR1VWVWhuYml4L3ZjeEZnSzQ0RDB0b25Ta0ox?=
 =?utf-8?Q?7XsQPCtR6G6h77KQ=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3ba5ed7-8bf5-4969-0c91-08df1df91bbf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 07:13:06.0790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MYM4MS0rIiRGfTC6Lv8dTLoMCoQueT13/ck5wQGo5wWzJ4d+FnPJWBBwjMGpAX56LLm+e/tFc1CzrHOs+hM6xy5MRYngk1Okbb98ihADm7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB8345

A belated follow-up on the three findings the automated review raised
against v4, since v5 (split into a series, as Greg asked) is about to
be posted and changes course on some of what earlier replies claimed.

The short version: two of the three findings led to changes in v5, and
one of those corrects a claim made in my reply on v3. The third finding
is refuted, and v5 adds a comment at the spot so the reasoning is in
the code rather than in a mail archive.

On "races from dropping port->lock in start_tx/rs485_config":

Right bug, and my earlier assessment was too narrow - both of its
scenarios are real, although the dropped lock is not the mechanism.
->shutdown() runs under port->mutex and ->start_tx() under port->lock,
so they never excluded each other to begin with: the window is the
whole of shutdown(), not the unlock. The same shape exists in the
rs485-disable path, where the sharp end is silent data loss - a
write() racing the disable leaves its bytes queued with no envelope
left to pump them, and a following close() discards them without an
error. In fact this finding and the two shutdown-related findings from
the v3 round collapse into one defect: starting a transmission had no
teardown interlock. v5 adds one (a tx_teardown flag set under
port->lock by shutdown() and the rs485-disable path, checked by
start_tx() on entry and again after the dropped lock is retaken), the
disable path now restarts TX once the reconfigure is applied so the
queued data goes out, and shutdown() also cancels tx_work, which was
previously only cancelled in remove().

On "torn read of the 64-bit one_character_duration":

Valid, and my reply on v3 overreached when it said every value the
driver can hold has a zero upper word. That was board-specific
reasoning stated as a driver-wide claim: with a low reference clock
the no-PLL configuration can win, the baud floor collapses, and a
12-bit frame at single-digit baud does exceed 2^32 ns - at which point
the bounded-shutdown-loop argument from the first round falls with it.
Rather than argue reachability, v5 stores the per-character duration
as unsigned int microseconds: single-copy atomic on 32-bit, so the
torn read is gone by construction, and three of the four users
converted straight back to microseconds anyway.

On "tx_work bypasses the before_send delay":

The premise about the code is correct - nothing in the TXEMPTY path
checks tx_state - but the scenario is unreachable. TXEMPTY latches on
the FIFO's non-empty to empty transition and the IRQ handler's read of
IRQSTS consumes the latch; that read sits upstream of the only path
that ever deasserts RTS, so whenever RTS is low there is no pending
latch left to fire. (If the bit were level-triggered instead, the
handler's read-until-clear loop would never terminate on an idle
port.) A write landing mid-envelope can reset the phase and pay one
extra before-send delay, but RTS is already asserted then, so nothing
is shifted with the transceiver released. v5 adds a comment at the
TXEMPTY handling to that effect.

Of the two pre-existing concerns, shutdown() not cancelling tx_work is
addressed in v5 as part of the interlock work; the remove() ordering
remains out of scope for this series.

Tapio

