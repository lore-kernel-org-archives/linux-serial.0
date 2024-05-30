Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2097.outbound.protection.outlook.com [40.107.117.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA1818396D;
	Thu, 30 May 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717062315; cv=fail; b=J6hV2v/O6u2ProSxFySBorY02E7XVp0ip/txC37Wbxaisokj12T0u1tpdEXKlQCgwhzpmNTT/USZvFJDyQXL51919VIzr9OuphC35tl3iqtoREMk9BUseeqdLAoBX3r85Nav2/I3Y6uqNiWHiix+aeeSceHspWTOtkO99C0sXXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717062315; c=relaxed/simple;
	bh=F+f9qz3wECUNByv+fbawI92jEe6DvZz6OQxFCvC/py0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=iGMgz5Ab18K7+Vpqa+lkyWX9wtHxfT3LmUakEZVcP+AsQHnw2yUGOsjdweR/8a2uh/+IRFPxrU+OA86ccYmCbUtzpgLzYB2F5tpPzJCN+NI/0Vadob8HVa2c70jrz2PJVzvpw5ntTLXBUHPVbq0FkEZqeiE/UDPJgrGQ7qhb930=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=J6seKdEP; arc=fail smtp.client-ip=40.107.117.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="J6seKdEP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PX7pjb8gsvKZvqGEz97nG8ZiyxEX1p8SXeEgTbYr4iCs7mUNy7cgBstz83OrTM1cqE43OwG61eU4HecFGELzjnpokdulNRpOokTh6Fd6xIPeRFdadpoYlvllXdRBDAgbPnuFuvK+7rsaHBss4yRicbF6W+24R+5ALginRHMIfsCijCvaUQqvzXzjeARqlw3Z3OICI72RZM5NTdQyghxqTcQ8szn4G2dN4coHxs+r0AKp723KSkIzY/cr+c9rfBRlQm3BUc8rYStAWEw8J7Deht7ZT0MCMM5IDP+ygu8iFnlmS/4It1kCSRTG6ZVV+C2XjdZKSEX3HOZi5TBVlPMDaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R3b9l8re+SlHFrg9dpLSRq92B0cW8lWnGFMY/TdErwE=;
 b=FAND1ZmuD1RWHHlDaWRq4236LemVDVp3IuMbonQozvWB0K++tJhHgBxs9Hlyl3qw8TbU3WsO+j3hCfxE5MdMRhNM2EVB2qzboTiBdRPq9STtr7i9+WvVLa26XwR/pFbZxNVsgadu8JVAA5k38rOE+lgZks3ai7R+cZtyNr01wGuJCfN1sB9hradnByA0kdZS0DMObRl3G9FIWxpgkMbzo6IwMq5rr6lePE+ww6f/TgMSm8i6gIc1qDXyv6DFbXT/e8lzWhrlecOyjwQxatHhlkMAhF2IPVTGzWfP0YILdzRo00mABfHatxxKvHBYkveKwILag9AcvMWLXZEduPdCCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3b9l8re+SlHFrg9dpLSRq92B0cW8lWnGFMY/TdErwE=;
 b=J6seKdEPuWoVF/R1QTIRC9HxSsMhncpx8He8fmgWZ5LLmEVhkbL6vzAhzKkjWJxmk5Ct6j/6KKTp8biFgdLRW7HnF1tZQlWKXgtAze4wE8SCBcwgWWPUJvOHls4e+gb41I4eR12VgpW5Ym4Yfd+aS8JkeU8lEBSDlg0orPwUenA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TY0PR0101MB4938.apcprd01.prod.exchangelabs.com
 (2603:1096:400:270::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 09:45:09 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 09:45:08 +0000
From: CrescentCY Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	CrescentCY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH] tty: serial: 8250: Passing attr_group to universal driver
Date: Thu, 30 May 2024 17:44:57 +0800
Message-Id: <20240530094457.1974-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0203.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::16) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TY0PR0101MB4938:EE_
X-MS-Office365-Filtering-Correlation-Id: 18e9ac29-9b27-418b-1d03-08dc808d30fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|52116005|366007|376005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B6r38Zvi1QE2oZoWYTfdvva/j1CUCNJeN7uRlOtqFB1gHl7QkPkBNaD8OgiI?=
 =?us-ascii?Q?NVFfFBbWrVLm3REwO5WfI7/UE80TR4I8B+g7LKTLXUWcXt90unouFe6+sfAV?=
 =?us-ascii?Q?MJOMkEGm+7BWvqgRAOeGO3IiLWGD2zTHIMvQ7YWbN707+3EZdh6/Cd9dxHU4?=
 =?us-ascii?Q?BkIZdg/BJszuYDnJdwnV9nV9ADSl5WhmcvThtX061PP9jdLZ+sQRd+HBC7+x?=
 =?us-ascii?Q?LfgjB+KeimLQK4RLY0gXer24PDkTdeLJbVs9ZDY3tdtgx91BNncloD73BxUd?=
 =?us-ascii?Q?TaUX+lBgQszzTmzEI6tGzJ7RJS0ob+Mt5TC4z7jX7PllZbmp6OEUybRHeZHH?=
 =?us-ascii?Q?KmX1FRY0QJL7Rl89RxCYBcAHRxi4JWX2QZvX8kRDcKwz8e3D/f/Q9YwzolWi?=
 =?us-ascii?Q?yjNbHLs4y2jNlJhdy0E3k8SN8uRaf/nrt/+6xQYatAXxbAHzEwYNYus0ZZ78?=
 =?us-ascii?Q?yXTHuXcgCKvZ5v+zV/zzUT17+zZWh5zaz7M5s4PpyfFwKwnllOXz+ql8y7lS?=
 =?us-ascii?Q?/KwsGnKJ95ZACWm2S5P1G9wAT6sB/NuTUjd/p7vcJbYX1wx5uQlopqAnjca7?=
 =?us-ascii?Q?QOh4YAMRn/8S2EvQrgob9IrGII/509IRVhTwnLakkqapHhEakhEQfTFmZ4Ak?=
 =?us-ascii?Q?cV8z/0YhoVBWAersRpn6PsrQethEIsGoXLTPH25ZESyiMv09nByVCgY5Ja75?=
 =?us-ascii?Q?rPMCEdxpzlAhIumDqTKwbagtF3rJK61MF0B3YpPUj6o7fby0fT1xpuVGXn9S?=
 =?us-ascii?Q?0qsGY0Z9viGzW8eLoBisDSM0tsl5S5HaroVxOmjXM7FCzg3zsQF25RyVZLlV?=
 =?us-ascii?Q?2BkkfnWz3EuCko6b6QKU1lhqcJwqCA3HgoYfMdY+A15lX+d7Eo5S1erfHhKO?=
 =?us-ascii?Q?oosdrSYtUBf01sld0C0tQnVDguXYVKSnNnmYXcjMsk4m9638FBDIqkzYrAUv?=
 =?us-ascii?Q?dsMldZd2PVvOKxfPgTGCcD/yukEiN2Ks1C9tp71OtoF+p0YahlRI5iu6jfNV?=
 =?us-ascii?Q?6K9mxaGHaiWJ7+o4+JlUkAtTnixZ/AhPPypSb1g+FFRh55W7fZmo3L5KRHm2?=
 =?us-ascii?Q?jy+seAmoof1M6587RGhkYs8gtFMXGYf8gqXdbCIIv/2K9Tm7xzuGTlgKCn6C?=
 =?us-ascii?Q?hQsgrDaLZ2wIjjXsRFClyVylJsiWXDeibuZK38rcbqxlfF7Ow7zjGtk7/Gfl?=
 =?us-ascii?Q?3Ar8tbXodo+lzZM6T88O34vLuaoiGnjExnPAr8SpGAJQhiOR7IhZgeoQeYST?=
 =?us-ascii?Q?Jsvj/mUqEf2h/O7Ftlk+CpxBUhQLMQ+FfebUg7fhcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3f25Z9L2mZLaQpmjaexMkXZz8HXJnp4gVYqITVMkcQ/MR4WcvyeCuJp95Cd/?=
 =?us-ascii?Q?97dA1JBdyN3JQscZWNsOMO525OX5RcPz3fh8ASj2Fg53ur7ywbsLy2uh2GHw?=
 =?us-ascii?Q?YhE0dMLKChTBVzevvfQAVLEzYjGRp3HuWgpDtTzKOZUJAbWjFuI2jcEHwTw6?=
 =?us-ascii?Q?V4qYTizO/ePrYE8PwnNDizTdA1XJjF0Dhfz5kbaoHkXdEpy1B10UmLV4nVpl?=
 =?us-ascii?Q?SS8r0BhTjoaR/QiCf/MKxPoFCUyWvl2+Jjt9FDYJ7CGNWAmLQ72DCStLExVT?=
 =?us-ascii?Q?oz4OCAmn3B5FuVmyIlPPDPVPp2VfwvVtlYUpPJkiMNxBiGbjqG4h1F8RNfr2?=
 =?us-ascii?Q?L+GxxuMCEi4y4W7FBgZFCLEDZQRUY1BTyF51FxTSPqjMytnF8CC+0LsZQEcb?=
 =?us-ascii?Q?PjQE5DQ87BEzIDhQe+wwT5TkmFy/6SxzbL1mVOITpooFsIxdXUqfjPT4HF35?=
 =?us-ascii?Q?Ebs9PcWIFK/ipmZgEEREHepEkeDWB0C8aOOXRT+9aOp6jvoh8jhIJjxIUqFa?=
 =?us-ascii?Q?yRUaHHAwWooFEF1zIP0C0NxkJ6U6l4G8GTHZAeoHgX1TRZsa1awVjCg87gP/?=
 =?us-ascii?Q?jPPNOD4KHY4vSgkOhBm07/UyQByOBpqCuCzwzkn+bFz2cjqJtReccTjH1UhI?=
 =?us-ascii?Q?pP76a5/i+dRxnJnlykBFNjp/eTPfl18PNh4r5Wi3gxDS5rhCY5EyAZlhnwZw?=
 =?us-ascii?Q?fo2Daabn2U9niR14IE2aRH0gZWKQEtvPQDbODiKPBhi8iu7PF67Gk/TmHq7g?=
 =?us-ascii?Q?JjhYt3dQ1F5gzRzvXgVvfTkPVoL3YQW76YHa8S3he8IjmyKz0eTrUgXLPTAb?=
 =?us-ascii?Q?cNmCFOEoUtprbrWcGRSshNhQYUyDl+ft0d6q36kOXlgVzBaXT+O+8o/bAmHB?=
 =?us-ascii?Q?1u/T0dYMBTaTbYM8dRDVs6o1TqYls+6x6s96d40ZFdmzSZfgJYO+dv9LNjki?=
 =?us-ascii?Q?YMp/w+8dRjbuWGO+rHFs3HkEx+qs1vBJ+BMmd3cPgTDfSF3jOcb5mRyh1S/T?=
 =?us-ascii?Q?LxCHfTa5CTqpRUiEqgEMMOGDjKbCWbyYTRT8n8zzWKFgPGDio4y1EWmvU4D/?=
 =?us-ascii?Q?HoDyqpHFiDTMhobs1NNK0tUKaWN1P9pIWTYaIdqvUiWWxwZG4NaBASlfeBQo?=
 =?us-ascii?Q?ybaAd42cp8RBQWeRbXz111PcuQxADlSlIfmZ7EDLGeRhRZV2aDJDCYSVbqWG?=
 =?us-ascii?Q?lW1p7wXq5HlZRLmoo6aerD1h7W5NzMf/8Hq60IfIWI8UQwNuGfJzP+EUXQLh?=
 =?us-ascii?Q?Mo7ezlL0yw5jDEhzPx8Q7DhIpdK56TjcBaU2VQ8VqnLfSx+qcgly9iNMw/nT?=
 =?us-ascii?Q?RIey7c6sq4dARJHZZzPnULcMNRxAQtpeNrySYFCzUVN5RK28VxVZ+HxRYjn1?=
 =?us-ascii?Q?VqF41h10u9d/lM262zQrwOA9FXwaxjqDT153GOjJGqKB2hB2xJBPyUs3ba4R?=
 =?us-ascii?Q?e2oVfEhh6y5eQe5YqKJnPJ/gLvv1R6U+YTB3hsEeogIsiu8FTRwHw9ZCvnhe?=
 =?us-ascii?Q?UhdKaFmMo4IgLl/oOpdvJIUX/iJ4JIM5cWDvQjZjmW8Y6a4hi0+0WpA3GClS?=
 =?us-ascii?Q?q6LvPmrrTSn+GNBQ5D8L2UShg5ScMEmEpVGvydwSzyBa56vuabPR3bkue6fE?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e9ac29-9b27-418b-1d03-08dc808d30fe
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 09:45:08.2096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvRc8TQ2oA/7Rnf2yhShAluBXbKlwK/jSSULDukdUL4W7eslaIld9Tg6soLBFA1oQDPvG0FuvoCzAVGtTQx5MLV+lI6fGhDTh6Q/8XzUSHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR0101MB4938

