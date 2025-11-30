Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022136.outbound.protection.outlook.com [52.101.126.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AFD2741C9;
	Sun, 30 Nov 2025 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499409; cv=fail; b=LLf2HbsazbDv4Hq1QLEPSZCYt24+o4r7R4kc2JAoXLb6Cj6bd8FkI/i70n7VQIzwbD749m65pVHgq1NilV8hhW7nvNFTiXMihNueBc+QRP5FwIdOqhBIEzc8EmWjfC4d37PPQppjbX/M3/w2USbxGzHTvqq5UdUO6fRtlYaM91M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499409; c=relaxed/simple;
	bh=lrA9q8DsuGQUdyNJPxqyh34LpcvGHl4HYCDTtj3qv8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=laCWw62odzqHlsuz1bg2QxiMwGRN5ac8+tPgmuyBcXIjYfK/+4Ip75j573JnW1s0ljg/FeJL45gKyotSAsFJEOxNKP0eiFcNarDJn3TRvl7EmutGNiAQ7o0czDKOgs7Iv8w8g6vfRMrW5mVlWE9VJDQaKU3M/bZdTS8N8mXpJfQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=g8aJUBq7; arc=fail smtp.client-ip=52.101.126.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="g8aJUBq7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ag6CE14Q6JAKGfCvT0gBva4aDfMP5X6PkVHeNc4dKeST/t5NMytXKYoQEnWeax+aj2fHIZfM0Qh4uxYpEhGMhVR9cvJZEt/H4qP/mC8hxSxNbSPJJpYBDhJnAiVpsfcZ+6mD2LEwE9egygudJ4LbT+HfqDKMI7t4wccMixogoc09fM2j6VCXKwLY1w0xYCYruoStSwgWb5uvSTUpS4tyXRsm2N6n1NWVK6hOrVGaZOVTPgkqzRBqbHkWcRnOimQBQwOShV3yBWmdhxTXnLVwNnf0HGd+1zyJgvzG+5M3vnSjhRkBRiWywQJy9o1swrOXNA9+OwQZPFLHkrmoJvgQxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RcW2HZ1Ge7CD9B2uOTFbznE3CQYjogI20/18E3lY1R4=;
 b=AOOB7FBNW6qeam/p6wV3Ph7MYcB9ZvJ+sJ46FkTnv12VcPp6GVfYjzm51l4xKj0WaoS3rVURT9z9rmsAeqjWKkqosYLUOb0aqBxvRRmJSgjw3C1X0g7Rpi0CUMqg1AcuKRF7C6d5UocmZ890/rJPOEsPwX721Xc3IwffjHvOXtRD26i7JCSG22dI9J0H+h24CNppjbzdQ8PNlQ8V3a7tfLYTw2Yj2YXepVJeO4IxfuTeDdR4dOjT05KzrvKdkHJDxPaazAe8NzxBCXjUKVGz518ejUkdEsqNq/ptWkuNT/X1JLmRGJxWumaruLRlrE31L1Wn29PyA1hhizVNQOr5IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RcW2HZ1Ge7CD9B2uOTFbznE3CQYjogI20/18E3lY1R4=;
 b=g8aJUBq7wSrPeJ4Aqe2bTo9JBmFrhde9j8MSTheBqVBB0MDzbtTun5HEJ5K/lMh27Mkiwf8kmhoTtvaNWcsbI/zoRs/T4ChKN1OVcGqFs8V0g9dEp/cKLs4rz2TfSccl6wksgrC9SbKAyl90RJQ54hnJ/fpNvVmNxhTtOQtNorg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB4235.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:43:24 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:43:24 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 02/31] serial: 8250: add MU860 UART configuration
