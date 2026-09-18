Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284B5418A29;
	Fri, 18 Sep 2026 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725899; cv=fail; b=qWNBm6u0meGToRNg/iuViqM0v60ZuGkUkL5S5uyS/O58dAvROID9GePaixTrKab23D4xiHhyJ428L0Q3Zei2JIgtXSyIDuBaF0Zj38ENJgDxoKmHx7IvzKnUFPP7e5IbZFfAmlAPfWs77n+wylPjUnq2fzGUy7KSqknbcCULzLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725899; c=relaxed/simple;
	bh=7pCo0/FhqlFNnl19hmxoVS+XRtNPvyhV8smyrqip7BY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f+2pgvpiOqkF9tSN21IPacMTDbEWlRd1ceL75RpyicWvYdC8wPTiPKrxT0WqOQjLPe1XLOAIJ2NO+Vy4kRyO7uONIOdgwcBZ+aKJj252E+9jXwbUeLsLNxNpelYWhfSXeosLdlGRWjtk+o8uFJj+T+NER9o9K317yFcQe3use/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=RXFzxo5G; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jivlUtHR; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="RXFzxo5G";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jivlUtHR"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68I9d86e1233713;
	Fri, 18 Sep 2026 05:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=8QmIegsLTravmNA0aJvuypDbGvEYpSx14wmYHv22K
	lU=; b=RXFzxo5GpQ2vZwashjEQpUI5j0vMV4Mzz7Ymv5DtEgRTpsmvmrgsT7P5H
	U4gEeaGfDEdzki+bDLy7wmkeIkoHSCf2pu9FktSMGPDbK/hp9TjC6Ij7/Q6JvFZs
	s/UGG8BMRhNexZBRVug1N01jQgMkgCZDgBo0tesE5mOCjWQDpwEv78s7LBTkBPGW
	Lve1pfiOkeRUCIFRIrtxGX5DkoLNzck8WgAoIjOwF+q7WNlVknqL+tpVWZ9rTE3s
	Pbv/eo6rSjEuioCDx0ESrmyjKhWnD7ci5r9CLyB8cmhXsnWaYIaTFGH38Tls40fS
	67Arsd8vCdNe/Ixenlv+NeMlRRrEw==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013003.outbound.protection.outlook.com [40.93.201.3])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gs2ux040n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 05:04:54 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7uei+qsBfx1UpHOMbSKi/Rb1bcMeBa8ON7BU26wC+Tq8fMOuSVN0pnzw9vZF/im6w/DIhRhtqHXSaG7hB4uzhD5xgh1ozkGi5J3CC/eO+x+r39LPCtkK+rrDhn8kE/71tPciU31AkrM21n/7Y4ujG1kZtFpxDGDgxb5VpudXQeSwv68UPq0qI16BpI+ogpFB+P4qEIZ2KkCwHfNObRPt7cjx9v5AdHDDWLxXUMFwM7RBUN3whe+dYn2l4XozAZgi4LcVf14iJy41ARfwpZzt3jdulCGaITJyct93ut5qKUfzketRsp4HI9YDQDWuRah8jfzhldPnlh4CZZYmcXQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QmIegsLTravmNA0aJvuypDbGvEYpSx14wmYHv22KlU=;
 b=BkIt/dlfxRZgd0JtqhXFLRzzvjDVRBb9WcY/I2nZswBRgIquHrgEyaKOvFaI/O3Byju/QKxAnqbyZ3dslf244bJSIiDuNJr9PCzrJkor7EOD+JfnjgHsDmTBOpcfF5bBJh+3OkGlVeFDSNx+CRve5Al/2Ys9cbXLyejLt6BQK4ExwvHbXOQ49sjM9yTHnBZWzL/8zBObhlVelhuawc9W5oioCC7ajIQoyLqKJAurpXFPjuKhITXbn0h7CI/oiclxii4nes2Fp7T/9j+JhSdz9tLJZP/cue7zwM7i45EG6k44Xk7fwEzzrS5VWUT8j9rlE9J4MqoSyKPX3W2eqQCUXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QmIegsLTravmNA0aJvuypDbGvEYpSx14wmYHv22KlU=;
 b=jivlUtHRY/9VYFa7Ivb99dTxGrA64yMCSjJEhBI2JVNJgHkkpli5XUBk7548wP/jS9TrmyBY2gk5cZnb9jvyZ0JG0fYyay07sa0Dq46n/4N1tm94BvA7fRmIH3rXF2J2oGJzjC7YHDDDbENkbvRNif/oL4ZJXu2fNNwOiUBnPxs=
