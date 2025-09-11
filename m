Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C480425A333
	for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 04:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757565231; cv=none; b=r6M6BAT6PYfqOtr3etCCr56Kkj89oXUxikfF1Rseas/Mo6oByimbInTbvnjgqvFhU+Acr5cgn3d0qf4t5suYqlUkGmI/K8qn9nr9wk8+keSykrJHMARYrjs1zuwQxjd4+NULF+gsbM4gZIB31TYP6SqU+liIK7xocc0LDTgJ664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757565231; c=relaxed/simple;
	bh=mx4d1AM06bO2S1IONf8a/pO/zrCQyz3bPkPpHgejOOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jgjTq5dmHLOUsfdjt4cRxD0elSkEu0zefqamnprDTc4TqevXT/1dfidFsOaSWBbnsPDi20ZoOx3JRppiZzKuwcx1VyviUOaI2klx8e+xe/xwpxOP0sWxWTtO3LjF1LdxGxDboO9PPUz2Pi4NLr5RbyF4QMsgQ4neyFldOcPThRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U/H6jqJN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U/H6jqJN"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2IV7d008188
	for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 04:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kcphrBZS8ap
	5SJ3Zmdf0DUuuF1sTIEHZQlGDR6UGNHQ=; b=U/H6jqJNTXVfBG/btaflFrby2c5
	7fuRKskqtI9rpIgBmNvsFCtvNfPhQ5mKFn0ba4eTLfDFaRuyh6Ao4AlNw5AZdP0E
	k3J1uF7NNnGizXcDrZ7q8c8t5j/7C2ySA54Ro6r2jnXz9JYMjFQrS6ORPmJC+w+U
	f8lK1Uzy0atFuwJ3TnptBSy1bgk8EvFkJeW3tN0oKxxR0Wm+0hOfz2oFpymQCU1p
	9rFjxieKXS44b5rmOjzYAgP2GbPpq2+gQV8hLzV2VxaQvIayZfVbnwvBiCLoCsUv
	Obz3BPq13zNqwh2GtYiuG6WlsyNc/RhmhMx08UXKcWiYBp+2ax0KjfUoQ5w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490aapph1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 11 Sep 2025 04:33:48 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24cda4063easo4113845ad.2
        for <linux-serial@vger.kernel.org>; Wed, 10 Sep 2025 21:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757565227; x=1758170027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcphrBZS8ap5SJ3Zmdf0DUuuF1sTIEHZQlGDR6UGNHQ=;
        b=a3yHdGLPzA0TifwCZOfKz9x88c8f4Zs5h94cb8Q7Xrr9HRcLyio83OxZH+BatAh0LG
         /ILspnJ78Ao6Ckb1R7YkjTp11iZr1yp0/ISSYYIFqFWC1DF/+4xBxJPoXlnQFBLozU3P
         IXoNLlHeUzly/W0OttQ8cpfOScdREXMFaPSimtBRiYlin1sJVxOtjDANLQqH3yS0yOza
         sCaOhAaWP0Re+isrNvAGMCvDDSCJ5vj6h/d6tvH+arAjcBIPZVvi6aJLf5WETcFAYmRl
         LMepC052X20o8YkY5BISsfR/GaPCQVTTCK1IcRQaLY58cj/S6/f5Nrw0+pl14/Coz7Ft
         xqcA==
X-Forwarded-Encrypted: i=1; AJvYcCUOY/If2+4Z6EfemsRN3pgW1CyrO38J1Ybgx1D7WcYMXQVl4Ot4CdF+9QNiyoBJTUfXZQfAZ7aM9YaOyI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFHJWmu0T6OUlMP44l/NgRhR+Ntj3rJi3HdZK6xEP2TPBCF2MZ
	xbHMRPhDc6xOiKEA2Rb2EnUNa7hvMhcjFNLyBfs7YUFOpxQM0T0gpGwLdnq6Tnozt12wg1En5+u
	ziGTAgW3p+hmFlRqdsyJ5NdEiXX12l80KQlqrAB8kbCKShxC1PabQjkSmi6Ox03yS92w=
X-Gm-Gg: ASbGncszfHDBQbOdpGjicHg6zBp5iQI/i1yaysgrxVn43gHEnfTnn6jhDctibdqVJ3B
	jpg6L7yDImVT2NSZBfSyNp4by/PC5IQx15CoSsV6+eAAM6wwRRQ1M7RjLZCg7iS1KEAokdAeYAU
	nMY4KcEDuEdMIRVxHjmQTNYNpI9k1zHXaP5urfrvsLTo5RzSx1M8Zh9MgoEpQBF0s/jzTWgQVks
	hmnrfHlLSsGGsPVNpanLbKwuqt+YdwTrvYvjd6A3kjVVtnWBWtvYIZ6uBIc5NOYzbbxLgwmuvja
	BvUqUPW5rlZ4R8clwoxC8lxPs0mRZc4+ANhq93JIdoa1t1eyrEZ1Osdvj7CihRD2zJTjnqGW+MB
	b
