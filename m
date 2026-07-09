Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013064.outbound.protection.outlook.com [52.101.127.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FE13B4EA4;
	Thu,  9 Jul 2026 05:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575252; cv=fail; b=c7exb4FaNuvBlk0708BGVixBC1/PU7YdxuDtKMjmgKMylpHor+9vBRcEWHpfX0MHnGQ+QnosxDD4IAhdT5HNneVg7kCKpyQb8PbZuk9vsyVugAefnwy7tQNYjUTTVyZc4MzUFC1Bfz4fMlmsWBUB1kQssd29XPpenN+5buXehuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575252; c=relaxed/simple;
	bh=ktY3Iz9q+gSzTaID9LqPrV3yYgj6GUp1fH8mJbe2QIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MCdfK/UDrDLMvJcwCn3jtSCajP7m2QWTkGUEVElyPBlOtWakTN+pF7huCx9jR2N8cUdJFmQ16ZVh039sUN8ZKqyr3afhyGRQVm2s0ZbilrSePibXFC5o+nLRMm9JR1MohUyDXdDyCBxysq4YzgNXhpiE0HV8y5edlXYmepLLgvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=RLzDy5Ok; arc=fail smtp.client-ip=52.101.127.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="RLzDy5Ok"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tGh/XNbMokVFVDHJi0oQ6M458Nu0awWWbTolbm4Mwkq+/Sa25JmoMXg2CB/PrvRT9Cu8RE/pneN67+wQTF7d0G6+X8BFAiLx5E84ZQJiNBUYJLLxdJVPmtH9UTbBXBcaXaA64mCbM7N1rfMnMx/VsylqD6pYJJaSZyyAiorIy6mW0g++L5UWltcvuI+XdZCSBGvlnO9ksHzBA49gcPMTv/lOwsaqp4b0uprzTz/8Kj35MEQvFKCcCscLu5ZulSRpY65xw5vvM5b9D0SkrTMS8eXDM+kXySdZbL0EYMExca4ywMuE4ZndwcCvLbYIOj/urcgpayMxvxIdMIe10jfwxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5KmTctalkt5rWd+i+2AsgEJXpYPdRBaIfimgn+zjsE=;
 b=v40YbPXyuD1QYT8nqoUEA4zyW3tLgGlPaqg2WkqN9jiRMRDyoO4umSlr6lbulQBoEy5LeKC8OUKl1wDXyi/PO/cnyxQbcCKY2E0m9Nqa3Aqm09UWGqG6USNFa4ttXi9AkfJ33TmFG3wvAkDb3VGKrl/fxjlDcJmuCnBZn0NfFmMaGKMn34+sk0mlFe2SWs+hT7Zy/9j5OLHJFnf2VPAhxhdzzkluVVhuyKmGjOzSow1urjTN4JLMe/AqZqO/so072M5rAChC4IjQcePywPbapODDIrEcz1AgncFOaEkAd+HWJFi4hN16nXmv/gnqD5F9Y/njy+30Y0W/N1zxEl+mGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5KmTctalkt5rWd+i+2AsgEJXpYPdRBaIfimgn+zjsE=;
 b=RLzDy5OkohXBOFpgnDtYvhSVjv2p548wLZ6kAhEiAFpHZl/ffL3CFJcw5JEc+XLoiPMNqvwH/K6EMn6nWQzNE98XqWeofI0b+MwHLeHew0EtiTg2GdAgphskV4aDDNX9cvtSRBYN/CHO3ppx0SBKSUAmT77zGesskS+0DiKPwK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6) by TYZPR01MB4610.apcprd01.prod.exchangelabs.com
 (2603:1096:400:260::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 05:34:01 +0000
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec]) by SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 05:34:00 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 14/15] serial: 8250: allow UART drivers to override rx_trig_bytes handling
Date: Thu,  9 Jul 2026 13:33:13 +0800
Message-ID: <20260709053314.435629-15-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
References: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: dc0218cd-30db-4912-991d-08dedd7bae19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|52116014|56012099006|22082099003|18002099003|6133799003|38350700014;
X-Microsoft-Antispam-Message-Info:
	xDkLb/hcAg32w1rJrpjhH/Z2V0RxuRmFoVdZuLLrWu+iDI5JhC6HLfhUX4kjLugUvFAnKyjgptdDY5jyefQzoAsPsg0T1iKVtUJhXKw558qlSBJJjL1G0+nkLLbZqeaxie+OMTaJBtaYKNmt2mg9GCrDChGdEFdpe9PrFYD0ifUwxAYLqtYe31OdnBSi5jkwzVZYu5vNMagqd9+L5H9sOCiUPffeKC8LMPC8UQJPHt1rPFktiu41vewQLuhyxtNR4cw7IltBtueHshz5E3PV9kMY8ZlVCZlNGRQCyC5n1aLZDvghLwiVSwu2Sm/yThtkLnDrCppuGkSgMuHCxm4R4AQGGO2UVCNUAoqaAK6rEx7dZj4p5gfp8z3V4TayvmgKHUH7UTCfmGI/hy039AUwQe3Ok57ObBIh7xiVTVGr67zYaGu2I8+UnESRvsLwABVFRbB93TlYvMKlD/RzhaO6x0M3W5CjM7fuV2JnaUgP9JfDWCOPBX/QV9+H2LTJvQd9MkY8dfyMWN6rZtzDczfZRumGltZspAWU+u8abhjq23jc0taAnM/lVjzMvG1bZQkXL0BmPayzbO5Xc0D21z256/b1gLxxbK/8c8mecZOYTJNFXNUinVdCgsVK5Yhy9tPbw1yusRf5PLgVxhxTxj7UN3SVRn6Je39pQnjzsoHx030CsgvwFTTBu0jtUb0F1MhJndoeXg65sdMSysHX6pd8PQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB5387.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(52116014)(56012099006)(22082099003)(18002099003)(6133799003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U5Kyu1TifLjV80tFxL5zHsQNN3X9YtFWvtZ1g6FUxtQ3WKF+8PqvbVSAW/QI?=
 =?us-ascii?Q?L/A0PkfEF7IHwt6P0V8cL/on1mLkNcK45QPOI+jS+nQh/j4lghsjg5FinlV3?=
 =?us-ascii?Q?gwJCe6bpPv+wAqxEB6dXFmh04Xa6KKJnQEOs7MBr3vVaLErkK22V1nvJel5W?=
 =?us-ascii?Q?kPn5nRHzBpoBnWL1JaC4GnDArBHlIxX20iguLAlUr/TmiX8XYfn2gakmfKdq?=
 =?us-ascii?Q?slX2UMB2DGVP5XOW4dxeBc2HtEoCpisI1NWqKVJ2KvxTdrkjXk5u9dWfsG/z?=
 =?us-ascii?Q?DQJjNAKBmpqAGF2M1/f8iH2fKnfRC799rps/YpQ1ztR0wzIjrUqxnAwNVcWG?=
 =?us-ascii?Q?jc9OJTQmvOHjWx8Y81FvwPSdDKZJ130949dbQpLTEfpcIW3SaVzU3NIj7XY0?=
 =?us-ascii?Q?7/tvhHNpl+MS0TNq2mpidhU4MtZqzdOOzbdKgUdEI6l/LtrSD8I0GPVBPVCf?=
 =?us-ascii?Q?1vJLbPJBmLwbpa1n1ZRJHJjNJ99ZqVoQzyS5s82hCu4cgSsBjxwOkv+bR0B0?=
 =?us-ascii?Q?t7EvZ8Y0GSkAEjQ7TYA40uerBz16NcbsUNDLD7pLNRjL4JRyYvW8IV6c7eIm?=
 =?us-ascii?Q?sdwXo9V3ptj1zHoN5LeEnK/lnspaETWPDEBrFfd+ZUpQyA8QPtMHPhl4NXTz?=
 =?us-ascii?Q?S7SYHFAFT+bAYzH7hCCFJ343dhhgK8TydRD+fzk2eDgCxe1RcldNLQRgOJgh?=
 =?us-ascii?Q?raWte2ueIR9ZtUCZBRhCXmYVNfDOWo6Ypb1rAi8zEA0h/D7d8K00SL916jdB?=
 =?us-ascii?Q?SKzXKvI+tXfyhgzUBHhggbTOYDMD1u1Y+iJnQmat0F4izht7zanva3qRKrCg?=
 =?us-ascii?Q?XsnpWeqzMj1QZECmdtXWwklTnoGc+y3BJ8XgtHN9UVRYk3uDEYmKL8sNEmFV?=
 =?us-ascii?Q?G/lo6ByfMNDJH/l78cQ3DWy84e6M8p03eY0QrkSfJ/azn2yIU8CjeGJJdXFL?=
 =?us-ascii?Q?Q45gmZyJY284SmyfNszG0BADeaKSXu9yuhyH/3AQjBj35XtLbxC2rZRoa3BR?=
 =?us-ascii?Q?NNfrzCBcXp7fqGGqMOObjf7U611ZZxk9P1NnxX8zlVnBrlduP2GCqdxR5Mcg?=
 =?us-ascii?Q?GHSL4YVCYW40DXW82sC07PbcPNaiCep4KMv6pezOr/dQ+pkLwx+sJSps1Hr8?=
 =?us-ascii?Q?2HjfYWnB2KI7+QxVJqBXtQpx6LnAwrfV0JJF4fbDLW0FktajCc6ggJgF6rh6?=
 =?us-ascii?Q?QAcNdzifNwqPx1LjZ5LNBN4QjOQqlgaF0AXt1VNGRbNfpk8ETigDDDrGABF3?=
 =?us-ascii?Q?5CZ230qVSiuShfU9mQAB8SqeoY2Yxbp9mwfnjDARTfkk6Lz239NgnwrKOrlW?=
 =?us-ascii?Q?z02OnFXuxo8z5303p35bPdW61aFZYhM+uK3fVj/mBN+vqHNMSLN99kpHbtRc?=
 =?us-ascii?Q?aVK9wVoC52IvNz38Re2SsRb3m/+sZxOx72S9g995bInSmha3pMjXHvRhfwsD?=
 =?us-ascii?Q?UExIs4kIM25zqq5rIaKZ/5RZRiFJ1SGB4ls6MqGJiCaPkgc035w9dUrJyxc2?=
 =?us-ascii?Q?9a2cSCmeqwS0xFMI8pUj8T+F8vE1rWkLqh5SmXkYC6f2Er6FcKmXkorjiAbD?=
 =?us-ascii?Q?gNqKb5QBXSOMHrAh0dWD1c6QHaudbDE01NnpFSZsgQhd/yabprzkEIeAZf9D?=
 =?us-ascii?Q?laWjSTb7VgE0UHcYb5edXdmdvghU7svPbkRerylfOQUAxAg4gj65Dj1DhmOF?=
 =?us-ascii?Q?ZszRRT22+c1FK/HqK3b/9UxtPwgNuXqK4rYM9aDqDuoy70LTmg8q9KVB/LZP?=
 =?us-ascii?Q?kChQlsPGw1/9iJYi1pEsOPy01vzBMn0=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0218cd-30db-4912-991d-08dedd7bae19
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5387.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:34:00.7496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RK3t8DRwN9/0KU2/P9EbNAkXTj7iZ9MfhoX/HjRI22x0palZLf0jsWGH0PdeKMsX6T5x8XqIEYoATZZtlPheEyKAjkAIOjuhgHTYcEx1bQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4610

The rx_trig_bytes sysfs attribute currently relies on 8250-internal
helper functions and assumes a fixed mapping between trigger levels and
FIFO behavior.

Some UARTs provide hardware-specific RX trigger mechanisms that do not
fit this model. Add optional uart_port callbacks for setting and getting
the RX trigger level, and use them when provided, while preserving the
existing 8250 helpers as the default fallback.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_core.c |  4 ++++
 drivers/tty/serial/8250/8250_port.c | 14 ++++++++++++--
 include/linux/serial_core.h         |  2 ++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 0a3355eb4bc3..052c0020a860 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -792,6 +792,10 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		uart->port.get_divisor = up->port.get_divisor;
 	if (up->port.set_divisor)
 		uart->port.set_divisor = up->port.set_divisor;
+	if (up->port.get_rxtrig)
+		uart->port.get_rxtrig = up->port.get_rxtrig;
+	if (up->port.set_rxtrig)
+		uart->port.set_rxtrig = up->port.set_rxtrig;
 	if (up->port.startup)
 		uart->port.startup = up->port.startup;
 	if (up->port.shutdown)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 72ecc0112b8a..2ece8af5d149 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2999,9 +2999,14 @@ static ssize_t rx_trig_bytes_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct tty_port *port = dev_get_drvdata(dev);
+	struct uart_state *state = container_of(port, struct uart_state, port);
+	struct uart_port *uport = state->uart_port;
 	int rxtrig_bytes;
 
-	rxtrig_bytes = do_serial8250_get_rxtrig(port);
+	if (uport->get_rxtrig)
+		rxtrig_bytes = uport->get_rxtrig(uport);
+	else
+		rxtrig_bytes = do_serial8250_get_rxtrig(port);
 	if (rxtrig_bytes < 0)
 		return rxtrig_bytes;
 
@@ -3044,6 +3049,8 @@ static ssize_t rx_trig_bytes_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct tty_port *port = dev_get_drvdata(dev);
+	struct uart_state *state = container_of(port, struct uart_state, port);
+	struct uart_port *uport = state->uart_port;
 	unsigned char bytes;
 	int ret;
 
@@ -3054,7 +3061,10 @@ static ssize_t rx_trig_bytes_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	ret = do_serial8250_set_rxtrig(port, bytes);
+	if (uport->set_rxtrig)
+		ret = uport->set_rxtrig(uport, bytes);
+	else
+		ret = do_serial8250_set_rxtrig(port, bytes);
 	if (ret < 0)
 		return ret;
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index f6ba3e7b09f1..13b0d4117036 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -459,6 +459,8 @@ struct uart_port {
 					       unsigned int baud,
 					       unsigned int quot,
 					       unsigned int quot_frac);
+	int			(*get_rxtrig)(struct uart_port *port);
+	int			(*set_rxtrig)(struct uart_port *port, unsigned char bytes);
 	int			(*startup)(struct uart_port *port);
 	void			(*shutdown)(struct uart_port *port);
 	void			(*throttle)(struct uart_port *port);
-- 
2.45.2

