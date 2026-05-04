Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F7C37CD49
	for <linux-serial@vger.kernel.org>; Mon,  4 May 2026 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777889456; cv=none; b=uipBJi6r69lZiYNnPA6X1j0DssMgZF5/WByl5ftPhQflsf9oX+jnFXhGsL+prkDbfPXuQvaPDBR0ZzMU+2x7m/sa3RBO8oJcM5VT7dMucIFE9iOmBcQUV0tY7gP6eE7iBD2GvHo+89YAm19FBjNGNuPC4JveO1bv3sMEDCe2h9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777889456; c=relaxed/simple;
	bh=GqKdSI51f1em7M39oQYLwVmjIooU0kDc3AYhR8hdk0M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cCWl9LJaP9VC/SwdY7V0knH+ldEsV7CEmZdQrkAPupGk9dYlf0jw0fezVZ/dYE5qLJFGpdcTkvygwDwC8gdO8pICYzuBWiLeAskjgUKFxncaXpaq5Aq6EFq4YHkfJICcZmYyjaG88ojNk1LWHSsQjCmNJyUSKK2Y2MAe6pG/Sz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EhbFlrHB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VUtywDKS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EhbFlrHB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VUtywDKS"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6448fci52539551
	for <linux-serial@vger.kernel.org>; Mon, 4 May 2026 10:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=PzBWqmaWx3NGD/Y6Y+6Ly+aWxbhG1VBBgUk
	9Lgibhrc=; b=EhbFlrHBm50qfs6nzI061a5gu49e2e4Y1W3zoyJ6bozG6IfWNck
	ZEeF1nPo3mfQ4AIRJZFHmfVyX/2m5/tQvscCDkpDJEB8VjwhCunQTvndU3tJXQWl
	H7KSHHNQ2+ph/ZtbGMB1Ngnb5m+kbcXzELPONpN18bhNcDFAg1ONK0Ueus7XCC6Y
	Lf57p5IpJBWERCRFCs6kfrnln4X7Fbp+A0Pju/eQ3fpSXAkFq5XJiC4vol5//dPN
	5Rkscj5RQXgVm31vnPAFGBjoM3/PRLycOtpeG7uKUjOFUdKGrFsw9RjysntH830T
	AqE0BCtxZwEsS04P2MWmRw+qZJ1SzOc9tKg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dwxk1b32j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 04 May 2026 10:10:54 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-358df8fbd1cso4823826a91.0
        for <linux-serial@vger.kernel.org>; Mon, 04 May 2026 03:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777889453; x=1778494253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PzBWqmaWx3NGD/Y6Y+6Ly+aWxbhG1VBBgUk9Lgibhrc=;
        b=VUtywDKSpSxsJ/qlEncgW+ddb7JS5QJbqlGvx/mGOmNm3P+0mFZvU0F0bChP7uk6AC
         zedEPS4i18Mr8NsS0hbNqoubr8YoQ59656c8bi311z53qLBXpCEBXMbHTlc4FUx+x4B5
         DpLv9dgqB6GLSUyN/6kE5EsH79q8mP18c8uY0Fr19qWcm413ECrO+bkgVaS09Zuwz046
         fg1HKBnDLBy4V4XYK2w4McLJokm28qwtnzK8VJ/njADi9jeXgzJQ/FW+haZZF+MXzedm
         L0/NipMGMxxlpS6d6KQecwi8VXSZOYQXYrcwQoN1SZQQf8m5BJaqVUqqggfQKoKxt0R6
         nxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777889453; x=1778494253;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzBWqmaWx3NGD/Y6Y+6Ly+aWxbhG1VBBgUk9Lgibhrc=;
        b=tNGzNIg+VzCDguq12k+Kb2yNOgkxt4eksl3qtidIHh1u9Y/dLKkYbdZJEWwf57VSmi
         ngbuP7mkBGqNqOEqkzVAaGeasiIRBPFLlhEhYaK+dlanpU8BwPuz4FsgaQJUeKo+39y7
         e3FmkBUBA6lLu/+7jAEm5FFVug0SD8ib9B4snUQc58QY/4tsTNzq0J7CaJ2Hia+EGNRm
         0UbETApizLJqzNaBat1svkYqjnbaTJFb3YfFepun8jCkcWKIsRgItG/Rp+DvMz/1i5Hp
         G9GTQR2ItCCCh3vCMiOsl5OvID+VjNElfYM1fZCsSRlt6GQvuzUhn+bOo7ZHje4vVsUt
         sCGw==