X-Received: by 2002:a17:902:db0d:b0:25c:2ed4:fd7f with SMTP id d9443c01a7336-25c2ed50044mr8373345ad.42.1757565227079;
        Wed, 10 Sep 2025 21:33:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJSDLFBIfEII/dWtZuLvluQE5OM8yus/jL1cVR398t46tsI0mtRTv1Sd8hk0JJ82ColwGboA==
X-Received: by 2002:a17:902:db0d:b0:25c:2ed4:fd7f with SMTP id d9443c01a7336-25c2ed50044mr8372875ad.42.1757565226545;
        Wed, 10 Sep 2025 21:33:46 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a46csm4323975ad.91.2025.09.10.21.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 21:33:46 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, broonie@kernel.org,
        johan+linaro@kernel.org, dianders@chromium.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v7 6/6] serial: qcom-geni: Load UART qup Firmware from linux side
Date: Thu, 11 Sep 2025 10:02:56 +0530
Message-Id: <20250911043256.3523057-7-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911043256.3523057-1-viken.dadhaniya@oss.qualcomm.com>
References: <20250911043256.3523057-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=eMETjGp1 c=1 sm=1 tr=0 ts=68c2512c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=9JGZuxy38fRfBSF6gCkA:9 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: x7bpPWoNBgk1UUncJKmSlBE1fo5nVLMT
X-Proofpoint-ORIG-GUID: x7bpPWoNBgk1UUncJKmSlBE1fo5nVLMT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX3FrVs9h7qgfn
 NI2zO8aCzfo6oS1zgxMBCcVpFHHeVv84CGEoxHY8oIJlEGd+1yK2I2tbNvYCgWrI9nhMG8I5u5V
 LIw1gB/tseSYiPkhYUSvGqHQpOVKQxmdwVXZMMTqX7Gr3yOMnhSIZiqmsh/LY4LSSM5+8R8soUd
 do8XZFPEZypKH2fQ/cj80jmddzWhmI2Eo+PUi6RkSM0icZ1zPvZxrUDSeSpMKCm0k3cOxT9lKua
 j3oUBvq64wF8TTS9yOauV+qmNnD/0eLr9Dw5tT9cL6lwKKW58PDCq50xnNrc1inFYqdm2KZ7JuW
 lbgIt8xQ5biNS+F4hapYjPaMBAZjfBwsH4j7A93DlX56rYNkGeUccUBoYl9dfLHDBXYJdMk0TEN
 1xAvNOc4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060000

Add provision to load firmware of Serial engine for UART protocol from
Linux Execution Environment on running on APPS processor.

Co-developed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
Dependencies:

This patch depends on patch 3 of this series.

v6 -> v7:

- No change.

v6 Link: https://lore.kernel.org/all/20250822072651.510027-7-viken.dadhaniya@oss.qualcomm.com/

v5 -> v6:

- No change.

v5 Link: https://lore.kernel.org/linux-i2c/20250624095102.1587580-6-viken.dadhaniya@oss.qualcomm.com/

v4 -> v5:

- Updated the email domain from 'quic' to 'oss'.

v4 Link: https://lore.kernel.org/all/20250503111029.3583807-6-quic_vdadhani@quicinc.com/

v3 -> v4:

- Add a patch dependency note.

v3 Link: https://lore.kernel.org/linux-arm-msm/20250303124349.3474185-10-quic_vdadhani@quicinc.com/

v2 -> v3:

- Load firmware only if the protocol is invalid.

v2 Link: https://lore.kernel.org/linux-arm-msm/20250124105309.295769-9-quic_vdadhani@quicinc.com/

v1 -> v2:

- No change.

v1 Link: https://lore.kernel.org/linux-arm-msm/20241204150326.1470749-8-quic_vdadhani@quicinc.com/
---
---
 drivers/tty/serial/qcom_geni_serial.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 0fdda3a1e70b..ce5cb97d60a7 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1184,7 +1184,13 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 	int ret;
 
 	proto = geni_se_read_proto(&port->se);
-	if (proto != GENI_SE_UART) {
+	if (proto == GENI_SE_INVALID_PROTO) {
+		ret = geni_load_se_firmware(&port->se, GENI_SE_UART);
+		if (ret) {
+			dev_err(uport->dev, "UART firmware load failed ret: %d\n", ret);
+			return ret;
+		}
+	} else if (proto != GENI_SE_UART) {
 		dev_err(uport->dev, "Invalid FW loaded, proto: %d\n", proto);
 		return -ENXIO;
 	}
-- 
2.34.1

