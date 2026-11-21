Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795288930;
	b=AWoFZSd/tDsPLsuv1oGdBaub+aXmU024W5GX31gavpdF0U9B2laq9teipQRVr55d5KIR
	 cBvO7jb7Wyjia9+/k2ipUVWyrokw0rzr89x2EDPO9KvGib9SdZB7/+Ua+GLNX964M92l7
	 cDk/XGrSATlPgHI+v94cvZT3crRG6QtQtzuJmrU5uPGWXdmSa0wwUfdu/IhwKaE53U90+
	 Exp5YO6fR+tL+7IPfvhVYx4aoqvqUGyCZNIuJDz7MDffvWESlAsURgkAUkTs/PAjNqgTW
	 xbsV5B09HU4bIEvn1onXdOIRxEUohdVdDAy1xIfRo6nzaENP46LbtvzUXk4YPA61oMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8aU0P4VqfqrMe/fjnlmGNnb/Fa/CsutnDC2e4seIbEs=;
	b=fx4eFtrYOCgKjcvv5EYIRwt+Ud7O25D0KL/LH1c5fO9eu8pWbYTGuVqJJrepeJS7ukSJ
	 ht7hdZhqdTHk6AVwJ0+hb7yg00KhWlbIflfCp6tN6XvIXabP8Dc63Zxdi1SHUNRxO6DPI
	 osTroGNGRc/LaE+RstZoe2R5rU733qzO+WZ9wBT4TWOcoMnPzWWwI+GyU6jmNzgk9+zui
	 dpxbhfM3Biz7mWScs8MRgJ997Za0fSiSuS1uYCR48vSMJH44UUjjDA40NOlVH7iyLLTzc
	 aAYxD1jBf9JW790IQ2kdgUxsE0wyekRzj8ubm6DKBwz2yCZQmMmCFlrl+utU5p/sDCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cFmhlEpj;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9084606A331
	for <linux-serial@vger.kernel.org>; Sat, 21 Nov 2026 19:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9084606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cFmhlEpj
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so23362815e9.1
        for <linux-serial@vger.kernel.org>; Sat, 21 Nov 2026 11:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795288928; x=1795893728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8aU0P4VqfqrMe/fjnlmGNnb/Fa/CsutnDC2e4seIbEs=;
        b=cFmhlEpjichdD5zcqPxkfjvyzXHT+7r4rHt6uWycqHgYc/JS8IxnzVQJuU9w9gdGrp
         oBI7+8x7xexd946jZ/Y7Br3CnwmBCX+CX4TsSPRaprX/AFDBWNw0dYd46yr+MwIHRQJ7
         Z5R/JwlKSJl6YnWCmQUBp+wW6bwdjdzqbquDeQS9EKHHkTPXPFD6NC4k4lvL3yVmJjjT
         OLCl4OnxfnwiD4T8dcSzuDOebWSVh7/5VQHnZ0X2JWyiZSU88A9vVrBgrrFmuspLXSkh
         BQKTo3bsturdbEg0DlfPez5q6/QBVEt3bwFwaVKm3XUlrzWFlhhniL2hWTtX0nOlKzSq
         JK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795288928; x=1795893728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8aU0P4VqfqrMe/fjnlmGNnb/Fa/CsutnDC2e4seIbEs=;
        b=qyH/Jyr49N6EFGvMqJKTh5Gtvkaindls2X6bd+4BMIbeKlhq4FUMZV1FOgcYo8ZiWc
         viKqsfwjBpvUn1h6XLTFOd9wYQgL8DPBgWVaev9DPJNYfLaULRPQ8tu2EL3xiPhtlT2J
         naITopGZDgcD2l+lu20jGWP1g9MZ/PkkGJx6WUIfp0Zmp5FaX5c5zP9up96yUOdtn2Hz
         4zTFiSa8j06qQUSbYmSwVjGMyI7RQJmzAo0PT1Q9U/9vhyEh+U4LHviRW6pQHBUlJYz2
         G89pLlhe8r4f9th3EKG44TPGN2++IxQG/NWvsMGjkF6mtu0dRNub2ANZr1vXrJ63eRzg
         zWvQ==
X-Forwarded-Encrypted: i=1; AL+hErE1B4IWE/kN4vS7LvSxTZOTPJHFt40k1/6V8SJA/tvpeMIItm4tel33VHuZZhBmr+pnLuxubpPaanbwKM0=@vger.kernel.org
X-Gm-Message-State: APuU4Z9s5EmLCjyPNcHKY+eoRr1/lgvim33xB/ANF4Fn6FOPwCe7bekT
	cHRolE6BatXnx2IxeyA45iW6Ze6yQTfN21Tg0JMPcvbiGuL7RQwXxs7y
