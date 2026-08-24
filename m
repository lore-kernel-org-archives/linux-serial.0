Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACD83672BF
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581947; cv=none; b=ONbtZQX2jSs46sqMZ/k6biZqfCLt+SDY4BRJqaJjMgGq+wQLs9+oA8mypuAwq72SUVth7ElxjZ0UZa8OiCMHdLgcp4kukLB1kKU2j15/JkBmGmVqjtpSeNfqYGfkytmzUqQgEy4z/9CizDicXdt3cGsiF/PYaP5q2LAbzEGsbX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581947; c=relaxed/simple;
	bh=lZhPUxX46U8cz7NCrnERk6mwOihx4Cpq1wkLQOYWdvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MDUuTnP3aC3lmymm3AlKrK9ciPwpKU0rFQMHzCSXd3umw8zSxDBb2rwqwRP0GWeS/eHboLci/SIaT9B8Dp7w0TFk4JhXHKWY9IiFYFliy8sEWvQ+z9ZA7uJYYobuPxmZSftOouzIl9Bbtn7s3/bXAseiDalnd3NlMH8jgeXSQ1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cA17SWBa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UKnxZ0/P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cA17SWBa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UKnxZ0/P"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OCv3mI1880670
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 14:32:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lzgtT73adN8oD8okeoxk47
	Ph58ooJDhQByvZ1BW01M0=; b=cA17SWBaeU54q1/NqbT96chGFfF4/0TdOB3r+G
	EFPhVoVvJzcQFz5Rx/Xc8YqruPTDgIWmNr7Om0MBzPTNF+iNYLFcyuBORb71EIyd
	xh8l53S90n+Rf4Xf4btDPkA6EDvFod3mTh7mtlkaDZHoQ6Z9sfAqr6hrwNj//w22
	Rb40M5855TALhG9HhoZXevIj//Uc/eeFihBMeyoONk7D4b74IAgrt/znLd9Qpulb
	s3ylspud7JsG3IXwi4YtrmYmWx/SpEJ7pMvW1iMptJ/z5QyIbZfWldQhflwP0ZsG
	OOr4a6Ky9CPL8Q845SNpcicyLAVHEAwginSc37oTM+nQjGMA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8huf1p8g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 14:32:23 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8485b7e18b4so5856817b3a.1
        for <linux-serial@vger.kernel.org>; Mon, 24 Aug 2026 07:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787581942; x=1788186742; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lzgtT73adN8oD8okeoxk47Ph58ooJDhQByvZ1BW01M0=;
        b=UKnxZ0/PUHXBTHCLEovv1FlZstUxccBtkYg8E8+1xKANhczJ0TnmiJsijAJKDWPVIn
         FUwH7zChU0HqKfvRIlfgraqRXQEV96p/YmyaIqei5kunPQFbHy15Th/X0WWKuCPDr02a
         uHMF9P9j1f9QgM1oNprOtA8iioSACphwG671TE06LpEWLi4k0ELbCgwfucH+31VywdhZ
         mLU2kOBgoaWGdva25Z/AWgdpJ9QmCTLjUy6667xpZiu0a9yL2AxITqndI0Gi5v7WPPug
         yA77Od1WANHcU9ZeNUQO8ASbXVfaNX26aCrCpj1GUyZ4zKAhqNJIYbT1pbJKKW/OUCwO
         rEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787581942; x=1788186742;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lzgtT73adN8oD8okeoxk47Ph58ooJDhQByvZ1BW01M0=;
        b=VyfTfndCw+v8zE0DjOfKGy7MRIGB/96jfAeqWfbFW4SloUmJqPiaOFzngKHfIq8qWN
         x5/NiOuJgU3to8SR4FosPn8pwa3ySigriXoBByeps4szlfB2kuH8VO8vSdzrvBz5dE3y
         7YaSaYDSqLKZOTs+lOog/vzE+Jxw04LSz+sMqnHRFV1DqY9dGNlZpM9CaLo/4+PFYBF7
         NWRs5G4VP98geyP5ADdBGcVEl1IKzmPg+EZj6XpbNmnb+Vk6ieW3M176DWgDOgfecY13
         s1c7x9kTWx/FH1sXi5DoOhYGQCXReJFBVKcM5oLhufAO4U+ZV2IeGpB8Spiew2yZrZET
         8+qA==
