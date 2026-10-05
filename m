Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022080.outbound.protection.outlook.com [52.101.66.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9148124E;
	Mon,  5 Oct 2026 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206446; cv=fail; b=ADL28nI6lk6eHWHIXR3RWkppC31qxtw6au8mVKErP94ycbU9ZCvaeNaukTIGPMnnLYZmI2Vf+HqijtNEPNZrm1vx2/BE4yrLYBTUpjnEoNoT/ppFzIDJFKyJbphckpbyaHDCJ2cBRBUJ3866aq55SXWeERJfTEzA8/ItqrUtouU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206446; c=relaxed/simple;
	bh=b8ZBOXq3yhMDK0JCVU2YkVgHUUB7DPkJGpOBnTyJgbw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=UjId+F6nEbyIS6Krt/KWcOBtG90B45m+T5h6stYv/E+objhh4L8FCEvnJtHpTawU20QqdDKyiFgYBJnjyctcPtX8kZMpjTx55mwEfEiu6k87ICKX2oLWamuuu4QbPrb+toC1QecWeB69cM+OZNvr1F1sAoc74xH/CdXJ1sIjrRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=QdYGdITg; arc=fail smtp.client-ip=52.101.66.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="QdYGdITg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzTIp1RCGuzFTfwuIeMLAHjnq9S0gaKi5byMl9HkyrVrto92pmVScgfVPtHK2HpkLAFOCOtfm37TM8jCiDjDcHX5KjcZ9/zAYji28wC4CEuuUydntE+ttladyVfVAZOJMMdhOMiv1RI6g3zuIQ6+PsS+ge7+27oHyWwkqocYAgvxJP2rE1h+BexmYfPznvAJrn33wthmuFLbS62sV+gwopFLEFvUOz+w39IC6UYT/F8ndLcq2BlYYhLjAXdUTU4t1UW6SZW2odlF4wqIjppE2HsGj0ZnAG7QwWvcn9tZhAw1/IAxUS7ZleTUkyUwTjstsMiRiope6y2M9yOPSIwDVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KksCVbuWemW5AU9eCmpHZpnpxtieCYxtpLQpjWqnffc=;
 b=jx3Agy9xRWjFw6s/RXFtfkDfxGf29cuwC+8wHrySqcNZpJs1o5s8YMpjS2OXWslk3GXLpIRBI6F1Hwx/Wuz4ub9dQRh+zwKDGGBhKosGtldP3u0wnO28tHGfMgBHk969z+qtSB+nTeRpF+TCcP0GZXcOzjQ+kGUdS6/yBuPI/3lTUsf5SYOGhDI/oS5YsjxBVGj/tZlrh+1e+CwtGXjktaFtnNLKDxbinFbptOR5RHmkWQQBNcW5h2fIkQb+05++02pohMbcCT/NzL9fTB7fem3raxn9Lgd8y/4uH7xmeV1/kEGN28z8nCSQxEapdx1sb/yiC1ihwYApCe59Jfk+LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KksCVbuWemW5AU9eCmpHZpnpxtieCYxtpLQpjWqnffc=;
 b=QdYGdITgX1J0JS2Wjqpm/PQO22Oi9oS8utKHrbg7jPlsLhBeq616fiXuNydyG3z9NP9JjHQ7LE1lD53jcIgcpSFPCkHKfpDGO8eKGy7LAtdcprv3L0jBctEzckNtt6PuYP1pRP6bzcw7U3rPLwe39br6hoO+goJ8PPdQOE9qPtK7WFddt8ur1kJXl103cXz114AmAJwqIvZZ56Gmx61ZiVCVW9G9cgSzyTw4L2EdnRL3TdDJYNIbqvQJRGHcf3nthEf/cS6I99STR21P82rQ/kkB0TDAhae1E0cageciDHPSSBiViyFO3McYvgv90kgIDmdUL4VVbXmaTKcAcKS8CA==
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
Date: Mon, 05 Oct 2026 13:19:33 +0000
Subject: [PATCH v7 2/9] serial: max310x: assert the transceiver during a
 break
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-max310x-rs485-sw-delay-v7-2-6ae392eca08c@vaisala.com>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
In-Reply-To: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206394; l=5854;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=b8ZBOXq3yhMDK0JCVU2YkVgHUUB7DPkJGpOBnTyJgbw=;
 b=ItVcPtaj+0AnWGCN9CHDlBxN83jB9PXbjmDjQwmrOXqDD1ob5F9vXUsIk9SJM7X4Br7ld43qI
 QAAYh9TuYJxDBttrY8KSxWRCozwi3DlXzf8Xk0BAuQdEN1kUaZDXWhN
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
X-MS-Office365-Filtering-Correlation-Id: d9a163e9-20c8-4763-6fb2-08df22e35945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|52116014|22082099003|18002099003|38350700014|6133799003|10067099003|3023799007|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	he1zCsMAwHsN+UNTsM8tRllEpdFo1uDQYszcEaNXQKTKrNQ9hIL1Yvj6WEipKMUDif65yt+5Y0mK9o4IA/ip3DRtLQbf7cDLnbMQ0/ScNUG7ox9tvoTsmNinRTnBsQlyLiJed61OJ1KDTUTZJhmU/EOxMRjtLKUR4AadoTnW+tMcDi6a1doVvv//Y6eND+wzHXQKcPcLlHSUasaMKKbA+4rh2cKsmGDO5wzxgFUQMEaZ9Q2joBNdEMV0CLK2XOVlRzEJQa8yulJPxlnfocQkkcDXGAAwgDcXuTNHEuhYBRVI74gIES9qVHehUCPmj1s3cFY1h3r0Qv4GE3Zy80oqMVA/LuDN38oxFx63YvhYpoKHOiPWNPgVNgBPOZNjR0s03S0P2gIDgc8e120O6eLcX7ThG0iJCMBq1Ed7KmTHBsyKXxXAdryqrdZeJqqJ7ENiRLEAS827CB23jC1XgwTQnT1bioqPVDPSDA6J9VHNiYogyExL2najgg4La2Mw7NekJRvFV+8w1Z8yjsAChBBOicxiTJ02tKiWFn2Izq2nEHpVF+axGIEPPykwWDx/oe3OaQqMMJNYQnU01mIV21WcO+gklx6ymN6HKk6wthZRYeZRwkXnudVyPIJC1RP2JKeAK9+kEJ1jZsj59qXa8Uje3AVurybKzqmFTju3Nn3Z5JaIAqw+4i+cpnLrJxr5ScBJBr1d39R3xkRAHH8Tz1KAv6LaLyEPnMaWR9mGDAASnzU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(52116014)(22082099003)(18002099003)(38350700014)(6133799003)(10067099003)(3023799007)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFZTQ1dTZUZydWRrUXdISW9FSU5KNlByeElicy9FdE1aYzZrUThyQ0F4V1lW?=
 =?utf-8?B?RmlrdGhpVU9YTlpSVUxmbnF4L2xHSlFDKy9XcUoreVRjWitGbWZUYURyejNS?=
 =?utf-8?B?Sk14ZFprVDA0dEY2UGc4RFl6ZElxYjNCVWJTSEhSbWhMMWN5b1B6TE5NQi92?=
 =?utf-8?B?L3FWWmU2bkg2cmJQaE0rZG5FMnNxbVpPSG5IQWhkdHlNcmFOT0ZlbmMrdG1n?=
 =?utf-8?B?N0J4eDhGbXJySE1LNU5NZnZ1bjR3L2tYdFQ2ckJMaWRrZCs0dk85VkdGZVQ2?=
 =?utf-8?B?Ulc0Z01WRXU5R3U3SWdIYk84R0pkMW5vdVhiYW5iOHcrT0I3aE9GUnExc2NL?=
 =?utf-8?B?SnFEOWVqN1RlYnZaSTFMZWQrQVhHakVRaDQvd2dXWUd2SXhGM2VaeUR1K2dB?=
 =?utf-8?B?dnR2RlI2NXF4M2dMSlBNYTh3TFpGM1RaMTN1U2VzNnRCS1VNRk56SDFGN2c0?=
 =?utf-8?B?UjhGV0ZaYnRMTFR4WFBJaDFjait4Q2paVjBkQnV3a2xkaUQzMDQ0TnJPWjAz?=
 =?utf-8?B?Vi9iVlltVElNRGRncVRZRHRBU2tNdDRHblNvS2dLWkRxcEk3S3NKQjloNTRO?=
 =?utf-8?B?bFg0UUlZc0ZvVGNvR1Zlemc4bTdBaGhHZUZRaU52b2M4czZzV1duNmpwektN?=
 =?utf-8?B?K2dBV3ZLaERVcFpvbSt2elUyU3RYdCtsTnI5QmcxbE5XWXRnQUlGK1RNdGd1?=
 =?utf-8?B?MExSTTBOUjRZTEZBQnMvQjJrOEx3aDk5dDMyb01tSHFuOEFPcTcyVkNBQU1k?=
 =?utf-8?B?Kzlhb0pPWCtTbWZCZ3gzSkNhTDlEc2tHNjdMK3JCMndZMHNzYVIyZ2xFeEM2?=
 =?utf-8?B?OGxsMlFQS2dOM0pVTC9xTlZzeURvUGgzYjl5eW93NnFZYW1HODdBMmFYRjR1?=
 =?utf-8?B?L3VXSHdFeVpOQTJ6TDVoOUdTakt5bFhZY216NElaMHZHaDlYaytGZllVVHZN?=
 =?utf-8?B?WS93YkRzeFArREFmT2RwMDZza0Nuc3lWdjlZcFE0Y2RJWWxwam05Umo4WVky?=
 =?utf-8?B?OGNHOExDbFpYNWJkVzJiRnR5dXFZSHl5WisyR2k3c25CTjVQeVpoZ0JxUnNG?=
 =?utf-8?B?Z3MzMVFlZzVCa2tjRDRVRUxaOFNwYWFEN3BlU1dBQjBhOWFlWk9rUUNaMGov?=
 =?utf-8?B?Ni9Xb3A4ejZCYVJVVXlndmFuT2dOdEtGQXgvZ2VSc1JRRWxFTVgrd1ZtYUlT?=
 =?utf-8?B?NkdLOXlWbVh4SVloc1Z3OWVsR2JKUEdXUWpyOVlJSHIzQ0RhdE50VlBPNnVp?=
 =?utf-8?B?Snc0U01Qa1QrNE51MGR5R05nbTRhYVp2RnBTNCtOTXpLUkJkRG5UdVFWNk1Z?=
 =?utf-8?B?amlFVHBzSStFTUwwZUZuV3d6T1RvTDljWm14RWU2UXcreUJkYmdBSXlKb0pw?=
 =?utf-8?B?Z1NrU0NqQmcwT3h5UTh5KzJNQnFDNUNtVmQ5NnN5UFhidFZhMWZqMjJRRVEr?=
 =?utf-8?B?d0pFaDdTVE1wdXNZbUpTMy8rVFZYY041SDRzYmY0ZFNWWXZsTlNPNkFobDBR?=
 =?utf-8?B?WWpiVnNyZnBaUTVhajJna0ZMbk16Y1NhNTZTTnc5TjBjZ2lHVVFKSzgrc2ND?=
 =?utf-8?B?a2FHVUdYQmxCVDErUHFFMXBtRnZLUWRJUnVMTmdFQkhld3lqSkFOemY0YnV6?=
 =?utf-8?B?bGpyZElDU2w3MEpWQUxLL0MzZ3JpNTh1bHBTUk1RQkt3L25LNWNsSlMraTJy?=
 =?utf-8?B?UGpDWHJwdm9QWE5wOWJ2QmF5RHM2UUorTitpcE5NVnhqNEhHRWdpK2dwcjVn?=
 =?utf-8?B?ejA0aElRcGU4VEVSSW0zd0ZOUndyL3FzSFFHMjRsU3lXdEJZbUE0TU1GdnZJ?=
 =?utf-8?B?M3R2S3dwaE56eFE4eDhrZjJxOWM2a1ZzUnBLdk1nL3Z6SEJoZFhuZmJrRjVv?=
 =?utf-8?B?QVlDSW9NYmlBZUNTV1VkMks0K1I2anZDYzEvaGVqMXo0YTZaOFprL1lSWUtK?=
 =?utf-8?B?Uis3WGdFV1NiS2RIN1JUZ0xBMUR3VS9tajNqVXFrNE9RTlRnU1JlRmRZQVI3?=
 =?utf-8?B?VmF2OXZ0Y0RpeGFiTFNzZm1UQ3pRZGUrWkdkaVF0YUM2alhrSllhWDF2R0tJ?=
 =?utf-8?B?WkV5RWQ0enRtVDIrQWt0OWxWS2VldU1YRWdFa1hzaGdTaXB5ZGZFeS9RQy9R?=
 =?utf-8?B?QVJhY2FJdlRPTXBrK2JBakdOdjBEaWR3dnlxdnlPWFVzV29vbEJEV3FaR21C?=
 =?utf-8?B?bXNrRGwvNWJMV3IrMzhRcmFYU0RWRTFXb2pyZkpselhIVGFaUEVqZ3hYakta?=
 =?utf-8?B?T0dnSlRpbXVWWnE2V2djZlVDcUZXbk0zOEp2cVNNWFZTQmZDVVhlSGhtdDFJ?=
 =?utf-8?B?d0lpdlNUTERuQm1PU3RuSUdqNk5XZHhXNGNZQVV5T0NONFU2MDlHeUpvZFBi?=
 =?utf-8?Q?VqgRl8hejkl0s1TY=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a163e9-20c8-4763-6fb2-08df22e35945
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 13:19:56.1487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mgP8xleGAwfW/GFxF53N9kOwMt0kHyyRP27iFTCZci6nFUI+gWHLxIp19VglgB9Kkr+c8/J0ndAQ06SaH0piCXvgoBWLzS/tKvK2SyU+/wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10187

The chip's auto-RTS (MODE1.TRNSCVCTRL) asserts the RS485 transceiver
only while FIFO data is shifting out, and a break is not FIFO data: on
an RS485 port a requested break sets the TX break bit but the
transceiver is never enabled, so the break never reaches the wire.
Break-led protocols cannot work at all.

Disable auto-RTS for the break duration and drive RTS manually via the
LCR RTS bit, then restore auto-RTS when the break ends. Track the break
in tx_break and leave MODE1 alone in the rs485-config worker while it
is set - a TIOCSRS485 arriving mid-break would otherwise re-enable
auto-RTS on top of the manual RTS and release the transceiver before
the break ends; break_ctl() restores auto-RTS from the then-current
configuration when the break completes. The worker runs under
port->mutex - break_ctl() and set_termios() already do - so the
tx_break test and the MODE1 write cannot straddle a break starting or
ending, and startup() clears tx_break alongside the latched TXBREAK
bit, since a port can be closed with a break still asserted.

Only the break assertion is gated on RS485 being enabled; the restore
at break end runs unconditionally and derives MODE1 from the current
configuration. Returning early for a port whose RS485 was disabled
mid-break - that reconfigure is deferred like any other - would leak
the manually driven RTS and leave the transceiver holding the bus
indefinitely after the break ends. On a non-RS485 port the restore is
a no-op: nothing else writes the LCR RTS bit.

Fixes: 55367c620aed ("serial: max310x: Add support for RS-485 mode")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 49 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index fead9c51163d8372d1b609ee9cd5b87faa917fc1..319517bee63fdf5e67c311d2575083fd0d8a5870 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -298,6 +298,7 @@ struct max310x_one {
 	struct work_struct	md_work;
 	struct work_struct	rs_work;
 	struct regmap		*regmap;
+	bool			tx_break;	/* break_ctl() owns the transceiver */
 
 	u8 rx_buf[MAX310X_FIFO_SIZE];
 };
@@ -682,6 +683,12 @@ static void max310x_batch_read(struct uart_port *port, u8 *rxbuf, unsigned int l
 	regmap_noinc_read(one->regmap, MAX310X_RHR_REG, rxbuf, len);
 }
 
+static void max310x_rts_ctl(struct uart_port *port, bool rts_state)
+{
+	max310x_port_update(port, MAX310X_LCR_REG, MAX310X_LCR_RTS_BIT,
+			    rts_state ? MAX310X_LCR_RTS_BIT : 0);
+}
+
 static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
 {
 	struct max310x_one *one = to_max310x_port(port);
@@ -929,9 +936,32 @@ static void max310x_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 static void max310x_break_ctl(struct uart_port *port, int break_state)
 {
+	struct max310x_one *one = to_max310x_port(port);
+
+	one->tx_break = break_state;
+
 	max310x_port_update(port, MAX310X_LCR_REG,
 			    MAX310X_LCR_TXBREAK_BIT,
 			    break_state ? MAX310X_LCR_TXBREAK_BIT : 0);
+
+	/*
+	 * The chip's auto-RTS asserts the transceiver only while FIFO data is
+	 * shifting out, and a break is not FIFO data. Disable auto-RTS for the
+	 * break duration and drive RTS manually so the break reaches the wire;
+	 * restore auto-RTS when the break ends.
+	 */
+	if (break_state) {
+		if (!(port->rs485.flags & SER_RS485_ENABLED))
+			return;
+		max310x_port_update(port, MAX310X_MODE1_REG,
+				    MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
+	} else {
+		max310x_port_update(port, MAX310X_MODE1_REG,
+				    MAX310X_MODE1_TRNSCVCTRL_BIT,
+				    (port->rs485.flags & SER_RS485_ENABLED) ?
+				    MAX310X_MODE1_TRNSCVCTRL_BIT : 0);
+	}
+	max310x_rts_ctl(port, break_state);
 }
 
 static void max310x_set_termios(struct uart_port *port,
@@ -1055,6 +1085,13 @@ static void max310x_rs_proc(struct work_struct *ws)
 	struct max310x_one *one = container_of(ws, struct max310x_one, rs_work);
 	unsigned int delay, mode1 = 0, mode2 = 0;
 
+	/*
+	 * Serialize against break_ctl() and set_termios(), which run under
+	 * port->mutex: the tx_break test below and the MODE1 write must not
+	 * straddle a break starting or ending.
+	 */
+	guard(mutex)(&one->port.state->port.mutex);
+
 	delay = (one->port.rs485.delay_rts_before_send << 4) |
 		one->port.rs485.delay_rts_after_send;
 	max310x_port_write(&one->port, MAX310X_HDPIXDELAY_REG, delay);
@@ -1066,8 +1103,14 @@ static void max310x_rs_proc(struct work_struct *ws)
 			mode2 = MAX310X_MODE2_ECHOSUPR_BIT;
 	}
 
-	max310x_port_update(&one->port, MAX310X_MODE1_REG,
-			MAX310X_MODE1_TRNSCVCTRL_BIT, mode1);
+	/*
+	 * A break owns the transceiver: break_ctl() disabled auto-RTS and
+	 * drives RTS manually, and restores it when the break ends. Leave
+	 * MODE1 alone meanwhile or the break goes undriven mid-way.
+	 */
+	if (!one->tx_break)
+		max310x_port_update(&one->port, MAX310X_MODE1_REG,
+				    MAX310X_MODE1_TRNSCVCTRL_BIT, mode1);
 	max310x_port_update(&one->port, MAX310X_MODE2_REG,
 			MAX310X_MODE2_ECHOSUPR_BIT, mode2);
 }
@@ -1090,6 +1133,7 @@ static int max310x_rs485_config(struct uart_port *port, struct ktermios *termios
 
 static int max310x_startup(struct uart_port *port)
 {
+	struct max310x_one *one = to_max310x_port(port);
 	unsigned int val;
 
 	max310x_power(port, 1);
@@ -1099,6 +1143,7 @@ static int max310x_startup(struct uart_port *port)
 	 * closed with a break still asserted, and set_termios() no longer
 	 * rewrites it.
 	 */
+	one->tx_break = false;
 	max310x_port_update(port, MAX310X_LCR_REG, MAX310X_LCR_TXBREAK_BIT, 0);
 
 	/* Configure MODE1 register */

-- 
2.47.3

