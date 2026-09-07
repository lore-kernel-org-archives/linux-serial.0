Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E08503BC0
	for <linux-serial@vger.kernel.org>; Mon,  7 Sep 2026 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794885; cv=none; b=LikxilFuIV97CCmHCiMh/DBT87D4idYzE55w3osJG5QWfogn/1IdvUP0rwxjpVT84vzWqiYKTfnP0nym2hk6Fji6rQnSoeIJMLo9g7x4MHKnVbf0khFjHYtZnhPIaaT2ZBOKm5uRNM+ALBaUBiSld1ytUH3vuARR4eIz8MtrGlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794885; c=relaxed/simple;
	bh=vhajuZrsqmCwOt5dYh0K0ju9UJkTcDDqh+0g8hbzEHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TXCqK5nyi1YBh8HO0kBilwZihbJvDJN2ME5WUGoRcVH+wHjx37vxlQOecB37qHY6RdVe3oYUnEf9Q51zOoBoApJstUFGGfc8QjGM3Rn1+N6J2qvzpJq2S00boIdH59Y3AA6v9zLthNZM1iD2u9PDPfZjG9JSBEmO4cdYnarUxvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oNeULgsG; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNeULgsG"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-484374f54d0so2281932f8f.3
        for <linux-serial@vger.kernel.org>; Mon, 07 Sep 2026 08:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788794882; x=1789399682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+ZQ7Pm71SixvZJgMI4PIPsvZ2aqIswjWhqrRzsbUnlg=;
        b=oNeULgsG+OmZ+vwrMoX/PW+Y1cfCIc+lj3pg0/j8kZ9oxqT1J+Xthr/6QEBKed7PqE
         7xy99b9Cw9R4jS3WZaV8O7mJFuF1kSriJbWNRorIgEaO3KoXEiQPZeXm2sdln2tvN8EC
         CWxwCpq0Bn+vVsrTJ3JAWbBBF7s0u/PXL2XOCukzCkg2RGUuCnELFzjcKgRhG5zU/ngm
         3MhgcyQ0pxW3SG9Mhc7YC7krgjlhAxdrSebOo6tYoxlvcTsh+BLacIDkNFqwAGYKD/fK
         1WeoPyvHKr0ybFe2JgramOyysm6wCK3M10YjcotPPJFMN6rF1lYCpx/FD6M8PZ6p3ZvF
         04Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788794882; x=1789399682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ZQ7Pm71SixvZJgMI4PIPsvZ2aqIswjWhqrRzsbUnlg=;
        b=IsRrfts80/P1Q65X7CYJL0F33wPXgxo+9mOAO33LadWFyW66BpqM97L37uqqw1Atiw
         nRadCmfhWn0bZd/5B6qSxTspZddeAYpwhxuunIxjss2HS6nRFVqvRlzkiEheDYdin5t9
         vRGm1ejmETNkeNS8m2MtVyTX+ioCTq2R1lqX0JKVfa210lhuSqkcJ/TsbjRQ/sX72VIt
         AbBh2GSIM4Z2LFuN5w1LgEdDxNaqwvSskCbkd1Edx8swfjN4sWiJsiBAsBNKf6S/Ue+4
         7Sx/BRC/vHjoY5HPiBxyBed+qw98ycE91/2AoPR6508FBRhFq4qPDkmYbLr+o9ol8Mkl
         8rIg==
X-Gm-Message-State: AFuF++kFZH7mkHfpZMRbr/+6vLucHvRyg+EBcZnByM8Pxe1zsdkdTvBF
	VN5fmwUM+iXvTnLx9Oi/0EC3XtShCAcQoe13zT4OmrNowyOc3AOHv7as
X-Gm-Gg: AYBFou3u20Q4kw+BjMYY0MsOGiMCojqXvx838YfC3o8t6t6HktY9l4Cd+UUSiOWoQX6
	+d6P4ljQ76q09zAYYGzi40rqflssQO8BpjlEjwrxue0TF+K2hQ2pdRpFkvlx7jwsxJnnOew6cDN
	oBV2rPlmPPpxrAj7oHh9u+T44p9S9RSyuga9eHuKbFIa7p3Y31DlphXBczHLXTqljj5fBeJf0iH
	PnKiKGJP0jm4PL24WrLR3WgGLVbgoAZHfnngkOZ+sMTaaEdNVmaCMPvzzzBeHjxi8M9AEUXBHKB
	daGL4k3dHWrZt4lci8hm2JE1dzJFl8aMU3YDeW6xB9RGgPuVpNyKa0NoVQ4J7S0LQRmnjZ4puhv
	eJd8e9xTrD7BDbfZJCxA/11kHxsRYccFsKAiCbFsKh/VzRzdCnjagpc/bCTppJ/Ctye/tU55ILw
	wvMEP/P14VAgOm+UvRg6dJyP3wHXjp8xpPOEiz66mbSp5DIs0ePDjRvrNmUPFb61Kbnp2lVJQdv
	w6gl73P/D8M1fEJOXdsbgvnQNPyKR4wbiKw5tU85IUO3BDf/3a+MQSrzBnN7Xc9/n2BD00PwAk2
	V3A=
