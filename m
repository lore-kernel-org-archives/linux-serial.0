Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32594718CF;
	Fri, 11 Sep 2026 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118757; cv=fail; b=HySq8T8hvP5h4ofl1MQpWVOkmN9PvmloZmAwkQnYdaV7quq8uSC6GDltIlCDGoNeM//WNsX/TT+Zwa0fW3cPxZ1XNh32tQwXxwJS/06BxmS7kQIz2FirK7iAiiFSuy9kjW2hASimoKORyI9rdk83tDVYa7JTm1V9yf+9hAljvxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118757; c=relaxed/simple;
	bh=9ktscHcEiGbOnMlSWGHEg1vMqZ7/UVoGi4vDkesapGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGljPAxS4BxztGprYNzDnw82vQBF+8kPNKpYv8cQRrALCal4GXlbFbzP/qTltB1ps0ITynxT0tJ4Z32MQAMTKHSxaYBQX/RBNJ7St+BMfT4/0qw1vf3RT/vZ04f1IdCcifXuEa2AfPFTz2wQk0VIJuOuvddG+g/JbeQveGooLi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=FCcjp/yz; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZxjCj+61; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="FCcjp/yz";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZxjCj+61"
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68B7nqIh1143826;
	Fri, 11 Sep 2026 04:25:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=pFYHA3pzZBPfbyZySmUv0f+uHxvuzfazZOLif6KKU
	mE=; b=FCcjp/yzZdrICgPkuYMNzTJ9ocdSybFcKLrd0BN7ILfooUiR/AFMlVeyM
	cP6ZgMHElcTnbM9115UwjLlGjVuBlwAhxmotnfox4aW3kv3JT9/k6c+4HQJcuLmz
	2G79KudFI9LqSN/L/Oh8/mEwOZqbEetdhnw+CEQf1MsBLKvlYEkSDpARwgnRrk0y
	f+IEh4AzR0ywk5Qi8Isyb2rkhBwUCVzDaGa0rkWtIoXx2+gSa9jNTXjmEhVR+N6A
	7Bwnrz2egNGn+pQX88Kj5IjagzK++P+UO1DrxsqQUINOvTFeLV4vqRThU7Rfpuj/
	aD7Ia3LI+xKcQfJGudn9PRh/6fvFA==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gkyx25735-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 04:25:50 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MSyZtCGbkTyv+4N9GvH58x0XjuRIWeVba1xr/bMIEBZZS4V3cs0KoR51111A2LWQVLPPnFX0xCkwFMyP6ohIUuWIR5cyYjPnrZ0CILAiRoBXkmKoICu/twLTYx6B02Fj/dkDve8caAHvd5tp4vQby5+MDMrsN3puiv11bTiM+z/9m8uM0BTSAYA0MH+67ynzEELfciPFQyu1RDqYOY0ZKYPuL7cFCRfPNVilKBVGcJb1rrb6G7v3MJ1jn2iJX7ko/qjIvqXyY06oQTyz/xcqCxfAk9xK1fIYiYAyT++TKxulrBBjTlgAN1cWNtgROCbuS+VJN9W8UebZB+QAmWYlHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pFYHA3pzZBPfbyZySmUv0f+uHxvuzfazZOLif6KKUmE=;
 b=v5Z3CQ5fmtMgz4+8Vo2oaGflNeSBd8H2eKMGmeW8ZWjDZoTqSYjIhYZbZ0hGU1tYGnuTu5aigKM8QKyGaUkF20cloi3mLzc0JGLPldlKzrNzth0fbFkkDTzM4A2xPymDseKiQcIkSEjbegidHhg5XL/Vbxzsbac9MhToSZRlsTwGGffDMJy4NvFtTd/PRoCz5kXtMUL4ESAiYMncl4yRJUagOEiot/hn+9uNGDF79sPvP/1jLLjs51z4G3atRIU6JX69V1O5uYWQJopzoAvIaECRgWNubVr0GzTlSSuuf4t6QiDIOPMDt2EjNCYX/uEmpz8lrRCZKnNA7PLSMWuPQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pFYHA3pzZBPfbyZySmUv0f+uHxvuzfazZOLif6KKUmE=;
 b=ZxjCj+61nKERoSmvEtawuA2EjbjhdNliawhKNiLmhjcAitSAlpshxk2MaOxcV3wJzWGuRjKWMtaLypSJvWAv7N2iDP1fyB87ON4qRJi+YyZtn00uKc37hUH07JqS1HaTSeNWuImrpT++Oiz028zbiC6+BM2/HlkMRsft7IpXTMY=
