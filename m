Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022074.outbound.protection.outlook.com [40.107.75.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1789C280327;
	Sun, 30 Nov 2025 10:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499533; cv=fail; b=DItV+rIF8lgL38TpNS3XDmE5/t0lRlnbNWOQ03/HhV8P7DAcJIeOK+O2ZDGaZY8Hd6wTJMl8RAEAD/z8iPmsN9MhgcWL1DukAT6/U6Qw9pmDsOD/S9wHb4DGroZIoHNQgiXyg98JLeyecTb3n+0EtoJJdq2txpW8gmHdYhxanwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499533; c=relaxed/simple;
	bh=WnYPHzx8GoslZvwpTuVnklB0FbNJpULMR6V/Vhun64I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qnVgYngfTrdi9k64y9audGFDELeuPRLpbLS8MfIaAhGKvWpKh1M8+DvBGqE+96B/HlTfSyeYhvYle9StVdA9xu63gwDv1CNHhwFvlRUIkHWQDdFSwmq9Ug2Hhm8pSQqeV+RKqFZSuoQpnvYwrEMRj2PbpfUJ5jvZPP0iOOcJGtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=VVDPB05F; arc=fail smtp.client-ip=40.107.75.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="VVDPB05F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLPlSf8BX3BLze/BO7DyQTRxHaNvrzEoOkH7cxMxJIRhzmhfW+EoYCMTqi8oboeNkVz2dRZXCg+TxDa+IrNuHnxrGVxkwEuTbVGEKYM9AdEOkQqkWi+KCape+B0BKQCQVIjMkMxaC1nDjWGFfRsGmgHO9mMxNGF9xJMxZ8cCbrtsoPHYhcPGHr0PoUEb9wEoj6dGsjm+InCHtebCly5Ix8seLl1Q0j+Wxfg3jMVkVUDMNOr/T5Ay9mhwYqwSNykV7GNF0jNMD/+wqzB2rx9IL6SXeOdpIz3K9krqBpTzSnvtyg+o1vC39CKUfMsNwwdxL1SBPZugUvwMGaee3f3bvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TBsCg3OF/wkF30PTjVVTtfKToop1st7HwYwqiL9wa4=;
 b=K9pVfYz8Sq9kKJCwvOFw7I0rzlpfu2N3E4uu4r74TfZOKp2WZAWlkVXut+bu6JzHdquRkBQCe6thvNHJxIBbRNTEwJ4bslwgJhCevOrELv6rf97pOhwreRHNagrJwtOQOS5OBdOo89zfQ50IaS+RjOF0CnvwGdhXvH6DTTmeWM3wDNiznhygx/WbF649cUHd4u/yccEb7RG3teEoxOXe79/A4My9yN//et+CXt2tYb//X3zkHMj6vNo6kU8re7muyeY/dF2+8v6zQ9wGwQBMfPjvqvWEsiFYiea5GXDvWZtGq2ns3Tw2PO6AZeYbVL5Tm3rvu6edlgMYflV825dy8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TBsCg3OF/wkF30PTjVVTtfKToop1st7HwYwqiL9wa4=;
 b=VVDPB05F10pD39oRLdFO/jHOiXqmyOz6zuBzd0wCks3hXMfl7mWWEKE79UiU8SUnxdvuIGvk5dCEzd1Sr5hPj34j5NjlM9XM1hi6tZjxIX71KWIU5JNWgPYo1g855iNbYYEoh83HWT13SUOh+CPYFGUhDvc1vZILiDX9XBIHyGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB6080.apcprd01.prod.exchangelabs.com
 (2603:1096:101:221::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:45:24 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:45:24 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 23/31] serial: 8250_mxpcie: defer uart_write_wakeup to workqueue
Date: Sun, 30 Nov 2025 18:42:14 +0800
Message-ID: <20251130104222.63077-24-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8580360a-624e-4d09-bb03-08de2ffd9134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uLKqz+3+bl/TRR4txI9DEM9RjW6UwYUMiLxxXJ+Tw/EqjNcQA4NJvPEVUoky?=
 =?us-ascii?Q?EJc5j047i5C7KSLqc/EMDg79PQI3ytpFaixnoHAA38ntXaoEcgcTj2nATg3m?=
 =?us-ascii?Q?IJ0x27if10BE8Ql4GZKA6eBM1By4A2vaIJjijvmJirMMnRWyiHSQ0C4Xv40o?=
 =?us-ascii?Q?FOHLfMR199ZF5WERwtVXqlBafMn76YJmN8283t3CnAKXjVYa+zHeLrqnsrVZ?=
 =?us-ascii?Q?dFMijQnXKe0eS/m8ZUiPIubZiGs5YXseVjbCYIjPuDN8x/9vh0lsJLo/h2qa?=
 =?us-ascii?Q?Ojgtbh5tFHl50vkCy46LnBmEzRzZ5K+DhQvwp/LrkUNUf5sA51pVQXrdhJ3G?=
 =?us-ascii?Q?QkZCatds5svpJJAG04FqYOxePP6LUhTP3mJt2kOuRwbNCYIDLXHc6TuBoahq?=
 =?us-ascii?Q?e2mbcYbpD6ZI/+Ta3WvuJ4+Bs4O5jHagnN6th6CQkrQ7hF7xL1sq5McNBTjS?=
 =?us-ascii?Q?3fDdgdF5Mq/ma75dGYGyK6vwbbvVihIIOe1W96jOneL9WXjpSnM1R76yOi4p?=
 =?us-ascii?Q?jzjwW+xmCEgWYOoMVDwHmiU2E9449HNNzyYjJZ2IpFeuK5F8R81h8mJBJB2K?=
 =?us-ascii?Q?n7vmev5xh8lDQHxoDXec1ailhpmFAak7A269fe8LP3gO5ri1QoE9TVac20Zb?=
 =?us-ascii?Q?cGLtwg9qMFryzH0GFlptBPhNci+QiXvNBBU6LTf1UWCzXUX1qX0P0vH8M6Pb?=
 =?us-ascii?Q?+Cu9BpkLddr+6W0a7S+sORzOdlNF6CBaFuBKnSFiaKbU07UT7NuGVFtjhjxa?=
 =?us-ascii?Q?bDVw0YHLsSMj1VaRE9mMwaAPSUAsIzCRf0YiY4VYWMoRaGeoQQBhW4awpOit?=
 =?us-ascii?Q?OA1tpe4FmDwTVhBk8CK+vlX+wO9gw/Vxd07UvM0+CaR1KXJv9AP+yi310Z2q?=
 =?us-ascii?Q?e5gC+16hS8q8keA3ZfGV/FWQ2TMLP9EW0ZuWpxPrWnR6TiWmuK8vmUur6bqg?=
 =?us-ascii?Q?iIItiuuTqukDmYRc6hdHPuChTNrRCcGwFkUByr3yUqZG47TvcFea5m0aYf9u?=
 =?us-ascii?Q?gTZMHBRlKPCZjXRRJw1dBWVZp4tkNKn35+idK8S8kw0TTRBBMw+lclaO+i7L?=
 =?us-ascii?Q?2DD8pF02ZIiYHqvPnwQsWF/41BcZa2xZpf0m5kwYlpwhvJupH0mdCaib1Gmx?=
 =?us-ascii?Q?+hk1KAy1BNfwXw0C7jkd4q6JXS+G/XjKAHlSTIniNO5s9L4RHEdm/HEM8uLu?=
 =?us-ascii?Q?71lQpeQEn1Qy/rjRPPh7yPthk76qPgZzZhDJKQY3mDYcjX1c8N+AfZFNlY69?=
 =?us-ascii?Q?wdQMqKbRY+8pyrVGO8nDyatEku+FJlNuMLCHB1XOviqiwH1mCmvw6Kn6o5ZF?=
 =?us-ascii?Q?IjNONej/TLi9rWWrKN5zjCnF84I5rjZnpBRX9caDEMgDbPiwqH0P/ai8e+kp?=
 =?us-ascii?Q?CQVaKYpKvigHTu12e7P9zz7yQ1nKr1pIu+j4dWLamaDUB2kTjXEHAKj0fT9k?=
 =?us-ascii?Q?KeLn0BOfTe1uh9PdgY21z6DEKFuMBpn6FaUOom7DRCXSEHvHWxc3kYj0KkiM?=
 =?us-ascii?Q?MABy5wInC+3SNGQkeDO5Sd+vxl9bi4iR5f05?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pqrujw67t7N7bMaZWwIDw0cQ7OkjsPELHyW59Vpnn/2KN98iZ0J1oWNWcPyV?=
 =?us-ascii?Q?9re0NeqD//wQOTcg0t6SmLb/oUDo8mg8pQvHQX4cWqRx+XA8Brz/wio2G37F?=
 =?us-ascii?Q?N3Y+5jpDXJmU1z70iYFRxxtkWRTe9arEBpx3UOaf/kukIoo4iLzTBwSc71CC?=
 =?us-ascii?Q?gM5dFntZURhFgFQeio+Y3FYemWW431y3bmBU9oTpUyOQz6wzhHyAHiRSpXWX?=
 =?us-ascii?Q?602IPYYA8lntWw8bOJUA9Qc/Rd4mylIpia5S+y6fey/Ti2MRy37uoy/AR3Tu?=
 =?us-ascii?Q?nJQnnRTSfSevK8/2HK4ZBcBC2BzyADMTh6AQM1tBIQmqjylZEVgBxwPLhUlE?=
 =?us-ascii?Q?u/aaKZ9s5vSY60/75EV8A0Z642+aoVMzYTyxz6oF8uAEZblD+r4MjL3c8n88?=
 =?us-ascii?Q?gP1+DbGDqiSHcSzHZBpSEV+bT+YjNHM1d4FTqcUtfFGpsZLXHuHgNBSNCwTZ?=
 =?us-ascii?Q?GF+4VthFedcJdu0Vrz+9sRj03SDiojCmbq02Db6v+pndO63TSbheqeWiDK8K?=
 =?us-ascii?Q?bLNHkmulFRZU3qSTi0njW27HkccLLc0JfYTTkirL4SPLBuYp3wrr3IR50oSR?=
 =?us-ascii?Q?Qh8OnAx4AVqb8wX2OGYU/9sxWenX1xT9sNQu4cKxhJM752eAmQdWFNpbE3dZ?=
 =?us-ascii?Q?hfX6F9n3W85Ic1xN4EKd2lBBMqI2o/twnQyWCzWKovGv5Cd5D1caoDFB7O7h?=
 =?us-ascii?Q?5x/BQLGcPBRQC14a4tJ75VyYLeDl9Uip0q/lKY1uopSyfHrxhaLAAYBGrIi8?=
 =?us-ascii?Q?nm9oaBJjWf5Yrf08XCcfuhMyuGAtBab+KQ+c19ZEUEAwJnn+f3YurfUTO7vG?=
 =?us-ascii?Q?UZ3eGkBPIdYHk5YsZxREDCBYmPORXw3Dqp8kDtXNrxbgr044j1w9wlGHoaL7?=
 =?us-ascii?Q?iR0Koaf2QzhIZo4fG+yWDdicybRFr1QA3qpiMdxmWAEs5Ms0WD6IyXRtLxvg?=
 =?us-ascii?Q?8y7CPWIp9/6uhC/aS/gMCjksSiYBXEk2vaCi/4bSp5aHg46BMMVKeHR1G1dO?=
 =?us-ascii?Q?vKccRPaw90cOfCU+zQdBk66yiuotP8dVN1QdJMPIZmDN7PNrk7mB35O5Px+m?=
 =?us-ascii?Q?KIGwYXm2YtDyA2XaMst8NwEACkogOeSjgRjsPDuTN7VSRXH+Kqo3wYY0mobC?=
 =?us-ascii?Q?7KUue3T+cel/PabloPse67P7uYQeUCuXy5LhnJoTBkEBwogRAirG0B3m3iC5?=
 =?us-ascii?Q?55hJ30qto76OvgVjQ7hyL3UMSMw8extnllBIfsfqd9xswAyQoEneRv1fnZ1o?=
 =?us-ascii?Q?TTuMw48WQHpsMaWh2ymrTnxk7pFWPeGhYe7txvf+QykHxpIXKG1+8TxX7t+X?=
 =?us-ascii?Q?rlt5ZIuixLdBErLbjkDIFOyjxqtZ7BBmZKfhW3EX53gAWp9iFnZbdWjfYWpT?=
 =?us-ascii?Q?ebowbNDe7VhYjP++MuNyJaRtsw9uXsN8xieB1r+3BcKBCCrxA+lsyHLubfFm?=
 =?us-ascii?Q?wyOgz+vFmNKUj4rZWtZli+7USMspCc27WsvdO4K/eVDsB5axobDsD73qfX5h?=
 =?us-ascii?Q?ZZtdKuOYgByJbTMSKIvuWWsG6pLPHeSjEBf2qHWTQew75F1gEOKXPyB9X3ny?=
 =?us-ascii?Q?FV/OM2gaJIczTCFCVCJv2AKOP+Vu8q/9YurExxFy3ZJQLPuwtRxvhHdJIOWb?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8580360a-624e-4d09-bb03-08de2ffd9134
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:45:24.3525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5lRn/rhQptH4pNi2kjhxHz6ZRGsL8mRk805GMrGr7x7T/ZtA/ITCYjbJzhlGDZCm6Ra8rt90x+MJOFu+62ODTR0bykrHAT/lnjBfPvu26F8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6080

When the TX FIFO drops below WAKEUP_CHARS, mxpcie used to call
uart_write_wakeup() directly from the interrupt path. Move this into a
per-port work item so we avoid doing TTY wakeups in interrupt context and
reduce IRQ-side work.

Changes:
- Add per-port state (event_flags, work, cached uport pointer).
- In tx_chars(), set a TXLOW event and schedule the per-port work instead
  of calling uart_write_wakeup() directly.
- The work handler test-and-clear the TXLOW bit and calls
  uart_write_wakeup().

This keeps IRQ handlers lightweight and avoids potential locking or RT
latency issues while preserving existing behavior.

Note: removal path must cancel pending works before unregistering ports.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 32 +++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 04b9c9ff5cbf..a0deb464a318 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -93,9 +93,14 @@
 #define MOXA_EVEN_RS_MASK	GENMASK(3, 0)
 #define MOXA_ODD_RS_MASK	GENMASK(7, 4)
 
+#define	MOXA_EVENT_TXLOW	BIT(0)
+
 struct mxpcie8250_port {
 	int line;
+	unsigned long event_flags;
 	u8 rx_trig_level;
+	struct uart_port *uport;
+	struct work_struct work;
 };
 
 struct mxpcie8250 {
@@ -332,6 +337,8 @@ static void mxpcie8250_tx_chars(struct uart_8250_port *up)
 {
 	struct uart_port *port = &up->port;
 	struct tty_port *tport = &port->state->port;
+	struct pci_dev *pdev = to_pci_dev(port->dev);
+	struct mxpcie8250 *priv = pci_get_drvdata(pdev);
 	unsigned int count, i;
 	unsigned char c;
 
@@ -352,9 +359,10 @@ static void mxpcie8250_tx_chars(struct uart_8250_port *up)
 
 		*(port->membase + MOXA_PUART_TX_FIFO_MEM + i) = c;
 	}
-	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
+	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS) {
+		if (!test_and_set_bit(MOXA_EVENT_TXLOW, &priv->port[port->port_id].event_flags))
+			schedule_work(&priv->port[port->port_id].work);
+	}
 	if (kfifo_is_empty(&tport->xmit_fifo) && !(up->capabilities & UART_CAP_RPM))
 		port->ops->stop_tx(port);
 }
