Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023090.outbound.protection.outlook.com [52.101.83.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983AE370ADA;
	Tue, 29 Sep 2026 09:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674740; cv=fail; b=uTTypeDOIf63L2OZ3QUEMIh7QE+rm2UFvqwHCkRnVO3pnU9IZUbNFa93Wk3QBzYYWlQ3hMPVpi2vcVudNgo98dx/vUCvVHo3qdLZDz6kLyc4XxMPB9kOmNIS3t7NKxs0fiqoXt5r1n9w0t4vIuGSVRSNe0kqxxuu+hlgdAGSd0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674740; c=relaxed/simple;
	bh=xr3HMZq/cCA68Q3MWoaSY+3f5H9EEnj2ia9uPFFAENg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=X1XceU6mcDGH0Luap7CoCGdN1X8MswHnc4dynk8eMSwrzS2UOFG0itn+ctr34bruN+zH09/CB++f6ggKltkwwlOljdwrNsR2gAYaTTfj87Q11k/Ynlwr3GI9/C0S72ctwg+z38fuAWwCoCZbS6KH/vqhvdzDqX/CtwM0dreNPYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=BWOWd3tQ; arc=fail smtp.client-ip=52.101.83.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="BWOWd3tQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgRlq/x7P5FvVZ6wMhHuNwGSvNwPGr5ppq3fPHKEImsuXNwwIuDH93v5teA9+1vf6p31lf7i7OP2SRBNkr/nfMaOF0MSnTu8h55xF7ZwGfNucniEVWrBehU7G9gdA83vHOGJbBaeAy7WnbGIrFrY4XBc/Urb8KGIIOo4swRquSTIBkYCV+D8KC2DbsXjRZYcCPmhfUQwfuykR4QoRMQLa5yzYWfxf8bSl5CHkSoxVkV6p3Stp5KhO0Jd6Ms+cQMbLAQNku73NxwaoPsh2VBEGzsULVoorOGYkFUEGIMZC0eBdCGDFM4bw+d9Bv2ntVs34X1BeSaUl9jKfQiT/+JPDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FBQdrgQSFZZJ+xlIlF8JyIGb1qP/WIQGZJr7Ubs+mU4=;
 b=R5Gq8Kml4nclODS00LBOaiue1IJ2iXbHCzHsLMNgu9wTN5vbY5z4u7KGAfIuwNGNOxUMK+0Bfq5D0mI0WZxVMwa9DUf5PCi7Fq5r44ZePWO56fjo6hhHeA9jcAPBmdwyfvuCArCHWznxTRT5oQ5ZYBnX698oEFCQnyPuQ02t4Db9iBvX3d2hBgKUWZjqv+88C6DFB3DG2Uh/zXtRdit0HoBHup2Wj8X6dBNHN3HJ3OhkMO+Ubgkk1c7aY0mylUtTuZw5z2V42dNJY969BDgTIAet0ux+H/bm7XqKujpo3r4GTSonOaLXH5nKtyDA9JoYbaEOA1tgD44Xlrr58v+YEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBQdrgQSFZZJ+xlIlF8JyIGb1qP/WIQGZJr7Ubs+mU4=;
 b=BWOWd3tQGdLzvjjvCTTLDWXO8GMo2sEg/cu/tI1GkBERjlxqLdsmlmtw/ZrilivGC2DSfNVOchjn0x0uG3GRMyLGV1gl5TOKDKP9F5ytE/GtoAy8WNZBRfO6up6bK8QqeVf+qBtkTVPAyvbpRQmvBoXcKEayGb8y6OOKN2vmpHCyygZ+TniICKWvlUb30oWCagz935tRu9RnqBn2Utj+EpQgo9rJE94pLEPeB00fHfNCp2ij5SXqF00cGyXZ4uohQEANQDLvZm/wBKxsPZyK0S8ujXEyqVuB1+zuPBdDDArwWTOjkld1SUOKtyYXo2OQKGHEojk0tidyoC5S8VYbkw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by AS8PR06MB8258.eurprd06.prod.outlook.com (2603:10a6:20b:42e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 09:38:03 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 09:38:03 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Subject: [PATCH v5 0/8] serial: max310x: RS485 delay and RTS fixes,
 software-timed delays
Date: Tue, 29 Sep 2026 09:37:54 +0000
Message-Id: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPKGu2oC/3XPwU7DMAwG4FeZciYotpMm4cR7IA5ek7FI24oSF
 DpNfXe8cRhoqnz6LfmzfVEt15KbetlcVM29tDKdJLinjRr3fPrIuiTJCg0OxgHpI88EZta12eB
 0+9YpH/ismcyQfKDkMCoZ/qx5V+Yb/PYueV/a11TPtz0drt1f0pu4RnbQoK2zPILZRvL82rk0P
 vDzOB3VFe14hwLAKoQCZbIYCI3zIT5CdIciuFWIBPIJDVuprcNHyP6FhlXICpTkpSFauWvc/Ye
 WZfkBQgApj5kBAAA=
X-Change-ID: 20260513-max310x-rs485-sw-delay-a306d783d529
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790674682; l=5027;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=xr3HMZq/cCA68Q3MWoaSY+3f5H9EEnj2ia9uPFFAENg=;
 b=T2pjdnUPAsSSniJQ5OQYWTpOzvVad9Qks7CyaoVizMhqRJOBatLrEhHB1WXMg0Mc0G+OJqobi
 EHwjanelMZjDezr10cAlWGvZFFA6sJpkkAPGCvduxfXAqRLRSWCWlTx
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
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|AS8PR06MB8258:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b5f3da-eec0-41ce-571c-08df1e0d5bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|52116014|376014|18002099003|38350700014|10067099003|260925021911599003|260925022911599003|260925021311599003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	w5JYKL04dy/5+SG8S2KnmhP4xAdBg9N3naH9mV0gqWof8/RWixSp9FXagOx4GU5hGaOlxPBuvLByQH7GlOsyqRcJU6RtYWIuRaVl4gDfusRz7o5tuL94cmB6M9lkJEu5UnZzjuusQxJEv1zVG1+yA2Gq+jMKgzik1XztPhUj6kuyc9ON7rRKy7RApD67xgWYDb8mhupXW5NfUVGajXLuB3DH1qV8koSNjs8l/sqc7UkYKjwrZvCc0mwJnATCUckx7r0WAMVBVTRb9ILHAD6pCStj/Iz4aUSSoqjglCFIT22ODmLMisnDSF+uuFYBHQYytGHmh/4ZcL0vkXxYM1TC5ay2zbxKolFXWjOk0jHPjcbfKtTQbAGaWysM15ibm0CXpB20aKpjm/APC3sBvVYfOg1uWr31rNkdzhQQbcZKCnDsyRwNRnrYp9+7La/HA1IGsMHHl+VRs9rbxOk9rhXZURCJ95TRDOggoWgyT66qx0kWNuUQ5b0f/xy0/uqgMkMC+GcWmZrFVtyJTdd8nDdamzxLUfBHjtQF7/LuedZSjAnsPtGm6RiPIvEqOz/Z0BHHCAlEZa1R5BsIfY3qIHdvSCqe7tm6A7/4NwgHJypSHtEoTkzHXCPAMTMyzM79B+JcJguXMOJKggjnQcJIUIPrEAW83nm1UX+QyTe/cdwfuzPZU3eECd4nNGHxjLkDRJcsdLxOYQ4BOQZgEE8XALu5f8AyA3d2E7Cn+4kisxS1MNk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(52116014)(376014)(18002099003)(38350700014)(10067099003)(260925021911599003)(260925022911599003)(260925021311599003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alQzRjRnVjNYRUtiL21uemtGaTlxbTU4ZWJWeUNaUUR6NERpMERZQUVRNWhN?=
 =?utf-8?B?R3BtNGZNY2MvUEFxUHBodjQvQXdvcGY3UTBDeTJrdGcxclFNQkpmQSsrckJ1?=
 =?utf-8?B?TFpKMmFLbEk1ZWRjU0t6QTVUVHdKeGk4QkU5L0F5dmZpUmk4eGVzN082VzV0?=
 =?utf-8?B?OWFWUkNLRUNyeUQ2eGswdFU3UlI4UG1XdzB3SldOVk9RZW5hVG9SRTF3VzJH?=
 =?utf-8?B?VTNjdkY2YXQzU2JqWnVwQzhlTWsvSXorSzd4SGJBWE1JY0VGR0lVN3FXTHdj?=
 =?utf-8?B?cS9MUlJoazdaUlFySzZZbThVcXhPRGJBTzI5L05TOWVIR0ZhbzNYNUdYa1dp?=
 =?utf-8?B?NDh0bTd4eTdSN21LYk5JMHFmdm1zYVg5QXVkR0RsRzM5VjB0YXJrVXpmTHVJ?=
 =?utf-8?B?WWtNQkJzQkZTb1lYNzZCY2xrWkJoaDZPRzFZOVc0V1BjRVhzQzJRbEd5WE9M?=
 =?utf-8?B?TVp2dW5XWUtWejhRQTZKWVM2N0FsS3IxRWh3d2UwQXZvcndqOUFxdHhWZXJR?=
 =?utf-8?B?cHB4UFc4MnRXRzRGb1BvRFNubVBxQmxuY0FaVHY5Q0tRSVdyVXJ3YkE5aGZX?=
 =?utf-8?B?ZTFSczBCaGJ5c3VMalpUcld3VE02ZVdkekJ4OTE1Z2dUWnJtOWZDOWpiWXVE?=
 =?utf-8?B?dEpaUWZ3ZVJZRGhFMGNLd3A4enhydXFNbFIwY28wS1ltYUhrRGFSdmZpRzV6?=
 =?utf-8?B?VFFiMFYwN09QczJyZUlaSkFBV2NNQ25Semp2Uy9jK1Y3WWREU0NIOW5rd29W?=
 =?utf-8?B?akJaYXNRdWd2L2lQcUEwRDRxdldwV2x2V1M5S1Nvalo2Q25TQ2ZPd3o0UFdU?=
 =?utf-8?B?SzRiM0hUSTBLZ2ZxazFqQWpoa0RXNUVMdi9vclB4eHh2QjVJRUtiMUpmaUtY?=
 =?utf-8?B?OTBXMk5FZldMYi8xNHRVSmkrTVFOVGorcko5QjFFYm1xRkk5TjBmaE1iWHZl?=
 =?utf-8?B?OUJtUGFBMzE5RzdhNzgydENlK2tIVDBJbjkrOHhlUDlvY0ppRFlWLzdQbjZr?=
 =?utf-8?B?MzcyeTFQeXJGL1lGdkpid3c0L0tZNjNDUkY2ZkYwVVFiWFR3b1FlVDBEdmti?=
 =?utf-8?B?K3V1cUVHOWZLcFRlOVFnS1hVMmFYWWRiTTJKZ043RUVOcE9sSEFXZ2dzUGNO?=
 =?utf-8?B?ZENuTFVvcFBDN2tkUEF0RFR3U1dVZ05MUXZGSHdPazZ6eEh3UFVRcjBkNEx1?=
 =?utf-8?B?cTdKVXc1c04xaXVCSk9SMHhYOVR6MXhMSEpWV29iSzVSZjdDQUMvUGFuOFRX?=
 =?utf-8?B?Q3VqakJKcm5ZZENmZ0RlN3hUZnl0bWNOS3N6OHQvekg1ekk4VzRvK3dYM1Rn?=
 =?utf-8?B?MHJ1TUZKZUlxWEsyV3RzdUpmNkYvbHFEcm51MTFJSTJWOFA2aFVmODc4RDdz?=
 =?utf-8?B?ck55dXM1YmZpL1l0UHNRS25vZlg4ZW9VVGRucUd5UjNIQmZlSlhCQ0RIUEIy?=
 =?utf-8?B?TzRZSEpsSlpyRHU2UHFHZ044K2xpT0c1UTl5RUJxOFdtSXNLT0JtWXpBU1Yz?=
 =?utf-8?B?b0tEcWJpSUpxK1FnTGtBaHhQV3liV1Jxc0VoMmJMWjBOWGJNblpJZ3JGdktL?=
 =?utf-8?B?anBEeE1NYVcxYmVrdXN0YUkyN1JQZllLUWVBaFIwQTV1QmEwYlVwb1FnaVNT?=
 =?utf-8?B?eWdXRm85QjZrQnRVdkFWdXVGcGM2SjJpNkhrM2NlZnAyWEVvcmVkU3hHWGNS?=
 =?utf-8?B?eU40MTIyR25QM21ldm1BZFF6K2V6ejRFU2ZubG91QloyVFExeTNpTk9Lb0V4?=
 =?utf-8?B?dHRCM1IzZDlpcUtGR1ZVYlFlMUM3dHlNc05hMS85SCs3T1RNNUs3ZFIxcmEw?=
 =?utf-8?B?c0dDVkxBT1pZa1lEdUMzSklxVGMwNm93N1JYbmVyclRqM0lWNU5VanpxTnFL?=
 =?utf-8?B?dWNyTThoY1lSd1BGM3pHREZqREkrbWpkTUlFWVpVUjZFZmh2VHY1UHRFSEJz?=
 =?utf-8?B?cUczUkR5aWVXeDVTWVQ5Z3llSTdjeC9HS3lHM0dMSi9TcUkzS3pteVJIU1Jr?=
 =?utf-8?B?d2gzVmNieDFYY2RBaDZjaDNSVERuZk9WY3hzQncvaFNxSDhlVGhXUVJaaEpK?=
 =?utf-8?B?UnFLa0pnanF3RzIwalBiYVlZMDE0Uk8vRmxWcTZWdzMyM3pHb2o2eEZObDgz?=
 =?utf-8?B?bms5NUV0bSsvaHdoZVo4V240M2lrcXRjMUVScCszYzg5TEcyWEtZOWc2Nnhh?=
 =?utf-8?B?WGs1SHJXYk9BOCs5Uk56SDJBUUUwZFUxTW5laGswNzJwOFB1U1dYcjIxcU1I?=
 =?utf-8?B?TlFUTkRGelFzNkh1RzVEZGsvTCtVSWt1ZW9xcUFLdUVGWVR5TTZkS0M2SGYw?=
 =?utf-8?B?TEtvZlYvNHQzektkZ09qUW9VeE5ONy9rWkI0aitrUEtiTGpWSmE0NTNSdjBD?=
 =?utf-8?Q?PmAa0ui5zVuWDf9Y=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b5f3da-eec0-41ce-571c-08df1e0d5bde
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 09:38:03.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BczfaijuVa7ipmqII4b0Teu3mbwH9FCBjcTGEu4djIJw/IMW7dehd3oE3P7HTvPBL+il8+br+/xF/itLFKlLvoMLwmIa771x0yuPt26KhnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB8258

The MAX310X hardware can express at most 15 bit-times of RS485 RTS
setup/hold delay, while struct serial_rs485 expresses the delays in
milliseconds. The driver rejected anything above 0x0f with -ERANGE,
upon which uart_rs485_config() wipes port->rs485 and silently disables
RS485 - a device tree asking for a 20 ms setup delay boots with RS485
off and an unusable bus. The values that were accepted got written
into HDPIXDELAY unconverted, milliseconds as bit-times.

Patches 1-4 fix pre-existing bugs found on the way: a termios write
clobbering an active break; breaks never reaching the wire on RS485
ports because auto-RTS only drives the transceiver for FIFO data; the
milliseconds-as-bit-times unit bug; and close() truncating the final
character because tx_empty() does not cover the transmit shift
register. Patch 5 adds active-low RTS on the hardware path via
IRDA.RTSINVERT. Patch 6 is preparation, and patch 7 adds the
software-timed RTS path that takes over whenever the hardware cannot
represent the requested timing, clamping the delays to the UART core's
maximum instead of rejecting them. Patch 8 fixes a reconfigure-versus-
write race the asynchronous rs485 config application has had since
2016, which the software path would have made worse.

v4 was all of this in a single patch; Greg asked for it to be broken
up into one change at a time [1]. Splitting it meant re-verifying each
patch in isolation on hardware, and that re-verification found two
bugs v4 contained: a set_termios() or TIOCSRS485 during an active
break released the transceiver mid-break while the break bookkeeping
still looked correct (prevented by the tx_break ownership guard in
patches 2 and 3), and the patch-8 race, where a TIOCSRS485 followed
immediately by a write could put an entire transfer on the wire with
the transceiver released.

Tested on a MAX14830 (SPI, i.MX6SX) driving RS485 transceivers: for
each patch the bug it fixes was first reproduced on the wire with a
logic analyzer against the kernel one patch earlier, then shown fixed.
The complete series additionally passed an automated 25-scenario
regression matrix covering both RTS paths, both polarities,
RS485/RS232 mode round-trips, close-during-transmission, and termios/
TIOCSRS485 disturbances landing in every envelope phase (setup, data,
hold, break), each scenario checked both on the wire and against the
driver's reported state.

Changes in v5, beyond the split:
- teardown interlock (tx_teardown): shutdown() and the rs485-disable
  path set it under port->lock, and start_tx() checks it on entry and
  again after retaking the dropped lock, so a racing write can no
  longer re-arm the delay timer or queue RTS work against a port being
  torn down (addresses the remaining review-bot findings on v4)
- shutdown() also cancels tx_work, previously only cancelled in
  remove()
- the per-character duration is stored as unsigned int microseconds
  instead of ktime_t: single-copy atomic on 32-bit, so a torn read of
  the 64-bit value is gone by construction
- the TXEMPTY handling documents that the interrupt latches on the
  FIFO becoming empty, so a stale interrupt cannot pump data during an
  RTS setup delay
- new in v5: the tx_break ownership guard (patches 2/3) and the
  reconfigure-pending gate (patch 8), both found during the per-patch
  hardware re-testing described above
- also new in v5, from a review pass over the split series: startup()
  clears a latched break (nothing clears TXBREAK when a port is closed
  with a break still asserted - 8250 does the same); a reconfigure
  arriving during a break is now deferred and applied at break-end
  instead of partially dropped; the rs485-config worker runs under
  port->mutex so its break-guarded register writes cannot straddle a
  break edge; the termios-path idle settle re-checks tx_state after
  writing and requeues rts_work if an envelope started meanwhile; and
  the hardware-delay ceiling is computed in u64

[1] https://lore.kernel.org/all/2026092326-truth-unweave-c773@gregkh/

---
Tapio Reijonen (8):
      serial: max310x: don't clobber the TX break bit in set_termios
      serial: max310x: assert the transceiver during a break
      serial: max310x: convert RS485 delays from milliseconds to bit-times
      serial: max310x: wait for TX to drain before powering down in shutdown
      serial: max310x: support active-low RTS on the hardware path
      serial: max310x: schedule tx_work directly from the IRQ handler
      serial: max310x: drive RTS in software when hardware delays are too short
      serial: max310x: don't transmit while an RS485 reconfigure is pending

 drivers/tty/serial/max310x.c | 511 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 477 insertions(+), 34 deletions(-)
---
base-commit: 9505146e885b1a842118aa6410f737290c4a5a32
change-id: 20260513-max310x-rs485-sw-delay-a306d783d529

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

