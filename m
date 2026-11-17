Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794945919;
	b=NwO6ybkHdXB+zVNGamuPZofpL5lPutiJd9Bwb8YiNmgC2CmhJYpbmj3RWoTCh3sB9BKS
	 ICF2VWrDq08J4QyuohUWdOg5t+hWd3bOW7FzC5s9bcXkq8dupE0pVfAQ3Y4xSOMiM7Hbk
	 gOctqcYsbpTRWEIMABJCaxElbw5GK4KbThyrdtv6VWSKzFLtpXIROcWzxEZcWHStrugmd
	 U5O9nQ+WduTODFN12fvM77DqlQlUkgqh6i11M/w+7jnTKXjAjd64HjOJ84KMSC4r8c4wu
	 XHXlBj9UnKV3SdeqEKn+aLJbl5BUXbwzbW+NtTN9UQeBS+pRDRC5bLTX7LtQlOhDYPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794945919;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UPJHLmwLZlatSt25hUeelYOc++vjVu9QgMh/X2VZQWE=;
	b=naYszAogCQxl57OkldDAuMSe1K6PFtEY65okey4fH8FEuROcWWjFUHR7H5rcV5KJ3r42
	 NKOWoWKicAmfpJ2ycChM72ZmtyJRMoBBZht7sHXbnJ6xzZrfuueOgsVaJm+/e6hZTlD2m
	 5yVoNArsYW2bajJ9BOEZVvDSC4XDgvlIYqqThLQ0WwBkV/E83v3I/cnBsF7fhqCwNLOTG
	 UZwQKeJMJxhRbBgYNYj6BZuQljwtIU7R2Q/Ey9SqPej45RXIiaylmpS53Sy/1Vg0Jpuhc
	 k+7Ok4XcWE83K1mVqe/vllaJgmZnJ8s9v6ca/CtskHLmm2dEHmwm2pbWU9aKMRUdI8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MhjW25tI;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ECB606BDD0
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 20:05:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6ECB606BDD0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MhjW25tI
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so87979f8f.3
        for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 12:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794945917; x=1795550717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UPJHLmwLZlatSt25hUeelYOc++vjVu9QgMh/X2VZQWE=;
        b=MhjW25tIfRYDFt6msKWXKEZvsJV6FE5BXzi3zLiQABXwwGUAb5mjJJggmlAam4lj3b
         vhPPsArgE4/SYAa+JMmZDpvUr0om/K7XKG8DCsfpZyelmr+S485w1DRAzID/YEqZb3EY
         X7wb4bvJ2dFOfgMqvjavHoFFFYpW0wmrtm02fCdi8AOWM98wqAdRKgVgQLdTzJDL9H/O
         z/H3LFCPflALGVzOGNyE1TDhtcN0oOX/qVni+8nM3ne1xcUh3JxY1QDDMoWLAH6eHpIy
         mDCS2tIKmDeeGidOh7Nb10Y3iVTXYhq2Yg5yb1m4ZCuxEWn22XO8ELQS1Undomc/aKEh
         DOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794945917; x=1795550717;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UPJHLmwLZlatSt25hUeelYOc++vjVu9QgMh/X2VZQWE=;
        b=2SAGqX2vSGn+L52jA/2l+5jPNc71o+uMWS08BoJdj+aiAKu+w8fZ1LPNPdSQgtZd7m
         bUvRhyuEHfLuGlZ/QUzMzmBq4MOYCvYbkiIwh7wtgzV+OZJJFOJ7tc77o6y/X4TCfMod
         bnUDN11SPCPgzdJxJhW8xIBbcrla2ktSpoD3ibECQEFyp6UvE91yxIBVrqMOcs7CkK6+
         Pw+Hw4qbCmy+CmWtzODXt+pXV1F1vTGERfKFHyoFeWa9zYLh6Z4aMLHxDqCVcqZ33Daa
         hRoDK/7YzaJWRQiXUEit9GnTpx+EH5DstjPIj+mxU9OCnYb3HZTNeWNY1yUBlMorrSUs
         q4wA==
