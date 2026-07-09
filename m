Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E184F3C2788
	for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2026 06:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578378; cv=none; b=bUmKRxZKLx25P+H/YT4rKTTtZ9EanLGx6HL3OnEmIeaJjV4hcGXA878jGRTGxuMkeL/xl7hySSBPXJcXsXv1YlBFU0f8QZ238no4FrGsrm+vcu14eFSf7BOLgrmh0+VjS8XTpGkAFjbEKEd5/G/eKvVNom55I5WNfm4ltCpPhmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578378; c=relaxed/simple;
	bh=qUNkuXWrcdVtB04kDk+E37DmPlOZJrpTJArSzZKtMVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TfvGj0ayUNrCz5N67JpWiAtdBdl/u1fBFezFlzLbk3toOgij3qbVhWVO+zgfOmkd2ac5KBWVqH9oRAZrKr1e1xqMCPGGbdjQv4D/U/CfCxpzOibpj1XqhJvGlpgpgfyD7Y8TZ8trpWt7wvJ9yKU1R3Ire4mC+ruXRvggtcswDfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yd+vR+Ri; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iQHxMvjt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yd+vR+Ri";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iQHxMvjt"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669618Ka933300
	for <linux-serial@vger.kernel.org>; Thu, 9 Jul 2026 06:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UFMApzgUBiN57ks2oOsTxl0jxniFCalkMhusL1AmBmM=; b=Yd+vR+RiSzmU2zUV
	hZyKp52vpLsGuVzyaT3zoiCIQJ9LFu/DteNpajO0H43/bxH1s2YGKkgl6MANM3HP
	0egOPDeL69RG9qjtaZEfkEFX+a0Y2ywQpdbfx8pwJii51VqEV7acKw9tQNY9LdB9
	96ZN8G+ShctTdORDYx5YoKavz6FFQmM4bX4fi7Go+FVhQh4FwfC8kPoATDv76FMS
	Zer+/y2MD3WKPVItAcKOprBxYYX9AzINFpOtKEDHqpGh2i271ucW7rrhJ+gXH8C8
	YuwC3+8XQoo52D4lrgPQ68v5L/LKW2VkjHVjIGqcTxboeu1e7ONRU/Ay6RTtDKTf
	b2PJZQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9ug6j7kn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2026 06:26:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cce02cb769so20758155ad.1
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 23:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783578368; x=1784183168; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UFMApzgUBiN57ks2oOsTxl0jxniFCalkMhusL1AmBmM=;
        b=iQHxMvjtzHBgf24rsKnmlvUfcPKL/qkbft1RuLvi7Y6pUQ+gXRvWsvWJqKObrmHH7/
         AeEfSofuEnAiJH6THvl0Ruyo8RoDrB95BahEpPjvSxqIvXcWN5hG3tE2ov8jljf7R3hg
         f2v2g02pxbXDMRMERjAQrgWNgKtcR/JNBMJRQ6R2aVod1z6uHpoTvISgIiAQKWo72mFD
         l39LogxgtSE//KMhDmbt1JzSqVJ3jBNZLe2m9DbpgEmvPhSoHWShYw9cWpvVPbyxfsVF
         jWMJ9gkzRz9ujkYuUwCa75roLk8inAoxnCrJZZP9+ytiDxTi/wR1y+zoQQfNuj7sp7FQ
         4wRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783578368; x=1784183168;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UFMApzgUBiN57ks2oOsTxl0jxniFCalkMhusL1AmBmM=;
        b=CV04z3Xd4dRT5PdsuHdcrolPx5Pdo4f4dfIPZRTKCxpwwU9CU9jMQKT3EvDYV2Y2ET
         QE0Fyl8rO0x0o/I3EpmWWjHHQ4d474vJoAmDYap3mJrDqDe7XnTOLp9TP6jhelkNMUdb
         5beRXw71NePPkM0Cs/fsYVU/Izg38Zt0mN/WbGfCWbvzNj7HPksg1MT8mVKjLjBqjHd3
         6kuwwx22xDYkXGAQySIH3D1fNSL1H81Q+zWIi3/TfvIeuXCP8Ls05rxw4CpfaeacNWYy
         nNbg6lMjt6Aa3jnbgP2kypv/xP9wHqYVRjmZenQnBkU29vvN1O6G5R0NsJyjd6H8LE1q
         U6yg==
