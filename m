Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381B53B47EF
	for <linux-serial@vger.kernel.org>; Thu,  9 Jul 2026 06:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783578336; cv=none; b=oak/r4KTyBGNbS/+Rk7otwdXhmWLBkTcdO+6ZyaYd1Z4+EI9R907q5EbLKZ/YTioJJ8xiWrWXx4IekMjP2BbNiDEBiIcJCASS4w4V0WIMnrfunJOr1WsxPiVCA+CwCSmfdSSXDYKkcdra//zbusYWpGsRf50cWOcGfW0uwV0HLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783578336; c=relaxed/simple;
	bh=xaM/hVUjZo3snEyz/S9bcZ/H9ysyVZEXqq3xmE7nNZU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DOM+NwWkdpsIC6iCAUaiaz/anzdV2HRPtLqUYSW8Vv9C+5BrEfwyOBiwrAuqaZeEU0PY5aETAxbsXb1a8is8mxVwjskP8tWL2Mr1v8GBMioW3zg9q+jVh3YJtzSck4Z1shcimVxvpWG+0+mciO5T4jfYsLjbYogsHp6Or9FpJ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D/v0rw55; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LZ2hEAid; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D/v0rw55";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LZ2hEAid"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6695xwEW793752
	for <linux-serial@vger.kernel.org>; Thu, 9 Jul 2026 06:25:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=1YqnzWWYNh3cmaUOCZIRd7
	TUov9rA8o7dhqsYSUv9m0=; b=D/v0rw55N+8gvJL2TPFvB6q34PLe7kK4RaJT7w
	WP+mnEBmSOe1UvyzcNS09krx6WOLlf917tXVXnLRrcqAZxP8cRhOA47mW8XnGn1Y
	k8EsYaxNhGsMwsekKBAPgGT4gJlrVctubMoBKyx8sGsn6O5JrKmWfuMdQ9dRswdA
	8M/rOYfeXhKrS/v68WfvkoAcAfdCDSWCvm5SD7xtPdVgnmucXbdeuCqHeUUxIXjI
	bX/2LsSI2Jd0Uri3hT6vNvPCna/B1Qh/GGDh11crLaDF8M4WTbVq0ekjC/ow18Bh
	hndVNiQFktdwwNs0LdMntW5URBp/Fb1Q7fgb8PTSRTYzfNUw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fa1ydryw6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Thu, 09 Jul 2026 06:25:34 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc77a6943eso35062695ad.0
        for <linux-serial@vger.kernel.org>; Wed, 08 Jul 2026 23:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783578333; x=1784183133; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1YqnzWWYNh3cmaUOCZIRd7TUov9rA8o7dhqsYSUv9m0=;
        b=LZ2hEAid8zUnwmtv7vl9FY2iPfy6PqFQMpK4hsIreOhVMp7aQs4aY8xZUV+nUM9/T8
         5YV5EL0TJOwr4d86QFam2GgX7RxMxpyrh8UDZFBn9L5wrZCv0Yh/2T7w5X0O5MsjYgLP
         sEvtztBha0hm/mmGKSvzObhxY+lSPW3+sETxMInyaVh8G+GHNr++sTiGAp6Lc1mTttH/
         ycI5YExr3n9nlNZKEfygDgb9MqOFtbODSpd0eKbZxBFHqOFqNiG1lFakW8svp5PcEqp0
         o1B9zxox8zJVbW0F4J/ILIuUEIrjWvQOZlj2qLxY6flkFVuVgf7+Sr6YNK+4Qf5MAvx9
         mLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783578333; x=1784183133;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1YqnzWWYNh3cmaUOCZIRd7TUov9rA8o7dhqsYSUv9m0=;
        b=bp7xWJCGUS/C9XskFuOJsBTztAMBpFxPB55aHKIa7tLxqjhJy3mupg3kvNxsD68smV
         EjldtDMdy/F9YAbztDSjSXMNuIki7r631exVlmg0rjEzFPKScy0zWYReIFg5yeHkeY1l
         UeORyIFceCNeBpMvlo0aOJvy7t679JcoQ2UyFp+vjFbvfHVRzSqW3N2neNxmIjyiYGUT
         miSmppcGthG0v+9ZOLVmeJqmrpGQlMch6at9n/kzlD3RKXSHZQO73X50HzCpgMbMc6kd
         WdxrNj/y3yJm4dY3Pxle+sOCqbh8eNqxLo9Q+Lh3GqSxNj1FtEvVF8hkKvF0z3vpUZH7
         q3/g==
