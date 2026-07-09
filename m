Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012011.outbound.protection.outlook.com [52.101.126.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083173A8722;
	Thu,  9 Jul 2026 05:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575240; cv=fail; b=SjJYeZxuyO115X97XszFwpiKeLYWmLcDmkAQd/u4idO3NmCpccGtPcNMU+8eK5gav7mWoUWhhNrLsIbf0Mpc2jPXQYsiBPS1A0cdlySLtZivg1gFZe0PthXnMx2W0FEI1B7zlWsaQgKt+eJMzcBRZIs8LV6egGhTXzNw0ZARxik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575240; c=relaxed/simple;
	bh=aetLwjV8eaJvbNZgrzypcKoOhdu5PfhXj22f0g0o53Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=a9gGsVfbONvlafy5Yabt2r3WAiJU0FAOs8c4lGG4X8kNsyWeeiTZHdZPmSYQrt9LbQimHTrVQYtGAJaHQDX28JAC/CsJDDPXvhhJwAO0DS8KZh7RzSCstt/3ydg20jfv0zOmsQ+YO6Mwvg9Embhut6M+vXu0B/Ad0breoQ8Q0Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=NYxLa+w3; arc=fail smtp.client-ip=52.101.126.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="NYxLa+w3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhdDFCa1MnpMTSflamRtTZt0wip5H4eNg5cYrR1//ANWGQD8oT19vdIFUZXwfRkoqqpaEkjjNlXH1qXtGhWdsbbljq343Xw15XriCCLQqggrpEtovQW/SKTyCTguPzYCi3wYRcpEPXczDbqFLcnEuFc20kkUt3ZoK71euuVnl2Kr8L8fmYvDQNdnssDwkfrPJyoRQUUuYnWjDmYlWig2A0jGhMte34fmEI+cgplR3S4YU1NhsQq9v8qFRaO3X2RgHSAUnBbb+3yyqx7XHEt9+M9YJncDTY7nMQgbNjeg0KrmluvNjVcaerWdhMuROGi3WVTspvZjgW0lVQ8U76RnKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNox9CCnf52Q9OvVttGkCmWkRmZODHqg6P1Dt+fZgHE=;
 b=dv6J5/LIl1CyfJOheTrDqhZQOGEeNtPf3vqCIlxevnPimp7YmSGFZR7Uj+GZD/7PVQ7dWCW254rHG8tdC8P1P1Sj0Gf7HLVYBpEIBngGom14byBoCiq2kBmPmwmLbHv+DNFLNxxxdehr4QY2Xy3eFUr6SLmmTnCcySA/s3HdXGnhjD8oOBPYW7IYfUXBJAqTekUDnvA4a//AZDedR7nQ+g9DJwyyk9/e8sZqxjk5gv8SGEkqV6p6Fkulp4IVh5Q6JT7F0sJnG9dNJFOM0gExa1ZWzaKEns1UJuKah7RuNB/ZG/by0ftnkqwl5qYKfrSro8d6XOMiMeC+TEbDGjDvuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNox9CCnf52Q9OvVttGkCmWkRmZODHqg6P1Dt+fZgHE=;
 b=NYxLa+w3gvPduxSOwHeG/4woTubslONpp3GwsuoaFZnBvXuf0eHvl9SRB5G+knYMsOMLdX5nl9LqCCy+MYuC81skU9D9h+F18GSew9WNfiK2OPj6x7U6ozw813xcoZUV0nrnayJFlA2JaeBHNsBKlki1KMFVJkQtquE2x9/32yk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6) by TYZPR01MB4610.apcprd01.prod.exchangelabs.com
 (2603:1096:400:260::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 05:33:52 +0000
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec]) by SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 05:33:49 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 00/15] serial: 8250: add Moxa MUEx50 PCIe board support
Date: Thu,  9 Jul 2026 13:32:59 +0800
Message-ID: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::7)
 To SEYPR01MB5387.apcprd01.prod.exchangelabs.com (2603:1096:101:d8::6)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB5387:EE_|TYZPR01MB4610:EE_
