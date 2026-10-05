Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021074.outbound.protection.outlook.com [40.107.130.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2326F48380B;
	Mon,  5 Oct 2026 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206445; cv=fail; b=QtjwAUXrsHDAT8UiKtqLffrFH9vfQr91RPrmBmT1KUihqoluchUYFh/J2sm5G4Wu4BNN42DScHXhB4WsM/4UDcFKryLYb9FvdJ3olUAbZVC9aqabNpwZDP0RM+PqQrBk3URBgvvkbpnIUbacfrezFZqCflVej6ftbLAsd0k2fSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206445; c=relaxed/simple;
	bh=ws/Wiv0Goo0U3u8+4SLD72tMKtjYct7l7Vhnt1v0cw8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ryG8JJ6bx8UWmRkn1yYRUSl7/Bj/DAPquaG8oDOJw/wrIsQZI7BX6iagtt1hW4GUL9OVADSh4tVmESgOs7lClC/wkqsAgbPokHJks5zbjOOb5RpuT3tp7W8u8lPdXO/n+Tfue8AQYdLBBsZuAtx8DueepzdPRcHDfzTEt6ynGfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=t8VY+OVI; arc=fail smtp.client-ip=40.107.130.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="t8VY+OVI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEesG9j9UNhRQWxdhgzTnqUFcCd4ESwna2oaFRUUdIMN9m6YMFmLJ0G7k5sm1VzYqf/YJgAEMCOldR2rGvJcirWlVuxz9ms5SCACH06I6FCpognH6oFIIKdsHLPyV4tO4Cn13gYvkGGLEUJ9I4Zc+8vxlc+/PFwJL+rXr4i9Sq0Ao5hrsJGfjdRnANqKF5S6hLIcmY+3SJ05KAcG1HnCJkngTaG4okyjYFK2a9p7h5WFmY0DmJr/5/kCTdXpSZ6orAvUDQGs4Pb5CVG9Ldp8wrb6muGfRWI4W0s4gTTA1WWcaLtaW2kumAQq1yYgBfVv9oBeiLL1PAukbgbocjbI0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDiVwI1/MnCrjVLx+HA5+Dx2IXUBMy/J9bz03Poh56Y=;
 b=x+Tjewzbu65UtWJqm9V7xzVRHTc1QU95GQmB3ay8lBs2P/JqOBbd8VgCKo8+LotCUtx8uyKabOZeC+nkkWrMIi9bsnCJWNT81mAVAUBFWozuUgE45F295cP0BexPN0MKPV37TrkmKYSS7YAs3byXvD70x24aYwU44kl2cvR9ps5D7sXV//B2CiaiEnYMdhKybP/llqzWLAAzq1pndgGht/r7srIGjKcBzF2meQIC4rcAdlJ78URQZ4cBNyGHZ54jrzEbcgVbRtF+qFWJpv19evbgj5qTZVy1wphQr7iQG91fgoicKXOlYk9GNrxK3C90S9b+2saMnnuxeKzZTCXfsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDiVwI1/MnCrjVLx+HA5+Dx2IXUBMy/J9bz03Poh56Y=;
 b=t8VY+OVI+5SQI8lBPuTe5RK2BILK5aBCRjGBwnZ3FS2tQKUgFJAVXTfJxVEHBg3GOteNtkBXm07pPVRJAQVHn3MWI9TXT6SHMu51NGcryLlfF6Es1mNUNNmZ87FZyWTc6a66a44DxWkafAnd2kTm4LqMkSL0sh2UFhIp7orrCCG/EsI5702LpKTk+9CM/YiKdV0QoF/ntuWCPdJYmgCirNwrsKsz9EzVF4BXmovk2L7kfk8CeklYpvpCIdJbocS2rvXAt5dCIdmwtf4aWWx2m3DfNc01X+A7Gj5sVJlaNrse6mgWCzZcGqngZqyFxyP2Ksv1JOQRu5CzjMUZ1Woh2Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by DU4PR06MB10187.eurprd06.prod.outlook.com (2603:10a6:10:622::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 13:19:59 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 13:19:58 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 05 Oct 2026 13:19:35 +0000
Subject: [PATCH v7 4/9] serial: max310x: convert RS485 delays from
 milliseconds to bit-times
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-max310x-rs485-sw-delay-v7-4-6ae392eca08c@vaisala.com>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
In-Reply-To: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206394; l=4609;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=ws/Wiv0Goo0U3u8+4SLD72tMKtjYct7l7Vhnt1v0cw8=;
 b=ZBGFB2g8VbR2TUIDEjTHEyNpXtOjP5Nf+qS4q8+jS0Lag24T/cKmQZVtNMb//UFCqnOBkFQpg
 L/NjOMIBf0VCi2K7U+BTG7/UoRolcec3RK0GMrK42+XcM9H/HMi40X6
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3P280CA0101.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::16) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|DU4PR06MB10187:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bde3b15-6c04-4fc0-7331-08df22e359f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|52116014|22082099003|18002099003|38350700014|6133799003|10067099003|260925022911599003|260925021311599003|260925021911599003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	zAehpsUbMzJfLWMWe+0quyV/S33DMmHCtqY9MGKGGC8hQt34f+Ul7OEmbmOxlGQB5YClKTjZSMkfE6zu/8H1yBNaxQ/4k70IBJZCInApfLjIQmhsNA24w0VVLFWTxApuDqkBhTNRCR72Oeh898uCTieU1NbV9F7ky6eMH5MDrzFuh/wjjAR/Ki6VvSaivToofhB5iOB2khhhnSEWtohBfTlc4Fz4sK10kVj7FaRabJkKZErlmG5EFe5Pokp7khXEQHqGfV9MVodb0qOADlyaBTH/MKVv+Bl5i1jYp6gcmS+sPpT/r1SdXs/eF6wnirEbv6NpqOg97LxBQxWAqRw0Q0tgCxYmPsEh32BsH74mGFvxONqXlB1c3f9Z4drd4NdiSLOcYpTgHlwA8xezWjzucoz/3Bs2eAIS1fR/CQRX54e4XH2b49haSDwR5HzgFsoHOVWSP1xlNb66tFX9TFKoDkWS1MFDXYeETGCUmuzi2ReWs9RisMHWa5xbiWxpdeKrtf7slOT57gQrlbMCxEkUOERB+rWcmjnF1PvUnVeeXsL5KxS/Di09/FL991ZoEtG+WWaSleTYdT+vByNRkbB1WQSQZrpFFizbqcYJ7zIQfLHczXiIWkrwRDStzyQM1U1e+apnY1gsnHfnpQC6SUj65rSPyUpMmZ1KT2T5wioCS6HbY1zKXWQrrmNwAY1J3LCcuqXrFNiYp4wVT+WkbvHMsh6TnuREbvRhqTUeoTEsqRs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(52116014)(22082099003)(18002099003)(38350700014)(6133799003)(10067099003)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDZpNnVwZXE3cWd2Q3Q4ZzZ4MTZBYUQrWU0vRUE5WnJMUHZrTlBWVUtlVEtG?=
 =?utf-8?B?SlRIZG03Vk8vV2IxcEFiUTdRQ2hKY05IQjVLUW1OUjNRbU5pdStqTGU1NzUz?=
 =?utf-8?B?bnRSb3JXbFoyMlM4aVNJNlFUT29HWXJrb2pMaVRhNEg4Si85bURqVmhJMUUz?=
 =?utf-8?B?bEIveGozMVlIQldJNHVzK2c2aUxIWFByWUpibHRJSW5iTkc3ME8xZjRvU21k?=
 =?utf-8?B?WjdCcjFUaTNlZjhZR3QwcVlUTEFLbmxlSldrZmhnSmpDb1piQ1BwMGdNZ25E?=
 =?utf-8?B?Zzhoa0Y5ZlNTc2ZwOEUxclNIY0NXVWt4bDM1aE01WHdsZ0FxUUNCVlBCeWNE?=
 =?utf-8?B?NWtIMzVQVU1oZnhlTlFQK1ZYdGhnbXp0alpvY3laRjlxL1I5WmtMTVhISUE3?=
 =?utf-8?B?dnRGNnY4eGR6Ty93akRhbUZVL25sdlZVelJxdEx3ZGFlNDc3bEsxaEhUc1JY?=
 =?utf-8?B?NXlMQVdvRENmNUh3cCtKdVFtVVgvRnZGb0VsbnF4RWxFUUxmUDRCVkJWNGMv?=
 =?utf-8?B?bXpLMlQ1MzdNTWE5QnRxeXZTRkZXT0VLQ05hSVlpNGxYNSs5ZlQxTVowajNL?=
 =?utf-8?B?SjRLdFFheWdWanVVajlMOUppa0J3VU5ZVS9DT0NISjRlTkY2R2RrcmcxUWFV?=
 =?utf-8?B?ZnU5cUpZd0FCVHJsaGUzL0ZzTFdtazNqZThUd0xpalRNWWR4NDJoaUpEbUtn?=
 =?utf-8?B?YklkRzQ4SVRIRWpWMHp0SGl0T1RRb3R1WFpieE02OWhxTWdHMG1iaU5XNkcr?=
 =?utf-8?B?TkRvTEg2Z2ZuNVc0T00zRDRwL3hYaFVQQmVzcUk3ajUxU0hJSXk0ajdwSW1o?=
 =?utf-8?B?OXN0VTJ4U1QzSjFZdko0OFFUcmwrVTVUV1VlWllEMkRuSXhNR0RFNUNCUnow?=
 =?utf-8?B?cHBYbXNlVTFJeXkxU0d5bVdLNFBUQ09XNmpEVzR1N0lvdG9pZUFUeU81OFNV?=
 =?utf-8?B?YXpmZEpNY1RPSUxzTituMTd0aU9jL05NSjk2ZnhjSUVwalhCRmpzb2JYdGlD?=
 =?utf-8?B?UU5CWDhVY3BwSU1BbTNBRmx1UDVLL0MwNlp6WGd3cWhQZFVvbU15cURmVnM0?=
 =?utf-8?B?TVFhOC9rL2RGai9lTkc4NWdvYUFrbmgyZi9rQjFQUU5mR2xISnNWY1FoQU1h?=
 =?utf-8?B?QjZtazZoN1IvZ0JSNzArck5FSWZSL1FNSng1YXJaVlZLUGpveFVNQXdzMlBX?=
 =?utf-8?B?VXBjTzRZVmNHb1orS3J0Q1NXS3ZFK3lFQkVFcnBoZ1BudEJSdXRkL0c1S2JI?=
 =?utf-8?B?MFhHTCtleFJVOTkxNGN5ZGJPa0JkcGk1Zm1vNW9CN3lPYkl5ZEpsak9IQ1ZR?=
 =?utf-8?B?VnRuVnViQk9SaXBUL3ZNWUE5ZkpvSW12WHRCcUw1NnZzOFhvNkFJRHJJRnRU?=
 =?utf-8?B?eFd1bmlCVUgrNnNOcmVSeDlPZXZ4NmMrQVludTdheWd3ZEdYL1R1S0tXTkhF?=
 =?utf-8?B?bVFjblUrQUl2TFFxOTRSNjZrUVhUaWRvT0tqNmtibW5GVnduVnFWSklrS3h3?=
 =?utf-8?B?QktQcitFVjd2bzVyWWM5ZFdheENQN1FGVURhL0dYVTdYZnVBRGtWZm5uUjV4?=
 =?utf-8?B?L0RZVGJXRHl4bCtPeWMyRk1oaXlBNy8zd04zZTBOWHNPNWw3TlloNlA1WnM4?=
 =?utf-8?B?MGpQKzVkazRkaS9rTWNWc0VDUlpBVWZzaTZVYWU4UmprR21SV1VXUG5jTkhu?=
 =?utf-8?B?ZEJiU1RwL1lIYmNMcUh2NFJWQ3g4ajMxRFh3UUJSSUdYS2FGaUxwQ29JL0Fo?=
 =?utf-8?B?UTZteHovai8zeW9ySU1CMTNzZzM3OFBqMmlUMUlaTk9wZkFvMmVtakluMHg4?=
 =?utf-8?B?NVRlUEV2YjlMWEhHMHlTeE5vQ0ZvcmVORHpHN2Y3RmhzenVNTzZDSUVwMmFC?=
 =?utf-8?B?QUhHdW9jWWRRQjdTTGlVV0cyN0o5VytSQ2Y5cUxSeVRDRDd6eHV2MVJLQzM2?=
 =?utf-8?B?akRGdGxWb05qVjdaRVl5VXZvTjRaemYxME5iamNoWmFpUTBrRUp3bHlQUGVC?=
 =?utf-8?B?QW5wdkNFZ0J5eFduNjM3aGo0R2ovN1JqeVQxNEw3ZnpheWNQYmx5UnJZNUNS?=
 =?utf-8?B?RXB2N2FKa2poTjZXc0Y0N0J2TWpsWlgyMVNDNWV2endlNnd5UkFsV0xVa0px?=
 =?utf-8?B?UG5iRkR2L0tEUUFmeFh0eDB4Sk1mNlJtb2pIOFk0UHAyM044M1BKdWlwakUz?=
 =?utf-8?B?WFFiSnFPY2thTVV6T2ZFdC8vajFJbDZmZjczYVBuYlM0U3UvV2lLWitqQktG?=
 =?utf-8?B?RlduMW13dHFWV2NxNExBU3EzL25hT1pVQ242Y3k2RlMxSWI0cGFBV2hVZVFU?=
 =?utf-8?B?S3ZVdk82MUhvMmJGMW5IeFpYRzNuZDJ0RnZhbGdXVlQwWVd0U3o1UXkzNC9J?=
 =?utf-8?Q?ulmxF/voNHwmxecc=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bde3b15-6c04-4fc0-7331-08df22e359f5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 13:19:57.3031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5KSYcITPF6NwIAcX3QumuIPbjACnyGeIv5bYMnNxwSMytOnDDZRp7SGad5QnQWbwhLBe++sXjgtYacbM0aieti3zjbX7mOGGGP3Zxoy2IE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10187

The HDPIXDELAY register counts the RTS setup and hold delays in
bit-times, four bits per direction, but the driver has been writing the
struct serial_rs485 delay_rts_before_send/delay_rts_after_send values
into it unconverted - and the uapi expresses those in milliseconds. A
requested 9 ms setup delay is programmed as 9 bit-times, which at 9600
baud is 0.94 ms, roughly a tenth of what userspace asked for; the error
grows with the baud rate.

Cache the baud rate in set_termios() and convert the delays to
bit-times at the current rate, rounding up so the delay on the wire is
never shorter than requested, and capping at the 15 bit-times the
4-bit field can hold. The conversion lives in
max310x_set_rts_ctl_params(); set_termios() now calls it as well,
since the conversion depends on the baud rate.

The delays a 4-bit bit-time field can represent still fall well short
of the milliseconds the uapi can express; requests beyond 15 bit-times
are capped, and the -ERANGE rejection of values above 15 ms remains in
place for now.

Fixes: 55367c620aed ("serial: max310x: Add support for RS-485 mode")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 85353401e09b1481996142432b1279f44fefff1d..2456a2af891f5296cfec833d6406916073d2865f 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -165,6 +165,10 @@
 #define MAX310X_IRDA_IRDAEN_BIT		(1 << 0) /* IRDA mode enable */
 #define MAX310X_IRDA_SIR_BIT		(1 << 1) /* SIR mode enable */
 
+/* HDPIXDELAY accessor macros */
+#define MAX310X_HDPIXDELAY_SETUP(val)	(((val) & 0x0f) << 4)
+#define MAX310X_HDPIXDELAY_HOLD(val)	((val) & 0x0f)
+
 /* Flow control trigger level register masks */
 #define MAX310X_FLOWLVL_HALT_MASK	GENMASK(3, 0) /* Flow control halt level */
 #define MAX310X_FLOWLVL_RES_MASK	GENMASK(7, 4) /* Flow control resume level */
@@ -298,6 +302,7 @@ struct max310x_one {
 	struct work_struct	md_work;
 	struct work_struct	rs_work;
 	struct regmap		*regmap;
+	unsigned int		baud;
 	bool			tx_break;	/* break_ctl() owns the transceiver */
 
 	u8 rx_buf[MAX310X_FIFO_SIZE];
@@ -935,23 +940,33 @@ static void max310x_set_mctrl(struct uart_port *port, unsigned int mctrl)
 }
 
 /*
- * Program the chip's RS485 RTS timing (HDPIXDELAY) and the auto
- * transceiver control (MODE1) from the current configuration. The
- * rs485-config worker, startup() and break_ctl()'s break-off restore
- * each carried their own copy of this sequence.
+ * Program the chip's RS485 RTS timing. The HDPIXDELAY setup and hold fields
+ * count bit-times, four bits per direction, while the uapi expresses the
+ * delays in milliseconds: convert at the current baud rate, rounding up, and
+ * cap at the field maximum.
  */
 static void max310x_set_rts_ctl_params(struct max310x_one *one)
 {
+	const unsigned int max_bit_dly = 15;
 	struct uart_port *port = &one->port;
-	unsigned int delay;
+	unsigned int setup = 0, hold = 0;
 	u8 mode1 = 0;
 
-	delay = (clamp(port->rs485.delay_rts_before_send, 0U, 15U) << 4) |
-		clamp(port->rs485.delay_rts_after_send, 0U, 15U);
-	max310x_port_write(port, MAX310X_HDPIXDELAY_REG, delay);
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		/* Convert milliseconds to bit-times, rounding up. */
+		setup = DIV_ROUND_UP(one->baud * port->rs485.delay_rts_before_send,
+				     MSEC_PER_SEC);
+		hold  = DIV_ROUND_UP(one->baud * port->rs485.delay_rts_after_send,
+				     MSEC_PER_SEC);
+		setup = min(setup, max_bit_dly);
+		hold  = min(hold,  max_bit_dly);
 
-	if (port->rs485.flags & SER_RS485_ENABLED)
 		mode1 = MAX310X_MODE1_TRNSCVCTRL_BIT;
+	}
+
+	max310x_port_write(port, MAX310X_HDPIXDELAY_REG,
+			   MAX310X_HDPIXDELAY_SETUP(setup) |
+			   MAX310X_HDPIXDELAY_HOLD(hold));
 
 	/*
 	 * A break owns the transceiver: break_ctl() disabled auto-RTS and
@@ -1107,6 +1122,13 @@ static void max310x_set_termios(struct uart_port *port,
 
 	/* Update timeout according to new baud rate */
 	uart_update_timeout(port, termios->c_cflag, baud);
+
+	/*
+	 * Cache the new baud rate and reprogram the RS485 RTS delays, whose
+	 * millisecond-to-bit-time conversion depends on it.
+	 */
+	to_max310x_port(port)->baud = baud;
+	max310x_set_rts_ctl_params(to_max310x_port(port));
 }
 
 static void max310x_rs_proc(struct work_struct *ws)

-- 
2.47.3

