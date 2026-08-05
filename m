Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38516466B70
	for <linux-serial@vger.kernel.org>; Wed,  5 Aug 2026 12:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932439; cv=none; b=rGCB+orZAzT7JZdQqkBg8bMfgEQxL/LG6QygYc3qWmdY8uS+iaRFRBkTQCrc9FG+HjktZxlFe1gvTSjTsNAqaI/sqcYV+OA6fpIASABtXtKARvkMBoOPAxUnzaIl1mtKHAYrjS6/U+2X82XZhMGTgZ7bz9qMQ/coijbDDN+Sxhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932439; c=relaxed/simple;
	bh=a230ZCfC90axJlgwhM1ZKMw6zyzB++PhLGa2dLzKeqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7wbYarsEBDo4kh8Lgx0y5ZcA0ZUMhr510eruoASdGqVRqQureEa3o0g4E2o/ujruV/sme22B5/UHhDE28s0Y0N3cK1JugH30RHkZRonKrt8gCLqlzaALbxYUujt6es6WJG4XCuvLUdJT3JKQQ4nIiVtv1ooUkYPL1FIUeguwFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=HWr5qCkR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="HWr5qCkR"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49553515a8bso13234695e9.1
        for <linux-serial@vger.kernel.org>; Wed, 05 Aug 2026 05:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1785932435; x=1786537235; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=43Zhfg5+4+Z1uzvRXKb3yHpIvITffod/8Jre6ZQvzL4=;
        b=HWr5qCkR2F1BUH964LLjzbJfK1Mc7YqBSNbLqEligu+GTUFn0w4mIuyu6+cYt1BBku
         WVhHn2yPbf6DA+sznbM2eAafcK7e60MGWF6HuFQkfEpDhsvEe1MEFqn59L0JeuGlOedw
         BgPSpdCwpCQ6zOolg8+NHcyWsb+wjZMkNJs3twNscW37kFyC32piEf6W6KBKzFjta9IV
         qP32PvfjlOVJ/pJ/fNQxuMUVRGBpIdpvqA3hvOk3SeVd47ZTqGG1VmuLCj0diVkmjQVu
         uy6W9IKv+c8dseUE0mjrL/CzWl1/VDC3DgVZdL+OwcNMjIBP9+f5ATM0OscETWsMEfox
         PcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785932435; x=1786537235;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=43Zhfg5+4+Z1uzvRXKb3yHpIvITffod/8Jre6ZQvzL4=;
        b=GcV3xgjMRh9J3BwZxQ+Uy2GnvMmu81L7Qujlg+C5udjLHsomuAuawOeBfwWtoIJZQA
         6In6pP/yY4pVnlhCNwzUFksKbiTvZFBNd7AX/4wT8tOLb9zX/SUppUiHWyvl21JpjvuO
         AKs4WZon/xYoL4acg92CeaxUhgAW0u/BTL7xEj21sfXmqhQDnC/WEFYw+T0icTqL9vAu
         Yvqb7TxdXba8RSkxR3XzGu0iMW6abnLsYT1Y9rhUX246GUfRcKom9k8DNtdS9Jf5Zu1U
         D5i1ZiRFrxoFua/6YbgPYNAPAk6p3uCvLIsg1azzvaBhbw0xKp2OWlJ0XVCD9/F/OLC1
         L0GQ==
X-Forwarded-Encrypted: i=1; AHgh+RpX0PwGNircbsSld98Y+5O/c0l1f5Tkv9KhsMkV3TFHGqv1WGwvaxVaE5iJVAMpOIyGv4bfAn2CPBaClJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsZomC+SjBEQ0HE7JEjc3rGha2uQsuJD9cRjDaR4IEdn0WLn7L
	9L24HsCC1cS2b2QLnuDylNCFImuLivER1Dl6S9R+TPu4sKzAIdc0FZ8HD4C9sbcI8ug=
X-Gm-Gg: AR+sD12RVbDvpIrphLpnmMGbue/d63wLRXRuRpgrRKfpdMVN2pVSOkccgT8UH1UFuXD
	T6XQaHQPqLvg+4PnuzxPqiA31PegegtWVXUJwcGbyw+Clqw+TojVC3WSW+mXv4A/SFzTq00VXlS
	BbdbTamA0X0M60WP3nxRrIiVnZlMuzyhLCXTtC/Gt8dIsC58cGos2XSJRtFT5omoPLlNOEElIvk
	VvrmQM6Lq8GhBbDJQopx6CR8AeWmMYs6eEIHbIEQG0qqI0vgHGCBskwW832BpGtbJMBK/A6u3dd
	i4Wo2kp1oZcKw7uioRznmfm/UWMK4jhf7Pg962Xqt5Xt9FUGPQj390v8MOGav4/jNPYS7cB9xW9
	LhfLnFzhUPxpeYif3UTI3ZHCsJoiMBDkmqA/IOhiYCvBBgm1fheD3u1arXNAGjXILl6IF9wXZP3
	I7g1S4/mpKi78ROj8aEQ9i7J0T2zWrhH0h4uep2UJSvomB57Q3L5HVGV11005aI6AvVPM1Vqx8G
	IaCuyiXRApGAx87mJDWrEz1xT59ABgzU7N7bbeBiX51/EL2u299cZsjneAoEf7U6xqDitcRVVlP
X-Received: by 2002:a05:600c:1c22:b0:495:734e:4825 with SMTP id 5b1f17b1804b1-4994e7dcf28mr67408645e9.16.1785932435246;
        Wed, 05 Aug 2026 05:20:35 -0700 (PDT)
Received: from gregwork.sec.9e.network ([188.111.3.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949f68f95sm196663515e9.0.2026.08.05.05.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 05:20:35 -0700 (PDT)
From: =?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
To: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lee@kernel.org
Cc: andrew@lunn.ch,
	jacky_chou@aspeedtech.com,
	yh_chung@aspeedtech.com,
	ninad@linux.ibm.com,
	anirudhsriniv@gmail.com,
	tan.siewert@9elements.com,
	linux-serial@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-aspeed@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Gr=C3=A9goire=20Layet?= <gregoire.layet@9elements.com>
Subject: [PATCH v5 2/6] serial: 8250_aspeed_vuart: add aspeed,ast2600-vuart compatible string
Date: Wed,  5 Aug 2026 14:19:49 +0200
Message-ID: <56aa0a5e26ea76e4f9a27ed059d2b05bec9cffa5.1785932211.git.gregoire.layet@9elements.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785932211.git.gregoire.layet@9elements.com>
References: <cover.1785932211.git.gregoire.layet@9elements.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Make the driver compatible with the ast2600-vuart.
Enable specific configuration for the AST2600.

Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
---
 drivers/tty/serial/8250/8250_aspeed_vuart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_aspeed_vuart.c b/drivers/tty/serial/8250/8250_aspeed_vuart.c
index 26fc0464f1cc..6afa2f4057e1 100644
--- a/drivers/tty/serial/8250/8250_aspeed_vuart.c
+++ b/drivers/tty/serial/8250/8250_aspeed_vuart.c
@@ -560,6 +560,7 @@ static void aspeed_vuart_remove(struct platform_device *pdev)
 static const struct of_device_id aspeed_vuart_table[] = {
 	{ .compatible = "aspeed,ast2400-vuart" },
 	{ .compatible = "aspeed,ast2500-vuart" },
+	{ .compatible = "aspeed,ast2600-vuart" },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, aspeed_vuart_table);
-- 
2.54.0

