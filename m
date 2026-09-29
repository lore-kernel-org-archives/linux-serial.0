Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023131.outbound.protection.outlook.com [40.107.162.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC433093B2;
	Tue, 29 Sep 2026 09:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674736; cv=fail; b=MqxIpmzgRczjJujopFQ4zBtIKDqWEG/tqs7d9j6NoeUmjsfvOVXC82PUQZcQ+/fKl0V5dnHCYiaNsph+oJ44uxFuvW7RIPRiQrGfDiJWiFohicKY06+TWnRg4qi7X48V93r7ZOoHajHFv2BOSFnpFmnrZOB5FK8ARRA7IsWE8jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674736; c=relaxed/simple;
	bh=dsDnY/03OfPHLK2WLwl2Cx3r7vdnlF73af8FKwyfTJk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VZrAM73YkhEHcUiEcDKITi1q82fjD4/7MmxjtrqrIiaMw93urjAA/oT1FEUVF8ezOF0aibniOTgN7RnU9oKXcY9crlgJU+bx5yeajHWGE8EJub8XztigzGgLpC/wcQpzorUqn9np8iSAZP4ylmzHj/XdEH7zQl53k/j5JhhQSLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=2tWj2cPD; arc=fail smtp.client-ip=40.107.162.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="2tWj2cPD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZ8MtZC7To0euFN6mUBjq+THZpRzTd7k4n5BiVYaCaLKQX6kACtSYWv1d3B4uhxknFr73KxFpCv5guO9/l/Ad+gWgfrji7BV/2uYq6USD62/AjYxSYZKM4zusmUiSYJqc/S4vJfG8iI7b2BtxBXP5qAvWfL2O6+muksOUF2VEA0qG+XYLuKxnVsLv7/PInMLFMzcSgaqDfhwP9Dr3xN2qxkKwizFgfITLWj0UFzZP4IBAz9c+wYdL/RLRq2mel3Wy5pOcs388D+31r0Xlym25j2UAPh65QUua8sWEg8uV1Lv/uIAEgmCgAQCBLkYkiKZbqCGIpICQP+8yapC9ZM7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2uWW6z7QjoFQ+NuKPaNxQQ7vy3ykI2vCePZkRHNI3U=;
 b=i73iAvnxjeiZPf5FLf+fB7jokJe6lQcJ1bDS13WMNyLHQd7ZD5gVyUetquOmDy6VdQOcT8VRwRmxAkR7wi9zh19HMRU64IhnDNy7RQDdHjErckEL5b0AJK9GpBSCl9iF9SVBX+vIuv1ohbGmXXtocvrFXFdqesUA18DYda14XJGTiOHHHLKPuUYtvXgiLHD+wLgJbgI+7BRzXo7wNcRivZPRmeCtFfRREVuqxU1lSDcOP6Rj6c1wHLuFjIfbL0yRNWRA3ntTNT0O4uJfeY6ZgEi4Vx8ntCRaDgRRR+Vt+D9F0Jx/7UXOmQn7p53isAg5jM2OAgHsm6zFBwF0jz5cCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2uWW6z7QjoFQ+NuKPaNxQQ7vy3ykI2vCePZkRHNI3U=;
 b=2tWj2cPDZJwaAAJyfdDlCpdNDyKWLnKKLG4AaRYBtHi52RgdKhyVOPf3nDpgL+ihbSknwfiadxZMOU1VAA7LG5EYpm0L6xKiKzpFn+mTDPl9rujkurqLVbKGS68nqW9UZCA5W5GDBWhnJFX845eSOWiuhOAk00/IN/EYqnICvK4+l/EseRuTUNDo7o4Ms2c5tKiepRDVF3rApLbIQrN/VcpDvSzcQ16Y+j7NveN6I7nB0CjhKQn/uuLaIq9Rb8ik98LQvoCepfxW4UwPPppk76CJ/LCaxqUEduh7cJSEQam7gZTMHnYHJCkzTSTQvDOJGC73Zj0C+iJz+o9N6Kpnwg==
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
Date: Tue, 29 Sep 2026 09:37:56 +0000
Subject: [PATCH v5 2/8] serial: max310x: assert the transceiver during a
 break
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-max310x-rs485-sw-delay-v5-2-ae46afa583f2@vaisala.com>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
In-Reply-To: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790674682; l=5180;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=dsDnY/03OfPHLK2WLwl2Cx3r7vdnlF73af8FKwyfTJk=;
 b=uilg8Yir3JfU2fk4IBMM0YlcTYF99WWQn6Ej2cfgcKkM+k5hR3lWVGLbs++/7KxbdVgSfcl5I
 eN66LMaEjQBDQPXqPFGzE6S5v0Ny7dQGrhB5Xcs+/nWndPUPq0DvhvG
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
X-MS-Office365-Filtering-Correlation-Id: 30de297d-b7ee-4215-f235-08df1e0d5d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|23010399003|376014|366016|1800799024|38350700014|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	SU6bd5Aezmsg6hNUz5WSt8qslARrTrDA0mCfrSii93I1ptAdr6VYf2rQJFVaRKHodoXj53xAe6Mj8yMribKLRfljVG6+kIjxLzLmpteXUxELQL60wEv4cw+PXGIt+CU5lfW/0YRrkNIctQSgaXJzkb17vJ7X1fcSj9wjFs5HdjUxrKCF4SZAax9ILjYiFpGvfy4rZHW2RBTMrIH7D08FCYlxl6hI044tRP3VFTpJ99qJw48UlNgvAu4RU50pZ5iCwzDWEJHQBpYZvQhvb7cUU8w/0GjZWJtNJY9ipxs5Dqn5pim2LmRv5RGB5Hu2X9qKCaJ2sCfpgVCKtutXybYTxgxdSmLufrSb82dyCtTZ+cSEcLPWTEaEB+/FirAQo58nvyV9QT9hww5xEBhdVIeg5EdIQOuCkIcWR+tb8dxpRwDp3SPAwdKwH1mQnEXeqFIMaKnGo7VFG/kb3am22GW9Mx93rBbP9KXewWf5jxcWjiaMxKjV2oKAyJI+xqOBehFXnmdfefE9IhnUyNcy2ZBuVZOJPPh60yOES7o8fPDwC+lolJfEKb0kyrw0Op/DS7y7fQGbBXVm36RZ//+hIGyQzISzJ/N2wLkG7JjudMHDf2z9TtpKbfKkzsjnqteFA9/Kl32PUFYErYXffnMh+pLViJYIm0OujsUoAERNuN50pMPaIUsjFUTukv12Xmzbsu2qLjKuv+0/z3dntd85147qjf9+a26uy/aPhhrEwl5+vqg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(376014)(366016)(1800799024)(38350700014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjQrNnE0RFdhcXhaVnlLWVI4SzNuU1BtVDA4UnAwemd5MzB2WmU1UDNsODBu?=
 =?utf-8?B?djhPckx4Y3QrMXAyNlp5TlQ3eW9DSnhaU1RtaTFqSVArbi9XdFlVT09YUTZI?=
 =?utf-8?B?Zld5L0NoSUl2MVlzcC96Wlk3Mk8vZWpKeUNIRTRuNGdUbjVDL3NYMnlZY05L?=
 =?utf-8?B?aWVRcEh3bnFsc0NDR2UveHRXREVOWjREdnluanV2d243VlN1dC81SHdCcENa?=
 =?utf-8?B?aDNJMGFHNmNnNi9CeS90TTdoY09lbENmVTN3UFF2aXFqMDAzbVBOV0srWENq?=
 =?utf-8?B?Q1Z0STd1a0NXdDV6eVM5eU54N0QrVERNZWlycjE3VlVnRllOUDVWd1FvRTNN?=
 =?utf-8?B?aEtST1F2RXdBeW9POEw1UGVMNVo5OWI4WDVMOXozTXdPQ2ZyWVE0RFhUL0pt?=
 =?utf-8?B?WWFtWGptcHBRZXIwUnk5aXltQ2RTQjFBblliNXFWZXVOMEVLTzVkVExmbUxS?=
 =?utf-8?B?akZmVm9XeXE1Yk9XaHlXTzlWeHQ3RFkxUEVULy9QQWswenpYOWRCc0ZNNi8x?=
 =?utf-8?B?OEdvY0RDMmpQeWdaSWpWTU03NmIzdlprQW5renFaODJEWGowNkNhUXhGMUIr?=
 =?utf-8?B?V2w4eS9GVURKVjVkTDN0VDYwdjQzMDRDNlZKRVdraWZmOU5JSFN6aXoyQTdG?=
 =?utf-8?B?dTV5bElOMitsU3JBa1RhbjdZTUwrdEF1eGNMMG4zYzJOS0lOaG1YZHRnY29l?=
 =?utf-8?B?TnhrbWhqU1lobmZtVFl0OWxUdFVwMWhPN2dPYjVUZmlJOFppYVk4cjl3T3RJ?=
 =?utf-8?B?QjVWTkdXUXFjcDFUWDNESU5JSTk2cHg1SDFkak5QcWhZMy96aFAvR0JXZ0di?=
 =?utf-8?B?RjRtM2dLV1M5amZ4V2ZJU0dRVEVLVm00emR6YTU1aXNIRzNaNnVNTjV0aTFT?=
 =?utf-8?B?ck5NSVN3MllySEVrdVZRMytqbmY0VzhjNGtBMzc3MWhUbVpGeTl0d0ZEYnFZ?=
 =?utf-8?B?VFRKOUxuTDNVYWJpZ2NXZ3pCaDVYSGtWWnZFVjBjNWVTL2RmaWFCNFRxMVM4?=
 =?utf-8?B?MWRBRGtzV0VJZzZnbDVwak9xRjVRVERWOWsyRjBUNWNvZEk5M2hXaFVHV3Ni?=
 =?utf-8?B?VU5JclpmWEE2QmRxQkkrMDZ1bEdiSmtYejVJMmJYQUJ3eCtlQnRqU3VyQ2pt?=
 =?utf-8?B?UzZSNlBtaDJ3TzZwU2JmajhxeFd1dXFpYVZKL1A1djR0Tkt6NjhqekZteVNs?=
 =?utf-8?B?NGx4K1VqUlRzL1dNR0hQWjh6ZG1MQ2JWVWFya0NoWlZBWDg4TlJvdC9admE0?=
 =?utf-8?B?c0dZRklpNTRXbnJiQ1l6UUZjM051SXp6MnF5Y1oyS1poSU5sb3FmVWplOW9j?=
 =?utf-8?B?Rk16VUd0SDdXQkZvODhENXo1UUZURDdOQmdidWR1YTJOZTJpblpmbXFRNU9h?=
 =?utf-8?B?STBnaGlkMjIvNW1jY0E2VzMzay8rTi8yblRra240bS9mWVhyVW9tMlVDWXlF?=
 =?utf-8?B?YWswMktZWjVyb3NXYXdXOTlQVHlmSC9uY3dhZjRtUU55SmpnWkY0aFpneXZS?=
 =?utf-8?B?MWJheXVLU093TG1uSVRvNlpOSHliUjA3NlFMR0pVaERTRDRGQkI3Z0ZFbEIx?=
 =?utf-8?B?THB3Z21yaUhkL25tTzE5TmFYWFNJMG9JelM2d2tnSHdxU3VuSCtsREhZTkxy?=
 =?utf-8?B?UHhDOE40L0hHS05lZzF2Yy82dHNzZHQvTzFNTFA0bkYwZ21VeStOeHhuZWpo?=
 =?utf-8?B?VDhCNWlDdUNPT2dKUzN0RjNSajR6WUhHL0hCOE8yNXA5RzRvVmhpeFIwSWxl?=
 =?utf-8?B?eHI2WDZvNmo2dFdZQTJ4aERyQVpONWpkYVFRbEJaRnNkajNiUXAvUGYwakhX?=
 =?utf-8?B?SDlYSG9xRkZhdXpzM253V3ZOcGRCd0VZNDJyeVZwK2YyaFJlUllSQUpBSlRZ?=
 =?utf-8?B?QnVMZG01R2xqWmtqbEJweU92QVhqQlJhN295a0xxRkt6TXVSVXVXeVUrdVph?=
 =?utf-8?B?S2crV3FRSUxBc2E2TFd6VGxZSk4xY25RczczMmhvRHpSU3JXaVYrN3RXSzRN?=
 =?utf-8?B?Vm55UCtMd1FwQVVZN2RkRHJnRkJvZW44T0RSZ2NtYXF4cTRReGsxZmdLNHZx?=
 =?utf-8?B?cEtjYmI3cjI3S3dydm5nVk1iMlhQZWFBMWxkdDdTVEZDY0VEMVpmbEkwenJH?=
 =?utf-8?B?SjdOSGhCZVplelpGQ2l6dm1IMkR1K0pRVFdRa1pPWWFPSU5OVmVFNHMzN0Jy?=
 =?utf-8?B?eGlpem5SSVFTQ3NtSC9IZFZNVlZnREZsUkJJWnZLaCtHbDdZc1JLRW5VdGFm?=
 =?utf-8?B?YVV5dGpaelBQMVpwMThoTzBJek1zSmZwSS9qZUFvL1BWS3VkUG1TdlVLMWZ3?=
 =?utf-8?B?bUIvQWtaYlZ6cUU2Ylpzc0dvZFZveG1NZ1lpYlAweGdQS2ErOWhVQ3l2Q2ZG?=
 =?utf-8?Q?qIfk57lR/pAxC3tw=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30de297d-b7ee-4215-f235-08df1e0d5d01
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 09:38:05.5079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yq2Qg85w03d7v85eLcdaaeD5SVYQQcHx2s7Z8t9l9jM5kIE2iTjarJT7bjideivhwvHaaphjMEo9pFPmWj+sv7aZimtk/3JU/+kUSlarc4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR06MB9752

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

Fixes: 55367c620aed ("serial: max310x: Add support for RS-485 mode")
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 4c1e10e0765f45a51e0c74ca965588f39872efd5..693decd04de104051b07357973364bd587ab3d91 100644
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
@@ -929,9 +936,27 @@ static void max310x_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
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
+	if (!(port->rs485.flags & SER_RS485_ENABLED))
+		return;
+
+	/*
+	 * The chip's auto-RTS asserts the transceiver only while FIFO data is
+	 * shifting out, and a break is not FIFO data. Disable auto-RTS for the
+	 * break duration and drive RTS manually so the break reaches the wire;
+	 * restore auto-RTS when the break ends.
+	 */
+	max310x_port_update(port, MAX310X_MODE1_REG,
+			    MAX310X_MODE1_TRNSCVCTRL_BIT,
+			    break_state ? 0 : MAX310X_MODE1_TRNSCVCTRL_BIT);
+	max310x_rts_ctl(port, break_state);
 }
 
 static void max310x_set_termios(struct uart_port *port,
@@ -1055,6 +1080,13 @@ static void max310x_rs_proc(struct work_struct *ws)
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
@@ -1066,8 +1098,14 @@ static void max310x_rs_proc(struct work_struct *ws)
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
@@ -1090,6 +1128,7 @@ static int max310x_rs485_config(struct uart_port *port, struct ktermios *termios
 
 static int max310x_startup(struct uart_port *port)
 {
+	struct max310x_one *one = to_max310x_port(port);
 	unsigned int val;
 
 	max310x_power(port, 1);
@@ -1099,6 +1138,7 @@ static int max310x_startup(struct uart_port *port)
 	 * closed with a break still asserted, and set_termios() no longer
 	 * rewrites it.
 	 */
+	one->tx_break = false;
 	max310x_port_update(port, MAX310X_LCR_REG, MAX310X_LCR_TXBREAK_BIT, 0);
 
 	/* Configure MODE1 register */

-- 
2.47.3

