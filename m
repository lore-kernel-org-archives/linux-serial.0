Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023131.outbound.protection.outlook.com [40.107.162.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455B34E322D;
	Tue, 29 Sep 2026 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674743; cv=fail; b=JmQlBjHiG6cBL7M0U+s11DS/jemAGBs9e6j3KQOgjkzOHbhAtJtaq/mFfVol1u/sBtH8g5DYC+Ptn/5NiVexXAz24rqnRZlsWnX8SpYqCQMNYRhWFXGyyGG3tLZiCjZxKzGCmI1VsPpQzQGlfJRekT4fZbeN+ciKkkv04AvCd54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674743; c=relaxed/simple;
	bh=W2i6Kqh0K5I+ru2hhfRTb6dutcSC8ppUOvImi+wz8T4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=BSzXeydWL0MU/tr46Ns2irOoL3oYO8XvjChFE0cPclyFrN60N/4j7gnbed6o9qQZUif+MbUlAwqKTo+8sm7rPE5aGH4U6BP4lWILsLOh/YpoN9BDF9fwhmcgYItros38fr9o4tAYBQ5CZDttQfvmCofQn1Gxuj+ljer9buIuWwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=g2rF38Lh; arc=fail smtp.client-ip=40.107.162.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="g2rF38Lh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dAgWincS0zzw4SoXsfeGYaRHvzLKyCRin4VTthmor5TkI+jJ2xpqNFQAs91sEaCC26ss2yPXo/ZKJaX0nZ+cmVOGdbp4VG+o/vcYIreHbIZOsCAdZR3Kt+N7siaQGS+BPSzcYFRSi4HMg0oo20V5WZBRLVNbuXapTJkrlzx0k2yIT3sbC272L6QUYL+oIXBDjfmLzdlPOjMtwCuXjGJQsWxJClka55bNoK48+ircLmAmq0XFyjiJExWPMDayHEdsSc2FIHIM0jAKb9xWOYZEI2oArN4mxk7ZKduQlHFCHTpL2iq0uxc9A/XpX5xdLH8noM4h48w05nW6pxqbKgBR2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jMtd0YSzruS6ZD4wrlK7FB2yDtwx/x7wwXa3eTYFZ0E=;
 b=Ce40aFzWR/Ht8wRS1yZ//AjeeoA72LKZ4rAzaAUyzQYAIB14RHz8yWwzMhQrRBQAXx7o1jDKIWScvWJJjrHiG+ztz2YZ6Lxpu16HjgBemSULijjNKTIoc9Pgf9pj9EFwEfX3fDp07XMQ/rQIiIw6fpAn5eecBfYkKb3fRrRWoArCxyD+znpNsItD9ZD1Ne4qjwdwtOkgcdQND2Z1a3Nf19ScR8lFrtacAsK8IiU2AEoiiCSWSlTh1pAl0ZC6WkCSzkJ6PnDg718QcEy/Yb8+4sQL7HLUS/5zVtnokpB+HcLHSCatSQ2V1sssoIF2knOgDrcpG9WdphP1Onrvd2QN9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jMtd0YSzruS6ZD4wrlK7FB2yDtwx/x7wwXa3eTYFZ0E=;
 b=g2rF38LhQ6MDjXyp0zKzMU75ochB9q6IgwnSmRA10YGJ2Zixu7mCWXlj1mhKr8/ejHoUshHYRl6JZFuaIxJ6QzMBs3RBt3xMa3qyqEDcmkoSLWkK0aiE3qOcreH+JWUZSMlrW/GN0fY7nVWs/LVsGOmqihPk5KYmAu5ONF9m7P71UoJ7t5TSWu6F9b1Y/A+uC3cSCTGJz29oXazPjzZIxlzqik08X+b9FpppvesRP1s4dBloAmSlnx/fENPS84K74yVfKfAvwWLqTwvlbLVPSJj7OoZmvnMIUbAUtGPO40Ex05UIbUc8TFkdLb9enDaNcdbY3ZRJNHh82ojFMPEOAg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by PA1PR06MB9752.eurprd06.prod.outlook.com (2603:10a6:102:446::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Tue, 29 Sep
 2026 09:38:47 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 09:38:47 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Tue, 29 Sep 2026 09:37:57 +0000
Subject: [PATCH v5 3/8] serial: max310x: convert RS485 delays from
 milliseconds to bit-times
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-max310x-rs485-sw-delay-v5-3-ae46afa583f2@vaisala.com>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
In-Reply-To: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790674682; l=8640;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=W2i6Kqh0K5I+ru2hhfRTb6dutcSC8ppUOvImi+wz8T4=;
 b=1s6mISLQ79lEXmojM0JGI7aw7/CH73caECdbeyo8LLuAENcy9oKe9Gi/O7y3x7ShvJuYpCKY6
 qgcozmzzcm2CQW7h3m1pzACij2PzJp08J7jV4YxDwk4f4CLtVqR+f4b
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
X-MS-Office365-Filtering-Correlation-Id: deeb205c-50e5-4daa-d33c-08df1e0d5d92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|376014|366016|1800799024|38350700014|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	y6+uPULulnTgTRl8UqT3pERmyxL1DAH7V2d9MZZknPX1RG7qfVRA7y3JHiLtnz/KofycC4QFWm1R3id4AQU84q5qlw9d656f2A4h99ED4XLEZRSUPFOnuCu6+9x6Q70k279kyMdXz10lL41/9WICLMZ5QZsyZPA/9UNypNQ7qzDISsPcKhgcdyXTOJf0jJAb8DMp6ja/eL6+BlOjghepLpum6BeCobzsP6eW9O4WbOI+iOCwELyBZwOauqW+9RHH6MdPXO51jDmSvJCPQdUm596gMw9yexHimX+WHxZ033y4aWOo2uwqfUTiVP4V/07guE6aLV2oSU8LLU6MuKhMb+yK+dCFBEWpaeJHcPSwFia/RxSYJgvYHEtVHJicxbDnYCxGryi7QdF2LGLc4TmnuOfsKRlgXYXM+aC2Q8msUdN3F5uZas5MH36DugpIArUo4GGywxIbsujWSd1IqpqNn6TfAR3e2Sr1vLwqa6G+IJSC8K59P56pvD5VFhhRk9tAR+k1rQNt/5V5maI2ZJR7gSpNKdN7C2LYiXvHcYp6Lrp3dx/Yc0a4i6MNgao2RDSvKGYS0dW3dd2gR5c08SoN4K2350WMbaOvpq+pwEP6Ge1dknN1ZS1zlSLoclA9GovmVV2M+iRAx1lN10W5g0eS1Zc/YjHJEm5Ji0sF5HHaODvltwn35bdspmJYdgzZFEyLey49BEH1QmAe9cYJDY9DUPFszED9Ir0cdAySmUF80fQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(376014)(366016)(1800799024)(38350700014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1dRdEpldWdxQkR1Z1F4ZEl5dlJ2UnZUUEIwcnhrRG14YnVKdjZWL2xCQ3gw?=
 =?utf-8?B?aE80WVpMR0dwZU5hTVVCOG1WT29PTlVnWjNCTGdXL2xYeGVXWHM4RFYvSjFt?=
 =?utf-8?B?SSsrd2ZsMXFDdWZRVHBDdUQ2eEhLZmZYQlc3bUhzS0wzTlZLcGZycDFPQkEr?=
 =?utf-8?B?YURyNjN0ZktVcWRtdmk4TGdlTUtPY2tRbjVPMTdEN0M4RXJFS2FrYkhrZzBw?=
 =?utf-8?B?TXcraGkySStoQ1hrWG9Ya25zZXphUUFCK0JHUDlLMTBhcTNTdTI0UmZKQk8w?=
 =?utf-8?B?SVZlZlRxNTh3VE9OTmtNUnUxd1p0TVpCa21jS1U4MHhpR0RkQjZvTWNLT2tD?=
 =?utf-8?B?d21ieXRwUTJxSHRCNjYrR29hK2FFRGtBZ1RTV0w1WURoaHBvTnVXZ3Z3WFVn?=
 =?utf-8?B?MXJuWEt2Z3RQZGhyK0hwamlyKzVmVDE4VVB6S0VWTFJJLzdrcS9na3loaDdO?=
 =?utf-8?B?VTA0dTVDckFyQTl0T0ZHU0xkYytEQ01zbWYxa1A3NU1GYUZpcXpGcDlCeEV2?=
 =?utf-8?B?OEJlWThXdXNkUUZROVdVb3AzbTN5S0Ntb3gyQkhDMHNuSzFCSHdXZzZwSmI2?=
 =?utf-8?B?b256UFdYS0t0NTlvQjFXMS9xZFExc0xnVVNvMytYQzB5M3VHN01ORk4rOFU4?=
 =?utf-8?B?RlpSM3E4NThSdnhuTGFZbEd2OXZKbmFjcWgvWWg0eGtPRVhCU2UwNE5ubXlL?=
 =?utf-8?B?MWlrK082NDJpQ3ZzRUs1NmVxOE81ZWxSVk1KY1paL0h4T09zY0Y2OTVsTnBS?=
 =?utf-8?B?S3YvalhoMEdScTZwU2tVNlVXam9ZbWhGTUlUemluTUdTaEtvVjE0NEJMaUpk?=
 =?utf-8?B?aGpyeDE0ckovV2wyQmlkWmQxSEZoc2huM1g0MlBqV2dHYWtpTS9RRE9xanFD?=
 =?utf-8?B?UkRsdUE5aFRnMkZ3Uis0bS80SmdjaVZsUmVEbVVXZlBXcm9TUUxObjlRM0VY?=
 =?utf-8?B?RnJGZHVBV2Y3SzZOdzVQRnZXZW04SGtVWUhON3paR09KeWhaZEU2S3BBT1Vm?=
 =?utf-8?B?cG5vUFQvc0NPQ1NqT3RZa2t4Q1BaaG8xbHAweHBkOW5PM0FpUU14NDZ6OUNj?=
 =?utf-8?B?bVhOTFo1WmdwbE1xVFNWSWRyeG1LNHpWS0tCZ2RValk2Zy9nQTlaWHBmeWRB?=
 =?utf-8?B?djdLcDlXQ0ZaWDhESW1Hd1V5aTUwRWNaL1dBSmtRRFRubFNZb1RrNzdKYjFS?=
 =?utf-8?B?Vll3M3VoS0JtalZoMTFIcTlROHZZNng3R0pTdzUyUFlsYk5CUjlZTW5xWm9r?=
 =?utf-8?B?TW82SUJNN3FVcFBnODRSSDdPOTRnVWdjSkRNdy9XWnJjMlgvdlRSS0lSMisy?=
 =?utf-8?B?a0h5ZXBTL2NHSzlyMmdPQlp5bTNZSDMyUlJ0S3loWVQzUTFxMUhQdDRESFQ3?=
 =?utf-8?B?Z2NmR0NMMHp0aldCNTUzc1YrLysvaGRzcVpmK1F5d0lqT251d21YOVNMTFc3?=
 =?utf-8?B?bW5ZdGhXNGxwMUs4N24zMElFWVczQ05QZnpMcmtrc1R0RVdIbzVSRWliNlp1?=
 =?utf-8?B?Q3FHeWw1MkpFWWREcjZjTTJldDFpenlCTXBsKzU1ekhlNUpzUlFlUDUzbnBk?=
 =?utf-8?B?dDdIUmczOVZlRjg1UUdYTVc2cit1cXhmVGZsazNlaUQxcjBaUHZZbUp3SUph?=
 =?utf-8?B?c3c3eGdhOFlKRVgyWGRyUnozNURQWnp5VEtFb2EyRkVVQnMwNjlLVW0yUUk3?=
 =?utf-8?B?a0RhRmo0QzV0TGNPQVpzbURoOHlMeGswL1FnWjB1d3VKdkdRSmlPc0pmVFRX?=
 =?utf-8?B?ZU9VRkd4TXNKejh2b3B1bmtKbWorU3VVa0tnT2ZkUHcxRk1oUFVJTlpYUENW?=
 =?utf-8?B?YkdiRWo4NjNEalBmTDYvekJUZ2hCVTAxV3pHQ3VrMDlMblBOOWgvN01MMlZS?=
 =?utf-8?B?M05aRDE0eDV6YjVXS3NCVzlycGxjREtuUEh3emY2VU1aUEFmRXh2YlE4YjNt?=
 =?utf-8?B?V3lUQWRBeC9WbFM4aHN6OHhPVytlS2o5OGYvRUoxbU8zbHNieGdXSDc4SUZj?=
 =?utf-8?B?MlVRNllkSEVsSUFmQS9PbERZQjdTVWxlczJneC9ySXVGeGZKVkZhTkJmdUU5?=
 =?utf-8?B?SjBSMDNQNDhtV2NFRCszSjlUaUdWSjFBUWVrT1orVEEvRDdIQ040TDBGTW5X?=
 =?utf-8?B?ZkkyTGhCby9Rdld1dHZGZDQwNURDTVpaTEdlcFFTNmZhV0V1dkp3ajdGU3lG?=
 =?utf-8?B?ZTI2cXNWUDgxaXpVNm5pcENydXc2Mkh6UnRvREtHUHhiaDJRNWFuT1V4MTVQ?=
 =?utf-8?B?QVFQRWlENVBwYit6UWNZOGdWUU9IYlhDdGFVejZYSFRZcmhyU1YydEVWUG1D?=
 =?utf-8?B?VktFRFNlMGFxZXpwNVQzbzZaa21SdjhUdncyYyt6bnlsK2VOR25Ic0o0R1ZD?=
 =?utf-8?Q?EPUcs0IyXPMS+2iE=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deeb205c-50e5-4daa-d33c-08df1e0d5d92
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 09:38:06.4458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6BQF7fpDVUa/psfGr5R6FlMku/K+nL5bIy2jmjrJm8R7tz9ogPxBFbprVirBLpH+SyMvquLBeOPVbzm34JmqgJba2lANG2GGqEIWHm4G7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB9752

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
4-bit field can hold. Centralize the HDPIXDELAY and MODE1.TRNSCVCTRL
programming in max310x_set_rts_ctl_params(), called from set_termios()
(the conversion depends on the baud rate), the rs485-config worker and
startup(), which each had their own copy.

The rs485-config worker's break guard moves into the helper with the
MODE1 write it protects, and break-off now reapplies the current
configuration through the helper instead of hand-restoring MODE1, so a
reconfigure that arrived during the break takes effect when the break
ends instead of being dropped.

The delays a 4-bit bit-time field can represent still fall well short
of the milliseconds the uapi can express; requests beyond 15 bit-times
are capped, and the -ERANGE rejection of values above 15 ms remains in
place for now.

Fixes: 55367c620aed ("serial: max310x: Add support for RS-485 mode")
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 120 +++++++++++++++++++++++++++++--------------
 1 file changed, 82 insertions(+), 38 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 693decd04de104051b07357973364bd587ab3d91..f8dad37d017afe5c0b1d36d6239ba05fc5e7aff0 100644
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
@@ -934,6 +939,48 @@ static void max310x_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	schedule_work(&one->md_work);
 }
 
+/*
+ * Program the chip's RS485 RTS timing. The HDPIXDELAY setup and hold fields
+ * count bit-times, four bits per direction, while the uapi expresses the
+ * delays in milliseconds: convert at the current baud rate, rounding up, and
+ * cap at the field maximum.
+ */
+static void max310x_set_rts_ctl_params(struct max310x_one *one)
+{
+	const unsigned int max_bit_dly = 15;
+	struct uart_port *port = &one->port;
+	unsigned int setup = 0, hold = 0;
+	u8 mode1 = 0;
+
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		/* Convert milliseconds to bit-times, rounding up. */
+		setup = DIV_ROUND_UP(one->baud * port->rs485.delay_rts_before_send,
+				     MSEC_PER_SEC);
+		hold  = DIV_ROUND_UP(one->baud * port->rs485.delay_rts_after_send,
+				     MSEC_PER_SEC);
+		setup = min(setup, max_bit_dly);
+		hold  = min(hold,  max_bit_dly);
+
+		mode1 = MAX310X_MODE1_TRNSCVCTRL_BIT;
+	}
+
+	max310x_port_write(port, MAX310X_HDPIXDELAY_REG,
+			   MAX310X_HDPIXDELAY_SETUP(setup) |
+			   MAX310X_HDPIXDELAY_HOLD(hold));
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
@@ -953,10 +1000,20 @@ static void max310x_break_ctl(struct uart_port *port, int break_state)
 	 * break duration and drive RTS manually so the break reaches the wire;
 	 * restore auto-RTS when the break ends.
 	 */
-	max310x_port_update(port, MAX310X_MODE1_REG,
-			    MAX310X_MODE1_TRNSCVCTRL_BIT,
-			    break_state ? 0 : MAX310X_MODE1_TRNSCVCTRL_BIT);
-	max310x_rts_ctl(port, break_state);
+	if (break_state) {
+		max310x_port_update(port, MAX310X_MODE1_REG,
+				    MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
+		max310x_rts_ctl(port, 1);
+	} else {
+		/*
+		 * Reapply the current configuration: a reconfigure that
+		 * arrived during the break was deferred by the tx_break
+		 * guard. Then release the manual RTS - auto-RTS owns the
+		 * pin again.
+		 */
+		max310x_set_rts_ctl_params(one);
+		max310x_rts_ctl(port, 0);
+	}
 }
 
 static void max310x_set_termios(struct uart_port *port,
@@ -1073,41 +1130,35 @@ static void max310x_set_termios(struct uart_port *port,
 
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
@@ -1151,21 +1202,14 @@ static int max310x_startup(struct uart_port *port)
 	max310x_port_update(port, MAX310X_MODE2_REG,
 			    MAX310X_MODE2_FIFORST_BIT, 0);
 
-	/* Configure mode1/mode2 to have rs485/rs232 enabled at startup */
-	val = (clamp(port->rs485.delay_rts_before_send, 0U, 15U) << 4) |
-		clamp(port->rs485.delay_rts_after_send, 0U, 15U);
-	max310x_port_write(port, MAX310X_HDPIXDELAY_REG, val);
+	/* Configure the RS485 RTS timing and the RS485/RS232 mode bits. */
+	max310x_set_rts_ctl_params(one);
 
-	if (port->rs485.flags & SER_RS485_ENABLED) {
-		max310x_port_update(port, MAX310X_MODE1_REG,
-				    MAX310X_MODE1_TRNSCVCTRL_BIT,
-				    MAX310X_MODE1_TRNSCVCTRL_BIT);
-
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

