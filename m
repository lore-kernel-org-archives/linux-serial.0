Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022105.outbound.protection.outlook.com [40.107.75.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1B029898B;
	Sun, 30 Nov 2025 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499549; cv=fail; b=dCl5pRGbMN3oIWnmiHx1T/bfoRN2hAbQI4cuOrkpxQYraK2lWENFiLek6wMb0yv8YeVtU+46yrB7ZrhufRs0aODFVqIQhG9Ko9FK485WB9xrdMV/Dpv+szQYCFwrNw5u3+8SbMn5meqgNnBVMsc4ZNPgnk24CAJiCqLSqfnonq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499549; c=relaxed/simple;
	bh=dZg7V0I30uItKcsOCEE/0xzggIPhrk8tidzFoTfGZVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S1IGFO3JokwOuPNG4gza3B9GLh08tCs/CTmvfLsaJPiNO3drdRVLQzLp/4xIloqQpWesPe6h5KCbjtybDcxibB5cE8OhTyu1l2hZ2KzVxLEp0uUAeWgqvOBaoppX94CZSqlMasXRS4iQgqQ+bvVlxM/Mf704XBJnxsaIwlyGaWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=GmXhsJIo; arc=fail smtp.client-ip=40.107.75.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="GmXhsJIo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nG/JnN4SBLF8BU/dgz5PDzUPSGBxiR9/xygXdC3jM22ulyasmS1eCIRnkgp3PR6R4lG/Z5IlbHSJk+kH2s6n7/B5LkLXyNCjbhyd7HrdtMokcQ1L7Bj6imAKyrWYMCQR5QZyLWcr+EbWhfBkdKSZaY2fVYzsERnUXFKq0yDQxCbQLG7MktW2qHQ7Xndw1wYYKVqhnrBSUDLkvc1e/lnm6StJpdql9mnqRPa1+Tdan/eZSeFsA+sdn33qmu8A8MhK6X4ehmpqpGOR3w51cMGp7kfb2BeX9seol312JttucMi4OcN83sLaTst/oid/FJD5oIgVRfSr7Bm00RekgpxzgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzFM3sTFAzk2a+qtG7tUjnAUDWU3n0ZCFKK/yN7Tgnw=;
 b=dr65IPReEWOTggXYK57nNU9D0Fcm2r5y/92vwUqd0J8D8rKQNbwZKbWDnL6szUUIhpRt0JJmRiNkrRE0fXuar8EXiCuzx9XRnW8z2J1K9M393y7UYh2cv4apBJW6PKaJ9moNrhCU+tzoQgotjxb67E3DScey3UrQFeOw+LCqmmVDi0XM2M64llClKt9jEN8kwM926brKLSyDqqEsAHc1aI7Da/I3iiDAyJezExm3VtzRbVtDV+hUKAKxxVWtjEsmpSw0jK8afmUm4R4y2hFCVP4fAyJNblaqBozum7axyVGNu8PjRV8rMx1GBYzs6sjV6J10mZ53kyl2fqn1SCVqAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzFM3sTFAzk2a+qtG7tUjnAUDWU3n0ZCFKK/yN7Tgnw=;
 b=GmXhsJIoOVHFRUJtR8hjFPzxmMsIFrXbsZ/7i035ReQQJEcAfg8KBdisNhe/ibtQ7va0yVitRYN0mm4qQhtnvKBFAF+XjoFgveTn6JihSzqUA0RFYWLjsyow9SYFpawFZh3dy6P6Y6h+3ZodwvX8KhlQMYFDXf6HDNLrvA0nIk0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB6080.apcprd01.prod.exchangelabs.com
 (2603:1096:101:221::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:45:44 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:45:44 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 27/31] serial: 8250: Allow dynamic extension of uart_port attr_group
Date: Sun, 30 Nov 2025 18:42:18 +0800
Message-ID: <20251130104222.63077-28-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::18) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 856075cd-283b-4d4c-e195-08de2ffd9d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dcst/DKXWlxqxF32xGX4sKnjYA91d/gD0iARsRy2rXemihwh5A9AVoRozZ3e?=
 =?us-ascii?Q?8uAiv20gVdh089ERZMc1oI/FxGllV983OKEpLDn1XQSVZG3WVYHRNYlS79X7?=
 =?us-ascii?Q?glM9XudwBD0Ctc9t2vCKkjIxZAcVd1TcomNuEoyoJclj8gHooxNj4gqdkYTf?=
 =?us-ascii?Q?9Kq5PapNT3HFBGnQTajc98XXFRS05whfoZU+Vk32hcMEpH8qVI/ELHEbRAqs?=
 =?us-ascii?Q?uHAUAzeybJeqdp3BzCGPpnMBz/gqiOA8kGNGY496Dx5MzYaUKrWWcGd9c9jg?=
 =?us-ascii?Q?1n17a/KHt+lSeprH6YgITy9W/+vlEmPxipw+15T1Nb5ykWG2XaDQB3H3EzoX?=
 =?us-ascii?Q?0qjFfEIRwJHEw6RdUCt7dt87Qh87VMVOeZ5yEvtC5ztjJZranPr++lHrrHuF?=
 =?us-ascii?Q?jDNlJua6gxY8uxdtzReobVm7yfyi+5fgifpmd8txchg8a96NLqf+dBjZSWAE?=
 =?us-ascii?Q?IzU7vnsRqfSKua7ZHMdiOG1RXNTBqsoAqBvVFTmjIaI4AXYERoMlHrLGQaw/?=
 =?us-ascii?Q?q7dYpFtW1xaAt3roSYjU2zYV1CLvf/UbzBAC2q+W+VDb4pGmFj81+lrty2UR?=
 =?us-ascii?Q?iL6q/g6TJXEQ2jszDT8EwReR74FxrqTiknz/E/F2GFm8RsXrDWy5JCupmh0c?=
 =?us-ascii?Q?ECeMqSTwa/ZAVAT/C0k7F8ioZ/ByYzL+BFX9gbihhOIuQp4HTLezpkSjLIVv?=
 =?us-ascii?Q?mNUoXqAovqqipL/s3IF2f8yfoNR9dx30wHRbWM9AvLAZTKhbnvuwbl4z+Foi?=
 =?us-ascii?Q?sQfZLHgEhhvEOQGEi0d+7PpZuO0EgrAEqSJrHJSfckiO2j59F89tBSJCFSOg?=
 =?us-ascii?Q?44a8ce2trysdmNBZHqi33YqojkqtlyDHbyJcFqXTR4mvgZxQbGANOF2t/yPc?=
 =?us-ascii?Q?LXp8TocOvFDaE4e+BDd28nSSMgPg0OxG5jLPHzWMZyVDmvt9pGNspPnCIF3C?=
 =?us-ascii?Q?wu6JudsP4jKLlw/qEeYfCBSdKVFN/NFTkzcMTQbOUt9BiN+FzOtQK8q0hFL9?=
 =?us-ascii?Q?GBkf2PYuUeMSTUlU6S0MhrKmwzQMdzfNCdMvcW4SQlRLE+utjud5K3c5nzz0?=
 =?us-ascii?Q?dUdUhF9aNNHhOtPgPFAqLepOW67EUJYxlchrkJC9AHg3xywytQgjbKYrn8u7?=
 =?us-ascii?Q?OzOe2spcxStdKiidmfkaGFqYIOUtguVpTQYgeuDrPP9PGic/LykDDfW2vOMc?=
 =?us-ascii?Q?iByUGIuzsHKB7qNZgKHANG1z67DKLCail66kCt8FnUr/W7DaSRIVKL/pXP6k?=
 =?us-ascii?Q?a3rl++w3IGNXeYXoFdcJfa7simNtlcqN7fauOKGRNUXW49mlKk/rFtK6mi67?=
 =?us-ascii?Q?2vQQMS9Xxss7dkr1teO3tPG0PJW0vi05EJl1EYEegYPVVFlR8JNOl6Hi0WqR?=
 =?us-ascii?Q?xacB3MQT+FxnTU6Ik1ivhgSSP00TT2o1V6/35bi3VbZBgW67RzRbcXkfgQfz?=
 =?us-ascii?Q?6tfcEQNI3xyIuy/wPNSBY9Tc+ujcoYh7G2h8d3Dya4x2gMTbVe7T3lmKkfuV?=
 =?us-ascii?Q?H6WLKNcmNtT1jKNZruRmwFzn7tbAk6tzE/wx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xeco2hvD80sVvolPtBbR2pxc6244iDpAEkSKDVb3giPiMvyg4SJr2djSH63R?=
 =?us-ascii?Q?t8fOY/wZpVAl4gA4fH87IbfFZaoLadS3vdXLko+aj/rR8Us3/yy26FlGHL08?=
 =?us-ascii?Q?og0Cv98eGGfvvWLgmuS7Za9e0N9zNjSxLgSb+kZXCroVftSs55ucfibXLqur?=
 =?us-ascii?Q?iLP6Vxo2tvQbcExKXMm5uvSQyCH8Qp3Jj8Mqjo9tN7EKFEZMnmEA6uVz5JhH?=
 =?us-ascii?Q?X7bnbNkAv9y1WFlTug5OpYf3nlF9rB7WHtB8B4gH3oD10nd7tLnhz+4gcAw/?=
 =?us-ascii?Q?s2D40hJW3ixCAdt0wmkxOTTLbhKGfnS0oeFo9o6B2sQB6wJwjsLyJOoOhHkx?=
 =?us-ascii?Q?Kus+6+nQ3pfWVSwF62ykLgUbOqUn6+YFamS1bQ9XhsyuIXCmfdBDtRQ4pjBj?=
 =?us-ascii?Q?By4PCN5PPd/XOplnGNfcCIV5klJqZ5HEt7iSdsexvhkuUjqIVO5xH8yzExU/?=
 =?us-ascii?Q?Y/t6T6PiVRM0f4zR7ZpA5206W7QRtm/vKXt/+umDM2/+cDMyMnP5fXK3qkCL?=
 =?us-ascii?Q?+fh3snuQlF88wdlCoBh1s/YHNjoN6jmMSbTHZwUZIZ6cmhcabmzZMT1JHCVp?=
 =?us-ascii?Q?wyeO6OV7lYx1qjrKSM3p5sj5huHng1KcnBwyQ1XaWr6ggXJaiRzkHdSqb7e4?=
 =?us-ascii?Q?5OzQfx5XUqyD4ZvTym/Y16KYUTdyMYP27jDRVQTIuPPS4ex9lZnwSDGe59dg?=
 =?us-ascii?Q?VD1o0DmvnOiJNFjJK71eIv+BpdGtMnI2daT6w5yNjpgVH1WmScFRodN+idKL?=
 =?us-ascii?Q?eaaMFq3PPHC/bIb3/xfLambCJiaNtM0OolfG9DMBSrO2qZujwe78jpmVJ3R5?=
 =?us-ascii?Q?CtPaoGiQgeS3dek1t9oU00gUE2yHNzvxAxeGipwfzk3N1Ym22vJf2kLUuw7B?=
 =?us-ascii?Q?zEM6u0F4uASLsOPOaZS9fHVWW9EGpMeMpJqabZGttGPP5dnot5eerFHr6RbI?=
 =?us-ascii?Q?1hsVOTD5XtNuY2OBIjAuW/YJiwgdbY2jZQs/XsmrGKmsaiX6VP/LaV0M1O9X?=
 =?us-ascii?Q?fdib4Lr2lTEynXgaSNkXK7mDxCiMaOU1iBP+KBQ8ZJL6fgtsJuFxVy7HARSR?=
 =?us-ascii?Q?bCsw3UjoUj8s9A1fqulu20ka/j7edbGgDHjC0HsD+MBL7ZOwVXDHzhAM0TeC?=
 =?us-ascii?Q?acUUGhpFVPscA4ffUezfR3Xjltrgng7lB+UMZDHjQHjeOB3b3/S/EE14YFby?=
 =?us-ascii?Q?VBeTQz7GHizdws6MueQzoc2SXfRL2uUU0AnsvgId7Q42dJ1lQQuVfizJfgJ7?=
 =?us-ascii?Q?tYwg9fZ4Oxag4F7VzYDn1Lo87ZQHXe5L0EpCR0pZxd1GYPKXyVIk3bRvs5Yf?=
 =?us-ascii?Q?0seuyaJ158h4GtJFYnT2/jZP63pwRE6i3+iWP5FsWM+1QJ0lUWfpoZg+erwu?=
 =?us-ascii?Q?AfbHqcwb9JouVMwve4eoYamyCsBOB8mLXdgRTtwJgDtOLcURti3fM/V3FBZU?=
 =?us-ascii?Q?v8NP5mikN87djIhSe9Yg0UszngqBZZEFUuJp75i0xm5gn5RXLNI8beDc+kzr?=
 =?us-ascii?Q?OeYXoXZEBgVBDujU5cH4+DJ37xz+KH53Xi13I+IVGcm1kwHuUJXiFvXgOYmL?=
 =?us-ascii?Q?drXgfP58KYcaU5vk03Y03YdqL6xxPanS/HmZfX+2ICYFety2nT5y6OEkdSUq?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 856075cd-283b-4d4c-e195-08de2ffd9d3e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:45:44.5513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GZ2ADuDgjfNIszl4ce2rg20B+lku9dbIisfPJkIa4XTk4jUg2fGc8nl1sdd16oMuZAJvX1L7YYeps7IxN5LrH3WkQRtvaWqtJeljCrdR7Fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6080

