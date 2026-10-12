Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010046.outbound.protection.outlook.com [52.101.46.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20364BE457;
	Mon, 12 Oct 2026 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826596; cv=fail; b=HQP9dKDXyZa8Pl2MIdYuu/uT4ACMq9DJa63/u2WQLan9j8IhDfpEK/JO65Xc+xSyHaiDPVUKkza7N6Za9yja2TdeeEKJNzapJ57330d/YBffh8/NHMcBBxi8fhMYfmCW3B5/ZiU/y4Y35QuqRJtb/b/E/f6YEreTOrkz2Y6HL9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826596; c=relaxed/simple;
	bh=dQuItktdMAPfSq3OFcBN+BGM4Ycf/gJ6DM6HyOLspK4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NJlh1gYRgGsTVOr1lEKkti0x2RoNinrxhXUbIEvkSglw4A825xnyDLSZU6+DWWLjRqACtVsIitxSm20UYf3yd6zcxUoJdkVaGqBXG3SfQP3Unl6/XXAMFFfCXZqPguattkaU88rXON0QQzb7mBQF3DawRLeg9RnMC1Z/m7BZvhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YrqXXTgg; arc=fail smtp.client-ip=52.101.46.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YrqXXTgg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUCiQHG5N+qlOYBmTb46Fx8ozPVRob5QxbUPiy+cPqK8yPVnPcUMYA1wMAcWtjdt/S9WylBTjZ1Hc7n2g1Cpp+/q4ntbdLy+L2YTrUOzcYUXAfaLxJtMjgA7leA6d5IzTFzDPMS1/welToeSLiwV4vTWd9FD66cPfASf3/7wrSKIhF3G5wk1wgtZEpLsJbVQhry1gKYdQ7dkFhMGjM1vo7637w7VE4lJNQycQ+MnNLnlzVM6+2ueoIsWjOHm6BrXT2Lw7ALEITP6PltPJ1/Ju9S6uSAf2K8C4MMiDDoNRJmeRCVIbMIzmYOc8iCfO/a3C6hX5YruSnwEPQ+JRi1Gfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaJm1RRcxQASpKfrfDq5hyVKw8O2UHkzYYvkyWeqfQ0=;
 b=Mk3SLzVv5DL22zzN9f2XY+7Z4ibHsTkuN1ssb57bfYssxzvOdebf+Ha/Jnn6o9Aq30ny/cTW9+nIv7NCfalYnM0djuvAmDE64por1svQXEghoRvHqQBlfooArhyAQWieBOq/tEo3lmGFjVWGyOlQaYDajYGqPpox0KJa0tmbiVVzSUX27qmE1RxasGjI8TppIU+flZYblsKBKt4eRFpsAeDZmDWGk2Galfxar9g927C1nufh7RW3toZtBfRslJF8CinrAG9pwhwzBZaydwqyBZzS4X0Co2D9F0a/YW/AmhqhpF8Jpu6hibQ97D+TFm+FfXaAUQ5ln9+2Cfvx12GTkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaJm1RRcxQASpKfrfDq5hyVKw8O2UHkzYYvkyWeqfQ0=;
 b=YrqXXTgg3rbiyrXUvSLZDAJzAGP/SMyaJaMcBp/IBhisYQasCFzzydcpK4hEWW0DOiuk7biTDsl3FBZJhDVdoZG3lqzsHzJpQao+FEYj5/x+RkV7PSZWykT1TbwRrr3CdZ4vE2qMEzafRhYl1jKJCPjtrQf4wJw6VaPnltBswEOUfG9AgR8Wq8DGnNsXNXDSUfX6/2iakgVhpVoS7JoA6ClgK3pbUyJwmDfbS2djUqNVuF4fcgAmRDpHTZ0sbzQldN5j46GMVRnao5KST13KDapHnUxz+XtEgMgcT8fXMBzudHzhzQOqh745xIe4pWGGtlMJdr9fSY1H0BvYgN7IDQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 17:36:25 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0496.010; Mon, 12 Oct 2026
 17:36:24 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Donald Shannon <donalds@nvidia.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Lixu Zhang <lixu.zhang@intel.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] Add NVIDIA LSTP USB adapter drivers
