Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C4046EC6B;
	Wed, 16 Sep 2026 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789548978; cv=fail; b=jqvV1Zd72eBblgt/cTglQFqJNwFWi+jZSpL1Gsgix9jFI9RBtxuA8uV7HB/hAYofHQxwxKa1Z8lbyhee2507mViiA5Jo+9TkCF+QpAWyKOaVDQci3YHF5QDoCGGqi1Cd2XU1r+U7W+VmnH5F/BxJdyrU8siWQLwvaK+MP17XM6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789548978; c=relaxed/simple;
	bh=qisnskVBK1LriryLZO9Q09j0y2dz8rTyT4aQraIyWTM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p8Mn845C+nE/gaRckW9THugbN9VFerVumQKddPxeVvCnTTxMH2nE4cTvO9qAz3j+oTd+Q7THczq9cFwzv+6K7xCmR2liAJOEXlnbIybX7ZmzX5JCm9RsdZ8cbKiccS5UO/gi56Sm/cpNlrgzmZCEvs+UbgK60rFw+hPrTROKKcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=myf/12U4; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=aTkR0qTc; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="myf/12U4";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aTkR0qTc"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G8Rqik2707759;
	Wed, 16 Sep 2026 03:55:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=km0IxINjTeJ23
	a13j6bFHZwmb8Qvd5d0fmSM084dTB0=; b=myf/12U4tJwfLr8+2LCNoT93E60Jo
	OCgaJYoIvJMhcIcMrW3jWZrpD9It+DwFVtRa75qJ194tIcjeXtNx8DcjX0M0fy+6
	CDgxtX4/2BMjrOqWVXZZB9v3RRgWpGkUH5CR7hyECL7CrxKWj7L+tc5MOvsG3OOq
	C7mggEE7ZuToGWgy+IVeyBSgHyzcxQ7gjto++YXa0SdTnuLmf3dRYEGaOXIz2rLr
	ubE/HCykBTk/ECKAsEOmRkSg6XOEwzcDlmKYFidmTu+OK5ORCO7IeJyCkpPE2ngy
	yy0yyAqHJlJx0TL9c22avBKMoxXNvBAI76HvHMZV3Trfoh+qgGk7aXo3A==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011065.outbound.protection.outlook.com [40.93.194.65])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gqqmd84r9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 03:55:56 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xdE2sRG6v+s/r0MFEQC3Gg9iYRMeRIR2V4ZbSWnLkqL5cU7uyymEGvqZwiBcnYyPJVyKqQN9G1aPicVe84oRGBArpRfgLYHvdSLzzHgT0mXY2X0/YccUTQMzjxXZowSKbQAmiv4fM9pZHtR0pxiw4t3PtN6Q7CLmFvBm/uROIa8+mdQSGQdEbStZW85fxYZVie35ND/rPgJQ1hQCjwBbbVB92PxcLtT8tfvTDtlWTO9dJeuC5x8LVpuogPN9lKW8Ln3kaw1gHhjIDzRKsohXB7GCrL7NPV7X1SqZCv+ExhVtE4H/3rgKq9qI9vIKbQ5HB/11KKvAz7ek1v3KbrHtdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=km0IxINjTeJ23a13j6bFHZwmb8Qvd5d0fmSM084dTB0=;
 b=hWb1F4tJzMyOT/tHrNLi5oVeVFV8+sOlrsGBa0o/qFiWwVbXLXISbosJUNK6hIg2fvlngW6jHnwxrsO+Kpkmm/4J0W3pURjipxXiXppAbKxtavcHKpJzNH1q0NskKIdYC8Wiwl9y+s0sBN941S4LcSwTYJM31B9nUUEEpXBttqJMWCwvFzt4gYrV+nMLlouGrryS7xnnkTYZGIRAJot4eZiFNcyNoyOwy1aNFhwSRQ6PYvWDYlPFmUvRpAYXNE3mF5A0eQiA9i+bDQxnSG66OwQYYHrmT45s0lAd/zscG/1U87hKeLFokY7Wf7nacqxJQp2+vZ/BEUlzX0w1GWk1+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=km0IxINjTeJ23a13j6bFHZwmb8Qvd5d0fmSM084dTB0=;
 b=aTkR0qTc+aOMu93A2voShHH3M0hhJk3fnrimHo2VjhJb0FVD/vbJ0Xtq5h/ArY9YNh8H9/jxebDp5Cr5R1s1A1BQ1op88t1fLoKElc5euf5+11EjVXIO6+lskS27NhCVEI7lQiFS5KJ7unOWxU7t3ckku8XRNTuhq/Frr0RcUoA=