Many low-level drivers in Linux kernel register their serial ports with
the help of universal driver (8250_core, 8250_port).

There is an attribute group called `serial8250_dev_attr_group` within
`8250_port.c` to handle the `rx_trig_bytes` attribute:
https://lore.kernel.org/all/20140716011931.31474.68825.stgit@yuno-kbuild.novalocal/

However, if a low-level driver has some HW specifications that need to
be set or retrieved using an attr_group, the universal driver
(8250_port) would overwrite the low-level driver's attr_group.

This patch allows the low-level driver's attr_group to be passed to the
universal driver (8250_port) and combines the two attr_groups. This
ensures that the corresponding system file will only be created if the
device is registered by such a low-level driver.

Signed-off-by: CrescentCY Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_core.c |  9 +++++++++
 drivers/tty/serial/8250/8250_port.c | 26 ++++++++++++++++++++++++--
 include/linux/serial_core.h         |  1 +
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 43824a174a51..01d04f9d5192 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -1130,6 +1130,8 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 			uart->port.pm = up->port.pm;
 		if (up->port.handle_break)
 			uart->port.handle_break = up->port.handle_break;
+		if (up->port.attr_group)
+			uart->port.attr_group = up->port.attr_group;
 		if (up->dl_read)
 			uart->dl_read = up->dl_read;
 		if (up->dl_write)