Date: Mon, 12 Oct 2026 20:35:58 +0300
Message-ID: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN4PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:272::17) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: a220c9bb-87f7-4a93-495a-08df2887561b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|5023799004|11063799006|56012099006|18002099003|6133799003|261009220027099003|261009221227099003|261009223327099003|261009223027099003|261009221727099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	/Re8rcOMisVIfc1bftCEWJ3iwKTQC12IYfIwED7J6fxR4242VIZWORGNqIIkK4W6iDeYFpsyNU+lzfhXV87h2eZVIwEjYm48c8Rn4dgXaDuTZ7H0BY24fNQbUONY5PlZk7RVuQgUvPaeqUR11uDwWCkXDWaW2H/MyEZXKllSydrNb9LkJmCPaVB4ydEe5VTw7t5KkMbZ0jACM5ga/Lvh164S3UOtotf7iC6VYOirGhtcD9XAjBIsNPszVVUfTZzXKuCU3XYqCBfxnsMfoirRLy0f/MrDOrXJ8lydtKFREc0UCD0HqQAUhEHYAptWy2QGAz2HO9BK1qhQIJVmXFIiFzd52Nw7rnIB+hDm8Z8Tqez82RfB92x9Clk5RU3doAPMWoWcd8KYhCVbOmfDKU3xXJLj4YxrWEYJqZtWVKmTMt9LRF94BoGlGkFwNA0XPz489aFSubgV56NmvDwbUEbec612c5eE74ln3PjV7XfdvsHxa8767ZcsQva6okXAUY9aAuTwT3qb6/qxRHCaBnMKYgz8JunmsQx8FVlOUApzxAZ2W3mD9KnsZoySJrs2db82GE44q+ziKY6zLcJvf0Clt5PHn6SgZQlz6oREfbzXI+sGdW0hLMnzlgew7ZgpxGQpMVc1bFwBL2Fj8b4U/ZxXVGZDeEJrzyhXP4p/dFpFZg8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(5023799004)(11063799006)(56012099006)(18002099003)(6133799003)(261009220027099003)(261009221227099003)(261009223327099003)(261009223027099003)(261009221727099003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cyQ1Se406MtVGl+13gPbsanXiS4CLpwUS/1HyMkTa4UxBRksJFxJj7AWeqxY?=
 =?us-ascii?Q?eHZR5DHMEvMMDrOBHVz8hIW2+71WA7E4GFlI1XnK0VC2vpUWy93MofPNuTwK?=
 =?us-ascii?Q?UvBHy9QmkaxXBuztsdf9PzBUWwWUinlAdHpQY8wu7PtPUAISuwtwb+3BeGVN?=
 =?us-ascii?Q?ZFsZClHojlisU/qxISbR0uyiARGKXHDf3vLwXAz0yLka7ewTTyQYTh4Pr0Zh?=
 =?us-ascii?Q?GyUOslIx8nLRz3WRAbolltmNHZk+kqdG2U9kI+Edfs9tW4jLoMXM2QJ+pgJr?=
 =?us-ascii?Q?ECFnIBf5VWsDUmj9S+nmUbO9JcHZeH5qbwe9NUzgAjw8ibJSnwKkM+zFsMMz?=
 =?us-ascii?Q?Y+ocFFbO4TXxYiOyp4Rus/h7sxD5+egoS0cLArWyayWR0lioZ+X+l5HhMJuA?=
 =?us-ascii?Q?GCHNoBvWNs84dDpLuWVcGIyNbAyiXcsWpBOkr/jLmsEuYSEXTCkH5ZE+PtSi?=
 =?us-ascii?Q?FIKTDH4X1v8TkkyF0yrXG3HMDC6PMRD3LQyzwB5RoUR2Kv3AP7O0jnIecn5q?=
 =?us-ascii?Q?lNnzBsF8DjiNdYSstiXN0+6IpceFFWgu+AdZ9KoyYfkjNPST8gbh8WkHdEUp?=
 =?us-ascii?Q?hQgAcRyrvrg9Iya6fNGLToJp3o0b/HsYzZiI7oW4Wkmz4MDdJKSTmv3ZnKkg?=
 =?us-ascii?Q?NrBx/Lv33gj923FOmnuIJWUCqBPu1j8tmYTQguT608eTb4KynmheWYCaH9+5?=
 =?us-ascii?Q?pNKUwCDiV9FbCwZn3SAVOPxl7oxivezbv0Js+HG91+wbr4Ag37+hTQMrJXY5?=
 =?us-ascii?Q?LBvaEJBTi/iFQEWFkj115gPAlygtDeIVYI3jhrdVlnbMdV0l+KBdaWI6Nj2i?=
 =?us-ascii?Q?U9W3Zgpx6NKD6MBslKFr4tPepOCKDbbo/qvTnbZ4J7/oATtClfE24daAPHbz?=
 =?us-ascii?Q?zaZLyW9AEDGEOef4xhH7YzokcGp7DVFeER7JFADixpx4mCSvY9vQd5oxA3Ct?=
 =?us-ascii?Q?6IPd3y2oUCxYaGWQneyr5QtBS3+W5p6TtHvmB0lr1kIXXzFUf+OOkFFqnFso?=
 =?us-ascii?Q?g8KK7kypDXG1oK2Y2wLYxSHDmr9lF7ZcZM+68zk5uh1I/aQhzPoR+BrS+AId?=
 =?us-ascii?Q?vK2NDu1Ifm6x7xgzwbsAxCg8iM3nJRdramsfGv5k/DcVmOv/6IQVpQzN4Hrc?=
 =?us-ascii?Q?NsAMLC2SyyybMcUo3wejEQoG4/P4SZLs4eGZCN9UPt7igfIxYBLgxbDMq1So?=
 =?us-ascii?Q?wa3OJ9a697tGoCcZaQc6JJbeZBPV7a3zV20SgXpJspdT1jYovEcwHLdlrBdi?=
 =?us-ascii?Q?u4p5BT3htzVgT/6N/R22EtcLkx0oFTbD96ow5PZOU7J3UnjU1cf1vBN+KBlS?=
 =?us-ascii?Q?YsB129IEDsQyBwbgpFB+zCXOuP0VFo3jYRAbhZFHvCTPcKX+ATd12mDe3lq8?=
 =?us-ascii?Q?441mKwAzSvi34yMERgxq17VJ4sbQY4hU1H+fuegPIuv5efd7OvxcxvxEwf2J?=
 =?us-ascii?Q?dJBja/i9qsqTBLMn0RBckTZIB52y/V5rVhboaYXNGPkWRnrcj27T0Cmmw2/2?=
 =?us-ascii?Q?oZ5qq5ffe+MmgAXWhXGrMLsCHJY6c0C4u0+h0x3kPjWcPa9ZNYF8wFpPJpxy?=
 =?us-ascii?Q?cWxDBRCym8SeSJs5M6oIBw5ml7Gq4LZs5Z/zs2xHnPl2Z5X3aESwkBIZLsG+?=
 =?us-ascii?Q?dWP2z/X7yB5xpRnmHceWk9JnnZtKTuKqz/QNrXq0iegAw8gxuB7MZ8g/trCi?=
 =?us-ascii?Q?ExoGHnn7AdEidpkZcjw6Dv/b4XNBdRMFJLFi70aWVYjyBm4bXs9mVItunDjR?=
 =?us-ascii?Q?wWPQTr8TFA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a220c9bb-87f7-4a93-495a-08df2887561b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 17:36:24.1364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXAhmWJ7Hynl1ltVwtRdke0wblSsqms37Jbwmnv6t8++P3VpcU8LKb4gUdHbi7otzvtiZGpkfSAvH2zVItVHoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012

This series adds drivers for the NVIDIA LSTP USB adapter: a USB core
driver and GPIO, LED, I2C, SPI, UART and BMC-side IPMI function drivers,
with their device tree bindings, an ACPI description document and the
sysfs ABI.

What LSTP is
------------

LSTP (Low-Speed Transport Protocol or Low-Speed Tunnelling Protocol) is
a vendor-specific USB interface (class 0xff, subclass 0x3f) that
multiplexes several low-speed "channels" over one pair of bulk
endpoints. It is implemented by NVIDIA's SMA, an MCU (0955:cf11), and
by other vendors' parts: two hub/bridge chips have it built in
(0424:4940, 174c:2214). Boards use it to
reach SPI flash, I2C sensors, GPIOs and LEDs, a UART and a host-to-BMC
IPMI path, on both BMCs and host systems.

The channel types are SPI host, I2C host, GPIO (with interrupts and LED
pins), UART, IPMI and MMIO. Channel 0 is the control channel: at probe
the driver reads the channel table from it, which gives each channel's
ID, type and configuration. The set of channels is decided by the
firmware, so the same VID:PID carries different channels on different
boards. No firmware description is needed for the channels to work.

Series layout
-------------

   1  dt-bindings: gpio: Add NVIDIA LSTP GPIO
   2  dt-bindings: i2c: Add NVIDIA LSTP I2C
   3  dt-bindings: spi: Add NVIDIA LSTP SPI
   4  dt-bindings: usb: Add NVIDIA LSTP USB adapter
   5  usb: misc: Add NVIDIA LSTP USB adapter driver
   6  gpio: Add NVIDIA LSTP GPIO driver
   7  leds: Add NVIDIA LSTP LED driver
   8  i2c: Add NVIDIA LSTP I2C driver
   9  spi: Add NVIDIA LSTP SPI driver
  10  tty: Add NVIDIA LSTP UART driver
  11  ipmi: Add NVIDIA LSTP IPMI BMC driver

Patch 4 $refs the schemas from patches 1-3, so it comes last among the
bindings; it also defines the serial@N and ipmi@N channel nodes inline.
The MAINTAINERS entry starts in patch 1 and gains each later patch's
files. Patch 5 carries:
- the core in drivers/usb/misc/;
- include/linux/usb/lstp.h for the function drivers;
- the sysfs ABI file;
- Documentation/driver-api/usb/lstp.rst;
- Documentation/firmware-guide/acpi/lstp.rst.

Patches 6 and 8-11 each depend only on patch 5; patch 7 (LEDs) also
needs patch 6, whose GPIO driver hands the LED pins to it.

Why the auxiliary bus, and why not MFD
--------------------------------------

The core binds the USB interface and owns everything shared:
- URBs and packet framing;
- request/response matching and the IRQ-style event path;
- channel 0 discovery.

Each channel the device reports is then created as an auxiliary device,
lstp.<type>.<id>, and the function drivers in their subsystems bind
those. They reach the device only through functions the core exports in
the "LSTP" symbol namespace, such as lstp_request() and lstp_send().

The closest model in tree is LJCA (drivers/usb/misc/usb-ljca.c), and
the series follows it. LJCA is a USB adapter that muxes GPIO, I2C and
SPI over its bulk endpoints. At probe it asks the device which
functions it has, creates one auxiliary device per reported function,
and exports a transfer and an event interface to the function drivers.
LSTP does the same with more channel types, with channel IDs assigned
by the device firmware, and with device tree as well as ACPI.

A channel has no registers, no MMIO and no interrupt lines of its own;
it is a logical function of one protocol stream, and its driver needs
nothing but the core's API. That is the use the auxiliary bus
documentation describes (Documentation/driver-api/auxiliary_bus.rst):
no dependency on a physical bus, device, register accesses or regmap.
It names MFD as the wrong fit for that case, because MFD relies on the
function devices being physical devices: an MFD cell is a platform
device, and its resources are ranges of the parent's memory and
interrupts (struct mfd_cell). Firmware matching does not decide between
the two, since MFD cells can also match DT nodes and ACPI _ADR children.

The same documentation says auxiliary devices "are not physical devices
that are controlled by DT/ACPI". An LSTP channel is not enumerated from
firmware either: it exists because the device reported it. Firmware
only describes it and what is attached to it. Before
auxiliary_device_add(), the core resolves each channel's node and sets
it with device_set_node():
- device tree: a child of the interface node the USB core attached;
- ACPI: a Device() under the interface's Device(), which is a child of
  the port companion (Documentation/firmware-guide/acpi/lstp.rst);
- neither: the channel has no firmware node and works as reported.
A channel matches on its address (reg, or _ADR on ACPI) plus
compatible. The I2C, SPI and GPIO cores then enumerate children and
resolve references as for any other controller.

The UART: a plain tty_driver (patch 10)
---------------------------------------

The firmware owns the UART line: baud rate, framing, parity and flow
control are provisioned on the device and only read at probe. The host
cannot read or set modem control lines; it can send a fixed-length
break, and a carrier loss reported by the device hangs the tty up unless
CLOCAL is set. Most of serial_core's uart_ops would be stubs, and
usb-serial does not fit because it binds the whole USB interface, where
the UART is one function among several. So patch 10 registers a plain
tty_driver (TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV) with one
tty_port per channel, the structure cdc-acm uses for a UART behind USB.

set_termios keeps the hardware fields at the firmware's values, so stty
reports the real line settings. The nodes are /dev/ttyLSTP<n>, parented
on the channel's auxiliary device. Jiri, Ilpo: if you would rather see
this on serial_core despite the empty uart_ops, please say so on
patch 10.

The IPMI channel: BMC side, with a message number (patch 11)
------------------------------------------------------------

On a BMC, the IPMI channel carries the host's IPMI requests to BMC
userspace and the responses back, like ssif_bmc does for SSIF; it is
not an SSIF transport and has no host-side (ipmi_si) part. Each channel
is a character device, /dev/ipmi-lstp<n>.

By default, each message on that node carries a one-byte message number
between the length and the payload, and a response must echo the number
of the request it answers. The number exists only on the node, not in
the LSTP protocol, and no other BMC-side IPMI driver has it. It names
the request a response is for: when the host has sent a newer request,
a late response to the older one is dropped, even if userspace has
already read the newer request. Without the number, a response answers
the request read last. With CONFIG_USB_LSTP_IPMI_MSG_NUM=n the node uses
ssif_bmc's struct ipmi_ssif_msg layout instead, so userspace written for
ssif_bmc works unchanged. Corey: is the message-number layout
acceptable as an LSTP-specific extension, or would you prefer it as an
option of the generic BMC message format (and ssif_bmc)?

Responses carry no tag
----------------------

The protocol has no request tag: the first response after a request is
its answer. Two places in the series depend on that:
- The core (patch 5) drops a response that arrives when no request is
  waiting, or after the waiting request already has its answer, and
  counts it in the channel's rx_late statistic. A surplus response (a
  reply to a request that timed out, one left from before a rebind, or
  a device answering twice) therefore cannot overwrite a response the
  waiter is still reading.
