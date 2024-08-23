Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.86.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDD718594C
	for <linux-serial@vger.kernel.org>; Fri, 23 Aug 2024 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432152; cv=none; b=MrA8a78BbqjlRxko/lJ0m8P6RusksMXmlIBLKKd4kkG5vbF4xe+bYC9Fjkjtx4OLm5vsJ5bDddvEld/oQbYl1unDMKcZSG7D1xSYBmBtqrPNsAxTKqoba9Z2aYs4v1JETHLfjeROPNT4cy0dBAELIMQ/z60beYc79PbsRRoK6J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432152; c=relaxed/simple;
	bh=X3ZBB/mDgG1Kjzde5mia5pf0TbgzFFqzHif36Q4Mn8I=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 MIME-Version:Content-Type; b=XSU6Oac9GDUiJK6sq8qkldLUHt0CdpUQ+xXseytfyfBrFK7kvblrmgqB4P5PjtZzABnmbRgKc/WxPiKVdnSbpF3ass4hjnUX8S4ssztynLUurYSXiaiwuAc+SqIdK+oGntwzmn49to+Relms31He6sYFEqnrm0MW2bA6QHyUHIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=di/ixNTS; arc=none smtp.client-ip=185.58.86.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="di/ixNTS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1724432149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CwOU/ElRbhXXjWKHwmDDxUlaVScH9TJ6tydmUNi9wD8=;
	b=di/ixNTSZNh2bfywqrR8fK5fWptAKYexs6b7u8cmlel1HiaHl4bPRfhpMibnFx0+4fI+Bs
	OJb5XrISb5bGs4mMPkU8zaYt1FwFHdlLOJpjRzNOkswsKMSoBM3VT7cTuypwyf0rojv0FK
	PUEHN2fz0jEHIrXP8o5BJAIaCnwi5iI=
Received: from GBR01-CWX-obe.outbound.protection.outlook.com
 (mail-cwxgbr01lp2049.outbound.protection.outlook.com [104.47.85.49]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-169-b-PLD-GCPMGLbSaUVbQa2g-1; Fri, 23 Aug 2024 17:55:48 +0100
X-MC-Unique: b-PLD-GCPMGLbSaUVbQa2g-1
Received: from LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:20b::7)
 by CWLP123MB3105.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 16:55:46 +0000
Received: from LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM
 ([fe80::55a9:7dae:8812:f567]) by LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM
 ([fe80::55a9:7dae:8812:f567%5]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 16:55:46 +0000
Message-ID: <fbd8debf-46ab-407a-beda-43e083bffee7@camlingroup.com>
Date: Fri, 23 Aug 2024 18:55:44 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 3/3] serial: sc16is7xx: convert bitmask definitions to use
 BIT() macro
From: Lech Perczak <lech.perczak@camlingroup.com>
To: linux-serial@vger.kernel.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <k.drobinski@camlintechnologies.com>,
 =?UTF-8?Q?Pawe=C5=82_Lenkow?= <pawel.lenkow@camlingroup.com>,
 Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
