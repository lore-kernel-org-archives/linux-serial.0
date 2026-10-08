Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022084.outbound.protection.outlook.com [52.101.66.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDC448B38F;
	Thu,  8 Oct 2026 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452957; cv=fail; b=mTJTkH8EVWzBfsLm9HcwzcV0+xfl6wfaHESD2FF2bmjlj4kZ9F6kEnBlVrA0K9Y4WeEayBJCL13U9YmzQjL1EzrqV53FVoBBVSpz/yPKBTF+x5gKoLhIFf7DCBUrWK33xyIyteNYnZJrwNjGq1TWUu1+JnQy6dv3kJktZDLy00s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452957; c=relaxed/simple;
	bh=b8ZBOXq3yhMDK0JCVU2YkVgHUUB7DPkJGpOBnTyJgbw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gCCTUec5UeVi1UmAXe2AyB+iXqPfXsurt4FPFNFO93ums6jB5oV8sgevqDiCU9RFdDZVL1piHooPB4aCHVEZC/rtO6Zp3nXzmBRPKAhKK88/lyh9urddWJc9JyeCUqkF1TIWJhOQoPebGRLx/9o4fsA+yevDvbM7imfAOjGN/aA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=fXrlVQxS; arc=fail smtp.client-ip=52.101.66.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="fXrlVQxS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t04/eksMN9qWgZuDraUEXKOaGb5ToNBbkShCk/mHVDrA2LW+KOAqWVzXpMxNmBhdiiMO5MNZvT+l1UKoN2hbyVlRGQldzM8vlgTn4MST8fogATX1f7x11XP33F8dwA9tHKQkFbsqk3klhl9wy6wcOL/uI1X02dWrIRn1F7o9GQfzNfaf16LOngGmwnCzRLoIqEAITjgckvZqx3rEA7PPZVDOmUxwyrx+41pY0W1yOwfQ54okP4SmvfG17Ckj1CLzMQupvOXScMaz70pl4z3BVSoM3SRFzsomaElnRoiND4bkm1rCDTqwywH/665+Xa8XYGc5yQMR1kSHTHx6Z28R4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KksCVbuWemW5AU9eCmpHZpnpxtieCYxtpLQpjWqnffc=;
 b=JN2u7pnsVJRmEucPX8aCht75eJ1+EIAHbYxqLsvy+HEvs0QQsDeCrwt/uvy6TU4QDup/6GKvyPH0Q30d1sA8VU07yN1Z2VMdh7Eq4YDSqok+o0t1qYkral/9srjJszQhiO+UVRJg1fEMLLyvQEpGxXH9l7FiMNjn5zkymMCS/1ZIKN48JTaU8ffBR6DhYkbWWpCktET/Htt+/bWp4qjsfCxhXcdlOdnGlXTUFpzTK9EUmX70KR1hZeclbrpHUlbhLF8maJn9UAZJhEW446ox7sVaah1tzCZRcs4nJsyqCKcj1bUVVlMKsrtbdwQJvnz0mTLP6FgfbhOuZyp2RZV6gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KksCVbuWemW5AU9eCmpHZpnpxtieCYxtpLQpjWqnffc=;
 b=fXrlVQxSOnqm4T4WE++wQBEnLbYbbDU/okE2MlO6ME6PxlbiN67wF1/1oqDe2DuilIQISLcOl/kpS6lNSamd5XbbuLvBt6e4WNvGtNhLbjbp7xGE78q3LBT55jjoIk1A96X4Fqo3yO1+OC+UxxdkVtE7/XudyjrJyEi5JFJdxE7x5EMvxZh0wd89ykgs1+5dgw3Ns254PhLjj7nmKQAmS83rirQEkuZkd2LaMywfioUZlTEGnbgruCAfk3FRZSDIyKt1gIOadWcRHZ0cT9q5p6VNm3oGYCpDXiFTif0PKCBWVUVYxdbVsG7GOvmMppzabGMx4PI0tvCc6DWm3bPPQg==
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
Date: Thu, 08 Oct 2026 09:48:25 +0000
Subject: [PATCH v8 2/9] serial: max310x: fix breaks not reaching the wire
 in RS485 mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-max310x-rs485-sw-delay-v8-2-6ba881f81e1f@vaisala.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791452935; l=5854;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=b8ZBOXq3yhMDK0JCVU2YkVgHUUB7DPkJGpOBnTyJgbw=;
 b=Ts8Q94ySfzThuEjun8rIqSvYZlKtj9lNZH/gxeg7ws+oANDrbfWo1Krea0TRc/83X4YaOW4ga
 3znlJwz378/BbtweQoV/MqWlfEo7V4nGsCDKsqx5h/1TUcnokpWM50/
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
X-MS-Office365-Filtering-Correlation-Id: 53424c59-7326-43c5-ce2b-08df25215f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|10067099003|3023799007|11063799006|5023799004|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	UCb2GAmbI3cZDSxkIWIXZq/n/BGJQEl4SL5XzqeSZJCu96eWkNjyEpjyYHX5zILJhCzQH6n05HatYdj0GPuq6vGFO7nCXByHf4hyYMp1AFlOV22azYRT0IsFjBvrsroSkGoqb4evYnN3Bu79fFQ3MNjkncY7Lfm3L3JQlIk9iL/LE/+gLdFGWwXII+O2PI8NB+Mi5ORpgmzFv+/U+0gp5TdGZcwHXrbUYMboiStpJ43bXxBZ1cZzVSDwsB0sVcM9XtGRlDO9X8nrD6Ax14j5o8PtixMPJNZUzDQP/4WG8qkUq7O9MRThtyjhtdnxJBoxh6ltBXXKB4J6kOBPAFa+A5JcDgBYdkdsX5VdB3CTwKq+J5KP6B+wWXeJbutyJBqsbYSom/RFV98uxKdiCxFHungtR8eZKUeKhlyeV+EBLk20nK8T8uYQj39i8lzcDBLWqN37W1UOsC8ZWyShZkcljT11PoY207P40icN3wEX8X/mpM5kUI35+FHMfWgvBJE/UHMOv3EAA8eLPJ9XEXPf3G2JCHqepJPHQSwXc1YxmIztuBfMknX7wHJQ7iiu1vlkGCgVSRHGSSddovMpICiK8AhlYOFebxGXRCupgx+X4Z8eLCWxGAmVn43IqwLeECazVQx4BhxfBYgFp2waTMGrXp+gePMkEMTPdRYWpOCuVPbSDsSwxqjjUtI7AcJ6b+84lYSd9EPFIkAipQB1quiqoQWfn/W/MTLVG63/SSKvAtw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(5023799004)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUhhL0gwN012bERnR0duMTd6WDZKVndNTWtxSDNlWU0vd014TlV4RmxjamZU?=
 =?utf-8?B?NzY4RlM5ekpTZWxBQzllWHVTeDBuNm5UbC85QUREVGU4NWpESkVLYUE0cEpo?=
 =?utf-8?B?TFdUTFZnTVJsWXZoc2pyRkJsTnY4VjBrRlMyeUcySmo2Wk52WFBNZEFNQktT?=
 =?utf-8?B?bHl3dDRwVDdMbTZlaFNvWDNNYkFZd2xNMDlXYnVBRHlVWlFJQjRsaDNRL3pK?=
 =?utf-8?B?bHNGdUdyNytwSmtISmYwM1JBVktRR2JRMHpNWVBtVElidUV0VnpmWUxFeDcy?=
 =?utf-8?B?TGZmeVNicmFIbEplN0dFb25wU2Q0emlZTmd4dGdzeGV3bWJoZTgvTUdWRWgx?=
 =?utf-8?B?Y2NpVlR2bkdxbmlyQnc4MllkOGx4SG90b1JGdFdQVERFV2xWODdGL0w0aFlr?=
 =?utf-8?B?dW0yUCtDejBmVmc4Q3Eyb29oRnZNK0QvcS81VTFHRU1Sb0tKM0czL3JKbGtS?=
 =?utf-8?B?YWpRVFZmcDRySmxDNlhycDJBTDcvSWVaRTlPYTJqejJkRHhEODdBbzFJb0k3?=
 =?utf-8?B?Wis5aGtDMGJreWFURjI3UlhxOTMxNnpNVTQ1SUhkL0F3WTNRazhrR3BjeTE3?=
 =?utf-8?B?YlV3VVVuQW5pamdqVTgrZnFneEVkdHpROVhCaDJ5alhFaGJSRTNoVEpKOGVM?=
 =?utf-8?B?MkxTYllrRHJFNGRIYzdaZUsxNWZ5ZFN3MGZONGNlS2kybXplZnZ3b2VNSXlU?=
 =?utf-8?B?Qnk3YnRqMFpiZ3cva3FmbnZITGJ6U2I0NDlVNThPOFF0SDE0Zi9EWjEvRVRk?=
 =?utf-8?B?cmRwK0xjQzcrTnpZZFcxWjNMZXZzUkNWM2hYYXoyRTBiNW41NHE4YnMySmth?=
 =?utf-8?B?SXBtcDVRN2FzS1ZmWVBpTkk4SW1HUlp2N0FCQ2dieFIvOC9HdUpOVGZpUEQw?=
 =?utf-8?B?M3M3WDZmU3p3R29CRm5rcGhTTHdQdXpacWxod2JMaEVGVFY5NlVrNS8yS05Z?=
 =?utf-8?B?UjUwb1BBVXE2ci9FdTJmVWg1NkZiZTcrRnFWNGpwQ2xtOVE2S0ZuQTlUUWl3?=
 =?utf-8?B?eGdSR1MyOUhRSkh3c2VkSTUxTWEwRFlwa2JZdEdLUzd4YXp0OUZ5Zk8yOTJL?=
 =?utf-8?B?UUZxSHBXYzFaTWJ0c2RLc2pIY1JnSFZzTkUwTVdFTUt6NktDNFkzVTVDNXVE?=
 =?utf-8?B?VW1wMGoxVGlUOHpLR2VPSXlsSVEya2lNbTAwZ1Z1NnQ3S0w3bDNOOS9iQjZW?=
 =?utf-8?B?L1NYc1pzK1hiaGRYVkx0OWl1SkJDdzVhS09kOXJVZHRGYVdvbzNXMmU4TXVV?=
 =?utf-8?B?UkIwTHBWaFRwREFxYXpjc0lmUitBRDF3b0J5TzJWOVJFQUhleUp6cEFHdG45?=
 =?utf-8?B?NlRqOEc2ZnhlK0pTaWVvKzFmOWdPMFRQd0Z6bWszOXRDRDdZQytTVEN2SmJn?=
 =?utf-8?B?dld0UDNRUEk2cVQyODF6bXYrU1psTStPVWNLWmQ5M3ViNVhiRmNCOWFJWnJF?=
 =?utf-8?B?R0ovTG9EUHVPNE9kbVFNV2xBbHVDVDFRSlhmOHdHQlNaNjFyM1RMdWpwd25J?=
 =?utf-8?B?aHVjdzhuYnlDN01JbWtxek1kM1l2RUYrWW1ja0ZhbFVWRVNpN0F1VHBOaksz?=
 =?utf-8?B?RjBnUTg3ZUNpMkpIZkhyQlhEMXNBYlFBS0I5Q3hla01lMW5NUE9uSzFtMG1G?=
 =?utf-8?B?L0lOTTdGTnh2VVlnMmZteVQ2QW5pUHVkOGF0bmsxOCt1cTliMHF4WnlYM241?=
 =?utf-8?B?aTVFVEhCeVFvVDlBclJpeERXN3RxUW5mNlgwcG54d2ZCMEptVHhCekVVbGFI?=
 =?utf-8?B?Mm1nelRDZ1RJeU0vVUJLVDQ3S055UDB4TVF4QTdDYTVVWkovRFFTaFVjR092?=
 =?utf-8?B?YUtsTXlLVU4wWE9SMml0Z3dlUENHNStFOWZCZkZyTVlJb0I3RWNoWUlqSkNL?=
 =?utf-8?B?WHg1OHZVNTR2S3FyK09kTGRnRElzMFV2bWl0ejlQU0MyUkRqQTI0OENrTlFy?=
 =?utf-8?B?YWNha3VqSXdrTEZIVllENDNid2RzTmpBYm5Td2VHTmkydGhDTGlFMDJoTWtX?=
 =?utf-8?B?b3h3blkxUnp5RDdZSEx1M3lJQkNQWGdXWlRqc3ZOc2l3anN6SXpzSkloZU91?=
 =?utf-8?B?d0N1Q3E4VUN3SXVTaUxNWHhxL1FpUDI4WVQxbU12eFcvK3lSK2VCRW91anUz?=
 =?utf-8?B?NWlaRHRJQXdsZXhURjh4MmE3QkVjcVRQNTE2S1JYdU9HRFZoUG9aUDFpbk8w?=
 =?utf-8?B?S3BXTnJYV2UzKzlyRGthMFdiNW5zWGZ3akRRREtRbjM3bEZoNVZqRjRROXNl?=
 =?utf-8?B?STNqZWQyWGllSEV4RXMvWlRhejNabkFldEpPU05YU3BUNERoTHJseUlISVZW?=
 =?utf-8?B?S3VkQlhTN1hxZ00vd1hwU09PbWhMUDFjcW01SGltNmxISnVBamt3NEVUb21T?=
 =?utf-8?Q?qYoU7jGauniupa+s=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53424c59-7326-43c5-ce2b-08df25215f26
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:48:57.2814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vHw/RQjfUtMr7rETGaboWOQ34iPJikMWuyoy9cigNGfPKPJpeIOrnPBmp5yL+bGSJIfIYIhZUxsDaySy0/wtTIQl7Qa84nusR0RhGKeEaRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7567

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

