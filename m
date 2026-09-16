Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97E0483804;
	Wed, 16 Sep 2026 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789548995; cv=fail; b=t51E7nN6FRvpjVIRWX2UEXkVF1QAg7YhCbNG3BDh/dcpJoYLsOZRxm5edtTWxE6+8Alcw1jCS6sVzikn+3TPSGO40pbGR96EqIBnpW0qb2uWoiIcXmh61OPf1SV4N9CBZtsyVNJMEmAWFX+sB2aQkNdXueaOQZmHMgJqha6G/J4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789548995; c=relaxed/simple;
	bh=rwevh6k69p/B3Ji1kS5IpvWfTlTjnBoBvxaLK/jEujY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1N7ZtnNsPWlZSNL0S/DJxIyKZa66/ubDaBkOvazyjDNbrlA6ny3j5dychtxxr2u1Oyinut+l2QWALPocQ4EfW3Y+ukUtCngOTWHPJgDfkmW9HoRdo2z/pr8018x0U3PPyy00lqrF4X5GnbAuOcJYnLCJuvoYlkkPTfk0zY3G/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Ua84KVSo; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J77F+x5j; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Ua84KVSo";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J77F+x5j"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G8Rr8k2707762;
	Wed, 16 Sep 2026 03:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=M7d1mBfQZUbU8y14KFFOTI5Z7xCZjoAaKQlPFNRpa
	+o=; b=Ua84KVSoh85jrcBXcICMLDQit4Qqc6DNHm9SB5j3bnFYdoe3Z6IGhMFlz
	2CIKXVJWxNsSCjg8T9dqzsyUblQlZWPpfYnZPJ4VzXv+0S7CfO+rZptemVo0q7kh
	NCoLBSdqu5TipjMd+jqpfcDgyq1IfuBjD9kgFUCpqQb6Y5n4CPxVKvm2drN8NJ1r
	vxN2hibJf7J4xFx9/FieLd6xuW4v9m0iuJS0qfV0smjXFDiRPcjEOIQz/p65TJuc
	b0QxuMw+jq//PZvwDIKGmMmT4ZktE1xZ2xoJSid+js0V9sbwNRGilrAJQlqxYs9X
	vH7a3/pUp/T+psaEdSab2ZIak9EzQ==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gqqmd84u6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 03:56:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnbnVbEDTQOWkKx/g8KZnkouqF1JvjKK3iFazJWxuF3g/Jele5a5saGT4wJvHlmEE7eN8pGMvWF5utZoAM2hnh4/1Q8hFEXYxQguy+zj0infD6aCGa3FkfU64XJCJcQPNdLOP95IhiX6vuqkZxD7wHQwY/uMdiQkedtFFxbmketqLx1gAxpJcTmUO741/eZqG8CV2Tf1etxcjmxY/iqaYR6g5ur+ogW0Yb5A+dOyoWDDFOMLrCp8kKOyZjRBQoyALz9sPYXsh9o5ICgHgRT2OPIQLPBsrbycPIhQLT5FRDQtyilMyDll896e74cwje9eNOFU5dM3sUq0BYiRexW8Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7d1mBfQZUbU8y14KFFOTI5Z7xCZjoAaKQlPFNRpa+o=;
 b=tGYM71eeb8qRKoezj7LNtYZM3idh5yDGdgt7JWGhta0umQ0vH79zCHW8RxA3DSuOPZTrKobOxs30iIGd5uP1IDK3DUXYUk1CNsH3pysyVeylzQ8NtvUdlkI1MXAU02n3vSuMNrpVbcuRz7YXkR87CIOqFtVgY9h8rnFCgS7nSfeHh9U1YU1FLLWCDhIzbi+j6O8ML9u+eFkgl6S5cfDSmqPOqDL+uhM6ChiV/QkAzL4hP/jnxCJcwppo60VdU9P+QHEs5mp11b3MhGN+qf/X8e7epAS3bnBxuyaCJNUK6R2GuAjmHAMSimAorxncMgQXqJXMPOI8Wiw667qDQRsKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7d1mBfQZUbU8y14KFFOTI5Z7xCZjoAaKQlPFNRpa+o=;
 b=J77F+x5jEE7qwPXLKn3Ue/y0RQ2/o+PTUBMf5yaxQZpPj38dxunJxD3HROrrxDQKxvbVMxRB+/mnpu8/xmyEtH/EFSiqjKE5WN77dLHU4YnU/yRZqpv8WK3dfapW3grpg3WRCtmZoJT99zkxQ2NNS+h5CRSqo7C5OYYyCZykiG0=
