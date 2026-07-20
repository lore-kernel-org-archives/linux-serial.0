Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B26A3D171B
	for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537887; cv=none; b=HqA8KJ+vfQ3ECqftSvN5FZUVGoyWA/JHOChoJZUP/1hVzQpmXIAyScnVxRSNoTosyag9KreAOw3/3b7oCgkIEOAf3PP3wiJK+RZt/LdRAtaPkfW4tLohwjf+DT11He0uREI1+1MA69eeLZiIoJz3h5tQVRSSXUxQt/A3Q7ydHWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537887; c=relaxed/simple;
	bh=owc/8QgSOr6t/UTWViEctCyxHem2AxUNXf9WbTkfbnw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d0Hh7XD4PfsSvvQh4Lo0+7c/u20J0phl3eIGi1sArIoALVtltzu37GuUG8Zla1jN5fg8LVlulNNoYmEPq9UqMEj8/bnYc/sHUuAUArXgXV5JZTB9qDtqxigi9CFCkbNUjAQ8M+k2+3dMnafCXyWdkulOaS8FFgbzXtCFbQu4p28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZMaPAWic; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RmzJXj5E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZMaPAWic";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RmzJXj5E"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6RjA01713671
	for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 08:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=a5whM6vhtBpazDXtf1CdxM
	P8lSS5QwhAYXs3vVOgpWQ=; b=ZMaPAWicmbjTLS6vvz93LVomKHw0Bdvhr/bv+j
	ZlSQNEn350JfP6YoO0NwsOI2BRSwhtsgfjMmXUotbfgvqcdRpgXQpsq0+NTyf3/H
	nAi8lSYFXB52rCgqBDoXSqf1ZyUaVim/lryR8Jr2/BFmf/uTrj65EuQyPoIBzNPN
	hQLeoUU3eavcJvOdausQdVJH/oO0aXmCvYRg4p63ZcPP3Vjv/X1WQvVL7Ve/C71e
	vbkw6PLPXCkE9qwUTq4AVfVBpuSt8liwT1WwCPiKyBUgSjtfx+Cd+FO4D/a5QN6s
	nGfyeV7YUfsWa5dUh2BjkSuhSZKwlPpaTA4mAoFlWbl1iamw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2dc5b6n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 08:58:04 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccbb61893fso207572575ad.0
        for <linux-serial@vger.kernel.org>; Mon, 20 Jul 2026 01:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784537884; x=1785142684; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=a5whM6vhtBpazDXtf1CdxMP8lSS5QwhAYXs3vVOgpWQ=;
        b=RmzJXj5En74/cgotmeBu53gALtHa2YsZHEDjk/BACvCFA3BZFBOdG5oVgZ9JoSFRiI
         7pbYbm9+KJ9j3PA4fp6K8sjPUVtgQEWcF7ukCL3mCGGHeFFM2nEV5+47kQHobSMU30+u
         bcC4g8R+8rXH9tkZ6TIGEMyAx7T0S35Fxvar2By+gRp5kW2TawrMhY2vpSvFiNTHbwHJ
         RBnzfnSvYQ+sNjwZDDkVQCuPsDOI524tmAlO0R2++lHvYdA8PdizQCUj3ix9xAhyuQQX
         DmPdRQjTLQGQwLm3s2Y2RlpIupfAY2snStXRdjMVv6Z2JD+8SiWWTWo/6CkEEAVdUWwM
         +bYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784537884; x=1785142684;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=a5whM6vhtBpazDXtf1CdxMP8lSS5QwhAYXs3vVOgpWQ=;
        b=PuylfmQEjpZxEfkCntItAuokSVtxIuMYLiMOVksfxmR8ZiH8PBBVNiD1j4XX4R3beQ
         kFJudPJfGIo/SO2FY6D4610EA1COUuH8d1/c3e681NbCnZLhuWMScEHnRdM3KU8d6K4t
         yWjD3/3G3+IcyRLNLpF8PttA01z4ugqidzptVhBnOwE99qfDA7fl4SpekaAvJS8d+CUp
         cnkswZg1iTCQgYIDspon12OG61TXrFp8LootXzym4GB+JBJq5VV3B0ovhgvhIUPmbUNx
         4jFDc7gt39edN8pJwJqwOBWstEG/xE93DhgvHtyBmcKfz3IqOEgTXZu88NK3hB96w85O
         eiEw==
X-Forwarded-Encrypted: i=1; AHgh+RoovQjTGiGXZ91zk6f3Kn+nE9kXFVbDpwNwC6rcZbV6o1F9c5MBuxzQpsWu5yrgEvMMVgRPoFT7KlRrMAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnW9j9SFmb6moQvm63LBAGiEqUWTPciT37oU1loWzkbHf+qp8Z
	I0egoqjIx882JNdCTCopgabiv2VLMEApZkzuIoCj64ez3Hh4c6uUtV48ky6bxtvt0a8tzCUG4bA
	wlpSnErd9i/FvMDEaCiAptTopwW4ElghgexJ3GP3G64TuMQyfcnt+egzuZYmoaPQ7lzs=