X-Received: by 2002:a05:6000:470a:b0:485:8101:dc40 with SMTP id ffacd0b85a97d-48587057037mr38784665f8f.9.1788794881422;
        Mon, 07 Sep 2026 08:28:01 -0700 (PDT)
Received: from MYL150-3871.localdomain (80.151.89.79.rev.sfr.net. [79.89.151.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c074asm28525915f8f.23.2026.09.07.08.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:28:01 -0700 (PDT)
From: Nicolas Thibert <nithibert@gmail.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] serial: 8250_of: set UART_CAP_NOTEMT for rts-gpios RS485 direction
Date: Mon,  7 Sep 2026 17:27:44 +0200
Message-Id: <20260907152744.1084359-1-nithibert@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__stop_tx() (8250_port.c) only calls the RS485 rs485_stop_tx() hook
(which de-asserts the direction GPIO/RTS line) once it has observed
both UART_LSR_THRE and UART_LSR_TEMT for the last byte. If TEMT is
never seen and the driver hasn't set UART_CAP_NOTEMT, the function
returns without scheduling any retry -- the direction line is left
asserted (driver enabled) forever, with nothing to un-stick it short
of another kernel-visible LSR event.

of_platform_serial_setup() unconditionally wires up the generic em485
GPIO-RTS RS485 support (rs485_config/rs485_start_tx/rs485_stop_tx) for
every port it registers, but never sets UART_CAP_NOTEMT, so any board
using this driver whose 16550-compatible core doesn't reliably surface
TEMT for its shift register hits the stuck-direction-GPIO case above.

Confirmed live on an ath79 QCA9531 board (SoC-internal ns16550a-
compatible UART, RS485 transceiver DE/RE tied together on a GPIO via
rts-gpios, linux,rs485-enabled-at-boot-time): the direction GPIO
correctly asserts for the duration of a transmit, but never
de-asserts afterwards -- confirmed by sampling the GPIO's debugfs
state through and after a multi-hundred-byte write, on both the first
transmit and repeated back-to-back transmits. Setting
UART_CAP_NOTEMT, which makes __stop_tx() fall back to a frame-time-
based timer instead of waiting indefinitely on TEMT, makes the
direction GPIO reliably return low right after each transmit
completes.

Scope the fix to ports that declare a GPIO-controlled direction line
(rts-gpios), rather than setting it unconditionally for every port
this driver registers: this is the class of hardware actually
affected (RTS state has to be explicitly un-stuck by software, unlike
a UART's native RTS pin), and it avoids adding the extra frame-time
margin to ports relying on the native RTS pin, which has not been
observed to need it.

Signed-off-by: Nicolas Thibert <nithibert@gmail.com>
Assisted-by: LLM (Claude Sonnet 5, Anthropic)
---
 drivers/tty/serial/8250/8250_of.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -156,6 +156,22 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	up->rs485_start_tx = serial8250_em485_start_tx;
 	up->rs485_stop_tx = serial8250_em485_stop_tx;

+	/*
+	 * This generic driver never enables a dedicated line-status
+	 * interrupt on TEMT, so for ports whose RS485 direction is
+	 * controlled via a GPIO (rts-gpios) rather than the native RTS
+	 * pin, __stop_tx() (8250_port.c) can see THRE without TEMT on the
+	 * last byte and bail out without ever retrying -- leaving the
+	 * direction GPIO stuck asserted after the last byte sent, on
+	 * hardware whose shift register doesn't reliably surface TEMT.
+	 * UART_CAP_NOTEMT makes it fall back to a frame-time-based timer
+	 * instead of waiting on that interrupt. Scoped to rts-gpios users
+	 * only, to avoid changing timing for ports relying on the native
+	 * RTS pin, which this has not been observed to affect.
+	 */
+	if (of_property_present(np, "rts-gpios"))
+		up->capabilities |= UART_CAP_NOTEMT;
+
 	switch (type) {
 	case PORT_RT2880:
 		ret = rt288x_setup(port);