Currently, uart_port->attr_group can only reference a statically
defined attribute_group, which prevents drivers from appending their
own sysfs attributes.

This enables drivers to inject custom sysfs entries without overriding
the core-provided rxtrig interface.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_core.c |  8 ++++++++
 drivers/tty/serial/8250/8250_port.c | 26 ++++++++++++++++++++++++--
 include/linux/serial_core.h         |  1 +
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 3d8575874759..66b942e9e78a 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -812,6 +812,8 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 			uart->port.set_rxtrig = up->port.set_rxtrig;
 		if (up->port.get_rxtrig)
 			uart->port.get_rxtrig = up->port.get_rxtrig;
+		if (up->port.attr_group)
+			uart->port.attr_group = up->port.attr_group;
 		if (up->dl_read)
 			uart->dl_read = up->dl_read;
 		if (up->dl_write)
@@ -895,6 +897,12 @@ void serial8250_unregister_port(int line)
 		uart->port.type = PORT_UNKNOWN;
 		uart->port.dev = &serial8250_isa_devs->dev;
 		uart->port.port_id = line;
+
+		if (uart->port.attr_group_allocated) {
+			kfree(uart->port.attr_group->attrs);
+			kfree(uart->port.attr_group);
+		}
+		uart->port.attr_group = NULL;
 		uart->capabilities = 0;
 		serial8250_init_port(uart);
 		serial8250_apply_quirks(uart);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index d7baceacd4ff..e84879718a51 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3192,9 +3192,31 @@ static struct attribute_group serial8250_dev_attr_group = {
 static void register_dev_spec_attr_grp(struct uart_8250_port *up)
 {
 	const struct serial8250_config *conf_type = &uart_config[up->port.type];
+	struct attribute **upp_attrs = NULL;
+	int upp_attr_num = 0, i;
 
-	if (conf_type->rxtrig_bytes[0])
-		up->port.attr_group = &serial8250_dev_attr_group;
+	up->port.attr_group_allocated = false;
+
+	if (up->port.attr_group) {
+		upp_attrs = up->port.attr_group->attrs;
+
+		while (upp_attrs[upp_attr_num])
+			upp_attr_num++;
+
+		up->port.attr_group = kcalloc(1, sizeof(struct attribute_group), GFP_KERNEL);
+		up->port.attr_group->attrs = kcalloc(upp_attr_num + 2, sizeof(struct attribute *), GFP_KERNEL);
+
+		for (i = 0; i < upp_attr_num; ++i)
+			up->port.attr_group->attrs[i] = upp_attrs[i];
+
+		if (conf_type->rxtrig_bytes[0])
+			up->port.attr_group->attrs[upp_attr_num] = &dev_attr_rx_trig_bytes.attr;
+
+		up->port.attr_group_allocated = true;
+	} else {
+		if (conf_type->rxtrig_bytes[0])
+			up->port.attr_group = &serial8250_dev_attr_group;
+	}
 }
 
 static void serial8250_config_port(struct uart_port *port, int flags)
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 96646d3f2943..95ef7b08b6d8 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -590,6 +590,7 @@ struct uart_port {
 	unsigned char		console_reinit;
 	const char		*name;			/* port name */
 	struct attribute_group	*attr_group;		/* port specific attributes */
+	bool			attr_group_allocated;	/* whether attr_group is dynamic allocated */
 	const struct attribute_group **tty_groups;	/* all attributes (serial core use only) */
 	struct serial_rs485     rs485;
 	struct serial_rs485	rs485_supported;	/* Supported mask for serial_rs485 */
-- 
2.45.2

