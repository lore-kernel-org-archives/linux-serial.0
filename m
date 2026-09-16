Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE674B0C97
	for <linux-serial@vger.kernel.org>; Wed, 16 Sep 2026 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552560; cv=none; b=hCeuEy1sRKSiSVYojTYEOzTxW3a9qnIDqOEgCpqqia0FEeY+asLdCIxGJjf1zl4mWkJz0VfWVcm0vgab9hKLo2gb9ZLKrOnpUH3HEiUs/kslfkFdXxejxIHKomfRYsFagfRqAlWSI6D3WCj2oUPtDsLD+rzmkKZV7c306GNIY8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552560; c=relaxed/simple;
	bh=Ibuya1/5DmSmqoKlhsPRcIYyCcZGsIV179wXU76CmKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=or7LNekukptHoLZzTscNaoD6rNIK6hAm9xAdKfrY0bzA+gfxA4ImNhKgvVQ4UOdNG0vpxsRMPkuXxtIrLQny1YO92g+ZRBjVYJD9IudBOw7o0q7OwDJIuvv7w1Yy20fLZh9zAWdWQvaGjyeAJserJgH1WcTQT4e7UZcbyYkkTF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiIlfS32; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiIlfS32"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d747ec6188so5214245ad.3
        for <linux-serial@vger.kernel.org>; Wed, 16 Sep 2026 02:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789552544; x=1790157344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gM03x/VUgDVaA/mIuaecDaV1OsFU+CmKDOqe3ZKytIg=;
        b=ZiIlfS32Gx9EkppvNOp5k3pWL3Ui1Q6tuTzd9bFazkp+qQgzVbeVyT1KSHF03z0XAu
         hgGOfxPo4tHDs8E0pvx7h2OLM+vHXyVEB22VUV7uIlkI87Vc/xkO/HXE0T0bQcCiRec2
         p99lqtpdfs3NHZu67J59+iiSI1d+YIaTuB/pIHB8zPBLsTlzIlO3/AItDnq43YLRcZM4
         i1CgRa5jmXrHGQgL6vxNVXxbdgu2OLYd8KSucZnI4lJF+ek9OcZtVHep4AzMSAUzaf3m
         1TP5pTIwP/oaGRxuXzvpw792KapETyY39+MDQgS2rC0TtuLplCATBDqS4u8GfCbnhkZ8
         49QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789552544; x=1790157344;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gM03x/VUgDVaA/mIuaecDaV1OsFU+CmKDOqe3ZKytIg=;
        b=Zkq0XgWF4hbTboPO2fCqXAFakwLBHiroqMPr2hyfilqRMGhO5PqApPuuMywGegi4yJ
         Vq39pSIy1LOPKaReB5HaAHGUvZZWMXIlZtoWY3yEOUC5+INiid/9d9CgDU4E1tNpXFhC
         9RDbgBD5+O6WdIw/8QCabc4u1i0hEXANqFUbvQ2Hw8tvh37V9QuYWi9NfQ7z5K7r47zt
         XsPZXmEICD9Va2mcYahLyas7VtAuc2839Mo68TQ98u8iSzxp57YkoRWBj1IDnovGugjX
         IUQT1GI6yu77cfU2dCVJv/vXOb9nKm1UO6KepRHfbHUsH+AE/5BWYGfd/WLAlyskkMk3
         a94g==
X-Forwarded-Encrypted: i=1; AKwUvBwXo49/gJyJnMt3i3z16YXzsu01IevCq+Td3fsUuDtkZzJ+orwMjD+knNq/NQyN0LcxlJoas3qF/zBI1PI=@vger.kernel.org
X-Gm-Message-State: AFuF++m2p0e9aWS6FFQiKTd9A2Kw3q+FtnGE8TAuPrLISvI5WhUhXXzb
	HLD1xzDLbNEUpYSuTN8AzZ4JzoFiTGruTmzVIQq2TvCdwdS6gTIGQpoE
X-Gm-Gg: AYBFou2F9Ex+e3gCSo49o26wondZizu435ghpJVNyEGCk4MWNyT3p155F8b5OWv1QDj
	6ho9yZGGHbD5ADuxlkB81LnhI9DgIlG2hDKPj0CggsFT6wbCVPe35HTuBUowpkTqrW4hN3k3uCV
	UKsjR6j2olDXkDfFzL/uR5IwgpAR/sv7YnjjgjjFisDdlYA57rEqSL/EHBGxcI8ipvWvd4i7Sc7
	/wkEOg2R2OkmArA2Vj8XzTJvdm3j7mu2HxK0Wsr50pPYeDkwg2RvHmZC1g/1GePPLKOQDUkzwJ7
	Q0KqqbEzy+bGqre1w7oPKj/w4rJwVUehGzoYNXNKXvUMZRBqtp4FtzHAn0cWC4oznQBS+pTby5Z
	fPqI8ZYwTBV5VgRmz6Ru2K5ILLD0m/5lFPUDrNBvV6qpWHIhruTgoNMun8NxWw9l723caPkY/JL
	na/fcF068umSdH4fLu9dayw7s60aZTIxeGrWdkGG3icQxqmqt3axuyaXrCLW9y6BRBBQyFWF8VO
	8+pN0/zt8zI8/htRe4CV0QNh2kJEQWIxwGsvA==
X-Received: by 2002:a17:902:c40c:b0:2cf:b68a:340 with SMTP id d9443c01a7336-2dd8e404f4cmr40489695ad.10.1789552544078;
        Wed, 16 Sep 2026 02:55:44 -0700 (PDT)
Received: from amd.ban-spse ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5e40494sm6617087eec.15.2026.09.16.02.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:55:43 -0700 (PDT)
From: Malathi A <malathi.a2000@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Malathi A <malathi.a2000@gmail.com>
Subject: [PATCH] serial: 8250_uniphier: Disable clock on probe error path
Date: Wed, 16 Sep 2026 09:54:36 +0000
Message-ID: <20260916095438.20837-1-malathi.a2000@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uniphier_uart_probe() calls clk_prepare_enable() on priv->clk before it
reads the port properties, but returns directly when
uart_read_port_properties() fails, leaving the clock prepared and
enabled.

The intent is clear from the surrounding code: the next error path, when
serial8250_register_8250_port() fails, calls clk_disable_unprepare(), as
does uniphier_uart_remove(). Add the missing call so the early failure
behaves the same way.

Found by smatch:

  drivers/tty/serial/8250/8250_uniphier.c:232 uniphier_uart_probe() warn: 'priv->clk' from clk_prepare_enable() not released on lines: 205.

Fixes: 26e8349c0d76 ("serial: 8250_uniphier: Switch to use uart_read_port_properties()")
Signed-off-by: Malathi A <malathi.a2000@gmail.com>
---
 drivers/tty/serial/8250/8250_uniphier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_uniphier.c b/drivers/tty/serial/8250/8250_uniphier.c
index e3db60bf50c9..52667c1891bb 100644
--- a/drivers/tty/serial/8250/8250_uniphier.c
+++ b/drivers/tty/serial/8250/8250_uniphier.c
@@ -201,8 +201,10 @@ static int uniphier_uart_probe(struct platform_device *pdev)
 	up.port.membase = membase;
 
 	ret = uart_read_port_properties(&up.port);
-	if (ret)
+	if (ret) {
+		clk_disable_unprepare(priv->clk);
 		return ret;
+	}
 
 	up.port.type = PORT_16550A;
 	up.port.iotype = UPIO_MEM32;
-- 
2.43.0

