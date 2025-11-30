Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022105.outbound.protection.outlook.com [40.107.75.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46F0296BCB;
	Sun, 30 Nov 2025 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499547; cv=fail; b=VgzF6FFWv1PmIruPjjKZyyXUjb0IiXP7qYk+t94iDeNTnQOBndYEb5eS5kxbVo5Wc6+jXKJ671B/0WnfjIGEt7SZr8Ouh1pAGmbG4+tdM72AbLgrcO6YDary4uR7XTyk7QF3czoGFHjIH/6iSTdVuUsY8pWB2qxC+9ZzVwplO2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499547; c=relaxed/simple;
	bh=uoVU3ZqkEMzoGQBu/ZUXW8ron7Z+J+OPugdaJSlyhbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bJGZ8ifL7rd//Ds+GQMBd3gxWTIXj4aR5Ry3yNRh/aSwSiWMQcb5NQm1us2YLwTOpmbq0MOBWVQVzubQgMr3bhbKQX73xQQmSW24aN5L57Zp+G4vQzw9x4uRzY7rqt8mtjD/ml6BnZclrjn76EStVTZKJwgtnckZoyGCYmePOsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Rjyb/xtp; arc=fail smtp.client-ip=40.107.75.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Rjyb/xtp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feq6HAVnObMx6hX9bPRYVwB9PLLV3B6vJD1EAzN2Li4VME/v8vV+LLnUpMMHasA9xvKL5eJhfE+QchJRHbx3CO/aB2ju1i9PfcO/+TUaMa1qZhvB9x8wrus96NNxT5fEVk4G0J9NCsUeKCvREYtF68m2Obu9QNpgDMe5ciw3FOr8Phh2hHeA7YiisNIuPfZe6txDkop+rxL1Ku5wfdpDFIoxiSCrh7izt9XWPB4MW3bVgg8Ik1Vtg/PBIPxsgjK7ye9QDVkcDS0dht5DaqgzLG4oYx5q722NMfgQNjMl5kp5yUItWSLY9y90gHMdXXyZTBD3CRYnWIYk2TcTsyBEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LH48BysqmETv9eAODvLxmaAkJKrSxKEWeGlFDvAEHj0=;
 b=DssCqfDj2asdQ4uDUkRBN6WGcluBx9DcVLLa1/vWdEgNW+5cN1qTfFHGn+DTfGoYrqL8ha4Iajzj8FFhzMKsdHumRwgsGnG7h/bRiVRnwV5UrOL6AuXAdfBvTR4o9daM5N7kD0aI/Pd9aHiK4UYyJCofKNuF0WCi9oqPsykkBdiTKXGvFvSmm1R2an1iuBcELHd/IxwNNUNc0yJtltQS24PjWFgER+k73aYkcIBhCiJM13lGdjEHkXQXqfrcMkAMjOQfy1dSW6zAU3hXdUzEpDhDJXpfKXv3AcsCBg7s9Jqz07711nqcQsbgAT4fAwQu4tU7FIiiAS+ls19gdFTJpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LH48BysqmETv9eAODvLxmaAkJKrSxKEWeGlFDvAEHj0=;
 b=Rjyb/xtp6jpQk/79jC0moc8NPY6PU9cZMqZkLY0iLGisO88BHFnX2gRPOqo0m0FtDr9o56qKxaQNEJOWwEDnStRjkz/pdJaqBBH3ZKmLMFcCij5VKyi6HGl6fhgyu7xfCRXTlpc5+OuQokqoORUQGRFw6YqggXSzgIp5W7EYHvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB6080.apcprd01.prod.exchangelabs.com
 (2603:1096:101:221::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:45:39 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:45:39 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 26/31] serial: 8250_mxpcie: add basic CPLD helper functions
Date: Sun, 30 Nov 2025 18:42:17 +0800
Message-ID: <20251130104222.63077-27-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 24abab7f-30aa-47dd-b9a0-08de2ffd9a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?STi0LJpC0862CQI4tXSAiAAtudfmVdqyTpPBae++2vRfYg686pMW5BIvuSGm?=
 =?us-ascii?Q?UN8FFrHdNsCdBRx3woWs4DAi+lSc404Ovo7oTGuxJ+ucOzaNoje1YpIn5lWe?=
 =?us-ascii?Q?YLDkGYKJO6hFMraJBOTJbS7852RjFWYmtNlni5EOS8kNQ8wQwDWuka3q5FPx?=
 =?us-ascii?Q?rDDFkM8BISvdn4NXPhAXFJM0s8/Vq87FosANrxQ8a1FJxVdxFG7YGik+loZE?=
 =?us-ascii?Q?z1+ogWUeNf67Ui3qGRDsXXZlDwaEuGHDv3vNw02yatySTZeLcN08MuaoKV7C?=
 =?us-ascii?Q?TwHJCYCdwjk1SRy1rZRXyCj56PNY1kOSwTy65DQpmdN/GtO1ajBPWdPCKofT?=
 =?us-ascii?Q?gy6A24E4On8gEIZIxRvHx6d5arvu4Hb81GDqDrcFxCOXKus5uEn56UFz1sgC?=
 =?us-ascii?Q?+BFlE9ji62A16Iwtc9T3NdhEWWL1xn9Ygno8YU8zc5XzI5tK/zABrGLBe6Wq?=
 =?us-ascii?Q?n0lRDXL9nBxnTe+d5l+giiDU07X33WKhCJxYvWOBJo6xxMFBBbopzom+5xnb?=
 =?us-ascii?Q?XqEP+rX/hy9ElG4Kux3evXdruHIlGa5BCZo9lO5q/wLBWejWeJltggrT72iT?=
 =?us-ascii?Q?/aOpGxxzctyRs1t48+1CpcrsXQHF3js6ILRWsjcjzclFCwom0SojcLcd0YKm?=
 =?us-ascii?Q?8bTn+25Hi/ENLzDUSiINFj9Wo1YODZldDWgLl5EIY9Zb9BzvlJ3Px2b0Shso?=
 =?us-ascii?Q?676o9lPME/6BUMfYuN5fmsDZE2ZIJHOt+Aj7Pnpwt2ohmvQm0HEsHJJQgl/6?=
 =?us-ascii?Q?6UOh34uzaU+riuXrKxbY5m6/rKQkASj4A4bJIhFhGB+z5E0iF9PsB+Cog0YV?=
 =?us-ascii?Q?j3G7aTBZIRsS6EEEWnH9rUetuMWVWWKsi6LUMscs4G+kgCqJ3YEKsnMND9J3?=
 =?us-ascii?Q?3ANrYOqCpGGxvppXc8VKyUU/EXIjdF/NvPZsGHHs9RMSm0SyzzOUrfc3c4ZG?=
 =?us-ascii?Q?8yxzD8UL2/j+4MgRCk4wB81p8ypVzA+syZRvDaS/1PvX+XNlvwBzfmEu7ejP?=
 =?us-ascii?Q?d8O2ZW/kc+qWY/RBmFPQrRjbDTcZiE1e1AdUjZnU3QbixWCUxcBpFRFW83ld?=
 =?us-ascii?Q?Kxw2wPrcHjXc5cVcJHZp/N1stB/Ic1xsDE5scyo6G7DeU3YXDupa/q93jtRF?=
 =?us-ascii?Q?MXAQeF3am7AKhh7NYw0FAqT+T/Ao9LlIRsM1xE+XkEDXIPBBJdHXpmT0N/70?=
 =?us-ascii?Q?RqN+40VSaG88r4aNL4WsLZj5FFYR1QQ/t+sAWSS9+myNhTpfCAZ2L/i/qKVM?=
 =?us-ascii?Q?uVeAQ5sMmL6OldOsiKTMwzdoUkASx63a3T25hMHQrZrDPei5/vM6N9wKxCFk?=
 =?us-ascii?Q?VzmandIshsV8szxTguRsZ4jlEH2ocbGyGa5W0qVvsedQHit7V3ppKz6clHQF?=
 =?us-ascii?Q?lyS6XUz0fh/WNFfTyX69/uInopF2yTos7r0AUdKhWXFVecqugFLZ9ympt85j?=
 =?us-ascii?Q?Fi0MFakma+ky5zMJWLAJA+JLDkcDXyHIcqwmbvdHFBxrDmH3j2lpLh+3B7Cq?=
 =?us-ascii?Q?SucO1uMyzABmuXxhcuWgou7Nt+VV0PxezarB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KMHeSBI3iOUtyMJRBWAg/D8YNdt4Z7EfdM6eWkKS3/IuLnd3ZbIzJPtLDdlq?=
 =?us-ascii?Q?WWGqFpgLfZVABCtgw2B2MlwV26tZ/fu9NtSGGx2HdF399JJBp29Ed50KsjEd?=
 =?us-ascii?Q?oFmcru2+DR7wflDiDkh7Ta02gmN/xYa+TWD0wluMPE2bCddHmZ+cE/lrYGIk?=
 =?us-ascii?Q?hfAG5ju1Ev9s4rtjXFOzy+KAa8iy92Bez6XVNf/Ksncj+4qpMYagh5d/WTss?=
 =?us-ascii?Q?gAtr9/b+gRl2l4xLSTvekHEaaTYhYHszx0yO4CPq11Hc3YO2iSCVs1xwx5J4?=
 =?us-ascii?Q?kV9JWbTaGHxd3YUtJCeA/P/wxReDpkZaKaAlzQBc0Z3K+N0K9Ihyrn5W8H9g?=
 =?us-ascii?Q?R73jOIgMrqWsk+G7czOjncOAgPJlxlcJtjN3v1zwMzkX4D4Q1PzX+Rc63eZ9?=
 =?us-ascii?Q?nuoM1IgTYydJFOxncip3KKbFJ65UQgxdT3oEkCg2gYev7Kiioyvs/vpnXf/i?=
 =?us-ascii?Q?T6qdmHQLRoa7Pv27XAp2AuR7A3J/8WDKvu4qYbO0Tt3g3F5kwfhYKP8LqLdf?=
 =?us-ascii?Q?gQeMEuk3QeF7VY3WN/3yEKO8UUEd3ikAC1lEtfWtTOey/7vqcwJztHKcSRQT?=
 =?us-ascii?Q?Lq57LcsfyRtvkSid2osUQJxPpCGa+A1Ozf8aaHfQVsyY3UOc1iPa0MNNQchI?=
 =?us-ascii?Q?r7khnmWRqdRuuMct83hf5n+/H5fy/GFCa0tbITlkA8u3j1wRJGGqyNdCyMMI?=
 =?us-ascii?Q?Mq6XTYDbw9M7xKr1NAo3NrwvzcNxx6tdVe2ZYjGtTZ199EBLy9dRI48LVMp4?=
 =?us-ascii?Q?VN8Yt+utwAhV2VeD/ttIJzLI+ozBSttKg7ZNdJcq1wmnOF/ouIgHi74N/MgJ?=
 =?us-ascii?Q?Rsnjse7SMdwVrRlLrHO9cc/SMyk/PeKK2I8Aq9gv6GmtNNnG7ybO51yEFFOo?=
 =?us-ascii?Q?MrtGDcgdyuYhFhSi0STL1iSQsBk0sRMJe1lZqhqh+PfkrfdkNr3zhsjWhj7z?=
 =?us-ascii?Q?Pd3bFIbmmknXon5h5UAyrzHD55Z/cM7bDZQ5LVGgIm5PmYGdBaNkEhx54T3s?=
 =?us-ascii?Q?78UM/PoWy7S3Qo9lA3tS66MVkLy6QcvI14gqYHGFkPPbjCQ2Cu1ip1KkT/E/?=
 =?us-ascii?Q?/qzqAUgLiAApldBlXLzOT0rA4jirpb7QwOy2uCj5WV4q1l6YNHvmZ9KDCAzg?=
 =?us-ascii?Q?JBGfmYIqn4ejAZYLnwgOaI/PblbmU5F5VakX176b/UzIwHseyMjdKZq9prBz?=
 =?us-ascii?Q?x1X1Csv+rr9ymDN95p73MGOFDveJ12DBVc0tpubiiCJhh9EHqQrawkpZmonI?=
 =?us-ascii?Q?7UZs1zABol2l2kC0NQF41SicL5emhGW015pvXcZt6TJCZWK5bJQ0qqKFZiRC?=
 =?us-ascii?Q?iPStsQjzq4RkPEjVN16NMpMiPRMrmb9SHzad8H6T+rTX431AMafyDJZEFEIQ?=
 =?us-ascii?Q?9pMsUWQxX2UgZB3AcckeYsn/+ij58s7easazBwZAlr4klPcBJdq9xilO62rs?=
 =?us-ascii?Q?l8H3dmINZogQ6ZhzNJC9vg7OgRTjbZANy7QVwgoqiqcnH5mDCC3iIumKkYPs?=
 =?us-ascii?Q?y6bVOuGYY+2TwN7eJg3W7YkGIShPD6qgCubLy9zWx0M5E6drVNNuodPp1qRh?=
 =?us-ascii?Q?CTgWBc/OAy0IFVYvL3VP57p2hRqw8MAZqb8CRWJ/x86/OKwyMmSlpcvoc65K?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24abab7f-30aa-47dd-b9a0-08de2ffd9a26
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:45:39.4267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cae/4Vs3xt5GP/J9sxpxuJBZNJcnbEezEjWva+X+OWSXn/mXFm5g1zXKlg9VT2qXvBsLQoOsr+foxQtKWxy0CM51nOU9qcYtYRzeL19WN7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6080

Introduce a set of helper functions to access the on-board CPLD on
Moxa PCIe serial devices through the GPIO I/O space. These helpers
cover:

- Initializing the CPLD-related GPIO pins to a safe default state
- Enabling/disabling the CPLD chip select
- Switching between read/write and address/data modes
- Performing single-byte read and write transactions using GPIO
  bit-banging, with simple delay and retry logic

These functions do not affect the UART datapath and are not yet used
by the driver. They are added as a preparation step for follow-up
patches that will implement more complex CPLD-based features.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 240 ++++++++++++++++++++++++++
 1 file changed, 240 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 6e727b77c105..88ab918fd000 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -6,6 +6,7 @@
  * Author: Crescent Hsieh <crescentcy.hsieh@moxa.com>
  */
 
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/tty_flip.h>
@@ -80,10 +81,18 @@
 #define MOXA_PUART_TX_FIFO_MEM	0x100	/* Memory Space to Tx FIFO Data Register */
 
 /* GPIO */
+#define MOXA_GPIO_INPUT		0x08
 #define MOXA_GPIO_DIRECTION	0x09
 #define MOXA_GPIO_OUTPUT	0x0A
 
+#define MOXA_GPIO_PIN0	BIT(0)
+#define MOXA_GPIO_PIN1	BIT(1)
 #define MOXA_GPIO_PIN2	BIT(2)
+#define MOXA_GPIO_PIN3	BIT(3)
+#define MOXA_GPIO_PIN4	BIT(4)
+#define MOXA_GPIO_PIN5	BIT(5)	/* Address/Data Pin */
+#define MOXA_GPIO_PIN6	BIT(6)	/* Read/Write Pin */
+#define MOXA_GPIO_PIN7	BIT(7)	/* Chip Select Pin */
 
 #define MOXA_GPIO_STATE_INPUT	0
 #define MOXA_GPIO_STATE_OUTPUT	1
@@ -91,6 +100,21 @@
 #define MOXA_GPIO_LOW	0
 #define MOXA_GPIO_HIGH	1
 
+/* CPLD */
+#define MOXA_CPLD_RETRY_CNT	5
+
+#define MOXA_CPLD_GET_STATE_BASE	0x10
+#define MOXA_CPLD_SET_STATE_BASE	0x18
+
+#define MOXA_CPLD_DATA_MASK	0x1F	/* Pin0 ~ Pin4 */
+#define MOXA_CPLD_CTRL_MASK	0xE0	/* Pin5 ~ Pin7 */
+
+#define MOXA_CPLD_READ	0
+#define MOXA_CPLD_WRITE	1
+
+#define MOXA_CPLD_ADDRESS	0
+#define MOXA_CPLD_DATA		1
+
 #define MOXA_UIR_OFFSET		0x04
 #define MOXA_UIR_RS232		0x00
 #define MOXA_UIR_RS422		0x01
@@ -211,6 +235,218 @@ static void mxpcie8250_gpio_get_all(resource_size_t iobar_addr, u8 *data, u8 off
 	*data = inb(iobar_addr + offset);
 }
 
+/**
+ * mxpcie8250_cpld_init() - Initialize CPLD control GPIO pins
+ * @iobar_addr:	The base address of the GPIO I/O region
+ *
+ * Initialize the GPIO pins used to control the CPLD. Also sets all GPIO pins
+ * to output and drives them HIGH to ensure a safe default state.
+ */
+static void mxpcie8250_cpld_init(resource_size_t iobar_addr)
+{
+	mxpcie8250_gpio_init(iobar_addr);
+
+	mxpcie8250_gpio_set(iobar_addr, MOXA_GPIO_PIN7, MOXA_GPIO_HIGH);
+	mxpcie8250_gpio_set(iobar_addr, MOXA_GPIO_PIN6, MOXA_GPIO_HIGH);
+	mxpcie8250_gpio_set(iobar_addr, MOXA_GPIO_PIN5, MOXA_GPIO_HIGH);
+	mxpcie8250_gpio_set(iobar_addr, MOXA_GPIO_PIN0, MOXA_GPIO_HIGH);
+	mxpcie8250_gpio_set(iobar_addr, MOXA_GPIO_PIN1, MOXA_GPIO_HIGH);
+	mxpcie8250_gpio_set(iobar_addr, MOXA_GPIO_PIN2, MOXA_GPIO_HIGH);
+	mxpcie8250_gpio_set(iobar_addr, MOXA_GPIO_PIN3, MOXA_GPIO_HIGH);
+	mxpcie8250_gpio_set(iobar_addr, MOXA_GPIO_PIN4, MOXA_GPIO_HIGH);
+}
+
+/**
+ * mxpcie8250_cpld_enable() - Enable the CPLD
+ * @iobar_addr:	The base address of the GPIO I/O region
+ *
+ * Enables the CPLD by pulling the chip select pin low.
+ */
+static void mxpcie8250_cpld_enable(resource_size_t iobar_addr)
+{
+	mxpcie8250_gpio_set(iobar_addr, MOXA_GPIO_PIN7, MOXA_GPIO_LOW);
+}
+
+/**
+ * mxpcie8250_cpld_disable() - Disable the CPLD and reset all GPIO pins
+ * @iobar_addr:	The base address of the GPIO I/O region
+ *
+ * Disables the CPLD by pulling the chip select pin high. Also resets all GPIO
+ * pins to output and drives them HIGH to ensure a safe default state.
+ */
+static void mxpcie8250_cpld_disable(resource_size_t iobar_addr)
+{
+	mxpcie8250_gpio_set(iobar_addr, MOXA_GPIO_PIN7, MOXA_GPIO_HIGH);
+
+	/* Set all GPIO pins to output state and pull them HIGH */
+	mxpcie8250_gpio_set_all(iobar_addr, 0xff, MOXA_GPIO_DIRECTION);
+	mxpcie8250_gpio_set_all(iobar_addr, 0xff, MOXA_GPIO_OUTPUT);
+}
+
+/**
+ * mxpcie8250_cpld_set_direction() - Set CPLD read/write direction
+ * @iobar_addr:	The base address of the GPIO I/O region
+ * @direction:	Desired CPLD direction (MOXA_CPLD_READ or MOXA_CPLD_WRITE)
+ *
+ * Sets the CPLD read/write direction by changing the state of the read/write
+ * control pin.
+ */
+static void mxpcie8250_cpld_set_direction(resource_size_t iobar_addr, int direction)
+{
+	if (direction == MOXA_CPLD_READ)
+		mxpcie8250_gpio_set(iobar_addr, MOXA_GPIO_PIN6, MOXA_GPIO_HIGH);
+	else
+		mxpcie8250_gpio_set(iobar_addr, MOXA_GPIO_PIN6, MOXA_GPIO_LOW);
+}
+
+/**
+ * mxpcie8250_cpld_set_mode() - Set CPLD address/data mode
+ * @iobar_addr:	The base address of the GPIO I/O region
+ * @mode:	Desired CPLD mode (MOXA_CPLD_ADDRESS or MOXA_CPLD_DATA)
+ *
+ * Sets the CPLD addr/data mode by changing the state of the address/data
+ * control pin.
+ */
+static void mxpcie8250_cpld_set_mode(resource_size_t iobar_addr, int mode)
+{
+	if (mode == MOXA_CPLD_ADDRESS)
+		mxpcie8250_gpio_set(iobar_addr, MOXA_GPIO_PIN5, MOXA_GPIO_LOW);
+	else
+		mxpcie8250_gpio_set(iobar_addr, MOXA_GPIO_PIN5, MOXA_GPIO_HIGH);
+}
+
+/**
+ * mxpcie8250_cpld_read() - Read a byte from the CPLD at a specified address
+ * @iobar_addr:	The base address of the GPIO I/O region
+ * @addr:	Address in the CPLD to read from
+ * @data:	The buffer to store the read value
+ *
+ * Reads a single byte of data from the CPLD at the given address using
+ * GPIO-based communication.
+ */
+static void mxpcie8250_cpld_read(resource_size_t iobar_addr, u8 addr, u8 *data)
+{
+	u8 saved_state, new_state;
+	u8 samples[MOXA_CPLD_RETRY_CNT], votes[MOXA_CPLD_RETRY_CNT];
+	int i, j;
+
+	/* Perform multiple read attempts with majority voting */
+	for (i = 0; i < MOXA_CPLD_RETRY_CNT; i++) {
+		/* Set read/write pin to read state */
+		mxpcie8250_cpld_set_direction(iobar_addr, MOXA_CPLD_READ);
+		/* Set address/data bus pins to output for address phase */
+		mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN0, MOXA_GPIO_STATE_OUTPUT);
+		mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN1, MOXA_GPIO_STATE_OUTPUT);
+		mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN2, MOXA_GPIO_STATE_OUTPUT);
+		mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN3, MOXA_GPIO_STATE_OUTPUT);
+		mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN4, MOXA_GPIO_STATE_OUTPUT);
+		/* Backup current GPIO output state */
+		mxpcie8250_gpio_get_all(iobar_addr, &saved_state, MOXA_GPIO_OUTPUT);
+		/* Prepare address to GPIO bus */
+		new_state = saved_state & MOXA_CPLD_CTRL_MASK;
+		new_state |= (addr & MOXA_CPLD_DATA_MASK);
+		/* Output address to GPIO bus */
+		mxpcie8250_gpio_set_all(iobar_addr, new_state, MOXA_GPIO_OUTPUT);
+		/* Switch to address mode (address/data pin) */
+		mxpcie8250_cpld_set_mode(iobar_addr, MOXA_CPLD_ADDRESS);
+		/* Enable CPLD by pulling chip select pin low*/
+		mxpcie8250_cpld_enable(iobar_addr);
+		/* Wait for CPLD timing (about 70 ns) */
+		mdelay(1);
+		/* Switch to data mode (address/data pin) */
+		mxpcie8250_cpld_set_mode(iobar_addr, MOXA_CPLD_DATA);
+		/* Set address/data bus pins to input for data phase */
+		mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN0, MOXA_GPIO_STATE_INPUT);
+		mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN1, MOXA_GPIO_STATE_INPUT);
+		mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN2, MOXA_GPIO_STATE_INPUT);
+		mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN3, MOXA_GPIO_STATE_INPUT);
+		mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN4, MOXA_GPIO_STATE_INPUT);
+		/* Wait for CPLD timing (about 70 ns) */
+		mdelay(1);
+		/* Read data bus pins */
+		mxpcie8250_gpio_get_all(iobar_addr, data, MOXA_GPIO_INPUT);
+		*data &= MOXA_CPLD_DATA_MASK;
+		/* No need to restore read/write pin (defaults to read); disable CPLD */
+		mxpcie8250_cpld_disable(iobar_addr);
+		/* Store read value for voting */
+		samples[i] = *data;
+		votes[i] = 0;
+
+		for (j = i - 1; j >= 0; j--) {
+			if (samples[j] == samples[i])
+				votes[i]++;
+		}
+		/* Perform majority voting to select stable value */
+		if (votes[i] >= (MOXA_CPLD_RETRY_CNT / 2))
+			break;
+	}
+}
+
+/**
+ * mxpcie8250_cpld_write() - Write a byte to the CPLD at a specified address
+ * @iobar_addr:	The base address of the GPIO I/O region
+ * @addr:	Address in the CPLD to write to
+ * @data:	Data byte to write
+ *
+ * Writes a single byte of data to the CPLD at the given address using
+ * GPIO-based communication. Includes verification with optional retry.
+ */
+static void mxpcie8250_cpld_write(resource_size_t iobar_addr, u8 addr, u8 data)
+{
+	u8 saved_state, new_state, verify_data;
+	int retry_cnt;
+
+	for (retry_cnt = 0; retry_cnt < MOXA_CPLD_RETRY_CNT; retry_cnt++) {
+		/* Set read/write pin to write state */
+		mxpcie8250_cpld_set_direction(iobar_addr, MOXA_CPLD_WRITE);
+		/* Set data bus pins to output for address phase */
+		mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN0, MOXA_GPIO_STATE_OUTPUT);
+		mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN1, MOXA_GPIO_STATE_OUTPUT);
+		mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN2, MOXA_GPIO_STATE_OUTPUT);
+		mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN3, MOXA_GPIO_STATE_OUTPUT);
+		mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN4, MOXA_GPIO_STATE_OUTPUT);
+		/* Backup current GPIO output state */
+		mxpcie8250_gpio_get_all(iobar_addr, &saved_state, MOXA_GPIO_OUTPUT);
+		/* Prepare bus value with address bits */
+		new_state = saved_state & MOXA_CPLD_CTRL_MASK;
+		new_state |= (addr & MOXA_CPLD_DATA_MASK);
+		/* Output address to GPIO bus */
+		mxpcie8250_gpio_set_all(iobar_addr, new_state, MOXA_GPIO_OUTPUT);
+		/* Switch to address mode (address/data pin)*/
+		mxpcie8250_cpld_set_mode(iobar_addr, MOXA_CPLD_ADDRESS);
+		/* Enable CPLD by pulling chip select pin low */
+		mxpcie8250_cpld_enable(iobar_addr);
+		/* Wait for CPLD timing (about 70 ns) */
+		mdelay(1);
+		/* Set data bus pins to output for data phase */
+		mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN0, MOXA_GPIO_STATE_OUTPUT);
+		mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN1, MOXA_GPIO_STATE_OUTPUT);
+		mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN2, MOXA_GPIO_STATE_OUTPUT);
+		mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN3, MOXA_GPIO_STATE_OUTPUT);
+		mxpcie8250_gpio_set_direction(iobar_addr, MOXA_GPIO_PIN4, MOXA_GPIO_STATE_OUTPUT);
+		/* Switch to data mode (address/data pin) */
+		mxpcie8250_cpld_set_mode(iobar_addr, MOXA_CPLD_DATA);
+		/* Backup current GPIO output state */
+		mxpcie8250_gpio_get_all(iobar_addr, &saved_state, MOXA_GPIO_OUTPUT);
+		/* Prepare bus value with data bits */
+		new_state = saved_state & MOXA_CPLD_CTRL_MASK;
+		new_state |= (data & MOXA_CPLD_DATA_MASK);
+		/* Output data to GPIO bus */
+		mxpcie8250_gpio_set_all(iobar_addr, new_state, MOXA_GPIO_OUTPUT);
+		/* Wait for CPLD timing (about 70 ns) */
+		mdelay(1);
+		/* Disable CPLD by releasing chip select pin */
+		mxpcie8250_cpld_disable(iobar_addr);
+
+		if (addr & MOXA_CPLD_SET_STATE_BASE) {
+			mxpcie8250_cpld_read(iobar_addr, ((addr & ~MOXA_CPLD_SET_STATE_BASE) | MOXA_CPLD_GET_STATE_BASE), &verify_data);
+
+			if (verify_data == data)
+				break;
+		}
+	}
+}
+
 static bool mxpcie8250_is_mini_pcie(unsigned short device)
 {
 	if (device == PCI_DEVICE_ID_MOXA_CP102N ||
@@ -585,6 +821,10 @@ static int mxpcie8250_init(struct pci_dev *pdev)
 	resource_size_t iobar_addr = pci_resource_start(pdev, 2);
 	u8 cval;
 
+	mxpcie8250_cpld_init(iobar_addr);
+
+	outb(0x0f, iobar_addr + MOXA_GPIO_DIRECTION);
+
 	/* Initial terminator */
 	if (pdev->device == PCI_DEVICE_ID_MOXA_CP114EL ||
 	    pdev->device == PCI_DEVICE_ID_MOXA_CP118EL_A) {
-- 
2.45.2

