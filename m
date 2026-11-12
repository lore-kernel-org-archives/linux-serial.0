Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794464544;
	b=ndeZt6CuvI8v5EFVEPNr7hCvBmDMNUb26jwb62gU0V8a8pTuWJnbo13AFVCyvAdfUs5Y
	 tzoZdOHe9HaL6vWH8NzGiUOQRb+Suewg6qJ1SAsau3MYpdss0W3orh3Mqia3B6pYnve0F
	 quFAw5qC8SCkTZByvl3muJj2UgsQDAqxodDoq3q7b4PzLkdJMJZ7TmJmEQteNq99LIT1q
	 LaxJNKoCDUB9JtQyfmVfPxMjjcb0W8NnQXONEwq/xVUdMQHGKbkvG5PYgZUR2KwQ5/gsW
	 9rdQuJWJqCEo1E6tGTzpkuV5WxJVIJ5UKVkISpnlz2bVRVRGNYq/PTw0MNAhO3UTGGg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794464544;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SharedMailbox-RoutingAgent-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Pbw/4CdjCzWQvIzC26Fib2KO5DBmfYmvo/bL1AYhzxc=;
	b=DDlyWMckFpcMr8WKqxzzPvLLX0hGHQKp+NJvdWxQUlJhIVMyeMyIQkV7gYlsTkf+Fmdp
	 gC8Sflwz4kJbSDmwnj1ldyOZOL+KtFVhHdDX3K2aDfdOEtMLA7NURo4rupTPP8vGCKL2b
	 txhmYiGRPoASOiLz6zOq/7siKAN22c7DDpNNHmFkInV2E+IdP23llchpCbxnUarvXhIco
	 WXNku8HQkG3+gjSYsuTiHUcZDsRUKE3odX6idF4QYchZ4ZFjFYsp5U1f70LWNma/zVj4J
	 fhi+Co0gVsiHUjEe/THCJ8/qJ0Rz0QGn1yhQ9h2oYRs1sc8kng4bjnWCNkdm5WgPeeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hdUshBEM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.52
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E451C606A8B2;
	Thu, 12 Nov 2026 06:22:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E451C606A8B2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=hdUshBEM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OboiYahH6ISy7mNsNhP/GdHepUykfSGFGRlu4JLNhzDr63LeWbw3RYfSa1imMilXgeMBTzIt22zMWNA5qyO8UdDe/09fkhLYeenl1cGdAFGPZzW2X/RjtpNx4aMuVnjmJd0AFmqN35m+FwLSV+lwL8KoherOSxXCphC5dhGAMI5xKTPTu/J/ZXTFF4tWmunSFdy+r0K+fzOdjsVCBSKnnJe9Ly35dYA6pfQhDpJ+ZMd8e/jZUKwapx1yWlNMSoVTZPeba7b/Q6O8u6awbMImtMabpL3UvPZCAjjTyG+JWzbOiPY+QC7nhzEBZqxR5NB6IValwVEI+VF5o+4Bu212Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pbw/4CdjCzWQvIzC26Fib2KO5DBmfYmvo/bL1AYhzxc=;
 b=f9CJHMWubY3gvS1WIrg9hJgxXk3HUe7QxdpzuAZ6lWCxcsMpC5RyVdB51YAIxPQCZ4ru59UWqL73a7+X8nLSJMRVk/sV5Oy654aJeII5tzhGKTt/C6GtBoQd8tYFay/+1Ryqpx8iPGpWzh85MISTH6hF/aP6C0qF+0FMuR6MrkW4D36yfHIQQ8cUsdWL0NG7lM9d+y748Y1zrqtWmApd+MC6sKHSbOQuk4T0BgTKQErZ4ASJXyxR8Fh4uA6K9jJc7u+QLyaeEic7OZV1S7FdQewb5z7nlFIMHIrODjhx42gyJp49HR2ARTNkVIAyFsDA7wNT0sLf3gfbabXppV967Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pbw/4CdjCzWQvIzC26Fib2KO5DBmfYmvo/bL1AYhzxc=;
 b=hdUshBEMucRTYrTCJG2QcoOGTo7lpgOqUuhQG3hn0WOm19jnRdscrh68S676qCQVv55cu1W3gGRih0Sv5cCC9o3I0ssZ1TuPv/X24v+oLrI9QiGrf5bm6cY5YAgBtNB28ANnkzMG8+88ljQCKIvGeN4pZQKdrsMBdMaCvcLZ1bUw2FX74FZpOJsbE0/RXL48onsME+IsB1YTQZFU0eiShux7NeRvkg9QamDb0JkWX5JySokN90OXtTtVGqD2wKejZ92sIoX7tiS0/lPrQabiLb98Hq5N7CJagLXX9Z787yRb01F6S/cYQH6bALIVbAYcRyPwElsDF/HCN8uuJgOgTQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com (2603:10a6:150:2c6::8)
 by AM0PR04MB12098.eurprd04.prod.outlook.com (2603:10a6:20b:743::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 12 Nov
 2026 06:22:17 +0000
Received: from GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4]) by GVXPR04MB12316.eurprd04.prod.outlook.com
 ([fe80::fc6e:ca22:f065:def4%5]) with mapi id 15.21.0592.012; Thu, 12 Nov 2026
 06:22:17 +0000