References: <7deb753f-bf86-47ce-89bf-8277aca4293e@camlingroup.com>
In-Reply-To: <7deb753f-bf86-47ce-89bf-8277aca4293e@camlingroup.com>
X-ClientProxiedBy: WA2P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::11) To LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:20b::7)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO4P123MB5272:EE_|CWLP123MB3105:EE_
X-MS-Office365-Filtering-Correlation-Id: cd508958-bac7-44a4-5c6a-08dcc3946f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1FUcnMvbUFiRTVWR2Z3OXlDUHZ2VWExbXJ5ZmJubVRTeHEvbDRHL0Rsb201?=
 =?utf-8?B?dTAxY2RGOEh3aTUrWDJucDM1cWNZb2hnOUoyV2ZoTmZJd1lXMzJnMHZxbmNH?=
 =?utf-8?B?YW5GQmRPU1pVVmhERGdJVm1uTU8vaHVOSVVmNGFSemdNUVovbTREUk5hYVhr?=
 =?utf-8?B?K0QvTFlZbWVFTnhRaFI1MVJNb1AxWEgwUllkeGNxL1JNMkFjMDR6UEZnRmdO?=
 =?utf-8?B?WTBobGkvOWM4TWF4emxodWdnT1Y4eU1XNmZCTnk2RTI3VGpDNnk4OGQ5cTYz?=
 =?utf-8?B?TENYRGI3a2YzY1ZHTW5FK1ZxaktCT1RMNUJjM1NiUzBUN1hka0tod0h4ME9G?=
 =?utf-8?B?UDBOYlhuekdjZjJQNTk2cTdPNGNaUTNRUWZmMDJrc0JxR0FGWFVGOGhPWDkw?=
 =?utf-8?B?WlNBcUg2R0djRmlSMWU4dlV4WGRZZlVHVTY1cFBac0krZUxHZUt3NUcwV3VN?=
 =?utf-8?B?M2cyWjNKVU1sOUxJV1lJa1RGN2tsNFIrbTZDQ3huNUQwRDdwSXlsU0JCa1cx?=
 =?utf-8?B?ek1OaGZwNHFOZVNOMVdHUUgxQ3RHU2tiWW94MHdYZ1F3N3VIcXM4MUwvQXMw?=
 =?utf-8?B?LzFQVkJCZDZQMU9WcEU4NEcyQUNhWkNtVUQ5UW9MV0N4endWeXNnWjRxR3lo?=
 =?utf-8?B?WHFzU1hxNktPdjc2WllWSHZ0UzVRZWwrZGwzYVluZzNQZW1SYlBPMmhIdUhM?=
 =?utf-8?B?WmxRUW1qN0V4Ulo3SE84dkt0b2N5Qkw4OHROVDEzSERPcXkreHhMYVhaZnJV?=
 =?utf-8?B?cWVMK1NxMGhQNm1hbU9vSGNlWGpuZ2dNWVNWNTR6dU50R3JQMkpLMEw4b3FR?=
 =?utf-8?B?bEZtYzQ4dHVVN0VSZjlhdjQvanFYbVRYNEJoWlBFS01haENWSE9ZakFoanp0?=
 =?utf-8?B?engxSjVnMzN0NkN0dFZxN1dkQUhMcVc2am9zTDJoVEJNeUU1T3JYT1BEL1Ri?=
 =?utf-8?B?UHhqM0ZNMFJLT3pmRHZnMHRMYU82WGdYbUpjbmhkNGZRZGpmVHRyQVB3aXlU?=
 =?utf-8?B?VVZaaGNlNU1TbEdwd2VHOXFWYnk4TVV0eEhuV1hVZFZJZVNGNVQ0OWJHeDdJ?=
 =?utf-8?B?WXd6ekdySDNNNUl3SDFoNS9wMzhWQ2Z4WlFNRDVNeE5KVDJNZ1loK0lnUElH?=
 =?utf-8?B?ZHJOdDhuM2ZUbHRQVlErdXlJRmNYQncvZElxaUxrVHh4aUpqOFlYV0VjSW53?=
 =?utf-8?B?TDJ2YmJyUHlFQmRnU3JlUkJvUGNlNlVlUWxuMjRubTNTcWsxWkt3Wk95QW11?=
 =?utf-8?B?RTBUK3hiemhwZFVjRk5WM083MmR1T0VFVmZ4WTVyK3BhdWxkWmF3Q2swcmdv?=
 =?utf-8?B?dEh1M25BWEdRVXZzNjJKejBjcHNYN1N3elJaSmN3eEtiT2lpak83M3JtV2Zk?=
 =?utf-8?B?UWpPOHJKM0RSTUd6V3ZaTnhtT0IvaVlKR2ZweEpDaVVTVDNMQ3NLL3BnMEt3?=
 =?utf-8?B?UzAvT1VRWVl2Wmo3VGoySjNYNG95UTk0U3pWQW5Rdk9jNWJGS200ZTgvOFRi?=
 =?utf-8?B?eHJ2UXd1WFByUGx2Y3hZNU9pRHJkSkxBZWdRQnl2TlFsd2doWXM5Wm50ZmJX?=
 =?utf-8?B?QWc4TTQrSHZjZGx5bUZjRk9sMXY1cHhDL094TVJ4QU56ZHBhblFENXlXMFNI?=
 =?utf-8?B?R0p1K1dma1YwN0U2bVh2VHEwelE2QWtqNjI4S0ZROUhBaUxBUTllb3k0cFdx?=
 =?utf-8?B?NUU3MDBMaWx6R2liSXFFOHQvdUJTNExMRDREdE1OWEt1WElBU25ZVm9RbnV2?=
 =?utf-8?B?dzR6VzVDTWwvQzdhS1Q4TXpEdHZjWFVMVm9salA4a054Qm9wS3FGUjMwck83?=
 =?utf-8?B?czAyL0pWNjhOOVdqaFU2UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkthZEk1bmg3L2pySEZVR3VxUVRMNUFiMEhhT21seXhZOE5UaXZ1T3BkeFIr?=
 =?utf-8?B?Qm9UUzZEcklNbEIrUmVEWDdMQm9ldFE5eU0rdGczMHFDKzV6b0UrVm5NRlFO?=
 =?utf-8?B?YTRoaEkxZU8rYXViYWc1NG9ZdWQ3VVhoRnhxQ0ZmRkxsUW91M0ZMd0kzVG8r?=
 =?utf-8?B?TVBMcnFaekNKRFBCRHlMb2RxVWh6UHh3ek5SeXdZYStxWFE1a29QcmlOSHdB?=
 =?utf-8?B?ak00WHdXQ2lGd256UDRydlFOeXl0dDJSNjdhem4yUmMwMzFiSG9YTUkvRUxu?=
 =?utf-8?B?VHV3V0VzZmErdHJTbGlycmd6NzFGYmlhUWhkdXVRdk5YNUtQN0p4WGlUdUM0?=
 =?utf-8?B?U1Y2MGxjYjBWdVBIV1ZVYmRvelY4ZVB3enFRYll3M082Qm9VVkxlUWNvaitK?=
 =?utf-8?B?Szg0TXZtKzZCVjVGb1pxWGJjRFA4dnY1UjF0U3NEdHlPRloxZUt3YWRhSmZS?=
 =?utf-8?B?YjBSTW10cVE2VGR1Tko0U25wd0NoVkpDSFM0MmpLVTBjYkJZa0FVcnBkckFJ?=
 =?utf-8?B?WHpRWlVrS0Q1OTRoQjJEd1JNVUFKTWpRSzd2WjB3b3k4RVF3VUNHVm8xR1Vn?=
 =?utf-8?B?M3RKN0JQa0dkaFdWcC9pdUhOU2UweUcxb2dRc0VQS25BL2JhbGVudjBiSkRD?=
 =?utf-8?B?MUhYUDliY1hSRzRScWpEV2Y1WVNoNTY1UHBVQzhvQi9zOEdsalNTY3JhSDFH?=
 =?utf-8?B?anh3UkkxbWZTQ0JSTFhqUFNtR2owajB5QzdJR3lSY2tuS1MvdEJVb0JtTGZX?=
 =?utf-8?B?c09jWnRQUmVxek9Qd0QzQXh5UXVXUDFZV1U1dkNLRHdWSDlRNGRtVDRmSWNI?=
 =?utf-8?B?MlBSVG42R2lOVDVmdEJ2bVJvQUh5ckxsbVlzRk96b011TzVmZ1Jvdk5nejgw?=
 =?utf-8?B?dEhnN1F5TXY4ZGxOSFVCU2ZqaXBwL3dRZ3hWdnpQVU1JQ1hwV0V1STlQM3hP?=
 =?utf-8?B?UVl2ckx4N2NOWUEwS2VNWllYS0wzaWdBcmc4S3h6MERCWm9VS01KZUNPNkhk?=
 =?utf-8?B?WTZTUTlpZFRzQStERWt3MnRLc1VRWjB1RnROdjd1VHgyOTFGZm1pdXhZN3ZK?=
 =?utf-8?B?QnoxekN5aVIzNWJoUmlEZmRrclYzSmY3c3YxMDdqTWZCTXNFelk0NTh5SG5X?=
 =?utf-8?B?d1Y0N1FUSUZRTWFBOEZsdFFrNk5MLytHRzhVSzVXR3kvejV3VjA5YkpqTEUx?=
 =?utf-8?B?NG5CeEdabWdDdHVuWExwL3VSVDJOZ2Y2L0VmYWdLTVdndklnQkZKMEUvZzRQ?=
 =?utf-8?B?dENjdGJNV0V5Z3pkSjYxajVSWGJPZVpReWppdGU2L1FTd2RRVEhySnkwOEdm?=
 =?utf-8?B?dEVZaWxMclZZYjZkZjc5WnlwSEhHeVdsblU3VEYydXVRbTZhT2QvNW5sbk1I?=
 =?utf-8?B?OXFzdW12TmtETTI1cmloaCtnZ2tZbzVyY1JabzNIdkl0VG9NeDNjNWw3UFpr?=
 =?utf-8?B?NmRUQis1SDh1TUxUM0U4MWpLSlZUT2xPREEzTDZ3ODBwYkloWHRYcTNON1ZH?=
 =?utf-8?B?RG1uRzdMWHlHT0taY0pCZ2Rta0lnVXJjTlNEVlFMamoxUHEyVjR0anpUaGlu?=
 =?utf-8?B?ZXQ4MVhhYnZITDN3Q0QrL0wvcHAvR1hHaWd2elNjaWg1OTZNZHZKVlI3VzFs?=
 =?utf-8?B?bndoK3lTUVNZblJ3cWFuWVVYbTYvTG5vcFN4Z0o5UDVXRXZmTDZ5RmJiV0dV?=
 =?utf-8?B?TTJza2cyRW90VGlXWkE4WFRGSE9CTlY4M0NFK2NHQis2VzdsTVZ6dkNlQnhy?=
 =?utf-8?B?amg3RmxUOVROc2MrYVhHSVY0R2Y0eU53NGI5RWVienMrMmlqSUhkcS9jbE1F?=
 =?utf-8?B?TEVieUFDQyt3c29oNW8vUE54WVlOYUg3aHVLL2dSRlVHV09TaktlNlVQZU82?=
 =?utf-8?B?U2tMMUR2WmxnL0RNY0pIbkkzRFhjcHJkYWtGM04yUHcxcEZ3WlYybWZVZFRX?=
 =?utf-8?B?N0lZRFNYdkxJQ2tVWWsxTysvVXlYZDM2eGJQa3ZYUG43OXdlY0poSWNnSEd5?=
 =?utf-8?B?SWFnd1F1QnpUQWZZSVRGRU5ld3hNeXBnN0FHTmJKSWVTZzd0enlEZHVxWGtM?=
 =?utf-8?B?blRLK1NHbFV3a05mNkpaN2h1NmRxRWtrZHBOTXZqRXdjL0U3SjNPT2hQdmpC?=
 =?utf-8?B?WkhKM1Fob1pDbWd5ZUZtVDJvOFZCNDE5N1p0TjE5V0xqbXRBVmRvdVk1aFpX?=
 =?utf-8?B?YnI0VGdKZzhFUXdlN0RkQUNCeUdhMEpPa3pCTCtQM3lVK2ZNbnByVnJIUkhL?=
 =?utf-8?B?RHBBQmFzRll6RlR0emJNZHZQeUR3PT0=?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd508958-bac7-44a4-5c6a-08dcc3946f0c