X-Gm-Gg: AfdE7clZmK6+Gza9CgnTi+a586BQpn23qLJdqGtgb2VqVpAK2WwnXlkPug3dV4Z++un
	D3ca9pR7jnQexyyuXIwPaPNonfHj2U2v0/eqM+W6hnb7zMLihirVKL9Zk/JT0QkkGIWXUXIibI5
	sImdWHwLlLdK8dSllAsa2cu9QQnGvmCIg0P4W5cmOzHUdSgRmx8vysGYar0GWCrrAny3gfrvP4i
	/XLe5/aaYDXZnI9LCoNjxcny3oQOeXMVP+nvX2faPIpod854IMRkQESVMaVLVnC0fZ33b1bCZZ+
	3uTH415RFWfYf/5CJhuvEdLP81gMwSxrV4OZsybTho+3yQYdHe/CcO+pvF8zmD/gprOn43W9c1g
	nj+ixrw0hBlCBCS1OoLKAmhrG4lDCmtbULg==
X-Received: by 2002:a17:903:a8f:b0:2c9:abe1:c352 with SMTP id d9443c01a7336-2cf3485335emr151177185ad.13.1784537883965;
        Mon, 20 Jul 2026 01:58:03 -0700 (PDT)
X-Received: by 2002:a17:903:a8f:b0:2c9:abe1:c352 with SMTP id d9443c01a7336-2cf3485335emr151176885ad.13.1784537883376;
        Mon, 20 Jul 2026 01:58:03 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf346db036sm54076405ad.46.2026.07.20.01.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:58:02 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 14:27:52 +0530
Subject: [PATCH v2] serial: qcom-geni: remove .pm callback, use runtime PM
 in startup/shutdown
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-remove_uart_change_state-v2-1-30153ce4333b@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAA/jXWoC/3WNQQ6CMBBFr0K6tqStBqor7mEIGWCQGqHaKY2Gc
 HcLuHUzyUve/DczQmeQ2CWZmcNgyNgxgjokrOlhvCE3bWSmhMpELs7c4WADVhM4X+1GRR48cpB
 djrk+AtaCxfenw868t+lruTNN9R0bv+6tRm/IW/fZ2kGu3i8jxf9MkFxyjfqU6RaUAllYovQ1w
 aOxw5DGw8plWb5vn9Fu2QAAAA==
X-Change-ID: 20260709-remove_uart_change_state-a1f7e783aeb0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784537879; l=4575;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=owc/8QgSOr6t/UTWViEctCyxHem2AxUNXf9WbTkfbnw=;
 b=Vl3G6ilyAR2jQ0jxmV2tZIf+WmGPV5XTiuyFPmeWvw+Z/1/swJ4a+JLnRfhAZK/Y5RR0jLxtp
 xtwFSemKEAxA9DJcnNmvxvr0J3xCasyTPFvt/1SfxJWw6XKV9qCpzrz
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5OSBTYWx0ZWRfX9rrX72+958/I
 5YW5ax84vWtLoHOp96AiWx+Z6KLrrD+MVCmBj/sAuSRzPl0Nck9svU6VlyjcIs7eHNfqLzqOJcr
 6OhboLy3bohODUp8U+xtUsjQ0gUQ208=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5OSBTYWx0ZWRfX2RvOwrfu4zR3
 5R9+Vu1enoThc+Zl2c6ADDzeJnThhz8+INj2wKJQQ/OHVIvvhbINLl503KKvtugjvYguuFGMmPB
 s2sXGFxdZi6pOgB4wDGNy2pI7bYHtPrGMMwUqYo/w00iAX03FKiWGywlgJXWOI0TTq4UhZ8xxWR
 eg05sQX8eO4UzXNWGTknBsavgdWa+/4spYleqEj2fTztt9743cPPaDUJruj01dSRPmkp3YjnJZE
 K3czu775Gz9w9WLcENplA1McQZD56l37fMWwYZAKuZeg5fjKneqLLk/hdlClCVghvqpr2Ezob3n
 G1vUByiqYuVO2l/MrggnYjWBxvn0TxcwF1/H7gq9NEzT9LOU4j7pLAzlidQE5Dfe2cJJsn5DFHo
 IqqCuJbth5IhGJAiH/Q582aoZggdIqbb4mOSRreRt6g2uPkyCOWL1scfu3k71+nPfdGh9m4dt4Z
 yWabRPuBYSpW0gbLdgA==
X-Proofpoint-ORIG-GUID: JqCtEgGIO5zWEER1GG3B9xSE0fucX27D
X-Proofpoint-GUID: JqCtEgGIO5zWEER1GG3B9xSE0fucX27D
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a5de31c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=Lm143-4zXO_JaeHAvGEA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200099