X-Forwarded-Encrypted: i=1; AHgh+RrwGVO9WT2XvGAhMF81/WeHUiO7hU2DwGeFGoBNYQ4L7fy616LPeapGMPSz2wWdjcMn0EqvvjqRdOVrarA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvbkU3Me73P+LDzbkZSH/VpcpWNmrUC98BXqMWN3DU8P3VRx16
	G4/4oFCxNXBiC23/sXhee+TeJ0dVUuuTUPv2zNXEUamLfWNVYUdgdHkQiNi9OwTyrweI9wOE0Iv
	AG88zMOqTrVn7FLrCrlHrzqJ6f9fcFFyncuzrPXeA8JL9jCsBjnP5tqESiLD3190c5I0=
X-Gm-Gg: AfdE7clq6XDbepqj7CvofK1P6nzkBslfTVQUHAm4nrWhb2Y43xxEmL/RO0jJJjKidVm
	deLXpHkOrHasKI+AoduVkp1Fc/PkIFdHDCL3Q9qeuYq0aXT/DSbJ9n+EMKnwEeg0eQOZ88DjBhF
	9GLEwvOEVrsOniTNPgAGhCWOpACU7MKTutf8qaB4BWQ1koBk7W5dnCZ5qYIwHhsTbXGsu07uEP9
	idF5u1VudQaGSWNBS4+hmc0ObkuSto3Q8UNcL+gzVAzFRy868Nf7hySb4R1UaFn8EDU5tbe3TnD
	rBihlEIQXTjgJAmmhsnhAPakC8whO/z/kGw1wJDN8HJbdH0ZOarjywyQYfGJs89vKbJcZVs3TXv
	ZMs55JmrjoBrKU4mcdJGbdN53LdlSqNWdNqxSR8D/KKQP
X-Received: by 2002:a17:903:298f:b0:2c0:b6c7:227e with SMTP id d9443c01a7336-2ccea3485b7mr72525255ad.5.1783578368301;
        Wed, 08 Jul 2026 23:26:08 -0700 (PDT)
X-Received: by 2002:a17:903:298f:b0:2c0:b6c7:227e with SMTP id d9443c01a7336-2ccea3485b7mr72524695ad.5.1783578367691;
        Wed, 08 Jul 2026 23:26:07 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf74cbsm37986405ad.18.2026.07.08.23.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:26:07 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 11:55:15 +0530
Subject: [PATCH 3/6] tty: serial: update .pm callbacks to return int
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-add_return_check_for_uart_change_pm-v1-3-e85c6ffa8ec4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783578321; l=13929;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=qUNkuXWrcdVtB04kDk+E37DmPlOZJrpTJArSzZKtMVY=;
 b=33rkx3Q4diRf5acWplYLWUgebCOis8BKueJFS0I1nhVhOUHCzaYBEY5s9tR3bAH/jgTDLPvqW
 9Aj9nwmg8NDAZZ7wCZoP7YsLbPjTm+0VnDUDzUnj92SYWNFfEGZTZMo
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1OCBTYWx0ZWRfX1qKxk9HUMo/W
 fV5eUvHGb3RTsJLcBA74GSXEyWSKtEwUQ/DjVKGXOcOZ+pCk1WT07W263WnYltQGAJAvyEyazIM
 8UCPddJoyEdnRt9PJ6PpP2r5z2iGRWw=
X-Proofpoint-GUID: h7tDdPp8xIshNrFet0A45DhUlxp9sJFh
X-Authority-Analysis: v=2.4 cv=cL3QdFeN c=1 sm=1 tr=0 ts=6a4f3f01 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=5x3-L-KNCuIJjzK26vwA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: h7tDdPp8xIshNrFet0A45DhUlxp9sJFh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1OCBTYWx0ZWRfX1vzLTk1FuMKy
 MMujdiUa0NjY/mLmxdNFclwB6IahDosRYgdGfVeypg+kpUh9F2unAsTnjuAwh8aJvLYi0uZd90V
 kYW7dcfUuxpjhFfLggslnftL8iNCx9sur7PpjYRH5U/80G8WfFZYhed3ny7zgT/yHZGnu3i1sYr
 bZGUccLilv6RCdPD7u3a4puDQIIxBLrjxV5bYUHDQVzauCjjRLUvQ8anOLwnyiY2KN50BX/igQC
 0Lr4TNEfHloaKLu1HzwlRsJ2hz595N3Pb75v9Qmo4Y+yGMOKWwn2GiLGfeOgROALk4vCsgADXDL
 nkUqIXtqM2qS+BeVQFwKBdMlOs36QdXuZ2Volg3b4sfMAvvDwCPjZIncrj8wJHOC+gMBhoOh7Di
 lYbXYwwhraRtOGn/RjsdsYpc8JNICxc//GL2gpYM2DpN5Oq4HO6wpQxlMTpVY86ZhP9GNnwe7LL
 TBt54WG2hVqnKS2dPRw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090058

