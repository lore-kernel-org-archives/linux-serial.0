Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9101F3909AE
	for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2026 07:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777273260; cv=none; b=ffoauHU5M4vlnMQhL8NXRl+ZUdySQzkRNWBv8sfVVOeF23WGD8nXmJz0R1h2DjqP6deSZkyYuNmVWFqAER8u02lwtGRqfMQKsRhtpIVBqllFjgvZE3R3u0BSO+eXTqnzhzJA91nTQ4cJM6s4eVSxV8Jiu9bvvfDCDJUwhYJDDiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777273260; c=relaxed/simple;
	bh=ugik/6RlZSUdiUsj48iLPpckt7kO/YmHHtrl32iY6P4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CdReN/sM9S+2V0v1FbAqoGQZzgqf5FjBO7b8VET38Q4kXY5PiHVye6ABbNxZ9TVgEI0NNn05tYLAvdKRGz0gjdZZV3HGNqoKobIZwpBcVo9YM1v9TkXND+xfHYCBt1FT44E+AySo/QXgBi+pvBkHx8Go1i7u8nzG2v8Bl2yg0nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BDbpo84L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FnvAujwV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BDbpo84L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FnvAujwV"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R6S4t63826669
	for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2026 07:00:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=XEUNKB6S8+Z+9ojQ8hs2qtCRBWWnjBnkbdL
	ux74/eoI=; b=BDbpo84LFg6/ELt7hccQsgnJ6QLYDsxBFEHFqoU6Svuba/6NbOy
	BxR1xdeWV5t4Gcv3Yt1pexzCC7QzEUU3GImVv2rske1uyRcPRX6c5inzHFtsRmje
	11VCLW1mmudgfWtXClak8+6n9awBkpPxgrgWEdCWSgkI0C4QdpKFMYanZpHSQTre
	6aSqnIMskn4C8NmIpPmu7bxMx4s6czuRka7z6xNvqFsBU5SvlmDx2Mbwzi5vWWoe
	d2HZkzp4XgZl8m7DD75Bzxyp4oGniqinukRmB4lcotjeyNfbqDBAXn13oknc/I3f
	0EkbSA06T0B2hk9GbyxnrLbqYe9+IZt3zRA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drpw9cpn4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2026 07:00:59 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-95674175677so3336509241.3
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2026 00:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777273258; x=1777878058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XEUNKB6S8+Z+9ojQ8hs2qtCRBWWnjBnkbdLux74/eoI=;
        b=FnvAujwVk+ecBvwC6KJttfrn9axbRzhfD8Bsg1ZTsGQ087oe4G3zapT0P/t90nMJNB
         G8aMRN1x9uYzQD+7nMuely+myHBB8l1kUEmCpWfbfguxqihC4E/+5KNFIsdIoG/SJ5NE
         wS/iHtgc4rQI0VFA2dKIsRCg/LABV5wmbsyW3pAIdE3AakKKb1xq0zMImkVM99IHFxcc
         q5tLR/bjI5CdNjZbmnh0KpUzDAsSUnRV+wpAuOtuWtqZNMDjvpVpWqJFc4LHEllQoWOY
         Dn2UylhMVn+XW+SpwcrQ3MJPUsxdumXO2p5FYt1JcniEp7D1b9sZtPiliWkVqeuYMMxW
         37qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777273258; x=1777878058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEUNKB6S8+Z+9ojQ8hs2qtCRBWWnjBnkbdLux74/eoI=;
        b=eCSE0b9AQC0+bR0tBCO35b24UYJNUnsayVZfkcTK5xihCjYcTrKAv9WoOfJK6G/9RT
         SCpJHl/DedSuZjJHRxx0YGwHF5cCBOwJ1BNuwt1YDtqIiCa9WDxGp7VPx+/yhV1nYtxJ
         ogc722LFeNYpimSnKfmzgqjp95h377ObVDlRqcgp4H+Ruh3qaTu5wZRYq7SPjXsMFCfr
         NYAMx28mWy+wX/ZYaWXKzYejOTaxSUnEZBGQhVyiAf8TmPON4M87huf7zURoAqarJ92S
         pWSZzYPJ8X5V0XM4RvAGf68dRbnllFG5zu4xYtmQiaPFGT7PS5PiFFtQVV5I1VzKzM/s
         taRg==
