Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D8F18BC31
	for <linux-serial@vger.kernel.org>; Fri, 23 Aug 2024 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432052; cv=none; b=hR65hboPYZ5hBUkYDS8RKGQvr8TSAsT5xZU/hGy8BHPmWk3ezXO9+GPteJpnckWXzeM0F3ePKO6HKaq8GDR3TJrm24JSVWoJ0sHd6AVCnPC68xew5HsFWErFIGkB4KFmUfafEQE2t+wWdQX3dUlo1zVtyXzxTvkJomtfvmJHAxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432052; c=relaxed/simple;
	bh=MwEVhaAbbZG5Mnu0wsRNb0OT3kpHS7zusoKlKGO7lww=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 MIME-Version:Content-Type; b=QTSpl+4a7pVccPwAiwp0Z5CfXhoiT4hJkpognD62lNwZWn6rbY93cw4YpmabFPD9kZT6m0epVJ/z8L1gdM2wcF1npVTFQCSo3wLy1ZFxoizsfsc6GTdUE0MMDiA3S+WjX8gnqLSpNDoL8gk3w+GGNWVnDQ6qaJXVt2roezD0fQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=P+saWbeL; arc=none smtp.client-ip=185.58.85.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="P+saWbeL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1724432048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MmDul3sGjX2alKR0pnOMKeFwHoMlNM0CJyllM9dlV8Y=;
	b=P+saWbeLsTGW1ibfgMszNfJxgM3ahSNwoW+gwAOg+XgyBkChScirH3nJV8aXpOoFlmlOBG
	JEy0bM6pLHJkrbMoQThn8zQM1tYsyI/FZeXiDEPvyEjGjUfbdWGBj0qBFvbWh8JwV3qOjy
	RWrIaa9UeKmpscgYUcLqqIrf4qJVdl8=
Received: from GBR01-CWX-obe.outbound.protection.outlook.com
 (mail-cwxgbr01lp2043.outbound.protection.outlook.com [104.47.85.43]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-192-M2L29m98NCeuO4dLZeW_zQ-1; Fri, 23 Aug 2024 17:54:07 +0100
X-MC-Unique: M2L29m98NCeuO4dLZeW_zQ-1
Received: from LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:20b::7)
 by LO2P123MB6200.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:268::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Fri, 23 Aug
 2024 16:54:06 +0000