- The GPIO driver (patch 6) reads every pin's interrupt configuration
  at probe. A late reply can answer the next request and shift every
  later pin's state by one, so a single read is not retried on its
  own: after a timeout, all pins are read again, in alternating order,
  until two consecutive passes without a timeout agree. That is at most
  five passes, ending within 10 s of the first timeout, or the probe
  fails as it would without the re-read. The bound is there because
  the probe runs in the context that added the device, often the hub's
  worker.

The DT nodes for IPMI and UART channels
---------------------------------------

The USB binding (patch 4) defines serial@N and ipmi@N channel nodes with
only compatible, reg and status. They exist for status = "disabled",
which stops a channel the firmware reports from being created on a
board where it must not be exposed. Without a node, a channel is still
created. The binding shape, including one vendor property
(nvidia,retries on the I2C channel), is discussed in a separate mail to
the DT maintainers sent with this series:
https://lore.kernel.org/r/20261012-lstp-dt-rfc-v1-aambrozewicz@nvidia.com

What is not in this series
--------------------------

- The MMIO channel stays out of tree: raw register access, with no
  binding and no kernel consumer.
- No auto-created spidev. The out-of-tree driver has a module parameter
  that creates a spidev on every chip select of an undescribed SPI
  channel; it is not part of this series. With CONFIG_SPI_DYNAMIC,
  userspace does that through the controller's new_device attribute:

    echo "spidev <cs>" > /sys/class/spi_master/spi<B>/new_device

  (Documentation/ABI/testing/sysfs-class-spi-master)