X-Forwarded-Encrypted: i=1; AL+hErGhnDU6FzZdrQ1I7Z93ePJFL9tzrTFV7dZ/0rfA2C2a96RAYidNzIQJFmnCisfArlx0jx8pAifTmZK7qVw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+XVFwh+o87mB+SDYD0wTT8/HUNtYUFHX2Dfa4rfopeLudkjZe
	RJouIdCFr/XuGux587wEtO9u6HXudFBlgfZfhfRzhyowrcmduZqIrrDo
X-Gm-Gg: AZFdTZe/Di+xrKXHr56Fu6xR3YnMKRWfPWBi9yJRb2vKoGslOyBABRyVmm+CxhewXBw
	oSidim7R8wjtPfyyNmlpXTkD3/APUz8P4g6D+djRsZllI9BrbA0MvoO/6Cx8K9Lk/o3ccgZ+lyg
	9J6K2FIWbCt23wXDYu131tmvoWInCP6nmw8Me9rRCNIAPoOLbPwAii4Pm+ed5hxZduos1lq46Ds
	vcXjFS+6XC8jEGdpVKpjESdUpPf054rN+NG/Xnt9Pl0K4YfR7aoEjnyiOH/oWMse/xbYg9/gb3i
	Y6QFOWU4TaUSlIK5vM+i1H6Z3G1by/FlIgzuBIhb/9hjQC2tWjTZgEhRp+eV8Z896nQb4vhULua
	S1lwtIBZAuUiSULXxj6YxV+BlDpuoA8BJcFZkFodEBbcx0w77bMuyY7yIL+vlUNUY7oGvIKcXGn
	Ed/lOMFMebn4CuOq1nPqhUSDaUsnBh2M+BKN3UGjSs8jauya9yuXyf2B/o5o7KqLhu+D737pxcP
	eEpI+1UGFfK87Pf1O3mm4zhdNjgKnp4PqckmYeaiEua2g554SZ5OMtBkR81EvcWXimVFWhOvBlV
	o3nakyhkSFtgZimGGhmCp/EWNlRz
X-Received: by 2002:adf:e002:0:20b0:4a1:a2ed:bc1d with SMTP id ffacd0b85a97d-4a63b6fbe61mr885459f8f.43.1794945917177;
        Tue, 17 Nov 2026 12:05:17 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4a64b60940csm625528f8f.0.2026.11.17.12.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 12:05:16 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Raman Varabets <kernel-linux-20260610-80b7ab08@raman.v1.sg>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Christina Quast <contact@christina-quast.de>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH v4 07/16] HID: ft260: uart: enable flow control
Date: Tue, 17 Nov 2026 22:04:13 +0200
Message-ID: <20261117200423.19561-8-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117200423.19561-1-michael.zaidman@gmail.com>
References: <20261117200423.19561-1-michael.zaidman@gmail.com>
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

The FT260 is a full-speed USB device. Interrupt transfers poll at 1 ms
with a 64-byte max packet size, so the theoretical UART payload ceiling
is about 60 kB/s (~600 kbaud in 8N1). The chip advertises baud rates
above 1M and small transfers can work there, but large transfers are not
reliable above 460800 baud without flow control.

Stop forcing FT260_UART_CFG_FLOW_CTRL_NONE after termios setup. Honor
CRTSCTS (RTS/CTS) and IXON/IXOFF (XON/XOFF) when configuring the UART.

Tested at 1500000 baud both directions against an FT2232H with XON/XOFF
and with RTS/CTS (~2.9 MB transfers, no data corruption).

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
---
 drivers/hid/hid-ft260.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index f722ef0ddf06..21789e97fd18 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1945,8 +1945,12 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 
 	if (termios->c_cflag & CRTSCTS)
 		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_RTS_CTS;
+	else if (termios->c_iflag & (IXON | IXOFF))
+		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_XON_XOFF;
 	else
-		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_OFF;
+		req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_NONE;
+
+	req.breaking = FT260_UART_CFG_BREAKING_NO;
 
 	ft260_dbg("configured termios: flow control: %d, baudrate: %d, ",
 		  req.flow_ctrl, baud);
@@ -1954,9 +1958,6 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 		  req.data_bit, req.parity,
 		  req.stop_bit, req.breaking);
 
-	req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_NONE;
-	req.breaking = FT260_UART_CFG_BREAKING_NO;
-
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
 	if (ret < 0)
 		hid_err(hdev, "failed to change termios: %d\n", ret);
-- 
2.43.0

