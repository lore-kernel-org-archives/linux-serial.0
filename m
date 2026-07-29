Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012034.outbound.protection.outlook.com [40.107.75.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6E2242D65;
	Wed, 29 Jul 2026 06:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305192; cv=fail; b=tCap7lZ6aQHr4qvghtidoJOHQwJkKyATMbevF7yOq8zhtlz56BmaWqcns320Mj+2NH8xycVDU41j/P60MVBImDohB42lD/NViU5YZstvF1h6iGJjEaZQzRcvxXv15TSGwlppCrYmckXFbdka/JQr4ih1PxmTzaUUOdM9/YQIiqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305192; c=relaxed/simple;
	bh=1o73JfekQDE75BtDvZ+LDruOyCTkvkqeK9ZUExzQTSM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aTjV3HPOjulaKI74m0kny+wqzuFRKa1k8Jwl1tnGkWs2N4fGOfZEUSAgSOhfZ2ejiRWxvn7E7lRdLtHQ9CoCoPb9VEO6DaqtOBGu22LY3e+0aVFYpsPbbvYGoCD+eR/H9UuIWs635SBDae/J0PCO6EmYhj6Yj6bBoZUZL7DqDV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=cWTHg/Zu; arc=fail smtp.client-ip=40.107.75.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="cWTHg/Zu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Buy7N2Xr3jiCOO1P5jZEHHo/uIi0qS4PYK2QZBAu1OUhdX2hm1+5xrv6vavuxjtmvks4EgtaqLd1LpIbifIz0j4WOrl0Jksr+dmN26iTy0gAm9ruEo9q0jkhfedUcIs8zydk/s6aNAv0DWjpVTioFVClfIhx6qnX7bwyFNqLHa3EiYzZnqFRM9mxDo768ZLjWPojyjG6IvFmG7O9hCRP/3Ud2Tkl91Nq2PsqE0vwpLB2l57xexkEiB3K3YolYOWjATx4CSSjiID5g/w6ReOUu7Ob7jmMmKBTG5JZsWI7bbzTFs+kV/i7cispC6vZ4YBYfrqDrCQPik6O6FhhP2jeJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/y6SDgyTfBOHPoOB3LbA2cpB6CgGBrcZ82OpITPmhA=;
 b=Sz3JBboYv+kb4IzWlo++6Wpf2KXvls0K6SQFj1zEyOt249vKGv6GYMPWeAn/nNixOr6nBlCj4zRchf18e1FA4wBrpj+pkJCZweyjZ5SNIlMM73Et/h/6zFs6w1uyOXidkLxtG+OSL9qNQBUiUSUmoYzbOhKKpY3PuXiFZ32mLDn3HIlMvN8bPkRTVmjAHScDXU72UQQmFGo26lwmx3eAXXewghqplAjnsPqwDjK48fJOrEW9zMaKanOrM8xrlBuMwsR4DDjkl0uSVMAF+19jeBR4qJQew2t0sM/W8oiTDA1CcWW8MgOn2lwIAa6qkMWKxVTdlW8n+FMB2wh9Ea0HRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/y6SDgyTfBOHPoOB3LbA2cpB6CgGBrcZ82OpITPmhA=;
 b=cWTHg/ZuE7QK8xEB4P5kvxqBHLh5CdGbyxxsmssOgR0YZntENgJQi8m+a0imNObyK+vGi7tDYVaIgdcoQeLj8Jk5CPdW6+NNAA4s9jiso+u06i8J27JRP6nGJsFknNybA02FNHVhTZr+vz24aNDLFS6uUSFfBcRUZDr+prwJptI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEL0PF4D55A38B9.apcprd01.prod.exchangelabs.com
 (2603:1096:108:1::59b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:06:23 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 06:06:23 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	EddieSY.Lin@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v4 00/14] serial: 8250: add Moxa MUEx50 PCIe board support
Date: Wed, 29 Jul 2026 14:05:48 +0800
Message-ID: <20260729060602.492430-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::10) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEL0PF4D55A38B9:EE_
X-MS-Office365-Filtering-Correlation-Id: a5bfe4a5-4294-4d4a-6f53-08deed378457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|23010399003|38350700014|18002099003|6133799003|3023799007|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	A0dZulSGZA14Y1ivHcrv3BruFkS6YKZsXpEdujr/uIZxBXkZBzJuaKfuPEoVsGyyQz7lsj3KeEYqGzrcbls+N0ztMSKZij6sw9qOWazHkHXJ0Gqe2jvUK4NggJiEjDtlVq1QyTnEDBgyS5rn9k9DJ3/EGhqXqrx5Fe2NPHXooUEsXKBIfagJXvour/d/7edS7dfXcBRkFve3mxuAzKlNQibMzrImSMqNnKDgL/n/DoA1vJQQ3IuNsZ95y/2FrYvRt8GKUuw476No939D7ufls6nsvulTY504F9+YmnbBFNPXv/2U8PkXFe6xfqr7AuwtKskXxkAdhzzFixLkGMOBavZUfOBsKp4OKUG3yo7aAOZ/5+2wjx/7VgCBRFEzVNKSv6XK84jjwJHrJbdCaPsTYba/eGjxJo9ckpgGw/Pj1wp0ODin3RTDeykhW/kqv0iuU+mLRgv0j9fYlBMGomnbepZgo+0Dgfzoznt8IyqXQq9D5d4Rzp/JyLcWyrSsMGE+6gbn/XNKl4oUJT+r509Mdxmo9/yYLk2DoWq93TsL2f3I0saVp3dDCFyyEGE/3nNHb9Q7OnwuS9d8quaY75mEIIWx0Kq2a8xL0mVe+7pXzmt8X/fhiUxk5Ipzc9xNc6N4BALC5z3c55Px5XztFURv/xZsr4jOkFmXPs3q/sp0HYFsfa1xJQk1uHkU5BPsw8tEc657Q6+Xa9GvcPt3akdxh0N3Sa2//75mUmVAcafr6p0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(23010399003)(38350700014)(18002099003)(6133799003)(3023799007)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0/J5LbHCwqaxKmfGndUYLnyfrPVkr6tFSffDILOQH6LFhSpiU6VvSERCj3VE?=
 =?us-ascii?Q?ZxlJvy1bLEu0BTINEC/CY4bOsTXOfGIQPVDdw+ZsvFeTTNiS9et7ufmL0L7/?=
 =?us-ascii?Q?kDpl3iJBqkXvbcVjnFwCIzh4cA+BeTeDeBivagbQDSWqpGK7DWGgp7uhEFHo?=
 =?us-ascii?Q?0B2OZ0ZetJxdDLiIk3VgPBRaaFx8qDFPpe308O4JtgFONbFz5UxMMj4+l/Gy?=
 =?us-ascii?Q?AmGA1C2X54S28DHRYPkvJweCnu+zGPFIyY2kkqSTw8sgsbADnHgSBiijlzwN?=
 =?us-ascii?Q?s9+XC3Tpcde53TifeXp30m661jt9p+2ea0RwAfOd9eW0paDx2MJheicK5JEg?=
 =?us-ascii?Q?fuxC9Vxs29OEqp0+prWcXA5nEoBLjw+6V3rYS8mE9VL7D6fXESaKRfUCl8Cy?=
 =?us-ascii?Q?84o6qkIRnUkkk1sevSQPSeCSmrryWxqC2AzRlaBq32LUuKDQprjas65wQDPR?=
 =?us-ascii?Q?VjXx6R3Msxgq5Efd2doe6NEwVRQ8vEueik7L3Xl9pQyH9J/7FX1flj7FGca9?=
 =?us-ascii?Q?PYH33Nu6NLI7imwXWBYPHitSePUWcHCQe0Cc7Y31nzynPAggI1ou/I04tUcR?=
 =?us-ascii?Q?q7HcRtPHx+5kS+RQYGDFo4j4ryHXKgYKJAsZF+mPyGFOhyfAmutOpj0j42iE?=
 =?us-ascii?Q?XiblNbXX38Gv5JQe3QXfoDtTirxEfloxGpidXtiPo6mHqgbp35PwT+/MGEWQ?=
 =?us-ascii?Q?PXvlpm7JjEUUbqidNqKGev1HgWt/7T2ybKE8Ufy17BBVxQ4p9VAzTesYtgrT?=
 =?us-ascii?Q?GhKSB4HKRHbnzS+Kl3DF65JtluU13vns2ktT4VA6ypbsEG5jvvGZBEiFAl8p?=
 =?us-ascii?Q?BkDicZ+Ni1KBfZtNnWc625FRrQGYYYwV5rYcB/M1rPlcZpqCwQmiOQA4qwiZ?=
 =?us-ascii?Q?0agqRS6CLhtwWup4hzaOJCBPpBE1dfDVO5NmTMeBhP6qIp0cBI2IYNKJhu+O?=
 =?us-ascii?Q?ORWzyhgKwybpM5mTplqFw0sedeeRmwyFsv2eyaEvobcHgzFxENerKdbgr7Ur?=
 =?us-ascii?Q?ybWpmz2K3d5UAucydOqPBdkud9LxnPzLIUDPlWcxPJZFOiSEuqVAtYgkfRPA?=
 =?us-ascii?Q?C1n1gfwTnHpgj2wEWiuKV8IdncLl/o2facmJ69zveGAZLZw6IIejiWK58DyK?=
 =?us-ascii?Q?FRPliGCerUE0KpK8Ka2gFCb01+e/X8O4STlvUCBDPGe44GWD3mpBuf2bkXUP?=
 =?us-ascii?Q?cnOEzhsFb76bLTSR87siK0bedbfttRKVZbvs7F8pMMypICRUGQS4H8aBBCaa?=
 =?us-ascii?Q?VX1PuuEjCZxrXT8PhVxVyZoJDl+ctB57qBlQUw/0vYIQSEsQEVTWceJCJiR/?=
 =?us-ascii?Q?Em5WQCi8IIF5u70kF7uBNOm6EETYuuRssyGoeFeefDSh2SdgEtIVnOyJW8sJ?=
 =?us-ascii?Q?+guiq5pQ+vzD/Ir4Hs65Ih61xRh/OF3TqGQTKB0plrCr4fThPPNaELQNa8Co?=
 =?us-ascii?Q?3r/VcruFoskprCGC6Az206Hize45p7jqvA5hGpbVJR3hlwOl7RuwWDDiViYe?=
 =?us-ascii?Q?9jUL2C66lZJJgYUpzNT7cBOKluhiHjPAd5f3fUJnSjR1k5G/huKCLFsW/QdX?=
 =?us-ascii?Q?+YVsnyfWGJdjOJuKrWlG0dd9lSvR7mq7/2Vtmfuy0OW6QXOstMGan4n8MzIg?=
 =?us-ascii?Q?MLrqzP98QvC+inDsPBYW3GVGAB/8KpYV0iXMbRAlybdnNfSS2AIvsvqpRfeP?=
 =?us-ascii?Q?/XftDgNgTzYtG9h9UnKCQawUuNdmnoyruZ5ILL4HERi1v14XqgIxWcT3fzpT?=
 =?us-ascii?Q?jZ61zFU7xcHtEYii86rOPQxheV8+q1g=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5bfe4a5-4294-4d4a-6f53-08deed378457
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:06:23.4788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/JRflPdpQVoMkw4kx4mPFgYL3Gp2jecVhQGTnIXt57oFuIyYYx0j7XmodWcrOTSMzxW58PCwDBus/ym33LIw2eR6upZOgZ08DTBJxpF8Iw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEL0PF4D55A38B9

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

