Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023089.outbound.protection.outlook.com [52.101.83.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4513C3EB80E;
	Thu,  8 Oct 2026 09:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452959; cv=fail; b=QruNake7LGO9I4SkqXDkOyPGPaSzr3dF0gDCglYIOXvhTNMM8pSplE34yzCJNLjLjI9NS//WTxiGgzrBIeObn864Fs8ePPCDfJJV4ox9/4GvoJPRFvQnj2P4RSYJP04W+hMZtywNGoAKXAMhJ2+Jk1jW1TNJ58Cbvm8Ehn5zqI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452959; c=relaxed/simple;
	bh=ONFssbccF7R5JxXySBUPDO0nqw68IxVCdSoVjRSgI5k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=U/AO6EXTtQUrD7lbeGaYOFVSH/4vXK1f0Eb9e513h8BS7v09hMutumNDJ8T+v8ff2/46hYLTrUkwDbdrpxDpSY1MxENWVem4vhw+/Vhrz02P0XdKnRMXTZmcahAcSdm3v6LvXGtvdnD2RBl/zzTtgDoM3W15z87TIe4Xa0D7wUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=nmskvmsb; arc=fail smtp.client-ip=52.101.83.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="nmskvmsb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDXNhBHCbxdS6Xb0v0bJuroOh/iWGqssAmjOiMfunAz4gKu9HtIhpRXdla1gX+HiysgMgMzupqVKkj3Ofr+kN/o+09MhNlYYC4fPrI/LYQ0Px2B99hbeGfRzmTf8HfTfztq/kr85xeiS9BRoXxrDO4bEX9ZepV4L4Xu0/VRF2sQ+O9xNwgSgurTogVv9/LremFbHiLp7GxFCxRvT9VuvkjX8XhnIhTPo/5hxPgqBr2Wm3mND2azH7XugCaSr/w2RM2FAnkpBnPpVL6x/Dhp2Nq3WiuiocmSekuHr59XNutbCZ4VV9U62bXI5og6qa5JhMtpf/4+2sg2DLaDp0YiZ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Enx81wo6Qe7BB2dtSscFYIe9m5mKCZc0t2UUtgKFd1g=;
 b=Apd9+n4loMvAgJPZ1lD5g3lTDuQrDciAIgbTC8nCfZCXrT5hAow+2FiHhjXu6P8xTfanorispVKCr6ItBaMGDhTua9j5d4g+4oJBGl0i5DDsKIrN6eGzjSFDfUDk+1vKj3TQZCgKM0Mcib9PMMTMfFO9xzEVREVM58axwgFs7AbRTJMi1VwRv/9pIuHV8w3ehEFk76KnGS9eqoEENB8TXrIbEshRD5DUPz9fJ8bsAS+wCDDfcwmkpQOPW9skJDVy7KtLL/z0PURR+c0X+MORqI4YC1vH4xtewNTVL6rL5iDRfO76Fm4smUfR4rd+MEKJYYCaO7N4KddbfwRWoJ67Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Enx81wo6Qe7BB2dtSscFYIe9m5mKCZc0t2UUtgKFd1g=;
 b=nmskvmsbJd7FA32m04kiJCZRdlg0+RofSVtHRNlMLQ4aQkTD9UXBzuuqxx7lJWdwasGEdknl5VO6FRUfEH0Ijs5+0jy5F4eQ3gokCYRWTBMzGTjMueYNTisCHwry+pWGAw5/GfsAho4U2uNIz0g5WApZNoI47dChhJKXEE1b0RaT+nz7dHaabl1WyNodarpaZxoUrapHE5lIlDOaj2ykD0WZqIhNpvnxda6Qgld4doQjb2PuQlH3KDTxA4F73BlMgjDwPmx0dx5e3XaM379GymfLkMQNiJrWH0qG9RyBBaYg45yIM3BitlZ2KIcTW/Hy7iqXnakrGMGl+HkkgvWhUA==
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
Date: Thu, 08 Oct 2026 09:48:26 +0000
Subject: [PATCH v8 3/9] serial: max310x: centralize the RS485 transceiver
 programming
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-max310x-rs485-sw-delay-v8-3-6ba881f81e1f@vaisala.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791452935; l=6071;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=ONFssbccF7R5JxXySBUPDO0nqw68IxVCdSoVjRSgI5k=;
 b=ORfNbJgMTzK1LuKYcxKkGkC7xdALSzQQSofn1orIv2XTwnT6+UZoia+JAkwpkNAU9C9kGf+GU
 cRQWf/VxXu3BjZP6vtoOoo2YF7UQMal48nW0xavSKFCydjWjRaPal0e
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
X-MS-Office365-Filtering-Correlation-Id: b15981a1-cf8c-40d4-140a-08df25215fa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|10067099003|11063799006|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	t2+xBT7c/w1bntKAoOyUESmRk6pxjXHisXb2JvAocxzC4QPFvFYH7XraOZfclLo367whzJLBl2QluGHXM8JXZM7GXu8N62vF/NfJF9XbRYmHAOqOQZjne97DfMY8tHV+UzokKWs2WiZ+MJfa2MiQQSNoxe9Ksw3+HhjfdoNI0OrI5zymaqkHJG61TNphTqDZNBF2vUsbE5A2qc7d34yuyNNuHQy7OPkln5CwruJjiEgJyCzJpwJpopMPbM3axw4XRNnB+1nabL4sFE4yTU7EbA+wyIwFLUuyY0aX8NnsMYkcnrFi7IzkN2k3smznkm/WTDjjgY6hyOJq31u+mEdInMqsma/8q5I0AFkg+/g/8spIL4TlBg4S5mWdLMTXSwDJT9v6ACkVWid6NEAni8wNRxd73UiFJ7MbvJAnNwKMp5Kp4OLT/Fo9mSVDHx+ICSN67dtirEkKVCHA0f9EgVknnwPsKkvwHLSqiw3zj7TpfXpX8nwP4kP/G0I2ET87M2bP833YWb0UlVOBaVgiCvxyQgoNjiGloYUMuROrSH1UhAiFFCK21uLfUBtZrDBTdNS0kt84b9tlgYbTK2fPx0kpYCkSfuIqNt8pvKhOC3w3pyK3X313fJCMq6bxn089Az9KtA8Cw+agLlaG0F7Tl9GnRyVI7m66Qv3bLgo7yNYFyf3y7oKG9tg5CeBgtE+J1GV5omcB3WWMGGhExq+MQDO4bmbNrQctqsJqheXR0zPtrRM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWUwek9JTkduOUxoWVBUbFdaVnZaVVpJcXFCUU9qdmE0ZG9XTTJkMGpTNzkx?=
 =?utf-8?B?VTJmVW9JKzl2K1pxWmEyMUlNcWdyQlBhV3E2dmc5WnZ6MkFLdlIzT25LS3Z6?=
 =?utf-8?B?TlJTZkdpYWU4Q2FURkNPK0hwcExWRXZ2OFhtUnphN1ZxWVFjSjF2dWJHZ01X?=
 =?utf-8?B?cStNb0paaWJ6SWk5Q1hFMkh2eTk1bytnV2pwSEo1ODlzQ2hyOUxPYW5xdjZn?=
 =?utf-8?B?WnJlcGdVMXBsWlM4dGpra0ZpUzB4cnFQWmxmTTd5Z2xFQktLSVdzaVBzUlRo?=
 =?utf-8?B?d05TMzByVzd6U0daSTFuZUVRZVFSVUFFcXdhM2NVUnkybVZ4b3RpdkFTYkN1?=
 =?utf-8?B?WXpIaVZRaE9Nc3Y2V29XVEFjZXdZOWdUcCtsYnZzNldmcklLZUpJMUVuSlRJ?=
 =?utf-8?B?UzNPMEdzTjd5SDdsZGcvZjRCWTFLdm1sOXNjYmNCYVo2ZHp1WDFyWkN2Y0VQ?=
 =?utf-8?B?ZURQMFdWVmpIUDdwcVppK21NRzc4emlQSFJZUUF0WWhZQXZSMlMvSUEwbTVr?=
 =?utf-8?B?RGNmVUtQVU9DSVJPTVdlZzd5UkN0VkVlbHhzUDhscnBMQ0d5bHN1ZFRzM28x?=
 =?utf-8?B?TVVlaGRlMU5YMnVjSE43YmdJNitHb2Q2aDlLdlV2ZmJVZ2kyOVB2ZWdacnFH?=
 =?utf-8?B?R0V1eHZBcjlFRFVJTXBSWG9xMUxKWERCSTdValhJZHM2a0ViQXQyL3VjK3Yz?=
 =?utf-8?B?QXlod0M0ZEdFS2p6cmQraWJaQTgweGpDdFd0aVJZRnZMbVZ1MVlLYkhLdGZz?=
 =?utf-8?B?NzFCL0xUNmxWL3ZyTXQzOWsyTWtqMk9rdk5vSWNTYU5CV1Z6VUtpVzM0Ykxr?=
 =?utf-8?B?MWdvTk9QeHQ5bFpMM2tLVkd6YVlSdWdtc2dlVmRjaVB5OWhMdFBDTnlhL1RL?=
 =?utf-8?B?ajMvK2Jjbi9pTDBRSktCRkxZRnI0WE11TTJld1dqbysybTNCREVoR3c3eWNy?=
 =?utf-8?B?SWw5N0xCaDFFa3NJazlwL2RrOTdGU2JxeVo3cU51MUxQLzNybUI3R1pBSmpD?=
 =?utf-8?B?L1BaUktOR3JPSGN5bXA3WEpnazBJRWU0YVk1VkM1N0lKWFdGR01VbG5YUk5T?=
 =?utf-8?B?Zk1PcS8reElGV1BGNXhEVXkrYXBTUHhnNGFuSFBxTVY1SXFqU0djM3RpS09i?=
 =?utf-8?B?c1NqMGFnT1pwOVVmVm1FY3ZYZzdWdStycXEySXpNZEhOUkM5a2ljLzRhSjBP?=
 =?utf-8?B?ekEvNEZZV0ZLSWVZS2xibXhtcGkyVkxEbTZFeTdMWVliY3dEaFpLOHVuQjRY?=
 =?utf-8?B?NXFDcTU0bzZNUUZZM1BiQlJaVm1ZZS9tVzZHVFVYbFJrZW00VzZKWHFNS2JS?=
 =?utf-8?B?L1FKYWI5QXNRb2VuZllsQmxVaTBXRlZDYjZBeXoxTDd4MUY5MWR6b2ZOY1k2?=
 =?utf-8?B?SXFvYjFGa3BKVWdYQllZM0NwSnQvZUI5R3YySks1em1ORmk2VlF0VXlPcDE3?=
 =?utf-8?B?QUN5cGpCQlRvOWp4WWZYMlhiMlRBcmQyajhjSUNUZmNrWE5PbldGa2FRSDBW?=
 =?utf-8?B?enVDQlBZWXNaS09ERGQ2aERiaFhSOUtuREExMVFJNzNhajJrVW02NWlyMVYw?=
 =?utf-8?B?VkJnRnlNeEZUSzNqUTdPUUYrTG4wZFlDYzNlbzB3bmVLeVE2MkdIbVlEZmFC?=
 =?utf-8?B?L1JoY3g2ZkkxSCtEVnhUY3B4R3dCelNEbVcyNUo5YUg4YkJFR2ltN3NLcEIz?=
 =?utf-8?B?YjQxUmhnaTZEdE5QUFZWN2tBTXg2Vkt1RkI2ZURTdWRSS3p2N0dLUFF4NFhS?=
 =?utf-8?B?bnNhYnNXcndmM3JZMVBPd2xURVpNN0pTNlRwRzJnVTBNS2M3Y1QzTDZLWDdG?=
 =?utf-8?B?OXk2RFNSbnppTjNoRlhFK0xldWo0cmhvNmY4a3pGSm0vUFJxWWFCekt5dmk5?=
 =?utf-8?B?eUo1bGJoOEwrNnVtREg0VnhZQVVIdDFzeHorZXNleUhhSStXMzhTRzkvVnlO?=
 =?utf-8?B?S2tCZ2FjajgyTktWMFR1TXQ2RE5SbmN2YWVxMVFoYTVrd3J5REtPczQ5SWFN?=
 =?utf-8?B?R1dUQjhFQ29OaUhqTldpZUMzTlkyQ1grNWVkcEFtL29SNGhIOFZwNEdtZVF4?=
 =?utf-8?B?cm1jb2JjWk5XaWNVT3FrYUhibWxTbWRBVEdGRGhvRzJZb0svcWdUZVZwV0ZZ?=
 =?utf-8?B?NjNvR0RiWndWVEhqa29sWExmRHNsck1uSVR6U3FpWkU3Y1JwTVVyemNzTTBY?=
 =?utf-8?B?aFpCZWtrdGFhcitsb2wxWmE5ZFdxV2FhajVTajQ5dTk2MHRzQmUwZ1ViK0Nw?=
 =?utf-8?B?aTFKcHdaWlkxMlF4bnBFY3JDV2w3Tk9tRGNDY0hRWnBjL2hTWGU4anBiUGY1?=
 =?utf-8?B?MkFvZUNTSEQxR3RqWGRnQlRQM2RQdlVUS1M5Y2JONlVtdmhFeXFpc0JQN3Qw?=
 =?utf-8?Q?bMA97ZhjdfNErpTY=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15981a1-cf8c-40d4-140a-08df25215fa2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:48:58.0085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tdlf/2BeqwZ5Srt1TvfSEnwWvG/8q7F/DW9WFcLb72Xg4CUGjg76bcStcq0UbIWIX8KKMvj/Kpj+c0kFNzfxb0I1/jI/5TwA8AQN1wOLJNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7567

The HDPIXDELAY RTS delays and the MODE1 auto-transceiver enable are
programmed in three places - the rs485-config worker, startup() and
break_ctl()'s break-off restore - each with its own copy of the
register sequence. Move the sequence into a helper,
max310x_set_rts_ctl_params(), together with the tx_break guard that
keeps the MODE1 write away from a break in progress; the break-off
restore reapplies the current configuration through the same helper.

No functional change intended. The copies differed only in that
startup() clamped the delays to the 4-bit field while the worker wrote
them unclamped; the helper clamps, and the difference is unreachable
while rs485_config() still rejects delays above 15 ms with -ERANGE.
Break-off additionally rewrites HDPIXDELAY with the values it already
holds, a no-op on the wire.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 85 ++++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 38 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 319517bee63fdf5e67c311d2575083fd0d8a5870..85353401e09b1481996142432b1279f44fefff1d 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -934,6 +934,38 @@ static void max310x_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	schedule_work(&one->md_work);
 }
 
