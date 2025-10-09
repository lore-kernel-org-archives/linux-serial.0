Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A269F1799F
	for <linux-serial@vger.kernel.org>; Thu,  9 Oct 2025 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759997630; cv=none; b=MW8eiNmStR/NaxC6L9BlB3hqnl2RxTmG4LSmpc5p2YnL9IvkjAXBUFGfh+aEM2VNNRDTLlzVUJ65odBdjxnQ5Iti1x4RPwqbIZjk6uW8KZmAJOhMDVFTzGer8raCiXO8eQ1gmnr02pLZ5ChsbW5Wwb6H8/s4Nwo737t3sYu1h2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759997630; c=relaxed/simple;
	bh=TN+/HuIl/tElekawhDQJfAyvvcptYtxxwnziK+Ps4gU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P8P6sLYjzijL8cgGQMOQEOYYzwjnFsJ88pASOvEICgnNrWwQcbJzL3cNYkSWzrYAIawbANlQ15r1Dk/tQc0MSpIh7vm+sg1VI5a0BXFy1VloISGpgmuBG9a+NABw5n9wkOdE/Ii0THl5FC04TsUl2HFiE9EE5Geo31kZcs9va2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZFOkJJZ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZFOkJJZ"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso2237541e87.1
        for <linux-serial@vger.kernel.org>; Thu, 09 Oct 2025 01:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759997627; x=1760602427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Q0cueZkPHkbn6Q4Lj1AUdLj1Jvz61p6khKCT5+d0BY=;
        b=iZFOkJJZ2hZM1ToA2JXSPoMV0l+9r87uiP0qBIZx0/KAFFIeKyJXAYs0zPwTJ4NDfo
         urHlyqAH5KKxXE9L0+o/Z9ob3A15G7tJcSRx56GZ1d6iSkXwoAh3VA04qF90/sNlHxUH
         0ijL2bTrc54wo6NOyesolr2e3uZL5+yDwTl7NN8DSzBAoZyGdPMnNJTU2GQjwUjB2jaM
         w3AtYPCBVfLpdbIxbDrfoYA6LaIYankkcM/nIfihDz8VpFoIevnc2hRClG/WrTwjhJIe
         Vjax3zpwQGACQh4tCi9fNxgo5X6DUWOGgqqcZF5NEM0Zo9Mhn7ZfeS826yX88Ax/pd5J
         drOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759997627; x=1760602427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Q0cueZkPHkbn6Q4Lj1AUdLj1Jvz61p6khKCT5+d0BY=;
        b=BtLTJSoN3P5/2Lhktpzzi2dqHdJZLbEMAStPx9uRFU1OXTBRuI2VpnPXO7Fnv1tY+n
         AD94nFq997AFogBVdJtZsNPM5jRtH5S6BEdlCEky8QY/Z8rxdA5879xlbiSOJbJuCQXN
         nfhZ8i+N7DfRnredQRp1DCSqCEWT2nW77e10oFs9zD4+1H7QYE2Sfwvm0XMwNqZmWj5z
         PHd25zS48zahigSD2RuYgQbOzI3GE1o7O1YElJ7KUe0Y4+cY+EKylINNmWylh1jJGICi
         GjbEIxhVy1zLEBHmNPL+WryMuVv36jQjj8L4LK4/07fwoJ7Xs8VwoSLYE2cXCbmvFZv0
         TSdQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6jaRLVYjOGIytqQx0XG53wOFqhbbOvewexsEfPdTBeWTKPH5oyWeyfagkrEZfQwka+Jy9ZU1gwBtUwFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy36pogkBJquCNMpmB0ZqvOZzL4bHhsq2yRYJZEQJNjJyuDKwNA
	cycyKxjg+DsoGdZoYMa7clAHjgPOLRFkYrtzYwiffUsqwsCWmgl3eOUQ
X-Gm-Gg: ASbGncv3NE/mKEZgmQIFb7+oxtPSnELSBwd+pjlO20prlHjg8sSQmlOKKI9aym2Eus2
	DKuXcLm7kOQ8tzshbfHT7Q+jaL+487M25Nco/70XnaKjHWQoAXNjnBAahXxycrO5G69wc9L00HC
	3x5Vv/PXkqjALHZyZcCe9KYMST1l0P7a2QRzoC4pa9cGv1jysskBulU7BkzmpnDFAwGmPLjyE3w
	DRqVamAgBDp7nn+rkN9bytNZCDk53/aGw3sW+dEuCdV4twa5KL1F7pFNqXBBLa5yd9HFPlJ18bI
	4qe2W3oaK0pfBwnMUIWiPn3RoTqozDT183J1oLv0gNTaC8+4152sL/bvEWcEzP/TYh2ZLqfplK/
	R1a0ZUK7YQYaIgoSIC1fnaWLyMMTGKM9IKW6wrqvJsH+vol0G/mRWS2dckWWoHtep6a18sM7dSP
	g=
X-Google-Smtp-Source: AGHT+IF0/FL6ISa07AMBLLSvo94NRr6Rl8+hqLbT73ju1TmIjYqpED4v5sik8/wuf7B6D2qEqWjVOw==
X-Received: by 2002:a05:6512:3d26:b0:586:a95f:cac1 with SMTP id 2adb3069b0e04-5906f3107bbmr1954853e87.12.1759997626591;
        Thu, 09 Oct 2025 01:13:46 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5907aeb4584sm822206e87.125.2025.10.09.01.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 01:13:46 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: a.shimko.dev@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH] serial: 8250_dw: handle reset control deassert error
Date: Thu,  9 Oct 2025 11:13:08 +0300
Message-ID: <20251009081309.2021600-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return value of reset_control_deassert() in the probe
function to prevent continuing probe when reset deassertion fails.

Previously, reset_control_deassert() was called without checking its
return value, which could lead to probe continuing even when the
device reset wasn't properly deasserted.

The fix checks the return value and returns an error with dev_err_probe()
if reset deassertion fails, providing better error handling and
diagnostics.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
Hello maintainers and reviewers,

This patch adds proper error handling for reset_control_deassert() in the 
DesignWare 8250 serial driver probe function.

Currently, if reset deassertion fails, the driver continues probing which
could lead to operating a UART device that is still held in reset. This patch
ensures we properly check the return value and fail the probe with a
meaningful error message if reset deassertion fails.

The change follows the same pattern as other drivers handling reset controls
and provides consistent error handling behavior.

Thank you for your consideration.

Best regards,
Artem Shimko

 drivers/tty/serial/8250/8250_dw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a53ba04d9770..710ae4d40aec 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -635,7 +635,9 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (IS_ERR(data->rst))
 		return PTR_ERR(data->rst);
 
-	reset_control_deassert(data->rst);
+	err = reset_control_deassert(data->rst);
+	if (err)
+		return dev_err_probe(dev, err, "failed to deassert resets\n");
 
 	err = devm_add_action_or_reset(dev, dw8250_reset_control_assert, data->rst);
 	if (err)
-- 
2.43.0

