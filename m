Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535D23B4EA3
	for <linux-serial@vger.kernel.org>; Thu, 28 May 2026 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779988707; cv=none; b=XPLMpYloupUjHlyi/fsNCBJOQgRakJMcd0qy5CTqmXl/mx3fEORtI6yX9VBscEd5WFae4NjQZ0mk6J8qVrcgF186GzbWrXA1Cf7HYCn2pWJ38K19pP7vKfDnIMat/ueRw26gw0dC3n9iGHMKDqfQpqa4Xmf2yce611MjmL9LsoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779988707; c=relaxed/simple;
	bh=KYjKvckY/VAl6XCtEiN8jjSXIWwmJfrlKKhhzB3/mOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=m5FSqUV9yWMyuNeM5XIUNzbC3tOC6mRp9JK+7rEdz8qWcdymQOOAyxBNrjEK8sHNjDQpGrSHZ01GX+7Z1aSRpqrwVh/dok+m8GNXz8Olgwlh5Y4eJcTyvqrA+MxrdKWm8Vyw3cRDrGsofJTFjo9BPCwqL2yXcr0Ec2gmNupqwEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IKsDATQg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WNAiXosX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IKsDATQg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WNAiXosX"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64S8vXwC4016426
	for <linux-serial@vger.kernel.org>; Thu, 28 May 2026 17:18:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=861lfeuRlAbmY/H78CLEEr
	qRlCIH8BpNiqVeOaDNe7w=; b=IKsDATQgdKfOLF2p64CxsNb6cCr6SLakMEWPKP
	pTdtcdmevPWwHUyO9/VbXbF3wV03MpVMEa3KZmTlFTgM5yQMgZ248p4QtABfaXcg
	RNLMM7qNBRSL2Im9f/ds+qON6xLNyZxzK0+FKS6PtFgi/bTqLV6AMGsFhSAtZNaK
	ugwfdW/9K3iuK8UCLEZbfJDRP1XeUfOJNmD0L+qPDjrTYORSYPz1rUuM4OAf3qH2
	VZsygK7S4v2DBfnXw2ODHwJltO0YtMCHYwqSkWF3vh57zm3nYCV09WPp0zU/Vfar
	VJlodIDbycF1wQJLmayDQpObLnNr/nrHVVLZgvVhElS7Em6g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y5btn7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 28 May 2026 17:18:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-365d4d2fa04so12139660a91.3
        for <linux-serial@vger.kernel.org>; Thu, 28 May 2026 10:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779988704; x=1780593504; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=861lfeuRlAbmY/H78CLEErqRlCIH8BpNiqVeOaDNe7w=;
        b=WNAiXosXnSVx5XpdnPEOy+hjfrWogNYPPEzfQq0AkPuYweldn0qRWgH99vtULOTZ67
         TON/oH3e6mDV9OZ8yDAYO14hNYv0fdUpsLk+FIVzpe8jtW7nFwJf36KvU5RHfmw6RwuD
         qkaLgFAdldmexVOhwgjMJiQ2+I1YJQ89Tps3pu187ko3EWpme7hthhLJcPVRewfi6y/3
         JnnVbDu9h9u1zlRbMnjOhmt4r3rFjO6VzXULHeX0MyUPbVf/dwXjm92C7DTNmH6LJuWu
         C10tIZSWTe7IqGDMxM5M6s8y1aNuVPMhaTSWcYSD3NASGxUSxsgMHEP4WSS7kgBtnCIu
         hfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779988704; x=1780593504;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=861lfeuRlAbmY/H78CLEErqRlCIH8BpNiqVeOaDNe7w=;
        b=L1C2DcfQ8hyiaCw/1gn14ewrBlaPDaGpdC2dh1ESUzhCFdpl9PqjWsmEyhhLk2Lgh8
         +40i/oeGvIbpHiSpbV5wkJe/+L6uHQOsCRGgSmWnHxJ138gnnNvv1NHrBZ0BlIJMx1b/
         YEKfn2+/xiwoi7LaziIeW83rVB+sZs/exMkMYKUE9oJ2xy2IEB3HHTgOmUfpsKY0nWuR
         bEpPkm2OXdGlZFnmT+jOO4uMGgZgJquJUw8KppvGi2JDHU5UP0htt50USYk/tQGT6E2X
         NDbzKlHaVztK+4VT+cRN4z44QEc/1VZfAzwqJbFlvSccau4xJ8Ex4yvdWcGH7kmvY/Fm
         DeeA==