X-Forwarded-Encrypted: i=1; AFNElJ9xy9w3IyIOiksdI2eGCTp9rVHPliJSFt6NBpIXDOs7QKcNwM7cZ5JyfsCbM+fflfXSm4K5ItnbZkHshO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAkmG1ZPUy3Yy4hqz7Pw6dYAJt9GchTHuo7GJ9idFvU2zuG/ky
	s0lHGGSFminDgbs9HOW1SgepGRRfbeZlVNqW8xS6cPy6NIgbZtLwqU/vA/SmlzZdq+LK1u1gVgb
	o3sl6RyotLvGhPRQIq50Ig7ErjA9gj2AHLaee/n5wyUdO5A8IYGJ28REYeZUHfJAcfEg=
X-Gm-Gg: AeBDievqgSpKh1nPG9sRHP4nrgq7D1Vc0liBK05C9uJZVKranlvTxF7M9CVR+jwOSL2
	dbKdFCt0TPr+1H5TKdAXzysL4s7yp8ayW6JvLj4t3Hrc6RyexQ8tS2l6DVFr0tIhUgjsT0Zsd6M
	0eoojvfZ4j7MYkc3icXcP1O5XtDAIvAOlKQCRvhxuJlu3u4+c+Nq0dcf7WPIvkZA9+LEUOka2KQ
	uWxr1kwLrP/6Uhm6aCY8+ihugJE/BE3uDbEbb3Tq2XSgpFTYG2o02SDbx84HV6N0DanRAkckeTu
	38LeFylbIpqelQsI4/NZiW52P+iDH8ts803RVP2ptWuihz7ma7b1mvQ/MZncg98hTEEAHsFOEAm
	Jxv+C0okjjTLu3vfpJNbRfYdS+c5/Rg3KubQpLc5LQ8x/EtAvB5XHwwQDuhpEEYpXxEzplkJbAq
	p7Qd3lW1PSKg==
X-Received: by 2002:a05:6102:290b:b0:605:62eb:46f5 with SMTP id ada2fe7eead31-616f740628fmr17820432137.14.1777273258052;
        Mon, 27 Apr 2026 00:00:58 -0700 (PDT)
X-Received: by 2002:a05:6102:290b:b0:605:62eb:46f5 with SMTP id ada2fe7eead31-616f740628fmr17820267137.14.1777273256122;
        Mon, 27 Apr 2026 00:00:56 -0700 (PDT)