The driver currently relies on qcom_geni_serial_pm() through the
uart_ops.pm callback to manage runtime PM references. However, the
callback has a void return type, so failures from
pm_runtime_resume_and_get() cannot be propagated to the caller.

As a result, startup() may continue and access hardware even when the
runtime PM resume operation failed, leading to register accesses while
the device is not powered.

Move runtime PM acquisition to qcom_geni_serial_startup() and release it
to qcom_geni_serial_shutdown(). Since startup() can return an error, PM
resume failures are now detected and propagated before any hardware
initialization is performed. The startup/shutdown pair also provides a
natural place to balance runtime PM references for normal port usage.

During probe, uart_add_one_port() may configure the port before any user
opens the TTY, meaning startup() has not yet been called. To keep the
hardware powered during port registration, acquire a runtime PM
reference with pm_runtime_resume_and_get() before uart_add_one_port()
and release it with pm_runtime_put() afterwards.

By moving runtime PM handling out of uart_ops.pm, resume failures are no
longer silently ignored and all hardware accesses are guaranteed to
occur while the device is powered.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Changes in v2:
- Resolved clnag build error.
- Link to v1: https://patch.msgid.link/20260710-remove_uart_change_state-v1-1-8e8468da22a1@oss.qualcomm.com
---
 drivers/tty/serial/qcom_geni_serial.c | 37 +++++++++++++++++------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 7ead87b4eb65..e7095f391397 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1178,6 +1178,8 @@ static void qcom_geni_serial_shutdown(struct uart_port *uport)
 
 	qcom_geni_serial_cancel_tx_cmd(uport);
 	uart_port_unlock_irq(uport);
+
+	pm_runtime_put_sync(uport->dev);
 }
 
 static void qcom_geni_serial_flush_buffer(struct uart_port *uport)
@@ -1246,10 +1248,18 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
 	int ret;
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 
+	ret = pm_runtime_resume_and_get(uport->dev);
+	if (ret < 0) {
+		dev_err(uport->dev, "Failed to resume and get %d\n", ret);
+		return ret;
+	}
+
 	if (!port->setup) {
 		ret = qcom_geni_serial_port_setup(uport);
-		if (ret)
+		if (ret) {
+			pm_runtime_put_sync(uport->dev);
 			return ret;
+		}
 	}
 
 	uart_port_lock_irq(uport);
@@ -1724,22 +1734,6 @@ static int geni_serial_resource_init(struct uart_port *uport)
 	return 0;
 }
 
-static void qcom_geni_serial_pm(struct uart_port *uport,
-		unsigned int new_state, unsigned int old_state)
-{
-
-	/* If we've never been called, treat it as off */
-	if (old_state == UART_PM_STATE_UNDEFINED)
-		old_state = UART_PM_STATE_OFF;
-
-	if (new_state == UART_PM_STATE_ON && old_state == UART_PM_STATE_OFF)
-		pm_runtime_resume_and_get(uport->dev);
-	else if (new_state == UART_PM_STATE_OFF &&
-		 old_state == UART_PM_STATE_ON)
-		pm_runtime_put_sync(uport->dev);
-
-}
-
 /**
  * qcom_geni_rs485_config - Configure RS485 settings for the UART port
  * @uport: Pointer to the UART port structure
@@ -1778,7 +1772,6 @@ static const struct uart_ops qcom_geni_console_pops = {
 	.poll_put_char	= qcom_geni_serial_poll_put_char,
 	.poll_init = qcom_geni_serial_poll_init,
 #endif
-	.pm = qcom_geni_serial_pm,
 };
 
 static const struct uart_ops qcom_geni_uart_pops = {
@@ -1795,7 +1788,6 @@ static const struct uart_ops qcom_geni_uart_pops = {
 	.type = qcom_geni_serial_get_type,
 	.set_mctrl = qcom_geni_serial_set_mctrl,
 	.get_mctrl = qcom_geni_serial_get_mctrl,
-	.pm = qcom_geni_serial_pm,
 };
 
 static int qcom_geni_serial_probe(struct platform_device *pdev)
@@ -1921,7 +1913,14 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
 
 	devm_pm_runtime_enable(port->se.dev);
 
+	ret = pm_runtime_resume_and_get(uport->dev);
+	if (ret < 0) {
+		dev_err(uport->dev, "Failed to resume and get %d\n", ret);
+		goto error;
+	}
+
 	ret = uart_add_one_port(drv, uport);
+	pm_runtime_put(uport->dev);
 	if (ret)
 		goto error;
 

---
base-commit: b9810cd75b9fb56a3425d391cba3f608502bd474
change-id: 20260709-remove_uart_change_state-a1f7e783aeb0

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

