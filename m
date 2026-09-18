Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095DF4772BB;
	Fri, 18 Sep 2026 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725858; cv=fail; b=V7tj+kiv/HdVTJJFVZ24osAOP+4aTWwZEh/uh6tG9cDA2eP47EIQMK3UNclDGHFDSmvLNwY3+T2iNc/5dx1Eq4xZKCe/lhZspq0UhmRPoSNYaQJjZrripUaQiyLdUHg2Z2Nyc6GJGnZc0cy9az0ZRFhwkg38RyFH7Y6cweegMnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725858; c=relaxed/simple;
	bh=MVcKVJQCRtJUVYzYZX6W0WNepyi5bianQ20nrRk/Ccs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FWdtkjioE9cXLCTYa5RIsAgD66nSNnlMb7PKl0LEzcBu7bXoaIXtbUheiIFEM4F1LSuMS/b0hCje5JwgV6oRlbI53m6lAlx5bsOSto31oLFFykKiMFHALEQkmH4gXnH7qK4YZYPA+jfMVXdHabbTKIO7+aC93znCbo980/NkBxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Xd9sV/nF; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=G94OGwAA; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Xd9sV/nF";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G94OGwAA"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I9dLq3033420;
	Fri, 18 Sep 2026 05:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=jWpylLY6FtkmE
	ObK/7EzskWlx9niryhJ9FXZ/JbadYE=; b=Xd9sV/nFrK99RsQW3Wl9mhW3Nfep6
	iSUu/Pbx7vEifY8OhYvbR1/xZluwpkKPV0/omAKAW2z2W2g955EgQ8Lc9Lc49amZ
	SsZjacfLFW5vC6XP5mftBSlH0mm/3aTKdiZQD++s1jtqbrDlQewCUHIKhiLyBip7
	OjrXg3tFZ0olLBn8VxA6+3KZjNwIE6Z3nTUi3+74sTCy2kJC4hjEWXvPYokTq/sl
	gGLPd67s21t9FaY6a/xp4vpa4L1RNgLBzYKBZtaR9QbBWjfQzF3A9sLxvqpVURBC
	JzVOp98XBEuO195V67mtNeNNIpvxn4FGuiRIV47KY4fQwcBi+hP+sOEnA==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gs0k38wrk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 05:04:10 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiiakZFZJyYa30BkaHBPYaQk74vBvQsGgFgKqZ7R8sGzJUUTr+sMFudoldOROMPwDOO65UR6PACygSWlFFW3BjXv5b4sz980jMs+loBsZwcX0of9Xl50/CsoEc+OKEtq/6Ju4OPx15yzQxB+zpfRG6LFwHT3PCjx50brEV5KSm1T2fZXinSB35Eat2tZYG7gNuLhUPSyKlW5ssD0f5qcnLFiy+hCSE4raFoB7dtBhDBNh5HFMlUiM57Dj0UDY00a9cOcHxlYognyQLxDgnYPf1znQEyxXNoCroKWtEjdjKvRNxlerIDj5clz9kl5rQUKIVgazjotBYvwYvZDWQtoYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWpylLY6FtkmEObK/7EzskWlx9niryhJ9FXZ/JbadYE=;
 b=wkkF1v6kAsBQ0hOBSCcAfz3RmdRdNHL1JcNOcl1UpbbcXvTiwMfVIeOH/KW1InNuBAmJabwG6RlqHYn6qGl9K6xA4xAJktF4ls+cIHYSwwOMQNQwZSc8O6QFwo5Yu5pfYSqhDDdUBfyoSFK+mJHbXxcP1fz5SCQsrkOjvzwAZh2iCTRbgRdz2BrwiM6zmWwS6Je5iwutowcuSTSGps7iYmabLtiifEI/xCx4PsEWjCpzgLAdEKvTiYC0y5eyL2KZPOUQIiu3jZog4rZpDI6LmAKQV8aVkOoV/pCzFb7X0tEE+Dotly0ETqFGUld8q4Q34KqrFALW4QnnW0ra6JL4cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWpylLY6FtkmEObK/7EzskWlx9niryhJ9FXZ/JbadYE=;
 b=G94OGwAAPLjNMgyt2fNIFCewJakl+9Of+LG7nnWf28thkKZoh8ic2clU0zmPYVt5nl4pIhUAxi2izVfPkrpfp38IIf3Nk7tjHIE7fho2YO8ePtrboAxqk8C9Ei223oMSAEDyLjyxrtid8TCEcpcJJrP8/wghNETRtGmIJoxAB5k=
