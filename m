Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A21413AF6
	for <linux-serial@vger.kernel.org>; Fri, 15 Dec 2023 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mG9mf3hD"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BF4j8ch030663;
	Fri, 15 Dec 2023 08:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=Rtq7pLXxCJVqYoA9YX3KTEKSSu5SyO6189Mebf3INIw=; b=mG
	9mf3hDD2WartwAMNlBOujxExwztU0gBEd/V/6/aSK9qeeZyebYlNVv+Yq2AP3zjZ
	VUTcgGhkPOS5zg4TjS8QjGRegRCtBQ4k9oYs7xw0Kefm8KRsnCVznyoYrqSramAr
	HnIlZ6/+S1HKRXDz3nj58QNHsotmAVetPSI5hSOK0eEAZRhKMwmVkXW92L0GHZpl
	/7uQMCIxGQXXXW4iJyEXgdOAkvpY+8AZJ88XopskZpWMc6nJIfu6+h+vNndiNH0R
	bD7HjlZaqKBk37EkVuHQ/jZuH2wja1IepmFnntDpbV+ReJkky/vxzvGltWFUe1Mj
	fDWKwc/P+hdLDSLGX/aw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0a37hh2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 08:29:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BF8T8xk003234
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 08:29:08 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 15 Dec 2023 00:29:04 -0800
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC: <quic_zijuhu@quicinc.com>, <linux-serial@vger.kernel.org>
Subject: [PATCH v1] tty: Fix a security issue related to tty-ldisc module loading
Date: Fri, 15 Dec 2023 16:28:53 +0800
Message-ID: <1702628933-6070-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: TTqsO6pgmQIeuW8KEuoWOVoQTJ12Bpmw
X-Proofpoint-ORIG-GUID: TTqsO6pgmQIeuW8KEuoWOVoQTJ12Bpmw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312150052

Function tty_ldisc_get() has a simple logical error and may cause tty-ldisc
module to be loaded by a user without CAP_SYS_MODULE, this security issue
is fixed by correcting the logical error.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/tty/tty_ldisc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_ldisc.c b/drivers/tty/tty_ldisc.c
index 3f68e213df1f..b490c0adf00f 100644
--- a/drivers/tty/tty_ldisc.c
+++ b/drivers/tty/tty_ldisc.c
@@ -150,7 +150,7 @@ static struct tty_ldisc *tty_ldisc_get(struct tty_struct *tty, int disc)
 	 */
 	ldops = get_ldops(disc);
 	if (IS_ERR(ldops)) {
-		if (!capable(CAP_SYS_MODULE) && !tty_ldisc_autoload)
+		if (!capable(CAP_SYS_MODULE) || !tty_ldisc_autoload)
 			return ERR_PTR(-EPERM);
 		request_module("tty-ldisc-%d", disc);
 		ldops = get_ldops(disc);
-- 
The Qualcomm Innovation Center

