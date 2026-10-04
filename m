Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023073.outbound.protection.outlook.com [52.101.83.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20506417BF9;
	Sun,  4 Oct 2026 12:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116204; cv=fail; b=RUpOY38zCaEsAB04s2LeNFuoVEDUaGteLdtL74BXXR2xgMu6Aco4VU1nsLyYTruOy5gl7wv0CpjESopUujv8EyZpv7AoHWEZyco7z+AtfNAjJjQMPKSGOKa4vtY43M28vM+kZ28ko/HjGRdIJc+zl+teOcq+SAFmXF/NOO1NY6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116204; c=relaxed/simple;
	bh=0IPPQ4vkkBkAa9f9BzjuA13WKTlTbu8sR4WhuJNF2Sg=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=aQvj6POoVaCtVK8Z0My3UUFpS2kiS2ZfnfEE9aWG7sj10uNpRYkQ0D1fqaopA+Q1ryjLY8iKFb532XlDurO/SCByj6unxGihh8RUAmXAYwLucRuQIbpnxTkxKQmdDEpWC8LAxo2vszHe9P5NKWX6zk7OaLMA39rDNKVPwtX6QuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=bN+pqxgX; arc=fail smtp.client-ip=52.101.83.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="bN+pqxgX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aAYxnieymd+j9/WeFaraP7M9+0GSqQ2XIXmjixx8nvY5S/RigXLDEb7Fz560BWkTkFlcdFEGv6rbya+rPDCjlWuliFngfPypW5QeN9PjgFBCg7I+Npo7BDVmLh66sHLvWV/UgWfvqgdtECNnqP6r7uc4AsMk5DzrpJmeO44vm96cIugBKp8AtSJWLaie7x+L+4QYYZ3+61K2vZRO48zAnFP+x5RxlmltmDsjrh/zXmnCVIJhBp1T/BH+2VW/PiNpkoOePIiR0eU/b+BxKydBc0AlclhnOWOegR90tnyjLDgvk6I7ula6SppPHUoQVo7hpUKuhQ6s/bY2tkcx0Ngb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MxaI4FGFE3QaA9VG6NU0569c5PhhguOBH3vVCyM8TdQ=;
 b=MCDPr8a2KfA809alji+vPdP9R7dbH6gBxD+h83b1Yyr9UcO9hLcHlWa4jHFac7kCsiAr45uG86F4r3AkyDKohbP68ZWQ6BL1bYubojOgq/LDW+fDpSUwY+V2Q13jF3oXyqJ3UiwFTRaW09mMCqXRCqztpGIPkUdP93G57vTyFg0Iothp8MqNb5GrPpkiHXWAJUOHMecuyTF4+MAj8umkQ7dlPkZt9XtKdZ6UO/7IBJ4NU1IaQ4K7TwIRHLfMUBQKo9fjb0Tk50HM0Azn/kLDdfxJJBdij7SlrZuGpcAQGGE9JRHLy26+6npFCzNROwrntI7zbkLtH4I2rZDxJqzpxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MxaI4FGFE3QaA9VG6NU0569c5PhhguOBH3vVCyM8TdQ=;
 b=bN+pqxgXtN2f3LmvNiaKFb0qUUBiD/inLdxfHyfAdOzdT4CJGlMxcHUgVverb5WmrKGAl8bDVKjRqIAspzSE5FUzJPxzgGuXzN9tQsVZLZm/wXceqCHQHcG0wRt9mWkb7mNqtlU9uvKFwT5woROZW+Uh9S1gWezlRGPwdMlJfrL0ra8tdo9cPoBBDYbS36VUI/Fh55oqCZPn+92dr+GC4QBPiahj0LVaGjB9A9tJpsSzZhvKIkNy2Jd3WCn7aHfkZcqbuJe0HFQC2c+c8XWIECg6ZcH+JpQc+Zgml2OmcKK9HBYklKJDPCSLgzhZdxsQxODODCmTBkf9tZ652CBvUw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by VI2PR06MB9239.eurprd06.prod.outlook.com (2603:10a6:800:221::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 12:16:32 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 12:16:32 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Subject: [PATCH v6 0/9] serial: max310x: RS485 delay and RTS fixes,
 software-timed delays
Date: Sun, 04 Oct 2026 12:16:20 +0000
Message-Id: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJRDwmoC/3XQ224CIRAG4FcxXHcaTsOhV32PxotxYSuJugYaX
 GP23Yv2QtMN4eonmY+fubESc4qFfWxuLMeaSppOLZi3DRv2dPqOkELLTHJpOAoFR5qV4DPkoh1
 CuUCIB7oCKW6CdSqg9KwNn3Mc0/yAv7Yt71P5mfL18U4V99s/0nLfI6sAARo1DYLvvLL0WSkVO
 tD7MB3ZHa3yCTkhupBsUFRaOiU5WufXkHpCXmAXUg2yQXLS7exQriH9CpkupBsU2peM163XMK4
 hfIFkf0cIHChqQyOhU+O/Rsuy/AIMg4Zu4gEAAA==
X-Change-ID: 20260513-max310x-rs485-sw-delay-a306d783d529
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791116192; l=10023;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=0IPPQ4vkkBkAa9f9BzjuA13WKTlTbu8sR4WhuJNF2Sg=;
 b=R+9nC4qTEBSmo0X/XjA0FmhZYDNTUMuKzql66qL4xiBRgo54Sss1D6uykE6LKJ6NINqflPFqt
 pSYocjCh6+fDo/y0gb4U8XmOQIgF/JOtQrqAxtn+B/kccLwKqB+511u
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GVZP280CA0005.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::6) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|VI2PR06MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: ec78523c-a5b7-49c6-10cc-08df221153f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|52116014|6133799003|18002099003|10067099003|3023799007|260925022911599003|260925021911599003|260925021311599003|56012099006|38350700014|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	1lGnYaVrbyBcVrVj/fyfFSE9m1lJRqQnMg4jiCyj9GDZi12XBuAWfPcvFOy9hLEoL5IfIAj3yayw21+3RrTMW7gQT4EpSZvmZsMFXsiODtANcTawBw960o76PhCgK2hjwYguqIl1JktQvcRso2gFLb/8fhYnkDHqMKTXVXjSs9xIGWcK7K/9ICBBeqwIU30RBt6Wr5DKHma8r33Jwsl3RB9qfuNgmU82O3xmPJSqW9+1OIEbhikB2A05rP5bMGBMQ55D18pb1yGRnuo7cOmVkCpX5EacK0Lcjb2/Yjiom8r1oU62IAf4F0xZdm4WcBKHxKyeLCpE/ihGbvC/Q7GXXyJAqkAPwGu7NVBNDGn0woJcHq5GnZQ6xbJC3v6mqsK/oyRtQlZ2KQnxhJOgu26T3r60+AvK3RFaNbA4GP9ml+8sv3TxzvNZNrEirxqP6cUaVQCllmciPzHEtByS5sepsS0FvW3A/eON7hcv0ZsbMTO+gggGOYWNFvKicbv5aB6rkV23h2O0yABtTxG6diLQna1s+t4rNZg4vI3KjaKNhYkEpzUvqbtgdUcqvDgUpQsaIKb4tIzkVrkxQ2ZEG/SD6L5SHY5yZ7DNQwAFYbOj5eO7XLQUhjJFZXe86ulLBUyBlci/xAViYhVPRcqLzEIcbi5uJdcooFjg6bqqdSCMfz0V4OdsimH0hh5Nv5Cv81biRcfry5aNzMTDdRTnPcaPRm/C/RwGFNblYiVppZz2Ahg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(52116014)(6133799003)(18002099003)(10067099003)(3023799007)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(38350700014)(5023799004)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUxNeFE3b1ZZQnphYURIWTZKTzVRVTRYZ3gwT3NXeWx2ZkpobSt3dlI1RlEz?=
 =?utf-8?B?RmVOZUVzeGtKcHRxeHE3ZTFsS1NUQTB0OHRQWFNlSjhCQUV6dFhQZDZpMDN6?=
 =?utf-8?B?RGY2eVhTeTl4YzFyQUhaTUhaOXpZMy9YYUp0Q3N4Q0NPUnIyQmNCUUNQZHcw?=
 =?utf-8?B?MHM5VzVST1drZVRFMHFuYnZvNHJZZXpJUFYzRE5zdWVxY3FIQzdXamM3all3?=
 =?utf-8?B?MnNHaEpidmJHK0FydDRlbExTbkVicjJraWZBVDVQYVBZaVZEZGUvSUx3QllY?=
 =?utf-8?B?bW5SbE0wM3c3WGhUWnp6M0tFNjFsb254NWtUM2V0OWtvY1FWR25MbVhDUUxq?=
 =?utf-8?B?cndCSzVjb0tXSmJqQThhNlc4U0R3a2NycjVBT1RqZEFmeGFCNU53TEo5T0NU?=
 =?utf-8?B?OTV6bzE1TGRxR0k2bFhJa1hjdGNjZUFJRURLbFNPaFZZakFMM2ZUUE85SnNi?=
 =?utf-8?B?TnFQY0t2TGpyQ2hqRjdkZmNxSEJTMjFBVE5SWitUaEdPanBDMDhCZ2NiR0Nr?=
 =?utf-8?B?U2psZUlNUFN4SzRtc1FVVmFrNHpJTGRXQ2tVM0p6MVZzeGNZRWltWFlRM05O?=
 =?utf-8?B?U2J5S1E4MDZOdURCdzd1aldVWUgwWmFqQm1BSDdnOWJWeWREZDFWQ2VycGJB?=
 =?utf-8?B?T3VUeWcycjhMQkR5dll5c2I1MSt2NjdjWGt6NHJPZExEOU11aU1yQnhqV1lU?=
 =?utf-8?B?ZkVnaVBsaFlaZnRScHdoOFh6NmU1RkxZUWduN3l6dU5aMjBjM2V0emdwL2sz?=
 =?utf-8?B?RG4yUEU0SDRQeTFkUDN4MlJyZlMyZUFROFc5enZmRTJZazhNTUJ3YVJyWHB2?=
 =?utf-8?B?QWNYbGw1WVYxNE5RakNZMTRka2pXR3VzeFc4a2l1U2crSFEwcUo2V2dibHRU?=
 =?utf-8?B?aFM0eFY3Sm81bmNPN3Q5KzJUdGRYaGxpdGw4Vys0L1orT1BlL04vOGlwR2kv?=
 =?utf-8?B?VGx0TUpFUFU5aDM0MllaYVovYU5xdU9yOGVpTGtnM1BtZ0JPTFl4bExqall1?=
 =?utf-8?B?V3ZQcnV0MG15OUxyWm52TS9oR3EyWWI4eWVjZHJ4MnJTVVh0ZnVsN0dtVnl5?=
 =?utf-8?B?THZvU3JQUnpBSFZtVm80YnExUWpXMExKdWphbFpjdWlrSG9ydHhSaWZ1M0ZF?=
 =?utf-8?B?YlpWaG03RmNjMmJKMjlaOFNaWGJ3MmZja093ME02QXZsc05FNXEvYXBsQ2Vv?=
 =?utf-8?B?cHZFcGYrZmhQNjV6R2Q2dmd4cjNyYzVYOVhVUWNVQUE3bG5mYjk5UU41RmRL?=
 =?utf-8?B?bTk3L1IwV1FMN2Z3TmlVK1RJSm51UnhndUgrWU1rSDZZUld1Z3lPbTVqTnVY?=
 =?utf-8?B?c3JLaDlXcDV3Q2FyTTY1OVFZbktVOWxGRWN4VURpa0thWDF5ZTFjV1JzbkZx?=
 =?utf-8?B?c2dHenliVkJ1TlBQM0RiT1RiMmlIZEN1dG9TUWZIdFkrMXN2THREQWVNdHNz?=
 =?utf-8?B?ZVVVNUJ4dUg2WWN0SVJUc0piM3F4eW1aUXhNWXF3NjVGeG5HSUpsN011Mmgr?=
 =?utf-8?B?SHFkQ0hvVUJ4YmFUcWZJeml5M2h1OHFBVzgzWG5SdTR1Y0dGdEVXcTljZzRT?=
 =?utf-8?B?SnBVWlZnZjYzSVZ5NWI2MkM1NnQ3UEg2cDBDbCszQjhrNmw5QzRKZ0l3L29h?=
 =?utf-8?B?RkRGWm1Zb0NuZTRRZGhVdkNmaG9VS09sZ2FMWEFZblNVajMzTVdWV3ErRytL?=
 =?utf-8?B?ZitEcUVSQ252YkxUblpHN2N5am9iWVhPZjN5SVVsZCtzakJtT3lka2FnVkgw?=
 =?utf-8?B?UjZaZUUycllSYXovSi8xbXkwcVA2Q1lManNjR1BUbmVnS1Evcjk3NHE4bGt5?=
 =?utf-8?B?OGdkVlRDZlByUlBPdjlaTHJXZlVkT0xXUURIR3RoQnZTK2MyeElvRGVJTHQ1?=
 =?utf-8?B?enZVR2VtQzNpZ1d3UW0vWDRaMlc1ZnlSWm5iMGpydDJxbmFTbnJVVldCYk5K?=
 =?utf-8?B?aWNnU0tMVEJvVWxGQi93eHg4aXRzMDAxNi96a2M2TGtmSHRTeUVCZDNUY2pa?=
 =?utf-8?B?bVFlTm5JMW9lWit5dGVzMXpFd1pMcDlLQjlyVnRFMUlkdkV5aHZKTjdKVy9W?=
 =?utf-8?B?MmFuWjNkaUxGYktlSDBIQWJ1R3FVQWkvR0ZkRm03dkpYR0JiVFB0WG5KT3Zw?=
 =?utf-8?B?OW5OUVJlcXF3ZWRmczJGT2tEL25pY0VtN3NGakI4V2pxMEdoQWcrOGkzeklU?=
 =?utf-8?B?UERmSUpXYUpiNjJJcW9EcHovTUJ0ZzdTUUg5WnlQZlFoSTZiMDh2MTFiUGc1?=
 =?utf-8?B?STBZdm5TZWovbWlmMGFEclZsdGJSSllzWXJxOU5Ody9oK3RRdlVYV1IvaDNI?=
 =?utf-8?B?N2lzY0FTQXZvaXc1TG1oTkc5ZWtVZitjU2J6cDZPc1RSS05vWHNlNDBjb2hw?=
 =?utf-8?Q?CQ4Iyi9C04rj9TUY=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec78523c-a5b7-49c6-10cc-08df221153f0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:16:32.8774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xag0zYADQOhwgitE1pFm4YsaZvJ1Z4jRMWjOUEikH8IzGFkjixXvcm0Z3deMiBxth+6UYwyUMnvQlB+9//xiC13sgzXDzLAncnNGw0Bokc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR06MB9239

The MAX310X hardware can express at most 15 bit-times of RS485 RTS
setup/hold delay, while struct serial_rs485 expresses the delays in
milliseconds. The driver rejected anything above 0x0f with -ERANGE,
upon which uart_rs485_config() wipes port->rs485 and silently disables
RS485 - a device tree asking for a 20 ms setup delay boots with RS485
off and an unusable bus. The values that were accepted got written
into HDPIXDELAY unconverted, milliseconds as bit-times.

Patches 1-5 fix pre-existing bugs found on the way: a termios write
clobbering an active break; breaks never reaching the wire on RS485
ports because auto-RTS only drives the transceiver for FIFO data; the
milliseconds-as-bit-times unit bug (patch 3 first centralizes the
transceiver register programming with no functional change, patch 4
then converts the units); and close() truncating the final character
because tx_empty() does not cover the transmit shift register. Patch 6
adds active-low RTS on the hardware path via IRDA.RTSINVERT. Patch 7
is preparation, and patch 8 adds the software-timed RTS path that
takes over whenever the hardware cannot represent the requested
timing, clamping the delays to the UART core's maximum instead of
rejecting them. Patch 9 fixes a reconfigure-versus-write race the
asynchronous rs485 config application has had since 2016, which the
software path would have made worse.

v4 was all of this in a single patch; Greg asked for it to be broken
up into one change at a time [1]. Splitting it meant re-verifying each
patch in isolation on hardware, and that re-verification found two
bugs v4 contained: a set_termios() or TIOCSRS485 during an active
break released the transceiver mid-break while the break bookkeeping
still looked correct (prevented by the tx_break ownership guard in
patches 2 and 3), and the patch-9 race, where a TIOCSRS485 followed
immediately by a write could put an entire transfer on the wire with
the transceiver released.

Tested on a MAX14830 (SPI, i.MX6SX) driving RS485 transceivers: for
each patch the bug it fixes was first reproduced on the wire with a
logic analyzer against the kernel one patch earlier, then shown fixed.
The complete series additionally passed an automated regression
matrix, grown during the v5/v6 review rounds to more than 40
scenarios: both RTS paths, both polarities, RS485/RS232 mode
round-trips, close/hangup/SIGKILL landing in every envelope phase,
output stop and flush mid-burst, mid-transfer path switches in both
directions, XON/XOFF injection at idle and mid-burst, and termios/
TIOCSRS485 disturbances landing in every envelope phase (setup, data,
hold, break) - each scenario checked both on the wire and against the
driver's reported state.

Changes in v6:
- every patch now carries the Assisted-by tag, which v5 omitted [2]
- patch 1: the LCR clobber is now described as "overwrites the whole
  LCR register" in the message and as a whole-register write in the
  comments (Hugo)
- the character-time caching and the shutdown drain-wait comments now
  state their reasons in place: both values must be current before
  the RS485 helper runs, and the tty layer's wait-until-sent is
  bounded by closing_wait and absent on hangup (Hugo)
- the old patch 3 is split in two: patch 3 only introduces
  max310x_set_rts_ctl_params() and folds the three copies of the
  HDPIXDELAY/MODE1 programming into it, patch 4 then only adds the
  millisecond-to-bit-time conversion (Hugo); break_ctl() keeps a
  single max310x_rts_ctl() call at the end instead of duplicating it
  in both branches (Hugo)
- one_char_duration_us is renamed to char_time_us and the shutdown
  drain bounds to tries (Hugo)
- fix: disabling RS485 during an active break left the transceiver
  driving the bus indefinitely - break-off only ran its restore while
  RS485 was still enabled. Only the break assertion is now gated on
  RS485 being enabled; the break-off restore always runs and derives
  the register state from the current configuration (patch 2)
- fix: a reconfigure that moves the port off the hardware RTS path
  while a transmission is still in flight - a termios change or
  TIOCSRS485 pushing a delay above what the hardware can time at the
  new rate - released the transceiver mid-transfer, and the rest of
  the data was shifted out with the bus undriven, with no error
  reported. The helper now takes such a transfer over: it enters the
  software envelope and keeps RTS driven across the handover, and the
  normal drain path arms the after-send hold (patch 8)
- fix: a break that begins while the previous envelope's after-send
  hold is still armed - TIOCSBRK waits for the output to drain, which
  lands it exactly there - was cut short when the hold expired and
  released the transceiver mid-break. The RTS worker now derives the
  line state from break ownership as well, so the expiry re-asserts
  instead of releasing (patch 8)
- fix: an XON/XOFF character deferred by the reconfigure-pending gate
  was never transmitted when nothing else was queued, and the re-check
  after start_tx()'s dropped lock did not cover a freshly posted
  reconfigure (patch 9)
- fix: a delay of exactly 15 bit-times - the largest the chip can
  time - was routed to the software path, because the hardware
  ceiling was computed in nanoseconds from the truncated per-bit
  time (49999995 ns where 50 ms at 300 baud needs 50000000). The
  selection now converts to bit-times first and compares against the
  field maximum, which is exact at every baud rate (patch 8)
- fix: a close() racing the after-send hold expiry could leave the
  transceiver driving the bus: shutdown's manual RTS release reaches
  the register, but the RTS output stage is clocked by the UART
  channel clock that the power-off stops - stopped too soon, the pin
  stays asserted until the next open (register confirmed released,
  pin confirmed high, in every observed case). shutdown() now gives
  the release one character time, at least 100 us, before powering
  down; measured propagation is below 50 us at 1200 baud, and the
  delay-free alternative (handing the pin to the auto-RTS engine) was
  tried and rejected on the wire - for an active-low RTS every
  register ordering of that handover drives the pin to the asserted
  level mid-sequence (patch 8)
- fix: a reconfigure moving the port onto the hardware path
  mid-envelope stranded the software envelope state: nothing reset it
  in that direction, and the TX-empty hold arming ran only on the
  software path. A later reconfigure off the hardware path trusted
  the stale state, skipped the in-flight-transfer adoption, and
  released the transceiver under the running transfer. The TX-empty
  unwind now runs on both paths, the reconfigure asserts RTS for any
  transfer it believes exists before auto-RTS is disabled, and the
  hold arms only once no transmittable data remains (patch 8)
- the seven fixes above came out of further review and hardware
  testing of v5: each was first demonstrated on the wire, then shown
  fixed, and the full regression matrix was re-run on the result
- Link to v5: https://lore.kernel.org/r/20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com

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
  reconfigure-pending gate (patch 9), both found during the per-patch
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
[2] https://lore.kernel.org/all/2026100116-saint-idealize-32cf@gregkh/

---
Tapio Reijonen (9):
      serial: max310x: don't clobber the TX break bit in set_termios
      serial: max310x: assert the transceiver during a break
      serial: max310x: centralize the RS485 transceiver programming
      serial: max310x: convert RS485 delays from milliseconds to bit-times
      serial: max310x: wait for TX to drain before powering down in shutdown
      serial: max310x: support active-low RTS on the hardware path
      serial: max310x: schedule tx_work directly from the IRQ handler
      serial: max310x: drive RTS in software when hardware delays are too short
      serial: max310x: don't transmit while an RS485 reconfigure is pending

 drivers/tty/serial/max310x.c | 583 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 549 insertions(+), 34 deletions(-)
---
base-commit: 9505146e885b1a842118aa6410f737290c4a5a32
change-id: 20260513-max310x-rs485-sw-delay-a306d783d529

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