The uart_ops.pm callback signature has been changed from void to int.
Update all remaining non-8250 serial driver .pm implementations to match
the new signature by returning 0.

The sh-sci driver exports sci_pm() for reuse by rsci.c; update the
forward declaration in sh-sci-common.h accordingly.

Drivers updated:
  atmel_serial:    atmel_serial_pm()
  dz:              dz_pm()
  fsl_lpuart:      lpuart_uart_pm()
  msm_serial:      msm_power()
  omap-serial:     serial_omap_pm()
  pxa:             serial_pxa_pm()
  qcom_geni_serial: qcom_geni_serial_pm()
  samsung_tty:     s3c24xx_serial_pm()
  sc16is7xx:       sc16is7xx_pm()
  serial_txx9:     serial_txx9_pm()
  sh-sci/rsci:     sci_pm()
  sprd_serial:     sprd_pm()
  st-asc:          asc_pm()
  stm32-usart:     stm32_usart_pm()
  uartlite:        ulite_pm()
  xilinx_uartps:   cdns_uart_pm()
  zs:              zs_pm()

No functional change intended.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/tty/serial/atmel_serial.c     | 5 +++--
 drivers/tty/serial/fsl_lpuart.c       | 3 ++-
 drivers/tty/serial/msm_serial.c       | 5 +++--
 drivers/tty/serial/omap-serial.c      | 3 ++-
 drivers/tty/serial/pxa.c              | 3 ++-
 drivers/tty/serial/qcom_geni_serial.c | 5 +++--
 drivers/tty/serial/samsung_tty.c      | 5 +++--
 drivers/tty/serial/sc16is7xx.c        | 5 +++--
 drivers/tty/serial/serial_txx9.c      | 3 ++-
 drivers/tty/serial/sh-sci-common.h    | 4 ++--
 drivers/tty/serial/sh-sci.c           | 5 +++--
 drivers/tty/serial/sprd_serial.c      | 5 +++--
 drivers/tty/serial/st-asc.c           | 5 +++--
 drivers/tty/serial/stm32-usart.c      | 5 +++--
 drivers/tty/serial/uartlite.c         | 5 +++--
 drivers/tty/serial/xilinx_uartps.c    | 5 +++--
 16 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 5d8c1cfc1c60..bcbcb77d4df8 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2063,8 +2063,8 @@ static void atmel_shutdown(struct uart_port *port)
 /*
  * Power / Clock management.
  */
-static void atmel_serial_pm(struct uart_port *port, unsigned int state,
-			    unsigned int oldstate)
+static int atmel_serial_pm(struct uart_port *port, unsigned int state,
+			   unsigned int oldstate)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 
@@ -2095,6 +2095,7 @@ static void atmel_serial_pm(struct uart_port *port, unsigned int state,
 	default:
 		dev_err(port->dev, "atmel_serial: unknown pm %d\n", state);
 	}
+	return 0;
 }
 
 /*
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index b7919c05f0fb..a6b6fb7aca88 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -820,7 +820,7 @@ static void lpuart32_start_tx(struct uart_port *port)
 	}
 }
 
-static void
+static int
 lpuart_uart_pm(struct uart_port *port, unsigned int state, unsigned int oldstate)
 {
 	switch (state) {
@@ -832,6 +832,7 @@ lpuart_uart_pm(struct uart_port *port, unsigned int state, unsigned int oldstate
 		pm_runtime_get_sync(port->dev);
 		break;
 	}
+	return 0;
 }
 
 /* return TIOCSER_TEMT when transmitter is not busy */
diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 2e999cb9c974..33b663a3514c 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1421,8 +1421,8 @@ static int msm_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return 0;
 }
 
-static void msm_power(struct uart_port *port, unsigned int state,
-		      unsigned int oldstate)
+static int msm_power(struct uart_port *port, unsigned int state,
+		     unsigned int oldstate)
 {
 	struct msm_port *msm_port = to_msm_port(port);
 
@@ -1440,6 +1440,7 @@ static void msm_power(struct uart_port *port, unsigned int state,
 	default:
 		pr_err("msm_serial: Unknown PM state %d\n", state);
 	}
+	return 0;
 }
 
 #ifdef CONFIG_CONSOLE_POLL
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index a689d190940c..5029821e3559 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1017,7 +1017,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	dev_dbg(up->port.dev, "serial_omap_set_termios+%d\n", up->port.line);
 }
 