- No separate IPMI POST-code node and no debug fault injection; both
  stay in the out-of-tree package.

Testing
-------

The drivers were tested on arm64 and x86_64 with four kinds of device:
- real endpoints, the SMA and other vendors' implementations, driven by
  the hardware test suite of the out-of-tree package on Raspberry Pi
  hosts;
- a real SMA passed through over USB to QEMU guests running
  v7.3-rc5 with this series;
- an emulated endpoint, a raw-gadget program on dummy_hcd, playing
  scripted protocol scenarios;
- the same emulator mutating its replies at random.

The test plan covers:
- every channel type end to end: SPI flash identification, write and
  read-back verification and throughput through spidev; I2C transfers;
  GPIO values, interrupts, line names and hogs; LED default states,
  brightness and hardware patterns; UART and IPMI traffic; concurrent
  traffic on all channels;
- firmware descriptions: ACPI SSDTs and device tree overlays in many
  variants, including incomplete, mismatched and outdated ones;
- lifetime: channel driver, USB interface and module unbind, rebind and
  removal, USB disconnect and reset, with nodes open and consumers
  attached, under load, and with nodes opened as soon as they appear;
- protocol faults: late, duplicate, missing and malformed replies, and
  a disconnect in the middle of a transfer;
- allocation failures injected across the interface bind and unbind,
  the function driver probes, open, read and module load.

