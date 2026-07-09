Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998333C4546
	for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2026 06:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578400; cv=none; b=RFk9xZqjqTCgcwTh8ai1NbdliInv/CVealpOqOD4sCRwlQOdUHIGsv9dvZDu3iwdWAf+Sux6Q7TfVml1h/bK3cNFtgZuDn+qAhA3SeXDRwx9OBZr348QHmjkPX5SMOw3F7UQIqwRWt41mls6fK9F0eAMZnA7VyH2zPPkyulPlxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578400; c=relaxed/simple;
	bh=RCVhJVzC+wYdvFevPUgqoSKxgJUMAgct7Wn34WkXRWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iPvmLLMZLx3Jz8pGwMTZ2/Hk4zV6Jiyg0whCZEmCtSyN5qJoz3srF6CnZkZpbZz3x/GwFJ9q/qLuPgnj2a0iIh9a8c1S+ahgPX90+dFLdsGd/dOL1Hii9JyP/udTYUTvHOJdAwZZrxJ3uqqPSaHs9fznX6EsgtWUChzNcd0AvPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NqHIsSbp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NXimI6+g; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NqHIsSbp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NXimI6+g"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696033O711972
	for <linux-serial@vger.kernel.org>; Thu, 9 Jul 2026 06:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jTTisIRrm1ikhDDsD0zkfVo0e3j+V+q/x3H6zj2yL0s=; b=NqHIsSbpA5lvbv4Z
	47M3CAoj6uO6UEbJD5y0BQysq5L1Jr1rsf0AiPX313hzBYpS3K8LChKHvBfabvnc
	V9BSGWOrBDr2DZBQr9+B7/Pw+mjlVbaPKaY3ZTof7YB16OMWPYtTwsTmlCkVChBj
	P7lyNOhAzzk7GFFiC6wgEIsS3Bff7xMSxJlZXYrudLuIw+4puPBegSMEka9XgxXF
	la3aa+G5nxIGIfXjpCvN1m0vNN556HsMZgp0k9TETl2Ay1AZuCJPvhGpVEdKiOGD
	ya0cvjixpb/Q+TNZHJ+UTotRX0UDf/hKztHRgyPbpEln34SNELVk77g3jQkNYbXj
	rSHpTw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa55vg9ks-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2026 06:26:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so31339035ad.1
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 23:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783578392; x=1784183192; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jTTisIRrm1ikhDDsD0zkfVo0e3j+V+q/x3H6zj2yL0s=;
        b=NXimI6+ghMqPajeFez57UhCTW8vUbbWj3BLJ1zo790Ayh01vKg6nt6EkMB+YTAURIg
         T3qM6aXG0lJL/XposEN1NjUevkcBI5jR8YDu0SfgkLQvJZQtPW7iVc68sMIfsIbPqxog
         /fjfH2QZ577L0kqDa8INhraiiPIEq5Sxq7cumIszVI9IDvlHbk1oZuSaVgVEtyKC8gIB
         sp7dLk4u0dYDTeIwiXi/1q9tm2OGJD+kIa8L2BbywI2CMxxfPrFa1w9qnkKWpIarPUWy
         4t3yiBporZ7YR94G+0FZW+GiKI/bulELqwqtUvKEtbRTVakCc8RvOO5U4hP0FKqzvqvA
         tdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783578392; x=1784183192;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jTTisIRrm1ikhDDsD0zkfVo0e3j+V+q/x3H6zj2yL0s=;
        b=HFVVO9hEBnThgNEOD32Nv3IOqp2+W7gadxVqQaJpQGN6qh2u8rPn4Qg3ojzQ+nELwX
         ylmFUX7CD7K1yQnLc9jTh9JzG8V/YUAZP+ElpM95l8YyCRg9F1xQ5t6aoW47Zy9SkJEC
         3cfFohPLu05DcndfnU5Hs3DXzlC4sTGPFwevs9TZadOYR0e+lAslWe8fqMbHcT+eMrD3
         jnD56Q4Y8cydL5M/9oErALD7tVuH0UlUZ9QKYfVJiYP7mKds4xpfIPloZuOgXfNYqdyM
         zM2vIYdD17UCUBK7tn/T2ZgelIniiAjfKy0vQwLFHqFjECkZOYRhCDgfjnA0vRf1v0d4
         EBuw==
