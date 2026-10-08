Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023089.outbound.protection.outlook.com [52.101.83.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06EF3D333D;
	Thu,  8 Oct 2026 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452966; cv=fail; b=oz9+T9j88oV4SYaThKrxGcYpYZjZB0v4FpgbFWHUhJUxKO/c2yQ8DLioqyeeQILFH+4br0kr0Z6sF9VpGUhReu+oXZyVS0YXne4LZsN/Poq2TWt1KC/KAq75M4OttrS4sPFMH7MNk2AL0AVuyTedQN3FkcHacemEEk9xKuTpjxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452966; c=relaxed/simple;
	bh=ze+nqhK1SVJtloL9Be7j55ofTH9g7XFiZwFWiSjaUaE=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nn0KuSuu7VooJVJRrfJa/V9AWEr4HWdznmAViv7YNcTSSOWzPFRfUuayAs1+4zcE+GpitgSebfD6bZFr35EqTF3A6AyQI3QapFAJT//CZSaB1iR5XmoS95gJcxfrlFHIeYwpIBbf9JW6umlZYJ0b/tGloj/M4hkmscJKOLYjBDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=gFWIIjzo; arc=fail smtp.client-ip=52.101.83.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="gFWIIjzo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XVQq7R2K3L5pv2Uilt0SfNJ835/az0dQp7XGAyvJm5+01ZihvxbAC3yqWlSP8RcrJm30i+WbbCpJtEX6GCNIchJl6dth//2Hk+kVa4HgJK5fZQ8++DkBPUWZ7pbjfi9AEol8zquaagL91nLN7Qoc/DPjQFQCQrU5tlMRRahYEFg6VjpI4+WCDEkUTqGUUL8feOArJs2FkYaVnnBr3xjQHqk0tud0W0yAE4v8O3tU3+Lsch/fFSynKAV8LhcmnmHyMkAGsnmZiejuO0GsCBRRh9nuDZa13a2sVXpbhPJimjhkwn60Z4Im1TQimLTdHbMgnC5bEwXwL2c49hAX4VoXZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJ0ljU5F7/Yi68hMdY9UCpdDLj14mW8Ako3HmrEALEQ=;
 b=R9fQv0pb+DVU0qGOmpmtPLAJwUnCSassSCZ1hmQ/fx6lmoX+AtVgV6onwYzCF7iAn7+qMc5CKm5GO40yvFcAd2JUfpHuW6zDjy7shq9E5CdCZKLIhlRGNg9V8nFkCFqbe3LZEZmuOHVjkQ3aBz4jYC0OuPmrlsvawuOxqdcHWUV8nBtgQv/C7zFf0lnjWYyrMWmGZegLw0sDUZHbwhkeapiCvpdQVmKswWlQQnYbeQXin0Ur8OBao0+dP84jI89E2NSY6GZAheSsabWM3Lr9TJPhyUDhrLJ9Mel6KpsVN1VeYvmr8xQXRC6audZHSoP4TQEhh3wAECoU8BvvE8uCMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJ0ljU5F7/Yi68hMdY9UCpdDLj14mW8Ako3HmrEALEQ=;
 b=gFWIIjzo3zsH0KiMk3NmEYN06OBF81vuDqqZDX4DfIC/5UNXwTpPaZWmIKGlZd7TiEthStfOIcBoORe6zl+ZBXXBZ5biGs9cj48eDH3UeJSIAtBr3c+P/9GiWuRpR7rsAiuKitwPqkErYcrbU1kXGf8inCj4MC2ECl5mXOfsIdffbG6RbGRgt2bSeEffn4+z6Aoqg1x4cQ9/rO9YQFAIyjrOkdet00Fpwr0dgnbC8TR9vsK3VvkD5qnLcRhA420d/hROd0q6MlwkFDjGFevTAoqgg4gKQrUpKePceuXv6ko2uZ4jmjvQoZZFxzWeAVBt8B027LYV2e3n+TDz8W3+dg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by PAXPR06MB7567.eurprd06.prod.outlook.com (2603:10a6:102:dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 09:49:10 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 09:49:10 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Thu, 08 Oct 2026 09:48:30 +0000
Subject: [PATCH v8 7/9] serial: max310x: schedule tx_work directly from the
 IRQ handler
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-max310x-rs485-sw-delay-v8-7-6ba881f81e1f@vaisala.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791452935; l=1761;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=ze+nqhK1SVJtloL9Be7j55ofTH9g7XFiZwFWiSjaUaE=;
 b=PQ0ZNjF+nAwuAkoglTCGdSJ0hhBUNowSMs/AiMlPfJ0pWo6+3h+EsRlnH2EwtSQ0UjZDHDUmw
 f5EnHOrBNSNCGhxNuHRjaZoY6KBs5AW9Wk8bcnhgzbWMvRhLGCElNau
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
X-MS-Office365-Filtering-Correlation-Id: e050c542-2258-4585-dfb4-08df252161d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|10067099003|11063799006|260925021311599003|260925022911599003|260925021911599003|5023799004|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	JyxgDX5U3XqEIUf7MARDhZJAetXgtTbuCI5N0pDSdeA9zEunJOS0TeZ5ycqaN2FcrkG+V9bdiUYnQ7PpDK1Bx1SXnfC1kufWSmVL71+zyabLcWo6DleOliIfZmJlU79XHpbsH0RHzUybaSR+JWxbi5aZx9Mb7JZuN9DgR4MBNh9XDojtLES3lhSfmM2VpK/s4L9812lbRroXTDsqqcMXSiSwkCp9Pv2frEhg1zpxwlAnaGa5Kxg23GQjLYRP10XtP6ucIgPeBZKbJTDHLxzJyuaCiCpUJb3nPS/f+IAYCAmRKWNrbMTC2JaUJjkE7KwCgIls1rC8KolmSmAPG3I3/AaoTVA8I0h7c8eESEZUhoSurs/30ntxEWMPQwlrc/00N8BxPtDCn31GnMKXwc8S7ojKEh6sin82DCckxyIFPjtHqK1IEOl301kQvLLvUy+E1AX57VD8lFqacjtTKaNIFyyLV97GmkO9s5PdIV78gX1WjVPrQiVDZ/NypnVRfplsmSOsal1aaIg9Ri65AEFCFo4ttjk1s4E/mihuLUWNznjLSvSWb1Y4gQew00AGxPCYwxT9t7M+m/W3/vt/nU1wsz+18DADAoIXNIVKqQ2HN+670FYI6vJ1gP+4JxI3IPm5b4m30TVM+JsbzYaaKApnew9A34ZaR7HnVUKhxzSuckWdyvX/6I5zLQscTqEeNKtDVntFnNiZF/6w5P/PeFecBDOQmGTujQ5S/q9IFSsYOtU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(260925021311599003)(260925022911599003)(260925021911599003)(5023799004)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SXdFdW5nUlV2ZWp0SUQ2SjdUU2ZBcGpUNlQxRTlHRGg0a0gyQlJBR1FPVENr?=
 =?utf-8?B?K3dXVkRsZ2pSTTF6TytzOEFkWTZXYXN4alFuMDV3WkVtUm4rZWJrUEg5TzV4?=
 =?utf-8?B?Yk5zQmxuejZMeGhIMU9ia1VDa1oreElQamVTdHRIbUpORE45VXBjZmJkWFND?=
 =?utf-8?B?S2Y0NVVMcDlYdXkzRW8zL1RiWVJ3VE1vb0pVdGFTNjZmYm5pWHVwc0ttcW05?=
 =?utf-8?B?bGNOQUNFVWNZY05GTlV3K1ZpMmp0WGk0VExFM0hhY3ozMkJoZkxVSGtTUm1l?=
 =?utf-8?B?bmNRaHk1OW05TlFmWDVtUmIzYWxtWDhWTGF1Z1huL2hrTnV3SHdkUTUwVzdl?=
 =?utf-8?B?TUFBMytXSzk5dERnK3IrUi8yVm8xQTloYzBDenBoR3d1L2JoNkJzUmVremh3?=
 =?utf-8?B?eXhWUmk1Y2NnMXc0TWY0T2lsMnMyTTg1ZExiQTArZ0lWQlhDUHJFSi8yc0lq?=
 =?utf-8?B?clpYNm5uRnJObEpka2lKZi9lNXZPWHQ5aDYwWW1KL0s5akk5Qlp1ekZ4RzZu?=
 =?utf-8?B?ZUZxY2NqTVNKd01YR1V2OXdKYjQ2QTFEZzhYcmNnTWZqS0xPSUprM1RFNlFX?=
 =?utf-8?B?RGUvS0RsZlZNMWJUcnI2YlpCUEdISXJacjFzNHhIQURGQXp4MGF6SFh0TGpw?=
 =?utf-8?B?UEtVQnVQZG1YSGNnQkRUODlVclZIUU9TeVBramk1N0JSUWNsa1JqY1pZREFt?=
 =?utf-8?B?RXNvMDhMeGl3SThRbXMydjgvcGpMcDF1OXQ5YisxTDNGdWJ1N3ZXeGplcHVJ?=
 =?utf-8?B?UlVEcXlkSjVac0xjWU5VTjBTLzhaR2o1OXRDQnUrSnloN3RNbkJsbUJCSzkw?=
 =?utf-8?B?MkhTazJ0c3ozUXZlaUkxb0NqUUwwSjZaNm9VQlVMVUwwY1g1elE2eHU3ZzJk?=
 =?utf-8?B?ZWJqV0REc21OMUVuTVR6MVl1VUpNTG0xZjhaRjNSSW1PQUl5TmQ1SFJ2eEpU?=
 =?utf-8?B?eVF1THJhTDgvcWdkRW03WDdUTWxZdUUvMjVmaXdBblJhMlUwdG1lVENIQnhO?=
 =?utf-8?B?b3JFMGRQT3BoVlBpN0dxa3E2UDRDSzM0TXBUSlZXUzFLYytMdUlrcmltZVRn?=
 =?utf-8?B?VUMwQUlLMU9rQ2lxVFN0a2NodHFqSVdsdnRHdnY5L1dBckRIbHNadnN4VFJQ?=
 =?utf-8?B?NXdUbmlVQlNBMGwvdzVwc2lvMmpkMXlRY3hxeWc0Q2tpOWQ3SFdvenB2V1li?=
 =?utf-8?B?bzhPeG90QXFvZEdDdnpveTAzUVhTb1lDVU5tQytWWEU2MEp1bEljeWRzK010?=
 =?utf-8?B?bm4rRmFaMXFyR0N1amwrNmUzemtVR3QxNWx5TUJ2cHc0dEpCS0hoVzZUZnRR?=
 =?utf-8?B?aTc0OWZpNVVLNVZZT0dza3NucVpmdHFlaGNuS0VyTTNYNXViOVJiSXRINXJH?=
 =?utf-8?B?T1FNaGtOMzhVTmc5NGFHQlEvODNVNUxBMWQ4dlBwVnU5c3FuMHpvWXdoVE54?=
 =?utf-8?B?N3M3U216ZWM1cm9pU281eXZVQUE4OGdNKzNOM3l4WEFmSzJZYmlmYjY0ZHZy?=
 =?utf-8?B?dUp2OUc5L01UQlE1TkFnVEVubExITFF0TWU1MHJGQWZST1AzaE1qcWd1NEVa?=
 =?utf-8?B?VTdXb2d6VlVhT0RKeHRpOUIrOWZsUm9Mb2VlbmdGUzl3aGNlZHg2MjN4RmZi?=
 =?utf-8?B?bVBpTTQwTFloYWJHckxPT0ZzaDZXdnBEMzFRYk9MbG15V1BQS0IwSElQNnZj?=
 =?utf-8?B?VlN0bjFhM3JZMlFZVStQOUc3UjEzRWJGME5pRG11VytzVUJoZ0QvV2VLUnQy?=
 =?utf-8?B?TmVsdXNkMWVWeUUxWi95OW1RekV0RGs3NFMybHRoS0xqaWJzSFh5MWhvOFJv?=
 =?utf-8?B?YVVDdTlWRkt6VjFqNkxqRm04K1AwVi9Rb0UrbnU0RVZ0aWVsalAxNU5GWHQ5?=
 =?utf-8?B?V0lXdyt0QVFVQlRqYlQ3YUJSZnpScDRLbWVKVVJNMUlWNjkwa2tyREYxSlF1?=
 =?utf-8?B?eGNtZlFGTG1TaGQrL0NnMHVzLzJ6Z1ZFRTdXQjlGejVyc2VBcmdYODg5UWVF?=
 =?utf-8?B?dHFkYXF5MjZwZGV5ZVhRSmJPaFFwK1hpTmFaZzVsSC9TTUF1M1h6Zy9lK3ZT?=
 =?utf-8?B?OEVDUmE2UTFMeVZJN1g1cU5xV2M2L3lBeVBadlN4ZFU2THBOc2FGTU9xZDY1?=
 =?utf-8?B?TmNqcnVNZ0tsTHpDaWhpTnRlcDM5eTZHWTdRbERZVmt3c2lKdWMwZEFIb0Jk?=
 =?utf-8?B?RGp6dU1aNGszczE0WDAzcldlY1FTSEEwdnloQlJ5RTlDbE5lV1E1VHB6Z1Jt?=
 =?utf-8?B?MmhTOXZnN25yaU14UDQ1aElnN21yM00rRGlnYWlCUDJGOVQrd2hiRnk0T3FS?=
 =?utf-8?B?UlMvTlVVL1hWQmRBVnlVTGMxZ25zOGttVmk5S1NkcXVMNXJrVm9UbkRyZ3l1?=
 =?utf-8?Q?m1Ilo+c4+R+zkvVI=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e050c542-2258-4585-dfb4-08df252161d2
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:49:01.6756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zowvnuzRl7RhLWSgwUuvOm9T7ymlYoYRAENAaRspbvR8y+TAwNl6zOfwLULphSqVK8w/sZOtQJVcrfcKLVAY83FvP6IhFrDWzZXxtKSTqnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7567

The TXEMPTY interrupt asks for a FIFO refill, and start_tx() does
nothing beyond scheduling tx_work, so going through it makes no
functional difference. It does conflate two distinct events, though:
start_tx() is the serial core starting a new transmission, while
TXEMPTY can only fire for a transmission that is already running -
the bit latches on the FIFO's non-empty to empty transition, and the
IRQ handler's read of IRQSTS consumes the latch, so a stale TXEMPTY
cannot exist on an idle port (if the bit were level-triggered, the
handler's read-until-clear loop would never terminate).

Schedule tx_work directly, keeping the interrupt path a pure FIFO
refill. This is preparation for a following patch that adds
software-timed RS485 RTS control, where start_tx() also starts the
RTS envelope and a refill must not restart it.

No functional change.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 0c40283f44ba1df712607218aef24cb642ba3918..c1fe4ad8878392613cbe4d7805eb8ecb454176d6 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -858,8 +858,12 @@ static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
 		}
 		if (rxlen)
 			max310x_handle_rx(port, rxlen);
+		/*
+		 * TXEMPTY latches on the FIFO becoming empty, so a stale
+		 * interrupt cannot pump data during an RTS setup delay.
+		 */
 		if (ists & MAX310X_IRQ_TXEMPTY_BIT)
-			max310x_start_tx(port);
+			schedule_work(&s->p[portno].tx_work);
 	} while (1);
 
 	return res;

-- 
2.47.3