X-Forwarded-Encrypted: i=1; AHgh+RqM9SP0KJyY3ultwYX8pD6mieBHHZoeiDHi3qC75lJ1HCDsbQAikGpUuv9okNwsE9jdaAV4e9zq576mO14=@vger.kernel.org
X-Gm-Message-State: AFuF++nDqKiHLcnVxPAjstY66sPdxR5dS4RmxiDnqbQRc8BItPStay24
	qGb+rb/s5lw80swJgRBlXkSxNTj4yVMwv0UmS1YsEs+mhIF3NlK+CeLEiHY4uqeYwRyoerVCu5y
	BIkL23WvplHbax2/dyD4Nc/vovyCW3gHU3pMrXLT8DLDyT1qgQbu/cXXcOWTPuIAldH6um9Lc3F
	E=
X-Gm-Gg: AR+sD10YtDlLJvU7hpZ51uHW8fTfz/Rk0cfW25wlomFoGayzlsTXWAAdIBrM9hKPQee
	3vDt8JgoREbJzORfUfe8fYPRHnu9wAYyTeItuKj9SgNbS6u15N8huiJ44RdqMwVEHhOPghx9OGe
	BcdMxoLYSww76YCmiXwva/VK+Y8LEjEfZMEEbwdyT+NxAZiJ4IHN5OGTd3jpcZne2SCZY9VCRhn
	O/RqA5IU/UH3+J6+WqJ0rKAeLJk8JJURX1eA7ED9Tod+vXkjHrMEZirWJMS6BhuWhrHM2OkVtK9
	UgvdIyJm0mmlYRuvWuFtlgtLrMwzFkICZGD3AJT0E5CAMgbJhOw2dkUh7+fP1My/KHtO/BKaEMN
	qXAopSxy1qeCsMA3teLeQclaYh1nD7+A3nQ==
X-Received: by 2002:a05:6a00:2d02:b0:851:92fe:504b with SMTP id d2e1a72fcca58-8520b9fff6bmr26848328b3a.7.1787581942493;
        Mon, 24 Aug 2026 07:32:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d02:b0:851:92fe:504b with SMTP id d2e1a72fcca58-8520b9fff6bmr26848153b3a.7.1787581941732;
        Mon, 24 Aug 2026 07:32:21 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f161e29sm2062684b3a.56.2026.08.24.07.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 07:32:20 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 20:00:17 +0530
Subject: [PATCH v2] serial: qcom-geni: Drop unsafe rx_buf realloc from
 setup_fifos()
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-drop-unsafe-rx-buf-realloc-from-setup-fifos-v2-1-9a1c8f711e98@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHhVjGoC/5WOQQqDMBBFryJZd8RMtUhXvUdxYeKkpqixGSMW8
 e6Nlh6gmw8PPv/9VTB5SyyuySo8zZatGyLgKRG6rYcHgW0iC8zwkpWI0Hg3Qhi4NgR+ARUMeKq
 7zmkw3vXANIURjDWOAVWJpDKtiiYXcXH0ZOxy2O7VlzmoJ+lpV+yN1vLk/Pu4M8u99zPnf5lnC
 RIKbPAsdZlnJG+OOX2FutOu79MYotq27QNQUMA2/wAAAA==
