Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023126.outbound.protection.outlook.com [40.107.44.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB1C28727C;
	Sun, 30 Nov 2025 10:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499503; cv=fail; b=VU5v87ivwRSUJW4TC/pjITgc22GBoxKW0DXh/RiyK8XZ9UgNc+Hd2X4iT/QYcqfAJX4GLNl3/Kj+4UOvvN2Pe0B6rfHDC2lXxiNx0CpOm7MyPBnXXHgDNDtWGaJETdhK0b2GVROWDeAGDYQNRrEap7GuZtU338kR4kpSWfsc8cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499503; c=relaxed/simple;
	bh=eE7zeiz3MFvb0MaO1X1k6LdFLVZl63Pdm7f4oOKF9nM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DCnw3Dtp3je9H9qqyf/QtvW5hxq4RI9IdruHHF5pv+114W9rE6odTpewe9Zk8K8Y/s+SuU4wy0MWnU5QtsCVWsjdNcCm7Jyzon8A7pUoKAJEfKITpcwRB5JBjX5TbVCriQBViEn0PTC9F4TMZ9nduAYg1qpUuvA+wMDpJXLDyoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=fumJpCur; arc=fail smtp.client-ip=40.107.44.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="fumJpCur"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8Ob4XYVQI9pUNml5Su0bmTkaVssw3CVEECVehTrIiu3rHgUu04T0Bj2KGXPgfKqHm4MLHhzEQmYgi45XKhoZiJBvSPcqYDZmvJINrBusUisccF6S5YVCZqImv6CYruMISFvAvuXx0Kls4lVTFvwsaRXxBUxEDgULDKJiVuvRaeTqYaHvKPvQBNhT/oC1JYfuA/9ZKjzFv5goA+v9ZrQWwFF++MDnteQGF7SWIO+NzpBGhQ0Lrug1UM0BcIRx6+u5WXNBlPqjvLeaMbMYKrI4F4d1JFdlp0YK1AsfhiquClr9Xue9QnSbdRwWb/uSehCZTb9Yw19d7fT3yqB/kNtQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNnc/X6EZQiZXqPJim3ARNYbmSUKCTcpHNQapEZYOHk=;
 b=FgoeUT210EkECiMFSS7u57vIUesRXGXtyjmdc1RiemMMC7RBl9AgfLNSKb8EzpvoaNOn8z6tJKtmfejvgVTJRs33Z8ev+z3+5AUwyA2nfhoXn2yWXSXZtU5MlfrtG7sNrWtgp6hjfiP1ku4Bi/92q9RAjJE4sDtlEpdgkCE8gsS1hd4zWp1PVLolXzGsV1F0nmMfG0Ux69XYOAlLKlcVUC6JvewytyjPx00IPKmmIJvkS0aTVMn7DBMm5LoknyuT4gtggUyBCuzmk2IM/iZtZRky2zfqd6fSbPejuZegHAa9LX2s6cOXEYv47bx4UptCgDUYWh0Uy36Jy5aD7uEcOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNnc/X6EZQiZXqPJim3ARNYbmSUKCTcpHNQapEZYOHk=;
 b=fumJpCuriafA5dvOhKNEvdPk6qUKHhAvbj3dwrOzR9OreyC4YvlTyOv7XtR+z9vi6NS+dcKu7LQzPZ8v93IhD6ypdCim/9VWuhx9IIhTeBW4lc0TvEQztKBQL8d/r6r0F9VGew2wpQ8NaXE1FMJIdZBAuEweet2bU/m8WSCbjJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB6080.apcprd01.prod.exchangelabs.com
 (2603:1096:101:221::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:44:58 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:44:58 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 18/31] serial: 8250: allow low-level driver to override break_ctl()
Date: Sun, 30 Nov 2025 18:42:09 +0800
Message-ID: <20251130104222.63077-19-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 504c38d3-af71-4afb-0d4c-08de2ffd817b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T45MTXJ993OEWwD3PKnO6RvXU0f5KGfa2oD1wr9HbxoDFJvzwxjTRzNHFSx3?=
 =?us-ascii?Q?sPhDujwU1/KboJDByqNKS9vvyCsgdeJ+vl4rCXrJS3dWD3XBQU77yD22s2VS?=
 =?us-ascii?Q?7YmW0UumazC7+cMkLJLxbAa0m6UuIKGDN6KbLBjugJnXowv7svj3d2HRCvWp?=
 =?us-ascii?Q?fQLu2Rfu6WcR+scNQaXCMBZSRLW1muT3k3En493iZviET2UOAe3xMHopYJ40?=
 =?us-ascii?Q?4tZsk9ny115lf32pjsGTdRkTaV18/XbUbUap/j3wbe5sKPeLHbrnq99tzbGS?=
 =?us-ascii?Q?V6KKXV5S+5SgQ/ZY5xCZ+/bBol21AV3stIO+R+aPtaxjHoo626KRg5DfVkfA?=
 =?us-ascii?Q?aJ81ebCWqAo+fsNevnSHBe15f3rdzxcVHlWlm1jHOjUFoo+HCrMf2Twsy6Nu?=
 =?us-ascii?Q?empWhQLBrUugpfdOu+u3vzGQR5Pa3lAww1BpH71nVH/MiAxKW/SkTP44PdDp?=
 =?us-ascii?Q?Fi70YN2ZpKH9qmbA01kOERuqBODiijl5FjdokcUsi705D+6abRApcc9leaiw?=
 =?us-ascii?Q?UVJjAWsBkf/0T7VqdO/77X0jOq5U1hG88UpUxlSMCxeXOPBZNpWYr599HjmV?=
 =?us-ascii?Q?8ZiqzEy+88B9VlNma5ntcwQpZ/oVzuSH6RvIZJ8VUqUTS7ZaFLypMrLIysDx?=
 =?us-ascii?Q?PTJB5Py6ze17XtPCTpgu2cN5xlTnzefEEWSMJ0G/lCtk7y51tG+rQxneZyxO?=
 =?us-ascii?Q?Ux3envk4VC4kS7Yg69bnFVqO1R8WL50KYoZg20pjYzm7lAxjGL/5pUY/mxwP?=
 =?us-ascii?Q?/Jzu3yNp5GPjvCegJ9gG+xOuw6Z5gHj+OY3UiYrAzaw8n8K3XHHgSyF2jmYS?=
 =?us-ascii?Q?uIu4dVk2aekoE6c8wHRVmwNmPLiwZjgTzODmtZ+qcNNPPNUc5T+Hu+AKcVCs?=
 =?us-ascii?Q?cKu2/yn0C5L8BV+krcB28UX9/6/HKrdPXn+1cBhsVPGElRLUWan6VQT+xaLb?=
 =?us-ascii?Q?qUs4KzJNSQW1Evs2jDfY6TAP+qrJenL/6gZyRZ2LGgRYIZqCpBr/jId8xihz?=
 =?us-ascii?Q?GPF1KIvdJ3EkLvvn61yIL2f0eG/7swuXbDSMZrwfWi2tGB96TtuDGqc0pWh0?=
 =?us-ascii?Q?mAAu5/9TKf0vBVW6UayeasoJNEnm7T+G2F/2VY4xUTua6Pzx7wPzVE6nJRn+?=
 =?us-ascii?Q?ohTaePWRQ62yauqJQF3RtDf8prt1fGqS0YRsd9kH/SKJVyz15/urchdAxTCD?=
 =?us-ascii?Q?1wQ/sCK+DwWRWpQVup8jpp86KPJu+M/2Yuljv6ydJ+vPOfV01VQZB5BBTitZ?=
 =?us-ascii?Q?ba6h9NY75gnyb/2znD2511k6gpp6leW6D4/gr0xx5jtU4jSpqmvSCVMJGFVX?=
 =?us-ascii?Q?3DTeJDYuoTU6w1urNqohx1fN5PMAFKAx4pFjzpXg2zlmvS+oP5RH8sM6vVqU?=
 =?us-ascii?Q?kk/aOUf0jADTtm5bQr7ghhPniIwGOpZMU/tPfNAVX5jAJEpc4AchgMA0OnAU?=
 =?us-ascii?Q?z+2EqkbJQD9z4X1x4GQ7V/DEpPkQLbZk9JobL5yihTPg3Xrovy2DLr4boVz+?=
 =?us-ascii?Q?xdqpBXbjUTeD6agxC1vSnNPRuntzkgzVDhxD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/G3d1ZkX/EZd+lAubh8fHkrZax++iw+fGn+DycFfWJljDyjXtoILQB6HW78Z?=
 =?us-ascii?Q?DkTqN+AkLCSqNOH1BWuNWhbkiL/Xqye4x9MNXgZLVJXZqdQ7ZG3IFSnxgrCa?=
 =?us-ascii?Q?DIL16L1ySfSyNZKJRU6rnHbwmndng/uIDj6pb9WI0tcDNAexUacJv4hkyc1I?=
 =?us-ascii?Q?X/Q7mA/Da6GqxzcMiW+ds5Luj4k8G7USuOdVLFXwat9B3w4R+YH27gXEorLs?=
 =?us-ascii?Q?qX+UqK0nXDSVShhcajuz0437G9SBkvZ9kZKsKw7SjNgFRVuqEbSb8+G4aS2X?=
 =?us-ascii?Q?bGdqC/KZxbHwuy31A663/EvInueswn1idi627jROqN6fzx9qEsQrzsngl6Ue?=
 =?us-ascii?Q?e1UOkkyMH/R1GMSIVSeJTBnE9rj/NFz3Js2kUzoOAgOD30f5fVEUZjSv5rgk?=
 =?us-ascii?Q?ddbTkDR8RX7QLoxosueVi4zKHIF86oIehOhgt3nVou5bj3FckZyxhfDut6Il?=
 =?us-ascii?Q?fWjEm7WXxGPwf2bhTOcbWSHWJIbcVZEbENkLrmPh+QALOeuiR/CPkzoZGK69?=
 =?us-ascii?Q?uZNFpNHnAiAkp6DPpFL+ff7pa44aLB8ksQnWVROZ6vLtpzK861gxDyijLf5p?=
 =?us-ascii?Q?E2Y0XFQSRq1+c7FDkh7hl7QsjOf5cbvyGxtV2jt0OZx8gio5k7uYYP5fz6TS?=
 =?us-ascii?Q?jPAZ6DZNyGWcWmH6m/0vf1OpsGII/d641PqxuUE3NRsNwKFADKp9DLHI2UAJ?=
 =?us-ascii?Q?ZIv2bUE0a/+JCV7rMt88pyppimMcvUxRE43u//ZN4sbezMJkkl6AWq3QvIUG?=
 =?us-ascii?Q?qflDdOc1g3NNRpRwJanNVJ/BJ7Gn61mA5cI+MCGRsizpT3Mh0UnWxEE2GPuL?=
 =?us-ascii?Q?zI+DxcJ99Yaz+LLv+GRAUf5LTbzx9a0/7kV/ExGt9+LSJhsxBG6sb2aIxbKe?=
 =?us-ascii?Q?EMBmAsAi644+bn5Hfvo702vO0UpdG+9kTZKcoe2Xnvx5eC9dmTlbXY+m6Dge?=
 =?us-ascii?Q?Vlyrd833mIyxwaWq7Q7MvDxHj/q1lH0++sydTO4gEg5Z8R8QwMB00UQKMWzm?=
 =?us-ascii?Q?kBwJRl+K8pbwtJEuMOKHC0H7QZIzhstIt9gRrw018CtJPTh42gGkhnNtRN1K?=
 =?us-ascii?Q?XraNyedvm1wScIhdllYYu/+m0fgVij7HSYLby+mydaWsEv7GPjXeQiXynWLO?=
 =?us-ascii?Q?Pf0NT+MvwhkaZyCS5KNIz+M46XlmzHfQ1eID9zX3/fcW7G2f94tyg3TGdAj4?=
 =?us-ascii?Q?BhF5FAHxkvNaazf2Lr17XIZ9TsP+EqKHaOD/l/S8QrANoSbPoSWkJLZaeujZ?=
 =?us-ascii?Q?9q3cz9JBN84P01bHQ68V1xWEnkXMjfWv7OHIqCFTH0GiFlGJa7SxeZjxZXoF?=
 =?us-ascii?Q?EgMWVUliT9ILxXBM8nJ3y8WEXzSOLyjMT/z5pp0x94CLW8OEDJNvP4aT6gcX?=
 =?us-ascii?Q?7eTTJ98H0DtZUZRigsoQrHtuzjlhLLcrFn/j1wUukyjIAY95Nic6/sUyIvY7?=
 =?us-ascii?Q?3guLBkwMbWNeJlQQOzgMwIxcRZg0fVy7Bq99MwvzFciwnnEWPgX3hlU+4Idb?=
 =?us-ascii?Q?7oyZezAWYBE+06qAuwymXD9WUCe+DXzykFJ11F1KS6C0ahqSUGqObQT/1pSp?=
 =?us-ascii?Q?KF+j8hos4Fx4ubPpW+WhwoIGrX/iw0VuroNHTHpavqmouyVO6XtRXu/+caVA?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504c38d3-af71-4afb-0d4c-08de2ffd817b
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:44:57.9966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ps5WeZr7isK6d8ll/nIt6hNiQY/pafkCUx7UIJOvtHVUutgBPFm/k8eQzKoAlat0m3InniqUttTk1TrkpAUuSM1Q2FMJe89tGTJHZXz6eQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6080

Moxa PCIe serial boards requires custom break signal transmission under
RS485 mdoe. However, the current 8250 driver does not provide a way for
low-level driver to override this behavior.

This patch introduces a break_ctl() function pointer in struct
uart_port, allowing low-level drivers to customize the break signal
transmission logic. If no custom implementation is provided, the default
serial8250_do_break_ctl() function is used. This ensures that
hardware-specific break signaling can be implemented without affecting
standard behavior.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_core.c |  2 ++
 drivers/tty/serial/8250/8250_port.c | 11 ++++++++++-
 include/linux/serial_8250.h         |  1 +
 include/linux/serial_core.h         |  1 +
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 68baf75bdadc..f642e8c77911 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -802,6 +802,8 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 			uart->port.startup = up->port.startup;
 		if (up->port.shutdown)
 			uart->port.shutdown = up->port.shutdown;
+		if (up->port.break_ctl)
+			uart->port.break_ctl = up->port.break_ctl;
 		if (up->port.pm)
 			uart->port.pm = up->port.pm;
 		if (up->port.handle_break)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 38825bb80749..64896f37b75d 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2079,7 +2079,7 @@ static void serial8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		serial8250_do_set_mctrl(port, mctrl);
 }
 