Received: from BN9PR03CA0365.namprd03.prod.outlook.com (2603:10b6:408:f7::10)
 by DM6PR10MB4362.namprd10.prod.outlook.com (2603:10b6:5:21a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Fri, 18 Sep
 2026 10:04:06 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:f7:cafe::8d) by BN9PR03CA0365.outlook.office365.com
 (2603:10b6:408:f7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 10:04:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 10:04:06 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 05:03:51 -0500
Received: from DLEE215.ent.ti.com (157.170.170.118) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 05:03:51 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 18 Sep 2026 05:03:51 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68IA3k3J1507569;
	Fri, 18 Sep 2026 05:03:47 -0500
From: Moteen Shah <m-shah@ti.com>
To: <ilpo.jarvinen@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <krzk+dt@kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jirislaby@kernel.org>,
        <devicetree@vger.kernel.org>
CC: <u-kumar1@ti.com>, <gehariprasath@ti.com>, <m-shah@ti.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <a-limaye@ti.com>,
        <y-abhilashchandra@ti.com>
Subject: [PATCH v3 0/2] serial: 8250_dw: Add ti,tda54-uart support
Date: Fri, 18 Sep 2026 15:33:44 +0530
Message-ID: <20260918100346.4044899-1-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|DM6PR10MB4362:EE_
X-MS-Office365-Filtering-Correlation-Id: 55307ff6-33ef-40c2-7531-08df156c2d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|13003099007|10067099003|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xqiNWAwLQBofqQuP0TLMWlOuINPFW1aV5SV/tk0NOs6uIVA4c50qEftr65x/u8PHIF2WJJTpWPOzDq4a8Z9zxfzESpHeVGWmXCoztqUM3LwNZnWQ1OhcmTOSj6+OPxnhqsbLz4RtpR/161nstJp/mSCCXm5JVQe1ftWDsb5QqKDuwCc8cUXw+ohHXQ5d5cNwwXN937H/XLtfkcpqkJIkZLjnkmXinfVqgez41XIuFya8VTb0YBlRWKy1mmJ+ja3M935o8cFXKoK68OiL1iUWoyWenr57QOChkSze8V5/a6E/dbt4BUpXqP0aJJAX+q9AQdDp7wtpxVGBaPJLDv7IaLyxel0m6XrWi3Q7snc741H75N7omgJVoiYQGjZMs/H4DmakqPfhGMgwlvBEDER3+Ij2yhCmMMW9pIra/AJmf5FAFu79H64uCz3bwxYJqezvCFMd4qMx70P41UjfJJ3/eSlKkrC40jImw+VvI9H3yTijxRbAs8egZ9kskg4zukjFNe45nSV6QNQytDI06oLWDe+ZxCULFK11loJlaB5mVRTbsdoguhX6x4KivW8VudRRKSM+6lDOqoyr3J64Rvo5DR3bZHVzeAy5lQzcPMYRGoenCow3JXoQAT5ZSjXgj0dHtBM/0mzxniF858B/mgIHmzhw9aCmgN8wvWM6gFJvlIoFzCE+4t2c38EwYCkFEP1PfRwtHeucQZuFmpWYfMtCSQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(13003099007)(10067099003)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	+g4Tc6LertWHWlLch5gcMFR/NwuD5By+j3nfPLDCKXrdVy/cXlXKOls9RtUgLflo8tcnIZxDQdfoGEjoe7hGpkZ4uJlnY1uvNqCVEBs3LO9xHo2iQSu7ohCDyRzr0uXyKcyOwAxIYe6CbqgkKt+p+FP5IdWAlKGthdFS6iJXESBQjOq0RFdKEmfmQEIO2JrxQJyFGaauWngJr22ICxDhcscRETL5FlQveMf10uyLRkJu4ib2STtDCalLYzl8IrZaJzI/pvmgaZSenFVVGGSprSXk+GnA/Z2NAHtsa0rqERfpMylDYh5fAN5TaA1NRkFLZEKv/9F7VBEL/AdJV6e6wOGHg84AD8y+B/z7zku6AaDZfFCFkULuNG5yzeatpIosd5ZkzcMJpODVS5PaZOCy+CVkx4pi7zLdeOL3Fgvw8XQ9e99g1KR9BbuUDt28AGnV
X-Exchange-RoutingPolicyChecked:
	ys0oPju/FBF9MGyR2Dj/1nRmj9W/dab8WKNfV9V2RCa25tte9ZvW1JPBiQ/63rth2etIHezRi2nWJJ7Rc2Ju2gFX4887N1IGj7kFRTP2If/8dEjzg9OXl+x5qa1I3N1voKj9ulonluSX8FBbYULwmyJq4ImWZqhQ5zvhtu/G6bIDpqYnYg/GT2Gqd27ievGlDpnIGNXR3t6XUtDRyc0HGC8wlAMSFYZhiin5THTVANcBP4t2+NEb4A9pADsK+13S2FZv4dKDscejFLQPGpsy01q7id0hr8QMMNGtAgsz8pBmOZpz9dqDvaK8FlsR3xhbKRV1dolrBfUFDa6h9DhaPQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 10:04:06.4605
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55307ff6-33ef-40c2-7531-08df156c2d03
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4362
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEzOSBTYWx0ZWRfX0MfULhDNxGvH
 IP0uzprRJbiH34c+h9fgd97c5wunw+0mu8GaGgjOiiyAEfCyEHd9dZTfiBOfGYWV8SJOUrp/QmA
 bhB1ime3FYIdBDh8R5Wk1Uv52lPUV8M=
X-Authority-Analysis: v=2.4 cv=K6S3jCWI c=1 sm=1 tr=0 ts=6aad0c9a cx=c_pps
 a=nfJ3K52CLbhVQgIdADXVOg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=TxhyHGSeAAAA:8
 a=dsxY-UZ9IpOO0aJRIToA:9 a=VRTRSrWG77IPp_BSX07q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEzOSBTYWx0ZWRfX/8xagx9uNOiv
 vLE6fBe8mfUifY6+s7o4xR3ez6qACxQrC7Q9ivhjlEGbyNZlVfCvLJ+/4YsFjLiwrqIPv57gZgb
 cCLJruUFBdJCos+p6auPOSpuQZYC1Xo8P2Ex+zNzdj48G6ClQeutQklfAF868MwPLJs36oxhjjW
 n68HEAeYopHsS25W7XnbQOPyoON0p8c8TuUWxuAEumfL3XMCVcuiWb1JYkD4fnC+5I73GN3X2vV
 6f4y+phlzpNbkbTRd1w+m5U62oG1wsXPmqcYTqKvUy/HeDgdNAysWjZrUoG5QTvOm0LreoP1j2f
 ktKR4iUBkw1wLBcABwFlBlvp0ZNEhKh3UdKY5HYj6u/iG2zO88Yxr/REmUt6G/zq4yofNQrwHC/
 byFylEFPKySSdXnl8074EQ8pAYcGqKRrinauIzThr7cOta9HsXgOwE/zhpMuR9RtgVkkiH7Bvy/
 yfC72h30zLTJtDYoEpQ==
X-Proofpoint-GUID: vaXQ6bUQn7sOlL5lMyRY1_TgS0SU028w
X-Proofpoint-ORIG-GUID: vaXQ6bUQn7sOlL5lMyRY1_TgS0SU028w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180139

Add the ti,tda54-uart compatible string to the DW APB UART binding,
and add a quirk to skip the RX FIFO dummy read on TDA54.

Reading an empty FIFO on the IP version used in TDA54 triggers a
data abort. The interrupt storm this dummy read was meant to avoid
no longer occurs on this version of the IP, so skip the read via a
new quirk.

Changes since v2:
Link: https://lore.kernel.org/all/20260916085520.2259420-1-m-shah@ti.com/
- Drop the fixup being done for the clear_interrupts and
shutdown of port. Reading an empty FIFO (by RBR) will be fine
when the fifo is disabled[0]. In the case of clear_interrupts
the issue is fixed by the following
commit 7f8fdd4dbffc ("serial: 8250: fix panic due to PSLVERR")

- Base this series on top of the following series[3].

[0]https://lore.kernel.org/linux-serial/ab256e4a-a9cc-410e-b889-f75fb01e77c7@picoheart.com/
[1]https://lore.kernel.org/linux-serial/20260908141524.20302-1-yang.yicong@picoheart.com/
[3]https://lore.kernel.org/linux-serial/20260908141524.20302-1-yang.yicong@picoheart.com/

Moteen Shah (2):
  dt-bindings: serial: snps-dw-apb-uart: Add ti,tda54-uart
  serial: 8250_dw: Add ti,tda54-uart quirk to skip empty FIFO read

 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml     | 1 +
 drivers/tty/serial/8250/8250_dw.c                        | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.34.1