Later patches add serial interface mode switching, RS485 break handling,
and per-port private state for MUEx50-specific configuration. The driver
supports switching the serial interface mode through the RS485
configuration path, covering RS232, RS422, and RS485 modes supported by
the boards.

The final part extends 8250 core callbacks where needed so low-level
drivers can override break control and rx_trig_bytes handling. The
8250_mxpcie driver uses these hooks to implement RS485 break handling via
MUEx50 features and to expose the MUEx50 programmable RX trigger level
through the generic rx_trig_bytes sysfs interface.

---
Changes in v4:
  - Drop [PATCH v3 10/15], the workqueue-based TX wakeup patch.
  - Reorder [PATCH v3 09/15] to [PATCH v4 13/14].
  - [PATCH v4 01/14]
    - Remove the unused 8250_pcilib.h include,
      MODULE_IMPORT_NS("SERIAL_8250_PCI"), and select SERIAL_8250_PCILIB
      in Kconfig.
  - [PATCH v4 03/14]
    - Replace FIFO trigger level and flow-control threshold magic numbers
      with named default constants.
  - [PATCH v4 05/14]
    - Replace the EFR flow-control comment and magic values with named
      RX/TX field values, and use FIELD_MODIFY() to program the EFR flow
      fields.
  - [PATCH v4 06/14]
    - Split the RX decision logic into mxpcie8250_should_rx() and keep the
      IRQ path responsible for calling the generic RX handler.
  - [PATCH v4 07/14]
    - Switch the RX FIFO path to tty_prepare_flip_string() and remove
      the temporary stack buffer plus tty_insert_flip_string().
  - [PATCH v4 08/14]
    - Rework TX FIFO handling to use uart_port_tx_limited() for common
      serial-core TX handling.
  - [PATCH v4 10/14]
    - Export serial8250_do_break_ctl() with EXPORT_SYMBOL_GPL()
      instead of the SERIAL_8250_PCI namespace.
  - [PATCH v4 14/14]
    - Reuse the RX trigger default constant and change the range check to
      use port->fifosize.

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

