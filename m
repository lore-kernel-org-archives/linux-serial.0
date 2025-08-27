Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258CE156F20
	for <linux-serial@vger.kernel.org>; Wed, 27 Aug 2025 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756296233; cv=none; b=DwSHd95ZtkwesXEhEdNYWjSQjhF5xkukpL6580RQOUXVzTHNR7yPUs6nSViDrZ8hzjrbVBU+wiyrskQ8kRx8sDmkbhao2j6hhqkSc7Ul9fdZ7BLKLY9pJS44mQ0WUqbZmOdkOEPm9oko3HUUkhEkOyft0+/49mO32Sc1WJzC7xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756296233; c=relaxed/simple;
	bh=9cBeQjS8JoJ+RAzZ4el0vbg7/RfxL+/8LgI5k6E9oQI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=miX9nnxknzno8bhxDX0bu5CwXAHH22Xqq55GBWqvSn6zqj4ZZrPMZrQ1FRucKd8RmMG5m56ScN8TlYPnUO0bek8Ww3EaT2RJ4DHvKmZeS5St4EvQqMC0S1hMNJi+cUpWfsaLtiHeUFTvZrWNzMDVyIGinoBQDBLmwT71V+CJpBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DGzCoYGO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DGzCoYGO"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R6kYcV023192;
	Wed, 27 Aug 2025 12:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xG5TWs40wC1uRk9pc3SKAu
	Dts9FtjHd+m8+g2xbj67E=; b=DGzCoYGO4FkZof8zzdbJRcY3lVuw5cFkQImJgm
	ZzutPkywWkn1QD9M12ltgkVPvAUUBUgJg10LKfaQUmrCaOV44o6V/ERkgbwNnr89
	SvoimD7duPC9JG4SNoEgx2dEeQSX7TxYIPp8/73oq0DUq/NpZbsAR9m6IDq2uabF
	jPOR/xhOCYvr+tkfKjFUnelqNQaPLDILZL+2yh8r9UFPkHYWavzOeKaYedANPLoe
	NzcEFzTYU1+lkGJsorlIo/1AcsBz3FN3l6i6DlVB+7hYTNoYklfnPpFhYelYiGTn
	C5jSbKdiBvjDcdQJfrmZ59A34bTAPrSusI6S83yrxy1NiIKA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5y5mcb4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 12:03:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57RC3jqE004065
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 12:03:45 GMT
Received: from zongjian-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Wed, 27 Aug 2025 05:03:42 -0700
From: Zong Jiang <quic_zongjian@quicinc.com>
To: <gregkh@linuxfoundation.org>, <linux-serial@vger.kernel.org>,
        <dan.carpenter@linaro.org>
CC: <quic_ztu@quicinc.com>, <quic_msavaliy@quicinc.com>,
        <quic_vdadhani@quicinc.com>, <quic_anupkulk@quicinc.com>,
        <quic_haixcui@quicinc.com>, Zong Jiang <quic_zongjian@quicinc.com>,
        "kernel
 test robot" <lkp@intel.com>
Subject: [PATCH v3] serial: qcom-geni: Fix off-by-one error in ida_alloc_range()
Date: Wed, 27 Aug 2025 20:03:19 +0800
Message-ID: <20250827120319.1682835-1-quic_zongjian@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX8aPwzVkpI2yn
 iy2UD/gRGwoOhWOBlbo/gNsnrQREel9jVWToXe1GCwgSCq4wN5bSAjAxbwcum0ZahlAr8SuZqRr
 mkPdOttuphxErP0XdJVnbLiRkae6waGmr9kRl6+6TWWg1aNfVOiR4op39u0Js4J9g0wbbYu0Cie
 S28Z/ljgc9BVH8wEUS6N1MO+BQXfuT5hGTxvnZLasRcEYdslOZhljG9JlOlkASyJlgTlcKOT4wY
 cPe4jEAIj1pXaEGMi+rlbJOYsqDIb3dNc4xpkMJ/HzYqgPATPAxLSaLduDY+7ZkTKEA9cECctnL
 +K3N9N88KoWZuBkso2W7YVSHsOgSLRidZXpWMrnDmb7WHK9a3h54UTJdoDJQ6JFYH+eKEzOkAdo
 aqNJedv8
X-Authority-Analysis: v=2.4 cv=Lco86ifi c=1 sm=1 tr=0 ts=68aef422 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=roy63ODkg0DyNSlNSiUA:9
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Wwe80VlK5zKU9AL4yuComT5Wh0feYAg0
X-Proofpoint-ORIG-GUID: Wwe80VlK5zKU9AL4yuComT5Wh0feYAg0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

The ida_alloc_range() function expects an inclusive range, meaning both
the start and end values are valid allocation targets. Passing nr_ports
as the upper bound allows allocation of an ID equal to nr_ports, which
is out of bounds when used as an index into the port array.

Fix this by subtracting 1 from nr_ports in both calls to ida_alloc_range(),
ensuring the allocated ID stays within the valid range
[start, nr_ports - 1].

This prevents potential out-of-bounds access when the allocated ID is used
as an index.

Fixes: 9391ab1ed9b3 ("serial: qcom-geni: Make UART port count configurable via Kconfig")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202508180815.R2nDyajs-lkp@intel.com/
Signed-off-by: Zong Jiang <quic_zongjian@quicinc.com>
---
Changes since v2:
- Added "Changes since v2" section to comply with patch format guidelines
- No code changes; commit message formatting improved

Changes since v1:
- Removed incorrect "| " prefix from tags
- Added Fixes tag with correct commit ID

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