@@ -1210,6 +1212,13 @@ void serial8250_unregister_port(int line)
 		uart->port.type = PORT_UNKNOWN;
 		uart->port.dev = &serial8250_isa_devs->dev;
 		uart->port.port_id = line;
+
+		if (uart->port.attr_group_allocated) {
+			kfree(uart->port.attr_group->attrs);
+			kfree(uart->port.attr_group);
+			uart->port.attr_group_allocated = false;
+		}
+		uart->port.attr_group = NULL;
 		uart->capabilities = 0;
 		serial8250_init_port(uart);
 		serial8250_apply_quirks(uart);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 893bc493f662..ddfa8b59e562 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3135,9 +3135,31 @@ static struct attribute_group serial8250_dev_attr_group = {
 static void register_dev_spec_attr_grp(struct uart_8250_port *up)
 {
 	const struct serial8250_config *conf_type = &uart_config[up->port.type];
+	struct attribute **upp_attrs = NULL;
+	int upp_attrs_num = 0, i;
 
-	if (conf_type->rxtrig_bytes[0])
-		up->port.attr_group = &serial8250_dev_attr_group;
+	up->port.attr_group_allocated = false;
+
+	if (up->port.attr_group) {
+		upp_attrs = up->port.attr_group->attrs;
+
+		while (upp_attrs[upp_attrs_num])
+			upp_attrs_num++;
+
+		up->port.attr_group = kcalloc(1, sizeof(struct attribute_group), GFP_KERNEL);
+		up->port.attr_group->attrs = kcalloc(upp_attrs_num + 2, sizeof(struct attribute *), GFP_KERNEL);
+
+		for (i = 0; i < upp_attrs_num; ++i)
+			up->port.attr_group->attrs[i] = upp_attrs[i];
+
+		if (conf_type->rxtrig_bytes[0])
+			up->port.attr_group->attrs[upp_attrs_num] = &dev_attr_rx_trig_bytes.attr;
+
+		up->port.attr_group_allocated = true;
+	} else {
+		if (conf_type->rxtrig_bytes[0])
+			up->port.attr_group = &serial8250_dev_attr_group;
+	}
 }
 
 static void serial8250_config_port(struct uart_port *port, int flags)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 8cb65f50e830..3212d64c32c6 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -581,6 +581,7 @@ struct uart_port {
 	unsigned char		console_reinit;
 	const char		*name;			/* port name */
 	struct attribute_group	*attr_group;		/* port specific attributes */
+	bool			attr_group_allocated;	/* whether attr_group is dynamic allocated */
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
 	struct serial_rs485     rs485;
 	struct serial_rs485	rs485_supported;	/* Supported mask for serial_rs485 */
-- 
2.34.1

