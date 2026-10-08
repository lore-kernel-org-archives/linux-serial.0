Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023089.outbound.protection.outlook.com [52.101.83.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A43488DB2;
	Thu,  8 Oct 2026 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452963; cv=fail; b=CXkRueUSQrjHCWsGaOwP2/Of9hQUCB1Kte4ksPuk/4MueM+SU/S2yNNa1khbQxMI29mw5YiPAXsB4eiL2Nx1ORzxdCIzDy/y7e6CMWfZ77MfIV+aCk9Z/hOGtB405Mljjo3pMphsGwvx0tPD3L+33GzAiTg6dLTaTZGX5pkvWfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452963; c=relaxed/simple;
	bh=asOiuxuRTctXuZ21ZSYyaHBquQuGr0H+fGxsoS3yZwc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=r5p81S1S3S0gJAgjEVU9FxMcutH9EGBzvi7I8WPBCiV49qr3H/qFTE5v3JkMTRwLrVYtE241C7rZX25zdxFb31/ptvWvoZ2Bm/TXuOx2g1IZ+Tl9xU8fb3W5+Fg1CPRCWAmTbtX88Sqds4gerfPnVqcpP28h12/iBa23XSwdzPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=LTL+DpdG; arc=fail smtp.client-ip=52.101.83.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="LTL+DpdG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZcoN10SLNaXIhZ7k44K6ytWJqdaslyGAMB863Glm8QNwSWuhd6jFEqk1z8YUv9SkiyO9uVMNRCDHeTW6EHudN2GO2HiNHXscrCsoP8ngL/Uo9Es74R8s40Hk/F/E3LSw5qq40B+ZK3hHm8pIYzLrv9yvtPKD5oQYjrToXbfzSMPiyVB7HWvpAvV/V+f6IKXNNWTlkMX5i71XsZg0MkpMdMolZeUAZYAqeIsyZp/b/3/uqel1IQO1T3rBTO0tRlUgwRm0VLOV/yV0fjOY8/snp9FJ/kS6Cgs5XqnTccXtpUbLb531UTYUQEX92xdUecRZUc3mq+hh00bdeV09DW8Tug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCI4nSq7Acm8bdxflPoWhzCS/RFOBruuBjOZy5Ayp1E=;
 b=nrFl/kdLCoLWR2naTuAnms2AusRn1BKNdurBolJaAT/Ur0/KcD1DgRk+3ADBeWB+pAO6XyylK65fvje+eAzHxmbRw0zQNAyx4peIeMcShOj6yRWOJOw64jeFLpxa19xP9tuvkljoN6wt1kItJO+x6sL+8iHIVM9Tw+rnQeOB/IzdLeMruP1n8OqD//9Tx+vYWjrVFtL2NRN6zUJY+nhSUPWob6vyOy3y6xbmpjqkSdd0H6eV8N9LeQwbAwd6jJ6n1g6lWgoEl6v6DPuduCd8VNftnKx+JjCasSLDikQJajqUWrWqTJW2WAchjRMI/n59zObYYoogvu1PhhDlT7sU7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCI4nSq7Acm8bdxflPoWhzCS/RFOBruuBjOZy5Ayp1E=;
 b=LTL+DpdGvChjumo8OmCvEp03Tm7Hujx0R4G4ZFcgwsA9yteiqdHxMv97aZ5fypVq6RycFy+bc4XdoET2iYqtsehD6iXXjS0PIJwQMWcP9aOHNSvqJ/HB5ILly+wrpWBUXF7g9V+4VWS+In2Lpdei4e3PWCVXb831OKLzPYEbo6JcbylY1dU5MsagS7HwgTgxmHfcrZ8hGj8dT0BoneZVxQBGUBsf3btkvjqoyIS1egclsWCHVpSSMZaxVaQJ25dlC5RM35sLeSzghBreka3p2OG4Y0tSN1UQMgc+3ByaldFyJMfyx0ebZmgaIiiQ4whQpbqhaADoy3IOxg8ORRIptA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by PAXPR06MB7567.eurprd06.prod.outlook.com (2603:10a6:102:dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 09:49:09 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 09:49:09 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Thu, 08 Oct 2026 09:48:28 +0000
Subject: [PATCH v8 5/9] serial: max310x: don't power down the port
 mid-transmission on close
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-max310x-rs485-sw-delay-v8-5-6ba881f81e1f@vaisala.com>
References: <20261008-max310x-rs485-sw-delay-v8-0-6ba881f81e1f@vaisala.com>
In-Reply-To: <20261008-max310x-rs485-sw-delay-v8-0-6ba881f81e1f@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Maarten Brock <Maarten.Brock@sttls.nl>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791452935; l=5040;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=asOiuxuRTctXuZ21ZSYyaHBquQuGr0H+fGxsoS3yZwc=;
 b=tiZSqeBHwNMYiDxM14Buh9T8hE/3g1GzEbCS8JoiGFgbC2Rro5eO0xM7dS31gRqkHf0hTgTxZ
 N9520t4uTOrCPranqHS2OeOmPmCnBqARaiDbYx5zsj7tys+sMijUNrB
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: OS6P279CA0138.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3a::15) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|PAXPR06MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b3b242-f973-4112-3ec4-08df252160bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|10067099003|3023799007|11063799006|260925021311599003|260925022911599003|260925021911599003|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	/yT30UqYyg3Z4/7jaVwI19nXBIsHtBzHpDz2eeYiM/Uvua3HuagFyda4Rh98Jh4Z6rhXspUVlcq58ewTilc37bhIRE8gy7QJO0mywdswQoqT7y8DHDmw85/5BFUvnO6NUk/UEKpyKK2qKUbcB5Z8qKaf2MOMJAsn+AvMHfD0/98SzogvXTjLDf0keEZpWZKWBbyPaidjyYhDgpydvOmOyQLk7H79ujaG6NMNQZSq5a/ybR2OTrKB4CUegxl0fMpnvvqYkf1++4a7CuyvCBjpzfBH+fzRERCNta76bafWI9+dF/aVaNllmt2C7GLiqMIZ/YBexn7nO8lqvQ5wDXqkVylNxyi9/L9tXT7HXINLBUIyozVvTlfp9bA5O6k0gopb81CLUj0jNHnrtdS52UYMjaU39KP3CnJZxkC9YOV4kGeETHh+KXsKBdd0kj8oUYos/glDhqgTh66uIYqeXN2qNvLbcrK0X8pXkfidU4mqwmmMl9f0oUDYojgw5tYkdMEny6pwwvfFhV9F/VMUPA76Rhf+R6rwGgbiOyFQ+jG6H+CDhmOGPavGFvMsypBfY8Xqmq/c6vkO97dME6jz73BtLUaZzroYfU4lD/+wzEWj2Thn3OuIABswxB7zLrV6WypvKf+/8W4Xr+Ns+tWCuZY9xO5PIPA2sbSP+g+ZcB/H0mzuthMWJcJJWb3Ex9v+dKE7pUjxqQu+qjKgtButEZws/v9zsYrGkaw4lwoZUhFqPVM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(260925021311599003)(260925022911599003)(260925021911599003)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnMzckxSQUhwZVFXMEFkRWQxQW5CeThJd3ZtaTVvQ1lmL0d5RGc1RXBSMFZ2?=
 =?utf-8?B?VVYyUWZ6V3ZRRG1pRVdOdDRmMXd6Q0hFTnAxUnJ2TWJyOTJKbGVuZWp2U3ph?=
 =?utf-8?B?OTBnbFhobEtyaXFGMlJvVjlnL1oyQUV0aEttRHhhTHJQeFcwa2c3b0pKNHZX?=
 =?utf-8?B?VThwU2FaRlVtR3VGQnpaMDVtS3RrSDl4ZHRaSmVSL3BVeUhyWE5lQXhxZHVv?=
 =?utf-8?B?WlhjL3orTnpUNEt4U3ZXeCtkeXRKQldyYmNsY21UYzJTZXBxSkpoTXQ1ZE9T?=
 =?utf-8?B?cDFjKzNaUlpEQXZyaEVMUFJrVVEvTitGVnBsYUhoNFBoVFliRzVZbWpiL3Q3?=
 =?utf-8?B?OS9RV0cyd2NhVWxlUWZQVWpzUXc2OXVxWTg0eC9UWndsYVI0MmZpbWx6d3Rr?=
 =?utf-8?B?VHFqZ3h5N1RLUld1R3FZWjArbUVuTi93c2hvSG1WcVkxVmFPZit4YkFiNzVl?=
 =?utf-8?B?bGRVS1R6bml2b3RyemNSNERXTlc0OFZlT3N5cmVDZEdaUll2SUs2Z1lxMUZR?=
 =?utf-8?B?bStmU0YvZWYza3dzTUkwa2E0OVZ4L0plM0h4S0ZsQ0c2eVhmdm1tUk5UMWJU?=
 =?utf-8?B?dlhsUzVpYVBhRk44YXJGcXF0YU5nU1RIVGdPNmxmZEpEWVpQckZ1MW1IeEJk?=
 =?utf-8?B?aU5pZktRQmR2WEFlSmtCZEkwRDJpQlBPU0Vsd1ptQ2tzeHl4eVNXVkJyTWk5?=
 =?utf-8?B?WGxIV1lyS1JxRmczbEY1NklMK05TZzJvd3FsZTg4YnZQK3UrRVZEOEtOZlZh?=
 =?utf-8?B?b1l3U1IvOThWZHlVTmltekpmY2R2NkJ4S1QvaVpFMzRXdk9yc2Urek9YMVA0?=
 =?utf-8?B?UEw4S3U5VjhIM0J5MW5MRGozeDkrejZhclNtQnJvZkxHMGxxRUlPeVNidW8r?=
 =?utf-8?B?VW8wMDIzdWR2SjY1cjFOR3VzYWUzbG8xM0w4L3B5UVRialZqVTRHQ2RlaGFB?=
 =?utf-8?B?NzZUdlgwWFZpbWR2QjdpTENSaHFPQmdJMjltM1NpWjBjQjZPR2RQWFNSMjBy?=
 =?utf-8?B?OXJMZXkwemJPZW56eDlUM3RuK2Rvd0RXUUYvL0grZ1Z1T0JiWGdYc1UwNVgv?=
 =?utf-8?B?dmt0bU56bW5CWUxkOVVQN09aWHh6eGZLek9PbGt6VjZzb1kyeHlNSmJLY0tR?=
 =?utf-8?B?TWRnbEg2d0FDOVVkT2h6K3dHQjJ0TVJuekJDUWdLaWR2SVIzUEtxSHk2M3g4?=
 =?utf-8?B?dFFxajdNdVVYZVY3ZWY1eU90MFBCS0JQcGsydEV4K2w5MGF6cHl6dDFHNERZ?=
 =?utf-8?B?SjJPY0M1VTRPMXMwY3RLcFVVR0h4THlmc0Y5YXJqbzRld0hUZW1FbDhLZ0tw?=
 =?utf-8?B?WkwyNm0vOEJEeTlGdDhkRkdRMHJvUWVCb3NOUitFRitQcEZkWExwRDVtdVcy?=
 =?utf-8?B?V3R4RUV0QnJDaXpRMWNkT1pDdlN1a2xiUDg5UlNMblV3U1JVbDdobFpuaDQx?=
 =?utf-8?B?VVZzR09zaFNCYmxQY0xNd2Q5R1RmcHRDNUxVYXNNWHljNkw0SU9MMkdmejFW?=
 =?utf-8?B?TitBaWtYdDJaZzhiOUFVSVorYTg2dDFXSkhNT0QzS0RrU2VaOUlnT0lkVnlr?=
 =?utf-8?B?YzU2akdYUDZJVC9NZWtyWnZCcFcvdnEreWpjZll3RVVVQzU1UDkrQ0RqcVEx?=
 =?utf-8?B?MWdXZXowU3dZOUQ2SlJmNStYM1JDYTJFYnJWMDh6cWViWStxdzFhaHBGK1Bw?=
 =?utf-8?B?MEpiL1hUa1dIOTRCU0xQWmZkSHlSQmVwSmhEODUwZXp5SVhqay92K294Z2RR?=
 =?utf-8?B?Zlh0ZG01NUtqL0pTZlpsanZEdE1Uc28zODVBYUJMMkVNOXRobnlseGMvUjJI?=
 =?utf-8?B?eGllUmZTVnBXMGErbEh6RUVrblVhbU1SdWM1SzVLRXROUUFibXdONFNSUVJp?=
 =?utf-8?B?QXY1R28vaXp2RkdOVVowK1ZzVGtTcnZrdDdHdDdQTlM1b2d5VmgrdFBaN3o2?=
 =?utf-8?B?NjhXUndmYzNsN3hGTDdhQ2drMlVTSUlsSzN6M0dvU1lNV0dDNjZGM1Q5c2Vh?=
 =?utf-8?B?a01VLzFRQWp2dEIyL1B3THlDYmkxN0lMQ2FBdndGOEorYkx4L1RudnVTZGN1?=
 =?utf-8?B?RkI3MXJta2VUNHJXMmlscGV2S2VlSUtFYkQyT3VNVlZRV1hsRHplekxxdDNU?=
 =?utf-8?B?NGVBNVZ0NGNNMTIwbHIxLzBCTWtuMlVoTGZxS1JsbWVvMkJtS1MrdkxGWFlN?=
 =?utf-8?B?V1orNFRUem9IUkVLVkVKSDhKcjJKOWdIZmptR3dqL3FTeFdJTytaZnRzeStr?=
 =?utf-8?B?dEFpTU9IcUw0ZFNuTTAyTDdTWDhBSlFTOHNveXFWSXJlUDhQak9zZk5KTWN0?=
 =?utf-8?B?bGk0djc1aCtQMDBrOVFPSzRZc0NFeHM4ck8yMXFmYnRiR0dLd015QzFXRzhO?=
 =?utf-8?Q?LcI3VFd+fGnD6sYE=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b3b242-f973-4112-3ec4-08df252160bd
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:48:59.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5RFdyMm7qGRZYRhfNU5vBk2PZnxKuEDaLmRJ3TJ4749K4s85TJy7mWyKQ5p2VECchXdYJIP8FyDfYoDer8TPJS2nLaRUoHQoscj5DwL1J8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7567

max310x_shutdown() powers the port down regardless of what the
transmitter is doing. The power-off stops the UART clock mid-character,
truncating the final frame, and on the auto-RTS path it freezes the
RTS output at its current level: a close() with data still queued
leaves the RS485 transceiver asserted until the next open, which also
emits the interrupted character corrupted.

Waiting for the data to drain is no better: the tty layer's
wait-until-sent is bounded by closing_wait, configurable to none, and
a hangup arrives with no wait at all, so draining a full FIFO blocks
close() in uninterruptible sleep for seconds at low baud rates - and
forever when CTS flow control blocks the FIFO.

Instead, set MODE1 TxDisabl: the character in flight completes and the
transmitter ceases with TX_ at idle. Give that character one character
time (the chip has no transmitter-idle status), then reset the FIFOs
so the auto-RTS engine sees the transmitter empty and releases RTS
within the configured after-send hold; wait that hold plus one bit
time before powering off. Abandoned data was explicitly not waited
for, and startup() resets the FIFOs and TxDisabl on open anyway.

Measured on a MAX14830: a truncating close() at 50 baud takes 0.23 s,
RTS releases one character plus the hold after the last stop bit on
both polarities, and the reopen corruption is gone.

Fixes: f65444187a66 ("serial: New serial driver MAX310X")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 2456a2af891f5296cfec833d6406916073d2865f..e08e506360d72a3ef4c0ebdca2e60d864973f909 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -302,6 +302,7 @@ struct max310x_one {
 	struct work_struct	md_work;
 	struct work_struct	rs_work;
 	struct regmap		*regmap;
+	unsigned int		char_time_us;
 	unsigned int		baud;
 	bool			tx_break;	/* break_ctl() owns the transceiver */
 
@@ -1012,6 +1013,7 @@ static void max310x_set_termios(struct uart_port *port,
 				struct ktermios *termios,
 				const struct ktermios *old)
 {
+	unsigned int frame_bits = tty_get_frame_size(termios->c_cflag);
 	unsigned int lcr = 0, flow = 0;
 	int baud;
 
@@ -1124,10 +1126,13 @@ static void max310x_set_termios(struct uart_port *port,
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	/*
-	 * Cache the new baud rate and reprogram the RS485 RTS delays, whose
-	 * millisecond-to-bit-time conversion depends on it.
+	 * Cache the new baud rate and the time it takes to clock out one
+	 * character before reprogramming the RS485 RTS delays: the
+	 * millisecond-to-bit-time conversion divides by the baud rate.
 	 */
 	to_max310x_port(port)->baud = baud;
+	to_max310x_port(port)->char_time_us =
+		DIV_ROUND_UP(USEC_PER_SEC * frame_bits, baud);
 	max310x_set_rts_ctl_params(to_max310x_port(port));
 }
 
@@ -1184,9 +1189,10 @@ static int max310x_startup(struct uart_port *port)
 	one->tx_break = false;
 	max310x_port_update(port, MAX310X_LCR_REG, MAX310X_LCR_TXBREAK_BIT, 0);
 
-	/* Configure MODE1 register */
+	/* Configure MODE1: re-enable the transmitter shutdown() stopped */
 	max310x_port_update(port, MAX310X_MODE1_REG,
-			    MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
+			    MAX310X_MODE1_TRNSCVCTRL_BIT |
+			    MAX310X_MODE1_TXDIS_BIT, 0);
 
 	/* Configure MODE2 register & Reset FIFOs*/
 	val = MAX310X_MODE2_RXEMPTINV_BIT | MAX310X_MODE2_FIFORST_BIT;
@@ -1223,9 +1229,39 @@ static int max310x_startup(struct uart_port *port)
 
 static void max310x_shutdown(struct uart_port *port)
 {
+	struct max310x_one *one = to_max310x_port(port);
+
 	/* Disable all interrupts */
 	max310x_port_write(port, MAX310X_IRQEN_REG, 0);
 
+	/*
+	 * Stop the transmitter: the character in flight completes, data
+	 * still queued is abandoned (the next startup() resets the FIFOs).
+	 */
+	max310x_port_update(port, MAX310X_MODE1_REG,
+			    MAX310X_MODE1_TXDIS_BIT, MAX310X_MODE1_TXDIS_BIT);
+
+	/*
+	 * Let the character in flight finish (the chip has no
+	 * transmitter-idle status), then empty the FIFO: auto-RTS releases
+	 * only once the transmitter is empty, and the power-off below
+	 * would freeze an asserted pin until the next open.
+	 */
+	fsleep(one->char_time_us);
+	max310x_port_update(port, MAX310X_MODE2_REG,
+			    MAX310X_MODE2_FIFORST_BIT,
+			    MAX310X_MODE2_FIFORST_BIT);
+	max310x_port_update(port, MAX310X_MODE2_REG,
+			    MAX310X_MODE2_FIFORST_BIT, 0);
+	if (port->rs485.flags & SER_RS485_ENABLED && one->baud) {
+		unsigned int hold = DIV_ROUND_UP(one->baud *
+				port->rs485.delay_rts_after_send,
+				MSEC_PER_SEC);
+
+		fsleep(max(DIV_ROUND_UP((hold + 1) * USEC_PER_SEC,
+					one->baud), 100U));
+	}
+
 	max310x_power(port, 0);
 }
 

-- 
2.47.3

