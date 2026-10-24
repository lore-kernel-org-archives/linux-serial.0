Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792879638;
	b=MNm3NgNKyNT4RJGJHnq858vDP64WDdzoSIggeqKmJMT9jR86wTUX23IzkARkS3SKAAMd
	 NXl7QglWJQCNDOq6vypsB8VPPY6r1D4mwz+SveD4qSfWOyoF+0iruc9INu9bsTnx+g7N3
	 ikXxEoCpTR97rkEU6hTLfgut/RIZXQvcfVL3rmCLLMCFgYyQoYnPMaYhQnfdxAalh7GjK
	 j6qaUOwg55NVktkCxAzR4Y0ZyqyeN10WwactB3wqD5uc44SBRDVpYGuz2ErmO29v8bfak
	 2qy/zSfWEYksVq8glbF3b7xvrc7jFXQw+XjNGLbyGHDVZypbKZuZjC9KH77w5q+6vGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792879638;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=xpsIF/cfagR2zVFmuilPnUkqxjm9mv7XoS2i7FolaHE=;
	b=JRd6hJ/JG6Xc5+nQCGnms1dLJbgO1Ho//6McNLKTnUbNWTiNXu+Izl0e8X2m/8LuhKEn
	 9RfbPUiQh9CQCh+c16ju7DNQRdOXLtrahQaFeDJKHSe1dkxZ0LluSDFdFCpSZxMbgAHkZ
	 GSQAok6eysqfkQQnMTB2KBwvS3Xcd551eaW78c+1mRNwLbjdX10ZdQzojd4Mzn/2bbrfs
	 /lRhYCfhe5+eEkiLCW04qL1X8GT/bH3P/qpR3CKhdougPxJ+AyKF1Ssp81y1CySeN+nM3
	 BWWGVg6Soo1zfGUZHZRkQmgw22pg9HBF/LChyClYaoC5LNELLO1R9MR/wQtolGBNQ4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=mgcrea.io;
	spf=pass smtp.mailfrom=mg-crea.com;
	dkim=pass header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=bMCFuXIW;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4CA606A329
	for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 22:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B4CA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=mgcrea.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mg-crea.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=bMCFuXIW
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso19291665e9.3
        for <linux-serial@vger.kernel.org>; Sat, 24 Oct 2026 15:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792879637; x=1793484437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xpsIF/cfagR2zVFmuilPnUkqxjm9mv7XoS2i7FolaHE=;
        b=bMCFuXIW8WSLFTdO69RsRRj1TOG56FNvXFJDyPKPQCXvpDcbUqzwN5B7XZLTqwR0pQ
         LhxaNIdIIsCo3fSitwA8UGcYqaF7HYfb7Kkc+I1OmOSlxW6jWJ9w9XVrRiL+01JuXA3/
         SXcVpcXnls1i1R9b2RAcyjuJlJLZu4LxZeGfGd+xTn5rFEpta2FDYcwDKnulNcKrFhBW
         53G5GOCh+TkA+UuSB9NdHoHiHQjTGPsxx/c78Vl9NXwkMjLg0hVdnpRVi3zepykbMAT7
         aZapMts7o0kFqf8YmGfj2XBPq5mqc4eVwFL5aw7pcY8u72ghz0nKfBsejE3tkjA/fMnE
         SpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792879637; x=1793484437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xpsIF/cfagR2zVFmuilPnUkqxjm9mv7XoS2i7FolaHE=;
        b=YRljezKKp2qAMt5hphZRrFBT/Wo9QY+0+LTr+JZuztBtULZos/jr/z8QIkbmsCqUFo
         hv21TR3XIW3EDrILjxtE8Z96LDTMk0E7V9M1Gg4/5dcmtI4cd2oT31KfnTLj9uIEX5R6
         a9uLEDMtOUZ/AgpAJNMCQEslyt58UYRfGhuIF6+yhN4MtutZK62fta0jfaRzb0GAZVKy
         EYyqroHrxKnXeEgbFNLVmCQ1771wYXPW6ggTLgyF88N5s+ippO2CFofXTGClYwKEGLqf
         7Aknt4eOyA+HP8QyLWLy6GbqTUnTfJs4iW78Laj7RPLR4kqTOssANrx4M/BSZBQ16cca
         ongg==
X-Forwarded-Encrypted: i=1; AKwUvBy1ZnsZ3cR2dHN/VaKE+7zpHOshNH3rHVpsMcIxluq4bo5B2rXCNSJnaCsz4CMSbGtS+dFgBlf8JlTAdwU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKOgsrFDkxAlHkHPRCLW95FfqhyGHwUbpqNi8T0gnPv99LbQju7
	xlCEfnWixUY6jpM/V0B+hCP2cwMsSFBnd5ApGs5mgi+AywtfjfSZAVm8kqhd9TYWwJY=