Received: from SA1PR02CA0024.namprd02.prod.outlook.com (2603:10b6:806:2cf::24)
 by BL3PR10MB6138.namprd10.prod.outlook.com (2603:10b6:208:3b9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Fri, 11 Sep
 2026 09:25:48 +0000
Received: from SA2PEPF00003F61.namprd04.prod.outlook.com
 (2603:10b6:806:2cf:cafe::2a) by SA1PR02CA0024.outlook.office365.com
 (2603:10b6:806:2cf::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 09:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SA2PEPF00003F61.mail.protection.outlook.com (10.167.248.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 09:25:47 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 11 Sep
 2026 04:25:38 -0500
Received: from DLEE205.ent.ti.com (157.170.170.85) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 11 Sep
 2026 04:25:38 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE205.ent.ti.com
 (157.170.170.85) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 11 Sep 2026 04:25:38 -0500
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com [10.24.50.20])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68B9PTqN838879;
	Fri, 11 Sep 2026 04:25:34 -0500
From: Moteen Shah <m-shah@ti.com>
To: <ilpo.jarvinen@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <krzk+dt@kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jirislaby@kernel.org>,
        <devicetree@vger.kernel.org>
CC: <u-kumar1@ti.com>, <gehariprasath@ti.com>, <m-shah@ti.com>,
        <vigneshr@ti.com>, <nm@ti.com>, <a-limaye@ti.com>,
        <y-abhilashchandra@ti.com>
Subject: [PATCH 1/2] dt-bindings: serial: snps-dw-apb-uart: Add ti,tda54-uart
Date: Fri, 11 Sep 2026 14:55:28 +0530
Message-ID: <20260911092529.306082-2-m-shah@ti.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F61:EE_|BL3PR10MB6138:EE_
X-MS-Office365-Filtering-Correlation-Id: 938e51ac-d486-484a-2454-08df0fe6aa04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	1zZStYnx+dUxuWRQ3PrQENO9zVYMEh92k/K63xi7qcR5MpZveDr7z+Xcqq5ScYDmKAEeUWvMOPXSstMEXYq5BWvPEwuiVmSgJN2z1HaZxV5CHwol5ZbYAx6MpaRvk9qLo+pCmph/ySUfCT4kOQaniDgg4LKEzBQV08gZXBhnNHKaZXcX1PvjV/jJag0/B5o9Jb6CXrm7hsF8psZFnn/PKhAPqvVi2EK5VdSah+EubsEWVKo4qxWIzpcYOfQ8AP0J3hBao0djxleu+A3xk+W7R9JGdNtkudy8Q/zPwVVemXWp1modyxiobpzdhv63tsJ6hwcIvqHkXRwHfUIO6/WaE2ra/TcwgN7Ho2MTdGx8t3Ak4N55Guy2f/RKIVSr34Nj0HL2Gi7Z+7aHlFIZjOVmb07JwOM9OozppFqxB93AEkWUrPr6cDDQO97Li7jPIQUgp+Aq7ZwcWRwHGNec1XzBZ/5IZDuO1gMDHuUtk+QZm5O4WFwN4DNzTPsYkV53jrh7ennNyS62lBvT+U6Z4ezb5Q6t2e+ONWhZ+xX60slOstfrpKIoTAdLKPlhHlafFpUxPNoRCjmiikA7YQmcwI3frSpetHRUbPpBBn9iekfsjB1Uc3QpDn4PfCU23WcSkAg0C5PY8y9mzoCcBev0PxeamHkhhxsNYtz4fSFV29UFgNorv/ci7PUeuXZWEn6yQRWzbNYZWFEKefZIDO3mVQ4tHw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	L2zT5fK+EBd27JMaazFLOWdPm/RfArQ9AwUoryHmNMx4tSMJyF9NnNW8J+ZDewu0oXL9Wo3PFAPkzUOSmmEzKpuXjD8xvONvbl7UjnR9mEq50PSDRb0JyGb/B7lrcAPtQ0tFhwGRpBAYLdP9+7ibrnqBo8eK3rXm0ogYIrx7iB2y68Gw/TrJDWl3b9HZS19okEJ7JeLMfCeRyJiSzQa6Ksfdbu31Ew2jTZpTcimOLAchRK5hmaEoC09xjK+Yv+YUfzE4Dd2WFV7hS0G8GDxTlXOm0jBqgK8yGkxMg6hwB0vc5IlN2S4YIXHpKKna1U3u6ANqNOH+MB6n+VvizJ4Cafx363hs8k7KK2cIvQOSQm06sJU0U95rhWX/6Tb1mxabFU/W9ixmyGmoJnzuZ938fyhsj5HppHRY1v1cSRt7Tctx11s/J/DQPjZ4Oeztclqr
X-Exchange-RoutingPolicyChecked:
	M1XWPTcI5YNXC+2JyVRrr3nmGnitP/ZC7dIN3AfUa+A49c9VH0kHIp1EyASHL29YAvzKcc+gZBDQY/Wz2166W2J5xrzDu/57jCihl1Vil7ON3EkU8DGQpiS/z62XzW8b+0RX4QuWB+VJv2LSFZh6kuqYeHq6oiGEoU091SjvLZd3vSIICInLOAyFl07Hfvpmr3y2kd3Osmmvck8Z+2XXodvbbfsGiVsZcMDsyTE3eI4p+wU/BcsOedtLCgXXB3iUPQdC3kNUdkOZW/JZVn4cF7f8O9zVsouhnVIrSJtKaY6MPFeqLSDnzKfHdATb5PucPw+9LYyaNpClFuPG4E8gfQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 09:25:47.8435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 938e51ac-d486-484a-2454-08df0fe6aa04
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6138
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDEzMSBTYWx0ZWRfX2Ssmaa8gpXBn
 aJm+rj7JiwP4PQpNmI1dmUqa4JDyGwERviVJTyDRWQ3AzZr2FMHOUDBgPM29xTCIqjjzs/nqGbK
 aOSTSbXbYRWg2gZ6RGKod7y635ZFgC0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDEzMSBTYWx0ZWRfX8rmr538lj3Eo
 /wE2sapjf/jPBf+nqZmQ/6TkO3SPXNX05arsr9Zv4Xd6ENtenIt27JC9GHigt0fqtS5zqopZsMU
 nmF7Ix4rfTnrpqZ7yXP5GxJ2rRdJQCSQup7ptW4uU1Jbp2oPOpmWx2r2VJ7JFq4fanU5sPOjB86
 mMMzK1RE8K2QXUnQnCUw5x5USQuwDHDphJyghK4jA74Z5UWVZGWNXp3NvCTnDGx4h7cMr916Fr1
 dmi2w6VYY4I+Ewcg2QuXHOlX8pikF5UiDEZwKFKCrN4O3SwcJ6nr8oY3VBpOATttaWxThAd/HMc
 QNuvxQDzpFWqEA32QZ9iiRmQG74L/5LYmmf6Vs+qcfYVDQm/w89qgoZCuZwLu+H1lXi5+iu2uX3
 1MXX0kftXMTlEtqagGevlteIBJL5W7L7T0rYVC7xmrmTWrlN51Zxs7Jmd3AYsKKMhKzp8VGICsu
 ST5ChiJDrmqhdbdTGGw==
X-Proofpoint-ORIG-GUID: ZVYCpRPwYTLD471xwFKbbmgpFn7y9c3w
X-Proofpoint-GUID: ZVYCpRPwYTLD471xwFKbbmgpFn7y9c3w
X-Authority-Analysis: v=2.4 cv=UJ5Ijyfy c=1 sm=1 tr=0 ts=6aa3c91e cx=c_pps
 a=qaGWf3H7ZUycNCJ7m3WmPQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=7XQQQQFb1Nbzf0LZnHMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 suspectscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110131

The TDA54 UART is compatible with the existing DesignWare APB UART
binding. Add the ti,tda54-uart compatible string.

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

