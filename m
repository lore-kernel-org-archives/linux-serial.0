Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218F147C0EF;
	Fri, 18 Sep 2026 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725863; cv=fail; b=ehwLL49gGy0+UPj5a8pKKwba/0doU56/PlLaAxCzB5sa1hpsEvkLtzRJxt0ugBFeCwX2du0yXPVeDOOOjFjXx2A0FInOFtfqhPmrBVvGLeLz2jaymJa0lrH8kmf8LrQAMdCp43UdcO+QSRLwrEoObFsmxtoSqktHKa9PGDpDHF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725863; c=relaxed/simple;
	bh=sXVDu9/7XdqspamDUVg57lPf5BxeX3Sewz12HoVp0GU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DnHWCEhaJHB35gvISU8g11GVB5mXex78kZEgklVoROHQIOnRXQU5bj34kpQUW+0DW4DXQ9JrV+rdVI5uzAnG2CU4QLVSVnRwbVNjc8PnK61sunu5gXnOKh+LK72Yp9/jHCXLaIsrcdYsZpu35aVmf6qVJQ84Cx9leAmAP4T/xII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=o6l7wotL; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=USAqkbSL; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="o6l7wotL";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="USAqkbSL"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68I9dBoi1233790;
	Fri, 18 Sep 2026 05:04:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Q/q/MsYhVBI14lkNHSa9jpQQVSQk7N6THMQr+IBlg
	OU=; b=o6l7wotLc+4e5++VEtGp/suvWYso0W5Vl1nqAMjLmpniBkGUk6VqXtz1e
	YvXsr3SL004YZCZBYn8PePF9LkdA6rS4CVHqTr37R4sa1kWrAbsjop8KCPUR8zY0
	/LlQb+qe8+0HiUWsQl3RL2MoVUxun42ZWBXm78dlO6s59927YhMPL2a0QQw3Ne9V
	IznfjPN5PTXLRDpzinKmixfilRThgJFxp/eT9Y0iwlxyyzN+lBpzHNd+F6Mgju/v
	obVI3Uo77b+NQgX6v7NosvZ52VESgw77bNeahf0/Ba16ZflNN7jcPEFGTvCt6H02
	T+N2vh5nCqb7cLCCzVQHO6bD9VNOA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010063.outbound.protection.outlook.com [40.93.198.63])
	by m0384305.ppops.net (PPS) with ESMTPS id 4gs2ux03ux-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 05:04:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lL5YSObW0VJHVQCYU40qkAH+eKnFLOvOOTzIRr5DSVxxx8E1s716WWQkUlJM6Q8NMmFvzLgUwqIrpj7EywGsy3EFMsMvOiB5QeQHSjH9k8tbXN61z/1dceFMvaO4cRJH9mE/LU04wDlDHyEwliqkhbAVycMFszsu7smdctR4GhHfr12WNK/V614CtHRfZy8YYpbotrp70tT89bPtJTF8nGJ33GRoecvD++hSf3JiWCKAxFHgJEiAbRfTnTDk02VANq1EUUjcqplMlrTsWUFCmZiIQKCaWysZkzPwTPtOQvABUm/w2TzH9pxyjbKEvgfp5ZAUPpmfZ1LEpDjWVM51Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/q/MsYhVBI14lkNHSa9jpQQVSQk7N6THMQr+IBlgOU=;
 b=iTlbfZh1PbxivrR8myPjnJmydzwxGIvYGNlZs/CLe7oYQ15PLasHO7mRAVfxcZ1fElF/71LEhr3X4QSt94poVNSshONQXamb6JcEivICtg3NOjldqFURld/Xt5Xpw1Agm1VBaB2tpSiV6UnDRn7kkmSACfeHmxX9vYPphEmqXecq6nTHMkKjMl+n5RbXykqCqvmgEtCVI4NoyBc+eoCTTysjZnfP6pMSALRMO8ol9u9dLcYGtsV0pv9U0ht5+x9tR3LYkgDJQ2TH1uMzZpAdDLTuqvLz5WyjLF0dwfUfDcBR5TOdb5et/PDUV5CPjjcPsKe+/4lzro/ZD3JEj52qwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/q/MsYhVBI14lkNHSa9jpQQVSQk7N6THMQr+IBlgOU=;
 b=USAqkbSLlnULdNzukD29L9k+3q+/xWU+3oxG6tmHuV9K4MErV67pjPj7dTGYgxhuXOZDeuinHTWREwHl6FgufkW/ywuTS0X5gsSpmtA5o6NdLwmIlaPpGkGgoB1tyXnowlc97Xjj3caSts9jK6kC601MP/bKojCZtETg8I0pGE4=
