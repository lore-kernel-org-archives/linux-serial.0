Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023131.outbound.protection.outlook.com [40.107.162.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75DC4E50D4;
	Tue, 29 Sep 2026 09:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674748; cv=fail; b=CtYZBuyhipZrcmAJ+X9ImlwwW2mS8wS+ch5jSKxoUpUkYHvI+Bc6j4RjEsaTFdEEfdi7MIM1ytlePS4DpGUkcOtcIiO0u3JZOw0AjTvW0Za4vPYOREfOU7dOWdQqPF6Bn5ajeWJvjZmbgCuZesu3wgHCXLiT1LMAnCiEeaiSn/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674748; c=relaxed/simple;
	bh=qyR9JiEhhdhUeQINI095zz35mQq5HJ06/6E+X6iCHPU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VxPvogoz5+XJcY619BgqnFu6+O0ke1H0ytea95633i7dAqNHw2VomEeoF8ZGYdFWhttxMEn/+eF5FxpPuoJYzdyimlbT1NCWVzjUELP4Ayv5w7wZ34INdtlMgt083Ek7hxQq+m51D0f7VmYAz6sSznRanefj6jIesCVOzDzNSpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=X8XaCXts; arc=fail smtp.client-ip=40.107.162.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="X8XaCXts"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/y3oSuVdw2JyiLaCZt9FbXZ62I/y8wm90T6n5ogj50YXXtnuaMlxresVXkRPxsVq+zHEoJD1B0RS+voXCZnjHnis5Iay+j2xeglNepH2zgb5uxq8F8Wn96uewI6oFI3zcvRBT9iZ9ZWEVArjyfpIyPgTUWCE4662UaF3RhVeOl9oAqpRTpfndBUbwQs/VIOtCgahuBTqUhksMhDVj4fDPSZf7mRnIu8L2hnt0SqkhfJyFl6SsTYpGvnHaPw+TL1IvPKh0KHWPAJxhRUMP3Tvu7lTatiD4C+K+bqyvvckVT+4wkQAb/soEsy3LI91x3OG85nMuLujCTUPrhgNYUEdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TT83l0o1eCM1nL02lE/1IOlPn5MtACyE8oeDMS5OXPU=;
 b=q5XkdApDKyRl8IHAMjRm6SXQwnhYVteVL1MDaYQBIH6AzAR9IaB6uz2kAVHIUWH0zURd4o3pNv2ytMRsgN7ZoaCtnDvod78k2NvFQEJzaaUzvLpUtxN9U3aXNG6yijV2Q3xmjW3X2PNHdqrWlHmpHsShvzLD0Z4E2TIKLkJTNDoJVw8uovfD6i9QnRcr2tTYsCsxRJoE1my9iWCUa8ZH4D+Ieypw0m9b/pnjh/Bb0S9gMeFsLB81b+cR9rssNrBx0jh09d+jBcOcJ4zsywEKomJZG4pgm1nO27fmTyCF1Y9b0u01Tti2K9Yc9f7EEWBQaiFbCqJpVBZ4+Petdr25HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TT83l0o1eCM1nL02lE/1IOlPn5MtACyE8oeDMS5OXPU=;
 b=X8XaCXts9AgmsEX5/wX4CQ1MQXMru8iDtJvgCzoCQ/hNUMQS/lvdwEzeirT1pKGghK9P+H9kQ05QqgiNsCF0UVBu/gnLMtXe6q1OqzfdYmX3GHcwfLa0uPDBw7QdVdH7KhNlhTKszoLDl6HytKIsuwFIo3rILLJHBLyK4WbbPI+u+f2QQD71e3kTfXf8AitTVrew67hRG1NMLuoxHpRwG861qP13QRj25UOOxjUuhwTJ6+2zXDtFxD3PNuadFVamcSC4Q6tMsVv5rIxXZDIiZYTgs/niBG47UZRL5WX6oAxM5nRECDHGWcJsqh8BZu094OsNgUeIBqkikKLu51dUvA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by PA1PR06MB9752.eurprd06.prod.outlook.com (2603:10a6:102:446::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Tue, 29 Sep
 2026 09:38:48 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 09:38:48 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Tue, 29 Sep 2026 09:38:00 +0000
Subject: [PATCH v5 6/8] serial: max310x: schedule tx_work directly from the
 IRQ handler
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-max310x-rs485-sw-delay-v5-6-ae46afa583f2@vaisala.com>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
In-Reply-To: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790674682; l=1725;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=qyR9JiEhhdhUeQINI095zz35mQq5HJ06/6E+X6iCHPU=;
 b=uKFVB13SwoCpgh/wW4Px1qOtPQ5WTzfE6PXpcwr6UHesPBoobyKERgwM2LKzcZVq+HpLQXaC+
 x2ubb7+RRxyC47+SAd5Jbg/iMmvzp6lN42+tIP1soRvQuC+MVRiNpuc
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: OS6P279CA0089.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3e::11) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|PA1PR06MB9752:EE_
X-MS-Office365-Filtering-Correlation-Id: d881e4af-a3e2-4558-7672-08df1e0d5f5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|376014|366016|1800799024|38350700014|56012099006|11063799006|5023799004|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	fg+A3GlhZgE6jop2lyjccpjWdN0Rbnda6PMYrOHeHpGnd3ipgWfBM82xv9yeboAcewyCxFkZjZNO7Ok9k33iyKfwog7ojPkrEZfV8//RZ8g7XGkmLT4v6Dgw6JLYkiu/9C/WqzWDrF+sCyqtc/FrD1XiuBCgDmkQbFikgrw3AvbgGg/NM0exQ6H+cZ3U9r6yhZbsAcYWPKxTcOcGBwiZ2dEog7/IRDD5fK9xglj3gLhYBtxqRNz3xWvUqLvo/HV79zQzB/Qety4a+h8+wQvkqErYcduFp5UI7KVwgvqOI87BOiRyrkU5w4doncD99yt8Bjx3otzUZo43yOjJqL7Sl17qaTi6I+k0nNDkm6JYKbU0I2KseBC4AVcKzDRU7HVm18quYRzwwAl0FjQ0byW25+W6T9aaI20fgEJaWi1cKD5l0ZXGWhPZZeVrg4FoFAth/fBr65aqwnmU2QLC1+Ao8X0qP68ye/OnzSwDnbindI9ghcXXEFSfkXyAhv5x+KiYMNyG/BsdTHp88vaAURUqHERsf9D+QJ35lzfS2XR3eKv90wjd8AQcPJvJ9MnbRw3ZvoczDiUEofrzNV6dk4EvnXeMv2fHhg7q2PgO5CrNktQkrlX9vdqpbbbq9w8ftMUzXx1SVz/PWmlQ549VoeV59cN04cYe82kx+DGeq+JMpOAnfirTd4pL7PWMDdGhlESIancSm0mKXK32GTCjV1bjSg2nrop1w0jagEsVdXC3Cmk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(376014)(366016)(1800799024)(38350700014)(56012099006)(11063799006)(5023799004)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVk1N3V5UmE1MlpIMzdmU1o4OWRZb0tDS1hzV1Z1SllqajlMWE9jV2NoLzRO?=
 =?utf-8?B?ZnFNVVc3MjB1eUxIdzN0ampoZ2dJWnlEdFdwL3RrYnpJRFYrK0d0NWJPdXNm?=
 =?utf-8?B?aGw3WkVUdWpqTGJkdGVRKzFVNFJROFB1dkd0b3luUDZSL1dmSDE3ZHlNb1VN?=
 =?utf-8?B?NExNbHRQL0I0d3ZmWkhIVDA4cXlvd2dCaDlwb2Q3SVVpMUYwcno0SUtnVDEz?=
 =?utf-8?B?cUo0UjNtaFlMTTBXbXBLc2MrTmtkYnZQczlvQnVTdkxnWGNvditvdHN2eSsv?=
 =?utf-8?B?S3hTRUtUSnRuRS9EdmloVHpiOVEwbTYydjN6aUZnOU9WcjlwZkdRWWV1WUcv?=
 =?utf-8?B?WnNhSGlLM0VGTWxjQXd2WGh5Rnh3SkxpWGJXTEVCcjlUMVRzYm5LK01PbFZY?=
 =?utf-8?B?T3U0cjFMR3A4bW5yc0gydXAydkh0Q3JHd1VMMHFjcFF5ZVhRa04yOXp3WkF2?=
 =?utf-8?B?WXkxaVplZzRLQ0U3ampONmVCMlh6bFJZeFhrNTJySlVvdXRRMVVrUmtjaS93?=
 =?utf-8?B?aHRlcWVtRDFaNzNZZG5SZDlIQ2RuaHhtSGE1UXJ4ZGx2czhCRkVtZ25GQmo0?=
 =?utf-8?B?VEdKc1RqemkvQ1puQW9LeW80OFlLREVOcGJuQjFYcXFlQ2c5ay9vVmorNnNk?=
 =?utf-8?B?WCtQSFNreE41L3g0TmlIU3BOd0FrdHdjVHc0U1lEQStNVUF3d3Q4L1R5UWo4?=
 =?utf-8?B?OXljQ2xGQ2ZkQVFYMlhlQURnQ2xpK1EzVVowOGUzRXJaYTk4dWRKYWkveHNq?=
 =?utf-8?B?eE4xMi9zVDZ1ZkVHRklyeWtqNFEydUlTUFcvYnhFRlN1c0pCcmhnZUt0RFp6?=
 =?utf-8?B?YWQrWWowbGpVVkdKMFNyT3F5MlBNOXJSQkRIUk1pbDByQml6b0tnSmRNdGUv?=
 =?utf-8?B?RUVJR1loS3dKWEJrWkdHbEE3bU40aWg0YTNEQzdMbVE3WjV2YWk3UlhDdDBD?=
 =?utf-8?B?UFQ4MUZoVFZ0VHZjRkxvUkI3dFdxZTVZbVdwYWNYZVIxd0lvdExVZkozNzVo?=
 =?utf-8?B?ZkpXa3k0UGFVL0s3eXoxWFh4azlqQkR1RDBDMVUzNUlFWU9QdHlGT1pHeUlt?=
 =?utf-8?B?WHNUOUMvOG9vU2k0NlhITkVLSFRIV0lqUG9MSE5OL2pqUHMxdWRudTFzbkh4?=
 =?utf-8?B?Sy9tQnMxN1YwcWxiNXcreFpleER1MEI2Q1JXTUhDSjdKQ2t0RFRXWnJjMU85?=
 =?utf-8?B?cThZbUVBZFZqRlFGZUt5VWs0bXlKN002eWRDTHpmdFRlR3NEYW10QUZlK252?=
 =?utf-8?B?OXVVR1Rxd1RKUHFwOW5CUU43YW5DZXVHRHVxak5PdHR3d3g0MENQeEd3ZUdl?=
 =?utf-8?B?Y1IyZkNneXdvVEVPRWhKNUFnc2M5Qm0xTU1pVVZIb0R3ZER5TG9lNURiVTB6?=
 =?utf-8?B?bjEyR1FYV3Y3LzR2ZXEwL3ZsRkVHY1RudzQ3dHVpbjR4cG5qY2pDWmxONTZN?=
 =?utf-8?B?cG9yNDhvVWlqZHFYcW1tWjlXY3VFamNOSXNQOEl2MEs4TzZjYmR5aHh0ZHQw?=
 =?utf-8?B?TEJJbXFzcVdFd1hiNXMzRFZFdnh4UGZyblZVZzkzUEp6cktYQzdxVDU0cEZH?=
 =?utf-8?B?d0FlVXFsc056SlRNQmducHl5bDBibHo2b0xnRzcvVkEzS21SdERreThGellr?=
 =?utf-8?B?NDM3SExvSHhJVFh6a0JvYksvb1hYc0VhbWdQc0NhRXlrUzNNV2pRNVUrcVEz?=
 =?utf-8?B?WVo2bXFsVVhzWmI0bExYREVoZkIrMGNVcTQ4YUdQZUhMNDl4T3B2aHJveU1k?=
 =?utf-8?B?QW9Pb3JTOGU2VnZRSTloTVBMYUtmR2tvbHFHQkorK0wxQ1dsRlhFRTJrRytx?=
 =?utf-8?B?S0FWd0ZoZE1VU0E0VUVZWEU2b2NNZTlESmdEbnhEUHdrQjBVMTgrbXpWb3I3?=
 =?utf-8?B?UHo5VXZwZ2R5cGppdjQ2bnZENzVneG5sVHdySnJzNW9IdDlIRWRnaFZ2VE44?=
 =?utf-8?B?M1B4UVQxako0RGVFNnlaVFlTbXZjUVd2d0FhZ0FjS0Y5Sng3bnlDRlVsN2JL?=
 =?utf-8?B?OTBzeVpEeU5DNFlDajFMUlVkc2NKWERqZ3drMXZRc0hqbHNRVUdNK0pLU0N0?=
 =?utf-8?B?SzJKMFVXOGpETlprd3hNUHR0VnNDY2x5UnQvUU1JcFI5SlBHcTBQLzNMYW1M?=
 =?utf-8?B?OWNVQ29SZC9BS0VFSWVDUTBJYWlleGtZU2hUajl6dUNYVzRRNlJqT0tWMWJ2?=
 =?utf-8?B?NkxiOEJsVk1NVjJrWW5yUjcybkpVaStiNENIa1JWZ083VG1td3NFcm54WFJ0?=
 =?utf-8?B?RzZjODRBUm0zSGdLdWpFMnhZbVJxS2lWRUhSMzBhSmNvU2gvak5ZRVRQWWNQ?=
 =?utf-8?B?MDZmNDMzb2xUek1YL29Edmpha2ozZU5US2dEQ1E4a3F5RU1UeDRGQTFXZ2Fn?=
 =?utf-8?Q?WBiihID0SgpSmmS0=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d881e4af-a3e2-4558-7672-08df1e0d5f5b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 09:38:09.5383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6Hzp7v0vkkspb+Wsj7GiT8oOkALGwXXB44TSQhXdQJcQ533OG/Iv4J6JpCJ9K9NnAnkaJQb9fLSCEG71r5+H6lJ81Ko1q70X8L07wLTVQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB9752

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

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index e07fb87f21f102cfa3fdae5275cb7810be1c3dbd..8f8817b127c891f18af52bd3d24efb269db78211 100644
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

