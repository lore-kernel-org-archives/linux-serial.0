Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C524C224A;
	Mon, 12 Oct 2026 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791826657; cv=fail; b=MgvVbx8QEXkALDexRKmrF7n+KfzqurNOgZShi8WJHdM1xjnUaSJ5xPnQkeV1l1o5drDRZUDGVph+0HTKscP4wnNC8Xj+IcsH8uYNl4bnWrJDLhkGEIglgpBdXPPaqTvdMrqqfstrqPk2ZQ33U5EPlegkbETlKyD/tjuJ1ivPDOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791826657; c=relaxed/simple;
	bh=YgVAVExV0c6fXyC+9CxFOrQ06n5DLu72+iUJPFvKICQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ge+44c3iEGpsiolENYGrgD+1zlQ10J3mddswo/+aUWy9PZkhRhsb8xkhi2NqgeHJEgXgmRAAvG+vc9qyWXXSYKBVVsVby2zJFyFWRNXrUy6zMtrBQvTGpUGq+TipCrq6p1GbOiYONIzjBsSwRdK6eo5ocQ10H84kvJ8nVcxcNw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GCnKnedm; arc=fail smtp.client-ip=40.107.208.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GCnKnedm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgDaOBuMVsc4Ly0GtnUNUtdBD9bw83YXXnkje99zQYjHd4c9Y+gUz5h/mtBZjbwpjIr6kpMIeWONVHs2FxA3GdiqEuJCuklaABblpF8De9tbnRzbwWD8dMG0ZZVxhUh44+XRNGsHMGmCIoImyl/2YXuk7KFk/wZeg+qxBuIaPAe7Sels9i32kVgxUpsEh8bJghyqVxxjaNda1HRUATHcvCBez6jtRfy/yDOoL+MXIRgh8z7EUG+5E//XKQzgMg9yaqtgHXejDuNETZQ3HIZvp95jgBU5yu4WaynkLkcjdTufH0v3EA2LcQ/vc4Rm3cRAEYGgUHp+DYR4XJBSb4me8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8xlZ1FFyklhVhbnVvjx/1C/9nuc+i1NUOTPufy4oqc=;
 b=Nx7KvjDZgDLkKMlrsD5bWI6QQnwnoxnpv88UpOs6P8PUoqMgQFFGUQzd3ES790QEyct602Mm6OcEyW6Bme3RyMshl7tJhz8EDJfHcrTk9w1meReIyu7YKkmW8bkzcv/4/8kK3GP+suyt4qlyi9tAryJ4VICoI3eAPZoYP3p5CfKfBgEssF5IvluaD0XWdFRgUDpDpbKzlWBjE1afbAFSDAGa4kU35w+J86YPer50uiOGpUuPcNwUerpOgWHUNM4s/KycQBT5ptNQ5w8WGRyMkGuHdnvubPXkV6DPFyFe8H8NSFHE0mnkZwUZkBMVS/kSpNuJWOHHw5sOQo/BBzfA0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8xlZ1FFyklhVhbnVvjx/1C/9nuc+i1NUOTPufy4oqc=;
 b=GCnKnedm2BjW8uNfoHE2vUHfb3ce5pY5TuUKFSEH8c5arDNOHOblLk1u1sbvUNYyjJOjKpUWzaaQI8Jj1W2B6YQdVx5jDkWSmSjq5tMrIYeqsJvGLBL6TKT+GGirPpnGaO/FwUOmenguh+5tPCHpcz59yYrHa9SPkHNe89RsLIJcGIRpJXX3hBQrav6CEW3f3xW/Ka9xHlmQdmIRYZQOmdFFg44zRdfFXKfkuskCI+97BYIxAahVN72ac/nFMpEkUnVNoacYGRGiw+6q3dE59pH02cWyPabczZ/nNZg2doRpahZybLYgo2IIrre38ZCgKcBRYGED3hZSsagk7tzmnA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5974.namprd12.prod.outlook.com (2603:10b6:510:1d9::19)
 by PH0PR12MB7012.namprd12.prod.outlook.com (2603:10b6:510:21c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 12 Oct
 2026 17:37:28 +0000
Received: from PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0]) by PH7PR12MB5974.namprd12.prod.outlook.com
 ([fe80::f5a5:bbc3:e9da:f8a0%3]) with mapi id 15.21.0496.010; Mon, 12 Oct 2026
 17:37:28 +0000