+/*
+ * Program the chip's RS485 RTS timing (HDPIXDELAY) and the auto
+ * transceiver control (MODE1) from the current configuration. The
+ * rs485-config worker, startup() and break_ctl()'s break-off restore
+ * each carried their own copy of this sequence.
+ */
+static void max310x_set_rts_ctl_params(struct max310x_one *one)
+{
+	struct uart_port *port = &one->port;
+	unsigned int delay;
+	u8 mode1 = 0;
+
+	delay = (clamp(port->rs485.delay_rts_before_send, 0U, 15U) << 4) |
+		clamp(port->rs485.delay_rts_after_send, 0U, 15U);
+	max310x_port_write(port, MAX310X_HDPIXDELAY_REG, delay);
+
+	if (port->rs485.flags & SER_RS485_ENABLED)
+		mode1 = MAX310X_MODE1_TRNSCVCTRL_BIT;
+
+	/*
+	 * A break owns the transceiver: break_ctl() disabled auto-RTS and
+	 * drives RTS manually, and restores it from the current
+	 * configuration when the break ends. Touching MODE1 here would
+	 * release the transceiver mid-break.
+	 */
+	if (one->tx_break)
+		return;
+
+	max310x_port_update(port, MAX310X_MODE1_REG,
+			    MAX310X_MODE1_TRNSCVCTRL_BIT, mode1);
+}
+
 static void max310x_break_ctl(struct uart_port *port, int break_state)
 {
 	struct max310x_one *one = to_max310x_port(port);
@@ -956,10 +988,7 @@ static void max310x_break_ctl(struct uart_port *port, int break_state)
 		max310x_port_update(port, MAX310X_MODE1_REG,
 				    MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
 	} else {
-		max310x_port_update(port, MAX310X_MODE1_REG,
-				    MAX310X_MODE1_TRNSCVCTRL_BIT,
-				    (port->rs485.flags & SER_RS485_ENABLED) ?
-				    MAX310X_MODE1_TRNSCVCTRL_BIT : 0);
+		max310x_set_rts_ctl_params(one);
 	}
 	max310x_rts_ctl(port, break_state);
 }
