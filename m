Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022124.outbound.protection.outlook.com [52.101.66.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4775648643C;
	Thu,  8 Oct 2026 09:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452945; cv=fail; b=Ay/9lcnl4MEbPONN/OmYcTc6aXzv9nTfgzg0CXKUItQg7cdDRNXV4YIR2bjVrDY90Po/wdg+kdqDktHkQ8GQooSD5uCF5c3C2FVDRq9ApyQatU/D1wmnmBla2Y1lzgk03+9a/MClB2KXjDTZjjOOgZzPNHnRg7n7V94dm5j2Vfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452945; c=relaxed/simple;
	bh=LbU8zbeJEzysKpxVKZefyVhNPxbUBh7tU6MNKaZv9d4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HrKD6o1p0aWALxBgEyzPpo8MRQTSOu9uaTkJAAeu6t5rLZgIi1f/UHC5KkBG6YI15pW9jsmbXux9alSrW6PqYc1xXaIzRse8hSqCnl5SsDYeDp7W9fEIJj3vWxyThXnJ3ccgxAhEuVO4pZv23AZS9xwgBLUyy75uWYng0MISqc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=xtjVC4O9; arc=fail smtp.client-ip=52.101.66.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="xtjVC4O9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUg0tdNImNavZ4UV7CowwSv73JPE9CMYnkz0ShNEoDJIeS81jym2Ct5TFwIktIDFEFdxNTU7TiKZH1TR9HRn7Xw64rAtAK7FTmoMmygt6+6mpjHzjAYGuJuy3NbGiOmNqPqWYSmnT0BUKj49AtII9Ie4Z56CAO+yJKDJ07aXro5C78gepYdYtMWmCv/CROLvV1tqSAAzo/V7u3PcaebMCuSFS2Kv8ROttbGNJSTBNoxsDORw0qBiKcGuQjTv9cFA8Dz9HW1zPuNi/wbn20rknHlboUJ/ZB5NpOYqo2jP6zLCBUk4wKZz+7jVfJIW5+E+cT0yAgG318thneXgmDpKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5DhP7ylzlTomdpGTcNT3K5kwmK5Tp5PE770QhnPhR30=;
 b=tf/iwhj+k6K27Dgdm9/vu40B+5LeLhA9e0tjJ5T0tO5X4uG4nL/tLFkr66WDwT0jYvRvlOlRkgGT+iwWuEAk7Y+kMT7o8DgbYyvGX9lFUBmo5OXHEsmzewb1VEUM463I89pA6kZI2tpNoj7JgG36T8qpKhikqy+AiyxP5B+ud/SkGYyaab5Le+wTEmcjRkHWBZ9vWShIRMz1dA0mRqSvaQ/5nsh0J4mC1IUXhoDPgxIpjShpO7qb5wEBvT8Iy5Ro1tNs48xb8sUshkCWLRDWidIv5LdcnU2NDYJFiZ4PT+euKJznCMpOLw4KElVkFpyWnonSLC4vwDNbfvc0qJ/o1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5DhP7ylzlTomdpGTcNT3K5kwmK5Tp5PE770QhnPhR30=;
 b=xtjVC4O9286tsz0/dLl669+OVDVtbjiwbdfnbp7m1gvuyCzhn/C8vhaVjqcKiS1662VTeJCgF6q+VZmyqtaGEn0vA5ribS1l8qT/H45PuIsXi/NRM1MyPbpjy56CAT7VuaswB3zNQaVknAKxHiOpG4TAvQsoiF//ax/P8YAgQehfvwgWadVpTdOhqX5/ZvtgNUyVKwCMfYe9d4OlcOveqHs4guFHoEeFpc7//0CezTBMVHwofsWEYF9dpSI0c/XUhM2ejitdZwQClwVpQ34of62iigZYWuTjwd4OkmNi/7QXlLiV9SHyTLlYz1uNNAYtprSfCMGSNNkby49cR6mB6w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by PAXPR06MB7567.eurprd06.prod.outlook.com (2603:10a6:102:dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 09:48:57 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 09:48:57 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Thu, 08 Oct 2026 09:48:24 +0000
Subject: [PATCH v8 1/9] serial: max310x: don't clobber the TX break bit in
 set_termios
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-max310x-rs485-sw-delay-v8-1-6ba881f81e1f@vaisala.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791452935; l=2867;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=LbU8zbeJEzysKpxVKZefyVhNPxbUBh7tU6MNKaZv9d4=;
 b=fmjjGzXxrmsx5tdmvtij4D5/1QkY0ILFgXZSxcMirK/zw1lTyF957G8gLwbQEFASaPVG/ybXg
 RPEaHuOg+eTBpiImd05lSmI5sfdueVZh5RAOffxDmj+EPmyN7C0BSeK
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
X-MS-Office365-Filtering-Correlation-Id: ecd088e3-436f-450f-2891-08df25215ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|23010399003|18002099003|22082099003|10067099003|3023799007|11063799006|5023799004|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	pjbVVT/xVg/OM9inf4vTzPSV645U4/slO+/GCv6l8ahfjQ5Idd0JXs+QhON+SCHhDZru8bTcNXj5uLXrTHDlWqRDZ/mS2YUtCwZC2nHjiUfIZ4G7E9tcTnVvDvPsTMw+R6W11mUUj+8f9qFQoNvSDYzYrgcmOhjygiu4gvlnOc2JJ1rvxYsNUkAl0RiJwbVIxBo6F45xLDBHEJe22sMo2gJQc6CFzIvQnNfSwGGmlihjJBLsUJejgqome2QyAhf8LZZ9XtknaCTvFDvcWFBBzVfZevqLaK96zmq6bu8E+ayQ1HUjSG+DXLZdBoqpmR/2Fq+EEXPngI5DmmrdRZr/fIQVXPnVIBcYdoDpFt4wUgzUKNa9gsHvHJu4jj6zEflz/SVl62+H2M3jFBu+G5IYpBLBbQMAjLkRRqOhUr4E26Nt0LrTaOuZ+DFaDKeaQDPGM0kNoz7HGsym71LbD0l8bGJ+1LtnWoIsc/kI9BCKFwx7/5TQL+lCzwPszyDzKIxxEejoXUWJkyg9NQ42DsU692b7NJCvXO+S8GcQZkQ44RmyMzcfzNogj30Ii1zyTZH+w0B3Uu2lBOKFVBrnJLO0PP7T+HEFT6m8lTVHf/U+d4A0NbDPp7Y37eKg1zgVcPHFzeuoy5Qei4pMNRa0eIiRdzED7RY2k4WIbXWbtlh/uRDQOSPj1yCByGX3POkY34US01bF6FYXDQANcy4o/3ZWpPkWNlamUzXKdnzPLOf3hMo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(5023799004)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekI3SG41Mm9JdXNYelM0Rm5IbzMvWmNiMTVVZ2M1ZjhrMTZqZE50elJraEtn?=
 =?utf-8?B?eEtmU3dGMDZJdk42cVdzNFNjTXZLb3Z1ekFpMWVGUHhYMDdJWEFIWGFlTWl3?=
 =?utf-8?B?WHMyUzk3Q1MrMVRxOGl4K2NvK01kaGg3SGtMeE4vd2tpcXNIaVFocjlPaDZC?=
 =?utf-8?B?emRGMjJJeklQVVQwMFh6b3JXVXYxSkIzdS8rbjhHbmsyMGJ4RHU4ZzQ2L1Fu?=
 =?utf-8?B?MWpuUndpQTZWN1V4bllBcFY3T1RPZ3FNYmtQQ1FnSjh0allkbTk2N3ZaajVx?=
 =?utf-8?B?WXZnOHg5QlJMSWwwVmRNYTZiRC92T3FnRWJEcHpka2dUMkQrNXhpb1hpcVhh?=
 =?utf-8?B?TlRSY2xtWlo4Z21Vd21hRWtLQVdNT2xXbnRlZ3RrOUdEMlF1THFXQWZkMnV3?=
 =?utf-8?B?VVNvRHNYME11QWdEcE1BUVNDM0oxMlZmZHk5UUZqTE9OMG05YzBSK0cvaU0y?=
 =?utf-8?B?NFBDMGI4VlQxTDdXZExFNmRXdlFxbVdRN3RwSlJEWGR1OFdaVEFHZ1ZiejA3?=
 =?utf-8?B?Vzk4MXk4aExhbFR4RkxxMUZpOXppclBBY0F2OEdDY29Ec0kxb3N6cENFTDdn?=
 =?utf-8?B?bEp0bkNobGtjZU9LOU9DOERRUWRyZWxvczRSTFk0VVdFYUQ1eGM4aVYvcVc3?=
 =?utf-8?B?YnJFaGhidlFheWZicVgrQmd5Tmo1Vzd6ZlJjSFBsV3h6UlByWGlZTWZBVlU0?=
 =?utf-8?B?N3BqK08xN2NaL1VBb1Z1TzNKTTNLZkZoTzBPbTIrcFFkRzAvaENKT3RiV3FI?=
 =?utf-8?B?Z0FWZXdkeHgvbk1IYkVMTVhhZjZVWWdaeE5WMzYrQ2JFa1A4V2t1RkVjTkZH?=
 =?utf-8?B?bktYc1NvSlVqSWJDdFV2U0JTWk5xYUxtSWdtUEpaUHh0KzU3UW5pMWhicFVl?=
 =?utf-8?B?eFJXVzI5M1hBMHlOcWlZdVRkTytTREJjcTlPdENvaDR5cFhHUytSSWZ2eXYv?=
 =?utf-8?B?MmFRbVpEZlpCUHdmNUpzaFNtY0piajZ6ejhjN1BKdktZU29rcXo0Mk1nMVV6?=
 =?utf-8?B?MlNRNHg4T2VvWjZHZWRmL25GNWVyNlR6NW84UmRXbmNCeUF0eHQ3YytDV3kr?=
 =?utf-8?B?dUwwbjd5d3BkS2ErcEsrdDdXUzRjSXdUODZqTGZ6OHhIaitlNXQyMFFkaHJ0?=
 =?utf-8?B?d0NmTllpVE5TQ1g4YmFJU05mSmpGODc0UnhVOVdibGk5VTBJTSt1ZGRmNkxB?=
 =?utf-8?B?ZEhOZEowZTJaZ1B4b29IWWRqZVV2VTBOS0RlSkpCdVB6alI2TUJWSmdNTExX?=
 =?utf-8?B?d0xqcUVCczg2cGhQNnNobmltOUVWNzhMN2tUdm5sNU9QS0QwNExyaGpqWnNE?=
 =?utf-8?B?OVdDcFFqY3R4NWx0R3dmV2hjY1dKcEtpVTZLejl3a1hGWEhoWlV5RGVROVlN?=
 =?utf-8?B?cXc1UkROeWJuNGdBTTlDV2UxdDhjY0lySWhieVViNDE2MzVEdTBlL25MdGhJ?=
 =?utf-8?B?WnNPeHh5eXRjd0ZWa21nYjdoMWg4azVCdGRnSVR5VmlWSXBYbEhKUjFXVldU?=
 =?utf-8?B?R01YVS85MnBhNVFXZGVQK3UydFM5LzVSMnNXUURqSFh6YWt1NWZ1WC9uQ3pa?=
 =?utf-8?B?TU5EV1dTa1JuMjFjTEtURndmanFSRENTd3pmOXRJYjFaem1wRWtNa0dOVEpw?=
 =?utf-8?B?ZG9nWTgyZHE3a2NsaU81dUZ1b3Mza2pPUGZiWGQzN04wMHJSbkErVWw5bmxl?=
 =?utf-8?B?bUFaREpESU5vczBSTUdpdGRZKy80Q1c2TXhYaG1xZ1JGZDRscC94cXVUUHhB?=
 =?utf-8?B?YXo5Y2NuSEFzY0ZjazRnNnFibjdYclI2RFZIVHVLVS96amY0eURUVDVZMTgx?=
 =?utf-8?B?WE5BK0JaL1NrZGN0bHlwbWdqSUxsQURJODdyTEozb1VQaVlnRjlMQjM5V05W?=
 =?utf-8?B?Szgrc1VEMHJHbGZCSXRxUjVpWEt0aTJOSG1XcDliOExVNVMzMmszZTBkd1Iz?=
 =?utf-8?B?bjZ4NzIzWmh4MU5tYWZXdUp0OGlNdlZpZkszOEFFcWd5WitmcGNrL0ZBTklr?=
 =?utf-8?B?c0JDZ28yNU9ueTBoSXFKSUV1UHAzN2ZYTE0wbEIxMVNqQ1B4c29aYmdqWWFZ?=
 =?utf-8?B?QzVVRWFyM3NqZWMyMEJrRnpRK0RQYStaVzZjaUZENzdYNnhUN0I0ZnIrNExE?=
 =?utf-8?B?VWg0TnFTNmNkUHlXTjY4MEsveTRoUHJQZGxabTRESzArM044VWxXR1NHWi9t?=
 =?utf-8?B?WmNwRVRJdVV6andnUE9HU1hVSnJyWnlqUXlkaXRiQkYwWHNwYzBSUHlxa1Jt?=
 =?utf-8?B?N0VDa3BDSTdjZ3ZwbkNiRXdzRUFiMGo0ZWVKeVMyeklTMCtHTGFxWklRbGhU?=
 =?utf-8?B?T1VsRC9PU2NzWkJzR2Y5Rnc3ZUtqWXovMmpTeDBMMmZpOWFoOXpGYlliM3hO?=
 =?utf-8?Q?pkAoSobcDXoQvRLI=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd088e3-436f-450f-2891-08df25215ec9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:48:56.5494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HktW8ExZT80t3CESfxNxPkbxHhvtBaI6UzREatU5dGkC1JAqNmXS+r3ipSCvFIxuryklkF9msTT6KAz+0vaKDzZ77UPRIDrIJT0FuKaF2JI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7567

A TX break asserted with TIOCSBRK ends early, with no error reported,
as soon as any termios change lands on the port: a break is a state
that must hold until TIOCCBRK, but max310x_set_termios() overwrites
the whole LCR register, and LCR also carries the TX break bit that
break_ctl() drives. No concurrency is required - a baud or parity
change from the same process ends the break just as well, and
break-led protocols lose their break with nothing in the logs.

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