X-Gm-Gg: AYBFou3poTEqmki0bu0/DXR4lLzod8S9jXofB+otDWhc+eMyejlPbYwopkTLnO2w0BT
	0p3oyEddvasvl6EwaymW7iKejBd3v+2b7v36/4PHeo2coJZqSbONdyF5MMzeH93TqtrewHaGVaU
	zw+WIL3f9kb0GLKlE/kdcuRUNIieaWIuYhfDXbEUGOjZ3HFM3msRIYAch9HlUHutI/nZYwR2+gf
	wvUhdbus23DvLsfZ5n2D6aZGx5PRSl4iFVPiOHixkqO4JwT1B2ddMnR385Kp703advO7EyRE0Wn
	PkSEOjUXLFY6XVMiTNcignEsg9BmeVLv8gUFu9MqcoTq/4W/qNDKrt2sAmux/ypi5VDEsC0uyLj
	bqVY/S8exkxhyJIDiL4ZOqihQViTp8DyJ97+yhHqTHXpPkd9ls6hVXdUdamDR8t5jdKb6k/TY3N
	DoL/HUixSPUejnkh4OdbPrTIIk1yr3BhuBpnxMGYTl4dxt/83wYrddvTdwfyvihyAJRvDqA52/l
	xUmR6HFSYxOR1Ns+GU01QNLVrcMUGjUNE/7XuLhfY65lQ0ou+L0Ni3zdChLMaAeSG3XbvoGr+yv
	2o53S5NBGK3DcZmvUjNz654wAyC1ZSDRUigdAV3l4RpgyHWxtZC1WzbqHCgHY/ivt/19
X-Received: by 2002:a05:600c:6212:b0:4a1:742e:3 with SMTP id 5b1f17b1804b1-4a35acdd912mr42496565e9.27.1792879635966;
        Sat, 24 Oct 2026 15:07:15 -0700 (PDT)
Received: from localhost.localdomain (2a01cb060184ad00bcfbae5efa3e0f0b.ipv6.abo.wanadoo.fr. [2a01:cb06:184:ad00:bcfb:ae5e:fa3e:f0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a06da5fsm53466635e9.3.2026.10.24.15.07.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 24 Oct 2026 15:07:15 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Paul Cercueil <paul@crapouillou.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH v2 2/2] serial: 8250_ingenic: Set UMR and UACR at probe
Date: Sun, 25 Oct 2026 00:07:12 +0200
Message-ID: <20261024220712.23250-3-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261024220712.23250-1-olivier@mgcrea.io>
References: <20261024220712.23250-1-olivier@mgcrea.io>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ingenic UARTs have two registers beyond the 16550's: UMR, the number of
clocks a bit takes, and UACR, which adds one clock to chosen bits of a
frame, for fractional baud rates. The JZ4725, JZ4740, JZ4755, JZ4760,
X1000, X1830, X2000 and X1600 programming manuals all have them at 0x24
and 0x28. The divisor the 8250 core computes assumes 16 clocks a bit and
none added.

The driver never writes them, so a UART keeps whatever was there before.
On a HiBy R1 (X1600) the vendor boot loader sets UMR to 8 on its console
UART, and the vendor kernel had left 8 on UART0, which carries the
Bluetooth chip: every rate came out doubled, and the chip never answered
("command 0xfc18 tx timeout" from hci_bcm). Their reset value, 0, which
the X1000 and X1600 manuals call normal mode, does not work on the X1600
either: with UMR at 0 the same command times out.

Set UMR to 16 and UACR to 0 at probe.

Tested on a HiBy R1: with UMR at 0 or 8 the BCM43430A1 on UART0 fails to
set up; with this patch it comes up at 1.5 Mbaud and streams A2DP audio.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
 drivers/tty/serial/8250/8250_ingenic.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 0cdadacd7019..ca45e74b999b 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -40,6 +40,10 @@ static const struct of_device_id of_match[];
 #define UART_MCR_MDCE	BIT(7)
 #define UART_MCR_FCM	BIT(6)
 
+/* Clocks a bit, and an extra clock for chosen bits */
+#define UART_UMR	9
+#define UART_UACR	10
+
 static struct earlycon_device *early_device;
 
 static uint8_t early_in(struct uart_port *port, int offset)
@@ -298,6 +302,14 @@ static int ingenic_uart_probe(struct platform_device *pdev)
 	}
 	uart.port.uartclk = clk_get_rate(data->clk_baud);
 
+	/*
+	 * The 8250 core's divisor assumes 16 clocks a bit. Whatever ran before
+	 * may have left another count, and on the X1600 even the reset value,
+	 * 0, does not give 16.
+	 */
+	writel(16, uart.port.membase + (UART_UMR << uart.port.regshift));
+	writel(0, uart.port.membase + (UART_UACR << uart.port.regshift));
+
 	data->uport = serial8250_register_8250_port(&uart);
 	if (IS_ERR(data->uport)) {
 		err = PTR_ERR(data->uport);
-- 
2.39.5

