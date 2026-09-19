Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC86738424C
	for <linux-serial@vger.kernel.org>; Sat, 19 Sep 2026 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789856791; cv=none; b=SIC9kN5M9ovHRlwRNdxIf5uPk7mGmaWfoESrCFZu2uSe0XLp451YbiYyPHzCn55lxcmWkuObFPd0p0wbz3lS63VnkFm1Ip4gHValewEqiHXcn2NlqO1m/XBEGT+RdrCY+m7GRgdgkYUmQUHDmKKO3wyY1tPjcZo15uV8YiAhVi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789856791; c=relaxed/simple;
	bh=bKmQjDO7xOd0syALACTYy/o5iBLTBBmStjTLuJ58dQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUbssbm5Mxhh2RbPo5jPOL6w9GELNpNUsmK0JMGRlzqI63oljr25pL5SnbuTTyXquaLfLAT8gmQfOdEHqOVHVGNDIK/fz4JYCIrF84rz3jP2yePPhjMbRSS9JrNBJDJKyxlushCxgwW6b0LrwjnVpHKzytx07cB76f9F6c8rwqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ee10MDwo; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee10MDwo"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469f204f6so1240943b3a.2
        for <linux-serial@vger.kernel.org>; Sat, 19 Sep 2026 15:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789856789; x=1790461589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V9Y/SVxm8MOmqJvVl1qnXFoqmvLC78rd9Cv4PArFdCA=;
        b=Ee10MDwor725T37Cj10NUKdaLvJofCD+zWGsJp+ns1L7a9/Qx36I5as1qOrDHMZikb
         Z/UayuZShLR1NWmcJKtGMg6cdBkygWNbtg/kfDI+yGvbbzsM1ikGkcvwHdQKGkS3FU3I
         z6bBd+7ULRrQJYHbLcDQXorNXFkeuC/zpj2tZpub6lkZXy5wmclbLZt+XZ/5K1Cp8+iL
         qONmuSZweJYbkmrrfzB/JcinmcCLqFrpLxIrhbqrMpzbIES3aU9lM/KeTv6JqncLcpse
         Mf/HrHqKqxEuiCo7YnvC1yAfEB43Gu3KZEJbyfn6ca92o6veVUc4L1xNwdBgoVoIM7Tj
         i20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789856789; x=1790461589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V9Y/SVxm8MOmqJvVl1qnXFoqmvLC78rd9Cv4PArFdCA=;
        b=KsOMRYYbRGJH/i41QiwdqgBTIwGQMibS4DAO8172zvcOe7/aToqMEHeH2AEzrdnki/
         Gw2I3Zsk5G7+jqkLSDt0atObsY7J3WoDsKmilp6WNY5P6HWLvHV8OwzV33gJ9x8vvPhu
         gtMJiN+N1bDMr/GFrc/Aa84LfXmZAmvPGVeIzasx/khhdg+XXzjQxbf2fHz35XRoI4mU
         Izww8ZbuY3oN3VNszWdTziXk/VsAfjP0fsQjsYyIZ4lJhhNDk9/bGji94gbuNXeCb0UR
         nxbOQk+clUcZq/zbiVvSY9XwwXTQQQysLsnRL/lLA7cEdyz7b7dzxOb7TrKjEpp2EFug
         bQAQ==
X-Gm-Message-State: AFuF++m/MVnG17puV+q2wkLW+C+DI3t8QPMrVamhFKhsmPVhkLSFBpNH
	+xGehcA3lNjXJ6NUTKr/5sQrBWbHp0zRPT0ssjllfYqxASi2E9NTcYre
X-Gm-Gg: AYBFou32nbTfAwMPIIw8nc5mK9ElYxUrsv55KMKhcAvk7ggXGNaNIfHAtIQU1ZehKEJ
	Dj5Zenbm39fETaFAcTFCs2zKJ68qh6TURoGo+9znyq+jfvwc/x6ZfoFjAw24rX9X6Ey50jmjXS3
	YGHCciAplzn11Ty1610DWkc+tzjppgRWM+W9EKCL4erpI4b9dtrJhXHssnh8Dz0jPGrqk29elDt
	rRYxfoAuB6QQdUyDUKLOvWafUqA99y8Z61aKXzyLBOYi1nL8AcK3lwaNyXdkuBDEWGt3TVx3kO+
	DOuCRjqci6GqxtwudVp+ZLpD8dxdaCwNwl75j9yUVndYOWwahe2EK5AdGhpy1Xf9eRDuZhi6dvR
	F4hrbJlF3D6krijURQfvHPppIaN0xMc1F3pRETVrBsT6A3juj1mlDNLg5b10BTbTLIzb0+qWkZj
	26KXRqJ04xNQTLX2TKCLIQdr2KwFxFsiOqGGMIYiZrM3t7pPEn16Cp9xj3FhJ3hNOGDgNPeOCSA
	t6ldVy4r4UCM4b/EmRByVTIbEK20We1M1cEH0aPCpIClRFjahpFzCqeyS7EhU6gI6ABQyfigBsN
	peBBnzkuRA==
X-Received: by 2002:a05:6a00:94d6:b0:857:7317:cff5 with SMTP id d2e1a72fcca58-874decf4e9emr10344836b3a.22.1789856789222;
        Sat, 19 Sep 2026 15:26:29 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a6ae7d71sm1352690b3a.2.2026.09.19.15.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:26:28 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	john.ogness@linutronix.de
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] serial: fix 8250 hash_mutex race and uart_get_baud_rate() divide-by-zero
Date: Sat, 19 Sep 2026 22:26:27 +0000
Message-ID: <20260919222627.3797854-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix two bugs in the serial subsystem:

1. In serial8250_Label / serial_link_irq_chain() and
   serial_unlink_irq_chain() (drivers/tty/serial/8250/8250_core.c), hold
   hash_mutex across the entire IRQ list manipulation and
   request_irq()/free_irq() sequence to prevent racing IRQ chain
   insertions/removals.
2. In uart_get_baud_rate() and uart_set_info()
   (drivers/tty/serial/serial_core.c), avoid unsigned overflow in
   port->uartclk = new_info->baud_base * 16 and ensure the fallback
   retry in uart_get_baud_rate() terminates cleanly when no baud rate
   lies in [min, max].

Fixes: ab4382d27412 ("tty: move drivers/serial/ to drivers/tty/serial/")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index b875d394796f..0bc810f285a4 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -134,8 +134,6 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
 {
 	struct irq_info *i;
 
-	guard(mutex)(&hash_mutex);
-
 	hash_for_each_possible(irq_lists, i, node, up->port.irq)
 		if (i->irq == up->port.irq)
 			return i;
@@ -156,6 +154,8 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 	struct irq_info *i;
 	int ret;
 
+	guard(mutex)(&hash_mutex);
+
 	i = serial_get_or_create_irq_info(up);
 	if (IS_ERR(i))
 		return PTR_ERR(i);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 95774b0f1484..4cd4fb0f7ee3 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -501,7 +501,7 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 		break;
 	}
 
-	for (try = 0; try < 2; try++) {
+	for (try = 0; try < 3; try++) {
 		baud = tty_termios_baud_rate(termios);
 
 		/*
@@ -965,7 +965,7 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
 	}
 
 	if ((new_info->irq >= irq_get_nr_irqs()) || (new_info->irq < 0) ||
-	    (new_info->baud_base < 9600))
+	    (new_info->baud_base < 9600) || (new_info->baud_base > UINT_MAX / 16))
 		return -EINVAL;
 
 	if (change_port || change_irq) {