Date: Sun, 30 Nov 2025 18:41:53 +0800
Message-ID: <20251130104222.63077-3-crescentcy.hsieh@moxa.com>
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
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYZPR01MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e956c1b-a0eb-47b0-7226-08de2ffd4981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hIG/z6LsyHNLX4T2XRZGE/z7ULZUgNMFIJb8bgrdLrYB3WFjt0fnRaMuLtMJ?=
 =?us-ascii?Q?Rwd+SJLx0R+8GXg6QRJdIeDvLEbgIjzbXmGmfaJ+Y0l1x2u4wreRZAqzzJh6?=
 =?us-ascii?Q?mAJmLVdmvxOdCsEL9ba4CdLm0GN1/S2wO6vgPy4mTsoWT04JhcLLI1sRL5eR?=
 =?us-ascii?Q?CqaVOVEnfLCztPtq3eoHoNHU/BD45PaBzGI9O7bD1fWc+hjuVHMvYv/Ehsm9?=
 =?us-ascii?Q?G/xXL9zYRCshAcLIlfPGVNmXWtYHQL0V/aGP5pKoakDHmXPMaknA1UFcaB3X?=
 =?us-ascii?Q?7hOx7WIPDcNrt1O3ZOSAgs9RWw3yDVuFEi666/F1UCKoZvHCkVe2qWw/etKT?=
 =?us-ascii?Q?55CQuOwgxKQqX0UwqpEf3EZfDc+TH+Y47qUA4b1ZGj5bA5XDq5FlNTFeIHX0?=
 =?us-ascii?Q?1IujlHnRvfkOOd09tCudBwd3w9uKOShZzmhBfqvRCXSlt1q6iglwwT1z6KwV?=
 =?us-ascii?Q?eV1Wydhzy7JCP/GtGmupLyo5FVwfxd/yC3NQJ7bjWuDqUoCzHpUrPhZeS6N2?=
 =?us-ascii?Q?gkNFRFKHcTFl+yNvKyN4Clvp57itnXnsS8w8LQVfeWRDjXeQsLDrhoUIVzjo?=
 =?us-ascii?Q?3ihE/CNCNpSPTHuhXJ/NyQ0WOXRgNTdTbyp0WlW45ESSxZwdRzYcpXJQp3gV?=
 =?us-ascii?Q?TU8ZDgVVzTanWvl1dUoYDw3NZoLNF3nQGp40tdw30ZW/judVEoixNijGT9dz?=
 =?us-ascii?Q?otf+tmi/X/Ap8CxClyoAsxWnvG+a5mSD0wW31KyCFFHuo2Uv0acDBlQ69lTM?=
 =?us-ascii?Q?XcO0FEMGcuphr8XcU2H/Jp06r0kKcESp5fkm9HxsuZTOTcB1eG0spXtdS9hy?=
 =?us-ascii?Q?IdJTvotrroVnReZeo65odyjvdOkeK/zDAS2Ng7k6/ihIsnC+wb++QiJ5kKKg?=
 =?us-ascii?Q?CC+Ofkf+I6GW6mnE2030rwEyh/SCC3NBl+k9kgpX18aJlICY6CF0x3X1e1Xf?=
 =?us-ascii?Q?pKrwjxMM73Y6g3k2/cpnnzbyJsAWl4KLPoGj7PYw41fly9Rs3V67xJt2tudf?=
 =?us-ascii?Q?yXC7RZnWxYmIMwJeVolP4L8re2yMCfH137BRrKKteLfiUq37r2sIx78U/n5V?=
 =?us-ascii?Q?2iYozIIOQR6pAbU/bpzaC3kae+7y14E2VOApam6F1UvzabWL17LLdOrVrTiB?=
 =?us-ascii?Q?xkNgPqFt/tk3ShXLH9KVO5BPswtd2nJlZFVCdBPEwmQGc+xicet9mHAXk8gI?=
 =?us-ascii?Q?7h6Bsqyze++bCLb7Li7UBp4cXU1atQNDOtB6pOumlx1GnypRzLMnJlCkvMVW?=
 =?us-ascii?Q?GvgijzvCE5nKX85jle0rtIPiL8iUv3V1zk5xkFaoznC20vSPul8lq6R9nSI/?=
 =?us-ascii?Q?xXzH4H0ZSZ/TBkKklx8yesP7M/NPqLxL9D+UWu6pEAatPJLOzh0SJDm+PcyR?=
 =?us-ascii?Q?1e0+G6Btx7gyt7V1QxACOqKg6oIuKCBc0ADG+fJoZpEpPaVHF9osXWrFiCzO?=
 =?us-ascii?Q?OAChostesYkPfn+Rkk7SDFD+qPKwIw6/95XNJ72e4acRKG9gi654bQBWr2Gv?=
 =?us-ascii?Q?rkZCvACl9ok9J23tMblcOAqjJraunG+79Ons?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SF1denkwukGKrnXCL6gpYOK5lXchr2Z7yJITwCtBZG4TkwRptYf9RX2dnvKS?=
 =?us-ascii?Q?nY5G1YJbcGyvz2UYoLoueRM5EezkEsDep3q/eQxn1mTq8DpKsb71REgs0+DB?=
 =?us-ascii?Q?NvM5TkNUH57QavunTJSPlMrZilGqCMHVzAerKMYna9AqSBt5pDXozyf7DCr5?=
 =?us-ascii?Q?QBo++zJl5B80G3aLlbAvWLIJXEeOuhPPhIg8Td1WS1zXvnMKc8RsRmDpkH/h?=
 =?us-ascii?Q?EasdH0z5MZofSJBH5Y4SZ2ySnFLGDW43NWtr53sAH6kRsa+im9MATZApi8KO?=
 =?us-ascii?Q?yRGNHD9AZE/zZwDmiu9YK+gqB/5Ozs2Kcrxd33JwOCHMeKjo9zqbgrO8pTap?=
 =?us-ascii?Q?a+Xl1rpMbLPJxbTBV5h3NPUYyeH/Z/gAMcEQYN2vabHA1l1v8N5ZxlyiIdMN?=
 =?us-ascii?Q?CgBQyIcMBy1g3SSn61W01LhLNMVBXjfAgzKfsGpSt294D6pbr5SFNy58GyiL?=
 =?us-ascii?Q?2u5c8AK+ibMwe/0p7pzzdQ5nIpCkVwFtflLkC4sCyHITFE6qRUqFbt3FclWs?=
 =?us-ascii?Q?7SnXWdjmg11yLeNngu9hjBz0QCbATPLmieMpsIF/rIydhGTGprsBNF75yAJU?=
 =?us-ascii?Q?aAuYQkN3Lp1FUzD5Uy9fp7Ujq6XUUK2SLQFV6PgDoy3qXcZXbiPFD7P3UVc1?=
 =?us-ascii?Q?3op3pl0t22U+ahnDqiFYJuxdp1NOamotC1HIIMERtXxuY5SWtyUJDszwj9KI?=
 =?us-ascii?Q?fGzZr0P4tOEnnp6wjm/8u17IZavrxmCGtck8A9FMIsWEIVlfRW8vUfs9BcK/?=
 =?us-ascii?Q?9q5z+TuzGkJGgZ/SFpCocqSjJ61IiNQf3Zq2VjXJEfEvo6ujX+BKbeL2RSR7?=
 =?us-ascii?Q?W5aaxmuFN4apgbM2TcDh6W88nYK84doFswWwGJIKJL2V5lsEO/5lkBzymgv5?=
 =?us-ascii?Q?kDMhA0LMr6Wzdc9WNbnvk4K0rKLB3QlJPZwePoCurCJHMYYEHLubG5CUpXob?=
 =?us-ascii?Q?PtsyyN8n0UtgW1mTYVQ+JISwTZSQONDJNaFPvjJ3Q4XLIV0jH5Ko8QLCkqF/?=
 =?us-ascii?Q?XsyFwl/th5CEvMhkgcgwQvAnxf2n6HMC+ccoO1PmjWKPEC2GDNmbbzY4CSQy?=
 =?us-ascii?Q?FEYcFLgmN19eHZCaTYeqKVvyx2QRqpWow5x5PZ1s1MIsB3Ija6QhGhKi6lIC?=
 =?us-ascii?Q?dnSgpyG6+4Xz3VthWNE4RiAeocvEQ3DoPtfO9xmd5X6MTQqTPQihOqboAu6/?=
 =?us-ascii?Q?MD+V1Jq47NrYQbhte52hSu9OzDUTu1xAEly3zKA9g8nkTtUWyLOFadisbzWt?=
 =?us-ascii?Q?oaK/HviBXThqdQ7L4p73lzKpwQCicsdkc84leVCnqvwQuPTjXWS3uuPFBLmc?=
 =?us-ascii?Q?C6/7b/feEH9CHPxIGgIUCpT2v2PTikXZykxPvjwDzQCthrF9kLDtJ7SpVNGl?=
 =?us-ascii?Q?WZRQ2ICMP/U5qXQ/Bf9vj6daViBcPgYczVRW3EtqPPyk9+g8VgkOI/ntCD2Y?=
 =?us-ascii?Q?YMx1NnUs1Pse5H4C3wxWqLyEV7i7x86fFAL/P/mB8wmvKgQHD/SQCXm5u+Eu?=
 =?us-ascii?Q?V8XRhFFOz+9ce5R3enfCLV/dS4JfdRND2LG8nBet8tnG/AY55tOfpn8d/Dov?=
 =?us-ascii?Q?1i6xJ69rXilJknWrmwaVwUbyczuED7s58psW+C0+2C1QRIHVuJCVzgoNthQu?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e956c1b-a0eb-47b0-7226-08de2ffd4981
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:43:24.0795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qh5S2XkDxQJEqozsB36SRh0fWt79O2Te9/Po/5QgAN+ZDLlXEIydGNXF8cGnU4pDKIPYBrVpm45M1s6QfWTx23vcUz+Qvzg3UCUlSzxWfPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4235

