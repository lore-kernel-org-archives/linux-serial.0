Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F0470120;
	Fri, 11 Sep 2026 09:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118753; cv=fail; b=PeCy23xXYzZMzg/2mpXhCtXwU/ott+Ri8r7hp7VO54bZ6Sz1eti06XzZU9JldYcWOlhdhvcedVGay35CEjGrREVq1S9Jgn7JF49vKnmhvv5xmksiM+MDp1g/dHNPxpyAihkKOzyTIj60nYAyS5Bw/L5jPulZS+mx6zw7J1M00BM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118753; c=relaxed/simple;
	bh=isuWcJBDJqjwZwzsEjZpucqeBxNrJ9NRayuuLvRAJYU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pf6yDttwiVlX7JnuNtVTLoIX/eGnOlqu+MiKlbo45NFhJJLDOlScvPj1PgrhRyyaIKK7OC9/ymRsnrQ4rZJzqE5Q4FGTYtAnfHgutLipqMvQS8vh7SICSgLy7HnUm0uRtToStqc5PbJV+PZG4Thq0bWSF9z0arPZ1tIlPYdojq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=blPVo59s; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ABbFj4I5; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="blPVo59s";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ABbFj4I5"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68B7nocA3304933;
	Fri, 11 Sep 2026 04:25:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint-05-2026; bh=gV4PcyE7oOF4v
	gPFVLSNg1JkSstzXsKM5G+qaa1tPX8=; b=blPVo59sYuV2OL8IIvQQpXejzQg6p
	Dn0++UyMuVpoAZZ8PJJMJtfkDaWqqg9pTfde6Uvrqcqdrmel8wUNzCItH+lz+F6B
	s091tTlQgBRodOZlurnYQsYxKARbwojeVyh/Lvg+xx/kxaMtM6KLFDZWyBrREy/f
	0/W0BRGua5fFgu8R4qgXMuiF/8zwg7i1fzAQhhJ0c4FlZj7+ug4EiTbl1LEV4nI5
	YQVgvi8IrR6joIQOo0scguXanTn8Uowbz7NXddvm2rRVyS/M3rp1fXIgdsBEVZPI
	rOmBgAhVyXlzKlW3lI7f/yqUiflJkEtyt+0F7fR1Y2TMnW7AfBnLhXQHA==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gm3yyuh6y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 04:25:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0HGXA3ZlEdRod4VgVVkPJ5VyrLMYt8Msmq2c2Npw1WAKgjzGJOy3obujpKw5WJWsBzf+UDA4sXj3z+vhSHe1lPzVSDVcjj+DwF9pCksRhmtjgUEJOblusSryCJI+vikCDWEY0kfpt7wMGDzyM5Fn9nf2PQFGMrCCSpY5kAxBbQ7/5qxyvS6Ym6Qpw8MXgimUOgOIgVbzXPwUP61pI0P4RbD4oCCXmpusqXvTeqLjDRa1nqr4T81+uc+JnUCA1H4aCnZ0nLP9syf+PhW2PtJQiDTJ/bqkGbxxGXxwb3QHtqewHLH3T4ICrshpxHXC1cW3kQOzuG/sgh6FNW1C5yj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gV4PcyE7oOF4vgPFVLSNg1JkSstzXsKM5G+qaa1tPX8=;
 b=cN0xLY/ikyoidqo3oxgiIDrU2/vnZB0rWUgBjdr9H3++XqW48SQiRs3mqVpGoL7mHBvAoDnA/1e+XgOf602zVZdY81mnWxiQR1+2xYpMDZtL2U6JuKDimlksl6IhbQoxE29WBZe5j2EPzdd0tha8tS4wNmJC7MRCeEPgqxHaIN5eoQkdCr59Bs330iy2dgitYqFKHU0MBo/WP1b2P67L0Jd5rhnAdbIqi3TxBRA2REj3nSagMpqUjiy0S+i0b3jU455tYlLGibA+QM4dJlnY82jw2W/DPu0b8m2YS9LxxOfvcE7HkT/O3heWZcwE/5YJ+kW5ZdlrAQVmaMioXs157g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gV4PcyE7oOF4vgPFVLSNg1JkSstzXsKM5G+qaa1tPX8=;
 b=ABbFj4I534QX1eMh4iPDutjkUUCVUt7Z0HgR6OOe4583TKQXM9JrENQQ2hHE4GWJm/ngAv1lJzw6WarRsBtMZNsr342ZiQzIYgKaBBRLuwxny8PSnCFTxOGVpsOOiV9JEXRACAMJwjNZ1zMSa2sP4pwVHps0l7gGKHcIdrN3IBE=
