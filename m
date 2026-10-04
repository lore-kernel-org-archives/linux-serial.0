Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11023073.outbound.protection.outlook.com [52.101.83.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEC8429023;
	Sun,  4 Oct 2026 12:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116210; cv=fail; b=BNgrOSsfPxGpegUW8BSu6hr/KqU9u95DfBW7yJeyNvpg6EZKevn9i40R9E3g3zmelx9pTSUTcRc4of88bDJbcec3L4NsZRlRmYA/0/ra6dDCavnSW+l8/bIxbc4/Jw/YhT8175Nahh3cfoPDgvLgpXqUJ791TowqRmqaoqZXqnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116210; c=relaxed/simple;
	bh=b8ZBOXq3yhMDK0JCVU2YkVgHUUB7DPkJGpOBnTyJgbw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PWeOaeXSqEt3mZ5uMyLFskubjTbts/TOfT9qFfzjb5hbzcI+Ld4yiMh4K60FNKV+VpxgrCE5hT5CFYdIrBvrE7MZbNFY/D5SyiGaQCcVh7UjvTA7BXQsZw+h3QT0s2PxmoAOFnGHOlsqYrpmUFLcQB6yBk3fc4G0hBxc9JsgcWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=NWGcKXml; arc=fail smtp.client-ip=52.101.83.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="NWGcKXml"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pDkB5frlHcOPyjt0p93l1FzTKE4t5qxbrSoBosYw+YjLyGGJL+84FB8NDQHGXz9heg+W0FHwrQ6afcnE/+vJwsxsTWXL0oKjdNc+zvWEoSF7pZJ5/K9vzk/auki5Y5meIf2acRofT1z579vP/h6x7AcG5rPWqPyXibUpUgS3M57C4IGNRSZ/20oPGeaoLT0vQYFn/l358l1Hummxb6FeO6uQV9GjBP7NGT9gsIjAt29iaq9Biv8bs6GFnIMbRTnx8RUnIEN6qvBm/GUsHAK8Uqi7Ha9zTPQ77kh9tHStsNVopdtncsLPr5T2AnhgCYqlOda3g/7sM1NQizutsCSKiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KksCVbuWemW5AU9eCmpHZpnpxtieCYxtpLQpjWqnffc=;
 b=bYkAcRWVamHsncrrm7/Fmi4MMzeGGlIONs+n1em7izE7Oq8c0vRn+GfSUADFl9rfKQbcaPMIcnjJsK6Bh39Y5vFGmhiTcu2n+CTHgPQvK1V7oXsbFlqSKflfmFxSaQyYqR+1ziS/M3IeocJ9JpfgkxSRsTIMIT25arKci/vQ/NI5Vie7AHdlVaXsJa1YI6UJd6VmWnrBHaoL7wBjxsH4TGLgDRuVzvlZIu+vrE3k9ssiMSawQC/p8yP88C5Uh3wai+7G6PH5jK1gQ1+9WSOoYRjUltDOt8vP2Pxmsp+z1TttJtABYPWIHqeEs28pEtPCHMIFh1WLqU7dw27JdpQ4dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KksCVbuWemW5AU9eCmpHZpnpxtieCYxtpLQpjWqnffc=;
 b=NWGcKXmlUDys09/XfHUwGhRw89xZTZJR1se7KbJFY1krFm4zZDYCLAILA4AHCXno4z+JfxtjDT0eYLrtnbn68KUvQgUfte1+yE+lDw3UuNh9sDWcfR7c0OMs3M+BDHpZNKjCFL8tKA5WQgaRdPRe62alu/SmLTrdYSoVJPcBNffm0Qb+/vQn5vMAdSDqlJO71XZgxB1p7VfLRzYlOd7gaUaTJlmZUJua90M0qI2P8p4UcSmmxIHNupe5tzYTXyMehTko61u+OU1CHr8sF0gTmNjIJLXg7mNgN7Iu3UUUDLp5zAA8rLhipkArLCE4Vns215KeT7z/vHRV5VKFTqCrrQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by VI2PR06MB9239.eurprd06.prod.outlook.com (2603:10a6:800:221::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 12:16:35 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 12:16:34 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Sun, 04 Oct 2026 12:16:22 +0000
Subject: [PATCH v6 2/9] serial: max310x: assert the transceiver during a
 break
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-max310x-rs485-sw-delay-v6-2-3a0ef13ed9e3@vaisala.com>
References: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
In-Reply-To: <20261004-max310x-rs485-sw-delay-v6-0-3a0ef13ed9e3@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791116192; l=5854;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=b8ZBOXq3yhMDK0JCVU2YkVgHUUB7DPkJGpOBnTyJgbw=;
 b=nYNRaUeaw3aRE88m7WSY5K9Zc4YzXP3uCFJRFxwfCIr+rXl1XC0u3VyQNSS8wW+vHPFJcNpfV
 efLFfhgHR9yA02XpDt9brkJpp/jVNziDWaLKjB55EK4OWdWM6oJooL+
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
X-MS-Office365-Filtering-Correlation-Id: 25b7f131-3529-4197-8006-08df22115526
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|52116014|6133799003|18002099003|22082099003|10067099003|3023799007|56012099006|38350700014|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	OzUbG8u3hYMwfAYDtZn6uYia1aBXLTM3Bdc/na1+bqqQLHx9WaF7hzydcHlm/56ZumQGAlxZtrbBbHhGvkx6keoQqOcoZabvy79gksDGkHbyMdFhCK6KYfGrKvDZbfurNHoPKyx/OhI/XjE0Kd3OAdIuwUy9+cc04WRBArbkFv4wUDYu9sXjVH1W3FBQ6UPlaNEMb0q0kW304KEDNe86Qo+6MrfzWudgrBLMcQu7gvG1zbPWjolMJZCJB82D51yHy6BgJG115+uWNuRWuZ9r+X3TZXPXf2yNkp1U16rgffnj6sNKNeINUWpw3tud13j2gY/C5sO8kkfGcUPHPL4B4RJvKQH/s7JtPwtm0GSYhmvmC9y5vR7x+l1AhurAqH5P74JmjEqcgTK/8Z6jd41cyvfuuzT8QWyhzpJ0OZJXjFZ+TlsSKaz4nOLs9tUy6ad8tgwNPg2ikl7wms/Q+aglADtB7SAcFGlokDDVGXneCF49QYvQhrUZVgGw44NMSd8enM5vJH4i0bEsUKpYq92f9x7S4C29wGK0n0Kr7l6pzrXW/gdV7ZVRrjnWjNOu29Cwg2RvLGGfOdBLrTgMe0xp5UNwXF2KPC2tGgNvLE4KgpTQsg8ffjCUQFkJv5HhIyVa1V6EigSxkBoD+/8EZctWpjVQTwidV7MukkTnujLWqMXXhlrT+B6Elea40smOBXebGwq3SrRFn7PWACxbyocHn6Herw/cnB0t/iw0F5TkmjU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(52116014)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(56012099006)(38350700014)(5023799004)(11063799006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUtQUHVSakxzUEJCbTdweE11bHoxRmtMbFlBVEtITUloWEErOGQzNnl6dkla?=
 =?utf-8?B?aE9ZanBPbjBHK21vdjIzQTF2MGhqRmprSjY5bWllYVFnVWM3RW85UlpQRys0?=
 =?utf-8?B?SkNXMDE1ZmlzNUVSaFd5YXllSVlzS1NSa3FGSlpNMkYrcmdZK054Qmo1NTI4?=
 =?utf-8?B?cHh4NDFSUENpalkrZjltdkRZYzBFcytiNWo1R0ZXMkJQMGpoMGd1ZEowTkZT?=
 =?utf-8?B?YkJYcVd5MHl5NjMvMXhRanVFNmRwVW5aZWNHZGdwVlluczNRVWM0TVJSRnk5?=
 =?utf-8?B?M0ZpOWtXcC9JelI0WWxMSW1KT2lNOEUzTTlmdisxbUp4SStHK3VmMVY5ZGtp?=
 =?utf-8?B?RVo2TGRIMC9rTWNGWHMvUTNSYjJBczVkSVljY05oUVJlUHNQblBCT21jRm01?=
 =?utf-8?B?bDNUR1VCb0F0Q2hmQjZOblZXODhhTFhUUGloYWNoM3dWYmlBSDN2a3hjdnV4?=
 =?utf-8?B?ZFRnRXpOelBCR2NjeUxzSWJnZmRJSTd1aEl0RWVHKzcxRUNscGtlbUVlQWtY?=
 =?utf-8?B?amxOVTAveUdkOHB1QnJuQndJd0RPaUx6eDBydHl5SzFMNldGV3Q3TmpDM0dp?=
 =?utf-8?B?KzFxSkQ3Vy8yaTJxR1dBWXhDUGtKTHREa21BVmNjbFhZakRreWpNazJBRnFl?=
 =?utf-8?B?ZzM5YnFtUTNPdnI3OG9ZMTFkZjFxcmdxbWg0MnhUZ01iYjhic0RJYzRVdEo2?=
 =?utf-8?B?dEZ3N2pXUkIxa2hlSmN4V2JUeGdPZFVnU3A1ODNaVWpLWWtXSUhIWTd3eElQ?=
 =?utf-8?B?U3JhRDFvanMxSXN2cVMzVDFBMEpsb29xSGVYaUhWU0pUNTg2WEN5Y05lVXQ1?=
 =?utf-8?B?UENEanlSVXZjaHl1Tm04Y0JxUmhkL3ZDcjVPVTRGWElGVm1PVFJiL1JJakhw?=
 =?utf-8?B?SWZteVRodlVQVFdya29VcCs5Wmw4MUZheGRBVlpkZXFWbWd3N0pUdTY2SlB5?=
 =?utf-8?B?RnRPMDZPcE8vTTZ2eUFxOFowc2ZHa2xzdDErYkhCU3ZSYkhPNVA1UUY0TFp1?=
 =?utf-8?B?YzV6ekpSK3crZkNBb2xuWjV6aEYwdlUrNmMyK3p6VHkvbU5MdXRnRWNlc3JN?=
 =?utf-8?B?ZUJQRXkwUnlkZk5qNmxlOE9GVUhhQlZBcGFteXNXd1FUQ0xtcS95N21CRGlL?=
 =?utf-8?B?aS9pWWg1QWxYMHV5Ni9aNzFEV2EvSnV4ZTBndnFrR3hqQWNBYjB4QTQwZEhM?=
 =?utf-8?B?b2hqTGJJdzZVVEZob2tkSzdnNnNKVFl2a3gvdTRiYkJOV1RkZUVWS20xUXlx?=
 =?utf-8?B?OHlsM1FJcSs0OGxlV2psVkZpcUl4MDhkYkhXR2g5UUVPVjNsUUlNQkFTVWFX?=
 =?utf-8?B?VGJRVTFZM1Q0Q1ZFUi8vWDhsWDUxSFY4UjBJQjZnNEl4UCt1Lys0bkhjRGpm?=
 =?utf-8?B?djNTaXJCWlhZMWNqa01OZWZ4WFV0K1plcWdxUjJwVHdTYnJFeUU4WElpcHVw?=
 =?utf-8?B?bDdvd0lNR1pKR3pMOWNmRy96RVJTT1dTU2pkUENxMVNyVUxCZmlETkJPQzRO?=
 =?utf-8?B?WlR0enBrOVJ3a29mWFNVaFlUNVVnQ2tKMGxXbkw1SXppR0laYmwzekNXRDJk?=
 =?utf-8?B?dmFpVnhyNTZ6ZGMzcXhIcGl1dkwvcC9QNzkvbmpGQURiL1pSMnJQNk9YWWx5?=
 =?utf-8?B?TG1UbzVtZGRlaG1rMUU2M0NGY0tNdGhRZUY5cytGbUQ5Y1ZKNk96T2lRdzFH?=
 =?utf-8?B?Z08rZVBZa1BTL0xjY2JMck5ydUlEOEJ2WWptS3c4WGM5VUZWU2RkMnlqYjlw?=
 =?utf-8?B?enNWS2pLMU1NeUl3bU81UlNOaEV4cXlubjhmcjBvcFplV25YTHJXK0xiQVZV?=
 =?utf-8?B?aXQvaVdNbEgrc2xJdW1POGpyc1BCOFJFb0RsQWgrdVRuT1c0M0liWnBZSUt3?=
 =?utf-8?B?NWN4cnRYekFiQjVZSy9vcVEzbmpYQUIvQ1FHRUUrbDh5WWRpL2MxaXMySld0?=
 =?utf-8?B?VHYxOEJtbk9KMitIalNMVExUTlkrQzEzK1k3Qzg5L2xNaUJjOUt1a251czNi?=
 =?utf-8?B?c0gvWlhoRE80YThTeDZBZ0xMSytRZmxpL2Nvem92Y3N4UTJvUHlkMGRzajB2?=
 =?utf-8?B?NktFQUZDdUNZWVMvMDM3cWZmVkw5YXJiT1VhY25hUVFYN1p4bVkrT1krZ1gy?=
 =?utf-8?B?T3RHcnpsVWRucldKbkVZOEw2Y3BYeUJtYndPN0t3dnlwUGh3T0VZWTRVS0Ux?=
 =?utf-8?B?ZXlFVEJpNitxdGQ5SEVQcEFBOTRwSERLaU1RWENDM0ExWGh6UlBnNFZ4VDIx?=
 =?utf-8?B?alRZNVhBWFIxNnhHaE9wWERvaDI3a0k5ZzlaYWcvbWRSbkpKVmpXM1ZkSEph?=
 =?utf-8?B?SjAvVWNyVUpFZ0FFeENWL2NmMTRNQlNEVFNyT3NzczlIblloNndaWENlUGda?=
 =?utf-8?Q?BtkrMbxLHc0WI7v8=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b7f131-3529-4197-8006-08df22115526
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 12:16:34.9143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJI4PT8vV90h7bZumw0WsyOZRBrAy+5yBLSybhX0Agu9Foq/mz0hFe/Lj8SVmnkSnTkROewgiBHyDsW3YEdBcL8ls7uxUGGQ/aj0YQDgrBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR06MB9239

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

