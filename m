Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11FD392C25
	for <linux-serial@vger.kernel.org>; Mon, 13 Apr 2026 07:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776065112; cv=none; b=WApmLJNgCjp6in3p+cFH68XQpPPegTXS50+41rk8V8kfFi5oN/Fs3oHUkilnS2RmCfbaU55iJTJGwuJf3AZttjIbyLTA8CKAMxB1T8nHVkKnRkc4bPpFyzm33Tw4+Ka52QEjU5JzKkowW+mW8BDxz/ili1MH3NWt/flOUNmOOdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776065112; c=relaxed/simple;
	bh=/gtd8aLCB9UW6v0B3NV0KuDTPl/hd1xhXaVtDL8mtZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ap5CQ+8E7qaeTevWp1z3OiJh1oIgzKhMMkYjbGl42qjkoGMS6ti9+NCEXNwGHfqBUZBwJkrALFGU0TVGgqr8YbDojDq+aDAZQpFn4dGc7OJsjR0zuOjq1uaCuz6VAhy2sWPj4Zgp25Np+pQHmXMaybYKA0M/VIIJLJFoXqQHtj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jgai4nus; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NEFsjlgu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jgai4nus";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NEFsjlgu"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D6frlH3162877
	for <linux-serial@vger.kernel.org>; Mon, 13 Apr 2026 07:25:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=IX3mbVpKI9CdsNJH+rUEyMRL9sYGXmxL7J0
	3WUO7FHk=; b=jgai4nusubaqiQ8fkdYzW1PVWK7coiNx2lYOkwSP/lhKCnYExVA
	rjDB3FYzOJnpcOncO7dJATPvpdkz2Bgk2WhfAd8PfHCA9CDz9DT/+mCQpFmy8DIi
	IUzVRqrBydA70wdr6CtLGSbtKP3nqiQzDBOb1WvcCWNbG6GB/F6tH/ydAdCa8Hbo
	qpE33xrRL+OtEjfcw7JrbL8h8/1/M1kZS8gPbuwW4BGKEqpZglEnGUftGFJt1CoY
	A253kLfpZlEHPgdNXLO8AZu/+mvK8yYvpUrUZuk0Hsyvm3WLJcst6uZb8NOEqtkK
	/Fe7JG+/il461bRgBLKQAXyk/3e7Og+lPdQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfexcv6ny-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 13 Apr 2026 07:25:09 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f20963158so897924b3a.2
        for <linux-serial@vger.kernel.org>; Mon, 13 Apr 2026 00:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776065109; x=1776669909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IX3mbVpKI9CdsNJH+rUEyMRL9sYGXmxL7J03WUO7FHk=;
        b=NEFsjlguvXKJOWYx5akx+XX5/66I9phvPn417to84N6le20D5l3EMNZvrzu6Ic5MX0
         /QoCxSTTwS5Ab2RI7RdbdiAALKHBABlskmtpY+wkYNKpj37fm7cR7HPjv9o+TPkqkCKH
         FC+uBviMrI3oF4z41scbP46Q2HZ4AyfkcwekGL3Ct/lj7YHAuV2xT6Dpv5289eICP1CJ
         hLlHQwtTphp8zGMzSixYqgTjgTOlosuIWxKkLj4pCOdWzVgZzriJ+jqih13uwpWh9IgN
         GZyp7++4Jqts+hQKsw8hmycUl9epmnesMnOX/A6oe6hdavYqyvq8VYHqnf0q6SKefQdX
         Ormw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776065109; x=1776669909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IX3mbVpKI9CdsNJH+rUEyMRL9sYGXmxL7J03WUO7FHk=;
        b=Mde7uKV5ZFPvIQprSuFXazHFu/yG58ifagDUrhU0osU0WF8v22ZfO3E8xP1j8aW3wK
         nsNJtkw/Ravu9ckpvaHgXIXQ3iTYc9BsL+BTffD3n/w/lZsXHgYaHMxcpAF57tST+6Nv
         aTeb+POSGjTVluFUV6ZOau607VwqdVPVWwxe3Qrbz5vFZtEfFVQ+M3sTkRI8QLoVCDfJ
         u9iiz5mATSstY7ySaXhAnlK5hMrXMNnDEZ5xQT3/v4c8APZE804mKAejS2zQFXj73egb
         jFgGDG/oPd5F4l5utxgie7/YESnsqNJy1mWtIq7oGUm0qRm6YdEVeLLzKmrN7cZ4hwY9
         5gmw==
X-Forwarded-Encrypted: i=1; AFNElJ8kE4F4OATFBCnvzrFQ7VMvl/6Ds/nO2b2zL5KNCVjeByg+VzR7OHlDZS9Vy9O32OG2yTyBc9erIY/MT8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0pYIc6RliDgK8Ag+JUdq+w0Ah6saW1dL6eBsY0khCnQVWoRHO
	msVHkZY8oZgVymLcj/AzK6MHddl0qXCoJYFCZWDAbReXPmkPIR+BKtSwXs/tF+3Z2YzQ9dWMgkY
	oGbEbOXqgiKcuDo+8PFxoU70Ct4V8CdEAW18hshnNwJKEvhVcawgjv6x3SZZrxg8rDTM=
