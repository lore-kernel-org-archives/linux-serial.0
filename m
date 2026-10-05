Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022080.outbound.protection.outlook.com [52.101.66.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3F348BD35;
	Mon,  5 Oct 2026 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206458; cv=fail; b=V1+2EqTn30tKqU74UfYpCC60tIik0AtKVrQKbuWoaHYm3B8ZIOQNbjUzhgfmiTZHfQ2bp6doyafFmx0jbNzAQJpk816Q/vAhBXrSlyd+tbhhIMR63IG22Z78l/ZocDs4iHx1MhuTnPkPj3OBSJ/MDJHf/0EyQ299LFlzNR+U0d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206458; c=relaxed/simple;
	bh=aZWZDA5l5iS4Z4t6awPKyg446Lc3xUlFsYl3vCsu5oc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=b3ZQMhCYmKRsWVnv3by9A4vaFJM8XrcxubFFgXiduF39yiVSKKZDzjaz9R372GPxTNOJEwAhyCBobKEJNjLqT+u+1hv6TviKMRVn2Q7Qono9VD20VvFuK5jW0Q3405mxgXtyamRLeNcBR1Xh44a4bXYeGITDeNgL6S48YfEk9XA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=MmoODXpW; arc=fail smtp.client-ip=52.101.66.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="MmoODXpW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2WY4iVUBRWdtPlGvRF0GAuOB/IoLo2PWZ2eO819h1FbTbriU0Ajd69GPZNSFPqVYglQNvz80cgRjZubKkgecQjbFU6fQYsWzl9KLHHsw0KD8exV9TiZqy8j/bsXlvZ6g3a2YCzL/Ab8hnkvHTZ61dUPBU3ss/xKrLpuWmYySLBc+4CHfT/twAqtWd7dLrCY6UdyIZJ1yH9wDbn8gXh127bVR1Z/hyP3+wYCDkY7GqyCm6T20/SWLf1F1pxHCzajnIUl0VL9y+QyrOGQd1LMs3ZKVve3wo4N+LabQLI8nFBrik7A3koSV46D/4MKc2XqSIH1G8JkNoROW1MdZE8WOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiR72CmxAmXC49Ne2P4Va+gXkK9t7gFgHcPE1eR+qwM=;
 b=gK0ILtaDK2HKohxN1sUjkIwLn1Pc2P4ZtaY6g48nm8PVcmeMbu8vgcgDNQhnzI3XfziykF24mtUWWLnRtNk6VH+XwkLOGE+rkoCL7RijWY56OHOPjVjGvX4CUOPSEN/bajJADQJvlfMGnusVA3I7HJ+WFFe76RamXwViiDTbusbCO3+xz5nO8jksvwRjFkPbIXKA+RtIsLUY1iPQ5DxCovBlIaIAllf+Dw4YEir8SYbid7jBHYxnoxFGe/esW0+smIht8immevgoYhr4kTMLHYSzHzJYXPcmenRUUAlJOirD0usC+Ku1S4rFsSvW1IVUsyHdMt2D+y+B+8kVfq47YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiR72CmxAmXC49Ne2P4Va+gXkK9t7gFgHcPE1eR+qwM=;
 b=MmoODXpWgnfsn3tX0QuM9NwVPROF+Wy42AJHfZmfoNJiPEV4ThF0vsTK146awb5oA4kg56wOfa8i6Mto6JAyp+cg8/FdoQSIhyZsJi1sZzHMTJOf/44F0uThglJid+zwR1vDqHE8P8QMvDMfbKFXM+x4/x7L//Sf3oSDU2CkkxWHrtcBjeFyr2eEoblCGGt0b9a2txMo5HKIUgbQfLVQWEXbRuJsYybBshhsb9Ss/8s9FWlJavriaT/sGrIIIzJbd5psjYPNSP/Qumkye5Qe/XBtqJGZuZrtxgKxvtR4UA3z+3yBgx6a2QRUklGuOcszYm8ynyUEiopOcDRfKLQzrw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by DU4PR06MB10187.eurprd06.prod.outlook.com (2603:10a6:10:622::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 13:19:59 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 13:19:59 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Mon, 05 Oct 2026 13:19:36 +0000
Subject: [PATCH v7 5/9] serial: max310x: stop the transmitter before
 powering down in shutdown
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-max310x-rs485-sw-delay-v7-5-6ae392eca08c@vaisala.com>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
In-Reply-To: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791206394; l=5004;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=aZWZDA5l5iS4Z4t6awPKyg446Lc3xUlFsYl3vCsu5oc=;
 b=BfkbDAOGMC0FnT0j7S+DIdzb3GrHaihMfunMlxq2f6HL749I/DCbU2SignHmeYualZf0hewPu
 rgJ+txd23OLBQJ0jT4iRW3dLu0p6J2xzATXOGVKlDqLvREcXO0KBsQu
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
X-MS-Office365-Filtering-Correlation-Id: 56f383b0-e01c-415e-b4e6-08df22e35a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|52116014|22082099003|18002099003|38350700014|6133799003|10067099003|3023799007|260925022911599003|260925021311599003|260925021911599003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	kfxf8dK/lrSHg9rXTtucmvkmdhlZplMLg3OK2y6NUDktHZKRw3ujDwO1CyXaiAH4yQ6JMbeyt/jx6IZ5NRtd1yyRwTtUdKLD30mUbDx9lEINfTYSEzUNJ+1LC1qPa/7IsaUOtDiC7+tRi2EnmE8DSu7RzDjkeZaT3SgTif14nez9v2IBFGFtaviDcfGsN1bbUqdkpN69Yz3P9T6/GfLZLNYoc6Ti9bnGAgQ2rZD+U2crpZuGL2zOcuRh1y3zvutn+aOD7oIqqf1Y2DDour7PG+GIB/XGiAjZUHaNu6e+V68L806delXjJAediK5Q0PU9ohQVV/YxqBmcS1lJWMQkFhSBDiVje50b3iOsz8PxdzlJA3llSy1CTGAI7wfR+pnfAb3uV/Nbcgi45qld0SeYEo2Y/jhEg68mB8wadY1vDCUEn3kg3eaSIZwdbEx7y4zD3IuUK/Cr/DPCGGz3LCeu5Y4IpZP5mtvZT8SFyBZKSMfyhEk0QRcSbx5If8C4Vhd+BwZUqVEGHZFEn9GKveqbnHR62I5e52I00eE0SCwAt3lFytqWrKQvRWuA7L9etogG61YdzXVosQapP+vfkk6dnC6snmpfIR9LnhzUuLcNWSf7yEGyOQiOMGArfpWiYpSiXeEu15KXqIlsxvDOjWmfykZjHWddBPVjI2mEjOoSUJVml0H22KiCp+WnsAorkEWgz4fzLS7WYZazGeIYEMaN3yvNs8PSgYpuOWPSw9onDiY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(52116014)(22082099003)(18002099003)(38350700014)(6133799003)(10067099003)(3023799007)(260925022911599003)(260925021311599003)(260925021911599003)(56012099006)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajBabzlsSG5ncHNiWmVVcC8yRDFob0d4cHJNRnR3OUhBa216R2Z2UEd5a2lt?=
 =?utf-8?B?dnJ3WEFRNmdOQ05jNU9JK2FzemVnaGtmWjA5cXVjeThMWXZPUzI5d3FsUE1q?=
 =?utf-8?B?cE9mYVVlVXV0M2JIRldoV2N5aEJnVm8rYkc2Q0FGV2RCdVZBYzBUMVZJVnFx?=
 =?utf-8?B?M3lYbVB0b20vT3dXNERoOTZ3eWpPdmQvUTVLdDhKOWF4NXU0U2RiTUkrV1di?=
 =?utf-8?B?dERsOUNOcE5YdVJNRVBZdjVkdHpGd3lNdUJmN0d3R00xamc4ODcyaTRJZnF3?=
 =?utf-8?B?bFF3NXlYMFNwUS9WZisvUlE4WHNtZnRoYURPU28xSWtkRGQxcDBHTENNY0ty?=
 =?utf-8?B?aFVMVGFMSGJWNm1sdkVCTkhWTGVGeHFyNFZJRzBSajVUSk9nZnVYZGNoUkdq?=
 =?utf-8?B?Q0N2MnVlRVl6aE1JamNxWllMSUg3dzJmMng3eGRST0ZRRjI5WmNFd3orNlFR?=
 =?utf-8?B?cVZRTVJCSEQ4dURBMW81Y0V1cU5TYmJnUzVkVWZZM1lDOVExZ1NDN0c3WGxU?=
 =?utf-8?B?aUYyRytRNVBVUnUzK2RiVWxBcHRQVE43aUZqL2VMbGVkV3krT0xSOWcrZ082?=
 =?utf-8?B?YVVTTXQzd1Zra21HeVp0UDZDajVhMnV2QjNKSE1obHZDais2RjJSeGJxTWc0?=
 =?utf-8?B?M2JPeldQRHBXVVFnQi9VdGNEUHk1bUxzcHM0bGZLaVRyQjRmWVV5dE96cHRD?=
 =?utf-8?B?eW5GYlhWeTFxVkFUU0hwU3ltdHhDLzRFMlVvUjhlMVc0M1pEOVVUYVJ5ZUhT?=
 =?utf-8?B?VW12S01rWCszNWFSK0JSMmZKZ01xbEt6NTNZcUNmVk5HTGI5eVZ4WG9MWjdD?=
 =?utf-8?B?WXRDQUVlK2l4dUd5QW1KaXVEKy91bXUwcFpQNXVVMzY3VlJ5REdJcVFTZmRS?=
 =?utf-8?B?WVBGY29PY01LMjVvSEpTUkdic2xFcFBJWDV4ZllwT0NueGdoanFmelYwbmZ6?=
 =?utf-8?B?YzlxUGJ4T2dFKzBlWVpidkxrZWhpdm5VVDFYYUdodGNKS0xVd0k4NjFzcE1Q?=
 =?utf-8?B?d2lFejEyVjVUUGdHeDZtY2dtMTd2dVdZTThNU0NDUnFRZXMzZFVDTTdPWXpN?=
 =?utf-8?B?MWZuUlpvWDJlRzFNSkRkaFpuZjFnMU5DT0dBWC9VWnNtWGQwcW9Mc3dNMWh3?=
 =?utf-8?B?aGVISEFrNHZPY3BJdFNRYms1ZXI5YVhiRFcxKzBiUDE4TGhSN2t0MkhYWjNz?=
 =?utf-8?B?WElDNDVnTnprbE05dmtiZks2Q25OVDJEcDZRaXp6QjQ0endweWE2SHFDY2Jj?=
 =?utf-8?B?RDBaem82WUJQcjBZN0tzQVJZM2Mrcmd1cTMrWmhFTXZ4MHdYT01XRmdEZUlt?=
 =?utf-8?B?aTlhd0JuWlZ0a0tVWXo4VW5ScGkvME5WSWdDdHJzdUJhTWFFU3BIRE05Q2Mw?=
 =?utf-8?B?c3NBS3I3WWdWNkpweVJDUVlFR0ZrdG92WCt6MmEwTHZ1ODZXbUYrTURaVU9X?=
 =?utf-8?B?VERrMnE2Qk5JZTRsNDg3amxxWDB6TlVTUlMxYXdCenl5dEVUL091bVZyNHhz?=
 =?utf-8?B?TW9Fa1lRQXBXRG5jVXd2MGhUa05zRnRlZ09JcXhPaFFPZ0hZaHFKZFYvNEtB?=
 =?utf-8?B?WkVZSTFwQzF6RkZRYUNhTkd5dDNGNVQ1aXBzWnhoL0VTdTFDQ2dzaEFxY1p0?=
 =?utf-8?B?UlBYOEg1N1NSaE56cnlrTlYxS05qOUdLellweWRGTGFBMjNYdkhrMTk4WlBy?=
 =?utf-8?B?dk9YcUtCd3c4UWNuanZaK3hOTHVJY1FWak1pTFZ4VWVPMEdkTkNGL1gxVEVE?=
 =?utf-8?B?ZlVwaDdiOHFxMTFsRHpIUXdIOGpxbldLY2lSLzJuL3QvMkZ2dXE4WXNESVcy?=
 =?utf-8?B?TnE0WnQ4dC8rZFN3T1orcS9BTGhyTFAzRTBpM1pxUTdyVDRiVk5yVGFsTTBL?=
 =?utf-8?B?ZTIzYXpJVVVkRnMyc2oxTHdDOUI2SER3aHEwZC9hTkR4N2JnbkJFRFZoSThB?=
 =?utf-8?B?a2hhcFdqN0d3RlNOWXpRNndTTzd2eHlQZHkrd2FXWVNOZ3d6YmgzWjRBdEQ4?=
 =?utf-8?B?YkNzUFZ3bHl6MXNPL3RUTm93UG9HQXMweFBUOXMxTnRuK0RSU1RuWThtMDMy?=
 =?utf-8?B?cm90WENlb3NPSVRzUHk5L0htSTFkZi9UaHNBL1Z5WnZidzdLZ1ZRbWMzdjVO?=
 =?utf-8?B?SStYSzk2RTVadXhheWtmM0Q1cGZ1ZGN4QjdmNURoUm5hZkQ2RjBoNGdIY0RK?=
 =?utf-8?B?NzRIdVZMKzBHSmgwY1NvMk9UQkVVUlQxZmdQZE9Qa29lVE9CU0hzR1dnbTlh?=
 =?utf-8?B?bThsYVhWZnUwSEFwWE1WQWdGN3NZMVJVejBBdHpjSkp6SXJpeGVXVmhTWEh1?=
 =?utf-8?B?S05nSzZxRnlLazR0ak14Nmw0VGVoTkdCY1UzVkRrd01GQ1JBQWFHdVprNFMw?=
 =?utf-8?Q?c39WOB5Zoi/GkCg8=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f383b0-e01c-415e-b4e6-08df22e35a4c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 13:19:57.9392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PCXbNcGWN7VsI6m7Bn33FwuewvysrJywfKsuG0vY5T76clm0c3pQmIZzT0mtrSZymHUOpiRaFYkQP8wfNR7ypFnwymHbrLkVH1a/e/NIvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10187

max310x_shutdown() powers the port down regardless of what the
transmitter is doing. The power-off stops the UART clock mid-character,
truncating the final frame, and on the auto-RTS path it freezes the
RTS output at its current level: a close() with data still queued
leaves the RS485 transceiver asserted until the next open, which also
emits the interrupted character corrupted.

Waiting for the data to drain is no better: the tty layer's
wait-until-sent is bounded by closing_wait, configurable to none, and
a hangup arrives with no wait at all, so draining a full FIFO blocks
close() in uninterruptible sleep for seconds at low baud rates - and
forever when CTS flow control blocks the FIFO.

Instead, set MODE1 TxDisabl: the character in flight completes and the
transmitter ceases with TX_ at idle. Give that character one character
time (the chip has no transmitter-idle status), then reset the FIFOs
so the auto-RTS engine sees the transmitter empty and releases RTS
within the configured after-send hold; wait that hold plus one bit
time before powering off. Abandoned data was explicitly not waited
for, and startup() resets the FIFOs and TxDisabl on open anyway.

Measured on a MAX14830: a truncating close() at 50 baud takes 0.23 s,
RTS releases one character plus the hold after the last stop bit on
both polarities, and the reopen corruption is gone.

Fixes: f65444187a66 ("serial: New serial driver MAX310X")
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 2456a2af891f5296cfec833d6406916073d2865f..e08e506360d72a3ef4c0ebdca2e60d864973f909 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -302,6 +302,7 @@ struct max310x_one {
 	struct work_struct	md_work;
 	struct work_struct	rs_work;
 	struct regmap		*regmap;
+	unsigned int		char_time_us;
 	unsigned int		baud;
 	bool			tx_break;	/* break_ctl() owns the transceiver */
 
@@ -1012,6 +1013,7 @@ static void max310x_set_termios(struct uart_port *port,
 				struct ktermios *termios,
 				const struct ktermios *old)
 {
+	unsigned int frame_bits = tty_get_frame_size(termios->c_cflag);
 	unsigned int lcr = 0, flow = 0;
 	int baud;
 
@@ -1124,10 +1126,13 @@ static void max310x_set_termios(struct uart_port *port,
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	/*
-	 * Cache the new baud rate and reprogram the RS485 RTS delays, whose
-	 * millisecond-to-bit-time conversion depends on it.
+	 * Cache the new baud rate and the time it takes to clock out one
+	 * character before reprogramming the RS485 RTS delays: the
+	 * millisecond-to-bit-time conversion divides by the baud rate.
 	 */
 	to_max310x_port(port)->baud = baud;
+	to_max310x_port(port)->char_time_us =
+		DIV_ROUND_UP(USEC_PER_SEC * frame_bits, baud);
 	max310x_set_rts_ctl_params(to_max310x_port(port));
 }
 
@@ -1184,9 +1189,10 @@ static int max310x_startup(struct uart_port *port)
 	one->tx_break = false;
 	max310x_port_update(port, MAX310X_LCR_REG, MAX310X_LCR_TXBREAK_BIT, 0);
 
-	/* Configure MODE1 register */
+	/* Configure MODE1: re-enable the transmitter shutdown() stopped */
 	max310x_port_update(port, MAX310X_MODE1_REG,
-			    MAX310X_MODE1_TRNSCVCTRL_BIT, 0);
+			    MAX310X_MODE1_TRNSCVCTRL_BIT |
+			    MAX310X_MODE1_TXDIS_BIT, 0);
 
 	/* Configure MODE2 register & Reset FIFOs*/
 	val = MAX310X_MODE2_RXEMPTINV_BIT | MAX310X_MODE2_FIFORST_BIT;
@@ -1223,9 +1229,39 @@ static int max310x_startup(struct uart_port *port)
 
 static void max310x_shutdown(struct uart_port *port)
 {
+	struct max310x_one *one = to_max310x_port(port);
+
 	/* Disable all interrupts */
 	max310x_port_write(port, MAX310X_IRQEN_REG, 0);
 
+	/*
+	 * Stop the transmitter: the character in flight completes, data
+	 * still queued is abandoned (the next startup() resets the FIFOs).
+	 */
+	max310x_port_update(port, MAX310X_MODE1_REG,
+			    MAX310X_MODE1_TXDIS_BIT, MAX310X_MODE1_TXDIS_BIT);
+
+	/*
+	 * Let the character in flight finish (the chip has no
+	 * transmitter-idle status), then empty the FIFO: auto-RTS releases
+	 * only once the transmitter is empty, and the power-off below
+	 * would freeze an asserted pin until the next open.
+	 */
+	fsleep(one->char_time_us);
+	max310x_port_update(port, MAX310X_MODE2_REG,
+			    MAX310X_MODE2_FIFORST_BIT,
+			    MAX310X_MODE2_FIFORST_BIT);
+	max310x_port_update(port, MAX310X_MODE2_REG,
+			    MAX310X_MODE2_FIFORST_BIT, 0);
+	if (port->rs485.flags & SER_RS485_ENABLED && one->baud) {
+		unsigned int hold = DIV_ROUND_UP(one->baud *
+				port->rs485.delay_rts_after_send,
+				MSEC_PER_SEC);
+
+		fsleep(max(DIV_ROUND_UP((hold + 1) * USEC_PER_SEC,
+					one->baud), 100U));
+	}
+
 	max310x_power(port, 0);
 }
 

-- 
2.47.3