X-Gm-Gg: AZFdTZcvAHCNZu/9SAvGAkzSumPc795bEDZ6aZrGZg8q37uYB79f7hibxDXEgG47gaB
	lupC5vExqeROnz1UIM5oEsckiiTLPFz22xN8S5zRTzDWrHAZDrjuwIqrb6tK+7QhVip03h4PdWb
	+wOgqbzEDP9cma2aMVuwmtVAfcd3Rqdsg5qzC+ENCU583XbmdYG6gT71HoyGqhh5CkswSjfW8hQ
	W954wweSNexUhY/l5Sw+X2nFvf81bc2SE0Uopn63PEVlJBYYeb8QpRuTC4Vy6GMNhhNj7ZTenlm
	IfKD5wzo0mnyryYRJT1eFTkpxhnFzBzQKUJGROWBQLjs0l3lOv2czNYzL8JRfI4mdf80QtddcqQ
	caX7y+rv0ED2cJVZpqPtwJTxi7W4J03koB0SzOt754ezBC9Hv56nSbgweb0+XjLAaENaSxFft8P
	uOWdfGOEf5q5NQbydNK7AGqW95GohwiH1fODNCES3tdQPTefmR45PFTdrOzToEXz2T+FpAM95Yo
	4jw2LxBR1G7O5K60b6WLMI6sOQWb4wT7AuiSX37qYvLN7RA3BwlSrVtj0bM7fHBQ0URd/yA/6i8
	mCpmeYYzkBfZlwr5lFGMRIrHrlo1Kt1OS7fTJtb156E8yKhzWoR0yIIMqKMWC0pAqw==
X-Received: by 2002:a05:600c:828e:b0:4a2:526b:d40f with SMTP id 5b1f17b1804b1-4bb88785898mr160908755e9.0.1795288927966;
        Sat, 21 Nov 2026 11:22:07 -0800 (PST)
Received: from fedora.jkuat.ac.ke ([41.204.187.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906e4ce6sm67560085e9.4.2026.11.21.11.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 11:22:07 -0800 (PST)
From: Bramuel Barack <bramwelbarack89@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	linux-serial@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bramuel Barack <bramwelbarack89@gmail.com>
Subject: [PATCH] tty: serial: samsung_tty: fix -Wformat-overflow warnings for clk_name
Date: Sat, 21 Nov 2026 22:21:58 +0300
Message-ID: <20261121192158.44872-1-bramwelbarack89@gmail.com>
X-Mailer: git-send-email 2.56.1
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

MAX_CLK_NAME_LENGTH is currently 15, which only leaves room for a
single-digit index after the 13-character "clk_uart_baud" prefix and
terminating NUL byte. Because the clock indices (cnt, clk_num, clk_sel)
are u8 values (0-255), building with W=1 triggers -Werror=format-overflow
warnings at the sprintf() call sites.

Increase MAX_CLK_NAME_LENGTH to 17 to accommodate the full u8 range and
replace the three sprintf() calls with snprintf().

Signed-off-by: Bramuel Barack <bramwelbarack89@gmail.com>
---
 drivers/tty/serial/samsung_tty.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 640f85e2d636..40a21e6825b8 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1336,7 +1336,7 @@ static void s3c24xx_serial_pm(struct uart_port *port, unsigned int level,
  *
  */
 
-#define MAX_CLK_NAME_LENGTH 15
+#define MAX_CLK_NAME_LENGTH 17
 
 static inline u8 s3c24xx_serial_getsource(struct uart_port *port)
 {
@@ -1386,7 +1386,7 @@ static unsigned int s3c24xx_serial_getclk(struct s3c24xx_uart_port *ourport,
 			!(ourport->cfg->clk_sel & (1 << cnt)))
 			continue;
 
-		sprintf(clkname, "clk_uart_baud%d", cnt);
+		snprintf(clkname, sizeof(clkname), "clk_uart_baud%u", cnt);
 		clk = clk_get(ourport->port.dev, clkname);
 		if (IS_ERR(clk))
 			continue;
@@ -1778,7 +1778,7 @@ static int s3c24xx_serial_enable_baudclk(struct s3c24xx_uart_port *ourport)
 		if (!(clk_sel & (1 << clk_num)))
 			continue;
 
-		sprintf(clk_name, "clk_uart_baud%d", clk_num);
+		snprintf(clk_name, sizeof(clk_name), "clk_uart_baud%u", clk_num);
 		clk = clk_get(dev, clk_name);
 		if (IS_ERR(clk))
 			continue;
@@ -2326,7 +2326,7 @@ s3c24xx_serial_get_options(struct uart_port *port, int *baud,
 		/* now calculate the baud rate */
 
 		clk_sel = s3c24xx_serial_getsource(port);
-		sprintf(clk_name, "clk_uart_baud%d", clk_sel);
+		snprintf(clk_name, sizeof(clk_name), "clk_uart_baud%u", clk_sel);
 
 		clk = clk_get(port->dev, clk_name);
 		if (!IS_ERR(clk))
-- 
2.56.1