X-Change-ID: 20260822-drop-unsafe-rx-buf-realloc-from-setup-fifos-2b82eb0cb5d4
To: konrad.dybcio@oss.qualcomm.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787581830; l=2545;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=lZhPUxX46U8cz7NCrnERk6mwOihx4Cpq1wkLQOYWdvY=;
 b=E7kyAPaXnQwNN5xXNYO6MsOW+aTsbNY8/GnIHw2mXSJMp6Kere5IyvscSKX0NXvICgrQ4VLer
 JAQSMu/ZiGZCMncQ3Q7wiZPf52cp0oN4VHdcjneWInefRkt64LGLaAo
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX3mlyXPpcYMPx
 CDka7rTSwJZqkjsSOP9A8zvltrJuYjjehq2Ngu417i/UMjPSnc/vkrlYfUnjYkbFQ8N1pD1hMK7
 MGDzpOS2Ybi3kpHa+QbJ7LEFZY7PZvQ=
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a8c55f7 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=rO80i1saf4kzB67oEq4A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 7QNugdtLBoWXZm2qOr19pmPztaZb9nbm
X-Proofpoint-GUID: 7QNugdtLBoWXZm2qOr19pmPztaZb9nbm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyMiBTYWx0ZWRfX2+mAZ4pzmQfl
 ALosywQizwht67ST2CJykPlMMeG5RsgaTHiCzScO19xA8onnmUOTyDonT3naiyD6u3f+c3u5kL2
 ben2dUDxUfAEFVRgj13KbTSwAwKDaRd6Z8CHMxcY/J6RC+94XllhqxmvYjDVRgG2fr4ZIIYagIG
 FiOKRiEuPxnkkuUG26aLfap9IXILBu4cRlcRYendlHGUbUqJkCO/UijXJyg8xqzEUFAK55gQ49K
 4DRLgws9xlrrZsQLyQ8Eymn2Lq19OwdYkNFBAHwOUmQsuNWX6SxZweBeNQArp9qgp2kzrjdGycq
 FfTDMgPXC9k7yUt+U9G1GcqhX8YbZ9j6B0KHeQnuag56+63IHzymLZKLnloYhCn/QgkMWo6t8T+
 L58JhPWViU2XI1lJcqXaL/8dHX4b+j+bMDLnIuCDwi8SEQ0UJ3pYw/w8ZAA/ZfYaJmf0y/dSB+A
 k8J46RG72HHU1cQA3gA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240122

The RX buffer is allocated once during probe using a fixed DMA_RX_BUF_SIZE
and is DMA-mapped for the lifetime of the port. However, setup_fifos()
attempts to reallocate rx_buf whenever the reported RX FIFO depth changes.
Since the DMA mapping is not re-established after reallocation, the buffer
pointer may change while the DMA engine continues using the stale DMA
address. This can result in RX DMA targeting memory that no longer
corresponds to the active buffer, leading to invalid DMA accesses and
potential memory corruption.

The RX FIFO depth is unrelated to the size of rx_buf. The buffer is
allocated independently using DMA_RX_BUF_SIZE and all RX DMA paths consume
it at that fixed size. As such, resizing the buffer based on FIFO depth
changes provides no functional benefit.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v2:
- Updated correct mail id.
- Link to v1: https://patch.msgid.link/20260824-drop-unsafe-rx-buf-realloc-from-setup-fifos-v1-1-52d231c840e1@oss.qualcomm.com
---
 drivers/tty/serial/qcom_geni_serial.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 3633723acef8..75b2e0b77d05 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1291,7 +1291,6 @@ static irqreturn_t qcom_geni_serial_isr(int isr, void *dev)
 static int setup_fifos(struct qcom_geni_serial_port *port)
 {
 	struct uart_port *uport;
-	u32 old_rx_fifo_depth = port->rx_fifo_depth;
 
 	uport = &port->uport;
 	port->tx_fifo_depth = geni_se_get_tx_fifo_depth(&port->se);
@@ -1300,19 +1299,6 @@ static int setup_fifos(struct qcom_geni_serial_port *port)
 	uport->fifosize =
 		(port->tx_fifo_depth * port->tx_fifo_width) / BITS_PER_BYTE;
 
-	if (port->rx_buf && (old_rx_fifo_depth != port->rx_fifo_depth) && port->rx_fifo_depth) {
-		/*
-		 * Use krealloc rather than krealloc_array because rx_buf is
-		 * accessed as 1 byte entries as well as 4 byte entries so it's
-		 * not necessarily an array.
-		 */
-		port->rx_buf = devm_krealloc(uport->dev, port->rx_buf,
-					     port->rx_fifo_depth * sizeof(u32),
-					     GFP_KERNEL);
-		if (!port->rx_buf)
-			return -ENOMEM;
-	}
-
 	return 0;
 }
 

---
base-commit: 903c1cf6dff9964e71eda98a39e2e5d442050472
change-id: 20260822-drop-unsafe-rx-buf-realloc-from-setup-fifos-2b82eb0cb5d4

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