X-MS-Exchange-CrossTenant-AuthSource: LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 16:55:46.6344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: De2EjTdwDXj5e91WxLP/BuV8TGI4i8/4l6BcBexfWNA0p0wEF71WixavQh1sm6DskR2AIfwDDcnuops6kpUOm5qxpCGqx8mohbXt0+S0OYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3105
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Now that bit definition comments were cleaned up, convert bitmask
definitions to use BIT() macro for clarity.
Convert SC16IS7XX_IIR_* bitmask constants, to use GENMASK() macro, where
applicable - while at that, realign comments.
Compose SC16IS7XX_LSR_BRK_ERROR_MASK using aforementioned constants,
instead of open-coding it, and remove now unneeded comment.

Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Andy Shevchenko <andy@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 174 +++++++++++++++++----------------
 1 file changed, 89 insertions(+), 85 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index 36b7c682ae94..68fdb2dee414 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -10,6 +10,7 @@
 #undef DEFAULT_SYMBOL_NAMESPACE
 #define DEFAULT_SYMBOL_NAMESPACE SERIAL_NXP_SC16IS7XX
=20
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -77,52 +78,52 @@
 #define SC16IS7XX_XOFF2_REG=09=09(0x07) /* Xoff2 word */
=20
 /* IER register bits */
-#define SC16IS7XX_IER_RDI_BIT=09=09(1 << 0) /* Enable RX data interrupt */
-#define SC16IS7XX_IER_THRI_BIT=09=09(1 << 1) /* Enable TX holding register
+#define SC16IS7XX_IER_RDI_BIT=09=09BIT(0)   /* Enable RX data interrupt */
+#define SC16IS7XX_IER_THRI_BIT=09=09BIT(1)   /* Enable TX holding register
 =09=09=09=09=09=09  * interrupt */