X-Forwarded-Encrypted: i=1; AFNElJ9l5sqAAqks1adznHfSXmB6jZi8/I36mHPMTkbU7OXAKts2AQDn1dKKJLrPnOSPYuhBiIjybOom8xCWIUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzre+tCw0bNxSQLX3r5Mb3vvKYKSlraJ4s1OsvByk2XGDPJqKFd
	OYmwi/mGsOvUVDSh9E0ucZkzfTsnsU5ShavTKS+06/72dV5zlTfF4dAcyU4+SBNGYz01Owmby0k
	ic1nNHdt/n9PBmzVpT71ZpWiHJMfzs/TqseleQ0GGrZ247khv2yrgC5QGJhGhxMXSfhU=
X-Gm-Gg: AeBDiesgzXlQ9FTLN8+02GByWrgXU1YpY7kmyEMP5XTAxDUTnNd0A8iAU7pwmH09W4T
	OMPV/bYHFajyMNCHKSG8BWVUjoQD1i/EMcjlQrG9hVakGOMet95MbBAZjM7k/sOH2kD9Sis9PMD
	Zz/ux0ZmBKyb/bY1CTY0bpRpvI8GMNkKOJFM0g5ZKHHvcLdVIu1Usejc2wphnuh4g74RtWyKxhZ
	Y7GpMu6ONgFPURnaGPwIlL8TYpKmMyLwzL4Pf5FBbjjRJ9FEi59yCb0gvDnWd9dfi/uFSg6W4/x
	8AZ75iqwLCE7sWHJftyoj8ncXVx0VXjxk2atOz3a3lETngDQKQLb9jIFzTwMYsKHuTB2XQN2xtS
	uyqdpHeIFsjiC4Njh+qE6WgNeVSQElkbNrsuYfYcRxUVM4AzdYF6+2L17mx/wyWTPTrU=
X-Received: by 2002:a17:90b:3850:b0:35f:d56d:1c45 with SMTP id 98e67ed59e1d1-3650cd7ce74mr9551598a91.12.1777889453358;
        Mon, 04 May 2026 03:10:53 -0700 (PDT)
X-Received: by 2002:a17:90b:3850:b0:35f:d56d:1c45 with SMTP id 98e67ed59e1d1-3650cd7ce74mr9551558a91.12.1777889452817;
        Mon, 04 May 2026 03:10:52 -0700 (PDT)
Received: from hu-arandive-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364bdf54419sm14516503a91.8.2026.05.04.03.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 03:10:52 -0700 (PDT)
From: Aniket Randive <aniket.randive@oss.qualcomm.com>
To: gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, praveen.talari@oss.qualcomm.com,
        anup.kulkarni@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        viken.dadhaniya@oss.qualcomm.com
