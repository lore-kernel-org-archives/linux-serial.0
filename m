Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCD22135DE
	for <linux-serial@vger.kernel.org>; Fri, 11 Apr 2025 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744386270; cv=none; b=LmASm8bzUUMpLrmZei2rIP8DcNf9Swf0HMSqnFYQSMGoPvGiUBWfAZbfH68bnEGJsbVwQrc5mnr4zR735UZJmWEKTd++RjWdsd2tXb5MyLdcZPVAxkGPWu7c+k4eJG66oNGZsrlp11vqyqSS9rorFGeGmnGjE8uWIpDW/zgdmSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744386270; c=relaxed/simple;
	bh=ucvbVh/yXALhRLORxO86EDtcUDjhXV2k7FhsHq1IhHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDDh1dgtAghmEbh5zMRou86PbpGatp1kYHtAcUyt25oM9ir9mB40gcTxkdIU6ska4AjnhNmKJmQXBsnZshn59Gp8B+cG9qR6x0cHB7JJBXdwuesCFuQPRJlW++lN3Kdvy0eiFqypsOCEWSY+c0b+C7zAUF/wwElSaPlWFnXWPck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=WEAWQd6A; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="WEAWQd6A"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3d589227978so6978825ab.1
        for <linux-serial@vger.kernel.org>; Fri, 11 Apr 2025 08:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1744386267; x=1744991067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+No0irtswkb42oZgjOuCr5NaquvvHMgg0F5193JRX8=;
        b=WEAWQd6AlZmwszqpr2FdMHOqU8RG330klxdCeKbWOQZ57QkTE7ddQSawMK/9di0qCb
         jrYKhLPt/GL7IkodueJqF7EEf1Ak9KJpVD5Su8U+O+xTx2dJs7HP86tt8SvhdFwQsRTx
         JjD3/Gjp/wSLWWIy81VlYvqLWYhSU2mrKBLz2Tn+86LmC+jXzHxjwBAoTa9RIjS8fGSj
         G/Wfzpvfvzo0GfVSPHOgNGHMPMtOwifcrzrh7jAoqwGBe+xGzu4LyvnPll0MIrd3+Dbd
         V7xHvmPqzW5zy8fhUhcy7Y0DfJkjuk9314SZ3oF2CItb9ZLYpo6WnKl0NuwY7WuEH2Ki
         sgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744386267; x=1744991067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+No0irtswkb42oZgjOuCr5NaquvvHMgg0F5193JRX8=;
        b=L66HN9Icbyz7J+4yKKz+PAT6Mx39y95e3fcWGJ10BLBQpK8mIumOuywHhTlLEjXTHR
         IsMJyq3LSsWbWlxjZmDN3zPAQjIyI+gyECps1NG8CxG1SPK2FZvut0CkL+k0jykPIvt3
         iD058i/QFxxyNh9Gmw2sNooNxC5iNZtYJmrxxFIJuk35jVOKGnlingeYQO4yty2yEsLO
         sXueSVu/HUeJlx3hMN3a6HOIViiWeLzAF12WQcwf/ie9IQko021GjHyF+szgEVmGfdKX
         HqgGQnf8AuPeXEpkss53V53m9Va1xczh2B+jV9xhlCWy2judSjgnLP6kMVoOOit0idtn
         XrNw==
X-Forwarded-Encrypted: i=1; AJvYcCXUQjB3zVZkYjvDqaY0m9iqX6YzmQGtsTOtZvs6S5MyLtRw19B7YexswopnWtzwHj0Rf2qVPWq/7LWNccQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr/3vvg5nxXcByy2X5bYgYrAhmKTxQ0DTwTtOEmuXaqi0ZSolk
	se73d7ozMwW/YAScj+GyxLeEVBCl9JWu5R3d+LzKSprOLX17J8WVpKPBzKwqHs4=
X-Gm-Gg: ASbGncuJ8RlxVUvDQYdquE6tNfktS4bDflLyS7vKcpslO2Nz7qOxUB8ZYbf8rkb58GN
	Dyq6UXJu+XF8MZqjuglSED4Z3Icw11AU2yZjHPlSRWI/opRmbK731lOt+2kwsGUrGM92RL2mMUw
	vRGLO6+6JtrYPACrlrsvz1nBPjPesQgP5dQ87Ooty1c9pemNDHy9mDx7KS7+lNmP4H2YZ78vII3
	XK7OQIhwmI94sOwWMz+FKjVA3TYv5a0mvHZoDhCTCt//LrES7OeZ2aq5Pg21SZcwF8TJ28tkLKY
	e3sNlYn10/s2Haq0mdbwhcSJPCIeJESdHP1fQ7mZwuKkOMR6ppBre56VE3V6XU3R6eQRXSDV62v
	QizdYnm8KZ3N8BA==
X-Google-Smtp-Source: AGHT+IFHmGeALO9Wp+63MrFrWPOF/pQKiCJFNH3pXYWduOMBqvBFciOLd/8MEHS0nwfjD94ZFGolaQ==
X-Received: by 2002:a92:1304:0:b0:3d3:d08d:d526 with SMTP id e9e14a558f8ab-3d7e4d0c549mr59399825ab.11.1744386267024;
        Fri, 11 Apr 2025 08:44:27 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505cf812dsm1276326173.18.2025.04.11.08.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 08:44:26 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlan@gentoo.org,
	benjamin.larsson@genexis.eu,
	bastien.curutchet@bootlin.com,
	andriy.shevchenko@linux.intel.com,
	u.kleine-koenig@baylibre.com,
	lkundrak@v3.sk,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] serial: 8250_of: add support for an optional bus clock
Date: Fri, 11 Apr 2025 10:44:17 -0500
Message-ID: <20250411154419.1379529-3-elder@riscstar.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250411154419.1379529-1-elder@riscstar.com>
References: <20250411154419.1379529-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SpacemiT UART requires a bus clock to be enabled, in addition to
it's "normal" core clock.  Look up the optional bus clock by name,
and if that's found, look up the core clock using the name "core".

Supplying a bus clock is optional.  If no bus clock is needed, the
the first/only clock is used for the core clock.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/tty/serial/8250/8250_of.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
index 11c860ea80f60..a90a5462aa72a 100644
--- a/drivers/tty/serial/8250/8250_of.c
+++ b/drivers/tty/serial/8250/8250_of.c
@@ -123,7 +123,16 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 
 	/* Get clk rate through clk driver if present */
 	if (!port->uartclk) {
-		info->clk = devm_clk_get_enabled(dev, NULL);
+		struct clk *bus_clk;
+
+		bus_clk = devm_clk_get_optional_enabled(dev, "bus");
+		if (IS_ERR(bus_clk)) {
+			ret = dev_err_probe(dev, PTR_ERR(bus_clk), "failed to get bus clock\n");
+			goto err_pmruntime;
+		}
+
+		/* If the bus clock is required, core clock must be named */
+		info->clk = devm_clk_get_enabled(dev, bus_clk ? "core" : NULL);
 		if (IS_ERR(info->clk)) {
 			ret = dev_err_probe(dev, PTR_ERR(info->clk), "failed to get clock\n");
 			goto err_pmruntime;
-- 
2.45.2