Received: from BN0PR02CA0022.namprd02.prod.outlook.com (2603:10b6:408:e4::27)
 by CH3PR10MB7496.namprd10.prod.outlook.com (2603:10b6:610:164::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Wed, 16 Sep
 2026 08:55:54 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:408:e4:cafe::19) by BN0PR02CA0022.outlook.office365.com
 (2603:10b6:408:e4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 08:55:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 08:55:52 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 16 Sep
 2026 03:55:25 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 16 Sep
 2026 03:55:25 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 16 Sep 2026 03:55:25 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68G8tKwE716870;
	Wed, 16 Sep 2026 03:55:21 -0500
From: Moteen Shah <m-shah@ti.com>
To: <ilpo.jarvinen@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <krzk+dt@kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jirislaby@kernel.org>,
        <devicetree@vger.kernel.org>
CC: <u-kumar1@ti.com>, <gehariprasath@ti.com>, <m-shah@ti.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <a-limaye@ti.com>,
        <y-abhilashchandra@ti.com>
Subject: [PATCH v2 0/2] serial: 8250_dw: Add ti,tda54-uart support
Date: Wed, 16 Sep 2026 14:25:18 +0530
Message-ID: <20260916085520.2259420-1-m-shah@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|CH3PR10MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: 33813b0d-e37c-42dc-d0bf-08df13d04fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|13003099007|6133799003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	7+KIMOCaqUr1b/pY/rflWQhjjUd70RUBARrkOi6sGAu95XKNx/1rruMxJu6h9gEXOSK0ahtVPRJIzoBuypzbTqXgXNPcrrUzbeLXyspmApy+w82wThnChu5Gd2KMsQNOE1WjVvDAu++/YPJWuCG7GfWyKQySY5UJaUK9kgYm/Z2itzJFSy/Izg/BDRldL8wrxr0e58oG5uybDbUaUCO7YF3umr1DpX2lNvBnTwxJ+HbmmQqcCm9osmFmQAxDN6Yz9pzKi1UE3+zJqd/1qHPnHPzIvEdKpv+dkGoCighQgVU1271hw3r9sPRmdU/sxhtZ8F8MoHWbfYZdZSVAsudITlh3H0YH6sJnfNfTr6zlmVC+YjqjazsG990lXjyIGBRJNcH4ZnVHTyx96Qc6SSKtNeSD+Z9dXIyiY98MCcFG0kE5emsdauFzQcm6cwhMYOO8zAlJ37TTRF144KmerCZlKOX0rpoiuCAnKafMdW3Y59ciWiRDuW4l9X59xCjk1m8nXZRdhBP+/laPg5D2mIDzIVK8gKsrgSbRNwW9ekZ3xK74IzjBqYtFhUbtPvlLAwcahwyhRitsUNqQTvqzinZbgmYH+TBcixUtUH8GW4psfK7BtjeNABNmo8ddKgktqmofcyrG0eVq9zdBxDEvWrJ4JbpWwMBOGtQoiIqs98nIpf03ob5srt+sOTNel2ZjMpaAsMLfWafQcSflDPTLsHZv6A==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(13003099007)(6133799003)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8VQbocy30Dy/NRTAls8bAdg11b9E1o+ooWcZuDogd6Sryit+HqMS1tZwZqEQ91XyUgklpdKiuQli6i1jl4XNMtAYdVJs2sYVZ+VhClTOD4i/rjvcLVrldLNbHjIDogN/DyoHoBCi7UVFmnnv06lc75s0JQp67p3isN+kWqOAR4GdcLPRstmaTWnf8sD4KSD+UeXk81TZNdE7oXkTbL61JEDssE8RLFtQmxoKek66EGJSy5zsokvukw96lApBgxoAC7fR/XmnEscZsI/WwHeWMfE7TWvIr8Wp/Ex4/o5RzLQxJjtqPLrEnmwq+Q3Z7Rm3fjT3Kop4qcQUh0lCMEDuoHeZwJAkx9M5+mTOCraIfQ5cGf9+NYg9xEqDEYZ9OrdREG16ql6ce2ApItcza12w6ftXmy00qEBTwrmbI+mILdic3wzClSZ8AzpPT4Y2HqSD
X-Exchange-RoutingPolicyChecked:
	UyyKYnC1eMcklfT8yhyK8GyrObncDHZM1coTCf/HL2m/SuKO1BMCDNjJDtXUPva/3OsZUwdevr5Lj0CmIPQFcoHFvgKK6iJ+jVYYwnmB4IineNljVxo4OjLdTvuXCr7GIBSB7vgwVCF43EIIAL/OzqUg2FoMHwB4MCY2aUmikgiNMJiu+bhNqQffDTqWaW3d9on0B0jwhXMa4GFw94LBzS69XvP+7RU+PFveKHgaueS60m6KjCJBsUkd0D5+/sZ11YaO+VREfLF80P3g00dTTOruOuiJFSqgWB1zySGJraosKiM1NLDdaUokKZJbnwNjKGvBQ4e8MhpTBKyHcTnbBA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 08:55:52.2245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33813b0d-e37c-42dc-d0bf-08df13d04fd5
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7496
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDExNSBTYWx0ZWRfX5GZ2TybuHntY
 mYhrb12XSi/2yYEU9iKHrZ/2aiAS8dARM+kciYkwOaAS9JTxuuj1pG2v8NE/yp/DAqFCALvDg22
 JqiMc0zox8WGom6m+4K1ogEsHQmstkQd0XwViDoxUSt4AYSY01MF6Dq+HwQvvjaXA41WXVqo6CX
 vYPtcaiVBF0D9+/vEx/Q/1l5wQ/ycNKoWYnUbhlzc6JIOKj/vSUXxyLjW7/EfCbqrLUAXbDpUip
 Txv2PxblV8nrRgBxfL0plQkAwhwfHg8mgdbc/LsCEBXBg9awcd6ZXGsjHRVHY7c7hRQzwk6ey70
 eTaRGGBc+mOwjCaSz/G5ZGVrUup7Wsh6X5AkOn6OzDe0hCErjxegZI0jaHsu4tuxuqDDW7j/Eqe
 hwP+KX+bMHYvQgc95XBcVV/PSzQ/o60RIYTl3zTUpH/yXywn6V9puCzi7H8T+KGrS70lqQIfeY1
 uVi6TkmrDbDKU2Pu59g==
X-Authority-Analysis: v=2.4 cv=S6JMU4sP c=1 sm=1 tr=0 ts=6aaa599c cx=c_pps
 a=JPuSXJPnATmcGobPKBfcew==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=kfyzvn_tYnN8tWGvylEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDExNSBTYWx0ZWRfX9Di131qXzHlX
 tuAnQb7fQHSINOG7OWBqmaJQLpisz3Z5oeyAZ16fjL9c8r3d74TI3zM3Mbh/S+mt07y1+JFQwht
 ioINLV9G11Wk0JyGeMGmgOwpuD2JRng=
X-Proofpoint-GUID: Cs4V0c4U6dkFNxTOrkl97pQ7cCz0oWNV
X-Proofpoint-ORIG-GUID: Cs4V0c4U6dkFNxTOrkl97pQ7cCz0oWNV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160115

Add the ti,tda54-uart compatible string to the DW APB UART binding,
and add a capabililty to skip empty FIFO read on TDA54.

Reading an empty FIFO on the IP version used in TDA54 triggers a
data abort. The interrupt storm this dummy read was meant to avoid
no longer occurs on this version of the IP, so skip the read via a
new capability. Also, guard the empty FIFO reads during startup and
shutdown of the port using the same capability.

Changes since v1:
Link: https://lore.kernel.org/all/20260911092529.306082-1-m-shah@ti.com/

- Gate the empty FIFO read during startup and shutdown of the UART
port using the new capability.
- Make use of the new capability in the driver as to skip empty
FIFO read, replacing the quirk which was being used.

Moteen Shah (2):
  dt-bindings: serial: snps-dw-apb-uart: Add ti,tda54-uart
  serial: 8250_dw: Add capability to skip empty FIFO read

 .../bindings/serial/snps-dw-apb-uart.yaml        |  1 +
 drivers/tty/serial/8250/8250.h                   |  1 +
 drivers/tty/serial/8250/8250_dw.c                | 16 +++++++++++++++-
 drivers/tty/serial/8250/8250_port.c              | 12 +++++++++---
 4 files changed, 26 insertions(+), 4 deletions(-)

-- 
2.34.1

