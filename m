Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021077.outbound.protection.outlook.com [40.107.130.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6E843F4B8;
	Sun,  4 Oct 2026 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116216; cv=fail; b=kax3+dG/MIlBV3Sfn9oRI3XB72Sux7tX6nqctz87SfTa1Ys2knaAlzo+r3sPLOB+6tsfUpgnXbIUrTxZhqA966cQFS1nFtC3jYa3yudfrKklUv7u/Qc8tkmF0mBUXHuhuoR+M+rRtqwdNwJ72k46q1Ur6EZJd+Zy7VTbcGrhwVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116216; c=relaxed/simple;
	bh=ONFssbccF7R5JxXySBUPDO0nqw68IxVCdSoVjRSgI5k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ab+1zS5Guq8I4xzxkxrLzVNCbEbzh8xvjdIrGOg/rHGQbgFdAGqtEyadTBFxBhtmT97XJWHui1nU7Tmb0AhHbmtWsCr8B4VkJOXrtVBoyU1/kz/5VHRpVQqxv1nU0x6xPch19v80M9H1ysJjILbygbXYIo9P9maWCspuyNVohn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=FQJfT711; arc=fail smtp.client-ip=40.107.130.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="FQJfT711"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0sMyp5hE7Y9YZtDdMeKFMWHuH2jjwG+0n0fvaUDdDrtaW++pzDZXyLPBp7vX450CcdfcFouJ4FDnN0HdPGHd55uwNFBSIKd4vabtFEz8gafeybrv2GTOLNZMjoeT+bqVaFNh8bf6HrFEge28M2v8dTBiXUd96sx2SQhdJGr/k66dCuSBkDLn+1Fo/JW9Ns9z7h/2szyafUOKXbKcB/+29OUlpXPLjmnL4OgLZAyefogpbvFVoHVhYx7AGZohdn6/5oAwws7IdWmDX7k9E48N4X8opA5cZ3F9alYT+kjmC4oOlUAQL1QrAPb0D6DUxRvM7ZFFc1tgK0528X74ZPXoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Enx81wo6Qe7BB2dtSscFYIe9m5mKCZc0t2UUtgKFd1g=;
 b=rpK/XHDjcUKOJyqcqYQcntL+e1xqfQgHHI0QrMkYnwFHCW8dIoQTnvY1PRZbsQJitq9sDQTN8vuycXIs72np7qN4DF7KXlqXPrjKrhB1xcs+nwhZn4abWfbfEDLA7saYDVJUdJcxhXmMAxFn1zbtFE3i67wZ7rh8GW0447574sI89nQ1Y0pma1kBPGCZ0dfjjcrAZ92MobIZLhnM0ypNPWWELS0kEFfKeBdrgjtFepC4EOrmA0wVcF0kkpQ/vbTQMPhCSxjxS5ot+oCQFtNWAwwZaFCRNg9XoFD3XROQC611Tz1RFyMyuCjEWLjh1RsQSl3QzoP9xHy8S3m9Nx/97Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Enx81wo6Qe7BB2dtSscFYIe9m5mKCZc0t2UUtgKFd1g=;
 b=FQJfT711dsEjxvWxsRlluoLQkmdvy4UzBUV1BIxXqdUzPb+6pwEk7RCmkd+8RavUneEDVnr1+SSVgPzGGKC6i2Om2/wkbeLh+3DYK5BogbVqdAeAJT7YujQDJwOqvyUKos3V3CNZAo67TkjKZQhiVaEEuKUrCWRdPhRQpye3oceRL3G0skojtkis4lle0W84vXv2eosCCuIHGv1Dut4hnDoN7VukqRp5SVBrvu57CIkQVTSjN39W5qtbym+A7zFlOqCJl1zzXeKr1ciIiEU6iuJlK+W/H/0ypBroRFgyOLJudw6eqn46bwC414nWgsg9Brpth0XwuZsjMjvdL6tvZw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by VI2PR06MB9239.eurprd06.prod.outlook.com (2603:10a6:800:221::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 12:16:35 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 12:16:35 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Sun, 04 Oct 2026 12:16:23 +0000
Subject: [PATCH v6 3/9] serial: max310x: centralize the RS485 transceiver
 programming
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-max310x-rs485-sw-delay-v6-3-3a0ef13ed9e3@vaisala.com>
References: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
In-Reply-To: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791116192; l=6071;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=ONFssbccF7R5JxXySBUPDO0nqw68IxVCdSoVjRSgI5k=;
 b=JXh4YBix9jITcRetLR4364gMU2lUADwfC9Q822UOP1g3K/oZGb92N2JUi9rD1hn0zIBt/c6UO
 O9ZJb3rP2oABPFvNYpLB2f4nBIvKWwZxAtfIdCABuz7g0M3tzGya1A9
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVZP280CA0005.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::6) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|VI2PR06MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: 89e48b33-1075-4fe1-fbd3-08df221155a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|52116014|6133799003|18002099003|22082099003|10067099003|56012099006|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info:
	xlPxtoTOeDeyGbvVxUC+GFAc3O0WkDRk0ia8jqSNixC4bIdMUZraDlC1l/zEjFmaM+vaQl/a0Kad8o8bqUKeBbPHlRlCvOKdHgtU4gKaoucArR3f1xZ0bdXJqp+5j7c/7h1g7buSkbPnY5aVr/ulyEAQOfwcRe1kBsb2ytwiWiZkkMf9fkj71Fc6UngPurWbddFZlIKJJ983ENrfhrnQ4xfqkeaOYpjMB8LnZBlNuRxNTcFYnv5yOOPpeRVkFx7kZ5CIUTQRPUIajSMCMqfJQH4NitOb1qQGIIE9Gn9o6G2g1QnQ+aw9A+RFnTC6RkrakblAlzWbxOHR9a2AeDikgDHw2Gr/pHDkkstyvXdHG3GIx4g8MKgfzyu87f+XBFmTbpYwuk+edDUw8q6UX7YL6rznIwIuTJXMdz60+1/uOOLKK4zajqS9sOlVIIMxlMH2X8M/Vfs+jwU2WtEGeLSIyALZTCz7OyP53CmoD4PYomyO8YECjVjvcWgKqERIUJtMSdur3ToC57ORKL49PWyW/BAceELe+LhAaeeCJhTvq35/mNIqZn8eNL0f2TOaP411+SgHhaeXIZpWCGg3DHhdONdm3wbo98dhkl9eb0ZhbPhnDZxOSX62ku8zunH7iTiSlAGx1S0hbBfNZZSsqiVanzBjNhF3PptLAQjJwrLpPzqH3Ewue7MS0BtavSUzQ1ZWL3hmB5lEGblhm3bBd9GgtLoRS6buqCVzWEaTjFZOFu0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(52116014)(6133799003)(18002099003)(22082099003)(10067099003)(56012099006)(38350700014)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ODllaFlMMEpKZVQyNCs4UnJmZit6dGFKQ1ZRSkRoc1RLYm5Lcjd3NXI0ejhr?=
 =?utf-8?B?UGVFQmdzRGROdm1pN1h0RWQrMDN1NTRvcEIwbkgzZmdnWjlMNXNWNTNsVi9M?=
 =?utf-8?B?NFhSUlVJQ25wMkJOSFVxWkVwanE3T09WR3NFRVhBQjVMZ3pOUVBqeGxLa2ZC?=
 =?utf-8?B?SzNMdCs2OFBTVDBkTmI4bnhmeHNyZWZoMjBEVHF6djEzZ1QvU3c3U1hWaEMw?=
 =?utf-8?B?Q0FBNUgrakZuK3JvbHFiRmVkRUlIUnB4akpMSmk2SDZOUGFyb2JHcUxyWFZl?=
 =?utf-8?B?enByZnAybGYyVG1GWVZNdTJvSzFzSjhhYzJ5SE9BL2FxU2tDdW5ac2UwaE5P?=
 =?utf-8?B?VnNLMkgrakxrc3QzTkdpeldaT3AzMzhOaUcyYzdoVlFPdmtMTCt1ZDQ4dkpv?=
 =?utf-8?B?b1Rnb0pOU1ZJaTlHcWlnUWQzNXlZNHFOR3FMWEF3d3ZKbXQyenB3NE5wQTZR?=
 =?utf-8?B?aEVLQ3dwbzJmd0g0ME9DRDVXNWQwdTFnanl4aFdpbnBRUWhjTGdLa1JObVlH?=
 =?utf-8?B?anpUZTdVZEV0NkFpL0dJTFlMcXQ5VC85bUxTYi9jMXFtcnlLM1ZGZFhYbG1v?=
 =?utf-8?B?T2VRb1ZPUFJnMGNVcDZxL0hDQjBaVWtocWF5K1lzQ25oRkdRajJyS1ppSTB0?=
 =?utf-8?B?SzJFVWxjUGs5cTEyYVVFVlF6V1F6UFdFZTdhTU5uYlBsSTkyYnNXbTVpT2M4?=
 =?utf-8?B?NktIdHE4QUp5RTdmWmZNRHpUbjJRblZXdkt1S0VrV1F6aHF3Ui9IaGxpaUkx?=
 =?utf-8?B?ZzhZMm5YUTVBRXBHS1J6YmZpbm9XN1ZQYWFiZFJhbzFMeVNrTnZURVhQWldU?=
 =?utf-8?B?YmlNdGg2Q21QV0hzdndybGN3ZlYxUGhzYUhnd2gvVTlZZmw3cVgyK2JLekV1?=
 =?utf-8?B?TXlyMHpKbEJvTlVxS1pKb2lyS3RjdC9VVmJ2Z08zbGYvaGlvTlBKWUVyOXFO?=
 =?utf-8?B?WTBhTUdyVUlhRll2ZDQ1UEhvaFBKQ0p3dTJFU3lBbHcvdHNVRmFWUStPeGFT?=
 =?utf-8?B?d2VCcVplOTgxSXRvbTdQTnYrNHQvRmJoOXlKUTRiWFlBY09oTjhFYzFkbXJx?=
 =?utf-8?B?cWJjejlxOWQxUmlUUkxGZ1VVdEJ6ZXlYOHNac2lja1ZmZzd5ME9XYWZjdTBD?=
 =?utf-8?B?QURSWVBaY2FkSkZ2aFJDVjlNSGNjdVljTzVyZklHQysrMGNDK1NMWDlBRGho?=
 =?utf-8?B?d0VrRG1yNWFuZjRTdVRmODRhUVRvSXpjTXdlalM3RGttYnFvcUhoUFA4WGI0?=
 =?utf-8?B?bTI1Qmptc0ZQanlIRW1EQTYzdkt3NGtFaThsM3pNczVxelFVb3l1OFhqRys3?=
 =?utf-8?B?M3VoTTZIL1Y5ci85UnNuTWJobCswWFE4bFNZTDJVa1cxK2UzR1BkeTRUK1ZK?=
 =?utf-8?B?eVJRbTArbTd2V1dvYkRCa1RRZ3RzanZMbUtUT0JuU3c1eis0VkFBeE1UZTVs?=
 =?utf-8?B?bmx5djI0cnkxNEpWOGNNK2Npa1Jhdnd4OHVwM0JYc2poemZZV2RzNUM1MFcx?=
 =?utf-8?B?NlRlZ0JNKzc3V2xFaitnOU1YaUdNMmMwSW4wZmtxVzUxSi9mREdVdExPaThD?=
 =?utf-8?B?WXNlbllMOE5Oc3FmNXhOYWduNGxSWktIMGZRZnQycTl5WDJHbU5KRlRsQ0M5?=
 =?utf-8?B?S00rUEcvUzhSN0hWWElaeXlHSmc3WWpNM1M4Q0JMWGwrRUpqYlVtWXBRNExR?=
 =?utf-8?B?NWlTNThhZXpqSThLcmdwQXBKb1FCeWNWYkMxbWtDd3MvR1dYRnVvTTc2WHJx?=
 =?utf-8?B?N3JWVjI2RUdnMUZkZDl1bVFJT2I2Yld3WWhhUjIwb29zdHh2NDNVMUdQUk1z?=
 =?utf-8?B?c0JEenVkREdvdEtCTnBEYm4yM1ZaSk1kM1FWcTFFcFQ5cGs4eUNOQWc1RUQv?=
 =?utf-8?B?ZWxZQXZFTkhhT0JiTlZTd3Y0bUFJTWVkMUhsSXdXaDg5V0svbFNobE1Oa1pL?=
 =?utf-8?B?citHUkNoV2JZbE1La2tiSitCanM1VGhRMUNpaE5YQkpxdFB0TmswU2Y1bXdl?=
 =?utf-8?B?amJTb0Q3YnhlRjJRc2UyQ2N1Y2NvZGhkUnVqbDZzM3R0NVZqTXVWTWJUSTdu?=
 =?utf-8?B?K052cEhXbWNSTEduV2lzamJSR0NianV3bjZPM0ZKTjgrWEJtR0toZTg5UFFB?=
 =?utf-8?B?UGIzbVVBaVlSbnFkWi9LbVdvZDJlSG9uSktmMEdic0dISnJmZWtCa0xlUXNa?=
 =?utf-8?B?czdtVG9VNHNYWm52ZENrUW1mT0ZLeGtZVSt2QXZFUGV1TE5KUWVFVEhpeU94?=
 =?utf-8?B?WnRPOVhHMFFxOUtFZHQrR2M4RzgwOVJSRno1WWo1RWdTWks5NnR0aGtBeGdq?=
 =?utf-8?B?ckZIeFFlMDlVbEdiMkQwSzVidG5zZlBiVml3RlJvWjdadXJRb1NKcEhHT0VD?=
 =?utf-8?Q?3PGVMfV/iNqJNYqs=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89e48b33-1075-4fe1-fbd3-08df221155a3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:16:35.7314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BjPy06YEAlTR9toK9aSko+NlXjhaXKapuyt2Un2GESd+jofdcjiXWvZ4haNYCad7hWHgpC8SMJx6/8mY5I99JaqVyONuf6CI/1RQQNNRkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR06MB9239

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

