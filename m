Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E6D33D511;
	Mon, 12 Jan 2026 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205931; cv=fail; b=R6jCYIMuEuYA2YQusmAfpEHThdh3tsesrq4nY08zjSua68D/wxcdLtwsqCPbfvQ6Ar5r/ycBJ9D7hC2zbTFMJDOLw/jIRCMLv9E2o/PyGMpXKAFyDrrxzJjgY64V1lZQC12lcUotGQ8vCCkDTcfec1kjWn7UkIMObdFrsFhaDkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205931; c=relaxed/simple;
	bh=i5cnwP3gGKS7kMwmDm0HsIPt0VcrQB4/rbJnPgS/E44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I3Y9cwKbC2Z6GqbJTdIBDydpTZAJpQQrqPDX1jcd8exCwP6DbC+5M+3uGQfznv6A+y82gffDRC6jUTMfOk0t1bAevXjXkDl8D7X5t25rbFiNhxZFtGuB30GVcPE4FIn34pVMNt/ay6vur3DU8Hdh6pzqotu/iY/ktUAmb9bsaQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MzKH2uEN; arc=fail smtp.client-ip=52.101.52.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MzKH2uEN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Es5tJgkiPxdsLuZ4N0OX+jjwPiXCxCnDN9SfKeYHXOGCBe0md3fGlsslYLsYvUlblXILRramJ0WbOM3ImTztaWioOf3vGM4jj3Kb0Ni2jB6mI7aMVsVnCLy/w1r74WffLPLPuBwO+lZyrtrzBm0hHyuFejDA+ZvoM0eFrxwNd8NTBctn66Rx4mz3AM5+wqJkZANeVMCVAqXv0oPaoBgWiffSUbEPYfIr3dp9vejHzjI0XhAZcCowrVPf1LF86KcbHKSoTHzYd35CUuhzDm+se+JI8hXxAWHFZp7YDb4pY8qqVRx5hOrWknM/6L4l0WJ5gEbYd+nZPdLreHvkFPkGTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73m0fEJHHo65p4+iHMbLWY87N9DdfJjbTSfeVyg8ELE=;
 b=KbvGhX8HWkdb3vMmE9hEMGj8YmAQCfZl67dnMqHw1pLlm8nXTrCCI5gLNYm8+lVD0/7Ywo5T52eb0d1D22MJw+v6tHIbviX26aVeptwGqJ8qERCF2rQ+LsThasDgvZQsJWdkXU+9kMWx6HAf9XRd3vNKoNa0OxxFtYGwVoXcVvSbLikLY1fbZzICQJhkij1hnv5NnQlO9XvbrPhsKOwH8tKTqMpr8Faq0ufZYGjYWyI/jumFmVkcXLy1LYBC4vxJXl865ZtFBePK4v/tPO9M3nKalMVx1REH7tJyOAbHU/7Kwd1bIh38ngh+KTxfQ6rTrntrpSkLRTrqe29lCyFchg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73m0fEJHHo65p4+iHMbLWY87N9DdfJjbTSfeVyg8ELE=;
 b=MzKH2uENVvYwXDGzmE7hCoHQi+GjNICpxITJPegHZo5OUjS5TVSJVQob0MKEnR+jaZMUPfgd1teJNSrHSw782cR02TXP25bLfiIPOVVuxVE/R7WPAM1hbJKZ0FpIwiIcGMHwCHfKDA5pUbghlL+VgQzKUZk7rugj+34+E1gwNTY=
Received: from MN2PR07CA0029.namprd07.prod.outlook.com (2603:10b6:208:1a0::39)
 by LV3PR10MB7817.namprd10.prod.outlook.com (2603:10b6:408:1b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 08:18:43 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:1a0:cafe::29) by MN2PR07CA0029.outlook.office365.com
 (2603:10b6:208:1a0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 08:18:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 08:18:43 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 02:18:42 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 02:18:42 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 12 Jan 2026 02:18:42 -0600
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com [172.24.235.46])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60C8IUWn171777;
	Mon, 12 Jan 2026 02:18:38 -0600
From: Moteen Shah <m-shah@ti.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<vigneshr@ti.com>, <u-kumar1@ti.com>, <gehariprasath@ti.com>,
	<g-praveen@ti.com>, <j-keerthy@ti.com>, <m-shah@ti.com>