X-Forwarded-Encrypted: i=1; AHgh+RqsOgw6nF4WVmxG9RM9Kp/3qhWkv2AnFktsSydsg6ATC2oOUFM2INwASFRgtgToAGUfAmxsgGuJJEqg/2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP8wrm+HAaOXnSXMBx1Kmo6apcMupxv7B1Bis0Xs0jRd/QX9ls
	jUm6h3TsAURZ+4pElF2fFvvf+h9u4JLl64XHP+sXr2NKytoYyB4V13t0v1ubL9EBhpkWqb6l9zv
	grahEaHLeTE8NXLhybl41/CGLZ07PzWhqCEvfwvC6n4lpsNEirnKnVzKGlKPs1Ue0AIY=
X-Gm-Gg: AfdE7cl1d/m8eXRBGzXmKblC4XE14QoKhXewNW9eXtPymgY02cYHpo1TCOymZs3KPWm
	wSklwbLNiMz7h+nFzOYmMDbj6ObNgo4lxQJ9PN+4G+habcJpy4WIcpMf9GInfouXHBGe8Z5ROmV
	kVL9M8r8Nm9EnHXE0E6txh48q1ClCbAUXcGVkKl4F9IuWWzhNa5zfUkG4tekfROp3kKbZZC/YjQ
	v61qPxOW5sSLJ6SeuxUu/Us41vgKm9WPod5YemoDyqkojr78bilwm8nHp9Tqd0uuO03Mkbfl1jc
	ahhYom8wom/0E/5Jsj0c3RUhoEAnXcBjr9QPH1Z9v03DaDA9T0KWDSiJFJfMlTIEcJ6Mc51heN/
	FVp25IufjOtff6eL8/rgqsRTejUtH3Hd06FRc5reMgh6B
X-Received: by 2002:a17:903:37cd:b0:2c6:f3ae:2386 with SMTP id d9443c01a7336-2ccea2a571fmr63676775ad.7.1783578333367;
        Wed, 08 Jul 2026 23:25:33 -0700 (PDT)
X-Received: by 2002:a17:903:37cd:b0:2c6:f3ae:2386 with SMTP id d9443c01a7336-2ccea2a571fmr63676155ad.7.1783578332723;
        Wed, 08 Jul 2026 23:25:32 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bf74cbsm37986405ad.18.2026.07.08.23.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 23:25:32 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH 0/6] tty: serial: propagate errors from uart_ops.pm
 callback
Date: Thu, 09 Jul 2026 11:55:12 +0530
Message-Id: <20260709-add_return_check_for_uart_change_pm-v1-0-e85c6ffa8ec4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMg+T2oC/yWNUQrCMBAFr1L220BMaQSvIrKkm42NYlo2iQild
 2+0nwPz5q2QWSJnuHYrCH9ijnNqcD51QJNLD1bRNwajjdUXbZXzHoVLlYQ0Mb0wzILVScHDx+W
 tvKGxt0PbhB5aaREO8ft/ud0PznV8MpVfGrZtB+rg+KeHAAAA
X-Change-ID: 20260706-add_return_check_for_uart_change_pm-d2cb365202f3
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783578321; l=4632;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=xaM/hVUjZo3snEyz/S9bcZ/H9ysyVZEXqq3xmE7nNZU=;
 b=xstS7B9zPIQfwsEBA4/XFGTcfAsU4oB4GSGJzY7XzF/v3xKj/L2hg5jibSJ09Rtcp/Zvw7q/a
 rKqBeBXhUaoCx0C8rUDinlyefoUSLITLDPzV1Kykv7lFa1T2iyWiUtz
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1OCBTYWx0ZWRfX0850EQU+sDv5
 vNcuT1b92TBXWjmwbRRoQdf9eZs0hdTBtkKjq41hcHONAufUSJd+D9AxtKnyuRROtRt2MlcHA4z
 nesQ1Sb1r3/Mcx0xe0oyYRPtqh29O2U=
X-Proofpoint-ORIG-GUID: C6_q29Oej5Z1rd05vkyfRB34Y-8bWw5i
X-Authority-Analysis: v=2.4 cv=cOLQdFeN c=1 sm=1 tr=0 ts=6a4f3ede cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Sp74d_8yOxMrUkFL1bcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: C6_q29Oej5Z1rd05vkyfRB34Y-8bWw5i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1OCBTYWx0ZWRfX+gwvhkDz1oIC
 1P+cPr88P604ty4dq2Uf86FeyQSXtXaTTpqKB7yGgtylbKZl8GMXfv3cfVNR/Ld7T+WkiJHtwvu
 KAwRXSJV1Nis55SuYs+41DHeO7HWQYLVA1rBykvjJV8AS7WWJmoLzxwY6rSO7e2i/pkzrmhBs+f
 GGdaFn67m2wctdBY/4lFWChENSyVq8jkg2rNEUkMA4jkJPG/hhVildO7FxUsWdgf4smC+uADtDy
 ejRoRIK6tDgVSpD8JP33Ru2LfiS5B8R+MjF7C7qAcmstxe2yTLWQpsW7S61JRokXBZOMSzLFT56
 2KOo/wpo9de/M7YcetRl10FpU6wfmD6rwcQWWvhlWaQBIgwd/T+UerVRmX63Dk1qKBafDJaMtMN
 auPH2UkKA6LKBz0GSaeu/NhkoQK5h36KgiNNYMynhyCgKf8YnKrxG3C0SJO2p6GeMGwnoJuUwvb
 M+jPKTxkKrFvfI7psUA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090058

