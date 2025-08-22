Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419F222172C
	for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 03:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755833767; cv=none; b=eXOfh2iJLGNwvX6PfPjZWYSLO/bA0L/29MwowxX93OR2ht8TNFChTnJOYH4dlaSZNHPvHQEGnuOx2+b/QLcNbR2g2lrtXRijl8fgOmEtFwdeEWj/CichdLncvw/Dcpg8DZjy09EBAzW/J13yp0an01LtFKArOUt4LZELDt7MyqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755833767; c=relaxed/simple;
	bh=Y2zMtaMsNTAxkpne8OLb3ZDp9dLPFhE/RUov7T8zj9M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bot97fazW5MtPcOJpI9NqqsG5vixLwQCiauUpa0ODedW56Mu7jkwpIjLMVukRjk09gmM4iZ/ApbRGpBdx+nYB3CsyoATQ1HCE2qX08dN+kAjNfJmKbOSXC/I1sLdxi0AoBXj3mXOIx1oP87cQW6CsKeswonJ1gxS+JTPt0ERMx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=InwIfeIg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="InwIfeIg"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LI9BdY003079;
	Fri, 22 Aug 2025 03:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=B4TFvoiuoMwVV9xr+gL99J
	KjGjBwkKNnw5qIewqBg24=; b=InwIfeIgzf+poOIyPWAu+mgTlZ2PhUL7Lu9eyD
	KkIWVTczVCiifDI3pEAi/U+OZfZhp0YntnA9XhTWMpVfd+kAVyrlQb25l5kXTzPA
	+ijmKXcbLl1bMFSFoHqfvXm5B+k8Z/UDEu4jWkRXBO86iYE3i+XRAm2GrrOSx/in
	w7+Y/xWLoV+peMQ0sQ2qT+3p+1BFJ2NfoL7ut/pFTGfALaJMuKXrLqF+/TFGaHik
	pGREKC9rCZ6diWeClFIgPUzy45FfebOood3PeBUk3FrulkjgPQj7WlsDOwWjEs7d
	yLHmNQKEaYp+hI1VPQRfBMITvNtVB+X1ZdJo4ma9Z5YBVugA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5297p80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 03:36:00 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57M3Zxk2004066
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 03:36:00 GMT
Received: from zongjian-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 21 Aug 2025 20:35:57 -0700
From: Zong Jiang <quic_zongjian@quicinc.com>
To: <gregkh@linuxfoundation.org>, <linux-serial@vger.kernel.org>,
        <dan.carpenter@linaro.org>
CC: <quic_ztu@quicinc.com>, <quic_msavaliy@quicinc.com>,
        <quic_vdadhani@quicinc.com>, <quic_anupkulk@quicinc.com>,
        <quic_haixcui@quicinc.com>, Zong Jiang <quic_zongjian@quicinc.com>
Subject: [PATCH] serial: qcom-geni: Fix off-by-one error in ida_alloc_range()
Date: Fri, 22 Aug 2025 11:35:32 +0800
Message-ID: <20250822033532.4074827-1-quic_zongjian@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nHR8yM9bNAzngRznDALFH06ZgOnnjtNu
X-Proofpoint-ORIG-GUID: nHR8yM9bNAzngRznDALFH06ZgOnnjtNu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX3OSuHbHatUbt
 zfIq5HCRGJEpfng2+RuNnqoQd8nE236+WeVjQtySAIbhGSo+yuEF1jP2YRG0L6Go/htk+AM/zI1
 nHwnXmHxCD5a0Cd2TeN2ppHHpv0pWfVnUzeGUVUQyBGS+1L3XdJVgZTkAQivTh1lJ4es/C/y1UI
 DILQgj1OXC7xVUswe0PMTY2ci/la3KtmXIkr7qaMPXJkuU7U5SEVGxDO6Ym8Z+jhq7s9hJufxSq
 26b4kaPIV3O/FTMKAPv+8KjNL7JLrsfsDwO/JdpHYPtgfpn6y2zTT+OM+8ynmlY6BTeyks9jP8V
 L4EvmN6onHhATqHIaMomfJmpWkLmVNal4/6h2BD4fD17Qt0Bq7sSQCTO+9CPSUFRBDTpm9+bBAk
 swQlSvXIFrYrGaTFAKuclCfc3BokKQ==
X-Authority-Analysis: v=2.4 cv=SPkblOvH c=1 sm=1 tr=0 ts=68a7e5a0 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=roy63ODkg0DyNSlNSiUA:9
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_01,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

The ida_alloc_range() function expects an inclusive range, meaning both
the start and end values are valid allocation targets. Passing nr_ports
as the upper bound allows allocation of an ID equal to nr_ports, which
is out of bounds when used as an index into the port array.

Fix this by subtracting 1 from nr_ports in both calls to ida_alloc_range(),
ensuring the allocated ID stays within the valid range
[start, nr_ports - 1].

This prevents potential out-of-bounds access when the allocated ID is used
as an index.

| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202508180815.R2nDyajs-lkp@intel.com/
Signed-off-by: Zong Jiang <quic_zongjian@quicinc.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 9c7b1cea7cfe..0b474d349531 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -271,9 +271,11 @@ static struct qcom_geni_serial_port *get_port_from_line(int line, bool console,
 		int max_alias_num = of_alias_get_highest_id("serial");
 
 		if (line < 0 || line >= nr_ports)
-			line = ida_alloc_range(&port_ida, max_alias_num + 1, nr_ports, GFP_KERNEL);
+			line = ida_alloc_range(&port_ida, max_alias_num + 1,
+					       nr_ports - 1, GFP_KERNEL);
 		else
-			line = ida_alloc_range(&port_ida, line, nr_ports, GFP_KERNEL);
+			line = ida_alloc_range(&port_ida, line,
+					       nr_ports - 1, GFP_KERNEL);
 
 		if (line < 0)
 			return ERR_PTR(-ENXIO);
-- 
2.34.1