Received: from CH2PR03CA0017.namprd03.prod.outlook.com (2603:10b6:610:59::27)
 by IA1PR10MB6145.namprd10.prod.outlook.com (2603:10b6:208:3ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Fri, 18 Sep
 2026 10:04:47 +0000
Received: from BL02EPF0002992A.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::5d) by CH2PR03CA0017.outlook.office365.com
 (2603:10b6:610:59::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 10:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0002992A.mail.protection.outlook.com (10.167.249.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 10:04:45 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 05:04:00 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 05:03:59 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 18 Sep 2026 05:03:59 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68IA3k3L1507569;
	Fri, 18 Sep 2026 05:03:56 -0500
From: Moteen Shah <m-shah@ti.com>
To: <ilpo.jarvinen@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <krzk+dt@kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jirislaby@kernel.org>,
        <devicetree@vger.kernel.org>
CC: <u-kumar1@ti.com>, <gehariprasath@ti.com>, <m-shah@ti.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <a-limaye@ti.com>,
        <y-abhilashchandra@ti.com>
Subject: [PATCH v3 2/2] serial: 8250_dw: Add ti,tda54-uart quirk to skip empty FIFO read
Date: Fri, 18 Sep 2026 15:33:46 +0530
Message-ID: <20260918100346.4044899-3-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260918100346.4044899-1-m-shah@ti.com>
References: <20260918100346.4044899-1-m-shah@ti.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992A:EE_|IA1PR10MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b73f2fb-90ad-470a-72e1-08df156c443a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|22082099003|10067099003|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	XLvkXvJYsUMtxTf/oRK6Ebj/ZJwbbFFUCoBRwrW6pzB3Q43YSq5eMmVdbwOHclaEUP62dXwtFxQvzyZlLnkkF9mSUGL2qqqTcvXAWFFL3SodQVrovVzO3d5riYz8pT/OVzNgbbWttbKq7e+FVWpnH1w2NeYz7DWhupsF6DzMXadrnUyD4mjOG6nwI8K9sfsYE9Gu8aHugmtGv2Yd5ZzaxyJ/+GhrF1uqcG2ktUBKLUz1sPQZke16r1LpHhKOOwM+BUP76/tZ8P8n08EvAGVOd7pUoJZUzjrHmZyJMvE70SExTceoRyBUe1TQ+VPXhHahomk5e0p7als/c07LVwWLtniOXeIx86xSQ0ZMCX8YC4HXsfIh0BMwev5LOeX/4L9/J75TkuJqEZMVkYCFSLefbHymoRq1WDyP6rxe7r1oJlCJfBs3PzqEt0D5tB74NACBkRaC40LAJ+fAHqWYV1F9VESFNPA2ccxQRho15wlQb4FvMN2jsbC1OWQiAkttsYYjxC0jMdrrZBZwRukKF5YTpCr9Sbj18FQW2kB3Z/dwVUM/AP5pQloAFRy+sL2Grj1efolz6mD4CeB0wCqcstyOEP3Fe1JQ82SiSYENncidiQfruZTu4+6lfNb/WPokQ3S849PSitWDJn0wBuN4EA3gIm3Ikt5A8EAZHn6Np5wLn0SQXmJpI7biI8HtIDtqUWD3
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(22082099003)(10067099003)(6133799003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3Z3LS9xbVkis9v8GbDBD8/HmMhauS08X+xmruJkoR5OiCvAY/KItqdL5lpn+fCnTPjr9EXBoYlLYxPF9VuBS8uzItMFHH2nIgEnV163rYiuzKE/oeVNkCY6omo06URAq2mHMwk8Rm1a/OCMaFdyAHTlpIW5a+b/ji9KG+Awo49e8nQaoEnEJF27HFwuJzlg+/DWVdIBzxtx8Bhi0A79u6WCJ3Z9PKbrUvWzYEfhcFsEZ689dKgoOQ6JadtLfiLnGf1p2v+BUXGZVICwJwuf/eNypRMnot1zLLHDGt+w8dIJp0qhqSKhs+jN4FBmdByYrXFkC8q4O8DhyjvVeamlV1S5KiD6HtKukKpo91lTNRU+/BAcC/wW/ArXIi20SWr+orzfCxhUsojxka94KDvyXklGWg141h2p6UqNqXDJ6ly/lA7ITUmha+rBgXfriFpjA
X-Exchange-RoutingPolicyChecked:
	gAA/cqkhuKypkSglZwbkIP5VMeZbaJlVuNfngozNtbb0vYjPzteFGILz5nZEMEyjAi0i0/V7aToPuRwfjEdxJzlflh81q3q/Vzv9ZueHRhzM8OU/dI45kYMLrVM52KvaSJt7q9svhmCLvfxGCa6MPhAxf5x9ZEvA93QRn120An9WuFtwQgSJDTH8D+nx+E1MAOmVs6eKAw3VSSqdYsmsfxG8fzb84fY1k5YpIwH6RMN8iZ8qIwMB7Z4yfv3oC25C4jI3Dgb4a7IoVI9uMXv02Ua77xrSNkhXqxukeoZ4Uwo3fDRBrf0zl4gOwhyVPrtVF2x39OBDf49uoe9KuWA78w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 10:04:45.4075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b73f2fb-90ad-470a-72e1-08df156c443a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6145
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEzOSBTYWx0ZWRfX1JohTATl2feC
 wqtmRI7lvJy2JGUsTYzF5ck/VuY0ymzgixLOxy7yilsret+fvj/AwextKaR4BXhesDZfdl5iYk+
 zKxOvz8e2R+txYany7+jRimshMADdAXugGw+U5c7VUkIG04acIQlWXepsoUL4Pb+Nlj2PSV9Ui/
 ZKGraesKVKXtYgIVtRtOUZivfikft7aDPLe+sbZ2XOtsd2ipPIwX2sy035KnT+/mAlBjpoBE+bt
 hS7Otz0+YDcPBj4UERCqHsWyFl6OZ2F+dfaoAb+IWsiLtvrsJFmZ/zNUYjpI4ZEID21m6pGZe4M
 iPMcnWjf7FczZZeIE2Sg3CzcuZt3k+O6y7ZKUVjnm6SXdRY18ZQUraAqpwQuP/EfZkIAcMm4+MT
 11HCFVF100zsUQUGgHnG4lECOZ0HYNv+vwgfTr/Ncvb5iYBmAuB1qh7ZKX6GPzcgFjpwCwkNt3t
 lOyBiU/srZLDz2FbIhg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEzOSBTYWx0ZWRfX6cDolCGREKAd
 YWHoXgmJ37Vc6etMI7K9d06dW/Ge4pQKtVm5VDl81sU5RWTLgXXolzRLbomI3PStHEKN9EkyiCp
 7fhmS0jZeaa4Ep0RNhmbgQ8BmaiqL4c=
X-Proofpoint-ORIG-GUID: aIi1s2UEjDCscpCXQb0v9apyZydO6TuR
X-Proofpoint-GUID: aIi1s2UEjDCscpCXQb0v9apyZydO6TuR
X-Authority-Analysis: v=2.4 cv=adH0Dhot c=1 sm=1 tr=0 ts=6aad0cc6 cx=c_pps
 a=9JMNuyHA4Bc1wrbCcMLwMw==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=5UjrIH7JrNX5thzwMLcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180139

dw8250_handle_irq() does a bogus RX read on RX_TIMEOUT with no data
present, to avoid an interrupt storm. On the IP version used in
TDA54, that interrupt storm no longer occurs, but reading an empty
RX FIFO instead triggers a data abort.

Add a DW_UART_QUIRK_SKIP_EMPTY_FIFO_READ quirk for ti,tda54-uart to
skip that read and avoid the data abort.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Moteen Shah <m-shah@ti.com>
---
 drivers/tty/serial/8250/8250_dw.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index b8a0bca8b536..e7e219611e0b 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -51,6 +51,7 @@
 #define DW_UART_QUIRK_APMC0D08		BIT(4)
 #define DW_UART_QUIRK_CPR_VALUE		BIT(5)
 #define DW_UART_QUIRK_IER_KICK		BIT(6)
+#define DW_UART_QUIRK_SKIP_EMPTY_FIFO_READ	BIT(7)
 
 /*
  * Number of consecutive IIR_NO_INT interrupts required to trigger interrupt
@@ -436,7 +437,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 	 * This problem has only been observed so far when not in DMA mode
 	 * so we limit the workaround only to non-DMA mode.
 	 */
-	if (!up->dma && rx_timeout) {
+	if (!(quirks & DW_UART_QUIRK_SKIP_EMPTY_FIFO_READ) && !up->dma && rx_timeout) {
 		status = serial_lsr_in(up);
 
 		/*
@@ -895,6 +896,11 @@ static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data = {
 	.quirks = DW_UART_QUIRK_CPR_VALUE,
 };
 
+static const struct dw8250_platform_data dw8250_tda54 = {
+	.usr_reg = DW_UART_USR,
+	.quirks = DW_UART_QUIRK_SKIP_EMPTY_FIFO_READ,
+};
+
 static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
@@ -902,6 +908,7 @@ static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
 	{ .compatible = "sophgo,sg2044-uart", .data = &dw8250_skip_set_rate_data },
 	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_skip_set_rate_data },
+	{ .compatible = "ti,tda54-uart", .data = &dw8250_tda54 },
 	{ .compatible = "ultrarisc,dp1000-uart", .data = &dw8250_ultrarisc_dp1000_data },
 	{ /* Sentinel */ }
 };
-- 
2.34.1