The kernels used KASAN with kmemleak, KCSAN and KMSAN; lockdep with
PROVE_RCU, DEBUG_OBJECTS, DEBUG_LIST, DEBUG_KOBJECT_RELEASE,
DEBUG_ATOMIC_SLEEP and UBSAN; and failslab, fail_page_alloc and
fail-nth for fault injection. None of them reported a problem in these
drivers. The only reports involving them came from gpiolib when a GPIO
chip is removed with lines still requested; the fixes are posted
separately:
https://lore.kernel.org/r/20261012-gpiolib-chip-removal-v1-0-aambrozewicz@nvidia.com

Per patch, on the posted base: each patch builds (allmodconfig, W=1,
LSTP objects) on x86_64 with gcc and clang and on arm64 and arm with
gcc; sparse; kernel-doc; checkpatch --strict (clean apart from two
MACRO_ARG_REUSE checks in patch 5); dt_binding_check on each binding;
make htmldocs adds no warnings.

The out-of-tree package these drivers come from is at
https://github.com/NVIDIA/lstp_module; the version these patches match
is the public-next-v1 tag:
https://github.com/NVIDIA/lstp_module/tree/public-next-v1
It stays as the backport for kernels without this series.

Base: usb-next at bbf6b99a57b2 ("usb: typec: ucsi_ccg: Add retry
mechanism in ccg_read").

Adrian Ambrozewicz (11):
  dt-bindings: gpio: Add NVIDIA LSTP GPIO
  dt-bindings: i2c: Add NVIDIA LSTP I2C
  dt-bindings: spi: Add NVIDIA LSTP SPI
  dt-bindings: usb: Add NVIDIA LSTP USB adapter
  usb: misc: Add NVIDIA LSTP USB adapter driver
  gpio: Add NVIDIA LSTP GPIO driver
  leds: Add NVIDIA LSTP LED driver
  i2c: Add NVIDIA LSTP I2C driver
  spi: Add NVIDIA LSTP SPI driver
  tty: Add NVIDIA LSTP UART driver
  ipmi: Add NVIDIA LSTP IPMI BMC driver

 .../ABI/testing/sysfs-bus-usb-devices-lstp    |  331 ++
 .../bindings/gpio/nvidia,lstp-gpio.yaml       |  276 ++
 .../bindings/i2c/nvidia,lstp-i2c.yaml         |   71 +
 .../bindings/spi/nvidia,lstp-spi.yaml         |   68 +
 .../devicetree/bindings/usb/nvidia,lstp.yaml  |  280 ++
 Documentation/driver-api/usb/index.rst        |    1 +
 Documentation/driver-api/usb/lstp.rst         |  276 ++
 Documentation/firmware-guide/acpi/index.rst   |    1 +
 Documentation/firmware-guide/acpi/lstp.rst    |  419 +++
 MAINTAINERS                                   |   21 +
 drivers/char/ipmi/Kconfig                     |   32 +
 drivers/char/ipmi/Makefile                    |    1 +
 drivers/char/ipmi/ipmi-lstp.c                 |  464 +++
 drivers/gpio/Kconfig                          |   14 +
 drivers/gpio/Makefile                         |    1 +
 drivers/gpio/gpio-lstp.c                      | 1194 +++++++
 drivers/i2c/busses/Kconfig                    |   13 +
 drivers/i2c/busses/Makefile                   |    1 +
 drivers/i2c/busses/i2c-lstp.c                 |  573 ++++
 drivers/leds/Kconfig                          |   14 +
 drivers/leds/Makefile                         |    1 +
 drivers/leds/leds-lstp.c                      |  404 +++
 drivers/spi/Kconfig                           |   13 +
 drivers/spi/Makefile                          |    1 +
 drivers/spi/spi-lstp.c                        |  316 ++
 drivers/tty/Kconfig                           |   13 +
 drivers/tty/Makefile                          |    1 +
 drivers/tty/lstp_tty.c                        |  829 +++++
 drivers/usb/misc/Kconfig                      |   15 +
 drivers/usb/misc/Makefile                     |    1 +
 drivers/usb/misc/lstp.c                       | 2983 +++++++++++++++++
 include/linux/usb/lstp.h                      |  219 ++
 32 files changed, 8847 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-usb-devices-lstp
 create mode 100644 Documentation/devicetree/bindings/gpio/nvidia,lstp-gpio.yaml
 create mode 100644 Documentation/devicetree/bindings/i2c/nvidia,lstp-i2c.yaml
 create mode 100644 Documentation/devicetree/bindings/spi/nvidia,lstp-spi.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/nvidia,lstp.yaml
 create mode 100644 Documentation/driver-api/usb/lstp.rst
 create mode 100644 Documentation/firmware-guide/acpi/lstp.rst
 create mode 100644 drivers/char/ipmi/ipmi-lstp.c
 create mode 100644 drivers/gpio/gpio-lstp.c
 create mode 100644 drivers/i2c/busses/i2c-lstp.c
 create mode 100644 drivers/leds/leds-lstp.c
 create mode 100644 drivers/spi/spi-lstp.c
 create mode 100644 drivers/tty/lstp_tty.c
 create mode 100644 drivers/usb/misc/lstp.c
 create mode 100644 include/linux/usb/lstp.h


base-commit: bbf6b99a57b2479bf51c3c8ad0946f4b8c33ed69
-- 
2.43.0