The MU860 UART does not fully conform to PORT_16650V2 or any other
standard UART configuration. This patch introduces a new UART type,
PORT_MU860, to accurately reflect the hardware characteristics of
MU860-based devices.

The new configuration is applied to Moxa UPCI serial boards to ensure
correct initialization and operation.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxupci.c | 3 ++-
 drivers/tty/serial/8250/8250_port.c   | 8 ++++++++
 include/uapi/linux/serial_core.h      | 3 +++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mxupci.c b/drivers/tty/serial/8250/8250_mxupci.c
index fe899ff090c4..d7a4b838ec1f 100644
--- a/drivers/tty/serial/8250/8250_mxupci.c
+++ b/drivers/tty/serial/8250/8250_mxupci.c
@@ -87,7 +87,8 @@ static int mxupci8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.dev = &pdev->dev;
 	up.port.irq = pdev->irq;
 	up.port.uartclk = MOXA_UART_BASE_BAUD * 16;
-	up.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
+	up.port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ | UPF_FIXED_TYPE;
+	up.port.type = PORT_MU860;
 
 	for (i = 0; i < num_ports; i++) {
 		if (serial8250_pci_setup_port(pdev, &up, FL_GET_BASE(FL_BASE2), i * MOXA_UART_OFFSET, 0))
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 649e74e9b52f..7d022315b3aa 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -319,6 +319,14 @@ static const struct serial8250_config uart_config[] = {
 		.rxtrig_bytes	= {1, 8, 16, 30},
 		.flags		= UART_CAP_FIFO | UART_CAP_AFE,
 	},
+	[PORT_MU860] = {
+		.name		= "Moxa MU860 UART",
+		.fifo_size	= 128,
+		.tx_loadsz	= 128,
+		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_00,
+		.rxtrig_bytes	= {1, 4, 8, 14},
+		.flags		= UART_CAP_FIFO,
+	},
 };
 
 /* Uart divisor latch read */
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 9c007a106330..49c2fcb2e24c 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -100,6 +100,9 @@
 /* TXX9 type number */
 #define PORT_TXX9	64
 
+/* Moxa MU860 UART */
+#define PORT_MU860      65
+
 /*Digi jsm */
 #define PORT_JSM        69
 
-- 
2.45.2

