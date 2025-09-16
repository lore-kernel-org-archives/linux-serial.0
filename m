Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B8283FFB
	for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2025 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015618; cv=none; b=ug+mmBC6yBKzWhv464RlS42JfJFBp/IggayHzqiYkBTWMw8iDpQmkdsE5w6/1gk6W6et28+N3/a/IJUNMHO3c4UKSw3xt2oZbqsSmv0wkBP5EJTijbreU/OZsixSZpDLq1iH0pda/9BDOB9ViQ4X+jUfsM9GP/BAKzGtaIFbCOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015618; c=relaxed/simple;
	bh=/AN0edio5MaldEncQLvD0kSKxTKUGpgRttz9iXUqZxk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ofI9DiQCW+il1k65srDa+iN3YHX5hPnZCcnSv8t+ziL8g36Y4LhxjI2fCfo+kueTI65vGnGnclxjKFzduJK7+n/7aiecpmNbAZnn2ZCF9VXEAEwiW5pd2X4dK2waQV1DNVbIrGtzPu9Mr3bMpwhlXXy4ocHaaTFz9u+UbfAR7DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EZMzOkBu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EZMzOkBu"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G3pn1v005337
	for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2025 09:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=SdbaG+qQMcuHskGeXqpUq0AHk1Ukw/1hxqZ
	/MRYhBG0=; b=EZMzOkBufAGzt8zUKa+ntj9/CVAth93d+7cckdcF8ZTiDToWPuG
	CscdwL+BVXtjmkPH0VohXQCskDnrtjelQBRHsrha1Cs9tEyIWYdcx+bvt/YTwIo7
	Tin5+4pB3Oc2wxQuRsMZGrJn5YRJgZJo5guCmcoihIMAXTLOOx/MRnR0qS4yReuS
	GNvFAdqE4tox4iHAJajKJfi/VtG4Dr7Fcs9QIJxiHMeP6B2Lj7yzjU2DyoCOseku
	2q/AqJ50zm6NYDacIUl5AOgoIBShsjEGQO0bAEL9WMkQLLMO9OKdDSGTTHU0NvPx
	9DnReY10lUbGmEO7gucYkowJ2aJP7ilAylA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g5n418q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2025 09:40:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-25d7c72e163so80468735ad.0
        for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2025 02:40:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015615; x=1758620415;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SdbaG+qQMcuHskGeXqpUq0AHk1Ukw/1hxqZ/MRYhBG0=;
        b=akdO403oOAZgVbYeoFZ/evihgbAirLDEqhMyAn/gPMuEkl/dcB4rp1HjAhkVE4G/w4
         vAt5oaVsgcMnAE4F2QjWS4cq/mmaO/cSfl57gE5vLDSKoEx7wnFSLCTDIuoHJ5r6jw1D
         vPwEJJMkhkJJG/rNQi5tg+Ad1FSMXH0eh/4K7XDyeCh+56EH+EmYJbSfjr+wmVS5Jc/6
         q1S9uwaX1J3ZIR/sdoqrdIGub7uJTKmkTgzLICfb5trl+e6J8GmqXg0cT2sdVpecJ0Cj
         AGGhIyjs2NxG5jOrNKLiu84C4CAcwBAVve6XE370l5+xCcHM3nc4kDsHJtFnlXLkqGAb
         D6Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUnJd8mYHxIz57IG112pqwytWcSIQX0qtq0jvscEAAS5QILkuwomWK6gafl+0toiypZUqvqQ/2lK2MBejw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUy/gGYdY3oLRFoMOgIjtsxPgAO6iaUXxdEeVZZbn/xxqwaOff
	nJHj8WmhaSn0DiY5wqm3HgKmEbIkhGjCTLisoujdO3ZTsXonq+fs78X6/SO+O8SH/OTaHSbR/Bs
	HLfF9buWVX/tV9FOKG0w9CKTby8gcYWkW66qg0R+g2MpQ6rGuK3qmRTZasjCkyBVigi8=
