Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A47A52ED20
	for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792075622; cv=none; b=fynWffA1x7uCJcqmPhw9UOrGKKvQkfnk7biKMtW9Ycg9PvYiAcnksGcMd98Pe5CyYMmMBxFhMumQWNExkAV23/rp0fLpNSeRMChI5XWAF0SdVohFRg02wWisCaKa/lL83phtnduh1h/aF/93m42bvHH6o30W3j0MEFFWYx2r81k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792075622; c=relaxed/simple;
	bh=iC9DN0Sjs9ijrGYXSch8NNYrtcI4yW7Tfh/t6BjbqPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BJyEeyXF2BIpOvBAbzYTThYZUjdZZBqTVbU4N6d2cr1n/u6V+wvTOUYENTWDzR+3HjvAvYnQo8klOuIGnNMV910RDo6O3leHYoSIPzErKeWy18AEgW/9qHDH+hvCM8lKXkJ2HhVYe1tc1ykrsrq8yCNjPhRIu0SLNv0MEa76qWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ossystems.com.br; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6dd4f3f696aso2730554eaf.1
        for <linux-serial@vger.kernel.org>; Thu, 15 Oct 2026 07:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792075620; x=1792680420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m1Sj8rSdmb/pbigDyObZpWX/JDYcZPR3uB5iI75Xx8c=;
        b=WG5SkiYBfER7L1gSQQrRAKRyatARG7MPt/TZQIjrfNZSr+IbeTYc5JhQJulQCrgxgS
         xAnh8iSK2l41OyMgS1pMa3CFGU97tCSGqHrGsJwqqZXrsCWAq3vA4RAiu3zNr5jv7S03
         BsVkzpwZE4j3pSazUiC2/g0oKLRq5iVWNqTBjt0FHoxcC8W2Z/SOIqvtr1aw5fK0G831
         J/LpVaNGrbiDC43DjsMhdDTtnEz8ctG7Du8sgZrFi0nVRJQtkQgQEdEzfhgmnLFJFthn
         IZ1Z/Px/3wYIguRM4FlyyQ/XiRp0hV+gqmFsh48z5joRzGYBzqj5OBcjJFW473RAHGJS
         CZtA==
X-Forwarded-Encrypted: i=1; AKwUvBymmF0prJVj399Ie3lmKYQGifSBo5c2x3PCnghOHP9oKqomWSwSkdjFiI70eMAVCE94uu/yBQqWArE3YI0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLB0HGCxuI9RmcqupZnP4nmTimTI1IqleGsB/KgJPKfYEkWJSyG
	ac4JfUBRtsJaeCPkRQIR9iBSgEEKNVjqYnhLYdWMM6NcMTCWp9eKtDUj
X-Gm-Gg: AYBFou1rVbg78XkP9U1TXFOJIENHXSN5d4TKyerlr/+PGBVHN0llvTmMn/yqgXIvvqm
	QVQO0UVwiVVTH/85cBN6bM0E5GZckTtGz3cd9VMKRIaMdBWdl5Bd0R21OtOQCQOxHV/x9s5JSfI
	QtROVoDwgzmuYj7MQ1qZSddoZLAAvvWl6kdxk0k6myztLqdjPP2ByEfc4zPEKYQ6zRDd3SvoCBY
	/aHu1frE+G+fN2ybhTpoqWrcd2Uw1BQOMAu3hk8BhdZ10szAC5oTpWhKPWCep+/JyRYPEK7N4xx
	T/aR6DpgFo+4YG0VPHHCX8eFRTmFFvixv8KS1EYPn92j+u5v58ggSuBInS3pDRm+xA3uX3U3ln8
	PpNJ0WWewQasA+Iq9Hiy7v+Kl6Y76en4VAJCbtXyxp7Z7S9iJc5FobkogcCs9i7Vxxfza9qd+kP
	UQSqE0TX0Ij+OV3U8ehL8OLQlpByOz68itDAe+2WSy2gbVarKy7+vaM+2GMkHIy8ZeFYDDPQaVu
	70N8zwbtqI6cixlMCKlgUyLpIWJjc4+CXcWbXTnVJqVJogZkpvwWvO6q24E2cf0KwjxNuSt47O9
	/UHqrpK/YYrh8eB/zuQO90HeIHcfAFp+g/dQHVPDkIQXzxgKbt87VfwBxLpNjTwEqLYxa6wPucY
	fmLK1AwzL+dk=
X-Received: by 2002:a05:6820:162b:b0:6f7:6416:a34 with SMTP id 006d021491bc7-6f764161ae2mr8416735eaf.41.1792075620353;
        Thu, 15 Oct 2026 07:47:00 -0700 (PDT)