The uart_ops.pm callback has been declared void since its introduction,
which means any error from a driver's power management implementation is
silently discarded by uart_change_pm(). Beyond losing the error
information, uart_change_pm() unconditionally updates state->pm_state
even when the underlying hardware transition failed. This causes the
serial core to track a power state that does not reflect reality:
subsequent calls to uart_change_pm() see the stale cached state as
matching the requested state and skip the callback entirely, leaving the
hardware permanently stuck with no further recovery attempt.

On modern platforms where the .pm callback performs real work —
enabling clock trees, interacting with runtime PM, asserting voltage
regulators — this is a correctness gap. Failures are invisible to the
PM framework, the port proceeds to call ops->startup() on potentially
unpowered hardware, and suspend/resume errors are hidden from the core
that needs to handle them.

This series fixes the problem in four steps:

  Patch 1 changes the uart_ops.pm callback signature from void to int,
  updates uart_change_pm() to propagate errors and only commit
  state->pm_state on success, and handles the return value at every
  call site in serial_core.c with appropriate policy per context
  (propagate, log, or skip-on-failure).

  Patch 2 updates the 8250 driver family: serial8250_do_pm() and
  serial8250_pm() are updated to return int (with the exported symbol
  declaration updated in serial_8250.h), and the 8250 sub-driver
  pm callbacks are updated to return 0.

  Patch 3 updates the remaining non-8250 serial drivers. All .pm
  implementations are updated to return 0. The sh-sci forward
  declaration shared with rsci is also updated.

  Patch 4 updates arch-level implementations: SA1100 (assabet, h3xxx),
  OMAP1/ams-delta (modem_pm, now propagates regulator errors), and
  MIPS/Alchemy (alchemy_8250_pm).

All existing .pm implementations return 0, so there is no functional
change for any current driver. The series purely adds the infrastructure
for drivers to report errors going forward, with the serial core ready
to handle them correctly.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Praveen Talari (6):
      tty: serial: change uart_ops.pm callback to return int
      serial: 8250: update .pm callbacks to return int
      tty: serial: update .pm callbacks to return int
      arch: update uart pm callbacks to return int
      tty: serial: propagate uart_configure_port failure to uart_add_one_port
      serial: qcom-geni: check return value of pm_runtime_resume_and_get()

 arch/arm/mach-omap1/board-ams-delta.c       |  10 +--
 arch/arm/mach-sa1100/assabet.c              |   3 +-
 arch/arm/mach-sa1100/h3xxx.c                |   3 +-
 arch/mips/alchemy/common/platform.c         |   5 +-
 drivers/tty/serial/8250/8250_dw.c           |   3 +-
 drivers/tty/serial/8250/8250_exar.c         |   4 +-
 drivers/tty/serial/8250/8250_mtk.c          |   4 +-
 drivers/tty/serial/8250/8250_omap.c         |   6 +-
 drivers/tty/serial/8250/8250_port.c         |   9 ++-
 drivers/tty/serial/8250/8250_pxa.c          |   6 +-
 drivers/tty/serial/atmel_serial.c           |   5 +-
 drivers/tty/serial/fsl_lpuart.c             |   3 +-
 drivers/tty/serial/msm_serial.c             |   5 +-
 drivers/tty/serial/omap-serial.c            |   3 +-
 drivers/tty/serial/pxa.c                    |   3 +-
 drivers/tty/serial/qcom_geni_serial.c       |  16 +++--
 drivers/tty/serial/samsung_tty.c            |   5 +-
 drivers/tty/serial/sc16is7xx.c              |   5 +-
 drivers/tty/serial/serial_core.c            | 104 ++++++++++++++++++++--------
 drivers/tty/serial/serial_txx9.c            |   3 +-
 drivers/tty/serial/sh-sci-common.h          |   4 +-
 drivers/tty/serial/sh-sci.c                 |   5 +-
 drivers/tty/serial/sprd_serial.c            |   5 +-
 drivers/tty/serial/st-asc.c                 |   5 +-
 drivers/tty/serial/stm32-usart.c            |   5 +-
 drivers/tty/serial/uartlite.c               |   5 +-
 drivers/tty/serial/xilinx_uartps.c          |   5 +-
 include/linux/platform_data/sa11x0-serial.h |   2 +-
 include/linux/serial_8250.h                 |   6 +-
 include/linux/serial_core.h                 |  10 +--
 30 files changed, 171 insertions(+), 86 deletions(-)
---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260706-add_return_check_for_uart_change_pm-d2cb365202f3

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

