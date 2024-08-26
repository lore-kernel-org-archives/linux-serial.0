Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.86.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE26193422
	for <linux-serial@vger.kernel.org>; Mon, 26 Aug 2024 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686890; cv=none; b=ZRggtOdaXu4oDOdSI52Msz6Vas64/+NL3nZqNmfdVtv6DuehBzbyoYo2DLxjGtnhK4kwqLC69QxgRBDbYkmhK7WQGTvL+MonkBQBdYBOYngzGVqjX1TnnGMO/KQf6sVv2NXAB+d25TM9e5XllVRpJKULzxB8MGIhveDnTC8mBbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686890; c=relaxed/simple;
	bh=MwEVhaAbbZG5Mnu0wsRNb0OT3kpHS7zusoKlKGO7lww=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 MIME-Version:Content-Type; b=kf21ZZ2HEEKzlcfEtS0imMF+mi87CjY0wTCByyFq8FoM4y1GmOuJWpOdXmKpWfBhjUWMuMSzr5rWhBygO4ueJjRCas/hu7Wa5hfDbevLZBGVyhWme8CWwFXrwmpXx81DoxASaRFk9U/4d7LeR+kJlddZn0qVLopb0XXdXN2tyOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=ZYnlKV64; arc=none smtp.client-ip=185.58.86.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="ZYnlKV64"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1724686887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MmDul3sGjX2alKR0pnOMKeFwHoMlNM0CJyllM9dlV8Y=;
	b=ZYnlKV64gUVXJEikW+AwLdY6CMskUM5r2O8FiJzKyyA8QRrJ3SvtPLmVDKSt1PGqTRpihD
	Ye+xULOnev/LhD4VbZL2EyHuDlcTiwnfiTkBTqh6ai7BdSwFdhGaNPJZlBnuKYUTHV2Mdz
	SAk2q7v8cKm/D7Mkr7zI94FgCWPe0pE=
Received: from GBR01-LO4-obe.outbound.protection.outlook.com
 (mail-lo4gbr01lp2109.outbound.protection.outlook.com [104.47.85.109]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-17-kUtsOAUCO-mPsS5ujUIy6A-1; Mon, 26 Aug 2024 16:41:26 +0100
X-MC-Unique: kUtsOAUCO-mPsS5ujUIy6A-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by CWXP123MB6192.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 15:41:25 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 15:41:25 +0000
Message-ID: <91a9aa22-47b7-449a-a7ad-877ce1b6402e@camlingroup.com>
Date: Mon, 26 Aug 2024 17:41:23 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 1/3] serial: sc16is7xx: remove SC16IS7XX_MSR_DELTA_MASK
From: Lech Perczak <lech.perczak@camlingroup.com>
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <k.drobinski@camlintechnologies.com>,
 Pawel Lenkow <p.lenkow@camlintechnologies.com>,
 Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