Received: from BN1PR12CA0018.namprd12.prod.outlook.com (2603:10b6:408:e1::23)
 by PH0PR10MB997665.namprd10.prod.outlook.com (2603:10b6:510:384::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Wed, 16 Sep
 2026 08:56:17 +0000
Received: from LV8PEPF00000068.namprd03.prod.outlook.com
 (2603:10b6:408:e1:cafe::7f) by BN1PR12CA0018.outlook.office365.com
 (2603:10b6:408:e1::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Wed, 16
 Sep 2026 08:56:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 LV8PEPF00000068.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 08:56:15 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 16 Sep
 2026 03:55:29 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 16 Sep
 2026 03:55:29 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 16 Sep 2026 03:55:29 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68G8tKwF716870;
	Wed, 16 Sep 2026 03:55:25 -0500
From: Moteen Shah <m-shah@ti.com>
To: <ilpo.jarvinen@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <krzk+dt@kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jirislaby@kernel.org>,
        <devicetree@vger.kernel.org>
CC: <u-kumar1@ti.com>, <gehariprasath@ti.com>, <m-shah@ti.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <a-limaye@ti.com>,
        <y-abhilashchandra@ti.com>
Subject: [PATCH v2 1/2] dt-bindings: serial: snps-dw-apb-uart: Add ti,tda54-uart
Date: Wed, 16 Sep 2026 14:25:19 +0530
Message-ID: <20260916085520.2259420-2-m-shah@ti.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF00000068:EE_|PH0PR10MB997665:EE_
X-MS-Office365-Filtering-Correlation-Id: 195f966f-5e9f-48c1-b2fd-08df13d05d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	/FoQxIxE0ZUqJYYCfgOuV23NQUy9/jXT07Cw6+/TY38ZhECcS0w35nsPq4ueKBbajohbTyZzICzofMFQrBiEe9E2nN0E33XDhdgbP/boVDSTOEWNPiDf74KQg7FVAVFQMSIu55HDdpikcgNT3aBVm5zCy7NwZf+8v1YvF+URk4IwjEV6zLYlRsXRySDOeiogb8wba1tBlrK8OtVS45HDmwA7ASC/S7gV3HjU+6EO+uikCi76cdcZ18Ja+ebv+FY7v1ZR+kkc79ISdNFdhX8Mjaylm5H8VCqXFAvVbrJOI3o6raDx/SFMTUyTf597ISu4NlFX1++FIuv5V0UCKZO9DKrns+NU9DRmpdYS6yv+WTZ/esfo3pOITegbeFT6PJjuRkozvNVkcsufYemjBMwF0DUH7PMPOZvfvfwMpmEgPo/dJKqGvjdzB10hwmrwe3u+xDdyWRKLVPP/zs4tCzo15Dc5TtlPqly6RQYJUHwhnFVO/iCklS4XLk+TAXUorkOW9D+/fN4qLfKfhsTLM+3unOhpda/hBYIYsUFZTlafkPP7Ag8wlNAIS4sGSMV5xbOg3FKvMAuczM9kUDmD/Y73p8er2WlILA0Ir0iYenSn7+giNcr6lPE57v03EouAkwEk8WwGB7dDeTm3NSl+WB2vJoUxJAfUitl/2CGmSDWPSjGPxv/BIscNAMSSRjomLwGiREJaDrSbt2fWwxzagXlTfw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0eVwAVKRDagnJ58JGhWiF/hnELlA8aROR44I0YFDOd61TTboDyh8u8rbHkKtBIqj08wAxTIlegwgv1DdioHsUDSpado0004zhsvt2c2P70n0u+o3Ap6YOrzE08KQTIixyDK41RwknVo8IXXlx8Vp46DMZCmomkCRKbSS6mFq6ZBeIVqUHVIXPxD7fpfxiEcFR7YJwBJ3zLJaGZwJUA1AtP3cg3R0xeADaAL66Eso1BtZJS6RIm5NIpw32iejTo1Jb6Q6JaGTm2THMQa88TbLlVykNe22Z0M+9txFKzLEbzbEuBr4MccH8ykf5y20GE3bXGy/agXKhUdm/c+bWm876X5LZ547v5jzR3ML5xLw417gLYmD/HNj6W2FbA7KjKm1VMvHAgRTaAJrCnkM8VObcBokSd+oe3dUqtqsyLMlxEjFv2IRohvopAuu2k129iZ+
X-Exchange-RoutingPolicyChecked:
	0UU5qWKsVKoBgm3NCKTsUROOFb4/Fql0GrIitGrAk2/qXe7HkWQsHLqSXzxPXSdenrABwBqR21WlTAav8X6YYwGAMulWJkfcbisfQF55nPw+XCQPWaM69Nkic/EeA6t9SW3WqTi7OJXKXuVqwiKeMxZd4CpTQZfpc7RDWon1CqJ0YYNSWVgMv2c/88tvzwyKypra/cHxrQXcZmuNl8cRG/M+9ZmQQAlSPP+a8R4S+fEm/ZnpzghMw/4RTneqvdv+LAC/y1nEPXYPREn8xm79/tgRk4JfI0HVj/k4XhD0nICWL/StrwINLmJoqxTxtlveYGg7nhBW/i4ru4ZvvcQNQg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 08:56:15.2209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 195f966f-5e9f-48c1-b2fd-08df13d05d8b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF00000068.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB997665
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDExNSBTYWx0ZWRfXzVu+frFjuESg
 DBGX3TGLKOKcSd02OSQ1ZqB6tS0d058bb2zI2l7KR9LZ52/Pk9PIAOU6rp3vpjLaQlDZb1YwIw8
 qpNCfipobBj/JJh/ZKY8yW2IrawGo4Sxrmj81GVSRkMIompmuS4+4SjEaRsuACxUQpHGAM5Icqh
 qz97oZkKCybNd1t6DuVgWrs7ixFsct/UehqKvZjxSrLlAWQm4Jocl7WdF7kcK/E0j3YKe1gG8S1
 Lv5T/V+hQurMeJZLVce6emQq6AgjFqsSOFO/TgzxhbL7qpjFR3uqZWSiN7GjBhAeYRYU4B3/vSZ
 kNMjhneH+Nauki/bfpX7ZdmiMkrFm+sdVZ/WQ2ESEqa8NjSpr7se25NB4S5ymL/FnekaBGYxU/i
 aIkJ/NuvAqqmwheNLWdA76VSMpn3L4iOAH4sGKN6wS6dBEAC8SAqIQFBhDyzUL0nfiPMsDevBoP
 7ajM4q9lXkeUoprf1Ew==
X-Authority-Analysis: v=2.4 cv=S6JMU4sP c=1 sm=1 tr=0 ts=6aaa59b3 cx=c_pps
 a=tq6IV6p/3TsKmbatKbZ8qw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=EUspDBNiAAAA:8 a=sozttTNsAAAA:8 a=7XQQQQFb1Nbzf0LZnHMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDExNSBTYWx0ZWRfX51g9g4hfJpmz
 zmAieg2CGFrnsBZmpGIVG6r8Rj5NFyFiTcW0Uacouu2GmixVr/w/MaSjk0dgqNyXAoB+O04JrYI
 nVymDLiJRQ92u9HagX4zoeamE20+HOg=
X-Proofpoint-GUID: WW8twShfQ4EgXrK4QKOchtAZk75LkmHf
X-Proofpoint-ORIG-GUID: WW8twShfQ4EgXrK4QKOchtAZk75LkmHf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160115

The TDA54 UART is compatible with the existing DesignWare APB UART
binding. Add the ti,tda54-uart compatible string.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Moteen Shah <m-shah@ti.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 49f51b002879..518c899c52d1 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -78,6 +78,7 @@ properties:
               - starfive,jh7100-hsuart
               - starfive,jh7100-uart
               - starfive,jh7110-uart
+              - ti,tda54-uart
               - ultrarisc,dp1000-uart
           - const: snps,dw-apb-uart
       - const: snps,dw-apb-uart
-- 
2.34.1