-static void
+static int
 serial_omap_pm(struct uart_port *port, unsigned int state,
 	       unsigned int oldstate)
 {
@@ -1035,6 +1035,7 @@ serial_omap_pm(struct uart_port *port, unsigned int state,
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_EFR, efr);
 	serial_out(up, UART_LCR, 0);
+	return 0;
 }
 
 static void serial_omap_release_port(struct uart_port *port)
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 10fc8990579b..1f6541f251f9 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -507,7 +507,7 @@ serial_pxa_set_termios(struct uart_port *port, struct ktermios *termios,
 	uart_port_unlock_irqrestore(&up->port, flags);
 }
 
-static void
+static int
 serial_pxa_pm(struct uart_port *port, unsigned int state,
 	      unsigned int oldstate)
 {
@@ -517,6 +517,7 @@ serial_pxa_pm(struct uart_port *port, unsigned int state,
 		clk_prepare_enable(up->clk);
 	else
 		clk_disable_unprepare(up->clk);
+	return 0;
 }
 
 static void serial_pxa_release_port(struct uart_port *port)
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 7ead87b4eb65..17ab8acb3b8e 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1724,8 +1724,8 @@ static int geni_serial_resource_init(struct uart_port *uport)
 	return 0;
 }
 
-static void qcom_geni_serial_pm(struct uart_port *uport,
-		unsigned int new_state, unsigned int old_state)
+static int qcom_geni_serial_pm(struct uart_port *uport,
+			       unsigned int new_state, unsigned int old_state)
 {
 
 	/* If we've never been called, treat it as off */
@@ -1738,6 +1738,7 @@ static void qcom_geni_serial_pm(struct uart_port *uport,
 		 old_state == UART_PM_STATE_ON)
 		pm_runtime_put_sync(uport->dev);
 
+	return 0;
 }
 
 /**
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 63d0232dffc2..4d35112cb153 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1290,8 +1290,8 @@ static int apple_s5l_serial_startup(struct uart_port *port)
 	return ret;
 }
 
-static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
-			      unsigned int old)
+static int s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
+			     unsigned int old)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 	int timeout = 10000;
@@ -1318,6 +1318,7 @@ static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
 	default:
 		dev_err(port->dev, "s3c24xx_serial: unknown pm %d\n", level);
 	}
+	return 0;
 }
 
 /* baud rate calculation
diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index daebd92f32c7..47fec6c5e3c2 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1216,10 +1216,11 @@ static int sc16is7xx_verify_port(struct uart_port *port,
 	return 0;
 }
 
-static void sc16is7xx_pm(struct uart_port *port, unsigned int state,
-			 unsigned int oldstate)
+static int sc16is7xx_pm(struct uart_port *port, unsigned int state,
+			unsigned int oldstate)
 {
 	sc16is7xx_power(port, (state == UART_PM_STATE_ON) ? 1 : 0);
+	return 0;
 }
 
 static void sc16is7xx_null_void(struct uart_port *port)
diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index 4ae9a45c8e3a..e97dea43708a 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -680,7 +680,7 @@ serial_txx9_set_termios(struct uart_port *up, struct ktermios *termios,
 	uart_port_unlock_irqrestore(up, flags);
 }
 
-static void
+static int
 serial_txx9_pm(struct uart_port *port, unsigned int state,
 	      unsigned int oldstate)
 {
@@ -694,6 +694,7 @@ serial_txx9_pm(struct uart_port *port, unsigned int state,
 	 */
 	if (state == 0 && oldstate != -1)
 		serial_txx9_initialize(port);
+	return 0;
 }
 
 static int serial_txx9_request_resource(struct uart_port *up)
diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index 01ff9fced803..2f03750094df 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -44,8 +44,8 @@ void sci_release_port(struct uart_port *port);
 int sci_request_port(struct uart_port *port);
 void sci_config_port(struct uart_port *port, int flags);
 int sci_verify_port(struct uart_port *port, struct serial_struct *ser);