References: <9c1f8fd4-a2a5-4f92-9e86-2cf0103b1908@camlingroup.com>
In-Reply-To: <9c1f8fd4-a2a5-4f92-9e86-2cf0103b1908@camlingroup.com>
X-ClientProxiedBy: WA2P291CA0009.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::6) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|CWXP123MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 4567b62d-796b-4616-27f4-08dcc5e58b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RlFhcVFUNFZKcW5aUkx1ZHA3bHh3UmNTODF4TDhEVkFycmlicE55NmJDRXhy?=
 =?utf-8?B?V0t0T09XOVd0QTlpS1JwQ1ZVR0pvYWYzclNnd0h6WXFWdGgrYnpoeEZNVWpn?=
 =?utf-8?B?cUp3ZjRtSEhXS2drQkZnZDFzZUc3YzMwY0pCTzJpRDVVVGJrT3hkTEpIM0Nq?=
 =?utf-8?B?ODhwZ1E1cXh1bm9hdk5IQUJZb2tuZURCMWpueU5FOUNwdFUwY28ycFgxNVIy?=
 =?utf-8?B?V1BkVGtiRXhPVjNBYUYyZUxvMCtLcnBPRHhiY3J0YVdMa1dhTW9Kc2daaXNE?=
 =?utf-8?B?ZU9sN1M3TWNqNyt0NGRWL2twQXpsRk9WWDBQVW14d054YmxQdEdBSmcrTVFM?=
 =?utf-8?B?aUx3bExjcVRGN2ZBQ3FLNkxXT0JyS3U2QmlOTlozREJzMkFCbTg3SGtyL2E1?=
 =?utf-8?B?RlV5ZDZac1FUc2FSeVRTVUNkeEUyUlh2NDZuY0llMzVkaWVhVlJXNk1sNTBB?=
 =?utf-8?B?TitXR3Z6Zi9WZFZkYURPeU9FQmtHWmtlSzBoVFZRR2dCdVZiQ2xFQ3FvYk1q?=
 =?utf-8?B?UjAxUS9vWXpHSDN2Qk9vM3NGbVVETUFDZkNhRUJXVzBNOFptN1V5MXR0Q1Qx?=
 =?utf-8?B?Wm9CZVoyY01SeU5Eb0g0VGtXa1IwSzVPRlg3NlpDcmd1YWovQTZwWitjeWE5?=
 =?utf-8?B?N0FWQ1NuTEJNYjIyZVpESFQ2ZXgvTURsS2I0L210LzhBNW50SDNYTm9hTHhF?=
 =?utf-8?B?V3lndTVDWTBIZFRtYVdsRWEwUGFLWldtbVFXcTk3MkY4R1lySUIwWndqekJq?=
 =?utf-8?B?M0RjRjI4bDlMZ25RSStIemhJbkR0cko2R1orVUlQSzRGK3FWaHJWK2F5RGNR?=
 =?utf-8?B?amwza3ZGbEplbnVzNUxSQ0lldGs0TTg1RDVBL01tdFphRHRGSFQ0SWl5Yi9I?=
 =?utf-8?B?L1lieHVZc3RYTnlCR2N1TUZITHVBMy84RTJqcHFLYllPbW9tSUlZMXB3OWJL?=
 =?utf-8?B?bjVNeFRXQ05aUkg2ck1iaWtuMkhCcStTOU9iVkRza0d2UVlRMFFtb01zMms2?=
 =?utf-8?B?aTRQaGViWERjUFQ3ODdIWS9HU2JUQmdMWGJiNUVxdjFUUXR6YWxZSmxrUkY3?=
 =?utf-8?B?QmVNb2dDbGdOTVo2cEdod1hFMDJQT0hYQzlRV1k3Zk04RkJKbjQ2amkzOE5E?=
 =?utf-8?B?K1BmZ2gzSWg5aHA0QUNaamFsbVNPZlplendjaW5YRXpzclNGRXdQbU1Wdmpt?=
 =?utf-8?B?L1ZOT1dOcjdqQkNxbUhoanl4WVNmK3NrcXo0QkF0WDBEV3JZdWEwVVV2Qk5q?=
 =?utf-8?B?T3MwS3JPR0cvMTVzaFRabVk1eWVNUHRZU2Yrb0lrYVMwd3diUHVWWkRSb2lL?=
 =?utf-8?B?dHd2TEZHYm1CS05WUnNlWVNRc3IrSnNNeXhiVVZESitSZDFjbTMxbCtBTDBo?=
 =?utf-8?B?RVFYVDN0bnhkZUNJV09ZbFJmTzdKL1hqaG8xSW9OeTMyR01JNzkzT0pFanBy?=
 =?utf-8?B?a3NpMDZmWmJ3M2xrYVlHbE1Wekx6UHpLa0FHR0lydHhRNUo0MWE2Z3dKM1V6?=
 =?utf-8?B?QXFvTG0zSFhuSU5ENkpXc3B2RU1JR1orVk5xQzJIK1RqYm1tVGZtbHBva1cz?=
 =?utf-8?B?dWVqYzQyYVNvcXBjeTJaMUtKN0FublAvenpqajVRcUdYbEdOd1E4a28veDEv?=
 =?utf-8?B?SjZ2c29JU1RiSlNEdFJSamN0TjVNaG5xem9HbjJKZjVpWXIzNHRxQ3EwNlhW?=
 =?utf-8?B?cVlVTkorWGluOEtuL3V1Q0hmeXQ0OHVNYlZuMzF4bURDU1JoSGpqRkJuc1RQ?=
 =?utf-8?B?eEp5NzJKN2xKUXhwbEExaWdPZzJuRm1NaFgvTG92RklvVU9WRm1yQkdJNHZp?=
 =?utf-8?B?Y3VabGM1V2tOUDdoMU9wZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWs1L2xiN2dUbVYwbEppRWdUWVFYcE1NMElxSzFsUUlPeU1BYUxKUXNCUzhY?=
 =?utf-8?B?MVVUd2MySlFhNFFicWRiNVpQSkVWQTF0YkRGYTRtZnQ4UkloQ1dGZXg1Zzl5?=
 =?utf-8?B?ZmtZR1dybHUvRnNOZ1lGdUVHRlI4STF3aEJObTUvOXR1WUlLdXQzY0k5ZTNT?=
 =?utf-8?B?Z1pnRmFEaUlUZVY0aDNyWXkxQzc0NkZWNGhVSFFqK1E1V2ExNklEN25YdUwz?=
 =?utf-8?B?NmowaEV5K2FoNnBQT0tPaHNzbnJOTCtlNXRYcUpjODFDTUtlNVk2U005YUEr?=
 =?utf-8?B?djZ5RXB4cUZSRVU1TjBqMVpwQzVCS0Eva2FSa0l5bVZYVTZDTTFreXc4SDVx?=
 =?utf-8?B?cllESDVBRmQ1T013VXZBODV1M1NKV0dpblBiQUlYd1IrRlBDU04rN3JreVh1?=
 =?utf-8?B?NVo0M1NXK0QyM05jYThqT0VJRW5YcXlnRVZEWDBvaXBDeUtKRS9halVXNXBs?=
 =?utf-8?B?WHppTTVvRlhWSUxTYjdQWnBzQ0F0RDZNQnVCZExDc0toK3dISFhUZWdTYkJt?=
 =?utf-8?B?alJHeGtxY3ZuNkxuOVlTZUFnOG9OazdiY3hNVTkrQjNxdyt4ZjhjR0tjaXJl?=
 =?utf-8?B?S0ZBZk1mSklKMWowUXdPSU1KWVhSTjVOczdNNnYvaDFQeWRFZ1c4Wkw5YzBi?=
 =?utf-8?B?L0tZek5abVd1b3kxdWNhVHMySWRGK1FUTHFKMUlTaFBUMDhJNkoyUjA3aVlB?=
 =?utf-8?B?ckdKQXhIWGxqaitmMjhoM3dpNkVPS1pIaGNpQURVVXVzdFRrZ1c3dkluZUVh?=
 =?utf-8?B?dWR2VzY3cHBsQWJLUmxnVnpGSUpITlpnbGxTRkdWb2JzK1VEU1AwT05sSkFE?=
 =?utf-8?B?VjJ3S2dRWVFweFg1RzFLekFIRGVGNmNkOS8zTXZRa3k3dTdXWStmcXBMaE4v?=
 =?utf-8?B?Z2RJWHZCQlNOTkgzZXNIQVNmMC8vcXJMbml5WEJPRzhFTmI2R2Vkc081VGNW?=
 =?utf-8?B?bTlpMHgrZmhUVUtYT2MzSnNmenRUdUFHTGtpbndDdHpncmpLdjFLYkVuUDkv?=
 =?utf-8?B?dXBSc0lwRS8xSFpUNmYrbS9pRTkyR2ZXOUJFL3NLRGZkd0NpTkxhTjZ1ODZ2?=
 =?utf-8?B?UmdTNmdvQy91ZEJBeXBydjMxblhTRzdNTHZZYTltRGdYanozcFdVbUZSR1Br?=
 =?utf-8?B?eWNKV1RNNHJEOFJiU0FVTEpJK1lKa1lTSUZzejN2YVN3REYrNW00N0VrN0xp?=
 =?utf-8?B?dHQwSXNsYlFERG04M2FVNDc3dEw5OFRiTlVsWFhvWGNKMVNlT2tJc1NDc0or?=
 =?utf-8?B?RytHbytnbHhSeFIvZTNtQS9EYmc4SXRTdyt4cDQ0ZzV5a0hmMi9iWEthdDRG?=
 =?utf-8?B?VUw3VXFlaFdjdDc4WlRSNWdJbzdPRm1uYWd4NmF2d3VkNkF3dlRLWEtyYk04?=
 =?utf-8?B?bVNDaWNXNzBvTlUrSGJ0Zk1KUUNxRjliODBnQ2RBZHhUdHpiWDFic09qeHdz?=
 =?utf-8?B?OWVCSzd4aXhSTTNQOVpHRmZGZmVBcUo0czBHMnZlQ294VzFpR0lFdVV2NXNq?=
 =?utf-8?B?eXNBVEp3N0N1anZRdTFWdUZvM1JsTGt1M0tkZHdIVE9xenF6d3JVMERULzJo?=
 =?utf-8?B?MU1aY2VGcTZ0ZSs3cnhmYUd6NVpOWWM4SGhFUURrUFUzcXZoL0w2NXIwZ1BF?=
 =?utf-8?B?MTVlRXNIWkNieG1Ca0YyRk5iUjhPaXJ1aFBQWE9FU3RIVDZNYjBsSW5EbnVo?=
 =?utf-8?B?WEZaa2tIVUlOLzdGSlkzK1FwVVhRU1FRb3ZqSSt1QlRBWUJSQ1Z3anVrcXlI?=
 =?utf-8?B?T0Z1SW9sRmc3MUVCb01iZk1RVHgrMDVndytlZU1EQVlOcUpoVS9vYU11UmYr?=
 =?utf-8?B?U0dPMVNpR05XNkNWVVIydUlta0tCY25HVjhOK0VFbmFqak5JVzhHVWMxSzZM?=
 =?utf-8?B?T0FvMmxoWG9tSWJpbm1BcUp5emhYSER4MUxYcXBOVklYclBBMTQ1cU00cDBn?=
 =?utf-8?B?Z2ZNczBraG80UXVpZkZBQTFzeWN3bGMwM2ExNkFJRm8zbnhDVEh2MDA2ZGZi?=
 =?utf-8?B?VkFVNHBRT2JvZFYrRHdIY3BibFRhQzArc1RCbUwxcVVlMDFrSWZrZ0hjVHJs?=
 =?utf-8?B?NHlocEFwNlE3SUZtVStXdEpBVGdPbGM3T2lOdUZZbG5tcXJKSjRKa29NdGxj?=
 =?utf-8?B?bVB3UTRNaFhUZDExdk0xZVk4V3hkVkJnSUEyazlqOG9JV3UyaWQwMTZaUm5w?=
 =?utf-8?B?S0E9PQ==?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4567b62d-796b-4616-27f4-08dcc5e58b49
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 15:41:25.6347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T97+352W3jS1KttRSiK/67dfTyo4zwmezPd6F3IABP721aBo29+kXcm5xYafP5r7gBdX7QAnTIAPOqoEsfgzFCtN+x2gq9J2gvMVgqk/EgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB6192
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