X-Forwarded-Encrypted: i=1; AFNElJ8Idql0VxdAY8v9Wtj20Ni3D5fZbASuYK7akTt8k/ew6CPhM5YJ/2MUuR4u1emKG3WZuXDxf2+L+Fktqug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr+jcvNeL/OggUS7aOJQSZLP3hwnH76DZufH1pbp7pJu6zdUZF
	QNjQ4kdQy9uF56Ug9D49jsgvOyNtj/iS8B7mX590AT+rCdP2NjjiIU84775IND2V7ZtB2cDt//S
	GkduCh0u2oSQgn28SNypQRVa97ZeuqT/QFsah0pGYpDvg/8m6adBjqQN6G50GuRl+x8I=
X-Gm-Gg: Acq92OF9HXCiy5CnI+Aup89m5Vd8+L/Xmhjtu/Wf3zOZTMVOncc9/exQiAbJUE88eRQ
	FHoCFXylozv2Dx71pAjxEARQA4juetrKHlbeADjl0vZZU2yt3DZKskJcQuAMnQOxm56Hh5tWFbD
	icsXVklRMM5R3rVyE/BkxHn/XxhUcX7vVinmqyzq7GbdqATVwGYavRNew9LYxaWBcigw1ROwkjb
	Mxl6UXxKrxe0Na8jDWYt3LrBdWCJsBWuaYz+yALwlwsX7pyygVgjMdUQBkx5zbtA2Fs2FKT+6js
	eSaADbZwGgKMMbab17wSENaqUpW84g0vUZ4PexnYcfBBkFxHGz63EAQznRSUzAqJtj1KHGtQLLf
	aWd5GzFRBNWnaJjtQeHMgjIbcMdVG1OwcoXasEPZLb30lg6QSWe8FS7fH5WHb03GeCkkp
X-Received: by 2002:a17:90b:5343:b0:368:a27f:9083 with SMTP id 98e67ed59e1d1-36a67761c51mr25386491a91.7.1779988704063;
        Thu, 28 May 2026 10:18:24 -0700 (PDT)
X-Received: by 2002:a17:90b:5343:b0:368:a27f:9083 with SMTP id 98e67ed59e1d1-36a67761c51mr25386462a91.7.1779988703499;
        Thu, 28 May 2026 10:18:23 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b90c03314sm2500410a91.14.2026.05.28.10.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 10:18:22 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Thu, 28 May 2026 22:48:07 +0530
Subject: [PATCH v2] serial: qcom_geni: Fix RX DMA stall when
 SE_DMA_RX_LEN_IN is zero
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-serial-rx-0-byte-fix-v2-1-b4195cfe342f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAM94GGoC/4WNQQ6CMBBFr0K6dkipCpWV9zAsYBikBqh2gEAId
 7fFA7iZ5E3e/38TTM4QizzahKPZsLGDB3WKBLbl8CQwtWehpErlVWkIftmBW0BCtY4EjVmA8FZ
 LjQ1lmoSPvh3591H7KH7MU/UiHENXMFrDo3XrsTsnwfszMSeQQI0X0lmK2TnVd8scf6ayQ9v3s
 T+i2Pf9C1vJtkzRAAAA