-#define SC16IS7XX_IER_RLSI_BIT=09=09(1 << 2) /* Enable RX line status
+#define SC16IS7XX_IER_RLSI_BIT=09=09BIT(2)   /* Enable RX line status
 =09=09=09=09=09=09  * interrupt */
-#define SC16IS7XX_IER_MSI_BIT=09=09(1 << 3) /* Enable Modem status
+#define SC16IS7XX_IER_MSI_BIT=09=09BIT(3)   /* Enable Modem status
 =09=09=09=09=09=09  * interrupt */
=20
 /* IER register bits - write only if (EFR[4] =3D=3D 1) */
-#define SC16IS7XX_IER_SLEEP_BIT=09=09(1 << 4) /* Enable Sleep mode */
-#define SC16IS7XX_IER_XOFFI_BIT=09=09(1 << 5) /* Enable Xoff interrupt */
-#define SC16IS7XX_IER_RTSI_BIT=09=09(1 << 6) /* Enable nRTS interrupt */
-#define SC16IS7XX_IER_CTSI_BIT=09=09(1 << 7) /* Enable nCTS interrupt */
+#define SC16IS7XX_IER_SLEEP_BIT=09=09BIT(4)   /* Enable Sleep mode */
+#define SC16IS7XX_IER_XOFFI_BIT=09=09BIT(5)   /* Enable Xoff interrupt */
+#define SC16IS7XX_IER_RTSI_BIT=09=09BIT(6)   /* Enable nRTS interrupt */
+#define SC16IS7XX_IER_CTSI_BIT=09=09BIT(7)   /* Enable nCTS interrupt */
=20
 /* FCR register bits */
-#define SC16IS7XX_FCR_FIFO_BIT=09=09(1 << 0) /* Enable FIFO */
-#define SC16IS7XX_FCR_RXRESET_BIT=09(1 << 1) /* Reset RX FIFO */
-#define SC16IS7XX_FCR_TXRESET_BIT=09(1 << 2) /* Reset TX FIFO */
-#define SC16IS7XX_FCR_RXLVLL_BIT=09(1 << 6) /* RX Trigger level LSB */
-#define SC16IS7XX_FCR_RXLVLH_BIT=09(1 << 7) /* RX Trigger level MSB */
+#define SC16IS7XX_FCR_FIFO_BIT=09=09BIT(0)   /* Enable FIFO */
+#define SC16IS7XX_FCR_RXRESET_BIT=09BIT(1)   /* Reset RX FIFO */
+#define SC16IS7XX_FCR_TXRESET_BIT=09BIT(2)   /* Reset TX FIFO */
+#define SC16IS7XX_FCR_RXLVLL_BIT=09BIT(6)   /* RX Trigger level LSB */
+#define SC16IS7XX_FCR_RXLVLH_BIT=09BIT(7)   /* RX Trigger level MSB */
=20
 /* FCR register bits - write only if (EFR[4] =3D=3D 1) */
