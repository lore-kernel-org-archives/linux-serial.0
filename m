Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023074.outbound.protection.outlook.com [40.107.162.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1F042EEAC;
	Fri,  2 Oct 2026 07:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925932; cv=fail; b=luREI6ve34w6wUVSvZZSWcUv6aTVttq6SVEOyQHfSWODXwBnXC3psRBW+UfUR56r69XpxwpLj5xCDRagKH+2mMTfzsdmXKTqeVNKNf8F5cXnTfZ+7zrv3i9utDVHUsYwabRn8yu1G2ieyphuzyo/iWz4emRugtpU20o4ebkRwN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925932; c=relaxed/simple;
	bh=x6Hb2zCjcTIF6YVWV7skYJ6H61u2/ql4Rc9iFg6OovA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hlzU0vlm4jrR/EcHwy/97T+DeqzO30mmgZN6WhQdFZqLI0S6azihhphVqgCQvzLuHUjAv/iMKE2PyJfS0siWipkVq5eVP6vVp/MaSf012WOqyCeBj85+y3wWusbsWPV/VPBmTgqibvkCCVe2H0nDqryoixIGZaHlU+VgquQxItE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=s4xWoAT2; arc=fail smtp.client-ip=40.107.162.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="s4xWoAT2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsbkP0x1Ivnfz62zKHJFpJll6ZhoaG/znu47nJEhHM/e7T2RDcZBCQoYhSrSi3DyogAWFHn2kWnORcZNhG1VZlu0p/iyZgql9pwiyZU9hOPVZpb7XzmevOB44sRdXnuaSpCyfoez4IewnKTOVCkfq6xxf6RS/8QLXq8CNr8XReeiYRdvPTJ8TxnYVaLQO1TjcWtDRGBkoA0mzn2luN/uc3GUhDBx+SA9Aahs2wjmwsO8nvw6qzh0GYY4Att6z0WOLtpyEymZFE05iwrJWnberCTDKl+jFuvJWoNma9cwxSBRb++/yn6sRaa0NmS2B3Vx924h5JIOyFz6JMkT+GSetw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6Hb2zCjcTIF6YVWV7skYJ6H61u2/ql4Rc9iFg6OovA=;
 b=AZHeBkbZmNewb+uchn7d8V6LGg5qDf0UCRRH4NmCZhQpWE+exXVoCZ3/xtWO4ORkT4vM23VMZycOPg8lklwvLA4/VkCmDeM1ZuKl8nulfVagrGy5XW0qwN2oXnLdosVO4dH69AaJZeCp9cRaRxv3VkThPA4bCNLG1+9VBRCNGhGYxk5eMUS+kL2A660svxfKhLGlfSmIvWs4vUAAlOCD/tqkTTr58PqBDcu9GED6T4vGfL54d447R+0ikOXP/6pETpLPACO7//GjzFqwCbVFA02OaxCbM10uR59aFViC0EHW7ZPydWiaiBfhU+3HWbweylHMcpspUmBDgPSS6k1CPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x6Hb2zCjcTIF6YVWV7skYJ6H61u2/ql4Rc9iFg6OovA=;
 b=s4xWoAT22nS3k0fr1YDyXkZARVMu0wMaeq3YsHtP2oLrDZAN9HfO8dAAd09LgHENFne+n16Tsrd35s0vWsGN0+2ykneZ0heTyrjOOAvxR1JqaYTYHhaK9Db0faOnRM3U1To1UkROVB29hhFVPO9IZ8a89BJXg3LS+VpikUQGCDHIGJSvnxsq2cBO/Qcw1VUNAYzBwC/XfbgYEsafnOL47a+g+Mlg3FLm7MJp0Ti3H4JHKznTQ6mPW+eRXzur3+PN8nrraYnOmSPflcA9abE2XvJG81pFNFfeHjKmRNPfQOQHXUbbFfjx1XN1TgKC7Wt/fUAWqa8h0HhsBQPD4gB5jQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by PR3PR06MB6825.eurprd06.prod.outlook.com (2603:10a6:102:60::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 07:25:16 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 07:25:15 +0000
Message-ID: <453bc692-8979-4e5c-a504-0b735da595d6@vaisala.com>
Date: Fri, 2 Oct 2026 10:25:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] serial: max310x: don't clobber the TX break bit in
 set_termios
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
 <20260929-max310x-rs485-sw-delay-v5-1-ae46afa583f2@vaisala.com>
 <20260929094019.67a4d5e9f473134dbdd39d93@hugovil.com>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <20260929094019.67a4d5e9f473134dbdd39d93@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3PEPF0001DBC7.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6b3) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|PR3PR06MB6825:EE_