Subject: [PATCH 2/2] serial: 8250: 8250_omap.c: Clear DMA RX running status only after DMA termination is done
Date: Mon, 12 Jan 2026 13:48:29 +0530
Message-ID: <20260112081829.63049-3-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260112081829.63049-1-m-shah@ti.com>
References: <20260112081829.63049-1-m-shah@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|LV3PR10MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 710629d5-a51b-44d6-87bb-08de51b3334d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|34020700016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X5MmQLTSsHBuz1jHZ33c3vWtFMUgYhjzIZPxJmnGcJK71GFm2LmgkmyrtvK1?=
 =?us-ascii?Q?Bk/4AiQOqUCp1LDo4JSnFE3cJH3r4hJw8P/yxa/O0j5Wpuz76ou+2Yf/mbtA?=
 =?us-ascii?Q?i/GTKucByR4lIDNCMTZ81qRuNwXx8x/+wbkw33NJDO2bTWeXyL+/6Y/wW7kb?=
 =?us-ascii?Q?W2agqdBhFzPXv+LT2QcWK+BDbGOquGanFFtqUmK6zRWC8L2DwUmpMVKX0hAA?=
 =?us-ascii?Q?VTGNbc/0Re61tek/lDV7U5V87Xd02yPgcCLXcf6lnTCjBMsdslEfkgFcN3Pq?=
 =?us-ascii?Q?CKt1Zk6cVkpkgMmXVFE2lPwofyFkhGXCdB7vEdQGwiKZfoXwVrfDNmHH2hiL?=
 =?us-ascii?Q?F0uWn9/TX/vXllxrhRq7NsIHVYcjGJiDqtDXhaBRhyYtz/uYWRbDFYLUs+U/?=
 =?us-ascii?Q?SPpLQ2ka3Wlpdsv9hIxfzfNAyqarBsSE38ISyxMGCWeNxkG9tBJCG/W950Bn?=
 =?us-ascii?Q?DUSjIHaqMd5e3Wo7T3VIK0c0dplc00ajcPsYRazmNrVewVEMK+ARdOXc5wTa?=
 =?us-ascii?Q?wTTTMSzzh745iZr/uOyFoWQ4Fc4RhUnehXadFzRLbgwykTLnx2+u7nzJ3wvE?=
 =?us-ascii?Q?5M5dWdwEG0Basl0tG2E3UNZmSKgjKqQfjQ8+pMhWRK/HRQbQkw7bR0A0UBe6?=
 =?us-ascii?Q?aneDw4DbT4KDJupuLKGoyELW+6rv8NhoJJn4ScP0T4Me5Eikjx4zWSFmuxXg?=
 =?us-ascii?Q?fcCkwJgbrc31f/4i9KIJZU53TjYZmu7wr3tTfDEZYL/N7hv7If40w2I7beu6?=
 =?us-ascii?Q?CxmRU2matkhxTSyx4MErpIbDy6XsZmPQ/noXpvjvvrtWUiy3qewoqJSo78Hd?=
 =?us-ascii?Q?dVGt90YJ8khUQYCbKR0kd3Mnr+RZn0zZesbOL3/yZk004tc01yvmBYeJ+nzD?=
 =?us-ascii?Q?m8xJfnUn+Zge69Z/YM+wUyQJU/tgPlKLtNAsCi+vYOv2q1pZ9e0bIEb59cFt?=
 =?us-ascii?Q?uiYcq3rT2IzfovjQiMAYMqJBaRmA7Y2WRRvci2O+eL9QHHTBeX9YIRH5LvMF?=
 =?us-ascii?Q?svqUbYFW9WJMCko4sVbWk/yhF9ArWEGBHkVEtSkx+0xNFzvUUSaZpU8Kpkfq?=
 =?us-ascii?Q?8//D6capaAHaBQ/4n+1gg1Gj90kUUoPX6S9ZQJTVAR1CWHp7UAtsj1oOC2lc?=
 =?us-ascii?Q?FyROJSZ7sz+9ch85JTrqwJgKE2udRciN7V4czBUAKhlo3YInKJQwoy6z9sN8?=
 =?us-ascii?Q?fSTRwS3VpMW+JmsMUXb+kQOh26RI3VbxPt2exPbDlmLbRTpCyNSJdR8Zkby0?=
 =?us-ascii?Q?MIAUURO4r1K2p9/0df+00cJ55skheBKaM88g3j68kQ8UUD2PzgEwBTIXSWJY?=
 =?us-ascii?Q?bPgU3w/6KwtJLVODcg34X3wMbw6lnaTy5Xsd5INxHNO/XsIIRQRMhSN+YrRW?=
 =?us-ascii?Q?vTh1fGrgJpqIWY1yJ0UCn4q4KHD57UiQdnpyS802+2b4IcEGcZD8DXRoRFfI?=
 =?us-ascii?Q?oOUTPh5N3PnavBMoG/wLgqXC+NpKrpsgIL3eqWZ8U1BAsf6zswPG01DYac/a?=
 =?us-ascii?Q?iev+Cm84/P6M76qQ4YdyLf5G8UuSv3/1ZZlJ0ZxYU02e18tMR4FGaKnYQSLb?=
 =?us-ascii?Q?3iRyXb9/I184yB4ykfs=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(34020700016);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 08:18:43.3677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 710629d5-a51b-44d6-87bb-08de51b3334d
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7817

Clear rx_running flag only after DMA teardown polling completes. In the
previous implementation the flag was being cleared while hardware teardown
was still in progress, creating a mismatch between software state
(flag = 0, "ready") and hardware state (still terminating).

Signed-off-by: Moteen Shah <m-shah@ti.com>
---
 drivers/tty/serial/8250/8250_omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index e26bae0a6488..272bc07c9a6b 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -931,7 +931,6 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
 		goto out;
 
 	cookie = dma->rx_cookie;
-	dma->rx_running = 0;
 
 	/* Re-enable RX FIFO interrupt now that transfer is complete */
 	if (priv->habit & UART_HAS_RHR_IT_DIS) {
@@ -965,6 +964,7 @@ static void __dma_rx_do_complete(struct uart_8250_port *p)
 		goto out;
 	ret = tty_insert_flip_string(tty_port, dma->rx_buf, count);
 
+	dma->rx_running = 0;
 	p->port.icount.rx += ret;
 	p->port.icount.buf_overrun += count - ret;
 out:
-- 
2.34.1

