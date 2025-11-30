Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022116.outbound.protection.outlook.com [52.101.126.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679EC283FCD;
	Sun, 30 Nov 2025 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499562; cv=fail; b=Uk0l7W+0p/v3BMvqSqkgMjB4tZXC6NJy7GvtrPZV37E+MTI0t2OvYKeKFFCozD7ahjA5zZlwOc/JINzQXz9GazcwRy9nx5AGJiA09iTs97a08mjf8WoRAk7ahVDpkEQqvNV8IDfGQT6DeuEofhqibNRkSzBhVAvNADNM9ph4luU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499562; c=relaxed/simple;
	bh=JRhnAICQSxaJ0EjLSf5XeCuhRDBqXAd/uuQj31IRMXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DNODK6eHT9f52rn1APhYdTpEBjh51f6ptZ4Rp6dDL/DLvCZgTZE8crkmpOJKiTr2mN3kUueOCWMVp7ojIyQWo0d7HYQ8yqH7K35FIiFnUAUfS9ZYsK7hKD1GzFXiWpUAICk9KFR4pmD7iK1xCDrxb5KKLsYd9gQhCMov4+EIUds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=B+5EDqfQ; arc=fail smtp.client-ip=52.101.126.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="B+5EDqfQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARuWolVD+MTo6VofELSbS4eSvjt5NOhoDvoldyiIVdOLogFZNeRrO50d8bobpf7lg8bIQbgJlCllS8qCuIDxJ965tXNvHP0cfNp4BPfI2w2XrxIWQkALiWQ43+w14Hdh+37HkYbLW7xs9QxLnVhZ9DLbg9vEJUnCrnIFKd188MIuViIqO4JTOoAMmaBB3TlUYod72vqe0WM+cESU5ByupSJyTzX8uVoQHrZrujoofs4AD6gFCWb2+DIEfJ/yiUCMfgTh/ItaAO8ZAUkKYlgwKErcheR30XymLqqkLzD148HAU+utzFAOO1ROs3+JUBbt0rkgc+cd6IG3Bb+y9PJrAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Xft3yKfH4zGz+s7gSl3AO7wkd+svHdISV8rmSMCHtk=;
 b=Kj72loSeiBe2diBrYtzR2zBiHqzjALc4CwHXTJJ6lsF05CGCbeHt97ScEqIIxPLnAsi7WPqNJHBtJpyQLIVP2fPcX+vM7Z7bZ3G3bKAEdtrpxPthvKmdtjaU7MiRtvefwCFUkttiPd0eqeLev9KzRevxOQ3kpcOW77wojciMmOp1HWbKCxbt00AycWznL5BnOiKQHFZNb4nDu/Cf/4QH4PbmNntb0P0TqsTb3LwEh9ONPII1URpLzr43J5ZZEyjugpCozIgrG4pjjmyNLaCS2CXwEVtYu/m1yX4kaizSgeQT649HyUE3O6PhXWxYElk+7rxnUraXycUmAsyRZ74vjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Xft3yKfH4zGz+s7gSl3AO7wkd+svHdISV8rmSMCHtk=;
 b=B+5EDqfQ29jXBgzCgDGBhqRXUNS23R9ABbutA/YmAXx67hufbLXPLKjg7NdJiz+3U3UFUJuvIKBTio4iGvfV06qr9fABbvy7YRof7fiq+5LhZoOrxeuJL21tqtVJ/vh+Np9RmyVEjUHM9XK+qtHnPyG8rUgvEa8H+TiMgE/FA+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB6080.apcprd01.prod.exchangelabs.com
 (2603:1096:101:221::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:45:55 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:45:55 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 29/31] serial: 8250_mxpcie: Add sysfs to control terminator
Date: Sun, 30 Nov 2025 18:42:20 +0800
Message-ID: <20251130104222.63077-30-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: af019cfb-29b2-4a09-1c79-08de2ffda3c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I7jNhSzQ+apsWCijCLtZUJhoIEo89lAlAxGsYl59kxYHcJHwYMMTEvFQJUbr?=
 =?us-ascii?Q?j5gsYJJDQluePIL3QxTGahEs9A6uNSmMgMoaP1BJPfblbTips/wg3TlT96dN?=
 =?us-ascii?Q?cGvTo5iGzt4oKquK3eb5V5YbDRmHJxzw/5jcI/JyRlqpxtJPrjTTeQ5fwi5D?=
 =?us-ascii?Q?aI4qktlLWlfKp5QlxWOFfBlqf0aW7WvXloa7SePOPxAdDdB6rPocgwo6B8dJ?=
 =?us-ascii?Q?v57jtnKbbSrj1XQAlGMlcq8cveRQ0NIt4MKOSz0lV12srEHpD38BUSuFimjw?=
 =?us-ascii?Q?29WgEqa+2IrWCp61m8Em74801S1+4G906Qgv0J2fJGnPfWSw7ObD+xHVwImX?=
 =?us-ascii?Q?VuBRMx+Ru479I+w8USz5VTVV5VqH5TSHRQOdk90u3WXArQpvSRrvIbwhVBH4?=
 =?us-ascii?Q?RVSPGTebPE527QjbmwOIX6ZRdV539bKUwSlwh0JBL2tlm5DxPb8F9tYN1AoN?=
 =?us-ascii?Q?r76DUFBSPxHU3S5WUUkuT0nlzxxZE9ySSF4+SqecKHKQSKBDB6DZMthebqgg?=
 =?us-ascii?Q?8oUFV/0kE2jih9c9oGgbYldi2ljWSFG6WIwLKQlA+0bykBVuGB6NHIMR3MAY?=
 =?us-ascii?Q?UoMB7zmGqUaKVRZbFJWdR40UMfUj01Ka3vN6By/71Ps2wLZGDMAY4OWGTgav?=
 =?us-ascii?Q?5AXT5YeY6+gYcZ8XIHlw/WYurF6r6yED7sRBQ3dJJhp0pUuj7CVbb5ahx8XH?=
 =?us-ascii?Q?veF8LqXjCYU88EEFFPYP2aIQdgozQeMX7IlESsT58BhCiTRXJFo+G8fl84XI?=
 =?us-ascii?Q?tI4vROk/9C6YTXlYH9yyvdKebF9Bk0BhQ09t60sNQLg+SL+HUiBZWHcZbEHc?=
 =?us-ascii?Q?2jeNRFy99nnLHQrURRbM4uaFWWUFwI/ACdib9O8oESBu4Fqox76NygczgviV?=
 =?us-ascii?Q?uMSVLw7zVg7S7VMMug7/72iDJIh1yGs6mSIjMmV6K9AvFaUPdunAWh0mGav4?=
 =?us-ascii?Q?LgUDFjNP1i8qV+ffqcwzXHzJcvGeQvZVUYr3sLDmrygBwf/0LIYWCjRdvHn3?=
 =?us-ascii?Q?HK7MBQ9tk9iiX7DhqURrFW3y7GPeIrPeRpzFUYvO+sNkL+r0qYwwdWd6oJch?=
 =?us-ascii?Q?ClTOR4jtMIDfZjbRnVVvc+zi7oHRTpX0zUCJMd74krf0QyXxzxT1FSjsxtov?=
 =?us-ascii?Q?qW/x8PAL8JKbhwPjfPkP2qjERnp8gKK8GQ6kcHYaSuDHGQCxg91reGkfbzVS?=
 =?us-ascii?Q?s6uVi1VvC0jb1Nr9+xS/b00BoDX83wZW33OKRKxvkdgmXe3quVIJ0Uvud+xn?=
 =?us-ascii?Q?U5781Hp3issptwNmsESRhVT8Q+VjmQKcVxZlrxZ4Ro5VB6MwyVHj7SCZ+idW?=
 =?us-ascii?Q?fX6u2FIvkvQaUqe5FTynwjTBLyi0xbZRLmRPHyzp+jmM56wrGNSOOVRd2cip?=
 =?us-ascii?Q?MEhZnbbtVZhCNnGalwzbsbwYDAvYnbp6Czo4T3DUddBH6SwTGxbGLBSOtF4x?=
 =?us-ascii?Q?NqyWyB6xT7vJEAIJzcgkPTKuopsTL86WHYED5P48SPXpoNRatTiDFr6rKGYM?=
 =?us-ascii?Q?iJGZYk+p8xVIDgnLbpRbBTy7Uwcg3tnJxbc+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rVtmlEgXq9sCe1f3vZ9RrgM3exEBE6b67Kho6vpvwX5OT2WKqiwdHmMnHxko?=
 =?us-ascii?Q?vlLS7shgmtpRKuWFRvIW97KpwPFy/FHBFCkHjIJEUbkZEfpAAMKB4Y4GcIyL?=
 =?us-ascii?Q?sLpl9IhGaKEmZneTWSJvSXaW6MMf949nXUaaI5mAoFzGtBQMB9GxI+AmEIvb?=
 =?us-ascii?Q?kpD/vUByVAwVw87ZJ3ghyY1CoIdshRuyM+DPt/rVKGWsSc2vSa1/Dt+BgZW3?=
 =?us-ascii?Q?Fqwq0QXFDGZ7/h5VxZla8n4VtTcq4VOWofxKtc6hao2CwnzOuqtguwTmILY8?=
 =?us-ascii?Q?/r85Lx/V1XFlYrL+DIfPmznb+daqRwwb5FCxsDJZKRc84Wbl55z92IA/4jrU?=
 =?us-ascii?Q?qJmVU6f8m8AIO2tExuVk1ah79AfVR18bvYDyuF7A4bhvHpB4+5Uq5B16PXG5?=
 =?us-ascii?Q?iNjZvZyVkAAh41q1AeceUt7tA0YDUcBcrl8ARsEZfQ7xZS5S++UOUJ8vf9MV?=
 =?us-ascii?Q?hbbuzu8ApwHWV/e53WJATB445+YiskmDxlOIXgJ59Odt6tzb+sMScYcdPou1?=
 =?us-ascii?Q?nrTK6lciYeKQPpZeLEgWfCb0UcC8EnFA1iyWunnNUKquh1X/mQBEbn8g6Hbs?=
 =?us-ascii?Q?IymsOMEBfU2zSA+RvZktCHE3q52nQxXxLPaVf8hv2Y57vDOecmU++kQaWzMQ?=
 =?us-ascii?Q?9Q1gpqWUADGYAYZ9L9Q2zYHalR/Sv88yOomwiptRQsCVYSsVLolqD4qsw0yB?=
 =?us-ascii?Q?0S8EN4w8BTtmIdrrswu9dr+NZ4k5Lcc1odokSqQEO1Ff0Px0WzNwW6yA0+rj?=
 =?us-ascii?Q?X9mAwGBuDxTTzGzz0IG09po1vYjJAyIl7K8pNCRUC1t4755Mwc44KDMURkT4?=
 =?us-ascii?Q?JwQD8a4Wdh9BIajf3zFs/9xQObWNfa5vfZY9bKd4Nxk49bDoqNL+jq8YdJpc?=
 =?us-ascii?Q?l8PD+AkfdAqmgo9KIKxGQkP4a3WWgYlg8orrkfy8mdSKMyzL7cR/pL5cds0E?=
 =?us-ascii?Q?1fBAq6kkxPa1a/pzGqYZAI5/Uq+NgYl6qjMWb99MzK2dZDJ2ZCOYoJqJvg12?=
 =?us-ascii?Q?5d0xZWU3eznEGakdDZU40sM60R92H21pfvXIZV/M8lDIQ9F4Pw8jbgkaTRlK?=
 =?us-ascii?Q?F60s+3MjBtwyrzMthDhjw2uo4xkLC/ke8lFkP8CrgktHVrBpB4xnfG9C9vTy?=
 =?us-ascii?Q?5et1QZTO0WLNIh0QvomwU/sqs8VdSWtGo7p9Gysytq+dhvxV7baybmwZh8TS?=
 =?us-ascii?Q?SibsMaZgAtwvRN71k5PB2/EwOOcE7pJkUudm7AKlILDOAhItB22nJ9HaK1lZ?=
 =?us-ascii?Q?tooRm9feWCn6RSib37xevJIhMvVoiKuTzd/+W861o/1SL8/DHrX8oY/fYt0X?=
 =?us-ascii?Q?9yZrR4fxwVfF6OeTn0O0PtsvK6vT5TQ/5SKfsTYaY6JrU7HIIrsSbPF/7BxV?=
 =?us-ascii?Q?X0bewOXVP1N03LJWp2F8grQIF3ArXD5hu2Qk6t7D5EXiD2nl9IdHEMfEmr8c?=
 =?us-ascii?Q?gigSRjrWubR/zRwlgQNk/PZb3Chie4YIFwuUSBEjW1PZA3Gw0PSIN5SLLd2d?=
 =?us-ascii?Q?Wfby5zdBHLe64uIe7JfVCQKydLGpNbno/e2HsOXc+/vpa5mXh98WMc7SOe3G?=
 =?us-ascii?Q?PWar/rQwk+7SqgT+kC16dnUr7NSbZZwPECJc5iRcazU40hmi7wvHWK38G3mf?=
 =?us-ascii?Q?fA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af019cfb-29b2-4a09-1c79-08de2ffda3c9
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:45:55.5780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwljRGwtVzIkRW6Cam0EayRyzmQUZpAgPC4y5VPg2GkSqPxr7ZKXNGp4CB0WEtr6Absi5FbDkOJZFFSzw14XWdVBP8nxMDLZDmZQkgizmGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6080

Some Moxa PCIe serial board variants support software-controlled
termination resistors on each port. Users currently have no standardized
interface to enable or disable terminator state from userspace.

This patch introduces the following:

- EXPORT a new sysfs attribute `/sys/class/tty/*/mxpcie8250_terminator`
  to allow users to read or set the terminator state (enabled/disabled).
- Implement both CPLD-based and GPIO-based paths depending on board model.
- Track runtime terminator state in `struct mxpcie8250_port`.
- Serialize CPLD modifications using a new `board_lock` spinlock.

Example usage:

    # Enable terminator on ttyS*
    echo 1 > /sys/class/tty/ttyS*/mxpcie8250_terminator

    # Check current state
    cat /sys/class/tty/ttyS*/mxpcie8250_terminator
    enabled

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 205 ++++++++++++++++++++++++++
 1 file changed, 205 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 7a1030a47b00..9dcb91b917a0 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -105,16 +105,22 @@
 
 #define MOXA_CPLD_GET_STATE_BASE	0x10
 #define MOXA_CPLD_SET_STATE_BASE	0x18
+#define MOXA_CPLD_STATE_MASK		0x0F
 
 #define MOXA_CPLD_DATA_MASK	0x1F	/* Pin0 ~ Pin4 */
 #define MOXA_CPLD_CTRL_MASK	0xE0	/* Pin5 ~ Pin7 */
 
+#define MOXA_CPLD_TERMINATOR_FLAG	0x02
+
 #define MOXA_CPLD_READ	0
 #define MOXA_CPLD_WRITE	1
 
 #define MOXA_CPLD_ADDRESS	0
 #define MOXA_CPLD_DATA		1
 
+#define MOXA_TERMINATOR_ENABLE	1
+#define MOXA_TERMINATOR_DISABLE	0
+
 #define MOXA_UIR_OFFSET		0x04
 #define MOXA_UIR_RS232		0x00
 #define MOXA_UIR_RS422		0x01
@@ -129,6 +135,7 @@
 struct mxpcie8250_port {
 	int line;
 	int interface;
+	int terminator;
 	unsigned long event_flags;
 	u8 rx_trig_level;
 	struct uart_port *uport;
@@ -139,6 +146,7 @@ struct mxpcie8250 {
 	struct pci_dev *pdev;
 	unsigned int supp_rs;
 	unsigned int num_ports;
+	spinlock_t board_lock;
 	struct mxpcie8250_port port[];
 };
 
@@ -448,6 +456,59 @@ static void mxpcie8250_cpld_write(resource_size_t iobar_addr, u8 addr, u8 data)
 	}
 }
 