X-MS-Office365-Filtering-Correlation-Id: 416aaf31-9de1-437a-649e-08dedd7ba706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|52116014|56012099006|3023799007|18002099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	uzj4xRgG8HkPV3fECRImCGSYaovcFEWQTyNu/15Nw8G1OE1LbAPxVfbyKYTsaxXF873ymeOYJmf87+b0MkVUyCJ6m1fgpS9P4Vi2wxllle1sLynkvjiHDMKg1cEEbstFsewBINXQsgjUmGSe2yjgEuw+rWFDLpleedLA/XtinUPNbPC15R/ZSjULSG5Yt7OIbgt+hK0eYoXS2b74yMoX3K6WrCK0tpflh6OhT3U9BZElJmIbyBPTlMqfueHCeuqnE4FlHzkTM/+L3yWQtjf5f/K2zO9DtpxOS1hXGYaaj3NzQBIHtiE4UkJZNI+bTCmPHtR4VBEWQ7cdkCilGoRtojgwjrKQBxYzYoFXkQ+9iLX9CVp/iZ37dRUCExeARmLzCZl/b+W9uXTZOp+rndvOwPNkf3a/yw8J7RhCMPcENA5EkUcShl7ojyTaS4srsoS8ZcvbBeMqZId5p9R5qWnmr54MAkcovZJuF5zSaitHGrJEcM3oZKeHTpRXtWvhlZtP9bP/NC9ZuJcf+xb0f1jEvrVFsKgry/clbaS4v5WBL7AaMw71yoYT27A23O3BX5PM8+BdViN3hn/Pn0IdKsrkiFVltIOxpDLtbuIZ0sjj83y1wX3FTNcWzTTh2FtYINFhRKkqECtA4hNlQpNjfZL8048DCaSk7cCBZatiXDEFn6fLx6ACMDEbXH+qViQhp9i+rPOD00JP5aXtjR5ioNGYAClXUeXVwasRrHPSttOrJfc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB5387.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(52116014)(56012099006)(3023799007)(18002099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M6vZ1loEyIGRL/NX2U0XVAwK9xasFOmbRn9+Ib8d2TVk5I/K0BLYdz/HElTI?=
 =?us-ascii?Q?AKj3Kn/dcLECm7LNZ2fwhVw22iE3teaojFqydr5uk9LdhPEPzQefAhOVUqEl?=
 =?us-ascii?Q?xtM+0lOjG9ljr6VzlKWPgUxx2b6+4ER/4c7xkibUy+V2u4lUMuIZDkgwL+pU?=
 =?us-ascii?Q?pOLxA7ACApXR9BJEDrfvX4JZkUT3duMe+OYpfh72x3bbkhFSdj9msuYdWmmz?=
 =?us-ascii?Q?M6D9/Qf2M8jAJuZJ7kh6R2mOQeXwFpQKpWZOvb1QjiqZ9qdWk1dfu5z4WFVC?=
 =?us-ascii?Q?Dut6SkN3CUadNLFNn1+pHs44D6+wb80I/bm9kbfUN2oKQp3hXqezs+YLnD6o?=
 =?us-ascii?Q?wX9lzEh6F/+0TBi5/AUs3QHTiMgQHIsR7bffTHWkeWt7USNoC60GFLZDzV6w?=
 =?us-ascii?Q?oEpabe1TEjrMxR6Fy26IV3gWO2Py9CvxItd/Zdt/8Mw6RN1M5buRpeXwPqLH?=
 =?us-ascii?Q?M4N3SwvIb/vlcQMGzJTTCbUV7459F69yhhm9y+tiiQM2VgOD6cQtVwh0YAzC?=
 =?us-ascii?Q?ZaXdIMibIk7ODwCBvGIpFel3ipC+dySBNivBMdaPl2XEURAcZEnnM9Wkqgd1?=
 =?us-ascii?Q?dIfrkVk4CCdOO9eSUEfdHmDlsaSgiim0b9my3p1VunOnKBvhzAKSBWzUX2E+?=
 =?us-ascii?Q?vN5j5idtptDqO4ki1ChrDW8HhAiLM8WJ3lHTD4gFZ/27kxgmKrOF36uu9bFO?=
 =?us-ascii?Q?JlXkUk7lAlOe+ln/Yc9emWIHIvAkfrgb/tEv8isWBs+ojoH2A1IOtJQR2wBL?=
 =?us-ascii?Q?nsGAWzxv3YGGN0W+ovjDQ88DJZRvYLuf/x0z78z04fg9CbuTYQV/k2OVrh7H?=
 =?us-ascii?Q?ebpDUAUnoP6QeUNLczR0OIsM0vzcBH6qXxl0OvKkx7HSykO0v17Hc41Dh0QE?=
 =?us-ascii?Q?BFqxN6er/yvSyDtMh3J8N2nUV3nn/alg65zBso4K9pxKqMZHbv5S9y/f+4aj?=
 =?us-ascii?Q?SA6+u5BcIpF1YY6oo/cXizf8OwxPJjXfvLsJtnkRu+W3Pfxh6hzMshbrZTLz?=
 =?us-ascii?Q?5vXwggJtQ5AWoFGdkGmZy10T8i1Pa9+RiyfLQD3DMxdbbOYd35h9Bu+4Vxj7?=
 =?us-ascii?Q?m3bYwOCvN2AfQRptup1zTqyAPU5kpitfh0Mlr7tfTVSiUveHaNjv99bNuQ32?=
 =?us-ascii?Q?5LBHqHjhCTXKNIcRM0WprWX0/MBXnwFqzhDQVFKg3scxrqnQy1izsGGCLVHa?=
 =?us-ascii?Q?8ZvWjJoMpkdV18hOQecpXCxsItEKeSPCeXSu77vKqHBwP/JuI1OO/3zlJuo/?=
 =?us-ascii?Q?XaapIYXaYWZTmgJ7P18kz2PWIkGvhMDc/7n3O8dqe1YfcFmSoOsl1uneQDdK?=
 =?us-ascii?Q?OwVmDmfvqMYxn7/8oiNel5hHe8Pjp6UvFOuMuKinwxxCBDXvTfrSD8XdXfHp?=
 =?us-ascii?Q?VPqIms38Qo5WAGc7w/fqsuLyqWY9yS+FbWLhxYNE7NBvfd/a5z1qKGHY9hiU?=
 =?us-ascii?Q?/Y6mXVpYn6rO6GiuUELBa6RmmHfgInSorfwvi+LD3PKNodHYGkIHGHWLse/W?=
 =?us-ascii?Q?a5bNHbdCoPvtGemJu9Oe1Hixn+qYGhxh7OVpMgiQ0wgqOLumP/cxkUAaBJWt?=
 =?us-ascii?Q?V+dYzswU5UQH8+DI5cCAh/QBl/qoUzftNrXQZ4VwWwadxYeshX3awDuBguu0?=
 =?us-ascii?Q?WOh7PWKPrHuYZeNDdw9GS2PsaParvuH1Vop9QEBzm1CcyiebUnjjz2CtwS/O?=
 =?us-ascii?Q?kbgY62c2qMvbzApEICuTJSIFD27H9KTiiHy//uU1xDjO9OS0lB67Hzc4heDE?=
 =?us-ascii?Q?9ktD25Mi3yZn9PuCngXlfYPAPgHYQD8=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416aaf31-9de1-437a-649e-08dedd7ba706
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5387.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:33:49.1501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZwrhtpJP+llTQye+6B/nJ7cOPWLatlAxpezrZhXdCHieTSaA8uD70qLl3grKhhOHs5RMyYJv4o+Dg9aynlxGYIFgWnaE6iDB8O9EWrQtcxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4610

This series consolidates Moxa PCIe multiport serial board support under a
dedicated 8250_mxpcie driver and adds MUEx50 UART support needed by these
boards.

The first part splits the existing Moxa PCIe board handling out of
8250_pci into a separate driver while preserving the existing probe flow
and device IDs. The series then introduces the MUEx50 UART port type and
enables the board-specific UART setup, including enhanced mode and FIFO
trigger programming.

The driver adds hardware-assisted flow control support for MUEx50 UARTs,
including automatic RTS/CTS handling and XON/XOFF offload. It also adds a
custom IRQ path and uses the MUEx50 memory-mapped FIFO windows to improve
RX and TX data movement.

Later patches introduce per-port private state and defer
uart_write_wakeup() out of the interrupt-driven TX path. The driver also
supports switching the serial interface mode through the RS485
configuration path, covering RS232, RS422, and RS485 modes supported by
the boards.

The final part extends 8250 core callbacks where needed so low-level
drivers can override break control and rx_trig_bytes handling. The
8250_mxpcie driver uses these hooks to implement RS485 break handling via
MUEx50 features and to expose the MUEx50 programmable RX trigger level
through the generic rx_trig_bytes sysfs interface.

Changes in v3:
  - [PATCH v3 01/15]
    - Add Andy's Reviewed-by tag.
  - [PATCH v3 06/15]
    - Use guard(uart_port_lock_check_sysrq_irqsave) in the IRQ handler,
      remove the now-unused flags variable, and join the LSR read with
      the mxpcie8250_rx_chars() call.
  - [PATCH v3 07/15]
    - Declare the RX FIFO copy loop iterator inside the for loop.
  - [PATCH v3 08/15]
    - Declare the TX FIFO fill loop iterator inside the for loop.

Changes in v2:
  - [PATCH v1 01/15]
    - Sort and trim 8250_mxpcie includes, add __counted_by(num_ports),
      tidy switch fallbacks and loop counters, use pci_set_drvdata() /
      pci_get_drvdata(), and add numbered review links.
  - [PATCH v1 03/15]
    - Document the repeated FIFO clear sequence and the TX FIFO
      read/write pointer clock-domain issue, and declare the FIFO clear
      loop counter inside the for loop.
  - [PATCH v1 05/15]
    - Replace open-coded uart port lock/unlock with
      guard(uart_port_lock_irqsave) in throttle() and unthrottle(), and
      remove the unused flags variable.
  - [PATCH v1 09/15]
    - Preserve __counted_by(num_ports) when converting the flexible
      array from line[] to per-port port[] storage.
  - [PATCH v1 10/15]
    - Add per-port workqueue state in pahole-friendly member order.
  - [PATCH v1 13/15]
    - Use guard(uart_port_lock_irqsave), use serial_dl_write(up, 0)
      instead of direct UART_DLL/UART_DLM writes, and avoid modifying
      sfr inside the serial_out() argument.
  - [PATCH v1 14/15]
    - Move get_rxtrig/set_rxtrig near existing getter/setter callbacks
      in struct uart_port and in the 8250_core.c callback copy path.
  - [PATCH v1 15/15]
    - Use named RX trigger constants, serial_port_in/out(), and aligned
      get_rxtrig/set_rxtrig ordering in both the implementation and
      probe callback assignment.

v2: https://lore.kernel.org/all/20260701034128.218569-1-crescentcy.hsieh@moxa.com/
v1: https://lore.kernel.org/all/20260504084900.22380-1-crescentcy.hsieh@moxa.com/

Crescent Hsieh (15):
  serial: 8250: split Moxa PCIe serial board support out of 8250_pci
  serial: 8250: add Moxa MUEx50 UART port type
  serial: 8250_mxpcie: enable enhanced mode and program FIFO trigger
    levels
  serial: 8250_mxpcie: enable automatic RTS/CTS flow control
  serial: 8250_mxpcie: offload XON/XOFF flow control to MUEx50 hardware
  serial: 8250_mxpcie: add custom handle_irq callback
  serial: 8250_mxpcie: speed up RX using memory-mapped FIFO window
  serial: 8250_mxpcie: speed up TX using memory-mapped FIFO window
  serial: 8250_mxpcie: introduce per-port private data structure
  serial: 8250_mxpcie: defer uart_write_wakeup() to workqueue
  serial: 8250_mxpcie: support serial interface mode switching
  serial: 8250: allow low-level drivers to override break control
  serial: 8250_mxpcie: add break support for RS485 using MUEx50 features
  serial: 8250: allow UART drivers to override rx_trig_bytes handling
  serial: 8250_mxpcie: implement rx_trig_bytes callbacks via MUEx50 RTL

 drivers/tty/serial/8250/8250_core.c   |   6 +
 drivers/tty/serial/8250/8250_mxpcie.c | 681 ++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pci.c    | 208 +-------
 drivers/tty/serial/8250/8250_port.c   |  33 +-
 drivers/tty/serial/8250/Kconfig       |  11 +
 drivers/tty/serial/8250/Makefile      |   1 +
 include/linux/serial_8250.h           |   1 +
 include/linux/serial_core.h           |   3 +
 include/uapi/linux/serial_core.h      |   3 +
 9 files changed, 739 insertions(+), 208 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_mxpcie.c

-- 
2.45.2
