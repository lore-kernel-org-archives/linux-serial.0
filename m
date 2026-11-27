Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798565;
	b=H0BEA/Z9LjJ77saWoMCbij3aSCCxUgjIEuDYWvTaC1mdooiQHYtZQMa++OI+J2hfVIZb
	 h/eXmrJVBoZ4Ua4F0P48mwYnEyaiR/7kQI/uBqNYy/rZ4pFLx+zmRrNltQOLAhzM72UC2
	 UHFMdsKonPM0On63c1t7y4I3V/ErU0UC0JGwXRWoyr54YAftJsgTVekZvK4HRHWTnpyaO
	 AfE2l1LHnjt3OXSR4Xm7bn0ChFavLSw3pkYs62saFtZ+LfFHu8MG+AgVftzydgwTlK9c/
	 2+NfSbWTJOGmiDQCLhQ6kwB2f4h+VAdn9K8AwVuoMx9zBRAwiL0EpGtgSc4x5NF3Txw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=0Qk+C52F/WT5bFnsjK29OcxfCcFJJ39L41GGvCZ8GDo=;
	b=RFqXe8Kke2sRR+I7dqa4nfZExYXP5KEnzJz58kocopQNgmHiDYO6UmkS+KkTm5rQbLYx
	 qsEMAj0XReB7yokknH6XnGphZu6LNdKnTGHQeWzllsEQG9IZOXQ6VLHqR7o+/Mz8wRCtz
	 DpWl1uStfi3mj9DAxiCUwSQUyfVTDQupLIuzkqPpO71geVvguryH9PTEY3hoZL2PcchX5
	 3ils1okpLr5/uiE8mGRzCB5dLCvyrnQBinoJ/rwM6iUIIZJsvQYy+ckwsk2v6uMP3C+Sb
	 fVnTYL7JUdeaYFDtH5UG0LEenypQzixMusVPED54iGHUfL7TU2CbcqdtXIp80DC+S9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xGwcnrUE;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E42C606A31C
	for <linux-serial@vger.kernel.org>; Fri, 27 Nov 2026 16:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E42C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xGwcnrUE
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-498f5fa5103so4960153f8f.2
        for <linux-serial@vger.kernel.org>; Fri, 27 Nov 2026 08:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795798563; x=1796403363; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0Qk+C52F/WT5bFnsjK29OcxfCcFJJ39L41GGvCZ8GDo=;
        b=xGwcnrUEJ/10w1P6UTvd+F/kaA0m99r+z0R1VP/h27GYuaTse5oMi4+7UbZ6Y/ME8R
         Y+CxfwlUXcuV9ejnovUYrXTDMFAq3m+V6LxFvrRRQnKt+/SGCn9vn+3FNGq3o5L/ALMd
         legzBhFmqB8xsMEw1BX9R+jUKEfVZHQT9kWxngr5hkxvQQohyZA3ezdo5CDckuc+YLEa
         ECvBGTpDzezU17mw3SSZagMiQygW660XprOUnaAwFizKZSv+jJV4u97uPyKBHpWqMIzC
         4Y74cVah6iPJswBOGqkc9PhIMQWVMMvxINWgVrSnMFe4KovFkr0kIIQ0JPUU7WeCgi0N
         Ufdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795798563; x=1796403363;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Qk+C52F/WT5bFnsjK29OcxfCcFJJ39L41GGvCZ8GDo=;
        b=tw5zoBSRP5avwdtQmomzbVBWuaoeDFMG+w/H2X3BJC8qWPwbDHHxZTHaF1W+mhs/Sv
         XALiR+WU5db6Iti7Av5MTRGKTlxROdptYZSAB0qLjVCDvxWrVoKqmKZGAQ5ZyfKBJEN6
         U++Q8LlpoSAQgZ8Jx4wbcsEmWhiMb/uCoO4eR3IY5wu0XYGitTlFJ+JqjXqusQFEj5FU
         j6xxqBqjk1BbO4XxpRczqVSuOo31uINUi0EBHUpQbzIss6krUuG6OAToMTJVI94w6W9x
         zlcKy+VEky3NpuOd9yNXTr2T3p3DvHC3nrfUdodVF7L1KWcZnc7Sr+u3XyAQSAFn2DAV
         8QMQ==