X-Gm-Gg: ASbGncuQv1DkGuGZpvdFbR6Hj5jqRV8rfHrNXLiZOP9NgEUXXsPrdPlO1PVBWPcXULw
	zA7aSNbFFUc2zLLHw7lrCDyq3/gz4M3kXSc9OZ/Adh1HARQhDijdRDulq5Cya/WpM8bdglgmllK
	BOuOZR96/xGzwhh/kYwTflnt+vzbFPA6L2c8/3pCGdlvoKyFCJ9J0G70GHG4X/2YmnmzDTBC//D
	0SdXJTnb/Epc5QPKthwPcZKpogjYWnW+UDNYh42CRda2CKl0zjO9O2bWih11xFiSFICP8bkJmqv
	aAtpKu/Xtc1KVDs5RybEOy9Hf2RkBuxl5Nxm7aV/8KoIRRS88poD8YiBafvrczTJQOLZyz4E9A=
	=
X-Received: by 2002:a17:903:3c2d:b0:25c:b543:2da7 with SMTP id d9443c01a7336-25d2528c254mr178027525ad.9.1758015615269;
        Tue, 16 Sep 2025 02:40:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3iRujT5RyN/Y70BYxNaVIMPtLsc7G5+gxIL9VhuL7Lh/nsZi48blzFd7jfvLmyl8MB9cHzg==
X-Received: by 2002:a17:903:3c2d:b0:25c:b543:2da7 with SMTP id d9443c01a7336-25d2528c254mr178027315ad.9.1758015614822;
        Tue, 16 Sep 2025 02:40:14 -0700 (PDT)
Received: from hu-anupkulk-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2663f633893sm55434465ad.119.2025.09.16.02.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:40:14 -0700 (PDT)
From: Anup Kulkarni <anup.kulkarni@oss.qualcomm.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org, johan+linaro@kernel.org,
        dianders@chromium.org, quic_ptalari@quicinc.com,
        bryan.odonoghue@linaro.org, quic_zongjian@quicinc.com,
        anup.kulkarni@oss.qualcomm.com, quic_jseerapu@quicinc.com,
        quic_vdadhani@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com, viken.dadhaniya@oss.qualcomm.com,
        stable@vger.kernel.org
Subject: [PATCH v1] tty: serial: qcom_geni_serial: Fix error handling for RS485 mode
Date: Tue, 16 Sep 2025 15:09:57 +0530
Message-Id: <20250916093957.4058328-1-anup.kulkarni@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4FmWiZbwVOL7_fXbHqCaIMegJL7oRJfY
X-Proofpoint-ORIG-GUID: 4FmWiZbwVOL7_fXbHqCaIMegJL7oRJfY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NyBTYWx0ZWRfXz/7xB2ExR6C1
 MNmvZN4btJ77NENKFLbfbz1JhSmwuCo9zCoeuKztq3HUJV4dJd6vi3PQ7YAy68dU04eY+knFgHU
 4jI8x/MgQms7tYbJHa7GPxH1CzwMqWm5bKN09yB0dO/VrK89Kghi/Qwkyk4c4GgNRhnAnUc5a9f
 6DWvZqf+vRMTipO5WEzDxhzwxuBfGqwtvSUezlZA624drjaOipLmADphg+P7kzcJ0230ebRV0BM
 fYMZlalgLOB2xNNrEHOqY2+HIpWWf755t0lOB61cdJwC3sdPOKcQNqE1bf9aMFfi9LV7z/sXvrH
 vCK++MF6iO2TlAkH0GDjz6738KtXpuSFibd8oL1cqzSp6vsjCJeD7PaI5VPuJm4QFcOlMZvyvMg
 /KowfzV4
X-Authority-Analysis: v=2.4 cv=SaD3duRu c=1 sm=1 tr=0 ts=68c93080 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ZXCm3_ECWB7Dsui8_W4A:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150087

If uart_get_rs485() fails, the driver returns without detaching
the PM domain list.

Fix the error handling path in uart_get_rs485_mode() to ensure the
PM domain list is detached before exiting.

Fixes: 86fa39dd6fb7 ("serial: qcom-geni: Enable Serial on SA8255p Qualcomm platforms")
Cc: stable@vger.kernel.org
Signed-off-by: Anup Kulkarni <anup.kulkarni@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 9c7b1cea7cfe..0fc0f215b85c 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1928,7 +1928,7 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 
 	ret = uart_get_rs485_mode(uport);
 	if (ret)
-		return ret;
+		goto error;
 
 	devm_pm_runtime_enable(port->se.dev);
 
-- 
2.34.1