v3: https://lore.kernel.org/all/20260709053314.435629-1-crescentcy.hsieh@moxa.com/
v2: https://lore.kernel.org/all/20260701034128.218569-1-crescentcy.hsieh@moxa.com/
v1: https://lore.kernel.org/all/20260504084900.22380-1-crescentcy.hsieh@moxa.com/

Crescent Hsieh (14):
  serial: 8250: split Moxa PCIe serial board support out of 8250_pci
  serial: 8250: add Moxa MUEx50 UART port type
  serial: 8250_mxpcie: enable enhanced mode and program FIFO trigger
    levels
  serial: 8250_mxpcie: enable automatic RTS/CTS flow control
  serial: 8250_mxpcie: offload XON/XOFF flow control to MUEx50 hardware
  serial: 8250_mxpcie: add custom handle_irq callback
  serial: 8250_mxpcie: speed up RX using memory-mapped FIFO window
  serial: 8250_mxpcie: speed up TX using memory-mapped FIFO window
  serial: 8250_mxpcie: support serial interface mode switching
  serial: 8250: allow low-level drivers to override break control
  serial: 8250_mxpcie: add break support for RS485 using MUEx50 features
  serial: 8250: allow UART drivers to override rx_trig_bytes handling
  serial: 8250_mxpcie: introduce per-port private data structure
  serial: 8250_mxpcie: implement rx_trig_bytes callbacks via MUEx50 RTL

 drivers/tty/serial/8250/8250_core.c   |   6 +
 drivers/tty/serial/8250/8250_mxpcie.c | 630 ++++++++++++++++++++++++++
 drivers/tty/serial/8250/8250_pci.c    | 208 +--------
 drivers/tty/serial/8250/8250_port.c   |  33 +-
 drivers/tty/serial/8250/Kconfig       |  10 +
 drivers/tty/serial/8250/Makefile      |   1 +
 include/linux/serial_8250.h           |   1 +
 include/linux/serial_core.h           |   3 +
 include/uapi/linux/serial_core.h      |   3 +
 9 files changed, 687 insertions(+), 208 deletions(-)
 create mode 100644 drivers/tty/serial/8250/8250_mxpcie.c

-- 
2.45.2