-#define SC16IS7XX_FCR_TXLVLL_BIT=09(1 << 4) /* TX Trigger level LSB */
-#define SC16IS7XX_FCR_TXLVLH_BIT=09(1 << 5) /* TX Trigger level MSB */
+#define SC16IS7XX_FCR_TXLVLL_BIT=09BIT(4)   /* TX Trigger level LSB */
+#define SC16IS7XX_FCR_TXLVLH_BIT=09BIT(5)   /* TX Trigger level MSB */
=20
 /* IIR register bits */
-#define SC16IS7XX_IIR_NO_INT_BIT=09(1 << 0) /* No interrupts pending */
-#define SC16IS7XX_IIR_ID_MASK=09=090x3e     /* Mask for the interrupt ID *=
/
-#define SC16IS7XX_IIR_THRI_SRC=09=090x02     /* TX holding register empty =
*/
-#define SC16IS7XX_IIR_RDI_SRC=09=090x04     /* RX data interrupt */
-#define SC16IS7XX_IIR_RLSE_SRC=09=090x06     /* RX line status error */
-#define SC16IS7XX_IIR_RTOI_SRC=09=090x0c     /* RX time-out interrupt */
-#define SC16IS7XX_IIR_MSI_SRC=09=090x00     /* Modem status interrupt
-=09=09=09=09=09=09  * - only on 75x/76x
-=09=09=09=09=09=09  */
-#define SC16IS7XX_IIR_INPIN_SRC=09=090x30     /* Input pin change of state
-=09=09=09=09=09=09  * - only on 75x/76x
-=09=09=09=09=09=09  */
-#define SC16IS7XX_IIR_XOFFI_SRC=09=090x10     /* Received Xoff */
-#define SC16IS7XX_IIR_CTSRTS_SRC=090x20     /* nCTS,nRTS change of state
-=09=09=09=09=09=09  * from active (LOW)
-=09=09=09=09=09=09  * to inactive (HIGH)
-=09=09=09=09=09=09  */
+#define SC16IS7XX_IIR_NO_INT_BIT=09BIT(0)   =09/* No interrupts pending */
+#define SC16IS7XX_IIR_ID_MASK=09=09GENMASK(5,1)=09/* Mask for the interrup=
t ID */
+#define SC16IS7XX_IIR_THRI_SRC=09=09BIT(1)=09=09/* TX holding register emp=
ty */
+#define SC16IS7XX_IIR_RDI_SRC=09=09BIT(2)=09=09/* RX data interrupt */
+#define SC16IS7XX_IIR_RLSE_SRC=09=09GENMASK(2,1)=09/* RX line status error=
 */
+#define SC16IS7XX_IIR_RTOI_SRC=09=09GENMASK(3,2)    /* RX time-out interru=
pt */
+#define SC16IS7XX_IIR_MSI_SRC=09=090x00=09=09/* Modem status interrupt
+=09=09=09=09=09=09=09 * - only on 75x/76x
+=09=09=09=09=09=09=09 */
+#define SC16IS7XX_IIR_INPIN_SRC=09=09GENMASK(5,4)=09/* Input pin change of=
 state
+=09=09=09=09=09=09=09 * - only on 75x/76x
+=09=09=09=09=09=09=09 */
+#define SC16IS7XX_IIR_XOFFI_SRC=09=09BIT(4)=09=09/* Received Xoff */
+#define SC16IS7XX_IIR_CTSRTS_SRC=09BIT(5)=09=09/* nCTS,nRTS change of stat=
e
+=09=09=09=09=09=09=09 * from active (LOW)
+=09=09=09=09=09=09=09 * to inactive (HIGH)
+=09=09=09=09=09=09=09 */
 /* LCR register bits */
-#define SC16IS7XX_LCR_LENGTH0_BIT=09(1 << 0) /* Word length bit 0 */
-#define SC16IS7XX_LCR_LENGTH1_BIT=09(1 << 1) /* Word length bit 1
+#define SC16IS7XX_LCR_LENGTH0_BIT=09BIT(0)   /* Word length bit 0 */
+#define SC16IS7XX_LCR_LENGTH1_BIT=09BIT(1)   /* Word length bit 1
 =09=09=09=09=09=09  *
 =09=09=09=09=09=09  * Word length bits table:
 =09=09=09=09=09=09  * 00 -> 5 bit words
@@ -130,7 +131,7 @@
 =09=09=09=09=09=09  * 10 -> 7 bit words
 =09=09=09=09=09=09  * 11 -> 8 bit words
 =09=09=09=09=09=09  */
