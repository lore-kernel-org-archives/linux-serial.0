Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFAB477E31;
	Wed, 16 Sep 2026 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789548985; cv=fail; b=eUObczNZ1bRwCtMt2V17jLtcAvDIbFbC7OimJEgavQwBCYL06nw1w/fgxWg9V93Joc5Lfn7+HWdYO27pfCtpxKxkZZ3tfAo0ot9f9/D7xpV6oov9g3WvvY32a6mxkkIHadjahPSphofRm+Nu559eOYCfHDl2FWmoKxzkBxOWgyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789548985; c=relaxed/simple;
	bh=vxep0id4/oph6rSG6ex3Knyl1xIzlJtVvUUt+37RBXg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l0Yz0RtvLZwth8Vv/gEhe2zwYz0DFd7IQUK4qkai60DzpWqom3sNCM12ILmBfY723BFZj0u3oy0zMtNT169lREj1/PApLSHsy94sdnsYtnjRkFEXLwlTDJSEH0adYxKXlfg8DSm71VUcssHl4Xt3rfxY4X3aguN+lYbcoO+lRDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Dqck/cv+; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t5KrGOMf; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Dqck/cv+";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t5KrGOMf"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G8Rpb92707749;
	Wed, 16 Sep 2026 03:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=O/RQ36K+CFeEfBCXmB2j74oA9bC7msBp39AxfQF3W
	1Y=; b=Dqck/cv+dthKr7fC8+Hler6QZRDFaxZtKpaf5m/hdmktlvrzxH9tIULWU
	wPz08fOj9GxOoGAf19OQDCT71jkX+cL+UdujYIStlnlHFilD2ShgVw1bOcxvV++3
	oeDKhEsdoBACTPE/z0O3WAq0KMbHF/uhmi1Di+Vi+adTbjJKTfElb2vVMUZJXrMe
	Vl73HPMoUp73qH1SSMgDriNhqB8h/CyeioD37KLxPlz1Ws03cF4qZwvWtquggxv8
	UK8bb3SmeIsuOc5MVYD0tn8D52A2Mnh38GFVAic1NfR+XuEThaqxVonoDESbTv6X
	SgZapIhriJLgIWW9rA2/vWqY7iBNw==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010034.outbound.protection.outlook.com [52.101.201.34])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gqqmd84sq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 03:56:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0B7s022s1QgjgFJGjiBfgsX3PwDfr2NHvikpR2YfsfwyRxDXStGnR992QGt1N+VNwTmcPsEpZY/UakADcZ0vbd+7YVISnm1a8oms9ZmRBAUSWIu/hArWPEOdrcRiQsiUyCbCf6FcERfHZtt/ONta2kd+Mmw4wJena4HHBvLYr1HVdKQfLrvxOgT9c+Tyd7zuSnqYUjTdV9ZOoiamqu/qiR+CZ3Kx5oApN8AewkcxRkPDtBpj8kFC5UuHlmbxyD1B7tNXRfsZOS7EvVl4n+4O7PIAPviygWaXzOKgTCNq1QoO5LYXg57qoGktdgc2YyERRDZNREMYUHSDRX/VuCfCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/RQ36K+CFeEfBCXmB2j74oA9bC7msBp39AxfQF3W1Y=;
 b=ThaQ2omGWHKxHM5ZLQ7bbnepef6djE07iRie/7FU+GOTVonohZIdjMGqt2T2AnodTa8Hvb5NK83cHp39qDOeYuHVNRnNovNFqkn7hSgS43ZinXbB1ctqySlLVhFhEQbToHIJeGsFX65yFv9wqkxJOKEBxCa0jvO+ubPIYYZ6/chQqbc97hCWFLtLKZuWrhWsUrXEkb2ITtCGEo4OAKVr+4lOPZ2OFY99eBWj6cV0n7wJEYiQm240m6zp5E57NOwqQV5T8La+T0GCcHg3r5O2fFvZ5JO4GqRkMpYqZLNJakIvekiOThHqXnMzREq/nEsre8H+15evh0sDAly4u8Bbjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/RQ36K+CFeEfBCXmB2j74oA9bC7msBp39AxfQF3W1Y=;
 b=t5KrGOMfUbMy/Ck1Be9YUky7gQV7dEqMfk2Aze4d8pCQ3H+a7x2svT2poXbBj/DXtM8T2BxyXzsQCZL8JCmJ6+gJuYQwcB9F05JkZornhnHc2I42NdaZsmf1bhnwPrNcpzIMvV86/2zLtTe9xI5Qd+yOsC+AKTCereDZdDpV9mU=