Cc: Aniket Randive <aniket.randive@oss.qualcomm.com>
Subject: [PATCH V2] serial: qcom-geni: Avoid probing debug console UART without console support
Date: Mon,  4 May 2026 15:40:45 +0530
Message-Id: <20260504101045.1084672-1-aniket.randive@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEwOCBTYWx0ZWRfXx9qrsuM9+Q12
 +r1ZLswWSA9XdqL2YqT/dr68kcW8YAjZj2jEf5WdG2MSsnE5WjAAc4t4iw5ewssxm1I9NVSG6Ri
 Rm6H7p0cVZ6bpfiesuKc4IzJ4cnGX1mvV7vTh4XxmzMrjTb53v8qFD1OrJPXDnVIN8BQFYM5rls
 2mJRBC7iOWLvQsiyurbMX+R9lw8+wW5Gr/wafEnnZvk2p0shfhBUbXQWxHOF7Lj9wRTwIemA3/b
 o2puS5YBC4OwBzEgMjflvYV4kqfVJsvBQ8bBX3NqbHUJKfvpJWsl0j9NZn+MgvuirMOPH6pki+R
 gOJofqKLfuv6Ce0RVQzBz4+cQNSS2FZT9oiIcZI/YbOj2mI372M+PY9jkcZLDBWfYniaZP97rhl
 hDi56aylt2m9usGZf/YLiwtnqqOQPx/Y924DFZ4+03U8nHKzIHBNQBXSYcRHr1VaZDaeTsgnBE8
 L54gTAdVmts8CJqvEAQ==
X-Proofpoint-GUID: A5p_w6wQs8QU24KWItJWl-R5YTcfB_yn
X-Authority-Analysis: v=2.4 cv=bb5bluPB c=1 sm=1 tr=0 ts=69f870ae cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=MZVvZoSPHoyeMB40_KMA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: A5p_w6wQs8QU24KWItJWl-R5YTcfB_yn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040108

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

Reviewed-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
Signed-off-by: Aniket Randive <aniket.randive@oss.qualcomm.com>
---

Changes in v2: 
  - Fixed kernel test robot warning (no functional change).

 drivers/tty/serial/qcom_geni_serial.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 9854bb2406e3..d2287a8b1d54 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1992,6 +1992,7 @@ static int qcom_geni_serial_resume(struct device *dev)
 	return ret;
 }
 
+#if IS_ENABLED(CONFIG_SERIAL_QCOM_GENI_CONSOLE)
 static const struct qcom_geni_device_data qcom_geni_console_data = {
 	.console = true,
 	.mode = GENI_SE_FIFO,
@@ -2000,14 +2001,6 @@ static const struct qcom_geni_device_data qcom_geni_console_data = {
 	.power_state = geni_serial_resource_state,
 };
 
-static const struct qcom_geni_device_data qcom_geni_uart_data = {
-	.console = false,
-	.mode = GENI_SE_DMA,
-	.resources_init = geni_serial_resource_init,
-	.set_rate = geni_serial_set_rate,
-	.power_state = geni_serial_resource_state,
-};
-
 static const struct qcom_geni_device_data sa8255p_qcom_geni_console_data = {
 	.console = true,
 	.mode = GENI_SE_FIFO,
@@ -2019,6 +2012,15 @@ static const struct qcom_geni_device_data sa8255p_qcom_geni_console_data = {
 	.resources_init = geni_serial_pwr_init,
 	.set_rate = geni_serial_set_level,
 };
+#endif
+
+static const struct qcom_geni_device_data qcom_geni_uart_data = {
+	.console = false,
+	.mode = GENI_SE_DMA,
+	.resources_init = geni_serial_resource_init,
+	.set_rate = geni_serial_set_rate,
+	.power_state = geni_serial_resource_state,
+};
 
 static const struct qcom_geni_device_data sa8255p_qcom_geni_uart_data = {
 	.console = false,
@@ -2039,6 +2041,7 @@ static const struct dev_pm_ops qcom_geni_serial_pm_ops = {
 };
 
 static const struct of_device_id qcom_geni_serial_match_table[] = {
+#if IS_ENABLED(CONFIG_SERIAL_QCOM_GENI_CONSOLE)
 	{
 		.compatible = "qcom,geni-debug-uart",
 		.data = &qcom_geni_console_data,
@@ -2047,6 +2050,7 @@ static const struct of_device_id qcom_geni_serial_match_table[] = {
 		.compatible = "qcom,sa8255p-geni-debug-uart",
 		.data = &sa8255p_qcom_geni_console_data,
 	},
+#endif
 	{
 		.compatible = "qcom,geni-uart",
 		.data = &qcom_geni_uart_data,
-- 
2.34.1