Message-ID: <987f1008-bea2-4d02-a2e1-f4389a0ff3d5@oss.nxp.com>
Date: Thu, 12 Nov 2026 08:26:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tty: serial: lpuart: Add port lock for registers read
 in lpuart32_set_termios()
To: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Jingchang Lu <jingchang.lu@freescale.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 imx@lists.linux.dev, sherry.sun@nxp.com
References: <20261112-lpuart_port_lock-v2-1-e1d914e52660@nxp.com>
Content-Language: en-US
From: Daniel Baluta <daniel.baluta@oss.nxp.com>
In-Reply-To: <20261112-lpuart_port_lock-v2-1-e1d914e52660@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::6) To GVXPR04MB12316.eurprd04.prod.outlook.com
 (2603:10a6:150:2c6::8)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12316:EE_|AM0PR04MB12098:EE_
X-MS-Office365-Filtering-Correlation-Id: 025ccd7a-2eb8-42f3-21a6-08df40854ca2
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|19092799006|366016|1800799024|22082099003|18002099003|10067099003|11063799006|56012099006|261026140227099003|261102123227099003|261028144727099003|261009223027099003|261021123027099003|261026121527099003|261022105027099003|261009221227099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	5kPEXsn+ZfwJgoSIYN94LBLgXyLQJZDY9Ghy2kPMziCzd/4GatBBeRLcPeqbvf+3lyM0ZhffPMbfmiUZnzRtSdiF10RpxMQ4dw6oHNPttt3puj7Vz8gAkvzPDSuIr1GNUhtxsE/pRZBTgDXn+/YUeli2zBF9MALgGdDix4un+etsmApv0FWtbxeeVQdPHu/FU7DCcJ7hxZGXqBSlkLsuew+u5Q7luEflZJfXErrKEmv0IyQgBBDjGxDaXm1+hzrX/LxuDlFOBp/ncos93k+FqRGVTSzQV3S7STQXKpN7U9igex0KDbh3f9ERNeySJXDC3TYHMFn9dE/PzYoMuJ9N+ps+Ux51q4Y03TdoAvRxsBKjEl4ktyWLPvcDF++Gnk8iMW2Glg3nMB7Gq+wQAnTeLTajB/XyZO9rf6dBnGEGFwa4pMGveC0yAHUbNo4HCdqyge8jbe3myKIAMSgj8R5zZV0Nce+kMuviy1eCxNDSrJ2cjJGYmWuzKspAVjjDsQg0YROIJmT6LdTxpWBJdVJzofeuKselCs1Ch8xy8wwB9gM4ISbjHXBSREXJ1nR3ca0GrAigke9HAYcpzq0S+CLA8l6fYd45K8RHkf4EycE9+4bSNyPsIp83RtPbIRAmZsWa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12316.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(19092799006)(366016)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(261026140227099003)(261102123227099003)(261028144727099003)(261009223027099003)(261021123027099003)(261026121527099003)(261022105027099003)(261009221227099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YklYQ3R6a2VlVGJCSE5ZRG9ua24yV2VhYVFaeDJhQWtaVjBVN3FoK1hPOExM?=
 =?utf-8?B?c0NyT2tzN0hVeXdaeUlwUGQ0ZytnbUJITlV1NEl1V2VUdUl1Z1lwMHNSR3ZS?=
 =?utf-8?B?ZHNKZU5ETmZtcWpjdGUxZy9FSFhkYTUwWFpYRWVpYXhkQ2c2NzRiVHM0ZDB6?=
 =?utf-8?B?U2hhdEhSNWV3Rm54VmQrak5tc3lzRWFKanNpN3RkMXYvVUp0dDZneGFRRlRU?=
 =?utf-8?B?SHc3emJyaFI2Ym1NdisxZmVuVFZSVFhSaTFITWkrUWRMZGdnaTZ5VXV0Vlha?=
 =?utf-8?B?VGJvSzRtSUo0ank4YlRSRkxHWktiN2Q2L040UjNMQWhFNldTcGVHak15VEhi?=
 =?utf-8?B?TXhKdFp3R3dBV1VYUDVjTGZmVGVOZUpkVTVUVGZNbFNDMTNOS0FDSFhmZWFE?=
 =?utf-8?B?K1Fsb2pBTnZtcWNEakYydmo3YzkzUFNQUDZuRGVaZzBTejA3Nm40bVNzRjVJ?=
 =?utf-8?B?cXU0cHZRMFdSUmljb2hyZVNqSGN5d05NL2RiTGlmNTBwbDJNY2gzUm9HYlhB?=
 =?utf-8?B?Z3J2cVJweDN2a1BGRWx4SWl2MjR3SW1xdkQ2by8yc21CVkRIYkk3S2Z2ejVP?=
 =?utf-8?B?amYzU2x6OUNaY1BUditBWUJaS1lweGpZZDA5SnU2TVA4QmxxVFMwdEVxbVE4?=
 =?utf-8?B?RHZyZWRzS05abTZKRGM0cGFKMm1wdjl3WldLeHhIMElvcTRFVkJoVDFvQ0xM?=
 =?utf-8?B?V3RodzYxckgxc1IvRldIY0dzYW1SbW1mdHAzUVN6dHpGamlhcTF6V3FyZWFQ?=
 =?utf-8?B?WVFBUEdBSExyZXhSNmt1RUF0UmhzUnI4TDljY3QzOEpSQkc3cWtLOGpqcTMr?=
 =?utf-8?B?anJaYVlsQmp0UnF2MWIwU2NoQ05mK2tWZHRJUTlRQWcvK3JQMHEvMW9yUE5V?=
 =?utf-8?B?WVRMRmJ6QjZCekViUXdLYWtISFlsQzltdFl0eXRCMUhSYjBhbWE3TG03ZDR4?=
 =?utf-8?B?dHJjbHptYytvTkZyZVhvMFFoTDFuQ3Q1MWtlT1FqZWVLTmlCWWw1U3ZHb1BL?=
 =?utf-8?B?dy93d1ByNXMyeE9NTjRkVlVCOWE0dzRiN2xZOTR4bFNPM2tUUlJkWHhSbmJz?=
 =?utf-8?B?azNvRHNPTlp6WnNQdjlqS3VLWmwram9WczM4ZVV0aHZxNmF6KzJOQnVhWFlT?=
 =?utf-8?B?aXFOWFVMc1p0TmYrZmtQNElGUS9BRmlKZ0MzZktFaFpBK29LUW9RYTdselNm?=
 =?utf-8?B?L0JTWm5kMGZIeEFQalJ6T2dsMmpqV2psNW1NUTUxblVtNXk0dy9IWFdsbzBo?=
 =?utf-8?B?TW1udzQyK1FXVC9XbllkTjM3NmlUYmR0djAzQWlsYWVmVENpMWFjYjdJVTBY?=
 =?utf-8?B?d1VOMStFaEdTL0VEZ01UbWxpaWdXSHRtblJOUCtFRnEyY1ZKWEVuZTB4cTNz?=
 =?utf-8?B?aTg5NWRrcUJLMktpbWZlL2J3eVRCaEVxMmZ5ZVVJZEtaZXpyV1U4cDhxeE9B?=
 =?utf-8?B?RGF2MFJnbjJGMEw2byt2NmtlU0NkSWNsSjJjRERBM2phSDV4cXUyUVo0TURD?=
 =?utf-8?B?bldqQ1BZNGlZZ1pTcFY4QW85cnZjTWRDeWRBZzlpQU5oakxRT2JJcWJiYTdj?=
 =?utf-8?B?Z1VjdDJxN0kzN3cwUEh0SkduLzdtZEVNMmNVUCs4bjNsVmdwTDNqeHo2TXVr?=
 =?utf-8?B?bkF1UzF0UUh1MHg2dFRJZWhyeCtMUHpseHVGeHZhRUNhVDRVRDhlUkRRYmFT?=
 =?utf-8?B?L09ZcWVOVE4rMkRvSXNpWU9tZkQ4WGMvS3I2dlUrYkNUbHNwZmozcDlQN3Zo?=
 =?utf-8?B?clhyL1BKWVYrY3VQbzZmZTZuWTNGdWpIZkIvekZuZmVqV3JTblpISlAxVHA1?=
 =?utf-8?B?VklKTzZXeUptRnJ5R3FNL3F5T1NyaEpjVVpVbG5oa0tKZE5obWhOazcyenl3?=
 =?utf-8?B?S2FUcHdWNnlsMTJ6NzEyc3FtYnBxZ2dRWU8xcUlaUW80ZG51M3ZGQWdMNWo0?=
 =?utf-8?B?UHN4RjZWekE4SFFhaHRaVFhHSzY2UUR4KzErQU94ZjVSWGNCbElYWEFrZ3ll?=
 =?utf-8?B?NnhqYXl6UXQ5SnpwSmFQRHhGdGJjQW5jN2QyV0hOcHFwT0pyZStYak8zbUlI?=
 =?utf-8?B?ek15VDNMMTIwaEsyRS8xY2o5WmFzNFFGdVRIdm15YTd3L2JyRzNpcVhja0ZV?=
 =?utf-8?B?eFZHWGVjcU1QeUlidDltN2RWVGxLejk4WVZ1SHRNQjRBa3RLSk1lSy9sOUxz?=
 =?utf-8?B?NlJ3MXRqVHVtVE96N2hDQnJra3VFeURob0ExSkc1d1lWNFlRWG0zM0xqUURT?=
 =?utf-8?B?NUF4S3VwcGtpU1V0WVZRaVlJNE13WjhvL1I4bFpaSjNWekF4a0hRL1V3cFdw?=
 =?utf-8?B?VFczK3M2YkNQMHlsS3M1cjFweUJZemJ5NWxLa0NMQU1waHIybXlTUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 025ccd7a-2eb8-42f3-21a6-08df40854ca2
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12316.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 06:22:17.2688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2NrRs1X5UUgxLIXu89thLITsKlN5wMSB4F9Kzrf6QCg6Xodw7Tm0EJhaTLLwHcouOTy6OXVkiYtEjo4328OybQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12098

On 11/12/26 05:19, Sherry Sun (OSS) wrote:
> From: Sherry Sun <sherry.sun@nxp.com>
> 
> lpuart32_set_termios() reads UARTCTRL at function entry without holding
> the port lock. lpuart32_console_write() can run concurrently on another
> CPU and temporarily clears the RIE (Receiver Interrupt Enable) bit while
> it polls characters out. If the unlocked read in set_termios lands inside
> that window, the stale snapshot is written back, permanently clearing
> RIE. Once lost, no normal code path re-enables them, so the UART stops
> receiving characters and becomes unresponsive.
> 
> Need to add port lock for the registers read in lpuart32_set_termios() to
> avoid the unlocked snapshot captured. Since neither uart_get_baud_rate()
> nor lpuart_dma_rx_free() uses ctrl, old_ctrl, bd, or modem, the register
> reads and bit manipulations could be moved into the existing
> uart_port_lock_irqsave() critical section after lpuart_dma_rx_free().
> 
> Please note that this only fix the normal printk path, in the
> oops_in_progress path of lpuart32_console_write(), when trylock fails,
> RIE is cleared and old_cr restored without the port lock held, there is
> still a risk of stale snapshot, but it's acceptable for the post-oops
> state and the trylock-fail window.
> 
> Fixes: 380c966c093e ("tty: serial: fsl_lpuart: add 32-bit register interface support")
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---
> Changes in v2:
> - As suggested by Sashiko, since neither uart_get_baud_rate() nor
>   lpuart_dma_rx_free() uses ctrl, old_ctrl, bd, or modem, move the
>   register reads and bit manipulations into the existing
>   uart_port_lock_irqsave() critical section after lpuart_dma_rx_free().
> - Link to v1: https://lore.kernel.org/r/20261111-lpuart_port_lock-v1-1-5d332c51edfe@nxp.com
> ---
>  drivers/tty/serial/fsl_lpuart.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
> index cd2575a3aef7..074bd9d42f84 100644
> --- a/drivers/tty/serial/fsl_lpuart.c
> +++ b/drivers/tty/serial/fsl_lpuart.c
> @@ -2241,6 +2241,20 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
>  	unsigned int  baud;
>  	unsigned int old_csize = old ? old->c_cflag & CSIZE : CS8;
>  
> +	/* ask the core to calculate the divisor */
> +	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 4);
> +
> +	/*
> +	 * Need to update the Ring buffer length according to the selected
> +	 * baud rate and restart Rx DMA path.

While you are here please fix the typo. s/acqures/acquires.> +	 *
> +	 * Since timer function acqures port->lock, need to stop before
> +	 * acquring same lock because otherwise timer_delete_sync() can deadlock.
> +	 */
> +	if (old && sport->lpuart_dma_rx_use)
> +		lpuart_dma_rx_free(port);
> +
> +	uart_port_lock_irqsave(port, &flags);
>  	ctrl = old_ctrl = lpuart32_read(port, UARTCTRL);
>  	bd = lpuart32_read(port, UARTBAUD);
>  	modem = lpuart32_read(port, UARTMODIR);
> @@ -2320,21 +2334,6 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
>  		ctrl &= ~UARTCTRL_PE;
>  	}
>  
> -	/* ask the core to calculate the divisor */
> -	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 4);
> -
> -	/*
> -	 * Need to update the Ring buffer length according to the selected
> -	 * baud rate and restart Rx DMA path.
> -	 *
> -	 * Since timer function acqures port->lock, need to stop before
> -	 * acquring same lock because otherwise timer_delete_sync() can deadlock.
> -	 */
> -	if (old && sport->lpuart_dma_rx_use)
> -		lpuart_dma_rx_free(port);
> -
> -	uart_port_lock_irqsave(port, &flags);
> -
>  	port->read_status_mask = 0;
>  	if (termios->c_iflag & INPCK)
>  		port->read_status_mask |= UARTSTAT_FE | UARTSTAT_PE;
> 
> ---
> base-commit: 793807ca13bf3072fc6d16ce6d90e9ab9beff2a5
> change-id: 20261111-lpuart_port_lock-01f7deab451a
> 
> Best regards,

