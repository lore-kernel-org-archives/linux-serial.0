Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE3B3750AE
	for <linux-serial@vger.kernel.org>; Thu, 19 Mar 2026 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773913697; cv=none; b=XN9zm5x1qi6pV6NLwEjFyiz7Zkh1tFkE5xHcZ24JbTJXp4drSGHtCpIjsG/Eks/vTUsOjlu1gZeQX06uRoiPp3vfJkC3l8M8VXCZsEjV4lrnWLX/qBECMeXIcofCqmQ/66dkKB9gBAxh4/Yl0V2O2eGxPIBLiVdHVMUJEexln2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773913697; c=relaxed/simple;
	bh=kS4fJc5ORDfQmCS1Co6/IOO3+J4q9DKDhUB6N1RE7BQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b1AUCTmUF5ZigdynrniuRg9oaHD36YwXQey6tBn604od2DFQ2A/P+q/l/J88u01RWD9aURcZm+0g3v57/ThYphMdklmP1k6Zkb6/ldcJpQAuvaw+ebhALqH0s09VpLaxg8wZnDJAu8BKP1MV9TOHKjxampl6Tukima7DBfvTmtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fI0V+Dy3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gW6Ho4qc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fI0V+Dy3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gW6Ho4qc"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J74EpJ1999533
	for <linux-serial@vger.kernel.org>; Thu, 19 Mar 2026 09:48:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=dqRkQOnkfyUBmHM5Gj1Wk7
	vql3Ejroq46FdDVPB6DJU=; b=fI0V+Dy3iUVCAn17sIkW75XjrkyZtp/67nheXm
	AZQyVsFO3ofHLqJYoU7Hq0rv0pgj/4+hf8hFidefchb4LZ/icJQS7jJTxXpz1F74
	Gf0Rrma9YyjOoFXYPa2zxw6vUNKqaQRCnj8HewMSLuvKXYrN1zv8gI8VsS/rW9Iy
	XuLtD+gvFHurG/yCyJrmUA8pe/whs6v03ohdf86XX1aJ5xnXRUex3LeoXo/wmjgO
	NAEdIXGKGZrBHpzAab+evu5o7sFtdFroFjBQOARqgTusnNEICrVs9/w3WL44F1Jq
	IbMOj9Bef6TKeexnwCpospEx5/1xDpGQUeYgbHa2FRw1cvJA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyscb4gsh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 19 Mar 2026 09:48:13 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b06b68783dso9601135ad.3
        for <linux-serial@vger.kernel.org>; Thu, 19 Mar 2026 02:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773913692; x=1774518492; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dqRkQOnkfyUBmHM5Gj1Wk7vql3Ejroq46FdDVPB6DJU=;
        b=gW6Ho4qcl2nG5QVTNqsFQtQsRqZw3vh08W/8fzEW+z7/D6b8mtkhJCWCWwZqJiWSEu
         L/HDZS8IWyAHVmYjdhZR38mhZCBzlR+sNQG8Kc0r1Xf9bdcm7vzhUWpTq4FutRbijw98
         Mi4FUes9QyprYy0bMDAFe2bBO2xHxc7M49YqhVBgoxbTg27E4ZbE7TVMMah5l2uLgU8y
         4/TJ15wC/eUH6i9E0IZit0HsJmAklcjdBYHFBkCq+pP5a+2sRsyKVjtFpaLhcI8RelkD
         z7raD1lZ0+w2INAyHUMllUiLEKvH/qqlaOG4+x+nrKpcU5b7jjHfJIQSf41n8yRocvuy
         jBqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773913692; x=1774518492;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqRkQOnkfyUBmHM5Gj1Wk7vql3Ejroq46FdDVPB6DJU=;
        b=aryBP8nl0DfPkapprPi616XQ+djVyVSvHU1ibsYDH9nzIhQwEFUw6XHrt07xFkIRBx
         ly9GZNVO+EAcHaYVr8fo4gDhriGO6dkg4ofo3EKsMmtqWvqdojcgiC+brGv8XTfn+d+3
         1rQmukoK725Maf75Z+wDYi/aXn7gMFg7/bRJ7AolHS5V9ycbkvRQLdGPzTZUBBV/UsEs
         vG7wCji3N/svHljlfvgJrj8l0GlnY1rnkx1AsxlMEZB7BUUsmLwSLaP1QISiUIeU8Lcb
         JLQP0TZ9mmLynDAVrd/Fg0nk20fMmGW+atX1Ik6WLRN1yqR5a/u0mwnjypXHAzW4U9bD
         tbSA==
X-Forwarded-Encrypted: i=1; AJvYcCVRT7YJgXWZY33pD3CijVm/EsY42Q7Z/i+1t5+u26HnDLG+ZSgDrRN78/13mq1Us40btOkBavw1qGYAsnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT4jkO19RCHMgzSl+PUsrBjqQyMYqFyIv/6oM3PDxZfrjdRQJo
	N0hmJOwHF8FB9wPRPqiAxcXf5Lda8SeYJum6zghc7+d6C9cRscv1bBKvLJ9ifgOztVqTyHazBEW
	oAMeLoccAGqfSfj26bzcL5YLbYkt/SrsyhtFtuIXhnFpOkIYjL1ykVppm+XgmvE/y0pA=
