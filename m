Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023087.outbound.protection.outlook.com [40.107.162.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070A53E9284;
	Thu,  9 Jul 2026 08:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783586825; cv=fail; b=PQVcoTG7ojQmg3r+0x1MuEPpCO9ibpcZop8csW76Km/+UHBq7dZMyk64TbieUq7XXkhZhUDcNECYQjn2YcvUjHz1hQM3/P6cx9NQ+Z/3uwOTRfwDuzS1aAORO9EJqsXel3Zamurn8pP9qDUUrVrp3PISCKnDvg1m6XlyeW+tT/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783586825; c=relaxed/simple;
	bh=Pqj931T2EsXxnEC6dG1wsbzk7BliJ8sbeWhRGFFMxrE=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=jQcdfvPsonaWq5ZyOHIN9cr7G+nBIJHgLr65uMNWr90YVig11KI3hApkjgOsJCUcqRTXnbeqFqEzlwmIWlqakpYRMx1F38Wofg1fEdVCHRjTFJIoPlwy2dDQDT5+PDedmvdH3AqlnuH1VPUsBhDsmrjkWGxklKcm/mPqt0KuPrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=kn4fEnm6; arc=fail smtp.client-ip=40.107.162.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="kn4fEnm6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHhvYdFG19IM3bS5MNVjxfQjBjz0xP0+PdMP3UGylnyW/y+o1y6JVv08ZbangEMjbabPRO4kK/XKaczG42UBH5M13GELUbxIwcvDdKbf+YArt4wPkbOLiK7vETH9Ro6EhANjpljMMYJn8Mm/ykA0m1oT729VxEtUQU3m08LtqnAXD7Evbe30bc+ju1rwlG4LcTLZSKbZJnhuWTcxMDlRTSvTEYcxwK2ShO2a0leRuFSeE5ZwImEEYMQSLb8e3b0sT7vraeUrvfyFrT1Dt+oeqlIjubYCwPZOdbTk5B4DggbxlouduVtuI0dd0YDsaIyQByKcKmJvVqX07bhN58O+jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xq4Sh0al9+3bYZxGvSk1zl0MjbVOlXLJ+VcWkQZS5Zs=;
 b=J28j09CF9N4ksoCN2TN9FCygTQnfi+5OVZfB1yPXcmtGO7m+Lq9XCQIv8hCcNY9tv2ex5XntxafhJBNCVYC3vX+YUNTVX9/cx8lz0/HY//MfhtklIfjJhV2kj970S8m9FYQ/7vkh0UmLnj74RdeJi9IL9NbET1aCO6POOKFNu4QKfDJxxa3Nx2eWg0lBoB4SQ3YViDp/JnyjzoeKIZocB+rHNVy8e8YJbE/uJqmK/+tnh+1Y2bUTS+xrC9nYmLc7VlLRNiJ4TfC2YhnJuSGFF88mf9I98NZYilvJltcOzJWqGfu4Lv3n8uwJp8h1uAnfu33YWSJF9u/goUfMP5boJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xq4Sh0al9+3bYZxGvSk1zl0MjbVOlXLJ+VcWkQZS5Zs=;
 b=kn4fEnm6daZhWxCPyr5pF+dzh5mS3kPywyl4MfVh8zSpYgx7l/yoSavtnfelSL+yxIlXrALYrozMG3oqks/jjD6XXLDdjzoDRxnq2/pJXclGXXu2HBvK1nNw5KUN/ILgxJIcxOVyJwhn72707W3r9HBoEeHz8sGHUE0DeARpcDvcSGLT8Cx2FXmJmH/bwNjlCX+GvGiZiiWJmxSvIkc7V95fLk9bMgkPhVGgv83qgNlRRon6z3Cl5kleiM25q1HF1PuksD/txl7Umm0N5QrVSClBlhFVmRhyMLY6h9m0Kz3lxBi5t3iFaZq7EoE5g94kkPf++yu/ZzJaFoRnfrpwTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by DU7PR06MB9824.eurprd06.prod.outlook.com (2603:10a6:10:5b4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 08:46:53 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 08:46:53 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Thu, 09 Jul 2026 08:46:46 +0000
Subject: [PATCH] serial: max310x: drive RTS in software when hardware
 delays are too short
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-max310x-rs485-sw-delay-v1-1-454ac10b937a@vaisala.com>
X-B4-Tracking: v=1; b=H4sIAPVfT2oC/x3MSQqEMBBA0atIrS3I0HG6irgInVILnEiBphHv3
 sHlW/x/g1BkEuiKGyKdLLxvGbos4Dv7bSLkkA1GmUo5bXH1yWqVMMqncSgXBlr8D71VVagbG5x
 pIcdHpJHTO+6H5/kD7FEBuGgAAAA=
X-Change-ID: 20260513-max310x-rs485-sw-delay-a306d783d529
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783586813; l=24043;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=Pqj931T2EsXxnEC6dG1wsbzk7BliJ8sbeWhRGFFMxrE=;
 b=PrcBks42B+m/k2J4uoHO9NzRLqvA0CqjmrUU9QH3wY92G0fVDlCIt5gCesy5FfVGeSzA321LI
 RFg8/D7kqyVBBMITIkzPgT+7HcPzJj9CMkiTKkXwrCpYtP0VehQgRU/
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3PEPF0001DBB2.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::6e9) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|DU7PR06MB9824:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e14621f-b085-422f-bcb7-08dedd96a013
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|23010399003|1800799024|366016|38350700014|18002099003|3023799007|56012099006|11063799006|6133799003|5023799004;
X-Microsoft-Antispam-Message-Info:
	WP3eitC9MiqaYYgwYTvXoqJDdrfn745/Y+xyH9xgcST+2zt75i6ajATQ007Qtb+rbTH8qYNTOaVOHTQiUeCRleRypCroAI8jGFseBNW/17fnzmf27gPRVWFrPI/BFFqB7v+SkXZwmUWZcSi/EvgBbuScZvu91nL/OC5gWWr8bqIUJYf4sX6XC3C3U4ABF2nx/Z5eoMinEUosZ2i2OJQsdGnObXf7t79gz09Tsv5w+KXdNLoGGvAU3zIlUB6Is6qMromc83Xs0QBdN1cx9GtB15d/7l+ElQBlb+tTZ6tbuCdOwdokrZlR1X27xNRvfdEACtyEivgs/9HMOU2tQPm3wNB60xuE5N/gqZI4r36ZeXcDQquU2kowJvuctxISd6rAtFFJ/SYs3vS5AltwoFiJwXUSxU7DcVsRwkgHBkL+1Ax7lqtY3rOblwlCnEaeOjytHcvpUUrbDpLOstRpXZFuHBYipZthrGpFWsDlWYxJ26M3hiJCf8+B2ztocAB+mBA3nP8nvpdFI5X8L2io/ILphMrk5VgY6NrOBKctjgo/kUyHXdQ7tRh2/iY5Dmci3Zk4mTxYu/uW//rXjl44R+3o8FuhVZ10i3DXM7b67sqUeAUAXrZczuzI9qp579mW4XlnsffRjDZskIZPyqPFB0BRd06sIL37pDJdt+Rs/OnXCQ5A9wKvM4E2q6WM6o7QBrPJQDGVRle3K/2Rdfm6K3N57H4QtH02mzhYDj5D8kUqEzg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(23010399003)(1800799024)(366016)(38350700014)(18002099003)(3023799007)(56012099006)(11063799006)(6133799003)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjdOTGgraml3cmZHZWExSzlveHNYOFQxcG9GR3lWNWlUajV0dkxWZ1hmOEp3?=
 =?utf-8?B?Y3BqNTBpWldSNWhFM3NnTUxYVTNHVi82Nk9abUlOM0xQeXdtR1dlTG9TOCtD?=
 =?utf-8?B?dmlLVGlkZ01OczZRZXc2dWhhL3JQOC9hdFFkcnY2dmxNZHRzZGNlQVZKa1VL?=
 =?utf-8?B?ZEIrSk56NWVPQkxIUjlIZkNpamJ0Q09sVUExYk5wUDdydU5RZHhtVkc1MXZl?=
 =?utf-8?B?SklwSnlVcXI4Ui9lTkY1U0VNcWxkVTdsOFh0bkppclRMdnhOVWl1YU1jNSty?=
 =?utf-8?B?YTErOW84dmoxOXFaM2tSVHpXZnp4cjBYSkgxMGVWMG1QYlpINjVpeklZODlq?=
 =?utf-8?B?dzhPb1V1dUtRTkhJajNoNWhIWHlBRDU4Vm9MZHZUTW5pbnFqcEdtY2VOZUZE?=
 =?utf-8?B?eFFhb0IzdG9uTEdQOVcvQUorY3hha1diVlpNZm05QXBtRVJZd05QTnFVd2RI?=
 =?utf-8?B?UGd4MkFlVkprRnBpcFVkMldoS2hLMDlGVVE1UjBqVkc2TWFMcUl2amlrWHlQ?=
 =?utf-8?B?emVOdiszK2JkOGU2bzVSVHVEOHA4NDV2RTRzeEhGcmMvUDdBdVRVRmtUeUJJ?=
 =?utf-8?B?Q00zNjEzdWt5ZzcxM2pnN3RxajRSbVdRRU9rREJhNTd0V0xTTXVoNXREQWN1?=
 =?utf-8?B?dERHZmZ5M29YVFhGL2JQcGkzTGo4VlUwOHBJclA3UGtpbjUvcnlhd3dZRi83?=
 =?utf-8?B?NkNtZ21Dclc5MjV0YU5NbHB1elZ3OU9mTFNNaVRSQnh0T1M4d2p2UzREYUl2?=
 =?utf-8?B?aG1lR0pXRW9vUUtqd0NhUHpZRGlFQjc1N1BXcVAwMWpBOXVhaldzWHdiZHc5?=
 =?utf-8?B?S0xlQzVJZ2gvamU0dlNkUENiZDB4V3NZSjh2SHJRMktMN0s0WHI2M04xS1la?=
 =?utf-8?B?ZS81Zi9xRjRNTUZIcnBVVmdRNDFVaEhoaStNRkNiVlJHeFpFK1B3c2xiVmR6?=
 =?utf-8?B?NElHaUlST0RVc1NMcHJhVzFIcHNZTDl6U0xjdUtEdDRnMFQwaGlWa2hEZzdr?=
 =?utf-8?B?bG5Zb3lIaFJYU0wvNWE4TDg3VjRYU2dJRld6YUttdUhhZ1d1MFFPbSsvUlRa?=
 =?utf-8?B?MVl6TGpCdjcyZ0pXTEdMUUpST1pJQlIreDBBUk9CT2VJWVlqemJ6WnNWVkxm?=
 =?utf-8?B?dVJLaitOdHhnOEIrUW1QSlBHUlFZQVJBM0I0VE44V3J6dlIxTXkwTndhWTRh?=
 =?utf-8?B?U09VeWxUVGF6d3VwQzVjdCtZblphajhzOFhuNlhqK2d3WE5XZ3pOVTd3eFpJ?=
 =?utf-8?B?U3Qzb0VFMmNXd2NTN1FtdzJrbTdqQTQ1SGIyRU9Bb2pON1NGbTRKU2pzRitl?=
 =?utf-8?B?TVBhTDduVW01bXhMeDM3NW9zS2hkSWpVRjJ6UVBpdEltTUxreVhGdjdNV3ZK?=
 =?utf-8?B?aHlCTjVreThQd3VrOGprM3RDSUhUZytPNFlUUjJEZTBadUVGVmJtYTQzZGdY?=
 =?utf-8?B?anhXQm9leGcrc1NveUYzVUZCdkZTNDdJdGpnVkpZa3dpYzk1am5IZXBDaElw?=
 =?utf-8?B?ckhZYTRXTDNEblNacDJzV0E1ditkTml0WVN6Y2E3d1RCZi9ja0ttZkxpRkxa?=
 =?utf-8?B?aEZrNmYzTTJVRXoxa0xOYjgzOEc1REhkWWZVamxFNHMwalJ0MXIySHdUUVd6?=
 =?utf-8?B?YkVZMmwwc1d2SENPMXNZU0hNYkR2cXNEbFc1cUpKQmI4Z1VqaGc3QWZrUXJL?=
 =?utf-8?B?dHIrZ1IyQzZRZTZDUFRoOCtzNU1OZnJkSmFRNHAveW4rck9FWTlaZm1jdm5n?=
 =?utf-8?B?eXViZ1lML2FZMnFFV01VcnlqdUN0MEh4N3RVa0lJck9PWnpaQ21MWkRpam1z?=
 =?utf-8?B?SXo0SS9nOU04TlYvNk9taXFtd0FPSlBtRmNoQjNWM01XOXdVVlhGenB1SzE2?=
 =?utf-8?B?TXdQM255STFoai90WDFrWGhrSHBIdzFBOHhkZ3dhSEtuTHdQaU9lWVdvSFBM?=
 =?utf-8?B?bjBNUzhKb3Y2eUh2UTF5OUtMUHl0ekUvT1JtSWl6Z3NKYjV3TThJeitETVZQ?=
 =?utf-8?B?enBBbUd0Y0l6dE02TjNtZnM4SFJjbkNJZURRYXc0aC9zWnJRUm9POTE4MDFu?=
 =?utf-8?B?c2hNU3hvZitmazVrTiszTFYrRTNYZFphZTFQY1JNTE5SWWJZUFVkcU1tOWMz?=
 =?utf-8?B?ZTBIZmZ4akNrYWF6SkhHSFdsQzk1MkdiTEErYzR6VHlPQkZaQ3c0a0IzYTFG?=
 =?utf-8?B?V1A2eWYyaEFEQXNXRnovTEs3YitJRXNubk9HU2lBT3VBb0tnZDRNVEVYcWxL?=
 =?utf-8?B?RWllbjZGMDRVOUdrSThIT3JDTzBXVVJQY1RCTkk4UG0yYTdNWnVTRHAxSGJn?=
 =?utf-8?B?N29ya3JrTjJhTDZoZVhLUzFLdFVQTXd3TU8vbldaaXQ2SUp2NEtlS0JObjhB?=
 =?utf-8?Q?70eQjXld+SKW1B/c=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e14621f-b085-422f-bcb7-08dedd96a013
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 08:46:53.4821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CDv9U3xWMt0dWx463AcEXZPxW+v0rJImWSGNOXwotsaHwdmmzCrHwmOqKsPrmj+4NFHaIKUvAqOrEHVoZIkwp6H6h1gzqViclIsLgzXaLLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR06MB9824

max310x_rs485_config() rejected delay_rts_before_send and
delay_rts_after_send values larger than 0x0f with -ERANGE, which made
the UART core wipe port->rs485 in uart_rs485_config() and silently
disable RS485. The HDPIXDELAY register holds the setup and hold
delays in 4-bit-per-direction bit-times, so even values inside that
range only encode a fraction of a millisecond at typical baud rates
and the chip's hardware auto-RTS path cannot cover the millisecond
range the kernel UART layer expresses.

Add a software-driven RTS path that takes over whenever the hardware
cannot represent the requested timing:

  * Cache the current baud rate and the per-character on-the-wire
    duration in max310x_set_termios() so the decision below can use
    them.
  * max310x_set_rts_ctl_params() picks software or hardware timing:
      - software if delay_rts_before_send or delay_rts_after_send in
        milliseconds exceeds what 15 bit-times can encode at the
        current baud, or if the requested RTS polarity cannot be
        produced by the chip's auto-RTS engine;
      - hardware otherwise, converting the millisecond delays to
        bit-times (rounded up, capped at 15) and programming
        MODE1.TRNSCVCTRL plus IRDA.RTSINVERT to drive RTS with the
        requested polarity. RTS is left deasserted at idle; the chip's
        auto-RTS engine owns the transceiver during transmission.
  * When software timing is selected the RTS envelope is driven by a
    single hrtimer, re-used for the before- and after-send phases (the
    phase is tracked in tx_state), plus a single rts_work that toggles
    RTS. max310x_start_tx() queues rts_work to assert RTS; rts_work
    arms the timer for the before-send delay only after the RTS edge is
    on the wire, so data is never shifted before RTS is asserted. The
    timer expiry kicks tx_work to fill the chip FIFO; once that FIFO is
    empty (max310x_handle_tx()) the same timer is re-armed for one
    character duration plus the after-send delay, after which rts_work
    releases RTS. Using one timer and one rts_work keeps the before-
    and after-send phases mutually exclusive and the RTS toggles
    ordered, which matters for back-to-back writes and on SMP.
  * max310x_shutdown() waits for transmission to finish before powering
    the port down, so close() cannot truncate the final byte.
    On the software path it waits out any in-flight RTS envelope
    (bounded) so the last character and its after-send hold complete.
    On the hardware path it lets the chip FIFO drain and the last
    character clock out of the shift register: tx_empty only reports
    the TX FIFO empty, not the shift register, so without this the
    port could be powered down mid-character.
  * max310x_rs485_config() now clamps the delays to the UART core's
    RS485_MAX_RTS_DELAY (100 ms) instead of rejecting them, and
    cancels the pending delay timer when RS485 is disabled.
  * max310x_break_ctl() drives RTS manually for the break duration. The
    chip's auto-RTS only asserts the transceiver while FIFO data is
    shifting out, and a break is not FIFO data, so on the hardware path
    it also disables auto-RTS for the break and restores it when the
    break ends.

Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 403 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 369 insertions(+), 34 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 022502986c5fcf1ff4de9328746ddc71677be730..7ab7b2ccecb5dc885a2e74441aef7002cf4039f6 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gpio/driver.h>
+#include <linux/hrtimer.h>
 #include <linux/i2c.h>
 #include <linux/kconfig.h>
 #include <linux/module.h>
@@ -162,6 +163,11 @@
 /* IRDA register bits */
 #define MAX310X_IRDA_IRDAEN_BIT		(1 << 0) /* IRDA mode enable */
 #define MAX310X_IRDA_SIR_BIT		(1 << 1) /* SIR mode enable */
+#define MAX310X_IRDA_RTSINVERT_BIT	(1 << 2) /* Invert auto RTS output */
+
+/* HDPIXDELAY accessor macros */
+#define MAX310X_HDPIXDELAY_SETUP(val)	(((val) & 0x0f) << 4)
+#define MAX310X_HDPIXDELAY_HOLD(val)	((val) & 0x0f)
 
 /* Flow control trigger level register masks */
 #define MAX310X_FLOWLVL_HALT_MASK	GENMASK(3, 0) /* Flow control halt level */
@@ -290,12 +296,27 @@ struct max310x_devtype {
 	u8	power_bit; /* Bit for sleep or power-off mode (active high). */
 };
 
+/* Software-timed RS485 RTS envelope phase */
+enum max310x_tx_state {
+	MAX310X_TX_OFF,			/* idle, RTS released */
+	MAX310X_TX_WAIT_BEFORE_SEND,	/* RTS asserted, before-send delay */
+	MAX310X_TX_SEND,		/* data in flight, awaiting TX-empty */
+	MAX310X_TX_WAIT_AFTER_SEND,	/* data drained, after-send hold */
+};
+
 struct max310x_one {
 	struct uart_port	port;
 	struct work_struct	tx_work;
 	struct work_struct	md_work;
 	struct work_struct	rs_work;
+	struct work_struct	rts_work;
+	struct hrtimer		tx_delay_tmr;
 	struct regmap		*regmap;
+	ktime_t			one_character_duration;
+	unsigned int		baud;
+	bool			sw_rts_during_tx;
+	bool			cancel_tx_delay_tmr;
+	enum max310x_tx_state	tx_state;
 
 	u8 rx_buf[MAX310X_FIFO_SIZE];
 };
@@ -324,6 +345,21 @@ static struct uart_driver max310x_uart = {
 
 static DECLARE_BITMAP(max310x_lines, MAX310X_UART_NRMAX);
 
+static ktime_t max310x_get_character_duration(const struct ktermios *termios,
+					      unsigned int baud)
+{
+	const unsigned int startstop = 2;
+	const unsigned int char_bits = startstop +
+		(((termios->c_cflag & CSIZE) == CS5) ? 5 : 0) +
+		(((termios->c_cflag & CSIZE) == CS6) ? 6 : 0) +
+		(((termios->c_cflag & CSIZE) == CS7) ? 7 : 0) +
+		(((termios->c_cflag & CSIZE) == CS8) ? 8 : 0) +
+		((termios->c_cflag & PARENB) ? 1 : 0) +
+		((termios->c_cflag & CSTOPB) ? 1 : 0);
+
+	return us_to_ktime(DIV_ROUND_UP(USEC_PER_SEC * char_bits, baud));
+}
+
 static u8 max310x_port_read(struct uart_port *port, u8 reg)
 {
 	struct max310x_one *one = to_max310x_port(port);
@@ -680,6 +716,39 @@ static void max310x_batch_read(struct uart_port *port, u8 *rxbuf, unsigned int l
 	regmap_noinc_read(one->regmap, MAX310X_RHR_REG, rxbuf, len);
 }
 
+static void max310x_rts_ctl(struct uart_port *port, bool rts_state)
+{
+	max310x_port_update(port, MAX310X_LCR_REG, MAX310X_LCR_RTS_BIT,
+			    rts_state ? MAX310X_LCR_RTS_BIT : 0);
+}
+
+/*
+ * Drive the RS485 RTS line to match the current tx_state. This is the only
+ * place that touches RTS, and it reads tx_state rather than a fixed
+ * assert/deassert intent, so a newer assert is never clobbered by a stale
+ * release. It also arms the before-send timer once the RTS edge is on the wire,
+ * so data is never shifted before RTS is asserted.
+ */
+static void max310x_rts_work_proc(struct work_struct *ws)
+{
+	struct max310x_one *one = container_of(ws, struct max310x_one, rts_work);
+	struct uart_port *port = &one->port;
+	unsigned long flags;
+	bool rts_on = READ_ONCE(one->tx_state) != MAX310X_TX_OFF;
+
+	max310x_rts_ctl(port, rts_on ?
+			(port->rs485.flags & SER_RS485_RTS_ON_SEND) :
+			(port->rs485.flags & SER_RS485_RTS_AFTER_SEND));
+
+	spin_lock_irqsave(&port->lock, flags);
+	if (READ_ONCE(one->tx_state) == MAX310X_TX_WAIT_BEFORE_SEND &&
+	    !one->cancel_tx_delay_tmr && !hrtimer_active(&one->tx_delay_tmr))
+		hrtimer_start(&one->tx_delay_tmr,
+			      ms_to_ktime(port->rs485.delay_rts_before_send),
+			      HRTIMER_MODE_REL);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
 static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
 {
 	struct max310x_one *one = to_max310x_port(port);
@@ -776,6 +845,75 @@ static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
 	tty_flip_buffer_push(&port->state->port);
 }
 
+static enum hrtimer_restart max310x_tmr_tx(struct hrtimer *timer)
+{
+	struct max310x_one *one = container_of(timer, struct max310x_one,
+					       tx_delay_tmr);
+	unsigned long flags;
+
+	spin_lock_irqsave(&one->port.lock, flags);
+	if (!one->cancel_tx_delay_tmr) {
+		if (READ_ONCE(one->tx_state) == MAX310X_TX_WAIT_AFTER_SEND) {
+			/* After-send hold elapsed: drop RTS via the rts worker. */
+			WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
+			schedule_work(&one->rts_work);
+		} else {
+			WRITE_ONCE(one->tx_state, MAX310X_TX_SEND);
+			schedule_work(&one->tx_work);
+		}
+	}
+	spin_unlock_irqrestore(&one->port.lock, flags);
+
+	return HRTIMER_NORESTART;
+}
+
+static void max310x_delayed_stop_tx(struct uart_port *port)
+{
+	struct max310x_one *one = to_max310x_port(port);
+	unsigned long flags;
+	unsigned int txlvl;
+
+	if (READ_ONCE(one->tx_state) == MAX310X_TX_OFF)
+		return;
+
+	/*
+	 * The kfifo can be empty while the chip TX FIFO is still draining, so arm
+	 * the after-send hold only once the chip FIFO is empty too - the TX-empty
+	 * interrupt re-invokes us then. Otherwise the hold starts early and RTS
+	 * drops mid-character, clipping the last byte(s).
+	 */
+	txlvl = max310x_port_read(port, MAX310X_TXFIFOLVL_REG);
+	if (txlvl)
+		return;
+
+	/*
+	 * Runs from the tx_work worker, which does not hold port->lock. Take it
+	 * here so cancel_tx_delay_tmr, tx_state and the timer are updated
+	 * atomically against start_tx() and the timer callback.
+	 */
+	spin_lock_irqsave(&one->port.lock, flags);
+	one->cancel_tx_delay_tmr = false;
+	/*
+	 * Do not arm the after-send hold if a before-send phase is pending: a
+	 * new burst's start_tx() may have set WAIT_BEFORE_SEND while its timer is
+	 * not yet armed (max310x_rts_work_proc() arms it after the RTS edge).
+	 * That burst owns the line and runs its own envelope.
+	 */
+	if (READ_ONCE(one->tx_state) != MAX310X_TX_WAIT_BEFORE_SEND &&
+	    !hrtimer_active(&one->tx_delay_tmr)) {
+		/*
+		 * Add one character for the byte still in the shift register -
+		 * TX-empty fires as it enters, not as it leaves.
+		 */
+		ktime_t delay = ktime_add_ms(one->one_character_duration,
+					     port->rs485.delay_rts_after_send);
+
+		WRITE_ONCE(one->tx_state, MAX310X_TX_WAIT_AFTER_SEND);
+		hrtimer_start(&one->tx_delay_tmr, delay, HRTIMER_MODE_REL);
+	}
+	spin_unlock_irqrestore(&one->port.lock, flags);
+}
+
 static void max310x_handle_tx(struct uart_port *port)
 {
 	struct tty_port *tport = &port->state->port;
@@ -787,8 +925,13 @@ static void max310x_handle_tx(struct uart_port *port)
 		return;
 	}
 
-	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))
+	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
+		struct max310x_one *one = to_max310x_port(port);
+
+		if (one->sw_rts_during_tx)
+			max310x_delayed_stop_tx(port);
 		return;
+	}
 
 	/*
 	 * It's a circ buffer -- wrap around.
@@ -813,11 +956,48 @@ static void max310x_handle_tx(struct uart_port *port)
 		uart_write_wakeup(port);
 }
 
+/*
+ * Begin a software-timed RTS envelope: set the before-send phase and queue the
+ * rts worker to assert RTS. tx_state is set synchronously here (start_tx() holds
+ * port.lock) so close()/shutdown can see an envelope is in flight; rts_work then
+ * asserts RTS and arms the before-send timer (see there).
+ */
+static void max310x_delayed_start_tx(struct uart_port *port)
+{
+	struct max310x_one *one = to_max310x_port(port);
+
+	WRITE_ONCE(one->tx_state, MAX310X_TX_WAIT_BEFORE_SEND);
+	one->cancel_tx_delay_tmr = false;
+	schedule_work(&one->rts_work);
+}
+
+/* called with port.lock taken and irqs off */
 static void max310x_start_tx(struct uart_port *port)
 {
 	struct max310x_one *one = to_max310x_port(port);
 
-	schedule_work(&one->tx_work);
+	if (one->sw_rts_during_tx) {
+		/*
+		 * The before- and after-send phases share one delay timer. If an
+		 * after-send release is pending, cancel it before starting a new
+		 * TX so the just-asserted RTS is not yanked; re-arming the timer
+		 * for the before-send phase then supersedes the release.
+		 */
+		int res = 0;
+
+		if (READ_ONCE(one->tx_state) == MAX310X_TX_WAIT_AFTER_SEND)
+			res = hrtimer_try_to_cancel(&one->tx_delay_tmr);
+		if (unlikely(res == -1)) {
+			one->cancel_tx_delay_tmr = true;
+			spin_unlock(&one->port.lock);
+			hrtimer_cancel(&one->tx_delay_tmr);
+			spin_lock(&one->port.lock);
+		}
+
+		max310x_delayed_start_tx(port);
+	} else {
+		schedule_work(&one->tx_work);
+	}
 }
 
 static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
@@ -843,7 +1023,7 @@ static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
 		if (rxlen)
 			max310x_handle_rx(port, rxlen);
 		if (ists & MAX310X_IRQ_TXEMPTY_BIT)
-			max310x_start_tx(port);
+			schedule_work(&s->p[portno].tx_work);
 	} while (1);
 
 	return res;
