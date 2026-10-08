Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022084.outbound.protection.outlook.com [52.101.66.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1FC488D95;
	Thu,  8 Oct 2026 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791452968; cv=fail; b=Klkqu2v13Mre8lv1PAoGc+k7UiMbTe+z5eZhDSHa7c/K6Pnu7uYW0qQmuXVmTieLCuywOGqHp0T0t7PvBLGIIo+EoVyvMknzfLR2tdLya37z7FwJiBE1sLeruh9kApDqAUU0n4L1t5J8GnkD9tpRsQ+QKdWrmBJEqDca+idKBEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791452968; c=relaxed/simple;
	bh=3kdonCu35hmuvkauT762asEWUbJN8ag0JfwiwfCYHOA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HItJHrJ/fW4WU2b6SF5nuI9k17/PxoXkQ2fOO5EPpEnD0QHxa4HKpRIy2SqBkBPIJIujJ1QZ5Yc0KwLnkQC8eOQUF8raP5tI5f44omtPa2uwmp2k3Da8WsO9OZ9JpQMpPAJgJUYNXG8vhQ6zenbjk6gVKapxnqTUjkgf6vCILX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=hNWcFvJj; arc=fail smtp.client-ip=52.101.66.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="hNWcFvJj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtLKSdfuV/LHyUmalBR6MgL0YWxQjLgLja1bL+fLgIs+wWQ9gPQMkQBaVTRqUinNwozdhtWfEEWXay4LW59SK99LO1f4B8N5pRoXx1Nfws6K/ME0C9oM30lObnlgq3sD5rVbRQ0PvK9wK4vUvZf5kzybeHvJKBBnGZfOFji46HQPNGzfPv0tL/YU3ZIjnh0wMDydWDAZ4xPepYCccLq/FjEBYXuWclCpE9dAEuMtM9DP5+R0v5c7sqxp3A7jCe8q/9JDwMhjSOUnn+yoyV9H4l8sYgrwj4wGa5eLgXpjr+v3zSVd+12aLrqdjV0F1rcJ/CW152iSKW98bd3oyV0GXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkTG0Sqh9DCCtwb8sUSTbALg91GEUiVQXJqBAxUt+8c=;
 b=iqqpfBddpb/W9S9O71xOHYftWihPWt6d1SXj5kqlUqTVxIc0hmrj83KWTEfKwyR2+RHSRsJHmKkBXpXgyIuGvYsZKWgvKov2/F5CrRM3TR2Cz63k9DEzkoCNaxVU9uJ22vkvcp4G91/9vAkB0f5S97/QcKfwb9D1b7EE9YgKOWsDJGZqFtnx/EwC1lP9pVdGPN9FxVKBERiUP4L2mD6RS79XeXPdpSEjli7dvCF8pYVbVcOAfMQRIfeQOS7JyneIMKlXSoQU2dEsLi+SIkjUC70FNYxEEWvwSYVhxMLFAWKijwh+HhXCYJ7amfFZfIVRMbkVHEAKGK8L017ADZEL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkTG0Sqh9DCCtwb8sUSTbALg91GEUiVQXJqBAxUt+8c=;
 b=hNWcFvJj5n01JWRpuAjda2wX8XsMrnZtTdKCjEMlVtE/5hhaNXC5LBsE1JXNMtp59nwLBArZaqEvGbxxM6SnvcbXM4RbcnIn9JDxvken0bZl4xfjAiMIw2C+Ri8d5qLgAISYv0IT0LDBq4nQHSUWGTeOUmSMqhrgUfYifA6qAEDRrJdT6cjhT69UWVG9ZkDKS4L/HuyUvfTPPJ7dhJ6I05TTeayzL5Die7n4Piyha/OoLlgnUE8VJS9DtTqucnoFwbj3K/CN2QRQsDYLmhbk1L5aFFBd45ql0a269iJTuLsIZNn49Vo+be5g1TwsUKReRGYugag9/Myu71pFgkOh4A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by PAXPR06MB7567.eurprd06.prod.outlook.com (2603:10a6:102:dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 09:49:11 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 09:49:11 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Thu, 08 Oct 2026 09:48:32 +0000
Subject: [PATCH v8 9/9] serial: max310x: don't transmit while an RS485
 reconfigure is pending
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-max310x-rs485-sw-delay-v8-9-6ba881f81e1f@vaisala.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791452935; l=7011;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=3kdonCu35hmuvkauT762asEWUbJN8ag0JfwiwfCYHOA=;
 b=3cWcFLJKg0Z0qXlURAMtNmMSn+v1OncdIZnWneGwf+7t9wHeEHh1ZPYTemMHJGZk6cC+A3QyC
 CkOkoaKv63zBLwk0kzh+Ed6vh7z+XzYKfkROEW2scGF21dpVQDXLt+H
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
X-MS-Office365-Filtering-Correlation-Id: 439aeab0-fd2a-449e-997f-08df252162bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|23010399003|6133799003|18002099003|22082099003|10067099003|11063799006|5023799004|56012099006|38350700014;
X-Microsoft-Antispam-Message-Info:
	CDNraolBCBIH8cFsbQw6HI6axhhkPm9X3kWrruaj3vJrfeWE2yg33gXV2WSQxlUrWZUUJsr+rVaLH8eiksVIKhYa1WbhdnQZV6C8CCLp3ygbAncJ6Fo5J67ZU3Mm0RrI+UNPcY2sJXnoEhN5Ph/HyK7LhzB/8dR/QdN/NmSAZJc9V7PcbBdBzsJQBA8BDg1WOv5tgUgOTkvHhrXZLqcTvUa1Q+Ev+UDPbKGf3aSTgtDNxOhYQnvssDph31KwQM0fIQu9N840LtxibXboEUre0TWuqXQW1TU9g3qv2fmYHnDo+L1HIVPSrknbNE0HiGhJ33kssGmIv1ZhDpga6NBpqe35aJqAeq4Y8UWkbLhMtDp43Z/c6VPS+Nuiu0Eox3iFsht5YRRPXbp2xlzkHwIVLlo4Qae8XZGmqKYk6SJdaXQCbkxf7ZLJriYnNAzEHO2jk4/7nwB1PYwcR8WSKjGWpse3yDRf3u7Ur8DclAfKzKCjyIVCtp2TBeFFM5XdkgnQzLFQppbQChBik1jk8L6ox+HAh/WS/DKcO/b6c8lRVyRtsFhL+/MfS/t/oH0Ny6qRMqbMGqrUlfvtqP4hx9Un6FnZLS5/cmS8nwnrQ5i+YHQrX7ZVLGDLrgC71EA/bmD7Qse9/dNYpa0b0xeDfCvQht3IfGCWTt0VhjotobDGTQxLqJ8GnwhZIOWQK/fJ+EBpXnPjVrRXg4NkwAkEjIF5FIsNUI0CQxIccnIcSgn8qHY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(23010399003)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(5023799004)(56012099006)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDdPSG5QU240MDYxMllZMWRRWUxFRytueFMzUGlKNlViaTUvYUhGM0pkbHhu?=
 =?utf-8?B?ZGtIS29Ja2t6UDdqVkRJRm4xcmpXTEN6aFp0QUpoOFlTZTNZMHlKZXZraGZM?=
 =?utf-8?B?TVhTNlE1amJObWZBU1E5NmtDd2xNMFh4NnNOZE9aYm9vdlBHN3JtSnp3TjB4?=
 =?utf-8?B?S2hLcjU4K1htR3VteHFDWXhJakJxMXJHdUNtWEdLOVpNM29ObGZNMlNMK0JH?=
 =?utf-8?B?U09VTGRLMzFKWlN0UGw4bFk5eFBrR2xKeENXQkpjbmVQVGQwYUVEdFhmMEFh?=
 =?utf-8?B?emg4L2U3ZGJ0MURXZGtLUDEzczd5OE5zZVVVYWNtOUhvQ3prNmtPTDFpVXBT?=
 =?utf-8?B?U0JGMk0wUUhjcjRWSUZnUmloREk1Qy9xdW4vQTRQMnExYXVWaVZINnZIU05T?=
 =?utf-8?B?cm9uOWxSay9uL2UyUDZkczhPOTBvNXpoK2p2VkdTUjRhT3Z4RVpUNWRxM1NL?=
 =?utf-8?B?Q05SQ2hVcGQvUDRKM2FmMENjZzF6Y1hvalM3OVNLWVZMZUYyRjFhL2ljWFhH?=
 =?utf-8?B?ZWhsYm9pWVNRTWx3WC94aFJac1hDdUlzeGxJNnVHN3lNNWhFM3ZpdGsvNi9v?=
 =?utf-8?B?UUhtRDhoTHJRY1p3OFlYMEtjdjZrb3BGcG5nRHhmWlNYd3E0K3hrUmdFdHlT?=
 =?utf-8?B?SlIwY0lYQ0M3bGlraWZhTlROYlNEOVpWVHFoSm8yUWsxTllEVVd6VUlwL2lD?=
 =?utf-8?B?Q3d4Y01IMWV1S2FXc3hTRlFwWGpCUXNkUUUvWEFXZWNBNDVtL3dEQktFdEl4?=
 =?utf-8?B?ZDRQUjBRS3BGNWR3bElodkNMUmJPL3hHVStlb1BqZUtMT3N5bEZSL0lDNFBW?=
 =?utf-8?B?UXM4SlhLMnA0OEhZWlowWlBiYVV6ODBjbFMvb0Z1azVMMHF5cmE5ZEpJMTMw?=
 =?utf-8?B?V2F4OVBVOW50UGFkQ1VFS3plMkgxbFlrd2NzQS9ZNjluSUN2YXF4N3c2ay9v?=
 =?utf-8?B?Q1ZXQTBCRFRRU043enZXNENCTElHOVhpUS8vekVwM0dIOVRyMVorZWFCM1JD?=
 =?utf-8?B?dzBCN0RpZzBGdW5GMEhYOWxFOUpmb1RFVE1XMCtOd3ZGaTU5ZTBqV253NFp2?=
 =?utf-8?B?M25mOFZUNDgwYkRiRCsyNHBZMUxDeHNvUnNWMEcxNTI0dUMyRWs4SDhJMWhW?=
 =?utf-8?B?UVNrWjREOHBITnh3L3ZQaFFrQlFNYUJnUnJWRVBTSWhveTRlekppNnlqdjlt?=
 =?utf-8?B?Rlhwaml1L2FCalFIYm1rKzRuaGtmUUlRN1FNdVBIQzNHRnhRUU5ieDdZQ01y?=
 =?utf-8?B?QlArZTNzZldENEhHSEkyQnN6N3V5ZDRveUt6Q0I0cnV2ajlyOGpWNGVycU1Q?=
 =?utf-8?B?VlpMK2tKbWNjVkRCa2NISHg3aEpHOUI2dHd3VGlPSDJnWnUzYklBbnR1Qzk4?=
 =?utf-8?B?VFc1Qm0rTnFLYkFHZ0FSZVBVN2FGbzVPdVVTMVBLTklNOFhzay9Tb21LN0ZL?=
 =?utf-8?B?QTV1bmVLWFk3VmF0R0FsSGQzN05IK21LM211UzRaR2JWQXBCN1NFRVlkV1FE?=
 =?utf-8?B?ZzJDKzRMaElnbWlEdnM3eDlNblNYazREUERqbkZKQnA0aU5Gd2FZVGxkdENX?=
 =?utf-8?B?UGk2M2JHZXVaN2N2N01NU0R1NnFDUVVxSnkrUHpiWkdCMzNQMyttenM1TjZF?=
 =?utf-8?B?MjZFUis1T1FUSy94MnV6Y3hrdVdqWG1yTGNuOXU4Z0xUTzYyZU9ESyt2ZExW?=
 =?utf-8?B?aDRqL3pBMWtQU21zeFdlUlozMHRzQ2M5T2YzUjhxbWRwSDE2UE9rT0orOTM3?=
 =?utf-8?B?ekZxSFQzS00yTW5iTmtYTXVlS25KMU1TY2dOVzEwWkFIc09mbE1mWmpxSnJs?=
 =?utf-8?B?aGJJbTJkYWc2RExhYUVwVVBKZnNLbXg1KzB1ei9nV09HQlRURWdiZDUrV2hR?=
 =?utf-8?B?eEF1emdEYTNkcGZ4bTRsVlp2NDFZYmQxTzZkZU9VTE5kTWF2SjZzWGNRYSta?=
 =?utf-8?B?MzlKc1cza0p0anRDY3BXc3YzTDh5UjZPOFRnNzkyWjZjZWIxd2pXclRGdmhz?=
 =?utf-8?B?U2JCMzROMWJ4bGNDMXFUQ0FHbTlmZm5wdjIxVVdpMmdZNFBQdEZQOWNXZTJq?=
 =?utf-8?B?TTdIcjhOYkVkSWJ0S1NZRjlUbVFvWmRJTWJlVHdZWUdZVTFoOGxleGFYcTZ5?=
 =?utf-8?B?bnFCdHZGOWg5cDJiSm9XWFRJZVhvVWJ4TFBXTGpGNndTSHM4aSt2eUJnODZS?=
 =?utf-8?B?VmgrWlRQSXltM3pRMnFvNDJTSWV3ZjBXVEJPbVJheG05OWdmTHQ1cUEzQnRV?=
 =?utf-8?B?NG9zNnVtbVNMelhjTW1nYnpmdk0rbHo3cGkrcjFvVXVjY2M4RmtWbUtCTyti?=
 =?utf-8?B?bmQxeVFRTzVpY1ZCelZJaTlyQVR0OHVlbDY0VldzY2hXdHNDYUVjbmlzMFVj?=
 =?utf-8?Q?Pcr+leFD4dxUm8r4=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439aeab0-fd2a-449e-997f-08df252162bb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 09:49:03.5696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Stil+5tTyPnAU8Zw0xFErorJKhirrbA912EBN6ubfWh3neleFMh6ZQOYR2/wB2odSi7XpfkMh+hGKrPROEjVb18VfIwGJGwQmEhSu3LvEzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7567

TIOCSRS485 applies its register changes asynchronously: rs485_config()
stores the new configuration and schedules rs_work, which programs
HDPIXDELAY, MODE1.TRNSCVCTRL and the RTS path. A write() issued right
after the ioctl therefore transmits against the old, half-switched
state. On a single core the ordering is even deterministic: start_tx()
picks the stale path first, then rs_work reprograms the chip, then
tx_work pumps the data - with the transceiver already released. A
TIOCSRS485 switching from the hardware to the software RTS path
followed immediately by a write puts the whole transfer on the wire
with the transceiver disabled: nothing reaches the bus and no error is
reported anywhere. The inverse direction is as old as the asynchronous
reconfigure itself: enabling RS485 and writing immediately shifts the
first bytes out before rs_work has enabled the chip's auto-RTS.

Defer instead: rs485_config() marks the reconfigure pending under
port->lock, start_tx() leaves the data in the kfifo while the mark is
set, and rs_work restarts the transmission itself once the new
configuration is fully applied. The rs485-disable path's direct
tx_work kick is replaced by the same mechanism, which also orders that
flush after the reconfigure instead of before it.

The restart kick also checks port->x_char: uart_send_xchar() reaches
start_tx() too, and a lone x_char deferred by the pending gate leaves
the kfifo empty, so the kick would otherwise skip it and nothing else
would ever send it - an idle chip FIFO raises no TXEMPTY interrupt.
And start_tx() re-checks the pending mark after the
hrtimer_try_to_cancel(-1) path retakes the dropped lock, mirroring the
tx_teardown re-check there: a TIOCSRS485 posted inside that window
would otherwise let the transmission proceed on the stale path.

rs_work takes port->lock for that restart through
uart_port_lock_irqsave(): start_tx() may drop and retake the lock
through the uart_port API on its hrtimer_try_to_cancel(-1) path, and a
raw spinlock guard around the call would unbalance the nbcon console
handling underneath.

The restart also rewinds a send state adopted for the deferred write
itself: set_rts_ctl_params() cannot tell data the pending gate
deferred apart from an in-flight transfer's refill by the xmit buffer
alone, and a deferred write pumped in the adopted send phase would
skip the configured before-send delay. With the chip FIFO empty the
adopted state can only be the deferred write: rewind it and let the
restart run the full envelope.

The chip-FIFO check for that rewind is deliberately lock-free, so a
TX-empty refill can land between the read and the lock and the rewind
can hit a live envelope. The consequence is bounded: the rewind runs
under port->lock in a state the RTS worker reads as asserted, so the
envelope pauses one before-send delay with the transceiver held - the
same pause the unconditional rewind produced before patch 8's guard.

Fixes: 5bdb48b501e8 ("serial: max310x: Fix RS485 handling")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 51 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 5fdb9dfca6027ff0a9284ed994000a5d7587408c..833ab4d461235d89438b1a7c84c46609fff64453 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -319,6 +319,7 @@ struct max310x_one {
 	bool			sw_rts_during_tx;
 	bool			cancel_tx_delay_tmr;
 	bool			tx_teardown;	/* envelope being torn down */
+	bool			rs485_pending;	/* rs_work not yet applied */
 	bool			tx_break;	/* break_ctl() owns the transceiver */
 	enum max310x_tx_state	tx_state;
 
@@ -979,6 +980,16 @@ static void max310x_start_tx(struct uart_port *port)
 	if (one->tx_teardown)
 		return;
 
+	/*
+	 * An RS485 reconfigure is scheduled but not applied yet: transmitting
+	 * now would use the old path against half-programmed registers - a
+	 * TIOCSRS485 switching paths followed immediately by a write puts the
+	 * data on the wire with the transceiver released. Leave the data in
+	 * the kfifo; rs_work restarts TX once the configuration is applied.
+	 */
+	if (one->rs485_pending)
+		return;
+
 	if (READ_ONCE(one->sw_rts_during_tx)) {
 		/*
 		 * The before- and after-send phases share one delay timer. If an
@@ -997,9 +1008,10 @@ static void max310x_start_tx(struct uart_port *port)
 			uart_port_lock(port);
 			/*
 			 * The lock was dropped: a teardown may have run to
-			 * completion meanwhile. Re-check before starting.
+			 * completion or a reconfigure may have been posted
+			 * meanwhile. Re-check before starting.
 			 */
-			if (one->tx_teardown)
+			if (one->tx_teardown || one->rs485_pending)
 				return;
 		}
 
@@ -1445,6 +1457,8 @@ static void max310x_rs_proc(struct work_struct *ws)
 {
 	struct max310x_one *one = container_of(ws, struct max310x_one, rs_work);
 	unsigned int mode2 = 0;
+	unsigned long flags;
+	bool chip_tx_empty;
 
 	/*
 	 * Serialize against break_ctl() and set_termios(), which run under
@@ -1465,6 +1479,31 @@ static void max310x_rs_proc(struct work_struct *ws)
 
 	max310x_port_update(&one->port, MAX310X_MODE2_REG,
 			    MAX310X_MODE2_ECHOSUPR_BIT, mode2);
+
+	/*
+	 * The configuration is applied: release any TX that start_tx()
+	 * deferred while the reconfigure was pending, now on the right
+	 * path. start_tx() can drop and retake the lock through the
+	 * uart_port API - a raw spinlock guard here would unbalance it.
+	 */
+	chip_tx_empty = !max310x_port_read(&one->port,
+					   MAX310X_TXFIFOLVL_REG);
+
+	uart_port_lock_irqsave(&one->port, &flags);
+	one->rs485_pending = false;
+	if (one->port.x_char ||
+	    !kfifo_is_empty(&one->port.state->port.xmit_fifo)) {
+		/*
+		 * A send state adopted without chip data is the deferred
+		 * write itself: restart it as a fresh envelope so the
+		 * before-send delay is honoured.
+		 */
+		if (chip_tx_empty &&
+		    READ_ONCE(one->tx_state) == MAX310X_TX_SEND)
+			WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
+		max310x_start_tx(&one->port);
+	}
+	uart_port_unlock_irqrestore(&one->port, flags);
 }
 
 /* called with port.lock taken and irqs off */
@@ -1490,17 +1529,11 @@ static int max310x_rs485_config(struct uart_port *port, struct ktermios *termios
 		}
 		WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
 		one->tx_teardown = false;
-		/*
-		 * The port stays alive, and a write that raced the teardown
-		 * may have left data queued with no envelope left to pump it.
-		 * Kick tx_work; RS485 is disabled, so the plain path is right.
-		 */
-		if (!kfifo_is_empty(&port->state->port.xmit_fifo))
-			schedule_work(&one->tx_work);
 	}
 
 	port->rs485 = *rs485;
 
+	one->rs485_pending = true;
 	schedule_work(&one->rs_work);
 
 	return 0;

-- 
2.47.3