X-Gm-Gg: ATEYQzwhP2mjQ4LSIKSY/TM+SYdy9pnItqOLP/zd/CY968ZMKIdIcfV2Utw/N7IjF/S
	moE/l9i6gU+djltRs41zGUbGiREEGCDlrb63Wu/cRWYI57Peq0ke5MDMYy5hE9+tVmdzd7vcMLu
	VLUXzobZI1GaifvNxbXSA9aH1mi7hw+YrAEe8CkjYlP06OE+jpIuOfRxKnLTVynXncyCdBA2blm
	t31q9fDkwTb7EKvGAAmzsGX2V8dNxH48aMQY408/VmKrMFpa5rVQgiv86m31bagskkOau+ewvFs
	D4S2NTwOutbeT20UIZpf2leQXzHuc0jbWs5Ro2M2ZmOP3ZrjgzwgZdmBYKfCbMZUGFQaj6GLI/M
	XQ7u0NFAKN2hhfP6ND2/zL1gmyxWkUdjt785Sqyt6vqijSmGcTsDyxQr879y9Vh+OJ5k3gsQfIJ
	U6vAJM3uSfz+vk8arSsHgQ7+bY7iPHf4baB7jcQ+oi16VTnqEfGS53pX27
X-Received: by 2002:a17:903:8d0:b0:2b0:5738:9817 with SMTP id d9443c01a7336-2b06e3d2f5amr75086095ad.31.1773913692474;
        Thu, 19 Mar 2026 02:48:12 -0700 (PDT)
X-Received: by 2002:a17:903:8d0:b0:2b0:5738:9817 with SMTP id d9443c01a7336-2b06e3d2f5amr75085825ad.31.1773913692001;
        Thu, 19 Mar 2026 02:48:12 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e63a971sm90445655ad.83.2026.03.19.02.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 02:48:11 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 15:18:08 +0530
Subject: [PATCH] serial: qcom-geni: drop stray newline format specifier
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-drop_stray_n-v1-1-37fb619538bb@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFfGu2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDY0NL3ZSi/IL44pKixMr4PN3UpBTzxBQjc/M0yxQloJaCotS0zAqwcdG
 xtbUAK0k9gl4AAAA=
X-Change-ID: 20260319-drop_stray_n-ebd7ad277f9d
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773913689; l=1197;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=kS4fJc5ORDfQmCS1Co6/IOO3+J4q9DKDhUB6N1RE7BQ=;
 b=cwD/CR2i/S8KWoHRl+j+Sa+TaFj8AYpvO5+5lEjayX4JqhuJ1atDRcSDmECO0lXtbPfqGc2eU
 JPpgdnoG3XwBPl+59dxoA3VcfVlJlsWl5nJTZAjLaz+pYBjoKlDvj3P
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-ORIG-GUID: rRoUpTwygzBRBq8ndUVSqsY1_36Zq68d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA3NyBTYWx0ZWRfX4DlnTTT8itHT
 ASFAXBLt3Y9hI9lM04D3fi/xkuY9YRd+edFtQ1AeTX4pZC/SuJkYT51XhHzjjxNq+dIvOX1YFtM
 XZqcYVg2lUtzwzYoALZk4tWCFJ2PZq0+qwOo/2FfD3dg6n95459GqpbtY6Qym28kTi70rnAKhtV
 a9f0F+EbmkkjMXqqZ2cmYudP9PalJoBffxm6TSFAouwOszYUMQ/IV9hA+PqEVZ8UCAkXfAmL3+d
 Iyzj/4JqRcNt9WkvXQHlpZnVlv0JKLh/LJ/O/AkCwnuRpS664ni5KkQL/ElC7fiafTpFXkuUlyH
 VNQ2qi0hpzfxMXQBZjUBCtFH3oMD91aHR6My64Qu+iF8jitx3awVS88IwKBE/QMSHBd+zRxLe1M
 KG9eJtllqmW8qBbDsYosguRWkjBBa4U9t45JRodTbjnR8MYc3HF5bYrbf5Ee3SrKmJx+lRigvoq
 PEG6R36I+r3TPm07CtQ==
X-Proofpoint-GUID: rRoUpTwygzBRBq8ndUVSqsY1_36Zq68d
X-Authority-Analysis: v=2.4 cv=PtCergM3 c=1 sm=1 tr=0 ts=69bbc65d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=D4N4v3-LJzNxafR2K_MA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190077

Drop the newline character from the middle of the printk message.
This avoids breaking the message into two lines unnecessarily.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 9854bb2406e3fc830323ebbfdef1e471f00fa416..b365dd5da3cb799c4ec241724310c23d6bf7e16a 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1282,7 +1282,7 @@ static int geni_serial_set_rate(struct uart_port *uport, unsigned int baud)
 		return -EINVAL;
 	}
 
-	dev_dbg(port->se.dev, "desired_rate = %u, clk_rate = %lu, clk_div = %u\n, clk_idx = %u\n",
+	dev_dbg(port->se.dev, "desired_rate = %u, clk_rate = %lu, clk_div = %u, clk_idx = %u\n",
 		baud * sampling_rate, clk_rate, clk_div, clk_idx);
 
 	uport->uartclk = clk_rate;

---
base-commit: 8e42d2514a7e8eb8d740d0ba82339dd6c0b6463f
change-id: 20260319-drop_stray_n-ebd7ad277f9d

Best regards,
-- 
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