Received: from localhost ([201.89.183.74])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a6dfc982a4sm4664115fac.14.2026.10.15.07.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 07:46:59 -0700 (PDT)
From: Otavio Salvador <otavio@ossystems.com.br>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-serial@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Otavio Salvador <otavio@ossystems.com.br>,
	"Rodrigo M. Duarte" <rodrigo.duarte@ossystems.com.br>
Subject: [PATCH] serial: imx: keep the CPU out of deep idle while an RS485 port is open
Date: Thu, 15 Oct 2026 11:46:27 -0300
Message-ID: <20261015144627.2461915-1-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In RS485 mode the driver releases the transmitter (RTS/DE) from the TX
complete interrupt. On i.MX6UL/ULL the imx6sx cpuidle driver offers an
"ARM power off" state with a declared exit latency of 300us, measured at
up to 2ms. When the CPU enters it while the last character is shifted
out, DE is released that much later. Modbus RTU slaves may answer after
3.5 character times (1.75ms at >=19200 baud), so the head of their reply
collides with our still-driven transmitter and is lost.

Add a CPU latency QoS request of 100us while an RS485 port is open. It
excludes the power-off state but keeps WFI and WAIT (50us) available, so
cpuidle can stay enabled and the constraint only applies while the port
is in use.

The request is added on startup and removed on shutdown, and its value
follows the RS485 state in imx_uart_rs485_config(), so RS485 enabled
through TIOCSRS485 after the port is opened, as libmodbus does, is
covered as well.

Tested-by: Rodrigo M. Duarte <rodrigo.duarte@ossystems.com.br>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---
 drivers/tty/serial/imx.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 986fefb45c632..be05ed94bf0c4 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -24,6 +24,7 @@
 #include <linux/ktime.h>
 #include <linux/mutex.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/pm_qos.h>
 #include <linux/rational.h>
 #include <linux/slab.h>
 #include <linux/of.h>
@@ -237,6 +238,7 @@ struct imx_port {
 	struct hrtimer		trigger_start_tx;
 	struct hrtimer		trigger_stop_tx;
 	unsigned int		rxtl;
+	struct pm_qos_request	rs485_pm_qos;
 };
 
 struct imx_port_ucrs {
@@ -339,6 +341,22 @@ static void start_hrtimer_ms(struct hrtimer *hrt, unsigned long msec)
        hrtimer_start(hrt, ms_to_ktime(msec), HRTIMER_MODE_REL);
 }
 
+/*
+ * In RS485 mode the transmitter is only released from the TX complete
+ * interrupt. If the CPU sits in a deep idle state at that point, the wakeup
+ * delays the release long enough to collide with fast responders on the
+ * bus. The i.MX6UL/SX "ARM power off" state has a 300us exit latency and was
+ * measured at up to 2ms, so keep the CPU out of states slower than this while
+ * an RS485 port is open.
+ */
+#define IMX_UART_RS485_CPU_LATENCY_US	100
+
+static s32 imx_uart_rs485_cpu_latency(u32 rs485_flags)
+{
+	return rs485_flags & SER_RS485_ENABLED ?
+		IMX_UART_RS485_CPU_LATENCY_US : PM_QOS_DEFAULT_VALUE;
+}
+
 /* called with port.lock taken and irqs off */
 static void imx_uart_soft_reset(struct imx_port *sport)
 {
@@ -1585,6 +1603,9 @@ static int imx_uart_startup(struct uart_port *port)
 
 	uart_port_unlock_irqrestore(&sport->port, flags);
 
+	cpu_latency_qos_add_request(&sport->rs485_pm_qos,
+				    imx_uart_rs485_cpu_latency(port->rs485.flags));
+
 	return 0;
 }
 
@@ -1710,6 +1731,8 @@ static void imx_uart_shutdown(struct uart_port *port)
 
 	clk_disable_unprepare(sport->clk_per);
 	clk_disable_unprepare(sport->clk_ipg);
+
+	cpu_latency_qos_remove_request(&sport->rs485_pm_qos);
 }
 
 /* called with port.lock taken and irqs off */
@@ -2053,6 +2076,11 @@ static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termio
 		imx_uart_start_rx(port);
 	}
 
+	/* The request only exists while the port is open */
+	if (cpu_latency_qos_request_active(&sport->rs485_pm_qos))
+		cpu_latency_qos_update_request(&sport->rs485_pm_qos,
+					       imx_uart_rs485_cpu_latency(rs485conf->flags));
+
 	return 0;
 }
 
-- 
2.55.0