From: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Donald Shannon <donalds@nvidia.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	llvm@lists.linux.dev,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 10/11] tty: Add NVIDIA LSTP UART driver
Date: Mon, 12 Oct 2026 20:36:08 +0300
Message-ID: <20261012-lstp-usb-adapter-v1-10-aambrozewicz@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>
References: <20261012-lstp-usb-adapter-v1-0-aambrozewicz@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PEPF000067EF.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::2b) To PH7PR12MB5974.namprd12.prod.outlook.com
 (2603:10b6:510:1d9::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5974:EE_|PH0PR12MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: d2bd1612-736b-4ce2-cb26-08df28877c1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|5023799004|11063799006|56012099006|22082099003|18002099003|6133799003|261009221227099003|261009223027099003|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	AnUJs0bTpDY0KmuUMBNN8QCQlwYyOfdAc3bJgh92cjNk2j2Ftdk48ss30ZV2ZwMfdllrX9lRL90/Uh7PqIK9D7awxpDZOeVx1D7feO3rPMVu/5/os8e9VKkAIy6hRlcftUixRQsVCp/sC6bNSF0MRYMpb/gIS/+0SsVzTxYFqgv+9tDKYk5Q7wL6lR8AJziZv2ExtYaG1SXKcKSqwISKM0BfA9tSfed041byhN3D/J2QcuR4QdvpO+Ch7nOQq5W3P1qPQNu6J0B23TfvSzqR0TRXW3naN12tsRcvK5JQGWBZaLOeOMNa4nrdATHKyX0h0VgVuNvz7u75fPjD/uGGCoH4GOIepb1LTGGCot41dbtQogy6nIgHsr6SGXGJvvhK/1/hA+DietI9zFNevOEfmiBxW2o3r/yjapOpaZCw5jri8Rlfg0+pgQdAm2otwFq/H3IQ9/hApsygJokt7RDCjIM3wE1yj3DqpZJRWiU2Jxzzyba3uPe8EIWBTup7/JhpK1VsnW3qFygy5QsXHTMbmi9qM/zMLloEyATFNgx8rC3PJW+EMeAArhqSO9Lkwh/1xnd12ksMUTfQb0xl5Rq8siFpl/dRJpzyVuvloVFdnCTvYurumJkAxur7XRB4lXw5/mMIW0E4IQ4P5syswQ8MpAYDtaa4jRb+CGHTUwWfEa0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5974.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003)(261009221227099003)(261009223027099003)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnBiQnlkNlZDNFNTWTJ0Yld3YW55eTVRaVowcDArSG9iUzd5MTVYUWFBcjFx?=
 =?utf-8?B?TW9qbWhBQmhTVDhpclhrT09PSUIrRjFjcXBjWisra1RkLy9hbHROZ1k5cVZq?=
 =?utf-8?B?QXdLWVI4bmpNSDFzamdlQW9aS2RSd1lsVnprbHVra0Jsd2htY2EzbW96OGxz?=
 =?utf-8?B?ajlIS0cwM28zNnFjNmJxN3pGNDBMdW5CYnZJMHIrWkVucGhuR1RMWE1tVG9T?=
 =?utf-8?B?SzllTDQ3VmJKRVRGeTd3REVmRUVPUTNVMjhvN3UzcWw2U2hyQmlLckRNd25X?=
 =?utf-8?B?VVMrLzBTSHMzVitxVjRXZFlnQXdxR0VETXRFbElpcy8zNGVvNC93anRWMk9J?=
 =?utf-8?B?a01mNGZiUFlJWFFIT0toaHN0OUtibTVNVm5Yd01oWmRMa1VaeG5CbUIyUm1Z?=
 =?utf-8?B?Zk83ZDQvWlN6cldOcTAwUG1zTnl3ZytQT0pPQzNPdml5ZVVpQ0U5TlJsSDF6?=
 =?utf-8?B?bUVmQjk5bUZZVEV2WkhPbGVyL1ROdVBMQXhiWU9SMFBHY2hTKzlUcERTVk96?=
 =?utf-8?B?UUFxL1hvOGVvd0s1UTZ1NVhsZTVpYW03WDFvcE1UYmdtTUNjM3FaanlnSUli?=
 =?utf-8?B?OFkveDAwcW9oQkpzS3VBK3RjVWkvZkpVQlFkSEJJeFFXcmMvNldYQ2VERm1H?=
 =?utf-8?B?RmNyVDBmUG9WcVVPUURBUEZhYXNUUGpvajhrc0E2SXBoSnBKcDlIaUZBNTE0?=
 =?utf-8?B?R2J0Myt6NVRhVVc4OE5oZTZ1UUVHMG9iS3hnMHNuaWIzeTYzOUlxblBVN3o2?=
 =?utf-8?B?YTZ2cXNXWXZQSWZlSnFmSDVmQkRLVmFuc2owMllwS25ZeWNnSDgzZ25UQXNi?=
 =?utf-8?B?QzBjcXdjdlVNVHBNSVlyeUVFTkRRek5xaTVvSmRNeXI1Tk5SYXh0NThqOFNu?=
 =?utf-8?B?Sm5qN0ljZDNqS3Nha3RZN3ZwOEJueFlTblhBV2R3TGhNdG93YnhyYmpkSzJH?=
 =?utf-8?B?Z2kvL1dFMUJ3bjEzYUliRTB0eVg2VUdlSW9lUlNwUUpkcVc5WWlpZWsrZUpS?=
 =?utf-8?B?NUVZcXk4ZWYyOEZtdEV1d1Fia2ptWjB2dUF3alliYVh1Qnd5UEkxWXg5Y001?=
 =?utf-8?B?bmVKS2h3N2tXaTdKR3B2RTEvZ3llcEYwU1hZMHpIWnZpcjlVZ005VXM1WDA2?=
 =?utf-8?B?YmM3MitNdUVIRW12c0pBVkF4ZmJtVFhuTnFlSUNRSWxRc21SUkF5RlVsZk90?=
 =?utf-8?B?TGhweUNLNXNsOXpBNkdIQnRKOWJXTU9MZ0U5STV0eEdBU0U2WnA0OXcxMGx0?=
 =?utf-8?B?aTdjSllSZnZlUWdkeG9rVHBrYTczTjhpTUVyMEJkcnJaanhLQ2RLTnBnYS9n?=
 =?utf-8?B?Vk1Md2RIdm90ek0zMm96cGNJSStGOTJzcTUvb1YzWll1Z1ZpY3NPTlZCem9j?=
 =?utf-8?B?MTlPQTRwQzRVdVpyM052anYrdnY2d3JrN1JzQ0o2UFRaQ0FiTUtGaDBLeHFO?=
 =?utf-8?B?eU5CMm5GSnMycitVSmtOcVZ1T0ViaGUyb1lmdGdoU2Uwc1pwdnNNdjBQa2t4?=
 =?utf-8?B?NnlPZVk5MWZzL2dHaXczK0hoaWlyS2JhVkVKVytOV01XMCtqUFhzWU9ONlFS?=
 =?utf-8?B?N3VneitJRmNYNUtuUDNTVGpLMlFQa1JERklvQXE0WXQxOTA1WWdGM1JmSkU3?=
 =?utf-8?B?UStOdFNtb0J4U3hwckgzUkc2d2JUNDc3WGgycldQMGwycW1xNWE3c2VaZHU5?=
 =?utf-8?B?SG9UTUVUYkViMDRCRWZrb0VBVFNkdDl3b3UzWndRTkVuYXNZLzRyaUV6OXZO?=
 =?utf-8?B?ZVJ1OS91eFphcDlDWWhlOTAxUXBEK01EbG5Tc1lLVFA5MmVKb09xaWJiNkZy?=
 =?utf-8?B?bVFuai9JNFg3a1FVVFhjL0tNRHVlblhPbkUvUmxHMzdhTGN1WEYraUoxNnVl?=
 =?utf-8?B?RjZYMFUzT2c2b0RDdGxxWGNyY0dMb29wUkswb29JVDVLa1k1cXdWYXdVMDdu?=
 =?utf-8?B?dE5YZ3BGdFNtSDNlRGVUM3kwZ2xtNHNQYS8zSVRIUmhNSzFiM1hnL0J6S2lr?=
 =?utf-8?B?bG14OUx1akxLV2MyNjFPT3B1ZHplakd0cW1XZUpremRUOXZIZW1HaXFSeUty?=
 =?utf-8?B?STZSNTRJS1gxdFYzTGRFVHh2VksxeWlwSDBTcXRsZFcxZGJ2ZE9EOVdlSlda?=
 =?utf-8?B?UVRwb2w5bWs1UWFDWEdjNy9vNGdzTHVuTWlmTjY5L20xci9JeWJQZ04ra0ht?=
 =?utf-8?B?d2F4cjNrUGdRWVVCOHU4dmFMdld2R2ZBQUtQZVhtSEZSaHBZOElrc3J4S0Fl?=
 =?utf-8?B?NHRnTVNvMWNjdjNhTG40WVM2YzdsbktISi9ScUFYajhpcTI4dTJsV0JsV29s?=
 =?utf-8?B?akNHczlCcWd5dS9UZmxITUpNTVZoT2pSVmNoemRkMTllUGdQY1Z3UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2bd1612-736b-4ce2-cb26-08df28877c1c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5974.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 17:37:28.2162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNr8ELJ1g7A2szpuABUxdPlGQufVb+fjgl0VXohehChmJuHJpKuTRHIlN6bhnhcyNV+/AoxZzJ7ISgk2oC1w0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7012