-static void serial8250_break_ctl(struct uart_port *port, int break_state)
+void serial8250_do_break_ctl(struct uart_port *port, int break_state)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned long flags;
@@ -2094,6 +2094,15 @@ static void serial8250_break_ctl(struct uart_port *port, int break_state)
 	uart_port_unlock_irqrestore(port, flags);
 	serial8250_rpm_put(up);
 }
+EXPORT_SYMBOL_GPL(serial8250_do_break_ctl);
+
+static void serial8250_break_ctl(struct uart_port *port, int break_state)
+{
+	if (port->break_ctl)
+		port->break_ctl(port, break_state);
+	else
+		serial8250_do_break_ctl(port, break_state);
+}
 
 static void wait_for_lsr(struct uart_8250_port *up, int bits)
 {
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index e0717c8393d7..88996a3194de 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -192,6 +192,7 @@ void serial8250_do_shutdown(struct uart_port *port);
 void serial8250_do_pm(struct uart_port *port, unsigned int state,
 		      unsigned int oldstate);
 void serial8250_do_set_mctrl(struct uart_port *port, unsigned int mctrl);
+void serial8250_do_break_ctl(struct uart_port *port, int break_state);
 void serial8250_do_set_divisor(struct uart_port *port, unsigned int baud,
 			       unsigned int quot);
 int fsl8250_handle_irq(struct uart_port *port);
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 743b4afaad4c..1aa07c5187d8 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -451,6 +451,7 @@ struct uart_port {
 	void			(*shutdown)(struct uart_port *port);
 	void			(*throttle)(struct uart_port *port);
 	void			(*unthrottle)(struct uart_port *port);
+	void			(*break_ctl)(struct uart_port *port, int break_state);
 	int			(*handle_irq)(struct uart_port *);
 	void			(*pm)(struct uart_port *, unsigned int state,
 				      unsigned int old);
-- 
2.45.2

