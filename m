Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794697722;
	b=Pbj9xdx/IjC5RNwMy1vuTd+lu60+6cYJ92WCgPSLT1JLILuyBzj30CDnq7kLwMp6EFLR
	 6uvDgTXnXctNTe1A3zere7KcR1aAmax898h7N+nY3cCRSoZKCnrMfhL3f+/dOGlbOvJu+
	 3fNWyv5h0QOSNTTJXaX22KuesSvyvJgJXNY3NnOkaD70mhywtfSqngZqSdU900hb0WvOv
	 obcPp7K7B4LUoVqXtffGdAX+4scCWvNgeUejhxuvcqGIF+by2Yp9604LoAtsfNmJBRz1f
	 rZCl8Q3vwKZv1PEDNADcP0239TTmONvlL4kjgxW++0aGgFKjzbKp1WgJKzdEUCnr4Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794697722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OWq1ZPhXVsQ8TnLGQfYbZB9MhFN53DcQmkdOU8DAzLM=;
	b=ICQ5T9ahsV1EYed0e/+Ex7v5Gee7caqI6CdAbnaGXZEugTVDFq/7Sk4KONl1Ckt0MKiS
	 Q3teKNTYhYKXMYQ6rS3xlsmtze+DjgnTAYBD+8h1PLmP037mIDlG6jcN1ErtgJIt+F3iR
	 FJIHwtfySNkhdCXdkOIQT6GqpIb+do2bYWuC1rtV5udg5x4HAu/FZ61LEKMYSrRUXCduw
	 6yt+Gmp1Ku02xDV33GIXCTzRmbYLW9cb6yGEVkdafslt4lufrODv9H4YcSMcpjHZ8oY+/
	 BRzSce6PnGDMsbk6TMf7JuJ2LsNyaIZMGwmwOkKf933cDfUXRG4Gsz59GcAK9FblSgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j2x4AYJG;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3149360A380F
	for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 23:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3149360A380F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j2x4AYJG
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48fd2e38825so1318350f8f.2
        for <linux-serial@vger.kernel.org>; Sat, 14 Nov 2026 15:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794697721; x=1795302521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OWq1ZPhXVsQ8TnLGQfYbZB9MhFN53DcQmkdOU8DAzLM=;
        b=j2x4AYJG6n6Db9GW977oMzXHN7UsiOwbhnKGYzeeISR1q9eapPvmbYFZYhSzsWSPuW
         p1CKAdFyMmXR+i3GSjxLKah+pfHWNHAS9AVTE4YwlG6Micg5x5ZVyN4gbg6Kp3PAKKZv
         RzkhOdlAZm/ViIGOuyuRIBKJtuqDkTeiNG3UOPwme14HPlkPi8XkATuf/Jg+Vp/9lui8
         As6cgonNIYPmg7jk291hVSLs53wjow5UAgAsiCtE0R3w9ZrzBQOfV2D3ODiru6nL92AI
         9+bfz8dH04ZlrE6UNSmasbmJTfoPeWfRVD89xFcz/X9xZc5CAtzZQIX+mGVLKmCGu6uJ
         qXww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794697721; x=1795302521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OWq1ZPhXVsQ8TnLGQfYbZB9MhFN53DcQmkdOU8DAzLM=;
        b=kUarG6PcUbwtYFK9j2UKQkCPAUPYwm5ENePTYO/OvcWQMZ2U5NdigtNir0dHqfNeA2
         B4QLrJj1tGt4Bgk1fCUCqeMCNZXsEDeB2m9X/p/99Zb2xMkVPYDS8vBwrfu+X5rZcmJQ
         7fc9hhm4dhZxQJokjiwRmJAmmYEs1hCu/Wujyjf2bwlXKA9P3LkwUl8vftCK591TXVse
         8Bxrbgw2WPddxECRR15TIFK3918aRcvpLTHa8AVBj65i8IanuMPBZWcNNa+DEr/gipdJ
         GF76MGG09Bvy99sfY+3Ym2rANOMVaDpBRdX2cNRBiHZUBH6R4DdWRm/2ZblglXt8/de3
         6H0A==
X-Forwarded-Encrypted: i=1; AL+hErExIi6capFt5aseRs3B/tMZ+7pcqLMwDPU4ZaFf4MJu06ENlzCxPCQefjvc82mUxpt47ys8n3XpUxVV1S8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9GlIP8G5Q2NKUU6i5jqVhcd4lfT6TlW0QG4KYUS6u7sCK+uw2D
	uuAiE+zzNYN6VTX51pcJ9dGBJ07yhwuIzOL3v2SAc4stQMb+gG+xOV85
X-Gm-Gg: AYBFou2HScs4RJvqLNlnIfLxo68BQhAqIR/+nFYp+Sn9gUs6sH1fEo2eeLC1yg2MV6Q
	+wfoYp1K9zHr1r9i6IAs0BpVqRB4AJ/QUq3Rd6e/LWYo42mwFXkNgaDdrlPCUeYZqgaVxQnqM1D
	YmsyLhHJN8Zj9gktqbIdVEa9cEC04f7Z3INfERlAeksCTq1sB5oMWVLEhbwrG5tWyQK+OGzLeO7
	xKgDWuo/r4t6wwiL48oW+HgFqkCjgYPH3EXfd9GhwOuB8Co7SLiGdI//JkB2Mp3zqAppl2vGPxQ
	HbNpW4bzwYSMqnlPg0zOtaWmoHgEMLvA7J0bC3aZXdNrvFUbdQlvbD0VMIi6RiB8WVlRUl0mvvc
	RrYZlb4qpRYlhzh+BIXZtxrqIJyOxMVaJs+W5tt+SLuvQRihWwe54aHH27LgaWObW+BzSy1VTlo
	zSfc3UZgcNwF2a7TBI9cKKl9lSwxZyzvfJWo2jFbCG7rDVmlfj5eSDCqXMDaWgItNb8lAllrkh1
	LC1ZoWZApSey0vr6EQou202zFeWdlMGgTtVvKF9+mQkFK2I/597z2ES/POE3BuJVNsmf/7W8/q7
	mU1NM5HGaOBm/mAWx+m0H4PKkTvK
X-Received: by 2002:a05:6000:2586:b0:48e:2f7e:bdbb with SMTP id ffacd0b85a97d-49c72c9c8b4mr15192826f8f.50.1794697720582;
        Sat, 14 Nov 2026 15:08:40 -0800 (PST)
Received: from m2.. ([37.142.149.161])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49c5d03b10fsm14910018f8f.1.2026.11.14.15.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 15:08:40 -0800 (PST)
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
Subject: [PATCH v3 07/16] HID: ft260: uart: enable flow control
Date: Sun, 15 Nov 2026 01:07:51 +0200
Message-ID: <20261114230800.1344401-8-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114230800.1344401-1-michael.zaidman@gmail.com>
References: <20261114230800.1344401-1-michael.zaidman@gmail.com>
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
index 270481766e2c..75ba68e2e8fc 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -1903,8 +1903,12 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 
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
@@ -1912,9 +1916,6 @@ static int ft260_uart_change_speed(struct ft260_device *port,
 		  req.data_bit, req.parity,
 		  req.stop_bit, req.breaking);
 
-	req.flow_ctrl = FT260_UART_CFG_FLOW_CTRL_NONE;
-	req.breaking = FT260_UART_CFG_BREAKING_NO;
-
 	mutex_lock(&port->lock);
 
 	ret = ft260_hid_feature_report_set(hdev, (u8 *)&req, sizeof(req));
-- 
2.43.0