Add a driver for the UART channels of NVIDIA LSTP USB adapters. Each
channel is registered as a tty device, ttyLSTP<n>, whose parent is the
channel's auxiliary device.

The device firmware owns the line: baud rate, framing, parity and flow
control are provisioned on the device and only read at probe. The host
cannot read or set modem control lines; it can send a fixed-length
break, and a carrier loss reported by the device hangs the tty up unless
CLOCAL is set. Most of serial_core's uart_ops would be stubs, so the
driver registers a plain tty_driver with one tty_port per channel, as
cdc-acm, the greybus UART and sdio_uart do for UARTs reached through
another bus. set_termios keeps the hardware fields at the firmware's
values, so stty reports the real line settings.

Signed-off-by: Adrian Ambrozewicz <aambrozewicz@nvidia.com>
---
 MAINTAINERS            |   1 +
 drivers/tty/Kconfig    |  13 +
 drivers/tty/Makefile   |   1 +
 drivers/tty/lstp_tty.c | 829 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 844 insertions(+)
 create mode 100644 drivers/tty/lstp_tty.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 081e3f32c840..8e58895b7d5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19581,6 +19581,7 @@ F:	drivers/gpio/gpio-lstp.c
 F:	drivers/i2c/busses/i2c-lstp.c
 F:	drivers/leds/leds-lstp.c
 F:	drivers/spi/spi-lstp.c
+F:	drivers/tty/lstp_tty.c
 F:	drivers/usb/misc/lstp.c
 F:	include/linux/usb/lstp.h
 
diff --git a/drivers/tty/Kconfig b/drivers/tty/Kconfig
index 5d6b0dd4d423..34a86259b537 100644
--- a/drivers/tty/Kconfig
+++ b/drivers/tty/Kconfig
@@ -406,6 +406,19 @@ config RPMSG_TTY
 	  To compile this driver as a module, choose M here: the module will be
 	  called rpmsg_tty.
 
+config LSTP_TTY
+	tristate "NVIDIA LSTP UART support"
+	depends on USB_LSTP
+	default USB_LSTP
+	help
+	  Say Y or M here to support the UART channels of NVIDIA LSTP USB
+	  adapters. Each channel is registered as a tty device named
+	  ttyLSTP<n>, so the usual serial tools and line disciplines work
+	  on top of it.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called lstp_tty.
+
 endif # TTY
 
 source "drivers/tty/serdev/Kconfig"
diff --git a/drivers/tty/Makefile b/drivers/tty/Makefile
index c6a063a541fd..c352adda5cfc 100644
--- a/drivers/tty/Makefile
+++ b/drivers/tty/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_GOLDFISH_TTY)	+= goldfish.o
 obj-$(CONFIG_MIPS_EJTAG_FDC_TTY) += mips_ejtag_fdc.o
 obj-$(CONFIG_VCC)		+= vcc.o
 obj-$(CONFIG_RPMSG_TTY)		+= rpmsg_tty.o