+/**
+ * mxpcie8250_cpld_set_terminator() - Set the terminator of the specified port
+ * @iobar_addr:	The base address of the GPIO I/O region
+ * @port_idx:	The port index (0 to 7)
+ * @state:	Desired terminator state (MOXA_TERMINATOR_ENABLE or MOXA_TERMINATOR_DISABLE)
+ *
+ * Updates the terminator setting in the CPLD for the specified port by reading
+ * the current state, modifying the terminator bit, and writing the updated
+ * state back to the CPLD.
+ */
+static void mxpcie8250_cpld_set_terminator(resource_size_t iobar_addr, u8 port_idx, u8 state)
+{
+	u8 addr, data;
+
+	addr = MOXA_CPLD_GET_STATE_BASE + port_idx;
+	mxpcie8250_cpld_read(iobar_addr, addr, &data);
+
+	data = data & MOXA_CPLD_STATE_MASK;
+
+	if (state == MOXA_TERMINATOR_ENABLE)
+		data |= MOXA_CPLD_TERMINATOR_FLAG;
+	else
+		data &= ~MOXA_CPLD_TERMINATOR_FLAG;
+
+	addr = MOXA_CPLD_SET_STATE_BASE + port_idx;
+	mxpcie8250_cpld_write(iobar_addr, addr, data);
+}
+
+/**
+ * mxpcie8250_cpld_get_terminator() - Get the terminator state of the specified port
+ * @iobar_addr:	The base address of the GPIO I/O region
+ * @port_idx:	The port index (0 to 7)
+ *
+ * Reads the terminator from the CPLD by accessing the appropriate GET_STATE
+ * register for the specified port using GPIO-based communication.
+ *
+ * Returns:
+ * 	MOXA_TERMINATOR_ENABLE  if terminator is enabled,
+ * 	MOXA_TERMINATOR_DISABLE if terminator is disabled.
+ */
+static int mxpcie8250_cpld_get_terminator(resource_size_t iobar_addr, u8 port_idx)
+{
+	u8 addr, data;
+
+	addr = MOXA_CPLD_GET_STATE_BASE + port_idx;
+	mxpcie8250_cpld_read(iobar_addr, addr, &data);
+
+	if (data & MOXA_CPLD_TERMINATOR_FLAG)
+		return MOXA_TERMINATOR_ENABLE;
+
+	return MOXA_TERMINATOR_DISABLE;
+}
+
 static bool mxpcie8250_is_mini_pcie(unsigned short device)
 {
 	if (device == PCI_DEVICE_ID_MOXA_CP102N ||
@@ -487,6 +548,75 @@ static unsigned short mxpcie8250_get_nports(unsigned short device)
 	return FIELD_GET(0x00F0, device);
 }
 
+static void mxpcie8250_do_set_terminator(struct pci_dev *pdev,
+					 unsigned int port_idx,
+					 u8 state)
+{
+	struct mxpcie8250 *priv = pci_get_drvdata(pdev);
+	resource_size_t iobar_addr = pci_resource_start(pdev, 2);
+	u8 cval;
+
+	cval = inb(iobar_addr + MOXA_GPIO_INPUT);
+
+	switch (pdev->device) {
+	case PCI_DEVICE_ID_MOXA_CP132EL:
+		cval &= ~(1 << (port_idx + 2));
+		cval |= (state << (port_idx + 2));
+		break;
+	case PCI_DEVICE_ID_MOXA_CP114EL:
+	case PCI_DEVICE_ID_MOXA_CP118EL_A:
+		cval &= ~(1 << port_idx);
+		cval |= (state << port_idx);
+		break;
+	default:
+		return;
+	}
+	outb(0xff, iobar_addr + MOXA_GPIO_DIRECTION);
+	outb(cval, iobar_addr + MOXA_GPIO_OUTPUT);
+
+	priv->port[port_idx].terminator = state;
+}
+
+static int mxpcie8250_set_terminator(struct uart_port *port,
+				     u8 state)
+{
+	struct pci_dev *pdev = to_pci_dev(port->dev);
+	struct mxpcie8250 *priv = pci_get_drvdata(pdev);
+	resource_size_t iobar_addr = pci_resource_start(pdev, 2);
+
+	if (priv->port[port->port_id].interface == MOXA_UIR_RS232)
+		return -EINVAL;
+
+	switch (pdev->device) {
+	case PCI_DEVICE_ID_MOXA_CP116E_A_A:
+	case PCI_DEVICE_ID_MOXA_CP116E_A_B:
+	case PCI_DEVICE_ID_MOXA_CP118E_A_I:
+	case PCI_DEVICE_ID_MOXA_CP134EL_A:
+	case PCI_DEVICE_ID_MOXA_CP138E_A:
+		spin_lock(&priv->board_lock);
+		mxpcie8250_cpld_set_terminator(iobar_addr, port->port_id, state);
+		spin_unlock(&priv->board_lock);
+		break;
+	/* RS232 only, no need to be set */
+	case PCI_DEVICE_ID_MOXA_CP104EL_A:
+	case PCI_DEVICE_ID_MOXA_CP102E:
+	case PCI_DEVICE_ID_MOXA_CP102EL:
+	case PCI_DEVICE_ID_MOXA_CP168EL_A:
+	/* CP100N series doesn't support SW control terminator */
+	case PCI_DEVICE_ID_MOXA_CP102N:
+	case PCI_DEVICE_ID_MOXA_CP132N:
+	case PCI_DEVICE_ID_MOXA_CP112N:
+	case PCI_DEVICE_ID_MOXA_CP104N:
+	case PCI_DEVICE_ID_MOXA_CP134N:
+	case PCI_DEVICE_ID_MOXA_CP114N:
+		return -ENODEV;
+	default:
+		mxpcie8250_do_set_terminator(pdev, port->port_id, state);
+	}
+
+	return 0;
+}
+
 static int mxpcie8250_set_interface(struct mxpcie8250 *priv,
 				    unsigned int port_idx,
 				    u8 mode)
@@ -495,6 +625,9 @@ static int mxpcie8250_set_interface(struct mxpcie8250 *priv,
 	resource_size_t UIR_addr = iobar_addr + MOXA_UIR_OFFSET + port_idx / 2;
 	u8 cval;
 
+	if (priv->port[port_idx].uport && mode == MOXA_UIR_RS232)
+		mxpcie8250_set_terminator(priv->port[port_idx].uport, MOXA_TERMINATOR_DISABLE);
+
 	cval = inb(UIR_addr);
 
 	if (port_idx % 2) {
@@ -811,6 +944,76 @@ static int mxpcie8250_get_rxtrig(struct uart_port *port)
 	return rx_trig_byte;
 }
 
+static ssize_t mxpcie8250_terminator_store(struct device *dev,
+					   struct device_attribute *attr,
+					   const char *buf,
+					   size_t count)
+{
+	struct tty_port *tport = dev_get_drvdata(dev);
+	struct uart_state *ustate = container_of(tport, struct uart_state, port);
+	struct uart_port *port = ustate->uart_port;
+	int ret;
+	u8 state;
+
+	if (!count)
+		return -EINVAL;
+
+	ret = kstrtou8(buf, 10, &state);
+
+	if (ret < 0)
+		return ret;
+
+	if (state != MOXA_TERMINATOR_ENABLE && state != MOXA_TERMINATOR_DISABLE)
+		return -EINVAL;
+
+	ret = mxpcie8250_set_terminator(port, state);
+
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static ssize_t mxpcie8250_terminator_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct tty_port *tport = dev_get_drvdata(dev);
+	struct uart_state *ustate = container_of(tport, struct uart_state, port);
+	struct uart_port *port = ustate->uart_port;
+	struct pci_dev *pdev = to_pci_dev(port->dev);
+	struct mxpcie8250 *priv = pci_get_drvdata(pdev);
+	resource_size_t iobar_addr = pci_resource_start(pdev, 2);
+	int ret;
+
+	if (pdev->device == PCI_DEVICE_ID_MOXA_CP118E_A_I ||
+	    pdev->device == PCI_DEVICE_ID_MOXA_CP138E_A   ||
+	    pdev->device == PCI_DEVICE_ID_MOXA_CP134EL_A  ||
+	    pdev->device == PCI_DEVICE_ID_MOXA_CP116E_A_A ||
+	    pdev->device == PCI_DEVICE_ID_MOXA_CP116E_A_B) {
+		spin_lock(&priv->board_lock);
+		ret = mxpcie8250_cpld_get_terminator(iobar_addr, port->port_id);
+		spin_unlock(&priv->board_lock);
+	} else {
+		ret = priv->port[port->port_id].terminator;
+	}
+	if (ret == MOXA_TERMINATOR_ENABLE)
+		return sysfs_emit(buf, "enabled\n");
+
+	return sysfs_emit(buf, "disabled\n");
+}
+
+static DEVICE_ATTR_RW(mxpcie8250_terminator);
+
+static struct attribute *mxpcie8250_dev_attrs[] = {
+	&dev_attr_mxpcie8250_terminator.attr,
+	NULL
+};
+
+static struct attribute_group mxpcie8250_dev_attr_group = {
+	.attrs = mxpcie8250_dev_attrs,
+};
+
 static void mxpcie8250_work_handler(struct work_struct *work)
 {
 	struct mxpcie8250_port *priv_port = container_of(work, struct mxpcie8250_port, work);
@@ -924,6 +1127,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.break_ctl = mxpcie8250_break_ctl;
 	up.port.set_rxtrig = mxpcie8250_set_rxtrig;
 	up.port.get_rxtrig = mxpcie8250_get_rxtrig;
+	up.port.attr_group = &mxpcie8250_dev_attr_group;
 
 	for (i = 0; i < num_ports; i++) {
 		if (mxpcie8250_setup(pdev, priv, &up, i))
@@ -943,6 +1147,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		}
 		new_port = serial8250_get_port(priv->port[i].line);
 
+		priv->port[i].terminator = MOXA_TERMINATOR_DISABLE;
 		priv->port[i].rx_trig_level = 96;
 		priv->port[i].uport = &new_port->port;
 
-- 
2.45.2