X-Forwarded-Encrypted: i=1; AHgh+RoNNG259Psk1Z3KQ60I/K+MK4TJyiSGb5lSmn2bS1L0yqs6rYxT0ULPPS39Wf61XjITwQnbhaqyZimVE+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYis6c87TW2s/eQQ5vPM+WsXJbEyAtDHj6A6yywDHmS99beiA1
	+aLQC/mPH+OgXyn4eMiy/ctvqFZg0i3X89qlJuT3WDl3km+++OhCp+HGavJCauPm76cY/1eTKLS
	Ms0g8aMP+Sk+aEhiGCsQH9GL5763erix61Tcli/jFRpbW6adeLBR1HKOuXxeNfiYTzDc=
X-Gm-Gg: AfdE7ckTvLzWVIvmIFhYGLbSltvOZRsdtXBv8j5E41B6C+vBDWk5c0MbQmDFiZL1xCC
	LVKKyYZrFyqQgGQ9QDJOs/GobC5wvx8ois8v6VvpLtAftv0CDSOrjAEjOqqAnpaqG+z1xeWNgXp
	pIGYVe708Qeyg2G+EDuYWPfXhXFsR7QsGH2xh9bZJTk//ryso0HixCIJ2emKOOeiwKEjruZvcjr
	AAY0xYVtChDSUaO1F9Iuv9sUHMUkPx0qxTx/cnYqqJ8EQC0eRI3IZdpstyFC7BvDGPhtMBWMg9X
	1DKks78Y3mqaP0HjW2SZUr5oFJLlFTKpFqiqL7mvJ8Uj+UgdUPVYFXyQTTJ/avCxYQQXiXcLi6G
	Rh/c/toy5hDIaAiV56XC10hNQb+cazpjpD43r033zAKhQ
X-Received: by 2002:a17:903:1b23:b0:2cc:d6de:d597 with SMTP id d9443c01a7336-2ccea36a539mr62888505ad.7.1783578391531;
        Wed, 08 Jul 2026 23:26:31 -0700 (PDT)
X-Received: by 2002:a17:903:1b23:b0:2cc:d6de:d597 with SMTP id d9443c01a7336-2ccea36a539mr62888325ad.7.1783578391002;
        Wed, 08 Jul 2026 23:26:31 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf74cbsm37986405ad.18.2026.07.08.23.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:26:30 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 11:55:17 +0530
Subject: [PATCH 5/6] tty: serial: propagate uart_configure_port failure to
 uart_add_one_port
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-add_return_check_for_uart_change_pm-v1-5-e85c6ffa8ec4@oss.qualcomm.com>
References: <20260709-add_return_check_for_uart_change_pm-v1-0-e85c6ffa8ec4@oss.qualcomm.com>
In-Reply-To: <20260709-add_return_check_for_uart_change_pm-v1-0-e85c6ffa8ec4@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Richard Genoud <richard.genoud@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Peter Korsgaard <jacmet@sunsite.dk>,
        Michal Simek <michal.simek@amd.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783578321; l=3013;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=RCVhJVzC+wYdvFevPUgqoSKxgJUMAgct7Wn34WkXRWM=;
 b=03mWtjLIQU7aWmNkLwR+vaK5fDe/SCxXzqhpbBs8b/Xb17vYTfEsjAwodzox5hzEhqv5I585X
 VlgTWl/svaRAQ3BHkI4jtOEcL+pvacYHbhDmbmUE3ytsKKBRXOWcuW/
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1OCBTYWx0ZWRfXw8Ix6ajPRXZu
 oyBkQt2YWmExIKw7WeZ0GAGZiWrkpgniLMr1uYWEalPnd0geIEhj7iw1xj71jU2sfdpA2tl/cqJ
 BvAqo/ZRxqeef1UZjwsbjr3PYAm+Zg5XdXxYQun8xxDXlP7aTalSt5z3h2FcSzlmSlxgq2DE2f/
 WW5770fitWzO1PTST6dmdFlUfQXnVSSScIkDZ10Ue1HCiNGBlj6KuPuEKVMwwuvJ3wjXnrjO4I+
 T6LGqf4fcoArnOGxD9rqC953WjsgbE01dKx2ItmbmN5R+47vpFkjRUn2QCyCaaKivRP5fGP7nmw
 1QpHecKwy9NBJZ8TGtB2K47jCyMCH+FBv2WlneWTBZMv294ExJu8XjPUyM0WQYw9yD5Q5bvKirc
 +0bvKUyMofhSGi17iD4b67b+y9xom8NJ4IxyXlZybu2OzlZMQGZ5gzCpjRmqT7hR2y2dfT5u6wJ
 gSFFuQxdliT3zc1QZPw==