Received: from SA1PR02CA0005.namprd02.prod.outlook.com (2603:10b6:806:2cf::10)
 by LVUPR10MB997808.namprd10.prod.outlook.com (2603:10b6:408:39e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Fri, 11 Sep
 2026 09:25:44 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::b) by SA1PR02CA0005.outlook.office365.com
 (2603:10b6:806:2cf::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 09:25:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 09:25:43 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 11 Sep
 2026 04:25:34 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 11 Sep
 2026 04:25:34 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 11 Sep 2026 04:25:34 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68B9PTqM838879;
	Fri, 11 Sep 2026 04:25:30 -0500
From: Moteen Shah <m-shah@ti.com>
To: <ilpo.jarvinen@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <krzk+dt@kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jirislaby@kernel.org>,
        <devicetree@vger.kernel.org>
CC: <u-kumar1@ti.com>, <gehariprasath@ti.com>, <m-shah@ti.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <a-limaye@ti.com>,
        <y-abhilashchandra@ti.com>
Subject: [PATCH 0/2] serial: 8250_dw: Add ti,tda54-uart support
Date: Fri, 11 Sep 2026 14:55:27 +0530
Message-ID: <20260911092529.306082-1-m-shah@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|LVUPR10MB997808:EE_
X-MS-Office365-Filtering-Correlation-Id: 78663ae2-262f-4638-b12b-08df0fe6a7ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|10067099003|6133799003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	g4NxCCuOt3RrvruCKmVJRoKf4V0zLGVCEMAx/60hTtOCOlQ7S/XAXw/maSs+3b94dLgBuOHkznLaPF3XjHHDVVJYXByLuGHbs+6V5QdxFeormvh8AEvHZg3w3kePa/qN5DG3GoR75EOFcSUamZO5jhl3h2PvV/l2lLeKo8hb9zx9R6nYc8EbQD+uVdywkuN5Ta2HHJ+c2/G02kDm59Y6JJ6dOCCIK23APEMJ/y+fPrxbpj+WTNnIlon/hTOJTIpFDzpw0Z24vVV8weAdS/ndq+/pgyBC4/EOGuWzvK2RY+BpLZUlQkktLvxwdm+pSL+NdTlBZkQqnvlPsjo3nD+jcdFZX6X3GxxOaIRk1wE7DM2O0e1FXK/go8MEyQqzFuBdR773XGcTdyGs0yXD+eT2u1LhX6qj5nkBf4tWxFkenyDGjlOk0p9sUD4y8lgbXSQ4Dt/7MQKCNq9Kn1X3PrvcRTRmAQ7hmGgp54gyc/JlUcJSclsDkrOhjKKRBKs6A4e5u7UA5nhUmzA4dgGKIO37ypjdMHtVCmdmZHtmLx4OqWGB5Exl6tFzqIJfZKDhZhai77t2o5VIakImbf2dNrze6jrNiLgBra4lJmdUXe5T9yFw3dk9anGsAMLwTeP/LvoEakAaVkX+C7mxXDE9pP/oIaRd2aSp4YqSHHiAyPEZ4YTO0YUSBqweBLaPdguBnB31ov2syTdusvl7L4mA2+Trnw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(10067099003)(6133799003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SNyaim7fN7gyVLwGqBs+Nr4cYzu53nrq0y9iymrxK+sCkE6du6M8xfosOEVNKrFIa337ifGJAndLsT5WFtqBOqx1w7wWhhOYXLDzZIdRQcGjYGVCv++11Xe55tbz+bHWlFa5uZXazqx7cDnNk8LleuWsX9nO0QMRtxHHLZq8nbAYg5FN7gGXZG8+MmF9FdmnhY4b+ANPsdxFwYWBisL1/glyuFNGE24WWNX6/DKuKXH2uoQt6dFsOh6vihYtEQLwRC8F9tpAuVH2Ewx4koGSAxAWxiMCf4YR9zRhQLJY1BAJRPZ8zXsKw3LHkIi2utvbWLG/UCsidHQQzMeMcntHMZ3GVfGIDjWDidfIGg3ZQDZnsTUwkmFsssIbPWC7qMhFNzwQ8GLrLSdoMo0WjoRFXBWAUGzFg5sPZvYfcj3xd6af2ygok/70fZzy6f4WabMj
X-Exchange-RoutingPolicyChecked:
	YyofbzdPGlbeW+nlFPG3iZXbktfMwlwj12lFC/oOCJ894qdaYjQUo5aBPiEEYpgiKvRDRmUOIPNOqCmKt7+rxrwilcCg8Ou3Bz+kURWcZofcce9h7WH7BwqzW743+42TID8rsdbGdwkrNrbindgNMdha9RwiUvAaMGk+m1S7CNH1tz3T0ELY80X9nZsquwZ9wS2FLI9PakPLewpOwo58fnmEVSCbqnod9uQw08J2QGJe/aDWpFTRboRsGihlEFD/S7Aj6QhE/w7uJ7aWfuZWS/H11QsPcm/f16fwCg0prgvimN06GSoOwashw3ses8suVVLhu0WyEkScaZ2BbJj95Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 09:25:43.9242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78663ae2-262f-4638-b12b-08df0fe6a7ae
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR10MB997808
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDEzMSBTYWx0ZWRfX0+NFHTT5XUH7
 Ji5eeJqOblwX6lV6xH7vpr0pgMX7T2xUSXi2VbNw/YdbcG1tOwpoelhlMtRTkL8aYbxMQacIg/U
 +L7177XuqMG/bbd5yHe6owckA29qCKo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDEzMSBTYWx0ZWRfX7hUNhCTqU9IT
 6OVaP9Qf3pyPWKXMUGcA8OC+drQsdK1crf4jBjAU1AuKFlwoIh/iQUwCkq6b0k6gngy8uaCyJzn
 HqeSxbtN3sas/J2TUeGLCbi+vpYZh2iI02hSf7L2ZJOws9Hn2Wvfx8wnKQC0u2QuzMUSrtWbfL3
 NJrgtmOblxE1H13IrPzwPzCUdIhm6hLuDMc3LkEJGHWr09+rJUMUGbxBgngY1eBsG5bbiC+UxaN
 4ks7Y4U0kiGb5LVL9+DEj2jhrMfDhPsTffqHERe6wKi1LwqOtUDVIUpXpBAEWtYynY90a/JuVv3
 VD4IGxNjceW6HZYOtQvZm3+7oCoMWLwFFr+O6JWGrFdkYDvPSixvrdNMCoD5T04ZXR7RMmQgnGk
 UJvVDWCpDEdJlz+yBEWjF0zwwo4sPAll5Xf4DW6pfH14vc7FhS7yluzHha71yjUfpCURSYI4/EF
 r72ZQxlJwoxFrejYYfg==
X-Authority-Analysis: v=2.4 cv=Y8FtIReN c=1 sm=1 tr=0 ts=6aa3c91a cx=c_pps
 a=UMwgOSM+WKnhBjpqxZ5HKA==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=ZpXbX5YHMAUVbjqxFjsA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: wmjhG58NekyVoP8YwGekWLwLl-TDZxpB
X-Proofpoint-ORIG-GUID: wmjhG58NekyVoP8YwGekWLwLl-TDZxpB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110131

Add the ti,tda54-uart compatible string to the DW APB UART binding,
and add a quirk to skip the RX_TIMEOUT dummy read on TDA54.

Reading an empty FIFO on the IP version used in TDA54 triggers a
data abort. The interrupt storm this dummy read was meant to avoid
no longer occurs on this version of the IP, so skip the read via a
new quirk.

Moteen Shah (2):
  dt-bindings: serial: snps-dw-apb-uart: Add ti,tda54-uart
  serial: 8250_dw: Add ti,tda54-uart quirk to skip empty FIFO read

 .../devicetree/bindings/serial/snps-dw-apb-uart.yaml     | 1 +
 drivers/tty/serial/8250/8250_dw.c                        | 9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

-- 
2.34.1

