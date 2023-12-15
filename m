Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3D625566
	for <linux-serial@vger.kernel.org>; Fri, 15 Dec 2023 11:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ixkx1M+n"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFAKMuZ022283;
	Fri, 15 Dec 2023 11:37:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=jqDlukir3j2ORX7rm6DEDEE4J3v27yGHsQ4KC75OPyY=; b=ix
	kx1M+nHM9wj6duQ+FMn3uZpliiyrTDrHvhoYqCjpTSqcLUTWQHAJb5TL9q+Me8CS
	2MbjyBsh5PYfobdGP/sqHhLnT3ySswMkVZiHS2DXZ4miBkA5QSfdrbhXyyPo06K7
	j4Qkfmh33D9z51dJjAce8hTCxvvnRbmqWy4v+wq86YA2AR3nXbOeeYP/fThaRT20
	JrcFYIcI8EEu+hK8mYsWMUuV7JJ04SAO99qzMsYrA/ojpcuFHK8XS2WeZTMnV8iC
	UhoZan0Ob6qfdPY0yvdTuZJy8HOTI9wYHtt8Szu0gZmE8vwc5psgAgkHN1/zDglA
	SWg07BNj3CJb2xXoTDQQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0jt68ks0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 11:37:24 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BFBbNXJ028257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 11:37:23 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Dec 2023 03:37:21 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC: <quic_zijuhu@quicinc.com>, <linux-serial@vger.kernel.org>
Subject: [PATCH v1] tty: Make tty-ldisc module loading logic easy to understand
Date: Fri, 15 Dec 2023 19:37:16 +0800
Message-ID: <1702640236-22824-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LMP9xDneR99gczl6p1H3cWYRrzUP2dIv
X-Proofpoint-ORIG-GUID: LMP9xDneR99gczl6p1H3cWYRrzUP2dIv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=923
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150076

Current tty-ldisc module loading logic within tty_ldisc_get()
is prone to mislead beginner that the module is able to be loaded
by a user without capability CAP_SYS_MODULE, add comments and
optimize the logic to make it easy to undertand.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/tty/tty_ldisc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 3f68e213df1f..faa125f32110 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -150,7 +150,11 @@ static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
 	 */
 	ldops = get_ldops(disc);
 	if (IS_ERR(ldops)) {
-		if (!capable(CAP_SYS_MODULE) && !tty_ldisc_autoload)
+		/*
+		 * Always request tty-ldisc module regardless of user's
+		 * CAP_SYS_MODULE if autoload is enabled.
+		 */
+		if (!tty_ldisc_autoload && !capable(CAP_SYS_MODULE))
 			return ERR_PTR(-EPERM);
 		request_module("tty-ldisc-%d", disc);
 		ldops = get_ldops(disc);
-- 
The Qualcomm Innovation Center

