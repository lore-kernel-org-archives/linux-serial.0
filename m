Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020112.outbound.protection.outlook.com [52.101.69.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300EB305683;
	Tue,  6 Oct 2026 04:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791259443; cv=fail; b=I93NqU0HluofKx/dMe7kwC4ilXvmgrKg1NMqusvIybwLLHIWL6jW75mt9+uvkL/4LA9onR7lLIjwMeD9l0L0XAOkgpla3IHeDPKukC6Lkbr9t68UBeFbGVe4qepkgW26P8lBChEZlYv/oGEPBkwcHt5npFnnEIhY9qjOLJQQ4/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791259443; c=relaxed/simple;
	bh=kFkWzdHjemit4PEwm/OvccmzM4SpY5ZbRNhJF4m7uaM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cDG7an8ApZzR+JHmdZzd8GZJBvBUFBgXIg4N3XjaL52ZIr0c/JwxalLr3NcGc44yHymrTCnSe7XrZYQ/xFA0bMdpxIUtDs79/+Qp4MYIhPdMrkHa/Ut7CYIUSSp/2cDC5S9V/8LMG0V6ZVlV57TquStOQQUi+yL7ubDuFE5QCQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=paiP78eQ; arc=fail smtp.client-ip=52.101.69.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="paiP78eQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhZPRpEisFG1iSEwSW5towXMHFvb4bCWYBgGL2QPE58b4fS1b1d/adoI9f7B2PWsg+Gc4SGCckicbq1IQoG9yaOdq+nYmTofoMvji90DQahAZLu3K6+/hy2NJZp8Q9rIMBjNaR3B9M4yHie5ySWzBbfJUkTBOdG8/eZCqztce29DYqt77WVzxFWiU+ZSJq3ScSNREB9VYUMGSusYS037YJtdvfXVX1hEeHfrS6StGPgSJjysAgw2+0sYqFmYZHUN1jvZrzbm3ZHp3mrMuTYwn9gM7aivc8zAO7otGgs9E/xMNACXWS2ryiAWKrWP1vGIU03IqBUHYyzOfsDAMDm2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFkWzdHjemit4PEwm/OvccmzM4SpY5ZbRNhJF4m7uaM=;
 b=UX5OHAUFWhsdRrbRefiGoRXLxFAZhiFG3cof8zly12BdJP7fEWlLe/kwZJgFSwhja2+HY5k3uspTLketHPKQ0R/Dxe8osbX1GDffCHP79AXv1o+odjM9oLmBavq0AFIuoZ+nBFGFAceoN+MCbTuZOJ4zFfba0ieTVEp/1vxK3nxppiKaulHn7gS3iWUokzJywkLKAsn8GDjk8oagAKw4nm+4aqXkXnYpuusc9NIfrWhshcVNvnD+o67UpmnY8026rIE69A/6tb7o2G6yMNqov6M/y1CA/hdX9oeQWNqscHQZFqnPKyJfrgdQtQQGNW4zhfYgfcQPURM2Djth6Oa4jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFkWzdHjemit4PEwm/OvccmzM4SpY5ZbRNhJF4m7uaM=;
 b=paiP78eQJ4szjlM+/FT/qWVsQfS+ugyXJNsVypKvZ8R3nmRUu045GSkY8uY8qsocJv+q8BwYK9c7EztYg5+t26/+QVO7L/pwBzH/2kPZIYTc2BAzQ09B/ny/ko5Bb5HVj4XJNoj+ogdYqI1QmEnxJTw8nLW+jeclROTFS/LXqFDEPo5uqF9G+mpDRFzNU4OYGDjOUorPN3Ab7X42GsanpJZoLmJ+9QWyeDF0cCPzxlP961wMjZmLBZBM7grRShogQT/i/4h40a3hE0Hebgxw/z6nSRKzeDksBB0OuKFOVJmBFmDs/zM33jzvLsmNOtAfnefHNt1BgiSc7bNnP3hT5Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by DB9PR06MB7867.eurprd06.prod.outlook.com (2603:10a6:10:294::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 6 Oct
 2026 04:03:50 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 04:03:50 +0000
Message-ID: <b0b24749-7d47-4640-9556-909eba07c6cc@vaisala.com>
Date: Tue, 6 Oct 2026 07:03:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/9] (no cover subject)
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>,
 Maarten Brock <Maarten.Brock@sttls.nl>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
 <20261005115102.0b865d739b0c53a082ab2463@hugovil.com>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <20261005115102.0b865d739b0c53a082ab2463@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0017.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::15) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|DB9PR06MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f680ca-da7f-4f66-1bb8-08df235ed420
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	qbgQ/EtIndpf4CkwJC+YIFcRFSj2IcnGQuMGlumhz1lVE1fIiL5vsP6i857LWz10oR906Bln2MBVmhTRiAK9+zjqX2gOe49FDwgpG/7RrIsJA6cDgDQ40pF0BQRcgIngqHJIN0f0T4oRNEojA/D9d8AIVYWgEx4fIVn65Q169bqDUS3p6atrciFh5ZKEHOIgsOLtS6UV29uvTYECueEfM/sBbkDX5UoN4vwq9XOfh2krhmxcbkDQ+nonihUYlVDAuFNJj1g1Exnq8BE/h7DQ2/Ckj4DkRGp0HU7nD2Jk7DxN/a9jN2ankGM7mEtg4vHQ3MnJizGqDE7vyDqRydj9GY6h6+KkYXQ+FeiODsCNlFEBve6bqrZGZ5Aa+H+kKP8V+g6ABs2CiYh60LMYabpJgev+86oCE7dplUmv3Ujs9sSqnzfYEE0re30dKnz6VoQgZ0zPD5pi/7ahJtoeiXqT1QlCqsmvApitRIsjg5t9QBulaZpCIWWOcDfJi+FeH3uyLVBd2fEMK8xPvq3ahKh4S/OGMmg0pKEaNEeZx9BNyY0S7vXnoFelt2kxiL50tbij+4vwbPrQq4piGDTTbr5hnOqJUV7jFP74/qzvmv8P0MWOSutQe6SxBCBZ/oBs9ug4EFQ1PnoxZKkMlwx2WBFriENiviI6ALRDKumC+ovcJYM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjlwdTJSOCtGbmtUTnI3K3NFVklEb0ZCbDJJS0drNkdzSXMxdWUyNGZHMURi?=
 =?utf-8?B?RmR0QzcrUldVL1NSaWNDRUxOdW1xUUNKS3h5MW1TN21tTjNkd3VtRGtrMjlm?=
 =?utf-8?B?L0hsZU1xZFd2V1hic3EzK2FEc0ZCMStjYzJReXlpRmJVaTJndFljOG9KUlgv?=
 =?utf-8?B?U3hPRDNFK21lanJpMHgvbGxqUCszN2V1YU9ld1Z3c2k5SWJrNnVQU1BhVjlK?=
 =?utf-8?B?Z2RjcEJhSFcvZFlvci9BRGx5NTM1TmhNMzZrM3NLZ09NczUwOUVZODBCSVAy?=
 =?utf-8?B?V1h6cWZGcFNBYW1hTHkySE5NNDBBRWFuYjI5NW9PbkQ4SjFCZ1J4L0syUTVO?=
 =?utf-8?B?Zmhhb0hJaWlmTHdzQWhGczdEbkxEbW13czZBditNaUVaY2wxUVBxT2FPVGFU?=
 =?utf-8?B?dGE2TXlPczBmeGVSdGN6YTQ1SDRxQW8zMEV5TjBWcTJCMUJURk5SbFp5ZkdR?=
 =?utf-8?B?a3RDdjJVNTdBaVh5OTdwWHFyUmV4dG1CeXlGeHRxbFZaUkpBdnNpUFV1T2xY?=
 =?utf-8?B?bVF2dXh5YjZQNVVlSnI3L3UrazFkazd4TTZ5dk12U2NlN3lQeE9RU1M1WVFk?=
 =?utf-8?B?UGowTDhlbmRkY3V2UDd0VlNYclkrNUJuVTlFOUhuTUJsb0wwMGRua3BlZWx0?=
 =?utf-8?B?MldDVWprMENsRHR2TDY2UXp5RU5Wb3NNaFY5L1ZmZ2xsQ0hxMG42bnBxUjMw?=
 =?utf-8?B?SFJ1Q3JyWExKUUh2ZStrbWFOclIxUkplRVhKa2ZOeFA4UEE3ZENMUFl6VzVI?=
 =?utf-8?B?WG5EL21rOSsyUDg2NkRseXE1YWI3ZjZEK3QxbFJCNGpDNlVsMHE5WWxOM01Q?=
 =?utf-8?B?ZURMNzV0Z0RjZFVEWE1QbHlmZW1kTkFvOWRjSDhvN0RvVkZvOUVOTUdOQmNW?=
 =?utf-8?B?Zkw5ZkZDOEJXSFZCQVRsM2dNV0F4YjBlRHBzTTVrQ0xPMHEzMWZSNkVlNWZq?=
 =?utf-8?B?SCswRkJrTDg2ZVNKZllNOU9ZRit0VCtyM2M5cVZONDZQTURsc3d2ZUZtVWtn?=
 =?utf-8?B?WlVYaEZvaFgvS1BpbnJSdWVwU29XZzIxT2UxTkxmOEcyaExmdlM3QVJKVzND?=
 =?utf-8?B?cXorTjk4M1ZEeFNqNHc4eVFFYUI0R05sUk9sTGNiejY4SnV1SUZKNzUxanhk?=
 =?utf-8?B?T3VpZC9IUDE2aGJCQTBYTU04V3BsQzVUd0x5RFB6RWhQeTk0QVNLM3VpVmxN?=
 =?utf-8?B?V1ZyWjJLM0FaZ1NMR2VzQzc2cXlueFNtVkVOeDdMeXdKTkdPZTZCQnJuQXlX?=
 =?utf-8?B?NjErZFljbjMwRXlsR3FiMlYwYlB4UlBNYkNQZDhIVjIyUUhFT1RnNzNIZ0p3?=
 =?utf-8?B?MnVZWU5oRVI0b3N5bTFNaGg0SEplSDQrZi9GV1RyUTY5M09ZQ1pTQ0xqeWlS?=
 =?utf-8?B?STlHc29BSGRoQUtpdXhHTWlvN3loaFozZ0VqMTIvMkdOeFdKZTdWTnRoOGww?=
 =?utf-8?B?ZHNJd2pTMHpXbXp6ck9PRXozWnRvWDZ2TkJvcGZOSjFYK3h4N0orc0JrcFlB?=
 =?utf-8?B?eHQ2UkJGRmg1US9DVkIwbm41WWpZTWVaWlJ5cmJZNUdiWnRiTzRnRG1FMjcz?=
 =?utf-8?B?ZFpGVTFqQmh5bTU4N1N2Z1hFOVh5aXZsUTEyMm45cW5YdndjeXBjZmM3N2t5?=
 =?utf-8?B?U0xKR09WR1dqREFMYjJURTJscEY5eXU0NVR1SXBiUXNNSmpkR3JPakFEc0lp?=
 =?utf-8?B?aERhWTRrNmhHV2YwMVJqbW1UZFlqMEVxZCsxQUE0L1hhdHNuOFEzc3Z4TW9N?=
 =?utf-8?B?dWl1dlZmZytCT0hCMHBGbmcrTStLMmgwMDBqbEs3b2ljUS9vNW1tQm5rYkVo?=
 =?utf-8?B?QnlYSXZ4STNlQThWemQyczdMbm5OeWFuL0NYMzRkbm9ZcWhYSW9EVVNIcFV0?=
 =?utf-8?B?SWMzb1ZmNjlCOWlvY2NZQTFJQWZaS3pQVjBBUkNnVTczcDJvTkVPRUZIdUlF?=
 =?utf-8?B?RERXNHFNM25JL0RWODdUNlR5UnJXd3p3QS83UHpqeE9BRXZicnJJYWZrT2JT?=
 =?utf-8?B?T3NIYUsySkNUcG1sdStJaGkrbEREcWYybDdyamVwbndOWjlaWXllTklPb3N1?=
 =?utf-8?B?eGJDQmpkQnBBVm1MaWFlM0V4OVBzTUY3eGpQdE9OQi9wYk1ZdlhZQXFCSk1w?=
 =?utf-8?B?MGRIS0VKeGo4QWp5QTgrcXdGRnF1SFB3L09zT0tkWFBRV0hFcGFJcFBDYjhL?=
 =?utf-8?B?WnNUUk00dGFTZ1ZBQ0pnd1FVbzlpUGN5QnFpeTNZa3ZPVDVFd3FxNlJXdXNj?=
 =?utf-8?B?Slp1NzNNR2I4Ynl6ZXVVVnRIc1A4YytVU1lkUnBySlhFTnQ0S3RqanRXczZ0?=
 =?utf-8?B?VE9WTzVMS1M3azdSQTdOQTU1bWRnekFxbldub0ZFcHlUblVsV0t5QXpoWThY?=
 =?utf-8?Q?T0FNAlmcRMvYsBUs=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f680ca-da7f-4f66-1bb8-08df235ed420
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 04:03:50.3959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: trWyFPszwk+lhnYNoROwAOBFqdnBvfxmbox8L4nIlY4WoUr1O2dCX5erNAgHZ48dhm1dHt/x2fYOIMRTvoPju+HC1XRBtRrtHFE55PhxkOk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7867

Hi Hugo,

On 10/5/26 18:51, Hugo Villeneuve wrote:

> Hi Tapio,
> Did you forgot the changes for V7?

They fell victim to the same tooling slip that ate the cover subject:
the v7 changelog sits at the very top of the cover body, above the
title, instead of next to the older ones. Short version: patch 5 now
stops the transmitter (MODE1 TxDisabl) instead of draining the FIFO,
patch 8 gates the teardown before any wait and adds three race fixes
from the v6 review bot, and patch 9 takes the port lock through the
uart_port API and restarts a write deferred by the reconfigure gate as
a fresh envelope. A v8, if one is needed, will have the cover in the
usual shape. Sorry for the mess.

Tapio
