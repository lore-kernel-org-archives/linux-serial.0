Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70CA2D46B3;
	Tue, 12 Aug 2025 05:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754977724; cv=none; b=USLiX7r20XMxCwiQomiFYf+Fjxsd5W/hAxI2DyluRnXR8GUlO1fZWuv+6uFiHY/kKxMYMkF+wSTIdz5uHdJlaK9ta/sua40juBuaASfqtmwg/kW+7HskYX3ra88OVhtUrb0OU1murllTv+6NrhNnc7Rq6WrLa2nFwS0jtUh1e+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754977724; c=relaxed/simple;
	bh=Mt75utOS+FLQdNmbVCXZeloFSRJkEf4uCSos32mxQkM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WWsv4xdy3BF2TDWVBw6j9g5w2U2kufzdcPYB6yLanTjeIfWAcKwSLneYO0zlcXW0aTV4FfUAhcZ/7KqF5jQ8sq8uoxX/Bx0tX1eILhP9L6Yz66BLFUbdtQoNolEA5p9ZopMp1VwSPuH89Hb0Aot8H6ujb1YeLm6g/ivZO8jFOok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DTIJRl8e; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DTIJRl8e"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C5XLYA029228;
	Tue, 12 Aug 2025 05:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=zv4jFYnA5NgrKThOuZiXOL
	7P6F+n1+7pt2PzbD7/OLs=; b=DTIJRl8e2PSlDHIxurdSy4TDH2a0Qf6l/4tQwi
	Vj9v31dA6eLa8s3dzq8+EM2CKkE9ckDBaMW0ZGSIFvc/StmJ6rPBSebT7/tbss2b
	V7rTlbMtbl6OBqJliU5P4otv5PHnje3JRnTBUhrgbpmy/FJc9DMKAFCmUT4tRmxE
	sPkSOe7oSsXgidO7RRPpA3EyzQLYo9ws8Allg7S2hul26QQBkWfk9mv2FTC8nlxM
	WOSUuYe2BOqu00yI2zf8ecjtkQo7WjPv5YQOoVwU/sA2rRiJVpG25xaNn5HRv9wl
	IXBClEOJQZhNeUKgLv1IFxKq+LPrD+kMr8zpnssOefnTHUkw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dygmex6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 05:48:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 57C5mewW026959
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 05:48:40 GMT
Received: from zongjian-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 11 Aug 2025 22:48:37 -0700
From: Zong Jiang <quic_zongjian@quicinc.com>
To: <gregkh@linuxfoundation.org>, <linux-serial@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_ztu@quicinc.com>, <quic_anupkulk@quicinc.com>,
        <quic_msavaliy@quicinc.com>, <quic_vdadhani@quicinc.com>,
        Zong Jiang
	<quic_zongjian@quicinc.com>
Subject: [PATCH v2 0/2] serial: qcom-geni: Add support to increase UART ports efficiently
Date: Tue, 12 Aug 2025 13:48:17 +0800
Message-ID: <20250812054819.3748649-1-quic_zongjian@quicinc.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAzNSBTYWx0ZWRfXzm5twPHdxOs2
 r5zrYeldowu84sR3huGpWlsWbdnSGLggbg0VcvYzduv0BjpWX+QxQPd4S1P8Vctx7T175gXeE9X
 2qOg10/hKarU6m6kf/LRJl3OKJ4WuaTdt/Xa4qiFqxipSDdv7py42D+CnWebAB118T4l/I5r7Wk
 ECQBZ74iRKoZ6ElNGH+22J3mP8YmdWaJA++1PFTQJzyMbcGOeX4x5zNIRJq+FwaBFf/IF3PnU1w
 R0hFDujymvByDQ3+yozUDw7vACorbl7BFz8nHusm+ssrui3XxllT7Bs9WK4a/qXlhwVFmMPggfW
 RmpkjHl3+B5NNREGz1KhuYAF/P/D9F/3BQcm8w1pAeNg+0y+Cqc/4DsD01nyn1PRW5AXCJxSN+Q
 lfmwRYFj
X-Authority-Analysis: v=2.4 cv=FvMF/3rq c=1 sm=1 tr=0 ts=689ad5b8 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=0UXVF4T5m0Rc8HU1ALcA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ksnGgTZVValycvpa2ckCJm_iJsrMTTfZ
X-Proofpoint-ORIG-GUID: ksnGgTZVValycvpa2ckCJm_iJsrMTTfZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1011 impostorscore=0 spamscore=0 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090035

This patch series improves the flexibility and scalability of the
Qualcomm GENI serial driver by refactoring UART port allocation and
introducing a Kconfig option to configure the number of supported
UART ports.

Changes since v1:
- Based on Greg KH's comments, the following changes have been made in v2:
  - Split the original patch into two separate patches.
  - Replaced static UART port allocation with dynamic allocation.
  - Added a Kconfig option to configure UART port count.
  - Improved commit messages and changelog to better justify the changes.

Patch 1 replaces the hardcoded static array of UART ports with dynamic
allocation, reducing memory usage and improving maintainability.

Patch 2 introduces a new Kconfig option,
SERIAL_QCOM_GENI_UART_PORTS, allowing platforms to configure the
maximum number of UART ports at build time.

These changes are useful for platforms that require more than the
previously hardcoded number of UART ports, and help avoid unnecessary
allocation for unused ports.

Patch summary:
  [PATCH v2 1/2] serial: qcom-geni: Dynamically allocate UART ports
  [PATCH v2 2/2] serial: qcom-geni: Make UART port count configurable via Kconfig

Signed-off-by: Zong Jiang <quic_zongjian@quicinc.com> 

