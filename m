Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021074.outbound.protection.outlook.com [40.107.130.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9236D483BD1;
	Mon,  5 Oct 2026 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206468; cv=fail; b=pxvEYdDa2D3Ajv3gnlUYc3nAltX0yjcj5GOKwMj8XFRZYsdZiLNUbU0MgU15DVuyNWuRgxL9UCNSzsf+lQ2G9Nqpn4Akbwo0mNhdihp58GuVGm73rVI9hFh5W++uSsJlTIX5VeenUnCeBECxQfaWGBBhwd1AlNxFRxL7pfhgHAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206468; c=relaxed/simple;
	bh=ONFssbccF7R5JxXySBUPDO0nqw68IxVCdSoVjRSgI5k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=n5CekCnY+NBaO2526ARel9JsB39xG5gRj0n7hE6b8i+RGbbkrotW5qYdWRVlw1U0anoOVJM/A25jqLjiB/3t2veinuCW0LpvZJ+hPI2EBAwjlIMjH4OrcrCUKxpeGdMJVvHpBy/uMFdIYRq1mmoKWV49vt8EhBJTbLRPMxaHgxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=QnsmEbKP; arc=fail smtp.client-ip=40.107.130.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="QnsmEbKP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+uMoQVg+fxkaRI3gX68a5BgieofMkIn6pysm4DlTZXdlx8X3z9gDHwa4bNXQW32Xq7U0TTrfX9kMc7/Ib53DQvqoFGvMQx8+4M7U9tlHEoaJYJ+l1QTlKwy4oIhiU5QD3SkpjuErOvJipky/oa5qYal0IW9K7EMGeiOgUoqUK35woBMvHQsFt53qVAmh94v+CDgX48x+xjclM8elVYHwAweVQXKVI96UyCXwH2d7UB0KL1VsVyHVimmhkAbdAgGYWgjGC/pyudtrxsPY8mRm9JKUhItmrmK2HYNM5OfRnuYkBwkMRfG8taPn5hsC6f6u6ZMhmrytnXBAuwFacIHKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Enx81wo6Qe7BB2dtSscFYIe9m5mKCZc0t2UUtgKFd1g=;
 b=m7uGkuMZSZfcP36Zk1zoinIqOmLsnuvXMnMMcwvaXLX+3k/wXWqbdAQPe0+pDQ2jbmFcenpEbRzlfXKrB8J5kEbbl/vKKJjXgcX8vJx5fgmqJt2pdjFbaBFS6IJbYwBOtJLRGTNktbmT2nkIGQLERTroXG7MoNieBJYJZI/UrVhCDbWKtao7RBaRyNUNAe4a9ks3Aq6k3PUIJYx7iNoY6buDOzq/Dxxd/E5ytZDY6FoyA/q12uk7tie4jzh0ka3uBs77m7BKeNB6f8uTfK8GxvXNI+t1Cs+qKcYrQ4P0yQ6cAZMZk0hDybYYUofu78dwrk0oamym6M34RrBvjv5law==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Enx81wo6Qe7BB2dtSscFYIe9m5mKCZc0t2UUtgKFd1g=;
 b=QnsmEbKPZcSFngCGNYekp+XOlUk0vFQndQCShd3DSqpSofW+c6eb/iu/AIMp+8cvzZq/f13+goBs4V+j/M4Ld1qzD+KqAOdaQ52qk8YertEw7qPaUfktVqneLV7DoXk0vON2dLC99kZ2FouLnOAFd9ZnRSQp/vj8qIMf/daCfUVeRuAk1IPbStlGO3ulhlmB9d1gypoCblXnM89WAQSrd2w1zcM7BvMA5TsS8tZMQef0jJ0m2uW8vkVlaHnhz34XhAUOFnpZVhqRubkOK/m8dCPSyqbfSlngzBNrCommaVlSkHkaGNsyEkVNjiVSywyMNVwneiM++SHmsxWsLo2Ljw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by DU4PR06MB10187.eurprd06.prod.outlook.com (2603:10a6:10:622::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 13:19:58 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 13:19:58 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 05 Oct 2026 13:19:34 +0000
Subject: [PATCH v7 3/9] serial: max310x: centralize the RS485 transceiver
 programming
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-max310x-rs485-sw-delay-v7-3-6ae392eca08c@vaisala.com>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
In-Reply-To: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206394; l=6071;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=ONFssbccF7R5JxXySBUPDO0nqw68IxVCdSoVjRSgI5k=;
 b=DFE0gMdTek4sJA79Wy2bgu/eOZXuLD34yei/UgRGQeMEZjmKWQL+w+cjlITuES06a4bJav6X0
 W5iXGobauxFCY/BgmbpPhSbhJykw94hfNqpKSXan/WzkcUa98d1NDE8
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
X-MS-Office365-Filtering-Correlation-Id: fbd13be2-7294-4a5e-1f47-08df22e3599f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|52116014|22082099003|18002099003|38350700014|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	iedc8/RrJZywTSfG/TT9zQ0i92OEDgKQMzmSih9iXhid/g0Zty8Nj8bWfX6r2mZmAXf8gVg09Kpny8BnNoC3ASyh/cEIiJR8ysC+onsCCRZET9B+KR/rcI8y+bsHReIydz7/yQMhWHHQEhJPmLQmEdRze3C1svwYkMxtfyvqKC4m29nWhKOft7DhGMotqsVWE6OCcBllZaqzGs6A97a2cEJ0RS5rzgcRGH4REzvRv9qDGHwq1qWkoNTfE0MV4oBKb7bRhZxzUO2PXxnVb+ImiqjVgggMhtoGyipYEK8jItouwbxGZHq/pdWBM+Vq5FIXgeKrJFjh+mku9nclFgiLTL2LHgil1802wCUXwOulFjuM0P2pd0lnsrNxbkWtz3DtebY+J8sw7G52DOTyqUYR/FiN9YPpZE26D8X51Q0KJsR4ieQg8OJfPQ4nHhETfZr4BFdQmZJcfVHlLPW+aBcVIs1K5lWqMI83c8A6VICKMNhaFGnQa6DleRvWlegu+2TqozX7ectnz/UfqYsWdX6RSopc7yuuMojxgCiKVYhvbyHuiXvBhLRCm60YCblVUsFFN//SmDr6/ZvdjrN5Gm7OH+f/IHElHxesesztikS6YnBxWbALFj9S67lSS1Dkj5MhDGF4RzLLMzFG2cPv+K8lQF+mOwrbT2ODIL1zCn9A4LfebzOBUShHZJsoejJmEPvXrbx25ICYGMO0fZxrugZn1lX8x7g+PRpTZ334Zpb9rcU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(52116014)(22082099003)(18002099003)(38350700014)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVJGNXVha2hoMW1ZSklhZUZyYXhZVmpjM3lBTlhsMlBobDlHWWh5NC9QeFU4?=
 =?utf-8?B?L1NEU3RkOEtmQURoR1drRkJzWTN1b2FjL1p3WTBXbG55QU9DRk44ZU42S29F?=
 =?utf-8?B?bjlhenBtNktTdEl3MnBERFB0U2x0OXB4UkZZZTF5UVBZdUJlSkJyMTh2YlRk?=
 =?utf-8?B?YS9QZFplL2hjVUdtcGJrMVBKUDQzODdNa2pTQzRxdnpkT2lJTW5JbFp2ZUl3?=
 =?utf-8?B?OUVPcDAwRzJoTGppd2tneHBkVEx3WUNiQTJlMjFtV1orUzR3WEsyRUlDcEdy?=
 =?utf-8?B?NU0vdFNJNGhwckxUNHlGMUwyRXkrQ1Y2MkdPZC9rQ2sxeUdLdC9NNi91S2VY?=
 =?utf-8?B?WFBLc3ZUVFBoTExBNUhNOGpnd3pDUEdlRWpIYVA4ZENiR0I0emZ6Z3NpZlRp?=
 =?utf-8?B?K2xPVXZ5NGl1RnVkdGppSmtQL3dEZkNoT2tweEhmUkx1eHJkM0FnZUNZTU1l?=
 =?utf-8?B?ZUdEQ2R2ZlRyWjFvbllySWV5cy9ZdHFoTnd0WlVjQ1h1YXVsR3lBSDVpck1p?=
 =?utf-8?B?VE5uV2tCZ09YaWsycS9hdDBTWEoreWd5Q2lNS1VYckpHVnZVeUwycFdEVXp4?=
 =?utf-8?B?elFjemE2TEU2V1R0anJRZXNXMXkwS1VDR3p4RWlIOGpWL3gybTVvWWVVcmFp?=
 =?utf-8?B?bGhZdXJUQlAxdFVkcXFrVG9RVnBBLy8zWDk0dkQrUEdLOFVzeVZnYUNYb2NH?=
 =?utf-8?B?R3c4ZW8xQ0JoR3VURjYyTHk0YWFLcDJ5NGptWG9NeFBmcXdqVUNxQW1xVjdK?=
 =?utf-8?B?RkUvTGxhSEVOQVZBeFZEVGc2bUszSTJFdDNBTVVJTTZHeXdqUUxYMTVXdThi?=
 =?utf-8?B?NnY3WG9uWU41UmNkL20ydG1TM0I3L2dhY3lBN1ZrbFFVUGVZUVFTc0U5d3VW?=
 =?utf-8?B?T2Vkd25malNWNEJFOHA1cnJZVEJqbDR0cGQyWXpLUVlJZGNWYzh0Q1V0UU93?=
 =?utf-8?B?dmRxVGdDRVBJblQzV2J0SUhoNU9MQSs1Z2dqQXA3R1hvM1ZWTnNrQTVnSURG?=
 =?utf-8?B?Wlg4NDdqNUdLQTVvcXIvNFZDd3hhTmZvaHV3VjU1RmVlc2VWK3pJQk9Kb255?=
 =?utf-8?B?TVB1dmUvZGI5Ym55cTRLNkhXQjlMUEJoZFFVSVN2VlVDZys1eGFsYVA5TlNQ?=
 =?utf-8?B?bHN5N1kxVGVubDJPNHZhRVpkaXVBRFFvRnJISDNEVWk1VGpSR3EzOWlYSTNU?=
 =?utf-8?B?UjRmUVdoRDFYM2NSWXkvUjJhdVRNWXd5QXJtMUovb2tXQ1RIQnJiWlBzd1Y1?=
 =?utf-8?B?YzhiOHczRURvTjZjMHBsdW54TSt1RkdXVnZQeENlWi9JbE9yUDY0Y2Nva3Y4?=
 =?utf-8?B?akUwMWFWdU9YbmZJQkx2VlBYbjR2L1NYSzZRNUdPYWxnUVoxTWpiWWtyQ3FM?=
 =?utf-8?B?NkpHY3RrcWJ6c25DdVFJdFRIQmxqeEtDdGlCQ1dNV2pGMnNEWWdZVWJRV2RZ?=
 =?utf-8?B?S29kR3hGMFV3ZU1xM1M5SUFWM0ZkZyttUWVxcms5b005RDZmT29DSUxiUWV1?=
 =?utf-8?B?N1ZHZ3AyR3ZOSG5lNUhmemFSaG9vQlZUWS92SUttRzB4VzVGY3d0c0UwT3ls?=
 =?utf-8?B?emorRXJYZnE2VjlNUEtLOVd3eFU2Q3pBcVB2c01GTGV2NXpWcXpWdi9lZlVY?=
 =?utf-8?B?K1JrSEV3Ukd3UGJSNDkwUCt5Q0g2dGdLYmM1OVIxMTRJN1l2UFliUkJvZmNG?=
 =?utf-8?B?K05zYUVRR2FhV3dCNVZXckJwV0VNWWdaRDBXSU1vYTN5T2N2S2JEWU9TZGZr?=
 =?utf-8?B?ajZDckhuOU9sUzdRclhuU1R6MTBLNlhKdWcwU0R2Y3pZK3Q1Q0dTcTZKZGFy?=
 =?utf-8?B?ZHFPNVNrcStpNkZpd2ZIOStSK2JqcURNcDQ2Ty9zdUVXcldBOTFXTmk4U3RC?=
 =?utf-8?B?dSszd1p0M1pGd1BaT2hDNllXdjhHM0xQZStkN0RWeGJqT1d4c2VRbjRicUV2?=
 =?utf-8?B?d3llV0toVTF3czZucHNrYktqQWI1alJzUmw5MlNOOFpjYjd6U2VHQUgrRUF4?=
 =?utf-8?B?YllGOWo5c0xmS0VKVnphRGhOQS80N3FVMWFjZEo0UkxlaXFOMWZiT0ViQ2JR?=
 =?utf-8?B?TnVFeTllVmI1WjljUVUyMWNSSlQ2T1p1VXNwYkE3Si90MVZZWU5CdzNwUC9y?=
 =?utf-8?B?NDFSSUsvV3IrUDJNUXVnT0VSMHZnK0VuU2JFUHN6K1BISTZPa2JoMHlsMGpn?=
 =?utf-8?B?aTF5QXhrRnhVZXVEUEhMS1I0dWNTRmd2VG11aTVKQ3dkcFhZaXJwME5wT3Bk?=
 =?utf-8?B?cFFQaDRXZEVEbkJlRGk2RERjY1FTNjVuRnZZNkdpWGJDWlpYeWFTbXNIZzls?=
 =?utf-8?B?K1BKNjN0YU0xSVJUOG42UWpMTDZNTWhINzMzZXFDNVQ2dTNwV2c5R21kOW5I?=
 =?utf-8?Q?JItC/IuWiXs43U4M=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd13be2-7294-4a5e-1f47-08df22e3599f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 13:19:56.7145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pQ+4uGgRihV4lHlrTGQDZU2aYfndST1VNa12YreOpNdgnhTPaOSrDVVUlDBTxlwK1CgWcgWmYPm1FBAz/7K+c9f2rclXFjl8FuZxE1jRenU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10187

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