Received: from BN9PR03CA0361.namprd03.prod.outlook.com (2603:10b6:408:f7::6)
 by SJ2PR10MB7828.namprd10.prod.outlook.com (2603:10b6:a03:56c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Fri, 18 Sep
 2026 10:04:11 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:f7:cafe::a8) by BN9PR03CA0361.outlook.office365.com
 (2603:10b6:408:f7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Fri,
 18 Sep 2026 10:04:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 10:04:11 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 05:03:55 -0500
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 05:03:55 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 18 Sep 2026 05:03:55 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68IA3k3K1507569;
	Fri, 18 Sep 2026 05:03:51 -0500
From: Moteen Shah <m-shah@ti.com>
To: <ilpo.jarvinen@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <krzk+dt@kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jirislaby@kernel.org>,
        <devicetree@vger.kernel.org>
CC: <u-kumar1@ti.com>, <gehariprasath@ti.com>, <m-shah@ti.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <a-limaye@ti.com>,
        <y-abhilashchandra@ti.com>
Subject: [PATCH v3 1/2] dt-bindings: serial: snps-dw-apb-uart: Add ti,tda54-uart
Date: Fri, 18 Sep 2026 15:33:45 +0530
Message-ID: <20260918100346.4044899-2-m-shah@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|SJ2PR10MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: e84964c6-67ec-4d7e-6ece-08df156c300c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	kLrJpUPRKsQU7C5kVSiHtJG7pvuAaHpmTwXG8YiH0JvAphV0Yc2R1JHLC6kvlpGXtmzccNt4V4y6HzhzW4a/1ufT746BeWQP5Su3jEtYs+j1FkqPOmdlsTHFi13j7lAX75mI+3EgvXGmma4nBicvS6O4uUHG0/OCjHEL6nH8kGGrWKKKCDoAwKSptH4z/ODo2IEvfECb2KMgGYFCwTZdrtwYs/UStNZSobp0eEcPAJEgw73JijdhO2NJTAzkdZRy1Wo81hwQpFCwFMlpaC2Rl40e9kY/YJ7zlqIWNFd3cfk8ftURpSkDF2+9Zj1A+de51FAGptDYv0rj6iAkdkzdZMi6VJ5xdK5C0uLTwbxldVIqzMfJ3/rYYkwHdjWzRn5eveAp8gLpK5Ee8sYHUkAfVDrXpsVrZYJ9lnENLFW8809FcAhHgcK0RwaykPI56rfgQlPEEOpT1Tkim+Iyk0jFtbG4D+KDSvJf2FcRdzuAs7hql3LbpNLMF01BlRjdCP5kwYhLp01A0w1KpEv32JWYQodU5tMZ6Sjh3mn6K/VpOnUZHeK0lOCwiEzt17oAqDlyE8Iu6q8do1GgsZ26NW4W3zM2LVt494RZ7snCFKJsw5kE5twU7bodowlKq1C5SiqVy6IB1A+7Ft0ELBJFS09P4dMR7kz16w9LwGVp8cUd2Ww5QXsB8bxCaHAaC8wVdQUADQ+ozD+UxP7o1b0y17/lgQ==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kcbT7i0WT1K57pQ56Gslf0H1EGVw0UONqtdJJ7DQpIrkjnitArSQdFK3YHVNsUpjEhQBKm3v31yuxCWhos1KqDHkhGmAQNXgZy2kkoTJpjerXByofNL2RDeuoaHgkEDSFEiPIPKEftuEUMyDLty46esxNWRdYN5dwHsopu4HzrGzCEfGyXTN/1SdVNjtYrNbfk0oRm/fcTjKLN9w7ni7Mz9QVLDeUJGsi2s56FSNX0KFWqbWIZzWZvyx2IRAJEGgvpFPj9Qetvdt3onZs0akGQjsI3d1yGdMTVVgz6IUo2nkZU9E5Rzu9rffXBq4ATp3CaMTFUPTO0jySpti3lqlshm+98HOvs6o8u05cfFCoDMhvEaXbBzFT+JUH1GpNObS+0YYKZPH+dmMGYT3LBfwhyNMHeLW0uGGfo2WoRfg2XF7LJRwZXxgp5enuZzULmti
X-Exchange-RoutingPolicyChecked:
	sFjQuJq5G5058BqK9HO7oFCWB2elifym9LGE5fRhmiLpAjwqFHBBqqI5oHknPuzbyxnHp+Tpp4IP+DaBQG6nONXUUpTnlgBqw32/VvBCnT7ns9uXBnfnKZp4K7TR9fy1RyrF1RIVRUE0ZhsQZd72jno8DrgLK/Lx2eU/sv5SFqmJ0lWq271tl2QAolFTA7e21Oef/BzvkVf7LxEgU15YCwxBjHCXw9fce+sTPtoMigsdSZJQmdqlZN33hsRuBQXVX3QbQmxmO4lbmC2YVl1aCKIjTd5PM3akF2XlkEhUub6SEcTWzghr/ZtyLMAuZETgs9X3v71xuQM+vqSwb9OFiw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 10:04:11.5393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e84964c6-67ec-4d7e-6ece-08df156c300c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7828
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEzOSBTYWx0ZWRfX3noTHa5MJtyK
 A1ZHzwwXIOxIAbYAlm3Ihvn5JyEo+/p7IJ2BXhJRwlSnqddDphQgFkA5OmJHJfRIsGh0CG3dOaw
 +429aGfLnhJb6fUtbjMaorMhW/yvm+eYgKs0ZUncrUZnGXtMo6pAXX7ODAfF5zr8lsJbWlgYFfw
 CYNkYJ98mS70GUXBS0UejnAtrGUirQVwsdBZjSU8LCNC42fmcQLVdLVzhzf1x8rBobnH4CLJssc
 kew7RlKPk3WBkpaVwhL5uXG4TjSWHh+mQ3uEziRqiqHX4xBi2agsUq2pEcM43akR9S8BGvTPjFE
 3/Nb+GxKxjHXyhc64NezhArCHKnrF+C7LFxnQwYToahqsxv62poZW+unLPKGL6P2rxgC14D/7ah
 gpM5ytb/59hIpNhMH+YwvZY0DhJT5jsDyGwj/QIeCxssn64yrKMbYRHybaJo09u0UutxLWgnVwE
 LoOi3NC8kMbnrmjl2LA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEzOSBTYWx0ZWRfXyLZ/4xjNFMqX
 t6vdergoUJepFuZNY+Y6eIu4vi0HnWMMpPckrDVFW0L8UVMZIFi20RVAiTDYrWTosAoyvsXsZmB
 5VnABfRklUojaVMFVf5Z63huT+pgUb8=
X-Proofpoint-ORIG-GUID: 4xDDlVJ8Iy7LntZEL-txIDjdsG50a4_U
X-Proofpoint-GUID: 4xDDlVJ8Iy7LntZEL-txIDjdsG50a4_U
X-Authority-Analysis: v=2.4 cv=adH0Dhot c=1 sm=1 tr=0 ts=6aad0c9e cx=c_pps
 a=nBoeifw3k4y6eW1CqgP3Vw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=EUspDBNiAAAA:8
 a=RgZSwAj9Bg2h5l3Or3YA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180139

The TDA54 UART is compatible with the existing DesignWare APB UART
binding. Add the ti,tda54-uart compatible string.

Signed-off-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Moteen Shah <m-shah@ti.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
index 664305de4986..86dc25919311 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml
@@ -80,6 +80,7 @@ properties:
               - starfive,jh7100-hsuart
               - starfive,jh7100-uart
               - starfive,jh7110-uart
+              - ti,tda54-uart
               - ultrarisc,dp1000-uart
           - const: snps,dw-apb-uart
       - const: snps,dw-apb-uart
-- 
2.34.1