-#define SC16IS7XX_LCR_STOPLEN_BIT=09(1 << 2) /* STOP length bit
+#define SC16IS7XX_LCR_STOPLEN_BIT=09BIT(2)   /* STOP length bit
 =09=09=09=09=09=09  *
 =09=09=09=09=09=09  * STOP length bit table:
 =09=09=09=09=09=09  * 0 -> 1 stop bit
@@ -138,11 +139,11 @@
 =09=09=09=09=09=09  *      word length is 5,
 =09=09=09=09=09=09  *      2 stop bits otherwise
 =09=09=09=09=09=09  */
-#define SC16IS7XX_LCR_PARITY_BIT=09(1 << 3) /* Parity bit enable */
-#define SC16IS7XX_LCR_EVENPARITY_BIT=09(1 << 4) /* Even parity bit enable =
*/
-#define SC16IS7XX_LCR_FORCEPARITY_BIT=09(1 << 5) /* 9-bit multidrop parity=
 */
-#define SC16IS7XX_LCR_TXBREAK_BIT=09(1 << 6) /* TX break enable */
-#define SC16IS7XX_LCR_DLAB_BIT=09=09(1 << 7) /* Divisor Latch enable */
+#define SC16IS7XX_LCR_PARITY_BIT=09BIT(3)   /* Parity bit enable */
+#define SC16IS7XX_LCR_EVENPARITY_BIT=09BIT(4)   /* Even parity bit enable =
*/
+#define SC16IS7XX_LCR_FORCEPARITY_BIT=09BIT(5)   /* 9-bit multidrop parity=
 */
+#define SC16IS7XX_LCR_TXBREAK_BIT=09BIT(6)   /* TX break enable */
+#define SC16IS7XX_LCR_DLAB_BIT=09=09BIT(7)   /* Divisor Latch enable */
 #define SC16IS7XX_LCR_WORD_LEN_5=09(0x00)
 #define SC16IS7XX_LCR_WORD_LEN_6=09(0x01)
 #define SC16IS7XX_LCR_WORD_LEN_7=09(0x02)
@@ -153,58 +154,61 @@
 =09=09=09=09=09=09=09=09* reg set */
=20
 /* MCR register bits */
-#define SC16IS7XX_MCR_DTR_BIT=09=09(1 << 0) /* DTR complement
+#define SC16IS7XX_MCR_DTR_BIT=09=09BIT(0)   /* DTR complement
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MCR_RTS_BIT=09=09(1 << 1) /* RTS complement */
-#define SC16IS7XX_MCR_TCRTLR_BIT=09(1 << 2) /* TCR/TLR register enable */
-#define SC16IS7XX_MCR_LOOP_BIT=09=09(1 << 4) /* Enable loopback test mode =
*/
-#define SC16IS7XX_MCR_XONANY_BIT=09(1 << 5) /* Enable Xon Any
+#define SC16IS7XX_MCR_RTS_BIT=09=09BIT(1)   /* RTS complement */
+#define SC16IS7XX_MCR_TCRTLR_BIT=09BIT(2)   /* TCR/TLR register enable */
+#define SC16IS7XX_MCR_LOOP_BIT=09=09BIT(4)   /* Enable loopback test mode =
*/
+#define SC16IS7XX_MCR_XONANY_BIT=09BIT(5)   /* Enable Xon Any
 =09=09=09=09=09=09  * - write enabled
 =09=09=09=09=09=09  * if (EFR[4] =3D=3D 1)
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MCR_IRDA_BIT=09=09(1 << 6) /* Enable IrDA mode
+#define SC16IS7XX_MCR_IRDA_BIT=09=09BIT(6)   /* Enable IrDA mode
 =09=09=09=09=09=09  * - write enabled
 =09=09=09=09=09=09  * if (EFR[4] =3D=3D 1)
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MCR_CLKSEL_BIT=09(1 << 7) /* Divide clock by 4
+#define SC16IS7XX_MCR_CLKSEL_BIT=09BIT(7)   /* Divide clock by 4
 =09=09=09=09=09=09  * - write enabled
 =09=09=09=09=09=09  * if (EFR[4] =3D=3D 1)
 =09=09=09=09=09=09  */
=20
 /* LSR register bits */