X-Change-ID: 20260528-serial-rx-0-byte-fix-ec9d08cfe78e
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779988699; l=2081;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=KYjKvckY/VAl6XCtEiN8jjSXIWwmJfrlKKhhzB3/mOk=;
 b=aTPBsPo1CPjLI0wCQbsFX1lYscFAfml4I823i+RA/CpTzZFoKJFg+kGzqK2JqJGlkDA2VYfix
 Eqa75SLa32SCdSfwiik59LX3RqL/iCTpYVeJoBymFfdHiMRRPq3rvIj
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Authority-Analysis: v=2.4 cv=OM4XGyaB c=1 sm=1 tr=0 ts=6a1878e1 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=tI4oF7B6g8YmWx8mlzIA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: YhOyNaFSuAn6eZ_174k5ZUcbmLOuWgeG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE3NCBTYWx0ZWRfX3HyIglUJuwuC
 POIwrt2dduhu01rATv2YS8crpagVT8CeSHUjIqiWVsCAPPInH0ax2WfmTwMn6KlXcMi85c/Sosn
 l+gPTbfSwGLpexj5SyKT3H2L8XQSSqhGie8IlOTi8QhSje+F+8iAdvrhqOBKEogTd5IYLW2kXB4
 4v4D7pbf0lvzRrt0wmqQaftoBoXHNfo7wBklgaF8FzJm5LKA+IuZs9chwll7Wv/brkX08p1CgBC
 JLf4UvOt0Gk4dJwCmvWihK4xjlVIgpVyVdnYfxWG+mQB0qjwc/kHw+k/yeZTuXTckbJE8/0X806
 BPmr/k6aWBLESXoz7FYeQqFzrDT4ZRTt9G4ff+MaO2uND4UpD+fCE20kVjdiHuRgfGR/6bI4OX/
 BLuIzNjqba1yfPYXdhCUePKwYdauY5B11B/AW1A3C9/ZoFaTINgBwPEWX3jn0bhzxB0yqriBCks
 40Ty20SGXdvJY6NWmCw==
X-Proofpoint-GUID: YhOyNaFSuAn6eZ_174k5ZUcbmLOuWgeG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280174

In qcom_geni_serial_handle_rx_dma(), geni_se_rx_dma_unprep() clears
port->rx_dma_addr before SE_DMA_RX_LEN_IN is read. If the register is zero,
for example when the RX stale counter fires on an idle line, the handler
returns without calling geni_se_rx_dma_prep().

The next RX DMA interrupt then hits the !port->rx_dma_addr guard and
returns immediately, so the RX DMA buffer is never rearmed and later input
is lost.

Keep the handler on the rearm path when rx_in is zero. Warn about the
unexpected zero-length DMA completion, skip received-data handling, and
always call geni_se_rx_dma_prep().

Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for serial engine DMA")
Cc: stable@vger.kernel.org
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
Changes in v2:
- Add Cc: stable@vger.kernel.org tag (missed in v1) 
- Link to v1: https://patch.msgid.link/20260528-serial-rx-0-byte-fix-v1-1-dc4e876c7368@oss.qualcomm.com
---
 drivers/tty/serial/qcom_geni_serial.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index d81b539cff7f..7ead87b4eb65 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -905,12 +905,9 @@ static void qcom_geni_serial_handle_rx_dma(struct uart_port *uport, bool drop)
 	port->rx_dma_addr = 0;
 
 	rx_in = readl(uport->membase + SE_DMA_RX_LEN_IN);
-	if (!rx_in) {
-		dev_warn(uport->dev, "serial engine reports 0 RX bytes in!\n");
-		return;
-	}
-
-	if (!drop)
+	if (!rx_in)
+		dev_warn_ratelimited(uport->dev, "serial engine reports 0 RX bytes in!\n");
+	else if (!drop)
 		handle_rx_uart(uport, rx_in);
 
 	ret = geni_se_rx_dma_prep(&port->se, port->rx_buf,

---
base-commit: e7d700e14934e68f86338c5610cf2ae76798b663
change-id: 20260528-serial-rx-0-byte-fix-ec9d08cfe78e

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