X-Gm-Message-State: APuU4Z/lMIBKD9e+dblNgyySDJls6z4cSKyBv4U0vr2vVQwTUzPK/I3t
	VMhXHv55FYZo5sfJtR+1Vjxha1MOVkb97C/fPvrjo5CUuWxbwxBWejFe2wMN5qcr04I=
X-Gm-Gg: AZFdTZds/G5oqBISG/w4PHdQ0crnky/dvxPYkyEbUgVzFQS6vN6vT0624tspaJY7G39
	2Ar5TqXQog4yEQ+dMmFSeDlgaP6j1yTXaobCRGSedAm6im5QWgYiX5SY5IoKDQ6XkwyfjgtMN9K
	qMOhRPyVsSgicTT3BXYeI3ebbeV4QKWIp3RGEv7wJF3/UfGuXbbbvRXo5lEDsHqCmHiuRGzLj7U
	NzRN+qF+4a/9D2PmkvdGYwblySSPkbqO+lEQ9JR3gmfqjeDUFBx1eoXEIgBqztpSWPpzLkNvTI1
	lOZURoVa9ejEl0rNnLzw7EFrfzo2SAZGooWMFcJVA3sXiTEgoh5W2FkDIKvH1wtDVZB4K1zQHxn
	P2KGvPdR4I7XM148V+LpYZKsjQBegNBC7aD3Y8XhVGacNfb6vJAXiHLrTzjnTX2q49v97qsqp4O
	lttOeEzlB4AX7uSQlSmb1YqzqgCe9QU0Vcooq8OdqwL1EPZQIz+mXC1ng+phSgSHXSAfJNLKYM7
	CdO9kmn73eDbDtQbLinlij+Lo0Okd75GnTn1zMUIzllIGOeGCa7wsu44ORcooml3+PFWN3X9Sug
	U283qxuiTye+pZWyGkpvecpq44STg81IKnZbvCg+L1mA50x3g0LVlS9PqJpOe/0trJgz9UWyI9g
	iaGSXInikT5UG1sOEHaM7t9dXmTWk
X-Received: by 2002:a05:600c:a55:b0:4a1:992f:d0e7 with SMTP id 5b1f17b1804b1-4bb889234a7mr473209425e9.16.1795798563314;
        Fri, 27 Nov 2026 08:56:03 -0800 (PST)
Received: from localhost (bl20-90-91.dsl.telepac.pt. [2.81.90.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884865a2sm733858735e9.3.2026.11.27.08.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 08:56:03 -0800 (PST)
From: =?UTF-8?q?V=C3=ADtor=20Hugo=20Silva?= <vitorhg20080@gmail.com>
To: linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-riscv@lists.infradead.org,
	sashiko-reviews@lists.linux.dev,
	=?UTF-8?q?V=C3=ADtor=20Hugo=20Silva?= <vitorhg20080@gmail.com>
Subject: [PATCH RFC 1/4] serial: esp32: Validate the baud rate before programming the UART
Date: Fri, 27 Nov 2026 16:55:49 +0000
Message-ID: <20261127165552.133713-1-vitorhg20080@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125233020.1380594-11-vitorhg20080@gmail.com>
References: <20261125233020.1380594-11-vitorhg20080@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Early console setup can reach esp32_uart_set_baud() with no baud rate
or clock rate. Reject rates that cannot produce a valid divider
before dividing or writing the UART registers. Early console output
can continue with the firmware configuration in this case.

A mocked register test verified that a zero baud or clock rate leaves
the registers untouched.

Signed-off-by: Vítor Hugo Silva <vitorhg20080@gmail.com>
---
This series addresses five findings from the review of patch 10/19
and applies after patch 11/19 of the ESP32-P4 RFC.

 drivers/tty/serial/esp32_uart.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/esp32_uart.c b/drivers/tty/serial/esp32_uart.c
index 304e134..895d0ec 100644
--- a/drivers/tty/serial/esp32_uart.c
+++ b/drivers/tty/serial/esp32_uart.c
@@ -448,7 +448,12 @@ static void esp32_uart_shutdown(struct uart_port *port)
 static bool esp32_uart_set_baud(struct uart_port *port, u32 baud)
 {
 	u32 sclk = port->uartclk;
-	u32 div = sclk / baud;
+	u32 div;
+
+	if (!baud || baud > sclk)
+		return false;
+
+	div = sclk / baud;
 
 	if (port_variant(port)->has_clkconf) {
 		u32 sclk_div = div / port_variant(port)->clkdiv_mask;