+obj-$(CONFIG_LSTP_TTY)		+= lstp_tty.o
diff --git a/drivers/tty/lstp_tty.c b/drivers/tty/lstp_tty.c
new file mode 100644
index 000000000000..64894eca16ee
--- /dev/null
+++ b/drivers/tty/lstp_tty.c
@@ -0,0 +1,829 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UART driver for LSTP USB interface.
+ *
+ * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES.  All rights reserved.
+ */
+
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/serial.h>
+#include <linux/termios.h>
+#include <linux/tty.h>
+#include <linux/tty_buffer.h>
+#include <linux/tty_driver.h>
+#include <linux/tty_flip.h>
+#include <linux/workqueue.h>
+#include <linux/xarray.h>
+
+#include <linux/usb/lstp.h>
+
+enum lstp_uart_cmd {
+	LSTP_UART_CMD_WRITE = 0x00,
+};
+
+struct lstp_uart_config {
+	__le32 speed;
+	u8 data_bits;
+	u8 stop_bits;
+	u8 parity_flow; /* [3:0] parity, [7:4] flow control */
+} __packed;
+
+#define LSTP_UART_CFG_PARITY(pf) ((pf) & 0x0F)
+#define LSTP_UART_CFG_FLOW(pf) (((pf) >> 4) & 0x0F)
+
+enum lstp_uart_parity {
+	LSTP_UART_PARITY_NONE = 0,
+	LSTP_UART_PARITY_ODD = 1,
+	LSTP_UART_PARITY_EVEN = 2,
+	LSTP_UART_PARITY_MARK = 3,
+	LSTP_UART_PARITY_SPACE = 4,
+};
+
+enum lstp_uart_flow {
+	LSTP_UART_FLOW_NONE = 0,
+	LSTP_UART_FLOW_XONXOFF = 1,
+	LSTP_UART_FLOW_RTSCTS = 2,
+	LSTP_UART_FLOW_DTRDSR = 3,
+};
+
+/* clang-format off */
+
+/* Tag bits OR'd into the WRITE command byte. */
+#define LSTP_UART_TAG_CARRIER_DOWN BIT(6) /* dev→host: carrier lost */
+#define LSTP_UART_TAG_TX_OVERRUN   BIT(5) /* dev→host: TX data dropped */
+#define LSTP_UART_TAG_BREAK_DET    BIT(4) /* dev→host: break detected */
+#define LSTP_UART_TAG_GEN_BREAK    BIT(3) /* host→dev: send break */
+
+/* clang-format on */
+
+/* Bits [1:0] = command; [6:2] = tags; [7] = req/resp flag. */
+#define LSTP_UART_CMD_MASK GENMASK(1, 0)
+
+/* Firmware NACKs WRITE on a full TX FIFO; 5 x 10 ms covers a 500-byte drain at 115200. */
+#define LSTP_UART_NAK_MAX_RETRIES 5
+#define LSTP_UART_NAK_RETRY_DELAY_MS 10
+
+#define LSTP_UART_MINORS 256
+
+/* TX coalesces: lstp_tty_write() appends to @coal_buf, write_work drains @tx_snapshot. */
+struct lstp_uart_ctx {
+	struct tty_port port;
+	struct lstp_channel *ch;
+	int minor;
+	bool registered; /* tty device live for @minor; under lstp_minors_lock */
+	size_t max_payload;
+	tcflag_t hw_cflag;
+	tcflag_t hw_iflag;
+
+	spinlock_t write_lock; /* protects the TX fields below and @iocount.tx */
+	u8 *coal_buf;
+	u8 *tx_snapshot; /* stable copy handed to lstp_request() */
+	size_t coal_len;
+	size_t tx_inflight_len;
+	bool tx_in_flight;
+	struct work_struct write_work;
+
+	/*
+	 * Each field is written under one lock -- @write_lock for tx, the
+	 * channel's irq_cb_lock for the rest -- and read under neither by
+	 * lstp_tty_get_icount(), so writes use WRITE_ONCE() and reads READ_ONCE().
+	 */
+	struct serial_icounter_struct iocount;
+};
+
+static struct tty_driver *lstp_tty_driver;
+
+static DEFINE_XARRAY_ALLOC(lstp_minors);
+/* Nests inside tty_lock; never hold it across tty_vhangup(), which takes tty_lock. */
+static DEFINE_MUTEX(lstp_minors_lock);
+
+static int lstp_alloc_minor(struct lstp_uart_ctx *ctx)
+{
+	u32 minor;
+	int ret;
+
+	guard(mutex)(&lstp_minors_lock);
+	ret = xa_alloc(&lstp_minors, &minor, ctx, XA_LIMIT(0, LSTP_UART_MINORS - 1), GFP_KERNEL);
+	return ret ? ret : minor;
+}
+
+/*
+ * Called only from lstp_port_destruct(), so the minor stays reserved for the
+ * life of the port: recycling it earlier would let an open of the reused
+ * index resolve through driver->ttys[] to the previous port's tty.
+ */
+static void lstp_free_minor(struct lstp_uart_ctx *ctx)
+{
+	guard(mutex)(&lstp_minors_lock);
+
+	if (ctx->minor < 0)
+		return;
+
+	xa_erase(&lstp_minors, ctx->minor);
+	ctx->minor = -1;
+}
+
+/*
+ * Resolve a live port by minor, taking a tty_port reference under the lock
+ * lstp_port_destruct() erases the entry under. The context pins its channel,
+ * so @ctx->ch is valid while the reference is held. The entry outlives
+ * @registered: a minor between unbind and destruction is found and refused.
+ */
+static struct lstp_uart_ctx *lstp_get_by_minor(unsigned int minor)
+{
+	guard(mutex)(&lstp_minors_lock);
+	struct lstp_uart_ctx *ctx = xa_load(&lstp_minors, minor);
+
+	if (!ctx || !ctx->registered || lstp_channel_disconnected(ctx->ch))
+		return NULL;
+
+	/* Fails once the last put is in, ahead of the destructor's erase. */
+	if (!tty_port_get(&ctx->port))
+		return NULL;
+	return ctx;
+}
+
+/* clang-format off */
+static speed_t lstp_baud_to_speed(u32 baud)
+{
+	static const struct {
+		u32     baud;
+		speed_t speed;
+	} map[] = {
+		{      50, B50      }, {      75, B75      }, {     110, B110     },
+		{     134, B134     }, {     150, B150     }, {     200, B200     },
+		{     300, B300     }, {     600, B600     }, {    1200, B1200    },
+		{    1800, B1800    }, {    2400, B2400    }, {    4800, B4800    },
+		{    9600, B9600    }, {   19200, B19200   }, {   38400, B38400   },
+		{   57600, B57600   }, {  115200, B115200  }, {  230400, B230400  },
+		{  460800, B460800  }, {  500000, B500000  }, {  576000, B576000  },
+		{  921600, B921600  }, { 1000000, B1000000 }, { 1152000, B1152000 },
+		{ 1500000, B1500000 }, { 2000000, B2000000 }, { 2500000, B2500000 },
+		{ 3000000, B3000000 }, { 3500000, B3500000 }, { 4000000, B4000000 },
+	};
+
+	for (size_t i = 0; i < ARRAY_SIZE(map); i++)
+		if (map[i].baud == baud)
+			return map[i].speed;
+
+	return B0;
+}
+
+/* clang-format on */
+
+static tcflag_t lstp_build_cflag(const struct lstp_uart_config *cfg)
+{
+	tcflag_t cflag = CREAD | HUPCL | CLOCAL;
+	u8 parity = LSTP_UART_CFG_PARITY(cfg->parity_flow);
+	u8 flow = LSTP_UART_CFG_FLOW(cfg->parity_flow);
+
+	cflag |= lstp_baud_to_speed(le32_to_cpu(cfg->speed));
+
+	switch (cfg->data_bits) {
+	case 5:
+		cflag |= CS5;
+		break;
+	case 6:
+		cflag |= CS6;
+		break;
+	case 7:
+		cflag |= CS7;
+		break;
+	default:
+		cflag |= CS8;
+		break;
+	}
+
+	if (cfg->stop_bits == 2)
+		cflag |= CSTOPB;
+
+	switch (parity) {
+	case LSTP_UART_PARITY_ODD:
+		cflag |= PARENB | PARODD;
+		break;
+	case LSTP_UART_PARITY_EVEN:
+		cflag |= PARENB;
+		break;
+	case LSTP_UART_PARITY_MARK:
+		cflag |= PARENB | PARODD | CMSPAR;
+		break;
+	case LSTP_UART_PARITY_SPACE:
+		cflag |= PARENB | CMSPAR;
+		break;
+	}
+
+	if (flow == LSTP_UART_FLOW_RTSCTS)
+		cflag |= CRTSCTS;
+
+	return cflag;
+}
+
+static tcflag_t lstp_build_iflag(const struct lstp_uart_config *cfg)
+{
+	if (LSTP_UART_CFG_FLOW(cfg->parity_flow) == LSTP_UART_FLOW_XONXOFF)
+		return IXON | IXOFF;
+	return 0;
+}
+
+static int lstp_uart_parse_config(struct lstp_uart_ctx *ctx, struct lstp_channel *ch,
+				  const struct lstp_uart_config *cfg)
+{
+	static const char parity_chars[] = "NOEMS";
+	u8 parity = LSTP_UART_CFG_PARITY(cfg->parity_flow);
+
+	ctx->hw_cflag = lstp_build_cflag(cfg);
+	ctx->hw_iflag = lstp_build_iflag(cfg);
+
+	dev_dbg(ch->dev, "%s: ch_%d: %u baud, %u%c%c, parity %u, flow %u\n", __func__, ch->ch_id,
+		le32_to_cpu(cfg->speed), cfg->data_bits, cfg->stop_bits == 2 ? '2' : '1',
+		parity < sizeof(parity_chars) - 1 ? parity_chars[parity] : '?', parity,
+		LSTP_UART_CFG_FLOW(cfg->parity_flow));
+
+	return 0;
+}
+
+static int lstp_uart_send_with_retry(struct lstp_uart_ctx *ctx, u8 cmd, const void *payload,
+				     size_t len)
+{
+	struct lstp_channel *ch = ctx->ch;
+	int lstp_status = LSTP_NACK;
+	int ret = 0;
+	int attempt;
+
+	for (attempt = 0; lstp_status == LSTP_NACK && attempt < LSTP_UART_NAK_MAX_RETRIES;
+	     attempt++) {
+		if (attempt)
+			fsleep(LSTP_UART_NAK_RETRY_DELAY_MS * USEC_PER_MSEC);
+
+		ret = lstp_request(ch, cmd, payload, len, NULL, 0, NULL, &lstp_status);
+	}
+
+	if (ret && ret != -ENODEV)
+		dev_warn_ratelimited(ch->dev,
+				     "%s: ch_%d: Failed to write after %d attempt(s) (%pe)\n",
+				     __func__, ch->ch_id, attempt, ERR_PTR(ret));
+
+	return ret;
+}
+
+/* @tx_snapshot is written only here, so it stays stable across the retry loop. */
+static void lstp_uart_write_work(struct work_struct *work)
+{
+	struct lstp_uart_ctx *ctx = container_of(work, struct lstp_uart_ctx, write_work);
+	size_t len;
+
+	scoped_guard(spinlock_irqsave, &ctx->write_lock) {
+		len = ctx->coal_len;
+		if (len == 0)
+			return;
+		memcpy(ctx->tx_snapshot, ctx->coal_buf, len);
+		ctx->coal_len = 0;
+		ctx->tx_in_flight = true;
+		ctx->tx_inflight_len = len;
+	}
+
+	tty_port_tty_wakeup(&ctx->port);
+
+	int ret = lstp_uart_send_with_retry(ctx, LSTP_UART_CMD_WRITE, ctx->tx_snapshot, len);
+
+	scoped_guard(spinlock_irqsave, &ctx->write_lock) {
+		ctx->tx_in_flight = false;
+		if (!ret)
+			WRITE_ONCE(ctx->iocount.tx, ctx->iocount.tx + len);
+		if (ctx->coal_len > 0)
+			schedule_work(&ctx->write_work);
+	}
+
+	tty_port_tty_wakeup(&ctx->port);
+}
+
+/* ops->irq_packet: push RX into the flip buffer, NACKing when full so firmware retries. */
+static void lstp_uart_irq_callback(struct lstp_channel *ch, struct lstp_packet *pkt)
+{
+	struct lstp_uart_ctx *ctx = ch->priv;
+	u16 rx_len = le16_to_cpu(pkt->hdr.length);
+	u8 cmd = pkt->hdr.cmd;
+	bool have_break = cmd & LSTP_UART_TAG_BREAK_DET;
+	bool carrier_down = cmd & LSTP_UART_TAG_CARRIER_DOWN;
+	bool tx_overrun = cmd & LSTP_UART_TAG_TX_OVERRUN;
+	size_t need_room = rx_len + (have_break ? 1 : 0);
+	u8 status = LSTP_SUCCESS;
+
+	if ((cmd & LSTP_UART_CMD_MASK) != LSTP_UART_CMD_WRITE) {
+		dev_warn_ratelimited(ch->dev, "%s: ch_%d: unexpected UART command 0x%02x\n",
+				     __func__, ch->ch_id, cmd);
+		lstp_send_irq_resp(ch, LSTP_NOT_SUPP);
+		return;
+	}
+
+	size_t room = tty_buffer_request_room(&ctx->port, need_room);
+
+	if (room < need_room) {
+		WRITE_ONCE(ctx->iocount.buf_overrun, ctx->iocount.buf_overrun + 1);
+		status = LSTP_NACK;
+	} else {
+		if (have_break) {
+			WRITE_ONCE(ctx->iocount.brk, ctx->iocount.brk + 1);
+			tty_insert_flip_char(&ctx->port, 0, TTY_BREAK);
+		}
+		if (rx_len) {
+			tty_insert_flip_string(&ctx->port, pkt->payload, rx_len);
+			WRITE_ONCE(ctx->iocount.rx, ctx->iocount.rx + rx_len);
+		}
+		tty_flip_buffer_push(&ctx->port);
+	}
+
+	if (tx_overrun) {
+		WRITE_ONCE(ctx->iocount.overrun, ctx->iocount.overrun + 1);
+		dev_warn_ratelimited(ch->dev,
+				     "%s: ch_%d: RX overrun on link (firmware dropped bytes)\n",
+				     __func__, ch->ch_id);
+	}
+
+	if (carrier_down) {
+		WRITE_ONCE(ctx->iocount.dcd, ctx->iocount.dcd + 1);
+		/* Honors CLOCAL: no-op when userspace asked to ignore carrier. */
+		tty_port_tty_hangup(&ctx->port, true);
+	}
+
+	lstp_send_irq_resp(ch, status);
+}
+
+static int lstp_port_activate(struct tty_port *port, struct tty_struct *tty)
+{
+	struct lstp_uart_ctx *ctx = container_of(port, struct lstp_uart_ctx, port);
+
+	/*
+	 * Re-test @registered: .install() resolved it under tty_mutex, which
+	 * the core drops before .open. lstp_uart_stop() clears the flag before
+	 * it samples @port->tty, so an open that gets past here has already
+	 * published its tty and stop() will hang it up.
+	 */
+	scoped_guard(mutex, &lstp_minors_lock)
+		if (!ctx->registered)
+			return -ENODEV;
+
+	tty->termios.c_cflag = ctx->hw_cflag;
+	tty->termios.c_iflag = ctx->hw_iflag;
+
+	/* TTY_NO_WRITE_SPLIT: let N_TTY pass a whole write down, not byte at a time. */
+	set_bit(TTY_NO_WRITE_SPLIT, &tty->flags);
+	return 0;
+}
+
+static void lstp_port_shutdown(struct tty_port *port)
+{
+	struct lstp_uart_ctx *ctx = container_of(port, struct lstp_uart_ctx, port);
+
+	cancel_work_sync(&ctx->write_work);
+
+	/*
+	 * Normally already empty. What survives the close drain and the hangup
+	 * flush is a drain still stalled when closing_wait expires: bytes queued
+	 * with no worker after the cancel above, so write_room() would stay
+	 * short by that much for the life of the port.
+	 */
+	scoped_guard(spinlock_irqsave, &ctx->write_lock) {
+		ctx->coal_len = 0;
+		ctx->tx_inflight_len = 0;
+	}
+}
+
+static void lstp_port_destruct(struct tty_port *port)
+{
+	struct lstp_uart_ctx *ctx = container_of(port, struct lstp_uart_ctx, port);
+	struct lstp_channel *ch = ctx->ch;
+
+	lstp_free_minor(ctx);
+	kfree(ctx->tx_snapshot);
+	kfree(ctx->coal_buf);
+	kfree(ctx);
+	lstp_channel_put(ch);
+}
+
+static const struct tty_port_operations lstp_port_ops = {
+	.activate = lstp_port_activate,
+	.shutdown = lstp_port_shutdown,
+	.destruct = lstp_port_destruct,
+};
+
+static int lstp_tty_install(struct tty_driver *driver, struct tty_struct *tty)
+{
+	struct lstp_uart_ctx *ctx = lstp_get_by_minor(tty->index);
+
+	if (!ctx)
+		return -ENODEV;
+
+	/*
+	 * tty_port_install(), as it sets tty->port: tty_init_dev() would use
+	 * driver->ports[], which tty_unregister_device() leaves naming the
+	 * minor's last context.
+	 */
+	int ret = tty_port_install(&ctx->port, driver, tty);
+
+	if (ret) {
+		tty_port_put(&ctx->port);
+		return ret;
+	}
+
+	/*
+	 * The tty now owns the lookup's reference; lstp_tty_cleanup() drops it.
+	 * @driver_data is the context, not the channel, so this tty never
+	 * reaches a later bind's context.
+	 */
+	tty->driver_data = ctx;
+	return 0;
+}
+
+static int lstp_tty_open(struct tty_struct *tty, struct file *filp)
+{
+	return tty_port_open(tty->port, tty, filp);
+}
+
+static void lstp_tty_close(struct tty_struct *tty, struct file *filp)
+{
+	tty_port_close(tty->port, tty, filp);
+}
+
+static void lstp_tty_hangup(struct tty_struct *tty)
+{
+	tty_port_hangup(tty->port);
+}
+
+static void lstp_tty_cleanup(struct tty_struct *tty)
+{
+	/* Drops what .install was handed. Runs for every installed tty. */
+	tty_port_put(tty->port);
+}
+
+static ssize_t lstp_tty_write(struct tty_struct *tty, const unsigned char *buf, size_t count)
+{
+	struct lstp_uart_ctx *ctx = tty->driver_data;
+	struct lstp_channel *ch = ctx->ch;
+
+	if (!count)
+		return 0;
+
+	guard(spinlock_irqsave)(&ctx->write_lock);
+
+	if (lstp_channel_disconnected(ch))
+		return -EIO;
+
+	size_t room = ctx->max_payload - ctx->coal_len;
+
+	if (!room)
+		return 0;
+
+	count = min(count, room);
+	memcpy(ctx->coal_buf + ctx->coal_len, buf, count);
+	ctx->coal_len += count;
+
+	schedule_work(&ctx->write_work);
+
+	return count;
+}
+
+static unsigned int lstp_tty_write_room(struct tty_struct *tty)
+{
+	struct lstp_uart_ctx *ctx = tty->driver_data;
+	struct lstp_channel *ch = ctx->ch;
+
+	guard(spinlock_irqsave)(&ctx->write_lock);
+
+	if (lstp_channel_disconnected(ch))
+		return 0;
+	return ctx->max_payload - ctx->coal_len;
+}
+
+static unsigned int lstp_tty_chars_in_buffer(struct tty_struct *tty)
+{
+	struct lstp_uart_ctx *ctx = tty->driver_data;
+	struct lstp_channel *ch = ctx->ch;
+
+	guard(spinlock_irqsave)(&ctx->write_lock);
+
+	if (lstp_channel_disconnected(ch))
+		return 0;
+
+	unsigned int count = ctx->coal_len;
+
+	if (ctx->tx_in_flight)
+		count += ctx->tx_inflight_len;
+	return count;
+}
+
+static void lstp_tty_flush_buffer(struct tty_struct *tty)
+{
+	struct lstp_uart_ctx *ctx = tty->driver_data;
+
+	scoped_guard(spinlock_irqsave, &ctx->write_lock)
+		ctx->coal_len = 0;
+	/* Does not cancel an already in-flight TX. */
+	cancel_work(&ctx->write_work);
+}
+
+/*
+ * Firmware config is fixed. tty_termios_copy_hw() restores the speeds and all
+ * of c_cflag but CREAD, HUPCL and CLOCAL; it leaves c_iflag alone, so the
+ * flow-control bits are restored by hand below.
+ */
+static void lstp_tty_set_termios(struct tty_struct *tty, const struct ktermios *old_termios)
+{
+	struct lstp_uart_ctx *ctx = tty->driver_data;
+
+	tty_termios_copy_hw(&tty->termios, old_termios);
+
+	/* XON/XOFF is a property of the link, not something stty may change. */
+	tty->termios.c_iflag &= ~(IXON | IXOFF | IXANY);
+	tty->termios.c_iflag |= ctx->hw_iflag & (IXON | IXOFF | IXANY);
+}
+
+/* Firmware fires a fixed-duration break; any non-zero state fires it, as cdc-acm does. */
+static int lstp_tty_break_ctl(struct tty_struct *tty, int state)
+{
+	struct lstp_uart_ctx *ctx = tty->driver_data;
+
+	if (!state)
+		return 0;
+
+	/* Hangup clears initialized under port->mutex, so it waits out a break in flight. */
+	guard(mutex)(&ctx->port.mutex);
+	if (!tty_port_initialized(&ctx->port))
+		return -EIO;
+
+	return lstp_uart_send_with_retry(ctx, LSTP_UART_CMD_WRITE | LSTP_UART_TAG_GEN_BREAK, NULL,
+					 0);
+}
+
+static int lstp_tty_get_icount(struct tty_struct *tty, struct serial_icounter_struct *icount)
+{
+	struct lstp_uart_ctx *ctx = tty->driver_data;
+
+	/* tty_get_icount() has zeroed *icount; these are the fields the driver counts. */
+	icount->dcd = READ_ONCE(ctx->iocount.dcd);
+	icount->rx = READ_ONCE(ctx->iocount.rx);
+	icount->tx = READ_ONCE(ctx->iocount.tx);
+	icount->overrun = READ_ONCE(ctx->iocount.overrun);
+	icount->brk = READ_ONCE(ctx->iocount.brk);
+	icount->buf_overrun = READ_ONCE(ctx->iocount.buf_overrun);
+	return 0;
+}
+
+static const struct tty_operations lstp_ops = {
+	.install = lstp_tty_install,
+	.open = lstp_tty_open,
+	.close = lstp_tty_close,
+	.cleanup = lstp_tty_cleanup,
+	.hangup = lstp_tty_hangup,
+	.write = lstp_tty_write,
+	.write_room = lstp_tty_write_room,
+	.chars_in_buffer = lstp_tty_chars_in_buffer,
+	.flush_buffer = lstp_tty_flush_buffer,
+	.set_termios = lstp_tty_set_termios,
+	.break_ctl = lstp_tty_break_ctl,
+	.get_icount = lstp_tty_get_icount,
+};
+
+/*
+ * Set up the tty_port, coalescing buffers and minor for one bind. The bind
+ * holds the port's initial reference, dropped by lstp_uart_remove(), and each
+ * installed tty another, so the context and its minor last until the later of
+ * the unbind and the last close.
+ */
+static int lstp_uart_init(struct lstp_channel *ch, const struct lstp_channel_init_info *info)
+{
+	if (info->config_len < sizeof(struct lstp_uart_config)) {
+		dev_err(ch->dev, "%s: ch_%d: UART config too short: %zu < %zu\n", __func__,
+			ch->ch_id, info->config_len, sizeof(struct lstp_uart_config));
+		return -EINVAL;
+	}
+
+	struct lstp_uart_ctx *ctx = kzalloc_obj(*ctx);
+
+	if (!ctx)
+		return -ENOMEM;
+
+	/* From here the only unwind is tty_port_put(); lstp_port_destruct() frees the rest. */
+	tty_port_init(&ctx->port);
+	ctx->port.ops = &lstp_port_ops;
+	ctx->minor = -1;
+	ctx->max_payload = ch->max_tx_payload;
+	ctx->ch = lstp_channel_get(ch);
+	spin_lock_init(&ctx->write_lock);
+
+	int ret = lstp_uart_parse_config(ctx, ch, info->config);
+
+	if (ret)
+		goto err_put_port;
+
+	ctx->coal_buf = kzalloc(ctx->max_payload, GFP_KERNEL);
+	if (!ctx->coal_buf) {
+		ret = -ENOMEM;
+		goto err_put_port;
+	}
+
+	ctx->tx_snapshot = kzalloc(ctx->max_payload, GFP_KERNEL);
+	if (!ctx->tx_snapshot) {
+		ret = -ENOMEM;
+		goto err_put_port;
+	}
+
+	ret = lstp_alloc_minor(ctx);
+	if (ret < 0) {
+		dev_err(ch->dev, "%s: ch_%d: Failed to allocate minor (%pe)\n", __func__, ch->ch_id,
+			ERR_PTR(ret));
+		goto err_put_port;
+	}
+	ctx->minor = ret;
+
+	INIT_WORK(&ctx->write_work, lstp_uart_write_work);
+	ch->priv = ctx;
+
+	dev_dbg(ch->dev, "%s: ch_%d: Initialized as %s\n", __func__, ch->ch_id, ch->display_name);
+	return 0;
+
+err_put_port:
+	tty_port_put(&ctx->port);
+	return ret;
+}
+
+static int lstp_uart_start(struct lstp_channel *ch)
+{
+	struct lstp_uart_ctx *ctx = ch->priv;
+
+	/*
+	 * Mark registered before publishing: tty_port_register_device() adds
+	 * the cdev and emits the uevent that sends udev straight to open(),
+	 * and lstp_tty_install() refuses a minor that is not marked. No node
+	 * exists at this index yet, so nothing can reach the map early.
+	 */
+	scoped_guard(mutex, &lstp_minors_lock)
+		ctx->registered = true;
+
+	struct device *tty_dev =
+		tty_port_register_device(&ctx->port, lstp_tty_driver, ctx->minor, ch->dev);
+
+	if (IS_ERR(tty_dev)) {
+		dev_err(ch->dev, "%s: ch_%d: Could not register TTY (%pe)\n", __func__, ch->ch_id,
+			tty_dev);
+		scoped_guard(mutex, &lstp_minors_lock)
+			ctx->registered = false;
+		return PTR_ERR(tty_dev);
+	}
+
+	/* Nothing below may fail: really_probe() skips .remove() when .probe() errors. */
+	dev_info(ch->dev, "%s: ch_%d: Started as %s\n", __func__, ch->ch_id, ch->display_name);
+	return 0;
+}
+
+/*
+ * Hang up the tty and unregister its device node, from the aux_driver
+ * .remove(). The minor and its map entry stay with the context until its last
+ * reference goes; clearing @registered is what refuses opens in between.
+ */
+static void lstp_uart_stop(struct lstp_channel *ch)
+{
+	struct lstp_uart_ctx *ctx = ch->priv;
+
+	/*
+	 * Clear @registered before sampling @port->tty, not after:
+	 * tty_port_open() publishes the tty before it calls .activate(), so an
+	 * open can go live between a sample and a later clear and never be
+	 * hung up here.
+	 */
+	scoped_guard(mutex, &lstp_minors_lock)
+		ctx->registered = false;
+
+	struct tty_struct *tty = tty_port_tty_get(&ctx->port);
+
+	if (tty) {
+		/*
+		 * Synchronous: fds move to hung_up_tty_fops and lstp_port_shutdown()
+		 * cancels write_work, so no write is submitted after this returns.
+		 */
+		tty_vhangup(tty);
+		tty_kref_put(tty);
+	}
+
+	tty_unregister_device(lstp_tty_driver, ctx->minor);
+}
+
+/*
+ * Nodes come and go with channel binds. The core drops a minor's saved termios
+ * when it is re-registered, so termios does not survive an unbind/bind cycle.
+ */
+static int __init lstp_uart_module_setup(void)
+{
+	lstp_tty_driver =
+		tty_alloc_driver(LSTP_UART_MINORS, TTY_DRIVER_REAL_RAW | TTY_DRIVER_DYNAMIC_DEV);
+	if (IS_ERR(lstp_tty_driver))
+		return PTR_ERR(lstp_tty_driver);
+
+	lstp_tty_driver->driver_name = "lstp";
+	lstp_tty_driver->name = "ttyLSTP";
+	lstp_tty_driver->major = 0;
+	lstp_tty_driver->minor_start = 0;
+	lstp_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
+	lstp_tty_driver->subtype = SERIAL_TYPE_NORMAL;
+	lstp_tty_driver->init_termios = tty_std_termios;
+	/* Overridden per-device in port_activate; this is the visible default. */
+	lstp_tty_driver->init_termios.c_cflag = B115200 | CS8 | CREAD | HUPCL | CLOCAL;
+	tty_set_operations(lstp_tty_driver, &lstp_ops);
+
+	int ret = tty_register_driver(lstp_tty_driver);
+
+	if (ret) {
+		tty_driver_kref_put(lstp_tty_driver);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void lstp_uart_module_teardown(void)
+{
+	tty_unregister_driver(lstp_tty_driver);
+	tty_driver_kref_put(lstp_tty_driver);
+	xa_destroy(&lstp_minors);
+}
+
+static int lstp_uart_probe(struct auxiliary_device *auxdev, const struct auxiliary_device_id *id)
+{
+	struct lstp_channel *ch = lstp_channel_from_auxdev(auxdev);
+	const struct lstp_channel_init_info *info = dev_get_platdata(&auxdev->dev);
+
+	if (!info)
+		return -ENODEV;
+
+	int ret = lstp_uart_init(ch, info);
+
+	if (ret)
+		return ret;
+
+	struct lstp_uart_ctx *ctx = ch->priv;
+
+	ret = lstp_uart_start(ch);
+	if (ret)
+		tty_port_put(&ctx->port);
+	return ret;
+}
+
+/* A tty still installed keeps the context until its cleanup. */
+static void lstp_uart_remove(struct auxiliary_device *auxdev)
+{
+	struct lstp_channel *ch = lstp_channel_from_auxdev(auxdev);
+	struct lstp_uart_ctx *ctx = ch->priv;
+
+	lstp_uart_stop(ch);
+	tty_port_put(&ctx->port);
+}
+
+static const struct lstp_ops lstp_uart_ops = {
+	.irq_packet = lstp_uart_irq_callback,
+};
+
+static const struct auxiliary_device_id lstp_uart_id_table[] = { { .name = "lstp.uart" }, {} };
+MODULE_DEVICE_TABLE(auxiliary, lstp_uart_id_table);
+
+static struct lstp_auxiliary_driver lstp_uart_drv = {
+	.adrv = {
+		.name = "uart",
+		.probe = lstp_uart_probe,
+		.remove = lstp_uart_remove,
+		.id_table = lstp_uart_id_table,
+	},
+	.ops = &lstp_uart_ops,
+};
+
+/* The tty_driver goes first: a probe registers its channel's tty device on it. */
+static int __init lstp_uart_module_init(void)
+{
+	int ret = lstp_uart_module_setup();
+
+	if (ret)
+		return ret;
+
+	ret = lstp_auxiliary_driver_register(&lstp_uart_drv);
+	if (ret)
+		lstp_uart_module_teardown();
+
+	return ret;
+}
+module_init(lstp_uart_module_init);
+
+static void __exit lstp_uart_module_exit(void)
+{
+	lstp_auxiliary_driver_unregister(&lstp_uart_drv);
+	lstp_uart_module_teardown();
+}
+module_exit(lstp_uart_module_exit);
+
+MODULE_IMPORT_NS("LSTP");
+MODULE_DESCRIPTION("LSTP UART driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0

