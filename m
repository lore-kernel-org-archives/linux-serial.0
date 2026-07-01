Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012025.outbound.protection.outlook.com [40.107.75.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D1536897F;
	Wed,  1 Jul 2026 03:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877411; cv=fail; b=svvCoW92QK4fpbZgwSXrx6bN3IHwjkZxmLybZ2g7PERYTThb8gdaV16ZuAtSgkDSe20ILq7zKDcWNEkq+jWPuhk5tbxnhJKy6Q/upGb+eyYSWZnzHxTBAXJGy7OK6q/48gZ5TvnTzp0hadHP0hPJluKFdrUyzDutBO65rbi89Ug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877411; c=relaxed/simple;
	bh=OA3QNjD+5NCFonjSp6+F+bG3kN767s9pc5yF5mE51GQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BD1W/d9OdCY4TI0lfeoWeG7qjMGMVo3XJgDXjpHUReo4WeqTKR9hSTVz5Jt1J3ugYNrVgSPuz6WXtiTloYIHP9bZtMnWGNB5BcfQD/kh2JuZpNzTTgdP0EX+QTE8LT3NMfRh7ewqp7NqYZQYepwqoe4nlH23munEpFUn6uFQO1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=XoAVJ6Qv; arc=fail smtp.client-ip=40.107.75.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="XoAVJ6Qv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5xMGK4hSniR3PzzB+y2WHflJStqdwYLa6DlN9ULJxvc0nS1scUUw0XuTzcIg50NwS5cP+s7ESdeSfw/OZuBL6X/QNiZlnSxFOWmwtg/jbkA0D7NOVfQtcqlyMyQHqPnJNfJtJepv4JjZ8NmBvgCWLzGvfjleiqAU+IGSXcPhKPTMXy2cfeMSg05b4gr174w0BGEH4RucWnyjZI8nucLug3MgMSY7rW3V4S46Y8WEniE/IA96qG9669aPXhjt7oxFma8El73u4z5NjBbm4u4eOPuDoGyDeVxxTefCVhSbi5fMhXQoRY5nzp/Y6mZThuBTaAR/GIIYcQCaTfDXGib9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsZXDiRhR0V892ENDzV58uTkXmp0ahduvk2rCFYaWDU=;
 b=NmNkDJI4oiZxmmekV2DUWo0gnN5tYTpflA88VgdNI4lowZcTidQ1d9Q/u56xvMfFcQ1z3LAAEfPDglf5rUyF1cf+mEJIbePUJEBmiD+1xjbHr/C5NSTZuqjZQnbEUu5BFtxFMy3B5s9eYXIq2ePj37rD6pOZBlN11q1JxXUxrEE68iTxR3aL/Vi3kQa4myOrtIodEHn9LfMrwixa3NgKy2oN5ulW9c1+BPPy0nyFOO1fGgjNUxPpxxupcieEN4jyJe2ZvhCJt3c/egW/Yxb5K8STnusYcsUSgCloStFATE5dDZi93zia/w7xQREbpryTM5ZBzzcUatAjnNRykYle8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsZXDiRhR0V892ENDzV58uTkXmp0ahduvk2rCFYaWDU=;
 b=XoAVJ6QvGUxDr0OBbhFlxv+tCfz6Ux+qZVvaw1u+cIRmBlZY1U7W/3r7jRvc9Ki4u/Q9G3TPp0FDbnn6Ftyi6QclLcyea3/cVqjzgj7POwyXKFiGYtqr083+WVf3jl1jpl9U94HyXmY/UF/CNbsa9AXhaxsmnfIQZud/W1x5qVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KUXPR01MB8048.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:7f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 03:43:25 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:43:25 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v2 00/15] serial: 8250: add Moxa MUEx50 PCIe board support