Received: from quoll (5-226-109-134.static.ip.netia.com.pl. [5.226.109.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cb11b4sm79588511f8f.2.2026.04.27.00.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 00:00:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc: =Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] serial: qcom: Unify user-visible "Qualcomm" name
Date: Mon, 27 Apr 2026 09:00:53 +0200
Message-ID: <20260427070052.18097-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1411; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=ugik/6RlZSUdiUsj48iLPpckt7kO/YmHHtrl32iY6P4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp7wmk9V3FgDfVGyzhQPw0wHo5ZcXuDQpnTIyhn
 LTjcg5v07aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCae8JpAAKCRDBN2bmhouD
 18VQD/9K9gG1b7AonmsIqpn3Tfj2RCSbqC9mnNSxsW4avQXXRFznfCuCdiccrNlS1eogW5MG4GM
 IXX4bzPcmzhShDm8c0A+3QC/EKfluCGVi6yV4+INuHl/n7uyqOqKdekw4cHAFdO1GJv0VlWizuU
 3Ur7218813L1p5QZv+rFzMGjOVQ8zxcatMPfww6PLZl2z1zuLIgEwQIKnZJPIGDujR/axFttz94
 Xk7hMso6qh7kt72IyBIjIkSQXy9GfdY45bJhizpSZbhUT9R0k8zBEE02sjh1frNNMhaxQOhyPtS
 7XBCar0faPQVmWJO0pLPWyao5IHBo8/Ttli7STGBF1CeOOfc3b5CDAw6NZKzRXsYdv7GD7AfHXj
 afoMsBOxZVXCxmANIDXqKCJW2muTxk0QlbC7WPMGe/TeJita55trV4/uCSIPJyQ5738A/UVwsC2
 2xlKWN55q8dLMYd++SwpzTnfBSaG4EvXwiszyRP7fn0rF6rNwSIh5RHoMvSc5WZhzcczR+5ywqZ
 X0cqf95ZrrKrxAz4alranRO1r2vjTGlF1jy4JTz6yoHHpFg9C/Q/FP7X0mmxqnowIB5ZNs33Icj
 +zYPQhAPMHWtVPNNPt9PpnAuii4xliPTmO/43OVriE9AFPbFXg+9dKeC9jc2MohX3G0AEMCKMTm ysbHdjNqFk6gjZQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: APnCNbPZRype3KYAEMndzsXIxojEDfA7
X-Authority-Analysis: v=2.4 cv=H67rBeYi c=1 sm=1 tr=0 ts=69ef09ab cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nnYKl1aPHK5ktf5uHVwi7Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=rDS-UetJi-EPvC9khCQA:9 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA3MyBTYWx0ZWRfX+RU5o5InW4R/
 foTn9Yz6WJCIEiutwb9JDbUIkz9DcrRqpJ6zcz8asAp6TCGVhLxuc5CPSaOM6xrF+1+O7vMmWsh
 h1XaHbdRLRxGBi8qvhAlXKb85YdB0VsZRX11b6yoe+eNW8vhVeDzmxc+5YcH4uktqxtOzRAkGKP
 1JWWeZFM9YMPPswJ2kTKf9mXfNpNN/Lu3Hyo5HV8qYRVibm2Nn+r/znV5wx+2z5nUoktvwEUlhL
 0n3vQ/Z1vt7IU7FbFBDYzq69JrM9AGcokZiR6n1fr4A8Fl8FTLIWflLsAwUj1jW3E7Mpjpj3zqD
 KS6T83TkrJ42J0faT76brO4Mwyr7pXw3La3JJJ65hSRwznKyYroxPG4ocx6L6dzvv0b12BJAD+t
 hq7v6bNlKOWZDXG2zg2ThC7dDqBpyxUrum0kQmcSEQgq7EsLBc/HN/9rj7vHCOyXSZOsvO6NH7m
 UMSDdXQ27xYgou+VkXQ==
X-Proofpoint-ORIG-GUID: APnCNbPZRype3KYAEMndzsXIxojEDfA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270073

Various names for Qualcomm as a company are used in user-visible config
options: QCOM, Qualcomm and Qualcomm Technologies.  Switch to unified
"Qualcomm" so it will be easier for users to identify the options when
for example running menuconfig.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

And "Qualcomm Technologies" has even variations over the tree:
Qualcomm Technologies
Qualcomm Technologies Inc.
Qualcomm Technologies, Inc.

I am doing this tree wide:
https://lore.kernel.org/all/?q=f%3Akrzysztof+s%3A%22Unify+user-visible%22+s%3AQualcomm
---
 drivers/tty/serial/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 9aa61c93d7bc..3e519d001e02 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -913,13 +913,13 @@ config SERIAL_MSM_CONSOLE
 	select SERIAL_EARLYCON
 
 config SERIAL_QCOM_GENI
-	tristate "QCOM on-chip GENI based serial port support"
+	tristate "Qualcomm on-chip GENI based serial port support"
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on QCOM_GENI_SE
 	select SERIAL_CORE
 
 config SERIAL_QCOM_GENI_CONSOLE
-	bool "QCOM GENI Serial Console support"
+	bool "Qualcomm GENI Serial Console support"
 	depends on SERIAL_QCOM_GENI
 	select SERIAL_CORE_CONSOLE
 	select SERIAL_EARLYCON
-- 
2.51.0

