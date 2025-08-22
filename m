Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20642FC030
	for <linux-serial@vger.kernel.org>; Fri, 22 Aug 2025 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864361; cv=none; b=epXAXi99MYgPv+VJ/Sd+7/P7rgIYVSgjdkcvjPhMcTLKxEfUFPS0W3PIFsLpiv0ct2jhYh4FGhyRp86IV9vxWv7DhdU0Ib0wYZUnlKiDhoUNp6wx00vgNQGAXwdUbSAxK6fWR8JIvmKb0CfjQttWPO8DYofjoLfhUznOKogTA3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864361; c=relaxed/simple;
	bh=kL6C2fnJ6eOt0PACPPmrEhT4pXm1H+Q9UAMnxrHEVGA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N1BBl98GaWQHm3MQ+CjxPMeGgKeS2Z3tEuxWUJlLhZO1vwHQISJ/UfEy7wmZj1QFV6XhBsg924eHOVKQjUvipd05OLp4B/ToaEe1FxG61bBL8hmp9wJzErkP43UR3h/9i714EYhkLuvWL3UOswe+MaT5+nModnPyW06b6hUDL04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IV/9cx1H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IV/9cx1H"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M8UMD1030532;
	Fri, 22 Aug 2025 12:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=IsdB48P3+k6hdqVOrEXtiv
	j1zkKac1YG90BHUPIeGe0=; b=IV/9cx1HkYPbowB4SUptEXmPcHo1Pze8AAnc3O
	9035ZT/PiBvAvKFBZHRF+iOe8ddl1kDSOnTkN073PfjlROwNlRErZdc4FkSJQh40
	VfUB67LktOCC9xtMfOGpSXRmjp4R15uD5vCRmv7Sjmt/flO023uFRvZ2EYeMAerA
	joNKa46jGhwnAn3rmlveA+YvkwAZxhENFbdgnzX3Ou/XIojXLrBBjltVo+e6SGyW
	YFngJnylQg1/4SfADZMD0kOiUQiWp+g89NrXp8L4sxY8uJS4v2aGrid6RvmchfDl
	GwVBH6jdI5jp4SaxPKfHkRljb36oo+5voGFnxhCXm2+HNTqg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ngtdpxus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 12:05:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57MC5ndJ019252
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 12:05:49 GMT
Received: from zongjian-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 22 Aug 2025 05:05:46 -0700
From: Zong Jiang <quic_zongjian@quicinc.com>
To: <gregkh@linuxfoundation.org>, <linux-serial@vger.kernel.org>,
        <dan.carpenter@linaro.org>
CC: <quic_ztu@quicinc.com>, <quic_msavaliy@quicinc.com>,
        <quic_vdadhani@quicinc.com>, <quic_anupkulk@quicinc.com>,
        <quic_haixcui@quicinc.com>, Zong Jiang <quic_zongjian@quicinc.com>,
        "kernel
 test robot" <lkp@intel.com>
Subject: [PATCH v2] serial: qcom-geni: Fix off-by-one error in ida_alloc_range()
Date: Fri, 22 Aug 2025 20:05:24 +0800
Message-ID: <20250822120524.4169865-1-quic_zongjian@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=LexlKjfi c=1 sm=1 tr=0 ts=68a85d1e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=KKAkSRfTAAAA:8 a=COk6AnOGAAAA:8 a=roy63ODkg0DyNSlNSiUA:9
 a=cvBusfyB2V15izCimMoJ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ASRe1p3WldTD6YUll9hcSN5x2qsQ66Qd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDEzNSBTYWx0ZWRfX4YzTLWk44s8D
 QZkq8CeZvO4a/8P6uYy1aQ5+2buVkgSmuCsAnkmKyb6pxE7jjNfjGfXf4sRyN8ah1cHGpcAHIzF
 W+Oz59iTrcCokkUi4vKb7g9x3KbuR11+zQht5WMfiPoaga5xZnKcZysH0njJaKHtwppFQ6F8wkP
 tugMl0c91dryKfcOeHRPA/UtN6VkOZjYyJ5jF6ER+62+TIoBbQOyEVKQuVNOGFGgo0qtB+wEe31
 9G9/RemWCQrTr01yre0OZ2q77LvLFzB6NOeXMoU6JOIDF6wfZAt+AnkQXRtgNAmnE1tbR9JK91m
 7mWAcQLjG7CDlqef29FxZOAU8bnIyIYsT6QIzejFfnsDmDyyXCR/w5E5lmzMuM8pQPKXjo63SYh
 GYtc+KyPBera7T12b8tu+mAxleGlRQ==
X-Proofpoint-ORIG-GUID: ASRe1p3WldTD6YUll9hcSN5x2qsQ66Qd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 clxscore=1011 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200135

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