@@ -1083,36 +1112,23 @@ static void max310x_set_termios(struct uart_port *port,
 static void max310x_rs_proc(struct work_struct *ws)
 {
 	struct max310x_one *one = container_of(ws, struct max310x_one, rs_work);
-	unsigned int delay, mode1 = 0, mode2 = 0;
+	unsigned int mode2 = 0;
 
 	/*
 	 * Serialize against break_ctl() and set_termios(), which run under
-	 * port->mutex: the tx_break test below and the MODE1 write must not
+	 * port->mutex: the tx_break-guarded register writes must not
 	 * straddle a break starting or ending.
 	 */
 	guard(mutex)(&one->port.state->port.mutex);
 
-	delay = (one->port.rs485.delay_rts_before_send << 4) |
-		one->port.rs485.delay_rts_after_send;
-	max310x_port_write(&one->port, MAX310X_HDPIXDELAY_REG, delay);
+	max310x_set_rts_ctl_params(one);
 
-	if (one->port.rs485.flags & SER_RS485_ENABLED) {
-		mode1 = MAX310X_MODE1_TRNSCVCTRL_BIT;
+	if (one->port.rs485.flags & SER_RS485_ENABLED &&
+	    !(one->port.rs485.flags & SER_RS485_RX_DURING_TX))
+		mode2 = MAX310X_MODE2_ECHOSUPR_BIT;
 
-		if (!(one->port.rs485.flags & SER_RS485_RX_DURING_TX))
-			mode2 = MAX310X_MODE2_ECHOSUPR_BIT;
-	}
-
-	/*
-	 * A break owns the transceiver: break_ctl() disabled auto-RTS and
-	 * drives RTS manually, and restores it when the break ends. Leave
-	 * MODE1 alone meanwhile or the break goes undriven mid-way.
-	 */
-	if (!one->tx_break)
-		max310x_port_update(&one->port, MAX310X_MODE1_REG,
-				    MAX310X_MODE1_TRNSCVCTRL_BIT, mode1);
 	max310x_port_update(&one->port, MAX310X_MODE2_REG,
-			MAX310X_MODE2_ECHOSUPR_BIT, mode2);
+			    MAX310X_MODE2_ECHOSUPR_BIT, mode2);
 }
 
 static int max310x_rs485_config(struct uart_port *port, struct ktermios *termios,
@@ -1156,21 +1172,14 @@ static int max310x_startup(struct uart_port *port)
 	max310x_port_update(port, MAX310X_MODE2_REG,
 			    MAX310X_MODE2_FIFORST_BIT, 0);
 
-	/* Configure mode1/mode2 to have rs485/rs232 enabled at startup */
-	val = (clamp(port->rs485.delay_rts_before_send, 0U, 15U) << 4) |
-		clamp(port->rs485.delay_rts_after_send, 0U, 15U);
-	max310x_port_write(port, MAX310X_HDPIXDELAY_REG, val);
-
-	if (port->rs485.flags & SER_RS485_ENABLED) {
-		max310x_port_update(port, MAX310X_MODE1_REG,
-				    MAX310X_MODE1_TRNSCVCTRL_BIT,
-				    MAX310X_MODE1_TRNSCVCTRL_BIT);
+	/* Configure the RS485 RTS timing and the RS485/RS232 mode bits. */
+	max310x_set_rts_ctl_params(one);
 
-		if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
-			max310x_port_update(port, MAX310X_MODE2_REG,
-					    MAX310X_MODE2_ECHOSUPR_BIT,
-					    MAX310X_MODE2_ECHOSUPR_BIT);
-	}
+	if (port->rs485.flags & SER_RS485_ENABLED &&
+	    !(port->rs485.flags & SER_RS485_RX_DURING_TX))
+		max310x_port_update(port, MAX310X_MODE2_REG,
+				    MAX310X_MODE2_ECHOSUPR_BIT,
+				    MAX310X_MODE2_ECHOSUPR_BIT);
 
 	/*
 	 * Configure flow control levels:

-- 
2.47.3