Date: Wed,  1 Jul 2026 11:41:13 +0800
Message-ID: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::14) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KUXPR01MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: f45c85c3-74a4-4904-6445-08ded722e7db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|3023799007|6133799003|56012099006|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	DIrPudifqF9g9RTExHf06azIqK2wCZh0X2+3Lq3pLUuXdJa2Y1f7BkKemm0VHszwMa3iO5gjHf/aV7QIc256q537CtOCe2Mjt65A08CECjWmwtSp4S8tyIWHKmEkjbmTzpSWBtzWwRR/Me/xheI3e/AFN47nsAd25QLg9VgsN/AnC8q5wCkTjX5EpEogwRMzcWbtYr6aDuMyhgMf5INp2wY4/STs7MialuldKWr5q9uGTCrTSMU2gafCXd2t5q+SQB3yCsImg1hsoxJNaUKUKkPkvpnwlWn2qttfrwEG8tWK3fbIpnpkzhf/trIc3fU8XWRNFMyq63xs/yWCpBo6NKDBXsRMeM1qgk8ZMs4wiQrQTQP6py1nbLzb8p03Y0Y/wCBP3Xfiz0WELsBTBnZDOEXQFIWBVFxKTQMsjRrwb1nq8vqoYw3Jy3J3JR2XK+3T75YpGQXNlr/op8T99+fDwBI3iivzOCN+ubnvcmWupsevDvO8cFKdwpn4WfptYt0XqPKIs8HLkP5NRLDitgiT6+B7RgIGSeVFM2cp3cB5nDcQofyWDPE//EFvAw+rxvWSZUe9VnMVzBupsZb6hXV7Yn98TfEW0P9WIRd5nrB+86DFax9snr+9nG7MKipiyMdSRHMB9FYI6PZZ89fpDcBzJofswhkWw50IfHIui38mLXJj43XnIkUxKqQDX66K1AJ9o58lUR+6fAxOJm4bUQwGYnBS4cWRpsXbLSClhJvqCcw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(3023799007)(6133799003)(56012099006)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kridqNSLuxdau3ZkTu+tz8wzVirucuP6ONa0wl0uf4DkIxgSCpx7htvx8b1X?=
 =?us-ascii?Q?FpuG6jiLpmQInmSYmwb/itdtuTe+ouTn9HpD5CJiSN5Sv+W5v3IM+4FAtvjA?=
 =?us-ascii?Q?9PY/miMQkHeGGWKeLdFW/mSYM23EY8TJxJy3R2pEfNKMPz7duk86F6khRa5t?=
 =?us-ascii?Q?XaOr8NluA2Or15HAIco45TL+CY0ZFj9hZ0u9+4WQsdaCBJDVUNjTPFazj6c0?=
 =?us-ascii?Q?7elMhuVJ+9xpmLwozNsj0qPw0DTH0mJqMWSN6A3aVwcQsWHPrLVq1WBu7EhH?=
 =?us-ascii?Q?mYymk6nwrXUYUe2K6kNI0mYwZTAM2eEFqHOkbzD1SvKQvY01+pc41P17petT?=
 =?us-ascii?Q?+I6Lq1JMoFBNfwqH1CdnFbozWnq1B22e/ES4vQ56eSInRzhEgWilwZa0ULNT?=
 =?us-ascii?Q?K5VfI+/c+y1nugWYHn05uiLqtZ9g90+g5CYmG0k/iFBqp+TM1Kcq5QDaLwDR?=
 =?us-ascii?Q?oxgrVigVlvvsxGku7xsG7UOGvF7QbruroPVMi4MTgMlqBdT73ibDag9pmGQA?=
 =?us-ascii?Q?AvS0InmlxqxvRzKq/I/Sak7YtCJ1U7WOwWw0No1NuEfR+eYVclLjXfj0fF7Y?=
 =?us-ascii?Q?KnZoR0e+qFUezBYUbjRI1OwQplrUcqZxm7D4avriLW5+K5exX8H3SeQwyuS6?=
 =?us-ascii?Q?LlZVzH4ETibAAdyqW3Z+LEHUcL7OEotM/hws12o2/8L1PBskV/h6eXg0fWl1?=
 =?us-ascii?Q?adBDhQ060uaKS+/mc6a0E29NcVknWg1WH1DUg1JuISHmf1s+xWDECsK7wtdH?=
 =?us-ascii?Q?hJY7UZQXI8V+VH5WKqnbdAtoIy3qIm0TYWo28wilztQb3nsqxG0rnaFTnq1C?=
 =?us-ascii?Q?Mx651GrQUBMgG+Ap30xYHO7kV+KCMZpAeg6ZpqiLOsU1ePVTg5bZ2X4uHsma?=
 =?us-ascii?Q?Qjj16bWBFtVj063Csv0GcCsBOv2j85GUweE0LdvOBLu4CtZ6BJWZpMZzkVck?=
 =?us-ascii?Q?XsYwqgmBuvJeRfZDl3Pq/03M7ZBAIIoq30t6CL7vw3JZYZ8mhG432CpvF5g0?=
 =?us-ascii?Q?0LeL9vXNpp/tbwDxbyft9m55dEw5U/I8fvotQ42OWPLwsHu8Qq+kUTYRA71o?=
 =?us-ascii?Q?1zxXFJkUcE0ae4BbhhYXmLpgFW4SpzmGtzFuA0NF+MXIcZMKnv8yHCBW3y5z?=
 =?us-ascii?Q?OQs4DteYLQCFyJBt/wCpeQJzIqNQKsw+snfSImFStXpqg8AH3ONtjEjWT4m8?=
 =?us-ascii?Q?8Nz1Fy9Aj0O8vt9HcH3pyf5cv0/JA8ploVB5cpKQBTM/AGbRiOm2nN0AuGw/?=
 =?us-ascii?Q?OcWpUv7MtCsfcnXUuSCO4g+QnENVcsCuOIBPLOv+fvhEa1UzLyAP3UT/9RAj?=
 =?us-ascii?Q?CD5FO7nrddKz2Lyyph5d7qyTL51WIk+ujHuGnc1C14WGqDCKm4ZOAndAEw2d?=
 =?us-ascii?Q?oMY6QSq7JDJ4NkOF4AIXvRQ/ofnpJaF9NUbz4jXYo/zmQuAo3/K4eIhdnVXr?=
 =?us-ascii?Q?rHlscqcfxQIdhBb/5kqG4a7S+hzipl/3IRoVNLc4Oz6EooAcwZ3nXT55DEK6?=
 =?us-ascii?Q?ugp7Dw9269hi3vm056jvZshQpxD+vVyjafUa3glK02zrpPPpuHBZ2UjvZuN1?=
 =?us-ascii?Q?c0ylEBR/ws4h4vYTzbM1NF181F/Q+12NasCHF4lIpKXisi9jDRv5WH7qoPz4?=
 =?us-ascii?Q?HDvA/GcCIkhc/W3bPez4yAoZdfMzN7oiAIKisaVylW/zHVQqw9Wy1A2z9huZ?=
 =?us-ascii?Q?nfWRhA+4IGpPn30BtcYTsHNokac+peqIRYaxidHOKTn12Rca1GR2JD5dqgIq?=
 =?us-ascii?Q?GrauWLT8H0c+VZAZsg6lkL59YeQoOC8=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f45c85c3-74a4-4904-6445-08ded722e7db
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:43:25.4411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pn6xJLNikIVpBL2QONagsm2Mg6VHTqQXMuKZ/VQdZpqOScyAoeXBTtDrDkSmP1sPqMZlYqoxo8m0o6llTHFVBgFnVW2L9sa+4PquFG5HH6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR01MB8048

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
 drivers/tty/serial/8250/8250_mxpcie.c | 686 ++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pci.c    | 208 +-------
 drivers/tty/serial/8250/8250_port.c   |  33 +-
 drivers/tty/serial/8250/Kconfig       |  11 +
 drivers/tty/serial/8250/Makefile      |   1 +
 include/linux/serial_8250.h           |   1 +
 include/linux/serial_core.h           |   3 +
 include/uapi/linux/serial_core.h      |   3 +
 9 files changed, 744 insertions(+), 208 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_mxpcie.c

-- 
2.45.2