-#define SC16IS7XX_LSR_DR_BIT=09=09(1 << 0) /* Receiver data ready */
-#define SC16IS7XX_LSR_OE_BIT=09=09(1 << 1) /* Overrun Error */
-#define SC16IS7XX_LSR_PE_BIT=09=09(1 << 2) /* Parity Error */
-#define SC16IS7XX_LSR_FE_BIT=09=09(1 << 3) /* Frame Error */
-#define SC16IS7XX_LSR_BI_BIT=09=09(1 << 4) /* Break Interrupt */
-#define SC16IS7XX_LSR_BRK_ERROR_MASK=090x1E     /* BI, FE, PE, OE bits */
-#define SC16IS7XX_LSR_THRE_BIT=09=09(1 << 5) /* TX holding register empty =
*/
-#define SC16IS7XX_LSR_TEMT_BIT=09=09(1 << 6) /* Transmitter empty */
-#define SC16IS7XX_LSR_FIFOE_BIT=09=09(1 << 7) /* Fifo Error */
+#define SC16IS7XX_LSR_DR_BIT=09=09BIT(0)   /* Receiver data ready */
+#define SC16IS7XX_LSR_OE_BIT=09=09BIT(1)   /* Overrun Error */
+#define SC16IS7XX_LSR_PE_BIT=09=09BIT(2)   /* Parity Error */
+#define SC16IS7XX_LSR_FE_BIT=09=09BIT(3)   /* Frame Error */
+#define SC16IS7XX_LSR_BI_BIT=09=09BIT(4)   /* Break Interrupt */
+#define SC16IS7XX_LSR_BRK_ERROR_MASK=09(SC16IS7XX_LSR_OE_BIT | \
+=09=09=09=09=09SC16IS7XX_LSR_PE_BIT | \
+=09=09=09=09=09SC16IS7XX_LSR_FE_BIT | \
+=09=09=09=09=09SC16IS7XX_LSR_BI_BIT)
+#define SC16IS7XX_LSR_THRE_BIT=09=09BIT(5)   /* TX holding register empty =
*/
+#define SC16IS7XX_LSR_TEMT_BIT=09=09BIT(6)   /* Transmitter empty */
+#define SC16IS7XX_LSR_FIFOE_BIT=09=09BIT(7)   /* Fifo Error */
=20
 /* MSR register bits */
-#define SC16IS7XX_MSR_DCTS_BIT=09=09(1 << 0) /* Delta CTS Clear To Send */
-#define SC16IS7XX_MSR_DDSR_BIT=09=09(1 << 1) /* Delta DSR Data Set Ready
+#define SC16IS7XX_MSR_DCTS_BIT=09=09BIT(0)   /* Delta CTS Clear To Send */
+#define SC16IS7XX_MSR_DDSR_BIT=09=09BIT(1)   /* Delta DSR Data Set Ready
 =09=09=09=09=09=09  * or (IO4)
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MSR_DRI_BIT=09=09(1 << 2) /* Delta RI Ring Indicator
+#define SC16IS7XX_MSR_DRI_BIT=09=09BIT(2)   /* Delta RI Ring Indicator
 =09=09=09=09=09=09  * or (IO7)
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MSR_DCD_BIT=09=09(1 << 3) /* Delta CD Carrier Detect
+#define SC16IS7XX_MSR_DCD_BIT=09=09BIT(3)   /* Delta CD Carrier Detect
 =09=09=09=09=09=09  * or (IO6)
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MSR_CTS_BIT=09=09(1 << 4) /* CTS */
-#define SC16IS7XX_MSR_DSR_BIT=09=09(1 << 5) /* DSR (IO4)
+#define SC16IS7XX_MSR_CTS_BIT=09=09BIT(4)   /* CTS */
+#define SC16IS7XX_MSR_DSR_BIT=09=09BIT(5)   /* DSR (IO4)
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MSR_RI_BIT=09=09(1 << 6) /* RI (IO7)
+#define SC16IS7XX_MSR_RI_BIT=09=09BIT(6)   /* RI (IO7)
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MSR_CD_BIT=09=09(1 << 7) /* CD (IO6)
+#define SC16IS7XX_MSR_CD_BIT=09=09BIT(7)   /* CD (IO6)
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
=20
@@ -239,19 +243,19 @@
 #define SC16IS7XX_TLR_RX_TRIGGER(words)=09((((words) / 4) & 0x0f) << 4)
=20
 /* IOControl register bits (Only 75x/76x) */
-#define SC16IS7XX_IOCONTROL_LATCH_BIT=09(1 << 0) /* Enable input latching =
*/
-#define SC16IS7XX_IOCONTROL_MODEM_A_BIT=09(1 << 1) /* Enable GPIO[7:4] as =
modem A pins */
-#define SC16IS7XX_IOCONTROL_MODEM_B_BIT=09(1 << 2) /* Enable GPIO[3:0] as =
modem B pins */
-#define SC16IS7XX_IOCONTROL_SRESET_BIT=09(1 << 3) /* Software Reset */
+#define SC16IS7XX_IOCONTROL_LATCH_BIT=09BIT(0)   /* Enable input latching =
*/
+#define SC16IS7XX_IOCONTROL_MODEM_A_BIT=09BIT(1)   /* Enable GPIO[7:4] as =
modem A pins */
+#define SC16IS7XX_IOCONTROL_MODEM_B_BIT=09BIT(2)   /* Enable GPIO[3:0] as =
modem B pins */
+#define SC16IS7XX_IOCONTROL_SRESET_BIT=09BIT(3)   /* Software Reset */
=20
 /* EFCR register bits */
-#define SC16IS7XX_EFCR_9BIT_MODE_BIT=09(1 << 0) /* Enable 9-bit or Multidr=
op
+#define SC16IS7XX_EFCR_9BIT_MODE_BIT=09BIT(0)   /* Enable 9-bit or Multidr=
op
 =09=09=09=09=09=09  * mode (RS485) */
