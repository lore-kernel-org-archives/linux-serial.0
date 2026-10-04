Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021077.outbound.protection.outlook.com [40.107.130.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389DC424D4A;
	Sun,  4 Oct 2026 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116210; cv=fail; b=nbdUgqXje94/qWfHzFoq4x+L0I8FoBYMJyXjb9gHB4fZO/QoqgihVhuPxe0o/uh9QfM3gU7y/QekzaBJi1ui/ea9KAlV/f/s2GdtGd+pVqqMabO49dxjh1f973tJbvxG+0JgI0I2PgHJ0XbD9QRQqtDKFLA2ZDV089oWjc3BYoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116210; c=relaxed/simple;
	bh=JVqBido9Y7eUmijTMCub909FETHemdv54Yqb/mA5S5M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qVhWCvthie30Lhk01hCziZmbZ3051R5M8tjU1OOod9VyTtO5WImn4BKUhQT0xAeIaV4be09NabSU7kZNa3RiTZp3mjSwUfcVjnT98CGhB9KlwEhanr5kPnajf70qNyVOIAIEY1/OkllxYLJym3CvYoxCxodmD0zjlpYu9Tb6mzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=UeOfbGsR; arc=fail smtp.client-ip=40.107.130.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="UeOfbGsR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjhmzX0st99mkAyFW0us79NGLbo4f9hHM96fxsmsqs5QPqsfj4iCUGfhUj+b9QePQ0OmkROm0YTyZKjGVkXyjUk9sdzS+dSY5T5e5Vx4MkFKcrspqiY9CVmnWz6Nq1LtDHp4tyRKb6O2ogQzlfY3NJP6I73W1PdIbOhe+tJjVPd8LSvWtOO473HsnDzZ7ZmoOSK4HXiQcKbc4ZQS861GOSxwXw4FTBLclJXJjoGcjCagEHhMTGTr8wxUZRPBIhaQe5BGGu9f9fNrCpfLR6PPhY9TEJBaoz03ldOebsCV0MlZU9OOcl0jKt5smI8EaYhX+/Ob3HSqjfNn01RG0ZI4WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7DiIjsND3CPxAfQjOEpyZn6uj0R/Qrbpzt25Oopw2o=;
 b=CkKIiYGP05WEaHb9gTSmJv+o6LifB+LuHeTfcH/EPM0MABJ7CDZNBgRyNSN+43cZ2A9wsVymBKUAiTwXlbwpzRIrWwPdQPcYwIhmiXaWM/A5Ec+XV7ZAe9DgxmBO/4z/PUxDmlQ9Z4gWCkmlOhk0tx07n43rvzFuJsx6iY/+Oq0tUXPwsMoBBOEYBI06InGWwELz+NBF6KbowF3Swjc7ufKef4UpbBoTO/WD/O0mNj2OmZVOoW2gjdFWbwc7PO1gLZSJen38IX0h0N3uNvVzJxgV8NxcaetYT8D/68KAHBC0yIJzQUYm5T6WIT8uPmbbJo0fY2gnbzeKfcEqvKxEdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l7DiIjsND3CPxAfQjOEpyZn6uj0R/Qrbpzt25Oopw2o=;
 b=UeOfbGsRSeyaVk4l3M8yfPCxOHCRv4aK5K8Q+eYF340wZl6eujUXBPblLznhr9QgHbQXHSp+aWduRuVDqenz/7LH+zVXbCWddpe8f9uQxRWQEe8TlzRichBIyjCkVQMWV6EHXmo5vhlAlZqkQWd+FRTj3REjjYly8myu+8okHBucy+mFWqCsUGhCTeltYRwIKOgWS4y8zOpwCKiln7INt1pZY8X2n5JR8o/a2YjPhmhssFIG8Iwg7Gr4YH7aBClWkCSVYeKfoXC4ch8zYW7uR7Tb8zhqmVNmB2T2gyXfIWQSjFPHpKQ4g3QlQscuAdLvsB+EZBXgAbyE4AfxQtzilw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by VI2PR06MB9239.eurprd06.prod.outlook.com (2603:10a6:800:221::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 12:16:33 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 12:16:33 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Sun, 04 Oct 2026 12:16:21 +0000
Subject: [PATCH v6 1/9] serial: max310x: don't clobber the TX break bit in
 set_termios
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-max310x-rs485-sw-delay-v6-1-3a0ef13ed9e3@vaisala.com>
References: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
In-Reply-To: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791116192; l=2757;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=JVqBido9Y7eUmijTMCub909FETHemdv54Yqb/mA5S5M=;
 b=UVjrxY6GeDYejEWqDtMgjf6qALOgSjZD7pq9WzgBbjQlCwSLFoXQC74PAFuJidrc9d2l1ZaTO
 PsIBHRcoxWiBkOTD3+va/uGEBl6y7aQuYr6T4bGTNHhG5L9vjTBL2tv
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
X-MS-Office365-Filtering-Correlation-Id: 108fdf4d-0fe7-4bfa-261c-08df2211546a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|52116014|18002099003|22082099003|10067099003|56012099006|38350700014|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	AqZ9th2PEO9UNmJyQcGg8K/6vXchdIyRYpssE3aVWmlcPfBLnJ8+yP2op041mQvJohuDDNqwn3oOdlRlkZbCLCGNcSsTnrqg/F+e014EVOzNPdtPUq1EyrSWDMAxk5FRWJRdQNyX7avFoPAjCuAvfwAhy7wkaMx1YramA66fkkLgHiTtQo2PGYY8LSI9N497Tnr5YmgyNFpfUM9/++35tO6Mg1DEx50WEmbh5nHMmZ2H2VQhzWWpogoE0TcSxPKEU1EbVvS+yNkmU+b+FM+bogD60uzh30tAwl+RwHSwWiFUjJoFZkVDc6TWWUmzMhxzxZysMaatlmun+fGVM9Lju9aWPBA6NTK7bBtivYDUR8Js/gc0qcnDiJ30LpSN8PUkod/N01issIuqVLlifGx+pFJ/reAEp4AqJsUtoQxD4kn3U1WE9nygutBgHDwR3jMch1m8AuTZbV+ZiOGmcq2OAsLMFCAiH8n0XFIZ8Fxsmh2zPvTsww5s5LNIoRYtYnczVumQMp8ed4CSziZS8yetS+YY9XugQiIp1PElR9LH6JNqd1Pda71S/pVLd4bmX131Oli7z3FanOKUsHkP7h/cA8LPrwxjvLPTdlJmTDrbCPOU5/IXQxrnCheDM6OOLVe4G7MFyCfHoh+ILLvJpevkGGcOvlzmgtuh/haF8gRjdB4opjbYjqwbN/KHY01VGT2XqDouoDmNfQp8Scoe1uqfeABC26SNG0mRnvZ4mul6otE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(52116014)(18002099003)(22082099003)(10067099003)(56012099006)(38350700014)(5023799004)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVd3TVVMT09wQU5qQlF5SG9wWFB3L2l3TldNL1BsUk14enU0Z2dzdTFvbmJC?=
 =?utf-8?B?Sko1U2s0UmM5aE1Xby9GN3pETTFCMFZPRU9HeFY1L3ZuVlg3aWRRYU9QbjFE?=
 =?utf-8?B?ZkdSRUFvUVZSbytHbEYvQXF0ckVXYTlHcmd6REJvL215eFFoNWRpalZyZ21n?=
 =?utf-8?B?QXJUTWxkdXpySWtzd040MVlURU5NNFp3VVAvcGNoQ1F6ZG1nUSsxaFcrcFp5?=
 =?utf-8?B?b3hIR0I5ME1TMmk3dERLMCswbmQ4ZkhrdHVLUE9uUUdHcTdTRDhmZ1B6WTlJ?=
 =?utf-8?B?WEhJTURKRVBtbVpEcWlBNVRROUdnR1hKK2pnbUZXakROd3phRU5XaHY4VUM0?=
 =?utf-8?B?ekViZ1JMSDhkdmx5NC80S21IOXdYaFRPQ0N4T250bVE5WGk5UHA0bVFkcFdB?=
 =?utf-8?B?L2NFb01xYWpoZWRNdS9IcUFQY0NodWZkNzZVNmlqQUFhRWJFSDJCM2hMYWxC?=
 =?utf-8?B?Qm9uNWVZYlcvU2o5Qm9FV1U3MkEvUlBwMGdFeVk2WElpMmhXNHRVN2drZmFx?=
 =?utf-8?B?UDRMYXVpZTJnY2xObVIzRDAxQlZ5ZHFFVFlGbkphZENXMXZkMkphb3ZFR1Qx?=
 =?utf-8?B?VHBqN2U2V00zcW1qWEw1NkpBV0NVQmFLSVJiYzVTWnlrN2V2OGoxbDZVK0NM?=
 =?utf-8?B?NGhwYVRjTTByOHNIYWZQZXVVczVxSWtaNjgvVlpZTlRXUWthbGJEZStaZXhM?=
 =?utf-8?B?TzlHcVJTcjBsM2ZneTduS1MxYzRWbHRXMEcwL0dOd1hlc2dPMzhBc2tWWlVu?=
 =?utf-8?B?ZGYzMURnR1JDYzdaY3R5TVBpbjZtc2RYMkV5VnROWERrRkJLQmVUaS8rNzkw?=
 =?utf-8?B?MnFGVzh0cDhWNlJGMmFRcTR1RTlVS2xDSWhubFMvMmcyVTNaMzR5Z2ZJSzRC?=
 =?utf-8?B?YXEyMlBHWXBLUkpaYmVYNzRtOE96UnZxbll3dGxHTzFINVVpVm5PSjgrRTFx?=
 =?utf-8?B?Y2dYNmV5QStKRGkzUDhFMzBWQnZDdGs2UmJKL05MQUF4ejIyVG9OUkorVmdJ?=
 =?utf-8?B?L1BJNmg5cUtyYWpyY0kwSmNnMWFVUklmcEpPbit2U05BOHpPSElpYW5qZ213?=
 =?utf-8?B?bmVvMk9VdDl2UnN2YzJGVk54YVhNc2gzZ05EeFFrd0dvY3FSRUl5cWZGY2cy?=
 =?utf-8?B?N1VKdG1xZ01LQllnZ0FYRlhWdnZxb2QrcVd3VEx2S3d6dkZHY2NmVkNlOG1k?=
 =?utf-8?B?VExBcVcvbXJQb2g0N09YQ3NXT1hBZ0RLckcrekZQM3p0RmUyWnorMDRkbnRx?=
 =?utf-8?B?NStGc2VKZUFUQ3hTa1hVZnlZdWpSWnpiTUllYmdRa1hRTzc3UzBRbGJ1MkdS?=
 =?utf-8?B?cHFPTG5ueVpzVmptc2RUUDdLU21lV2I1TFN2OUhsRFJnTXFjMEFrMEtiaUEz?=
 =?utf-8?B?bGE2SWpvZk1yTzEwUWhEOVlmQjNpQWpyUWJWRElvUitYdE05UU1hUFBLS1lU?=
 =?utf-8?B?OW9WbFpBaW01ZzdLVHlmTnQvVEt4eUJET0U2YlZQcFZjTHpmMXA0S1NsVkN4?=
 =?utf-8?B?eFgvZzZYamtXLzNKVGl3eE5GUFpXcjRvM2VtcGYwUllHdHBNRnRkL1EvQlpu?=
 =?utf-8?B?cjMrMHZ3a2F4cWlabFY1RlBHUUJ5T0h6TzFYcnlaU0I5NXYrcEhRNkJrUVB3?=
 =?utf-8?B?NEJNcnNTNzdXMzBVUHdvZkpxcSt6WWY3RGhYSTlNUmZ6VVpGOEhhVktGOVQ1?=
 =?utf-8?B?MnNDZ0xwQURwRzJFWkVJVjN3Q25pSjF2cU8vWUxqK0dWdHZwMURzRU9tMnJP?=
 =?utf-8?B?TzdLMmx6QUlHQ0dTbzNPNzlPOEhNeDlpaXBtNEJpbmxzMUZoL1BiWE52SVlQ?=
 =?utf-8?B?bWR6Rmx5YUhiVGx0b25xbmEvOTFlb09KMTFkcVJXNXpGVGlNNEJzbS9qNjVm?=
 =?utf-8?B?ZkFWSzk0WDNoN0xoa0JCWFlZby9NRFBPZmFNeG1WRjFVV2N4NGlrRGNrMmRZ?=
 =?utf-8?B?RitFYUp0U1pQNEZXN0pzYU9SYXVhSDFQZml5T3BpWExmU09mcUJydk11ZDNC?=
 =?utf-8?B?OG1aR3MvUEpaSmlCMWhDVnR5cVpDKzVJRWFaZWZDdGZlcDk3SW1aT1VlNDQv?=
 =?utf-8?B?VUdKeWxtakVwM3QvRS9WNkhkbXIzaXhlMXBwMTVrZnQ3UUtxSThYNzVFdXE3?=
 =?utf-8?B?N201T0FCQmpXNENRMTVyM3E2NHNNWWlhM0FQbWZzRmR2ZGhadWtYOFpNVmlX?=
 =?utf-8?B?RTRxVnRvMmZHcXkxRmZHZkd1VWJ6UFFhUERVWjc3ZlEweEx4b0ozTEdNQnU0?=
 =?utf-8?B?bjl6ZG5HT1FmaVA5ei9pZm84czBURkh0QXhtNFRmTTA2RU5lbXlYeUdEWWhE?=
 =?utf-8?B?VlZpU01oRDZqaDh4cGNiSXk3bjUwNnI1OXllU1ZtNU5ZbUJIOGR3eDhSMVBr?=
 =?utf-8?Q?lxKGpMf66kQ8buCc=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 108fdf4d-0fe7-4bfa-261c-08df2211546a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:16:33.6886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5jOQP1McYmwyS9ilfRU2eJZ7Uiq4RJeWCVBtWV6B5czUhIJPVIKWY/84EpGcX9WHn8kSxDiAM6rz8Kk/Uka+qfJT/likPlyzatgRz40LOhs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR06MB9239

max310x_set_termios() overwrites the whole LCR register, but LCR
also carries the TX break bit that max310x_break_ctl() drives. A break
is a state, not an event: TIOCSBRK sets the bit and it must stay set
until TIOCCBRK. Any termios change in between - no concurrency
required - rewrites LCR from the termios bits alone and silently ends
the break early.

Update only the LCR bits that are derived from termios and leave the
TX break and RTS pin control bits untouched. Since nothing clears a
break when a port is closed with the break still asserted - the tty
core sends no break-off on release, and the unconditional write here
was the accidental recovery - clear TXBREAK in startup(), the same way
8250 does.

Fixes: f65444187a66 ("serial: New serial driver MAX310X")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 022502986c5fcf1ff4de9328746ddc71677be730..fead9c51163d8372d1b609ee9cd5b87faa917fc1 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -158,6 +158,8 @@
 #define MAX310X_LCR_FORCEPARITY_BIT	(1 << 5) /* 9-bit multidrop parity */
 #define MAX310X_LCR_TXBREAK_BIT		(1 << 6) /* TX break enable */
 #define MAX310X_LCR_RTS_BIT		(1 << 7) /* RTS pin control */
+/* LCR bits owned by termios; TX break and RTS are driven elsewhere */
+#define MAX310X_LCR_TERMIOS_MASK	GENMASK(5, 0)
 
 /* IRDA register bits */
 #define MAX310X_IRDA_IRDAEN_BIT		(1 << 0) /* IRDA mode enable */
@@ -969,8 +971,12 @@ static void max310x_set_termios(struct uart_port *port,
 	if (termios->c_cflag & CSTOPB)
 		lcr |= MAX310X_LCR_STOPLEN_BIT; /* 2 stops */
 
-	/* Update LCR register */
-	max310x_port_write(port, MAX310X_LCR_REG, lcr);
+	/*
+	 * Update LCR register. Leave the TX break bit alone: it is driven by
+	 * break_ctl(), and a whole-register write here would end a break in
+	 * progress.
+	 */
+	max310x_port_update(port, MAX310X_LCR_REG, MAX310X_LCR_TERMIOS_MASK, lcr);
 
 	/* Set read status mask */
 	port->read_status_mask = MAX310X_LSR_RXOVR_BIT;
@@ -1088,6 +1094,13 @@ static int max310x_startup(struct uart_port *port)
 
 	max310x_power(port, 1);
 
+	/*
+	 * Clear a latched break: nothing clears TXBREAK when a port is
+	 * closed with a break still asserted, and set_termios() no longer
+	 * rewrites it.
+	 */
+	max310x_port_update(port, MAX310X_LCR_REG, MAX310X_LCR_TXBREAK_BIT, 0);
+
 	/* Configure MODE1 register */
 	max310x_port_update(port, MAX310X_MODE1_REG,
 			    MAX310X_MODE1_TRNSCVCTRL_BIT, 0);

-- 
2.47.3