-void sci_pm(struct uart_port *port, unsigned int state,
-		   unsigned int oldstate);
+int sci_pm(struct uart_port *port, unsigned int state,
+	   unsigned int oldstate);
 
 struct plat_sci_reg {
 	u8 offset;
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 787e7cdc5e9c..36a08fd6677f 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2931,8 +2931,8 @@ static void sci_set_termios(struct uart_port *port, struct ktermios *termios,
 		sci_enable_ms(port);
 }
 
-void sci_pm(struct uart_port *port, unsigned int state,
-		   unsigned int oldstate)
+int sci_pm(struct uart_port *port, unsigned int state,
+	   unsigned int oldstate)
 {
 	struct sci_port *sci_port = to_sci_port(port);
 
@@ -2944,6 +2944,7 @@ void sci_pm(struct uart_port *port, unsigned int state,
 		sci_port_enable(sci_port);
 		break;
 	}
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(sci_pm, "SH_SCI");
 
diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 092755f35683..571123f58232 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -900,8 +900,8 @@ static int sprd_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return 0;
 }
 
-static void sprd_pm(struct uart_port *port, unsigned int state,
-		unsigned int oldstate)
+static int sprd_pm(struct uart_port *port, unsigned int state,
+		   unsigned int oldstate)
 {
 	struct sprd_uart_port *sup =
 		container_of(port, struct sprd_uart_port, port);
@@ -914,6 +914,7 @@ static void sprd_pm(struct uart_port *port, unsigned int state,
 		clk_disable_unprepare(sup->clk);
 		break;
 	}
+	return 0;
 }
 
 #ifdef CONFIG_CONSOLE_POLL
diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 6ed9a327702b..39404bd94592 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -435,8 +435,8 @@ static void asc_shutdown(struct uart_port *port)
 	free_irq(port->irq, port);
 }
 
-static void asc_pm(struct uart_port *port, unsigned int state,
-		unsigned int oldstate)
+static int asc_pm(struct uart_port *port, unsigned int state,
+		  unsigned int oldstate)
 {
 	struct asc_port *ascport = to_asc_port(port);
 	unsigned long flags;
@@ -459,6 +459,7 @@ static void asc_pm(struct uart_port *port, unsigned int state,
 		clk_disable_unprepare(ascport->clk);
 		break;
 	}
+	return 0;
 }
 
 static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index ad06b760cfca..a4a93d3911f8 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1418,8 +1418,8 @@ stm32_usart_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return -EINVAL;
 }
 
-static void stm32_usart_pm(struct uart_port *port, unsigned int state,
-			   unsigned int oldstate)
+static int stm32_usart_pm(struct uart_port *port, unsigned int state,
+			  unsigned int oldstate)
 {
 	struct stm32_port *stm32port = container_of(port,
 			struct stm32_port, port);
@@ -1438,6 +1438,7 @@ static void stm32_usart_pm(struct uart_port *port, unsigned int state,
 		pm_runtime_put_sync(port->dev);
 		break;
 	}
+	return 0;
 }
 
 #if defined(CONFIG_CONSOLE_POLL)
diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index 6240c3d4dfd7..8e2d1d4dc10a 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -412,8 +412,8 @@ static int ulite_verify_port(struct uart_port *port, struct serial_struct *ser)
 	return -EINVAL;
 }
 
-static void ulite_pm(struct uart_port *port, unsigned int state,
-		     unsigned int oldstate)
+static int ulite_pm(struct uart_port *port, unsigned int state,
+		    unsigned int oldstate)
 {
 	int ret;
 
@@ -425,6 +425,7 @@ static void ulite_pm(struct uart_port *port, unsigned int state,
 		pm_runtime_mark_last_busy(port->dev);
 		pm_runtime_put_autosuspend(port->dev);
 	}
+	return 0;
 }
 
 #ifdef CONFIG_CONSOLE_POLL
diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index a072b75dbaf2..c81a57e0c77e 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1231,8 +1231,8 @@ static void cdns_uart_poll_put_char(struct uart_port *port, unsigned char c)
 }
 #endif
 
-static void cdns_uart_pm(struct uart_port *port, unsigned int state,
-		   unsigned int oldstate)
+static int cdns_uart_pm(struct uart_port *port, unsigned int state,
+			unsigned int oldstate)
 {
 	switch (state) {
 	case UART_PM_STATE_OFF:
@@ -1243,6 +1243,7 @@ static void cdns_uart_pm(struct uart_port *port, unsigned int state,
 		pm_runtime_get_sync(port->dev);
 		break;
 	}
+	return 0;
 }
 
 static const struct uart_ops cdns_uart_ops = {

-- 
2.34.1

