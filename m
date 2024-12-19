Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A761FC7D1;
	Thu, 19 Dec 2024 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734612217; cv=none; b=BiNPuIwrWhawC9Ox2ykdthKidSIRNm1xP/3mhCDpdN4cSO2yOd+Cz16/7ZB7KNBHP2XTfW8kjRCiQuZSJJ9fD30jxQIsvK+SCjp7dulxJbSI8f2OpnOCfZWOy/n5k7RVY45YsTXttrpoN76ISEJG5XBBhcvzPdwzut+oaQzMxws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734612217; c=relaxed/simple;
	bh=ZimRf8Bpsd35kexojX2r6tgKxASnY1RyZ9Q7bVg6g1E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s+lbll5bp469NLq/jhXb0GJedIXfKdIDbcc6nxY06FKildT1kn7y4eT/NBGRV4HGuq2/qEsajMm2K7e8AG2z3SUY4Lg2BIBK9F7tQX3YzyIXI4/26kB8wSqmtQ1iw4664K70B2+cBePTy7yP0Rd0Gm+U48X7S7AGmmNKE7ivn60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CBHYY2Oj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CBHYY2Oj"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BJBWHQk026534;
	Thu, 19 Dec 2024 12:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xdexvtfmKWuPhTpSS1RlZ4
	qKoANDMWHUA6xHxfD+Cy4=; b=CBHYY2Oj1BOA3bujED0dvMeFz1vT7FnlI/14i+
	goFdd9W04Y8AUkVGx/64aO+KxBDJgpc5PYEZ/EyExKpevj7+tVuBqSd4Uvjv09cX
	ifWcsytG1wfgZx0TTcChfCMiMMp4dEhA2u0VBdLHYTqbXeJNa3TlLdfWecBReoh4
	n+B31mq7vnqiZw7MEhwKMY6U+3eiTtwl4pZOtMi77wnc2fxoT7OmbNywmhvFZ5dX
	o4uO2NEQh+6iLWwl4quXoy8cNzEb0d78CAkh6jcs1NKuJyBq/tjGjj1ZOsFQ0lkX
	JvsIIFDRpuSIcvwLkWASz8cN7WiDr2EAATKgmDz36Qy60dtw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43mjpyg69v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 12:43:31 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BJChULg023567
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Dec 2024 12:43:30 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 19 Dec 2024 04:43:28 -0800
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <quic_zhonhan@quicinc.com>
Subject: [PATCH] tty: mips_ejtag_fdc: Call cpu_relax() in registers polling busy loops
Date: Thu, 19 Dec 2024 20:42:54 +0800
Message-ID: <20241219124254.321778-1-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oY1iWaAV32xcDLIMCEMkV-S4zcSnPE6T
X-Proofpoint-GUID: oY1iWaAV32xcDLIMCEMkV-S4zcSnPE6T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 impostorscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=792 adultscore=0 priorityscore=1501
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412190102

It is considered good practice to call cpu_relax() in busy loops, see
Documentation/process/volatile-considered-harmful.rst. This can lower CPU
power consumption or yield to a hyperthreaded twin processor, or serve as
a compiler barrier. In addition, if something goes wrong in the busy loop
at least it can prevent things from getting worse.

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
 drivers/tty/mips_ejtag_fdc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index afbf7738c7c4..b17ead1e9698 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -346,7 +346,7 @@ static void mips_ejtag_fdc_console_write(struct console *c, const char *s,
 
 		/* Busy wait until there's space in fifo */
 		while (__raw_readl(regs + REG_FDSTAT) & REG_FDSTAT_TXF)
-			;
+			cpu_relax();
 		__raw_writel(word.word, regs + REG_FDTX(c->index));
 	}
 out:
@@ -1233,7 +1233,7 @@ static void kgdbfdc_push_one(void)
 
 	/* Busy wait until there's space in fifo */
 	while (__raw_readl(regs + REG_FDSTAT) & REG_FDSTAT_TXF)
-		;
+		cpu_relax();
 	__raw_writel(word.word,
 		     regs + REG_FDTX(CONFIG_MIPS_EJTAG_FDC_KGDB_CHAN));
 }
-- 
2.25.1

