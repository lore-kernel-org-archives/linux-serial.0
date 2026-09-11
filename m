Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49419468C05;
	Fri, 11 Sep 2026 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118792; cv=fail; b=eNQKjC6jzzc38TgZRoEbfWqcoTi7QReI+wqLdH+UTHtRyptQf/xv8S9EHR9RyzGfR8pZgx9KOV+LEYzIT0zQ9q1BIkglpZ+dW4t4taSIVoZJq24TSZW6ytPjlsg6OI4FXZeo2F8OCBQatMh8O5OMegWpgceGdUzEdAdtx2vQvuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118792; c=relaxed/simple;
	bh=cHsuaeKFAN0nMiObDigdDwsFgMVJeoCNQtSMQQVTbhA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjjhBDxwcGETciJn979IKoyMqfSkdPvxu5qypGFImtqGFgrW3Wh3ZZfoTPFmXqSqTVAnRWjiPwrEceeLBEjgW9tMDkoCpEfH7QZn1UV/ivBcmuD2Cm59/tHweKgn9t3Q1sp7rhnjPzAti76g8Q72Jg6zvbrBeHfsEa0lfEI1f8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=pPxUIkaQ; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZO4gN62J; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="pPxUIkaQ";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZO4gN62J"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68B7nowS3304954;
	Fri, 11 Sep 2026 04:26:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=F0ksubqHac49CCXxCw82+ZZ5OZC4n1pHCGbhkzo0u
	V4=; b=pPxUIkaQcj/bLdUoWozCSixl+l3mpdugpglQgzZ29HkfFReWX5PtuaOxL
	J1lGInJnh0DRgGJEjJsg5A1L0qlTi3zQWN0i8Xn5ghd1t3BfJfuaqbTveu1wRDcs
	hxnZiDfpebN3jVir/fcK9FrqCUHKZJPJUQYIJ0bVrBthjr2Ap4YlCfo5hw8UKKox
	O/+veO4VqnDCuxo8YJD5ULP7FKB+gmVYInyXMMHe9U/Ni9R4HrllUGmtOaYLvM86
	wkbtByS58BLz+AkgWiFzVjfdAdB76MCDlSY7fV6oELxF+XWrCUOT5y8i2zUNpdL3
	eANnggO+Pcdr3UlnIyuVttUdURRcg==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gm3yyuhc9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 04:26:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzA3a6x4wg7vlM/PM/qZP9va1XCzomJM/aehY4Ce2pRJkue+JibeBNFhe+v9zI4+L236be6xd9366VEZqj//nDPwTJsAqm8L9hcUKT1/Bd2/UvCd7aJIMn4r94IWVdSvvt8Y/b//QSGj+3lHSYKkp6OOoCkhMSS6Qu5BsQnAZE+FfLIiqSvEcusGdk0ZPEE6mfd0jili/KvWZ+9v3+bK3Owx6FxL/tXHbLQpXIIIWep9xTXrLc9erjQSI/jS/BZRBzkiirZIAv6t9jhmllQXMICojkLrNopLA9gId0WGg/TLaHB6ARhbqzdjM3xhvNENm8G7QfXWpgChharJr3YdYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0ksubqHac49CCXxCw82+ZZ5OZC4n1pHCGbhkzo0uV4=;
 b=cSE4gre47hcmpo9DSDQ7b3iu7pQUxCfKQ928hNp2R5kdnj7SXRuvsM3JPC0Kdm7UD5OFOkX+DHNfMaYK16/UiaIczMddIW+VS9Dve0I3JP1TL2mn63mR7JHnbiTcQ2k3i+G/zYlTagAmDAvyRls2EFDEyCymM67NZJvCsRCsrk9sViG90ibaEgsXwCX5QAkVV/AzTRee1dAc4TibrI7mOhR02aSnmQ+aJOLAviJeBGeEaoH3wpDPfheyNcHOQxuFPPqUXrG4sxSQwJelRFUbPq0ZnpeHg4a4E/42IIY5cthx5ErWksedv3f060lb+w63BzzI32pkFeCvCGiXI45pSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0ksubqHac49CCXxCw82+ZZ5OZC4n1pHCGbhkzo0uV4=;
 b=ZO4gN62JsAkAZmUESQ1TCeuh92j9EEm/fMd03lYOze2zxWEQdZYNoYLf8vfHC9eF6CSVDETI/Cc58Yyixxagc+O/8VMC1iSZK+hGZ/QMJy8j0u7dE1kqpUcbWEB+ip2Tuv2Ldy2pEJn2A++copsxj1wwRum2bfjYFy2S+wGrBdQ=
Received: from MW4PR04CA0225.namprd04.prod.outlook.com (2603:10b6:303:87::20)
 by DS4PPFF257CDCED.namprd10.prod.outlook.com (2603:10b6:f:fc00::d58) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Fri, 11 Sep
 2026 09:26:23 +0000