X-Authority-Analysis: v=2.4 cv=KfDidwYD c=1 sm=1 tr=0 ts=6a4f3f18 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ix9lyGl5LlKgHWL4iMAA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1OCBTYWx0ZWRfXwTo1GFcBmQ35
 2KDDyUIyK9WgStmXaPWSo66Ev8wcK+p9d9wbSNWR+DGtmCHnMGdfe2RICLy4HadsAi/7BmNTuyG
 ONrfhCCNWKdr7WULGwdzu1DXNCiUJkM=
X-Proofpoint-ORIG-GUID: qhUWqZfY_YgOnx0dZji5IyqZ5CkAh0GK
X-Proofpoint-GUID: qhUWqZfY_YgOnx0dZji5IyqZ5CkAh0GK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090058

uart_configure_port() was declared void, so the uart_change_pm(ON)
failure introduced in the previous patch used a bare return that silently
dropped the error and allowed port registration to proceed regardless.

Update serial_core_add_one_port() to check the return value and return
immediately on failure. This propagates up through uart_add_one_port()
to the driver's probe function, allowing the driver to handle or report
the failure rather than silently registering a port that could not be
initialised.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/serial_core.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index e624a67a9395..6cb9e870ba86 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2526,7 +2526,7 @@ uart_report_port(struct uart_driver *drv, struct uart_port *port)
 			port->uartclk / 8, port->uartclk / 4);
 }
 
-static void
+static int
 uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 		    struct uart_port *port)
 {
@@ -2536,7 +2536,7 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 	 * If there isn't a port here, don't do anything further.
 	 */
 	if (!port->iobase && !port->mapbase && !port->membase)
-		return;
+		return 0;
 
 	/*
 	 * Now do the auto configuration stuff.  Note that config_port
@@ -2559,6 +2559,8 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 	}
 
 	if (port->type != PORT_UNKNOWN) {
+		int ret;
+
 		uart_report_port(drv, port);
 
 		/* Synchronize with possible boot console. */
@@ -2566,11 +2568,12 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 			console_lock();
 
 		/* Power up port for set_mctrl() */
-		if (uart_change_pm(state, UART_PM_STATE_ON)) {
+		ret = uart_change_pm(state, UART_PM_STATE_ON);
+		if (ret) {
 			dev_err(port->dev, "failed to power up port\n");
 			if (uart_console(port))
 				console_unlock();
-			return;
+			return ret;
 		}
 
 		/*
@@ -2613,6 +2616,8 @@ uart_configure_port(struct uart_driver *drv, struct uart_state *state,
 				dev_err(port->dev, "failed to power down port\n");
 		}
 	}
+
+	return 0;
 }
 
 #ifdef CONFIG_CONSOLE_POLL
@@ -3094,6 +3099,7 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	struct tty_port *port;
 	struct device *tty_dev;
 	int num_groups;
+	int ret;
 
 	if (uport->line >= drv->nr)
 		return -EINVAL;
@@ -3135,7 +3141,10 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	 * immediately after.
 	 */
 	tty_port_link_device(port, drv->tty_driver, uport->line);
-	uart_configure_port(drv, state, uport);
+
+	ret = uart_configure_port(drv, state, uport);
+	if (ret)
+		return ret;
 
 	port->console = uart_console(uport);
 

-- 
2.34.1