@@ -473,6 +481,14 @@ static int mxpcie8250_get_rxtrig(struct uart_port *port)
 	return rx_trig_byte;
 }
 
+static void mxpcie8250_work_handler(struct work_struct *work)
+{
+	struct mxpcie8250_port *priv_port = container_of(work, struct mxpcie8250_port, work);
+
+	if (test_and_clear_bit(MOXA_EVENT_TXLOW, &priv_port->event_flags))
+		uart_write_wakeup(priv_port->uport);
+}
+
 static int mxpcie8250_init(struct pci_dev *pdev)
 {
 	resource_size_t iobar_addr = pci_resource_start(pdev, 2);
@@ -533,6 +549,7 @@ static int mxpcie8250_setup(struct pci_dev *pdev,
 static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct uart_8250_port up;
+	struct uart_8250_port *new_port;
 	struct mxpcie8250 *priv;
 	unsigned int i, num_ports;
 	int ret;
@@ -590,7 +607,12 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 				up.port.iotype, priv->port[i].line);
 			break;
 		}
+		new_port = serial8250_get_port(priv->port[i].line);
+
 		priv->port[i].rx_trig_level = 96;
+		priv->port[i].uport = &new_port->port;
+
+		INIT_WORK(&priv->port[i].work, mxpcie8250_work_handler);
 	}
 	pci_set_drvdata(pdev, priv);
 
@@ -602,8 +624,10 @@ static void mxpcie8250_remove(struct pci_dev *pdev)
 	struct mxpcie8250 *priv = pci_get_drvdata(pdev);
 	unsigned int i;
 
-	for (i = 0; i < priv->num_ports; i++)
+	for (i = 0; i < priv->num_ports; i++) {
+		cancel_work_sync(&priv->port[i].work);
 		serial8250_unregister_port(priv->port[i].line);
+	}
 }
 
 static const struct pci_device_id mxpcie8250_pci_ids[] = {
-- 
2.45.2