-#define SC16IS7XX_EFCR_RXDISABLE_BIT=09(1 << 1) /* Disable receiver */
-#define SC16IS7XX_EFCR_TXDISABLE_BIT=09(1 << 2) /* Disable transmitter */
-#define SC16IS7XX_EFCR_AUTO_RS485_BIT=09(1 << 4) /* Auto RS485 RTS directi=
on */
-#define SC16IS7XX_EFCR_RTS_INVERT_BIT=09(1 << 5) /* RTS output inversion *=
/
-#define SC16IS7XX_EFCR_IRDA_MODE_BIT=09(1 << 7) /* IrDA mode
+#define SC16IS7XX_EFCR_RXDISABLE_BIT=09BIT(1)   /* Disable receiver */
+#define SC16IS7XX_EFCR_TXDISABLE_BIT=09BIT(2)   /* Disable transmitter */
+#define SC16IS7XX_EFCR_AUTO_RS485_BIT=09BIT(4)   /* Auto RS485 RTS directi=
on */
+#define SC16IS7XX_EFCR_RTS_INVERT_BIT=09BIT(5)   /* RTS output inversion *=
/
+#define SC16IS7XX_EFCR_IRDA_MODE_BIT=09BIT(7)   /* IrDA mode
 =09=09=09=09=09=09  * 0 =3D rate upto 115.2 kbit/s
 =09=09=09=09=09=09  *   - Only 75x/76x
 =09=09=09=09=09=09  * 1 =3D rate upto 1.152 Mbit/s
@@ -259,15 +263,15 @@
 =09=09=09=09=09=09  */
=20
 /* EFR register bits */
-#define SC16IS7XX_EFR_AUTORTS_BIT=09(1 << 6) /* Auto RTS flow ctrl enable =
*/
-#define SC16IS7XX_EFR_AUTOCTS_BIT=09(1 << 7) /* Auto CTS flow ctrl enable =
*/
-#define SC16IS7XX_EFR_XOFF2_DETECT_BIT=09(1 << 5) /* Enable Xoff2 detectio=
n */
-#define SC16IS7XX_EFR_ENABLE_BIT=09(1 << 4) /* Enable enhanced functions
+#define SC16IS7XX_EFR_AUTORTS_BIT=09BIT(6)   /* Auto RTS flow ctrl enable =
*/
+#define SC16IS7XX_EFR_AUTOCTS_BIT=09BIT(7)   /* Auto CTS flow ctrl enable =
*/
+#define SC16IS7XX_EFR_XOFF2_DETECT_BIT=09BIT(5)   /* Enable Xoff2 detectio=
n */
+#define SC16IS7XX_EFR_ENABLE_BIT=09BIT(4)   /* Enable enhanced functions
 =09=09=09=09=09=09  * and writing to IER[7:4],
 =09=09=09=09=09=09  * FCR[5:4], MCR[7:5]
 =09=09=09=09=09=09  */
-#define SC16IS7XX_EFR_SWFLOW3_BIT=09(1 << 3)
-#define SC16IS7XX_EFR_SWFLOW2_BIT=09(1 << 2)
+#define SC16IS7XX_EFR_SWFLOW3_BIT=09BIT(3)
+#define SC16IS7XX_EFR_SWFLOW2_BIT=09BIT(2)
 =09=09=09=09=09=09 /*
 =09=09=09=09=09=09  * SWFLOW bits 3 & 2 table:
 =09=09=09=09=09=09  * 00 -> no transmitter flow
@@ -280,8 +284,8 @@
 =09=09=09=09=09=09  *       XON1, XON2, XOFF1 and
 =09=09=09=09=09=09  *       XOFF2
 =09=09=09=09=09=09  */
-#define SC16IS7XX_EFR_SWFLOW1_BIT=09(1 << 1)
-#define SC16IS7XX_EFR_SWFLOW0_BIT=09(1 << 0)
+#define SC16IS7XX_EFR_SWFLOW1_BIT=09BIT(1)
+#define SC16IS7XX_EFR_SWFLOW0_BIT=09BIT(0)
 =09=09=09=09=09=09 /*
 =09=09=09=09=09=09  * SWFLOW bits 1 & 0 table:
 =09=09=09=09=09=09  * 00 -> no received flow
@@ -307,9 +311,9 @@
 #define SC16IS7XX_FIFO_SIZE=09=09(64)
 #define SC16IS7XX_GPIOS_PER_BANK=094
=20
-#define SC16IS7XX_RECONF_MD=09=09(1 << 0)
-#define SC16IS7XX_RECONF_IER=09=09(1 << 1)
-#define SC16IS7XX_RECONF_RS485=09=09(1 << 2)
+#define SC16IS7XX_RECONF_MD=09=09BIT(0)
+#define SC16IS7XX_RECONF_IER=09=09BIT(1)
+#define SC16IS7XX_RECONF_RS485=09=09BIT(2)
=20
 struct sc16is7xx_one_config {
 =09unsigned int=09=09=09flags;
--=20
2.34.1