Received: from LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM
 ([fe80::55a9:7dae:8812:f567]) by LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM
 ([fe80::55a9:7dae:8812:f567%5]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 16:54:06 +0000
Message-ID: <be349181-5616-4bde-ba0b-ee0eba752c5d@camlingroup.com>
Date: Fri, 23 Aug 2024 18:54:04 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 1/3] serial: sc16is7xx: remove SC16IS7XX_MSR_DELTA_MASK
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
X-ClientProxiedBy: BEXP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::26)
 To LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:20b::7)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO4P123MB5272:EE_|LO2P123MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: c42d20b4-0e82-4d3e-85db-08dcc394331a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U1JReDRsWUw2TlNwWVltMk1xb3NUZ1JzMVdQRVh5K2I0dCtOSjFZQSszRTZy?=
 =?utf-8?B?bVVBd2o5TysxUDYzcEgyNlZ5YXNvM3A3TzFQcXk3K2hyNXUxMXFFc1JyR3lX?=
 =?utf-8?B?UnFWN2xlb3Y4eTFHU1N0cGZlNWg3SE0vRjF3Y1hrY0lUNzBjYnNsZXFaWFFM?=
 =?utf-8?B?T0ZvS0h1RGE2UnFCK2kreDJxZk1vb3Q5VDlFNXpUQXpENFU4dVpQWVVRTThM?=
 =?utf-8?B?OUZaekpjekRtdGU4MWtubWs5YjgyaXkrOWxsc3ZjS2hJM2Nnb2o5Y3VmU20y?=
 =?utf-8?B?MjVhZWdndUQrZ29TclRDQmNvTFphVDFqaTZMMzAwb045OWZQZGRMNkZXYzhC?=
 =?utf-8?B?azhId3k4bjJCYnhvOHI0WjllTEtoL0R1WEZUZW95NmFhbG1oUTg2SmxYYTVE?=
 =?utf-8?B?TkdPR0orK1lhZE1VUFVPb3k2RUI0dnBzQWgrZGZYK2x0OWdCbllPM3dUeFpL?=
 =?utf-8?B?c1FPYk5vODhRTkI2NW1YN3ZuYUlaU2tKb1VST2dZTGZLOWRPcWJpNFVIRnc3?=
 =?utf-8?B?S2FtUjhqVUNDZytqWjdnT3RuOXJuc2I1SFdxMFFiU3hHWjg3ZWN1MmoyZzVJ?=
 =?utf-8?B?N1lKQ2IxMDdQOWJyS0Fockx6dWJ3WkhLdFpWanUybWxzcnp3N0JudEFpdHhj?=
 =?utf-8?B?WmlEMTNaWm1POUFsQUNYT3g1TE9Sb0tuWGRnMTlQRFVWclFCa1RieVhvQ2FB?=
 =?utf-8?B?amlTVTF0WTkvVUcrTHpyWFNxU0p1UGRtbHR0eGFiSmFuQU5kT2NmejVOZ3pt?=
 =?utf-8?B?Vi92MTNQVlIyck5jWW13YTBVd3dta3M3STkwNkVzaUoyUWw3S3FyOTF1VG1U?=
 =?utf-8?B?dzRIOU9QMXBtM2tLWld6b0UxRVVCU0x3T3VqeTNCQnRBY1UyNWw5bDJzWGJ2?=
 =?utf-8?B?Q1NQWGd3bHVBckc3bDRxODlKT2c5S2gxOG1GZDVOUnk2TktKZzZhQ2pwMlpr?=
 =?utf-8?B?UVBFZW5hZ2VmQTN3UHlHWVVQUGNyaUE2d2hkZm1ybDV2cnc5T0prOWxQS2x4?=
 =?utf-8?B?Sk5sWU5BcVdjeEoyVGVMdjhqK1M1SlBkS2NnbG9RNWNIL2FzaGQwQVZhai91?=
 =?utf-8?B?MVdYRmczVzM4NTlSUUxhNjUzdzE1M3gxZzNwUDh5elZrQWxQb0VMck1Na0h1?=
 =?utf-8?B?SnFIL0E2a2Y4eGFBcDc3RXNQVzhsM0c4aXRIZHJPTGlNelJyQWdHeDFST2Rx?=
 =?utf-8?B?Y0xyZHN1anJVdzlmdG9pekY2aDgydTZVdjZiQWl6ZE56QVFJM0MybXF6T05w?=
 =?utf-8?B?ei9VZVpxekFpNS9OMWpBZjJsRFV1bkRVUFI3VUFKMTVsSnhvRndFdnBrSHRE?=
 =?utf-8?B?ZTNiWTF6UGNZZGJkc00vTmxOK0VKbklHT2UzRG1sVEhmMzgzVStCQnFnR3F5?=
 =?utf-8?B?amFXMDlWSE9iZGsvMTd5WE1rSmpRcXllMEdGZ3JlNVlaTFY3a1p6MHdsQ1Jj?=
 =?utf-8?B?ZVVVRlBrMWU4REFGR0M0MCtwaWM0OXkyOExWQzROaXZ5dXgzSmJpQlNrWnUr?=
 =?utf-8?B?TExzQ0J6RUtvOUJGVWhFM1R5Y09icmpidlBNdDlaRXF3dVNPcG1paXZXdC9y?=
 =?utf-8?B?QytBOHd4TXNMNk8rQ2FjQUsyMVVhOUFweHdOM3dLak5QZmFKK0w0cnhnaFBE?=
 =?utf-8?B?a0VSZUpxNVQvbHpTUll5ZFNUL1k2UUdUdWI3R2c1M0VKUnkyZWI0TUM5Rmd1?=
 =?utf-8?B?azAyWVZ5Z3JRWUNFUVpZQnpKelRLb0p0dEN2K05aWUttcFdmeWsvREMvOFJY?=
 =?utf-8?B?TmxyUU9EV3hPaDVFdTZoSytjZE1qdDVseDZtYTlhWnlGSkxabGJIYWx1eUMy?=
 =?utf-8?B?UEt2SWlWeThEV01MYWNkUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUF2bEU3TTQxZFNtVnhLTDN2cFdIaTBmZ2tCS2FlNTBtb0E4ZHh0SklmN0M2?=
 =?utf-8?B?Q1BnaGlYQzRlLzVPTEc3WndNY2JiVGFnN05RbkZqdVFMU0xCdnlnTlIrNUtS?=
 =?utf-8?B?K3hDbHFJbm1xWEZHckFqSURJY3Vkb1FZL0l1c1J0NWRocHRiK2l4OVVHRFZG?=
 =?utf-8?B?dGVBakNJZ3E2bUt0cTVlcktSbFBoTE53dEFVdVZ1bFp2NDcwU3VsWEQ4eDlz?=
 =?utf-8?B?dlprd2FTa0JmMmtiQXYySXhqdmNoYUk0blV3OWZhZmdQN0dlVzJsUjNMR0Jv?=
 =?utf-8?B?bWZ4WFJxQmZUUU9WNDgyLzhFRUVVVDdwNEtCaGxSTWZ4UEhHWkh4V1oxRnZo?=
 =?utf-8?B?dkhFbkdtcjVvSTFkMElBU05PNCtBZk9MdWlFTzFFeUNlTzkvaHJDR0tFUTdN?=
 =?utf-8?B?K2M1OU5aREZUbS94bFBqVWJ5VkxDM0NvV2JkR21FdjhoVmpHU0toRi80dHNX?=
 =?utf-8?B?Ty9ZTUZqVG5OWFdBTmpKd3BPN0VXcWRKY1Rhc2FrQXd3eG5Wa05OOFcvZzh3?=
 =?utf-8?B?K0N6bWFiZURZbjl6WlRGL1BqVnRjYzhwMkdLSWxuSlhDaFJIcWZjWVQ5Nisv?=
 =?utf-8?B?YmovdWk5bUNyNUZPdDErZUNIN0phUlRhcFI2dDdJS1lBcWNwOUVtdVJoSmpE?=
 =?utf-8?B?cFZxTHF4WmNjVlUwQjYzb2VPTTEwcDF1SjZWVXdCR2xoM1orcHVyYk9yOW9B?=
 =?utf-8?B?VGxHWHRsbHN6S3pmVnA4OUNRZm5LTjlEcm1BNEdTUDNiWjY2QXlhbCsvaDFO?=
 =?utf-8?B?UWplS2pRa0xmT0JlakpRSExTbWJ1SVBUaWYvQ3lPWmlnSnEvZDBkV0lTWjA1?=
 =?utf-8?B?Kzk5Qmk4bnIzai8xNmFxMC9DbStPOUhjZXlLdVdFdkQ3TlVGTWcrWjRkVVVN?=
 =?utf-8?B?eS9Fdk5icGswMDRLWWxWenlVQVNEWVoxdCs5M0VsRWFnM3ZLYWpTKyttZkhC?=
 =?utf-8?B?VGd6ajMxa2tEcWV5TzhyUGN3VkdBUGsrNXQ1UWZmcE03eXUyYXViNEJBWTJk?=
 =?utf-8?B?VlNJZkIzVEsweDd1MXM0eEEvRytzWTZqYlByOStLajVsUTl2d05jQ2EwQXRk?=
 =?utf-8?B?aTlJeEJxQkxGM3VzaUs0TzJrLzMvNnZ0WXNka3JVUVNJRTBuKzgrSnVzb3dP?=
 =?utf-8?B?QzkwajhxQ0tvb3haTm0wbWJoK3dFck9oTCtnL1M2SmU1RCt0ZWJ4NndLVTdu?=
 =?utf-8?B?Ti96ZVRkTkorR0ZIU2hEVmtNdUtRb3cwZEtCVUY4Yjk2czBqcHhxUzhESFFT?=
 =?utf-8?B?QzhpZ2k4UGQwY1VsK2hvZ2p0Q0dEYVU5ZHU3anhRRGRYZXUrV0hWbTNQWXlu?=
 =?utf-8?B?SWFxV25uOGQrUTNYY3JhSWxpaGlJVTRBKzlaUjFFeW5Sek5DcmE0RThHM1Uw?=
 =?utf-8?B?dnBoeEQ5WmNKc250M3l0RzdYN3pwWkJvZjdOV1gycW96U3BrcEJNYlZqZmFW?=
 =?utf-8?B?aDEyVnlYckhWMlVrRlAreC94by81UHFXMWtJeU9yWVo4cjJPUjRNSGpPY091?=
 =?utf-8?B?M2xMaWFMSkw0ckp6TzlOOFZhei9xU3VEK3Q3WlkzNkZsOFJ5MEg4cU9iZFRo?=
 =?utf-8?B?WmpCcnEwNkdBSXhZRWpXcUgxWmUwTzN5Q1B3QXFIZGRsS2Rwd2pyVEVyb01K?=
 =?utf-8?B?SWpoV3JtbER0OVZjYzZoZ2NadjYyejRPdHU1bXVDTVNnOERKblJKeFpHR21C?=
 =?utf-8?B?N0hVeDRuYlVWR2VNRHJuRGtLbDBhRC9kNDJzS243OTI4YWpwYVlqdkNmOGs3?=
 =?utf-8?B?THZ2OVNiU3VzRGNvVTgxanNyTnFkOEg4R2kzVTFKUG5YZTBUQnNCMHQzUFpK?=
 =?utf-8?B?V2wydUdFRkxFMHc2MlVTNDVPWCtsU1Y2MTU4ZVJFcDc5V2dDWVhYTDl3eTZo?=
 =?utf-8?B?bWw2SURjYXlsS3V3a3dkM1ZkZFVxZXFVNlBtYndZWlRhUTVlVWk2S2UraWJG?=
 =?utf-8?B?RCtDdWpTT2pqRHNWcW1YMVIzb3o0TnBtUGNHOEVIeHNORTRoYU9EUWo2Umtx?=
 =?utf-8?B?RjM5dmw0NWk0TjA0S21VK210dXZiSU1LZlhGVzJYU01EY3F2SXBNaWxnTlJh?=
 =?utf-8?B?UTNETE43MTlJTTRyTjBLdUx2SU5KWUlyVTh5T0Z5bnA5UUVLVGVRbllQbm43?=
 =?utf-8?B?SDZ5UmtpcU5VNStkUStPd2tqN3N0citGb3J3R2Z0Z1NPRUN6MkR3QkxYTmVD?=
 =?utf-8?B?L2w4ZHdybUZmc0txRmtJeHBlWkMxNUp2TU0zak1jL3NjNkV2MFRmTFcyNDJV?=
 =?utf-8?B?T2VoTytsSlVhSndINkRJazRDZnFRPT0=?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42d20b4-0e82-4d3e-85db-08dcc394331a
X-MS-Exchange-CrossTenant-AuthSource: LO4P123MB5272.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 16:54:06.0917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pv1BDGeJnc353cBrv7XwMe7KZ05NZvs8CyCGwUyMwo6DuUrEXH6f/2SgJLDVWkmDFPOg3yqT3NK+3rmoBRsneUM9szr+2FORkdQFk+gLylU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB6200
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This definition isn't used anywhere anymore, let's delete it.

Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Andy Shevchenko <andy@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index bf0065d1c8e9..8a2020f9930e 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -207,7 +207,6 @@
 #define SC16IS7XX_MSR_CD_BIT=09=09(1 << 7) /* CD (IO6)
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MSR_DELTA_MASK=090x0F     /* Any of the delta bits! */
=20
 /*
  * TCR register bits
--=20
2.34.1