X-MS-Office365-Filtering-Correlation-Id: 635bc842-89e2-4954-410b-08df20564df0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	OYfYY3hP9/1dLN/e7Z7FLI1PqW47olNSwugDd9gHg3p0dlT7PWZ6N/h6mJ/sjiBK8iZ4tngHOStLCxky+Nk6998DyI+2ZIkva+328H5Lh5YhN5+oSBkasUC9TM4ZadgGdHrFiOlWfoBug9vpg6u0ZK6bLkeJKt3EIJtP9KOkbDzSvQcgkIpgHqhGMKYDXRbXJAcx4Vyp75V+WAlHaCosT6TcOWO5Cl7hKimf3NoxMIV+Ktd93kD6k+N1+WN/8+BDhPNExAl218mI9mjv1yVV6kpcberonBERJMm2r3E804+5OnJY7xFFT32aLKvi6QzsH9vbUZQMV98sN62kAgHDotSS23+HATVA7tcFW+kkhdJGheO3L3wrnnxmY7n4p8grKRwcqXVNVF3LJ0u9QHUSQPN+owQMrl+lzijZy4GhbrrFgZydWY1y/sdJxXhnc6M9hdNyznInBF3E6cfo1C7+hIUVJTzEywEPli34HgCKtltDJTD5u9Bbdv1jtNv/amzhKp4kzdu8IzcJd1HSvQuEtit/sKmWmPYUJJMZohmXFda0b+MMZxhOh7AdQQKbrvO372lj7gldHAp4J6e6J3vNmm/B0wT8iqPt6FgjpnZLwMCugrs23nrygSzwZVLRs24K4ElUF1ExoeuRklbJ+l4imoBtw5EwPvnfuUNGRql/u+8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aUhYancwbGZ6bkRCNm5mQTJ5Y2NYN29uRjlDakkzdjBzVHRMTWRVMm9CM2VD?=
 =?utf-8?B?YnpwM1NmVkxsWVNSVmZtMW5DZHUzaTVXQ1djc1lmNlZoVkJicWxIbGhmRlBV?=
 =?utf-8?B?enN5MlBNR2M5aHhWb05CbG9hR1NxK0JIOXJoeitQSTdvbDJRaEk5QXJxd3NK?=
 =?utf-8?B?STZxV1dOVWQ3N0wvQzdnSFVLeFNtOUhMWWZCVVNLaytRb1BqTTRIRFVSQWRR?=
 =?utf-8?B?TDVrKzFIUmVSVkVDU1M0V09kK3QxREdneUc3dTFNSnhGU0ZYazJ3SFhYSHN5?=
 =?utf-8?B?TWJoOXlnTkVYb3Q2M2FiZ3pPVGt5SHlIWXBHeTMwUm9pRGNkVnFpSW5zU25z?=
 =?utf-8?B?bDlDZTcxUnZIdVNZbDJhelpOZ1IzeUJleTMwT0kwTk5SaXdZVFZoMFBEcTla?=
 =?utf-8?B?S1huTUZMQXBKSlRzOWRRZFN4NEhmaVNEbHdsNFlFd1NJai9JaDJKV0JqdjdZ?=
 =?utf-8?B?czFYVHlrNWdCa1RjUGNWdGYvSlRNbjBXbEpQSURGeUVXUlQ0enVwRi9PbGtG?=
 =?utf-8?B?V0RBeHU5K05Va3habStPcW4yWlU5ZURPWlRReXZsL2pxZHhDcUxMbUV5eVE1?=
 =?utf-8?B?TXI3TW05SDdGY3J5c0xsaFF3bjY5TFBQRURXbXlNclk4R0Z4SGFTeFBHK3N4?=
 =?utf-8?B?ZnNxSVhvanZTTlkza0cyc0FiYVhMMjVUa2hIQlc3dnZqVW9GY0lxWmxDV3BO?=
 =?utf-8?B?bzhhMldSdTVhVW5SSENJNkVZNnJNLytJQXJFTUpzVElOSldTd0FYK2lLUHl6?=
 =?utf-8?B?MGMxM3ExNGliRGNuR0NhWnY0VDBuMHZPNGI1OHp5UXRVSTZRRGdjckdyZjVu?=
 =?utf-8?B?RCs2cUJSWWJQMTJqS2tzbE8yQ1dvTitzSjBsV3Rkbm9oeDFJNGV3OEdrWG5C?=
 =?utf-8?B?M2QyQlFRWlkrb2NuaVVTTisvcDdtN2VwZTBnclhCREtDeENnbndJTTRraUFL?=
 =?utf-8?B?SnhldTBhTUt6d21WQlh6L0NJVU1kMVNEYlFycmsyVURJYjVSeG9WMndhRG82?=
 =?utf-8?B?SWdQYlROZVFUd3U2ejR5T2V6U2YxcXlhS3NZa2MrLzQzMVlTNmdsVzdGZ2Ny?=
 =?utf-8?B?QWlyY2tRSVp1Y3Z5Q0NrNFMvWUJld1dZZThOOHdZNEMyZEZCaWdTZTdVeEhr?=
 =?utf-8?B?MzdkaGJkdzVPem1TNzhaRGlNQTd3cGlaUnRCdDdZVjdOZWkzbC81ZTlHSDFp?=
 =?utf-8?B?emhHQ2EzSTVQaS9xMVB3MVg1SEVXZ0NlelpYRzJaWHpVemVtOW9vZDhXWUdB?=
 =?utf-8?B?eVhnT2RKOWpHakJxVkk4Qlg4Q3V6TDJrQ0o2ZzVnWTBIUFI1eEhiTHFraUlm?=
 =?utf-8?B?bXR0RVU5WC82ZmxTSnJzbGNpS3hNNlJKRnZjNUhiK3pTdE1YalMxUjJIZlBr?=
 =?utf-8?B?MkNQUVBhTmQxOGk5d0NlazVCaFF5Z3RaU0JtbUJKQ0hEUm80ZGNhNDluOE1U?=
 =?utf-8?B?U0lMNnR1YWNJSkFhWTdON2NEQTJ4SUxMUXl4Wk9wT2tUYWpVelNmS1c3TXFs?=
 =?utf-8?B?TStVZVlMZTE3SDhpZklBMUJsV2U4TjgwWFRza1llVEVQZ1NwZ1QyMk5PVkpi?=
 =?utf-8?B?KzVpY3NHQk1uZ3lkQXdzbEdlNHZWTFlGc3BGZWd5NzZKOS9sQnNDYjA5UEY0?=
 =?utf-8?B?TFFzVy9mekdnMGp5YVA5Q041aW5FdDdlTmlyWGZkMDJtU0tPUEgzLzBpeGdi?=
 =?utf-8?B?bmxpUXRrSTRGKzhsdXVDTDkrM1ZhaGszV2ZtVFZ6R2twMC9LaGR2bEM2SkFm?=
 =?utf-8?B?ODVpMSs4UDBQSkxEa0pIaUdWY1plRnNyQXZWZmhxb3h1RmlqTUpNMFNyTnc2?=
 =?utf-8?B?MVBhSWNuT05EWkdCdE01SGk3Y1cyeW1HZnZIMHVWbWhyRy94N2pPQUUyUm9V?=
 =?utf-8?B?ajU5ZDlyMTBzU25LRjVJQkJjNkEyNXdvbjZ3NDBjSm15dnRic29RRWZsNFhX?=
 =?utf-8?B?ZDBOeEUvNk1uQ3BLUGtxYklwY1V1NnIzWmpMdFJzbmNVWGwwb3JxRWtGZkRW?=
 =?utf-8?B?YUhRdWJ4akxBZDVCZ3ROU1c4TjI3aXpJSXlxY0NrZkF1U3Q5OGU0YjFrTWs5?=
 =?utf-8?B?RHlmOTREZ2JxdHR3QlhkZFFDR0F3QnpQSnRCNWxsTVNQUnk4bXdINFg1RGh3?=
 =?utf-8?B?bDdqRnVSeDJmR1U1YXJ3VmxUQVp5L3N6YjVPVGk3TXVqOEsydDlzdk0xZWhC?=
 =?utf-8?B?ellQOVdheVNoY0taWjlQZkhHQ3QxNDlwN3pwNDRja3JhaU82am0xMzdTNGd1?=
 =?utf-8?B?REhZZDBoajBMWTltcnJEaUhURWt6cUY4TXZYZ20xMUZvSjZUQm1GMUR2eElh?=
 =?utf-8?B?UUlFWG1XNURPcjBHTko3SXlselUrN21DSWdCaDBFaWFSMVJ2aWV5RXdMQTBF?=
 =?utf-8?Q?sDJEwzhJ9cvrCMsI=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 635bc842-89e2-4954-410b-08df20564df0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 07:25:15.8412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qr9ZiBTW2qjjwBesNB4ELyGD1pp875v1RSggALgagmaumbBGd5sR9OOFKOdzYZokqMDXEz8YA9ovZJiF8B8/RMAsYcDOgNL9/wHrYH96O9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6825

Hi Hugo,

On Tue, 29 Sep 2026 09:40:19 -0400, Hugo Villeneuve wrote:
> > max310x_set_termios() writes the LCR register absolutely, but LCR
> > also
>
> What do you mean by "absolutely"? I think you should rephrase that...

Agreed, that reads wrong. v6 says "unconditionally"/"unconditional"
instead, in the commit message and in both code comments (the short
one added here and the expanded one in the software-RTS patch).

Tapio