Received: from SJ1PEPF000037A7.namprd04.prod.outlook.com
 (2603:10b6:303:87:cafe::8f) by MW4PR04CA0225.outlook.office365.com
 (2603:10b6:303:87::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 09:26:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF000037A7.mail.protection.outlook.com (10.167.244.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 09:26:21 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 11 Sep
 2026 04:25:43 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 11 Sep
 2026 04:25:42 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 11 Sep 2026 04:25:42 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68B9PTqO838879;
	Fri, 11 Sep 2026 04:25:39 -0500
From: Moteen Shah <m-shah@ti.com>
To: <ilpo.jarvinen@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <krzk+dt@kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jirislaby@kernel.org>,
        <devicetree@vger.kernel.org>
CC: <u-kumar1@ti.com>, <gehariprasath@ti.com>, <m-shah@ti.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <a-limaye@ti.com>,
        <y-abhilashchandra@ti.com>
Subject: [PATCH 2/2] serial: 8250_dw: Add ti,tda54-uart quirk to skip empty FIFO read
Date: Fri, 11 Sep 2026 14:55:29 +0530
Message-ID: <20260911092529.306082-3-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911092529.306082-1-m-shah@ti.com>
References: <20260911092529.306082-1-m-shah@ti.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A7:EE_|DS4PPFF257CDCED:EE_
X-MS-Office365-Filtering-Correlation-Id: c9614757-ff82-4134-a999-08df0fe6bddb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|10067099003|56012099006|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	3AUBNPLqeZyMWtB6j7aHVld2bylBFzydMoh6fMjRbof4mH3dEztaUQN4SPlQH6PrfuVb13m5bikiZCxZJYVEv8qHaa6FJFZs8ZQY4BAO/Bmi3BO3LwkxcJ68x6i7aRVv2zzoXXBfgAQi+8dnqmW59sscq0qHz//MGEk5o9YQrc1ebItgp8XrMZTBEUfD8m5Imla5GYPa1wxx0XfM3dL07G0kzPtl9TWxqAFyudCzuE6Nomr9UYMPmxxWORpEldT39f9PT03OqLyNo6kVjyaOscs0qTVYWPjhcHi685AvlcKz7W9tWxqPNNbaPhkm41vko2SwmiPqPYkTqxwbXKby8eXPG79MBvoUmJrmQDuqL8w7llbxqtvuBCqEZBeEHXTtQ4+e9G2lJC/Lddz00wKkf6g94/qn+P+wiH9+EX6IAnF70UU6d3DkJiDPLgO0bgoKIVT1VyUDZ+HTKiAwgq88zx4GD9S6or8xXVdamXutTK82uZjYcu4URjaxkvH0JtsRA+swlLYmaa6kMctzTbFd5UVN3AGMQhWnOVnIdw6OurWNZbfX9H7/ksLG1JXGjI+hxjqn771eZHfA2H4Nshaw3kPv3iKb9yFB20Ti5RIcJQ8wdKyRcGugKWKR/QA7kvxBAco6YY7DZrXMI3nxGDIsWzNrZN/iQal/0UVUHDtm25Ci02JZaBr8bwmJeNegt9/a
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	18wA2oNmwMKQ7utirkKUEcoIvC5zVqbn7yhb6SR6A2OajSacVsjNSFp9sXd/FDFI9SuCiWr0Dcm6/+OoFApG/s1YNB7WPnS1a+BpPagyb7Tq67lPn8fcneRzcYEfnEavIWtdIgckKyvSAiNxQhW2XrL8m6uQhntsDR9jVpSCPPdzh8q0Z6LWp4dpjF8+Yi962yE+FCuwQ3VTeJwxCGpMQE+Ze//rf98clvnvOu4zIX2hX2/Ft2GfbYlhRCN8srJTITBSKR2DsmRh/BvxbSKgosi1fWjTWdml/RsZtk0c0jN96+MIG5b9nPMieMGuQIdTxSCNunVbHGbicnQPW4CGxH/Ie8X9+B28Z/NRGmsVPEtYzLekYM7g6xH3Sl3EolMAZyV32MGLyj0vEFQlAZKhaRx+QsL2vSoLI8qFR9KKZP64KuD710uzRblW4VBdOsC+
X-Exchange-RoutingPolicyChecked:
	g9NfAbq70Kj2xdJXDIN9ao3vMmmjUjk4Yiu4WNqp9H8r1Pj8zB0WZl37lQT0VITx94CQKtzUg/iLXF4hRxeRvI3KhCVYel+IFkWQJN6IVWhfmQcfzm2mnwkIUnR3TbaexiTFy2w01dRowQeqQDw2FxEDK4B+9W4v7ikLhJtyyLAoBVF7HaWV24kTjdLTgVQ9zoQttwasXkJ5hc2Si3Fib7ChNXYnvX3uTxnkRbZ5mXUxlzDrIm7UhddO4O1qKQsByfLBwVNEbN9ZLc28NG5COALu27QNZvUUGNax8fG5R6ry2ffKgX1pUt+xcLhSH6aCOBqQqCHNweBcv0a5klcBfQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 09:26:21.0754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9614757-ff82-4134-a999-08df0fe6bddb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFF257CDCED
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDEzMSBTYWx0ZWRfX2Eax4NcDt/az
 0IbB5kVwrs/QL3liRStAKbTmlG8nw0z7SUG0Ugn6DXIkbPTdgrm9NowuRgy+aLoWFGqnaEHxopX
 DSnhGfe3Vhzuso/wLVYipOIpMX/s9Oc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDEzMSBTYWx0ZWRfX5FPYagIC7RN/
 rl8vaQYGXfxEO84bHrlotNPLNMAq9yksLM8jkRfFMdkI6ZZvm3kutEazZzQ5bFlfHB5sMqi3ljv
 IFNUDvZ9q3p05tYy1rk5H+/fD72Hmb8tbajuVSVkY+DB+m08C2flhlfSkKUxuo4UsWLoWJJ+wOt
 cuJ/kzh0p/l94s6JS7h/3I/Tx4NIfC7oaKL6EyTYFKflECFiHLHiypgJ81QwZdjleXD4yspUp02
 hR8qHPyiBvipLcW9g60glDuVsgkXHXem22YxL2HVv7R6SG6/fMJIYQU/vrWMkldUUay3zO8w2kp
 iJJ1qjAYmTf4Qj+eeZuWfF/tXaD5Q+fLspq3Xv5jN1uwbPctcNvtGMIQW9aj0YZNLzBFdQ74+aK
 q1N87AhI/n7KUEM6IIoWQmgssGN7I7grYX9aXoRAe9743pcichpKfHFFxOcTCIDc5r9qreN1/Rl
 P5QtsItWLeir3zfNcIw==
X-Authority-Analysis: v=2.4 cv=Y8FtIReN c=1 sm=1 tr=0 ts=6aa3c943 cx=c_pps
 a=AhJDvPO6yzy99x9PXTlr3w==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=GmI1URznFtpN0O3YwlkA:9
X-Proofpoint-GUID: cnnWB85UqCvWAuFa3nWoLf1yyaBBvi1C
X-Proofpoint-ORIG-GUID: cnnWB85UqCvWAuFa3nWoLf1yyaBBvi1C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110131

dw8250_handle_irq() does a bogus RX read on RX_TIMEOUT with no data
present, to avoid an interrupt storm. On the IP version used in
TDA54, that interrupt storm no longer occurs, but reading an empty
FIFO instead triggers a data abort.

Add a DW_UART_QUIRK_SKIP_RX_TIMEOUT_READ quirk for ti,tda54-uart to
skip that read and avoid the data abort.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Moteen Shah <m-shah@ti.com>
---
 drivers/tty/serial/8250/8250_dw.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 5fba913f3301..a1ce00156ae2 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -51,6 +51,7 @@
 #define DW_UART_QUIRK_APMC0D08		BIT(4)
 #define DW_UART_QUIRK_CPR_VALUE		BIT(5)
 #define DW_UART_QUIRK_IER_KICK		BIT(6)
+#define DW_UART_QUIRK_SKIP_RX_TIMEOUT_READ	BIT(7)
 
 /*
  * Number of consecutive IIR_NO_INT interrupts required to trigger interrupt
@@ -436,7 +437,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 	 * This problem has only been observed so far when not in DMA mode
 	 * so we limit the workaround only to non-DMA mode.
 	 */
-	if (!up->dma && rx_timeout) {
+	if (!(quirks & DW_UART_QUIRK_SKIP_RX_TIMEOUT_READ) && !up->dma && rx_timeout) {
 		status = serial_lsr_in(up);
 
 		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
@@ -888,6 +889,11 @@ static const struct dw8250_platform_data dw8250_ultrarisc_dp1000_data = {
 	.quirks = DW_UART_QUIRK_CPR_VALUE,
 };
 
+static const struct dw8250_platform_data dw8250_tda54 = {
+	.usr_reg = DW_UART_USR,
+	.quirks = DW_UART_QUIRK_SKIP_RX_TIMEOUT_READ,
+};
+
 static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
@@ -895,6 +901,7 @@ static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "renesas,rzn1-uart", .data = &dw8250_renesas_rzn1_data },
 	{ .compatible = "sophgo,sg2044-uart", .data = &dw8250_skip_set_rate_data },
 	{ .compatible = "starfive,jh7100-uart", .data = &dw8250_skip_set_rate_data },
+	{ .compatible = "ti,tda54-uart", .data = &dw8250_tda54 },
 	{ .compatible = "ultrarisc,dp1000-uart", .data = &dw8250_ultrarisc_dp1000_data },
 	{ /* Sentinel */ }
 };
-- 
2.34.1