X-Gm-Gg: AeBDievcEp//ES/PaOF+zUMjvO81Kn4Ev1xKUJG/UXaaRt0Cur8ZgRpCUS7AGmT+T9a
	cKUYL3YWDUusm2ljhF7A/2EJRwuen/+jafgF4+MYSTBvZHlLt7+JbumlxW5O4zA/mpI8sHHMLYz
	uUlzu2f74QsF4GWYstxlV/XQRAUz3HbyaijfCwQEiK7bNkLgk3UNde/kp3K2iSIANTY8elp85TK
	9oTPNGrjgXAynbLrwsW04L22cOJXCo1MqK6ULYbWep9EcReAaoiZxm2PUcvy+LDu9XN3n48EWlV
	u9MDgoqg01oCoAPUyXgCy8RSMNVMlox0aVKNa1o34Ko5/Bf0celt4i5IWu8h4YMVATyY1CMkf6c
	FYLCpUTuNFzgq4d0dFNjO9p7OgRljifBDtmXysWQpB+ntfG8A5SEqJkmv
X-Received: by 2002:a05:6a00:302a:b0:82c:daa4:ce29 with SMTP id d2e1a72fcca58-82f0c2d93admr12361299b3a.47.1776065108757;
        Mon, 13 Apr 2026 00:25:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:302a:b0:82c:daa4:ce29 with SMTP id d2e1a72fcca58-82f0c2d93admr12361260b3a.47.1776065108219;
        Mon, 13 Apr 2026 00:25:08 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c500415sm10213450b3a.51.2026.04.13.00.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:25:07 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, praveen.talari@oss.qualcomm.com,
        anup.kulkarni@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        viken.dadhaniya@oss.qualcomm.com
Cc: Aniket Randive <aniket.randive@oss.qualcomm.com>
Subject: [PATCH v1] serial: qcom-geni: Avoid probing debug console UART without console support
Date: Mon, 13 Apr 2026 12:55:01 +0530
Message-Id: <20260413072501.263871-1-aniket.randive@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDA3MCBTYWx0ZWRfXwacESIhnU3HN
 ShZqwceAz27rq8sb45vzzPQqaBVh8BEzcYsP4nALRmEOPc1HFC6n56iNM38/Df0yZm9q6RXVek7
 neQ9+sdlaD+ME+0cgcSiJvWuFMPkgA/nAGbPgEyINmcaEGuhwxo/0+KNJtVwFofWU9u6+ayeVhZ
 Qz7G1Hn8VJdBSrjId+GDAcwZ08BnLuRVZCny29CQpRTSHpGbNvNast/3m9JQGrYv9ZSNTH68LVL
 uTCN8kIIuXxftls6K30uaoROVVs56QNvQJ54uk+Imgo7Z7CkbGOVEMipkphv4a7GilSWq0aW+wo
 MMEM3M6Y4MNOscxzkWP5ZZ7/W/AnaEWrKyqQyMttamd8M+037wsksGNCpaPs1adFIQWPgEyd56B
 v6AYFl1FN4JZBnICdlOfEUSPJMQmRjW2BPU7vjxac9pVSOZJoFkLwG7xXpR5ir5BH0CvKU5C4ea
 a5+t+WC3AevB8D6R2Ow==
X-Proofpoint-GUID: A5U8Fo9btN1UHtYDKc7Ri8jmrGZE3ghh
X-Authority-Analysis: v=2.4 cv=MqliLWae c=1 sm=1 tr=0 ts=69dc9a55 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=-DdxBgvXw3sWXynY89EA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: A5U8Fo9btN1UHtYDKc7Ri8jmrGZE3ghh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130070

When CONFIG_SERIAL_QCOM_GENI_CONSOLE is disabled, the driver still
advertises the debug UART compatible strings ("qcom,geni-debug-uart"
and "qcom,sa8255p-geni-debug-uart") in its of_match table. This lets the
driver match and probe console UART DT nodes even though console
support is not built. As a result, the console port is never registered
with the UART core and uart_add_one_port() fails with -EINVAL.

Fix this by only including the debug UART compatible entries in the
match table when CONFIG_SERIAL_QCOM_GENI_CONSOLE is enabled, preventing
the driver from probing console UART nodes when console support is
absent.

Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---
 drivers/tty/serial/qcom_geni_serial.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 9854bb2406e3..b756e0c07c16 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -2039,6 +2039,7 @@ static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
 };
 
 static const struct of_device_id qcom_geni_serial_match_table[] = {
+#if IS_ENABLED(CONFIG_SERIAL_QCOM_GENI_CONSOLE)
 	{
 		.compatible = "qcom,geni-debug-uart",
 		.data = &qcom_geni_console_data,
@@ -2047,6 +2048,7 @@ static const struct of_device_id qcom_geni_serial_match_table[] = {
 		.compatible = "qcom,sa8255p-geni-debug-uart",
 		.data = &sa8255p_qcom_geni_console_data,
 	},
+#endif
 	{
 		.compatible = "qcom,geni-uart",
 		.data = &qcom_geni_uart_data,
-- 
2.34.1