@@ -927,9 +1107,94 @@ static void max310x_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 static void max310x_break_ctl(struct uart_port *port, int break_state)
 {
+	struct max310x_one *one = to_max310x_port(port);
+
 	max310x_port_update(port, MAX310X_LCR_REG,
 			    MAX310X_LCR_TXBREAK_BIT,
 			    break_state ? MAX310X_LCR_TXBREAK_BIT : 0);
+
+	if (!(port->rs485.flags & SER_RS485_ENABLED))
+		return;
+
+	/*
+	 * Drive RTS manually for the break duration. HW auto-RTS only asserts
+	 * the transceiver while FIFO data is shifting out, and a break is not
+	 * FIFO data, so on the HW path also disable auto-RTS for the break and
+	 * restore it when the break ends.
+	 */
+	if (!one->sw_rts_during_tx)
+		max310x_port_update(port, MAX310X_MODE1_REG,
+				    MAX310X_MODE1_TRNSCVCTRL_BIT,
+				    break_state ? 0 : MAX310X_MODE1_TRNSCVCTRL_BIT);
+
+	max310x_rts_ctl(port, break_state);
+}
+
+/*
+ * Pick hardware or software RTS timing for the current port. The chip can
+ * deliver up to 15 bit-times of setup/hold delay via HDPIXDELAY; anything
+ * longer (or any RTS polarity the chip cannot produce automatically) must
+ * be driven by software via tx_delay_tmr and rts_work.
+ */
+static void max310x_set_rts_ctl_params(struct max310x_one *one)
+{
+	const unsigned int max_bit_dly = 15;
+	struct uart_port *port = &one->port;
+	unsigned long max_hw_delay_ns = 0;
+	unsigned int setup = 0, hold = 0;
+	u8 mode1 = 0, irda = 0;
+
+	one->sw_rts_during_tx = false;
+
+	if (!(port->rs485.flags & SER_RS485_ENABLED))
+		goto out;
+
+	if (one->baud)
+		max_hw_delay_ns = NSEC_PER_SEC / one->baud * max_bit_dly;
+
+	if ((u64)port->rs485.delay_rts_before_send * NSEC_PER_MSEC > max_hw_delay_ns ||
+	    (u64)port->rs485.delay_rts_after_send  * NSEC_PER_MSEC > max_hw_delay_ns ||
+	    !!(port->rs485.flags & SER_RS485_RTS_ON_SEND) ==
+	    !!(port->rs485.flags & SER_RS485_RTS_AFTER_SEND))
+		one->sw_rts_during_tx = true;
+
+	if (one->sw_rts_during_tx) {
+		setup = 0;
+		hold  = 0;
+		goto out;
+	}
+
+	/* Convert milliseconds to bit-times, rounding up. */
+	setup = DIV_ROUND_UP(one->baud * port->rs485.delay_rts_before_send,
+			     MSEC_PER_SEC);
+	hold  = DIV_ROUND_UP(one->baud * port->rs485.delay_rts_after_send,
+			     MSEC_PER_SEC);
+	setup = min(setup, max_bit_dly);
+	hold  = min(hold,  max_bit_dly);
+
+out:
+	max310x_port_write(port, MAX310X_HDPIXDELAY_REG,
+			   MAX310X_HDPIXDELAY_SETUP(setup) |
+			   MAX310X_HDPIXDELAY_HOLD(hold));
+
+	if (port->rs485.flags & SER_RS485_ENABLED) {
+		if (one->sw_rts_during_tx) {
+			max310x_rts_ctl(port,
+					port->rs485.flags &
+					SER_RS485_RTS_AFTER_SEND);
+		} else {
+			mode1 = MAX310X_MODE1_TRNSCVCTRL_BIT;
+			if (!(port->rs485.flags & SER_RS485_RTS_ON_SEND))
+				irda = MAX310X_IRDA_RTSINVERT_BIT;
+		}
+	} else {
+		max310x_rts_ctl(port, 0);
+	}
+
+	max310x_port_update(port, MAX310X_MODE1_REG,
+			    MAX310X_MODE1_TRNSCVCTRL_BIT, mode1);
+	max310x_port_update(port, MAX310X_IRDA_REG,
+			    MAX310X_IRDA_RTSINVERT_BIT, irda);
 }
 
 static void max310x_set_termios(struct uart_port *port,
@@ -1042,38 +1307,55 @@ static void max310x_set_termios(struct uart_port *port,
 
 	/* Update timeout according to new baud rate */
 	uart_update_timeout(port, termios->c_cflag, baud);
+
+	/*
+	 * Cache the new baud rate and the time it takes to clock out one
+	 * character so the RTS-timing decision in max310x_set_rts_ctl_params()
+	 * and the post-TX delay in max310x_delayed_stop_tx() can use them.
+	 */
+	to_max310x_port(port)->baud = baud;
+	to_max310x_port(port)->one_character_duration =
+		max310x_get_character_duration(termios, baud);
+	max310x_set_rts_ctl_params(to_max310x_port(port));
 }
 
 static void max310x_rs_proc(struct work_struct *ws)
 {
 	struct max310x_one *one = container_of(ws, struct max310x_one, rs_work);
-	unsigned int delay, mode1 = 0, mode2 = 0;
-
-	delay = (one->port.rs485.delay_rts_before_send << 4) |
-		one->port.rs485.delay_rts_after_send;
-	max310x_port_write(&one->port, MAX310X_HDPIXDELAY_REG, delay);
+	unsigned int mode2 = 0;
 
-	if (one->port.rs485.flags & SER_RS485_ENABLED) {
-		mode1 = MAX310X_MODE1_TRNSCVCTRL_BIT;
+	max310x_set_rts_ctl_params(one);
 
-		if (!(one->port.rs485.flags & SER_RS485_RX_DURING_TX))
-			mode2 = MAX310X_MODE2_ECHOSUPR_BIT;
-	}
+	if (one->port.rs485.flags & SER_RS485_ENABLED &&
+	    !(one->port.rs485.flags & SER_RS485_RX_DURING_TX))
+		mode2 = MAX310X_MODE2_ECHOSUPR_BIT;
 
-	max310x_port_update(&one->port, MAX310X_MODE1_REG,
-			MAX310X_MODE1_TRNSCVCTRL_BIT, mode1);
 	max310x_port_update(&one->port, MAX310X_MODE2_REG,
-			MAX310X_MODE2_ECHOSUPR_BIT, mode2);
+			    MAX310X_MODE2_ECHOSUPR_BIT, mode2);
 }
 
