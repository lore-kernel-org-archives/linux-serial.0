Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022101.outbound.protection.outlook.com [40.107.75.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03255285CAA;
	Sun, 30 Nov 2025 10:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499497; cv=fail; b=lbNIOMGrUc7LxNW14C/o5k9djABGSJUKT8rNn04IeYUhRarP0Vgh6j8zsJY/f2a9w6uSwUrQsoJqHwBGE/lx5hnvVI+6sduwdFWsPQekctxi8Xi7jVLdL2yKHlNZKsTb6cfkcGPTLVQAmHBMb1lv22cFz6G8U46j4ZOj+JyaCq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499497; c=relaxed/simple;
	bh=FyVt10JMyR8At+ytNqlHW5L2MQgYZ8TicQhQRmDhutI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JVZl+IWtJYiL12Gf5d+Hee3TAjwlNh/lq7WbV2OA2MiegOpNMxZWcx52Epb3OcYdKNElzyHrCD/sA0+mG6alETQoAX6NqeL44s93idlIFDGLMNnnHO36r/X5KIZsF3yiup3LKzC9qWTkypZ4atHygA9O3U4zmPUrv69PFCUctRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=KA90oLWP; arc=fail smtp.client-ip=40.107.75.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="KA90oLWP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/RJ6eGnQ1fHNTIPR8QoMRCoBoG3kp817eOEzses2REkXbowp8jKzWaF6e09fdZCw+odfoh4cLHn0MBUpo7u7ka3uPLvor6xaiQemT+Lr6kc58vD3mr94x3z1yKWaDasYXaVu4ae0RXUaXtiW/QGwYVDxVV+EPhpPl0YzQws8oc/nOPVZOgoh4WUOomvZDco9kGjItmo+neFhlbxrokzjicLFeW0ByIML/JPVm89W3hIzrGqHrlb+wapBVT45ooGFrFlRT4oon30UuntSHO5lC0miOWnvUhRoruklxKb7Cvjd+gFTu/VHwGtXLGz1+D4odga2jICQFssXdl8c070ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8wsN17oUIKdmiSDTDqSnJiAogSkY69ubx1bmG8UOeQ=;
 b=o+JWeiMWCoGKglATrf6F6iK3Y2GV3f2WFavjH9xHehdHJaZZpNitMCqi1UbAdF3WbjiGA897GseqQsfaJUpOW0ysBFb1F8mU24muVO7k5EinBo78nuVJ3eqUWT2EWBipWpWrCqJlc/wGASwCD6gMadwbWa1Ht1/GKqv4kTrP+m5qgzzpnHpFwLwNlg1SBxEmca+TxNHnQTrQG2YrJQNtPfU1jEjc5/qvEYS4hkX5SYWGt+98b3aX9IKbCUChGdZ5kEn2O13PjKG6rGNxmR9ZxOR4ymZqzZ84rmpSooUrz2JI/GnLa8k7Bq7CZwZxMnOnNEjaAB8pPWkU1awlIGm+iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8wsN17oUIKdmiSDTDqSnJiAogSkY69ubx1bmG8UOeQ=;
 b=KA90oLWPYM/MjZ2NNxJokCA+xL8e2qilgh9YtHS1gG+qWi1JKvqcAXSTzYJfvno8NF11YVYHW3iKX0Jrvf8e1YxDnnfWlimwclmE2SVOaSGgJpir7hZSvX9kK+wFTMWrTaF3H/l0m0g52JLC3BkeRsbOgTUu3UnACRT2wrDiiM8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB6080.apcprd01.prod.exchangelabs.com
 (2603:1096:101:221::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:44:52 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:44:52 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 17/31] serial: 8250_mxpcie: enable serial interface switching
Date: Sun, 30 Nov 2025 18:42:08 +0800
Message-ID: <20251130104222.63077-18-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 073c6b9f-d9a0-4a4a-72f7-08de2ffd7e41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ksvIM5IbvMX4Q6go6CKz2gNyj3KjEyJLH4DOq0pvVrk1ZhI9p2Y1LsH/CNk8?=
 =?us-ascii?Q?xJTxwEoMVm6H31yDPOKu6JUp4b6DNcV9BEr9OCGxaYIpwRLzApJAMZAiiDpo?=
 =?us-ascii?Q?/CCkXwLtArKL4BFOwVN/ew7fUwRMmStR0SWFzC36F/ecvRz/d5ZRHImJ4/O8?=
 =?us-ascii?Q?xP7/R2LztqDqR3cZsyCF2JDbM2p9OU4+5Wd+FotJHyuO/7P+/pt22CcLgp3Q?=
 =?us-ascii?Q?/j8UiFSxNNLnGv4wNebV938AUmOm5teOat8Wkgf6XWkQqxK1R8B3G5WAMaKc?=
 =?us-ascii?Q?wDPdItMgnMrWV2C6s01GM2GeSemG5eO8PzySLvsTnxxssvVZre1kjrpAdbIg?=
 =?us-ascii?Q?s/hnMzMNl7QJbeWXyAUZzuw+OalzgD7ASWjahLjdFvIOcg1rtj0kDi/SpgGY?=
 =?us-ascii?Q?ipPfRR5CoJywvEA8DH3Cj9PxCjgXux/7foNMxlttKrHHjXg1yKXJzo+2Tgpk?=
 =?us-ascii?Q?pTHAh8odp7rDYI5MQw8Nl+yK7MGcadGV+17mfnavh9g1ZACAw6uO94ZiV/J5?=
 =?us-ascii?Q?9C3OhX0YMJPbspwhhM1MN0H3e5DoXr01/5QW+5XJrtSwQr7nWL6am1a4LbZt?=
 =?us-ascii?Q?qIiAZyf+fygVDje9WOtTQ4J3wLK0V4338fohA4sl2pOZFNYdwooCA3ra5BSG?=
 =?us-ascii?Q?QDkze48HIirk7tlQVqTfG6z2gBMjFVrF7gxP6XMj+MixkIYWe1/UYv6FxUYP?=
 =?us-ascii?Q?cQso7lP3pulz8vu6uXseyze66bdYzsPmKOcLx0KUjtJO1oDup9cHzXwc5POR?=
 =?us-ascii?Q?LpFB4xqRxCYMai6laYWhnEPCSVG7G/ImQA/FdE3PXZ9B3HalrVQGtmjhyi91?=
 =?us-ascii?Q?mP4Ta4IumLUSelM3L4tOSA5G59e8Q8Ldv4Boaa3FxYoyrdisj76zfrW9b8oR?=
 =?us-ascii?Q?sYZEd2NF6FvWU5Tb6lDmZkTWkDPkFHG3QosplsQ5EVfLkxU3IWEfzvJA4nAm?=
 =?us-ascii?Q?6bKMf49t/ra2uV4ERY3YPt7i6zUBa3VRWdHkYybofsZ/c7W2MV46FNbqnQy4?=
 =?us-ascii?Q?+I/wpjiEKhEPDmZstUs5fy/bzaBRaLrHf9Djf0n3PW1Sfs06IvbYDCDL5NXc?=
 =?us-ascii?Q?MuJpEjkGv7S+7wIu+l8+lDo6Ab6+WzhaOjZ+xUfGrYxJSJiDCZUML/vZj02/?=
 =?us-ascii?Q?cwt0MZy+ghGEeEQgjbAlgOfCOUrxVmZjr3dAIc5MDmuNqTBni5eb7pzsenaS?=
 =?us-ascii?Q?9AjhuDyN2ajrdwIkZOOqFi+PgtHLDfBP6xw820CeMTEhmWFzl7x8lY5+f1D2?=
 =?us-ascii?Q?prmpeeVk8FXX4XHaiyQWRgoTgYofnhV0vdcO1/yn9OJ6oPhxS5jlbSOKU+0N?=
 =?us-ascii?Q?J3JWQhnsFX8HpuMpf8uqPtNrDiskd5MnfuP+pnaf9+c6+L7c+EcniXdOdiQ3?=
 =?us-ascii?Q?RdQxjKtKHmuzLq3DGZPlTN200ZYf58JPmpR2ixyuaiDzQT5CavZYAybBunNQ?=
 =?us-ascii?Q?wG2L1767gj+Obq+oSW581OAOt0iec8jcNugTLto1bEh9puBbL8DZgT2RQP0T?=
 =?us-ascii?Q?4+hthDVfAEQkjstMuIqwIU1teLYJFgHu1E3l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?06U231ZObUppvi5z8y3ApGEfA2+NTF0/WhrwBeu6lUKg7AD6IbJZT25UfNII?=
 =?us-ascii?Q?ZwUqWd2KK5phvWngNawIMGHNEkD3PNYKhdCl3ZsOyBpQ8OYWDql6WcdbW90B?=
 =?us-ascii?Q?wVQKRYnr9A44E4pSli7m09r82NWb2DRNJRXMug9btxF9ZrNile8xLJhYXMGD?=
 =?us-ascii?Q?2yCGUeBa2or9OTrTnOk48vygF9uCeDmbj1CoHJcWlRE/ZB6TP8yz41AEHL4A?=
 =?us-ascii?Q?W30RrS6gEPdUVBCO1B71TfJptAceURr0TLcVewB7fmrKSORl07PPpRNaR2o1?=
 =?us-ascii?Q?Kgub7eZVULVRZbS9s4bPUX2hRmRXk9xqlB964WJQIwsdRs37zgh5lvQBEZpr?=
 =?us-ascii?Q?hgmE1rikDv8/OxyWWWBwMlFDCwpuGxmoWSEm8vPWB0Z1eCpBLznM2Vrc3Y4r?=
 =?us-ascii?Q?mOpSSbRjDbnkPjpwBX9wEeHijeZnbIzHOSO+GqqUQTGIu8fh1nHtaCmAZYu3?=
 =?us-ascii?Q?RMg0459hxpnE87pezsH4bDYLhXW3/WV8sxkGZn5SkihGdZXZo46VzMDVCBOF?=
 =?us-ascii?Q?k6UwsczDObVM3QjDO5DHlHfmfZzsKbhic995J6TBxkRWGQml7qV+/hh6JW0H?=
 =?us-ascii?Q?BuINjDjOT1gIka3mQaGkPEqSDUwaew5gS6dGeEFKZFvXw0/Ku/OtZGGkBJcN?=
 =?us-ascii?Q?RcDZ+EIXnpWFQtAmyx3c6Z7PExoNTKRaY82cLyExSDPEcCVvE6s5+VE6csXT?=
 =?us-ascii?Q?b5+pkoaFaWAoxUYDd3+PhdN3PPyrbJlnqQjDdh78OEbMUDqceC92IH75mgXv?=
 =?us-ascii?Q?+yiZi3tZVmaANUXe5aUtmubFI8mma2ZfabnOa36bEvoxY5JE5WeTNcSC5qAu?=
 =?us-ascii?Q?jSYG/zkl1nyT9vt0KIRxoZbeMwGNO7A9Xk2q1LTvmi0KkdfumkciKyBZEpO1?=
 =?us-ascii?Q?19UBd3PV8bPBxO3Ty9rnQtzFuECpoKCteReZnEsCjN1yAQxlDtp/i3bjU8fw?=
 =?us-ascii?Q?Q+g9neTgXp4mnpZZ/Hclixm1fUwa8DdgIl6jMQGFXptb+LEvTSjXEmY/4Nu3?=
 =?us-ascii?Q?2Ah5EfXq5e6Gqyn6s7wyos4edoVifOedXfoTtDWMt+cmTYAurr6ewKHBmvuP?=
 =?us-ascii?Q?UGCj4LeoQ7WfN1KGGifLYwNA7RFh5l2RjZay0Rn1okq3gCQOV6gzQqHlV3OF?=
 =?us-ascii?Q?gFIURQFAwGQZ8a6d6S3x0w8XuaJZYRdKyh/wPWD+n21SAi8NoQchZtYIST9f?=
 =?us-ascii?Q?377CtiKeXsbzPcBLcuDARO/Z8ot8L2bx8zz9cR83zRrD8yhGzNDoO2niaCrx?=
 =?us-ascii?Q?6DAsz63tacrNtRXc7MakbJtdKV4gXoqrUfcewKCifP253iwPpkjRUk6HLEiL?=
 =?us-ascii?Q?FTUJoebjPzmBMOeJFwcPrNvHSL2CwFti6d9PtxOjUCuCwDm9EBP/6VhnmAWe?=
 =?us-ascii?Q?BEqyfFPftOqF1+n7cHD6qPuS5KyzQDoMHLHIpjl7/9Q+V4mVyfestj5EeTUk?=
 =?us-ascii?Q?Z3b0923KwwP5vcsrUwyOECJb7ICVC2LH2CgL8n6lqwZA+szlcKD6oI82FlXo?=
 =?us-ascii?Q?aSeWP+5AfoKTDAqaxi5f0j8GGrORXDqQdUNP91fwr3Wdkd/e6ztlXcUsm03V?=
 =?us-ascii?Q?xkI0/kCh9b+gSGWxg7c9zcOMDPkjXK/uK4mqszDhnDKHUwrqXS67Y5HDYQ7a?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073c6b9f-d9a0-4a4a-72f7-08de2ffd7e41
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:44:52.5747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4SQsD0EwyhvwAHFOR6Nz7AffXsOVS5EaVOMtcxDzD5biaNqJcAoZz8uYmiEc8wFkRO2A9FijxlsUdQ6wBONi/L46YvzX8rzru4eKiVgWO0U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6080

Add support for Moxa PCIe multiport serial boards to switch serial
interfaces via the ioctl() command "TIOCSRS485" using the following
flags in the "serial_rs485" struct:

    - RS232                  = (no flags set)
    - RS422                  = SER_RS485_ENABLED | SER_RS485_MODE_RS422
    - RS485_2W (half-duplex) = SER_RS485_ENABLED
    - RS485_4W (full-duplex) = SER_RS485_ENABLED | SER_RS485_RX_DURING_TX

This allows users to dynamically configure the serial mode without
requiring additional hardware modifications.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 45 +++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 90ce522fe40f..5d1097c166e4 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -105,6 +105,10 @@ enum {
 	MOXA_SUPP_RS485 = BIT(2),
 };
 
+static const struct serial_rs485 mxpcie8250_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RX_DURING_TX | SER_RS485_MODE_RS422,
+};
+
 static bool mxpcie8250_is_mini_pcie(unsigned short device)
 {
 	if (device == PCI_DEVICE_ID_MOXA_CP102N ||
@@ -166,6 +170,38 @@ static int mxpcie8250_set_interface(struct mxpcie8250 *priv,
 	return 0;
 }
 
+/*
+ * Moxa PCIe multiport serial boards support switching serial interfaces
+ * via the ioctl() command "TIOCSRS485". Supported modes and corresponding
+ * flags in "serial_rs485":
+ *
+ *	RS232			= (no flags set)
+ *	RS422			= SER_RS485_ENABLED | SER_RS485_MODE_RS422
+ *	RS485_2W (half-duplex)	= SER_RS485_ENABLED
+ *	RS485_4W (full-duplex)	= SER_RS485_ENABLED | SER_RS485_RX_DURING_TX
+ */
+static int mxpcie8250_rs485_config(struct uart_port *port,
+				   struct ktermios *termios,
+				   struct serial_rs485 *rs485)
+{
+	struct pci_dev *pdev = to_pci_dev(port->dev);
+	struct mxpcie8250 *priv = pci_get_drvdata(pdev);
+	u8 mode = MOXA_UIR_RS232;
+
+	if (rs485->flags & SER_RS485_ENABLED) {
+		if (rs485->flags & SER_RS485_MODE_RS422)
+			mode = MOXA_UIR_RS422;
+		else if (rs485->flags & SER_RS485_RX_DURING_TX)
+			mode = MOXA_UIR_RS485_4W;
+		else
+			mode = MOXA_UIR_RS485_2W;
+	} else if (!(priv->supp_rs & MOXA_SUPP_RS232)) {
+		return -ENODEV;
+	}
+
+	return mxpcie8250_set_interface(priv, port->port_id, mode);
+}
+
 static void mxpcie8250_set_termios(struct uart_port *port,
 				   struct ktermios *new,
 				   const struct ktermios *old)
@@ -392,9 +428,14 @@ static int mxpcie8250_setup(struct pci_dev *pdev,
 	int offset = idx * MOXA_PUART_OFFSET;
 	u8 init_mode = MOXA_UIR_RS232;
 
-	if (!(priv->supp_rs & MOXA_SUPP_RS232))
+	if (priv->supp_rs & MOXA_SUPP_RS485) {
+		up->port.rs485_config = mxpcie8250_rs485_config;
+		up->port.rs485_supported = mxpcie8250_rs485_supported;
+	}
+	if (!(priv->supp_rs & MOXA_SUPP_RS232)) {
 		init_mode = MOXA_UIR_RS422;
-
+		up->port.rs485.flags = SER_RS485_ENABLED | SER_RS485_MODE_RS422;
+	}
 	mxpcie8250_set_interface(priv, idx, init_mode);
 
 	if (idx == 3 &&
-- 
2.45.2