Received: from BN9PR03CA0554.namprd03.prod.outlook.com (2603:10b6:408:138::19)
 by IA3PR10MB8089.namprd10.prod.outlook.com (2603:10b6:208:504::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Wed, 16 Sep
 2026 08:56:05 +0000
Received: from LV8PEPF00000069.namprd03.prod.outlook.com
 (2603:10b6:408:138:cafe::87) by BN9PR03CA0554.outlook.office365.com
 (2603:10b6:408:138::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 08:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 LV8PEPF00000069.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 08:56:05 +0000
Received: from DLEE205.ent.ti.com (157.170.170.85) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 16 Sep
 2026 03:55:33 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 16 Sep
 2026 03:55:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 16 Sep 2026 03:55:33 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68G8tKwG716870;
	Wed, 16 Sep 2026 03:55:29 -0500
From: Moteen Shah <m-shah@ti.com>
To: <ilpo.jarvinen@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <krzk+dt@kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jirislaby@kernel.org>,
        <devicetree@vger.kernel.org>
CC: <u-kumar1@ti.com>, <gehariprasath@ti.com>, <m-shah@ti.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <a-limaye@ti.com>,
        <y-abhilashchandra@ti.com>
Subject: [PATCH v2 2/2] serial: 8250_dw: Add capability to skip empty FIFO read
Date: Wed, 16 Sep 2026 14:25:20 +0530
Message-ID: <20260916085520.2259420-3-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260916085520.2259420-1-m-shah@ti.com>
References: <20260916085520.2259420-1-m-shah@ti.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF00000069:EE_|IA3PR10MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: eb865d8d-ff5d-427f-f083-08df13d05790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|6133799003|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	kkU61lCAka0NcXv7Aj6lJhFRB0w+BdO/VlaQlgoV+bk11HuRlojUQ6DFK5hb8WyJyY+IULzKwH52pUEm9PLzTl0cEGBEykCfEcAwebAikDxI7IJOgqOTYPSYQg1ha5E/in2WHIsgTqhhG90pQIWb8D3vJmt/ZRoEIF565qlRaO/C4c6z03v9lF9eO9ODhaHaYD0pCnrUBUe4nTI2Mr18fJHS3MQkP8h9q31hwfz+POxeTbbAX6z1Aq066i8jqBaXKhReCQA6vDByPOQAeEZkzpQ/MPqCjb2hNog2e4UpuhRaJlt/bWywzOg2pht56m/KcAAo8mUv0W1Pgoo/jaAXTE/1F4C1jaKAjUSq6wf+cY7bvbp1+r6fiN1e3OgstESiiSUcYpnH1Fx2y/ekF0/psEQqTiWdQ8eBZJvvRUMHZ5qma2BFJ5SPMN1RYmSSsHBQ5dC4wnt4JVRI803sshwyzneeKR1pExYoePJwxwVZDyjH63+U+kjoWAjIUR69wAGUD/NhFrpKfL4SVG+1/GyMZRVkokfunuU80Clw6kKX80XxlvmV/aVZx0M9rBkTd56ys1PGtAylq7J9LhhG6lJ5Vz8Bkc674RII9WEpYhVj3zyqPP7ceSfhOQEi5HIxq3mqq53qd40NGmBRulSziMYzIlTPnuh7Bl5sW9af9sey/f+QECeKq/g4cj5V7WQmkkK4fn080TBYZ6PJ9zHqTOlhyQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(6133799003)(22082099003)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zqIsPcoZbw3RBZR/qFGyYtSZLMdhdwyy0GfTpsU2x2NW8hvkJHs2H9VON59ZGzyR7RMRc32hwuluqoYfyPmudv619GxeIs3fqm0B+Vq1J9UrXYfNZjzL7/JREI+1JLH4efET7RPOJxPEz3Q4U9QOvtpRCArstqt781CfRBiQiXeYRT5tn1sPt+rw+uNDT3noRRRYGZtHwYpe/f5bUpwT3cZfRy+/uhfa60E1AmPtrCyesq/EzxljJvGRnoBBGTZddTWRkmY5sbUFbHeEesNyaYaSGIirqat8NZxaJnfS1WKAIPJZOjTCte9zixT29VyRKI74mf63JA5Skne28udM6GpvfuGzPe6wm8z2Y6PqO8lDI26Wg6b39nFKO811I//x1g7gv6ap7LvU/A1rmQKKNBKurnv+lm1sT+vBDwcYyocrUMgQwSTRLUJ55P3ho5RC
X-Exchange-RoutingPolicyChecked:
	plb7KLhf2rh0ag5bm7vd9Q86COffEJk7JmSCbcFfexzA1ekY9ZHV+ReaaHgtR3j1dEQm9pC0dc32hysyExRbtzK7J6L6KE5TZMs4OZWkFWANh+i2DgZAaXLNkiMhzGq63vg0yL/IdiaOHHZzNiPu0UnBuakZ2OmhhLggDN+MNCZ4FyCCr0OObrufjJ2yeMpKM8pnSpZUy1wwPQKvpCrKljZrFlsMUSK9TZbkPHd8VoCZBZ6uebKPgHmoSNsSJ/pWbkNGyZcG1e2hKuk61iguh44/iKjSQenRlHVvONg52AHZy2VUvueyfR+WOO4WynZEvQ3iWYXIuvTgY1hskcwGqg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 08:56:05.1994
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb865d8d-ff5d-427f-f083-08df13d05790
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000069.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8089
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDExNSBTYWx0ZWRfXxzmgB2ZgNuLZ
 LUls67vJlXBEDezGBQUW2L/eoAIrQ5XrRAkDvNnC18CD8IQ97n0LuljaACjxACLqRPLwoKyEdYK
 HphItbAmpydyxoxhrqctzfbKOna7xuxdttdZlzYTXg03SahTk7LXID/nYC8JSfrU5jhe0BEfiUB
 A1Qz9qnGnnk03u1CjZ6x9N0e5zJFxLbyR8bP+y2PB6TmMhqQsUSptkUaMG/0FNYF2gzqG2M8XJf
 r1mzyYZF7R/CS9yr/TuWHls8FrUEIItYHsunrOGBPKVmofOyQDKsEOp+sT6LcMRUT7XlRSwNYrI
 E3Mu3EZAgI0Y18lZ+eR4n3tFxDe71pABoBo875tn742CT062HkrskKbDWI3MjGvsUt+uxB/kFC8
 cr5QntoIW/BV97oUQ8aqvgDw+W197XlS6QnzBemHaVVzfopAPfnsE1UtNy3uiYadnMvmulX+DF6
 +hBoNuIA/wolUBRy6gA==
X-Authority-Analysis: v=2.4 cv=S6JMU4sP c=1 sm=1 tr=0 ts=6aaa59a8 cx=c_pps
 a=p9IRwfs10qZ2nHdxx/cwJw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=x-C6ANIshD0BN1wYHMIA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDExNSBTYWx0ZWRfX9WWmLCwE/T/t
 dxjwUssd5sA3/+wBXrW3qYo7rrsCPvAPKA5P/BaDaBCbke2OzEmDU3kzKl5RQCxqKYc0OD9VkKC
 91TqZWidMiQLpKoiU8CWEa0i1F+rab4=
X-Proofpoint-GUID: y6hwjQRh837d4-J8Y2iK6XYze7CmZose
X-Proofpoint-ORIG-GUID: y6hwjQRh837d4-J8Y2iK6XYze7CmZose
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160115

dw8250_handle_irq() does a bogus RX read on RX_TIMEOUT with no data
present, to avoid an interrupt storm. The UART core also performs
unconditional reads on the empty FIFO during startup and shutdown
of the port. On the IP version used in TDA54, that interrupt storm
no longer occurs, but reading an empty FIFO instead triggers a data
abort.

Add a new capability to guard against the empty FIFO reads, avoiding
the data aborts.

Signed-off-by: Moteen Shah <m-shah@ti.com>
---
 drivers/tty/serial/8250/8250.h      |  1 +
 drivers/tty/serial/8250/8250_dw.c   | 16 +++++++++++++++-
 drivers/tty/serial/8250/8250_port.c | 12 +++++++++---
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 77fe0588fd6b..45e13c3a8c14 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -86,6 +86,7 @@ struct serial8250_config {
 					 * STOP PARITY EPAR SPAR WLEN5 WLEN6
 					 */
 #define UART_CAP_NOTEMT	BIT(18)	/* UART without interrupt on TEMT available */
+#define UART_CAP_RXFIFO_EMPTY_READ	BIT(19) /* UART needs LSR_DR check before RX read (TDA54) */
 
 #define UART_BUG_QUOT	BIT(0)	/* UART has buggy quot LSB */
 #define UART_BUG_TXEN	BIT(1)	/* UART has buggy TX IIR status */
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 5fba913f3301..325b620172a7 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -28,6 +28,7 @@
 
 #include <linux/serial_8250.h>
 #include <linux/serial_reg.h>
+#include <linux/of.h>
 
 #include "8250_dwlib.h"
 
@@ -436,7 +437,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 	 * This problem has only been observed so far when not in DMA mode
 	 * so we limit the workaround only to non-DMA mode.
 	 */
-	if (!up->dma && rx_timeout) {
+	if (!(up->capabilities & UART_CAP_RXFIFO_EMPTY_READ) && !up->dma && rx_timeout) {
 		status = serial_lsr_in(up);
 
 		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
@@ -758,6 +759,14 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	if (!data->skip_autocfg)
 		dw8250_setup_port(p);
+	/*
+	 * On this IP, reading UART_RX while the FIFO is empty raises a data
+	 * abort. serial8250_clear_interrupts() and serial8250_do_shutdown()
+	 * in the 8250 core unconditionally read UART_RX, so guard those
+	 * reads with an LSR_DR check.
+	 */
+	if (of_device_is_compatible(pdev->dev.of_node, "ti,tda54-uart"))
+		up->capabilities |= UART_CAP_RXFIFO_EMPTY_READ;
 
 	/* If we have a valid fifosize, try hooking up DMA */
 	if (p->fifosize) {
@@ -888,6 +897,10 @@ static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data = {
 	.quirks = DW_UART_QUIRK_CPR_VALUE,
 };
 
+static const struct dw8250_platform_data dw8250_tda54_data = {
+	.usr_reg = DW_UART_USR,
+};
+
 static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
@@ -895,6 +908,7 @@ static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
 	{ .compatible = "sophgo,sg2044-uart", .data = &dw8250_skip_set_rate_data },
 	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_skip_set_rate_data },
+	{ .compatible = "ti,tda54-uart", .data = &dw8250_tda54_data },
 	{ .compatible = "ultrarisc,dp1000-uart", .data = &dw8250_ultrarisc_dp1000_data },
 	{ /* Sentinel */ }
 };
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index e94a0802cbdd..4435df88a1b1 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -704,8 +704,13 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 /* Clear the interrupt registers. */
 static void serial8250_clear_interrupts(struct uart_port *port)
 {
-	serial_port_in(port, UART_LSR);
-	serial_port_in(port, UART_RX);
+	struct uart_8250_port *up = up_to_u8250p(port);
+	unsigned int lsr;
+
+	lsr = serial_port_in(port, UART_LSR);
+	if (!(up->capabilities & UART_CAP_RXFIFO_EMPTY_READ) || (lsr & UART_LSR_DR))
+		serial_port_in(port, UART_RX);
+
 	serial_port_in(port, UART_IIR);
 	serial_port_in(port, UART_MSR);
 }
@@ -2421,7 +2426,8 @@ void serial8250_do_shutdown(struct uart_port *port)
 	 * Read data port to reset things, and then unlink from
 	 * the IRQ chain.
 	 */
-	serial_port_in(port, UART_RX);
+	if (!(up->capabilities & UART_CAP_RXFIFO_EMPTY_READ) || (serial_lsr_in(up) & UART_LSR_DR))
+		serial_port_in(port, UART_RX);
 	/*
 	 * LCR writes on DW UART can trigger late (unmaskable) IRQs.
 	 * Handle them before releasing the handler.
-- 
2.34.1