+/* called with port.lock taken and irqs off */
 static int max310x_rs485_config(struct uart_port *port, struct ktermios *termios,
 				struct serial_rs485 *rs485)
 {
 	struct max310x_one *one = to_max310x_port(port);
 
-	if ((rs485->delay_rts_before_send > 0x0f) ||
-	    (rs485->delay_rts_after_send > 0x0f))
-		return -ERANGE;
+	rs485->delay_rts_before_send = min(rs485->delay_rts_before_send, 100U);
+	rs485->delay_rts_after_send  = min(rs485->delay_rts_after_send,  100U);
+
+	/*
+	 * Make sure no SW-timed RTS toggle survives an RS485 disable, even
+	 * if the delay timer happens to be running right now.
+	 */
+	if (!(rs485->flags & SER_RS485_ENABLED)) {
+		one->cancel_tx_delay_tmr = true;
+		if (hrtimer_try_to_cancel(&one->tx_delay_tmr) == -1) {
+			spin_unlock(&port->lock);
+			hrtimer_cancel(&one->tx_delay_tmr);
+			spin_lock(&port->lock);
+		}
+		WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
+	}
 
 	port->rs485 = *rs485;
 
@@ -1084,6 +1366,7 @@ static int max310x_rs485_config(struct uart_port *port, struct ktermios *termios
 
 static int max310x_startup(struct uart_port *port)
 {
+	struct max310x_one *one = to_max310x_port(port);
 	unsigned int val;
 
 	max310x_power(port, 1);
@@ -1098,21 +1381,20 @@ static int max310x_startup(struct uart_port *port)
 	max310x_port_update(port, MAX310X_MODE2_REG,
 			    MAX310X_MODE2_FIFORST_BIT, 0);
 
-	/* Configure mode1/mode2 to have rs485/rs232 enabled at startup */
-	val = (clamp(port->rs485.delay_rts_before_send, 0U, 15U) << 4) |
-		clamp(port->rs485.delay_rts_after_send, 0U, 15U);
-	max310x_port_write(port, MAX310X_HDPIXDELAY_REG, val);
-
-	if (port->rs485.flags & SER_RS485_ENABLED) {
-		max310x_port_update(port, MAX310X_MODE1_REG,
-				    MAX310X_MODE1_TRNSCVCTRL_BIT,
-				    MAX310X_MODE1_TRNSCVCTRL_BIT);
+	/*
+	 * Configure RTS timing (HW auto-RTS vs software-driven) and the
+	 * RS485/RS232 mode bits. Don't hardcode HW auto-RTS here - let
+	 * max310x_set_rts_ctl_params() pick HW or SW per the configured
+	 * delays, otherwise the chip's auto-RTS would override the
+	 * software RTS hold and the after-send delay is lost.
+	 */
+	max310x_set_rts_ctl_params(one);
 
-		if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
-			max310x_port_update(port, MAX310X_MODE2_REG,
-					    MAX310X_MODE2_ECHOSUPR_BIT,
-					    MAX310X_MODE2_ECHOSUPR_BIT);
-	}
+	if (port->rs485.flags & SER_RS485_ENABLED &&
+	    !(port->rs485.flags & SER_RS485_RX_DURING_TX))
+		max310x_port_update(port, MAX310X_MODE2_REG,
+				    MAX310X_MODE2_ECHOSUPR_BIT,
+				    MAX310X_MODE2_ECHOSUPR_BIT);
 
 	/*
 	 * Configure flow control levels:
@@ -1134,9 +1416,54 @@ static int max310x_startup(struct uart_port *port)
 
 static void max310x_shutdown(struct uart_port *port)
 {
+	struct max310x_one *one = to_max310x_port(port);
+
+	/*
+	 * Drain any in-flight software-timed RTS envelope before the port is
+	 * powered down, so the last character and its after-send hold complete
+	 * - close() can reach shutdown with data still queued and a before-send
+	 * delay pending. The loop ends when the envelope does (tx_state == OFF);
+	 * the bound is just a worst-case safety cap. Then stop the timer and work
+	 * so neither runs against a powered-off port.
+	 */
+	if (one->sw_rts_during_tx) {
+		unsigned int loops = port->rs485.delay_rts_before_send +
+			    port->rs485.delay_rts_after_send +
+			    DIV_ROUND_UP_ULL((kfifo_len(&port->state->port.xmit_fifo) +
+					      port->fifosize) *
+					     ktime_to_us(one->one_character_duration),
+					     USEC_PER_MSEC);
+
+		while (READ_ONCE(one->tx_state) != MAX310X_TX_OFF && loops-- > 0)
+			fsleep(USEC_PER_MSEC);
+
+		one->cancel_tx_delay_tmr = true;
+		hrtimer_cancel(&one->tx_delay_tmr);
+		cancel_work_sync(&one->rts_work);
+		WRITE_ONCE(one->tx_state, MAX310X_TX_OFF);
+	} else {
+		/*
+		 * HW auto-RTS path: the tty layer waits for tx_empty before
+		 * close(), but tx_empty only reflects the chip TX FIFO - the
+		 * last character may still be in the transmit shift register.
+		 * Let the FIFO drain and the final character clock out before
+		 * the port is powered down, otherwise close() truncates the last
+		 * byte on the wire as the chip auto-RTS turnaround clips it.
+		 */
+		unsigned int loops = port->fifosize + 1;
+
+		while (!max310x_tx_empty(port) && loops-- > 0)
+			fsleep(ktime_to_us(one->one_character_duration));
+		fsleep(ktime_to_us(one->one_character_duration));
+	}
+
 	/* Disable all interrupts */
 	max310x_port_write(port, MAX310X_IRQEN_REG, 0);
 
+	if (one->sw_rts_during_tx)
+		max310x_rts_ctl(port,
+				port->rs485.flags & SER_RS485_RTS_AFTER_SEND);
+
 	max310x_power(port, 0);
 }
 
@@ -1291,7 +1618,8 @@ static int max310x_gpio_set_config(struct gpio_chip *chip, unsigned int offset,
 #endif
 
 static const struct serial_rs485 max310x_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX,
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
+		 SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX,
 	.delay_rts_before_send = 1,
 	.delay_rts_after_send = 1,
 };
@@ -1425,6 +1753,11 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 		INIT_WORK(&s->p[i].md_work, max310x_md_proc);
 		/* Initialize queue for changing RS485 mode */
 		INIT_WORK(&s->p[i].rs_work, max310x_rs_proc);
+		/* Initialize queue for software-driven RTS toggling */
+		INIT_WORK(&s->p[i].rts_work, max310x_rts_work_proc);
+		hrtimer_setup(&s->p[i].tx_delay_tmr, max310x_tmr_tx,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		s->p[i].tx_state = MAX310X_TX_OFF;
 	}
 
 #ifdef CONFIG_GPIOLIB
@@ -1535,6 +1868,8 @@ static void max310x_remove(struct device *dev)
 	int i;
 
 	for (i = 0; i < s->devtype->nr; i++) {
+		hrtimer_cancel(&s->p[i].tx_delay_tmr);
+		cancel_work_sync(&s->p[i].rts_work);
 		cancel_work_sync(&s->p[i].tx_work);
 		cancel_work_sync(&s->p[i].md_work);
 		cancel_work_sync(&s->p[i].rs_work);

---
base-commit: 9505146e885b1a842118aa6410f737290c4a5a32
change-id: 20260513-max310x-rs485-sw-delay-a306d783d529

Best regards,
-- 
Tapio Reijonen <tapio.reijonen@vaisala.com>

