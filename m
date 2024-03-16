Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFDA11CBA
	for <linux-serial@vger.kernel.org>; Sat, 16 Mar 2024 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710581418; cv=none; b=DqhheBDfcVtO+M8SU4a2OOH02KvDGVCxDHSInkGuzd5edyfVPjnr9FU3xPatIJK0ThXaYYrh/ozgrUdga4R9PTEdiQzst0NGePYwBK5PhNzKMUbwl+zjHVqJDfYNHDjm3X8ETGfqmthQTvp900ouW2RjrGHmmMWi9e4SqSsSqQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710581418; c=relaxed/simple;
	bh=3a6ZkGbC6qnjXSvnaDZPukV97lFmXpUpFjamuzvR7e4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GjyLZnrvAdnLzMnmYHe7k1veleCFhn9VYddvOrn+jC8Yt62RmtB2Qb6jSvWuBG4mr5N8TzCJrLV6iBye/1lVg8N6j3/w9UJGHIVJu5HcKu919YuEOnvf05fDwXAUEjq21tu8iTh+OTTE0V0tb4Hlmr/l8eo04nwWXJbvcpQOURc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hQ9d3b//; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hQ9d3b//"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-512f892500cso3216109e87.3
        for <linux-serial@vger.kernel.org>; Sat, 16 Mar 2024 02:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710581413; x=1711186213; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGUAB3UIw3E7EFrzYS72iNT6shEEycV/Wx4kFX1KU/c=;
        b=hQ9d3b//VyzUIh/rdiLQt7Jdf7l7DRhbvVjrM2jerO3K8r8lcPflktsdqZzAKdG2Gb
         r0uX1uPuTE3P2HGfIwI7PD91N/oo7N6LHth+E2FAfx0TBhaMusUhBjG/3l/T6T/BCqxU
         Gh3nHg0mX4Xl9KA6Bb89tgU90Lft241uyOtVmOzasW9D45XD/A+gHDGP0mnPPZWR7Yrg
         0wmrtvTwbmm63bHBWh9A4PbsXvGjEFiIegt82bZERiZRP0NGH6z7CKVHX+0BeS07NUDu
         hauV/Z7OpE/xAr+hnxaOkt27TWlLhBQ5iFR3rnY4oYKN7ivCOGGu0Vpz75gqWMA9diQ7
         2R9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710581413; x=1711186213;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGUAB3UIw3E7EFrzYS72iNT6shEEycV/Wx4kFX1KU/c=;
        b=FS0lmbhcJt7wAHlm+W4o96qKsPizgr4+bbla1atBe12/GS0w1gduPbUObailJDHXbx
         ydOVOKvmRp3DE8A5RJZurcwFK42t4N5J5+pkMbmhuf+AKRI74bAllVZZl/OVUCCYl8dz
         t67N3o9FPnfjFp3thD2M01bBKGy7VgYOs3vwRVJ/Y+Jk2BPVLlLL8kHNAI65lRetJkFa
         y6sthCtcFcGRMbGDXzb0D06ZXrlnmtmMhpMff8lWHX5ENYEh+fo0I9BhDgDs3ydMSzwc
         xOBRupLeOZqojnM6qEeH57EmSsSK9tmby/VN/BtvHzGeTGkoumPKe29f75pmY8kFIDjT
         Mkkw==
X-Forwarded-Encrypted: i=1; AJvYcCXu2VyVN6fOpbzsIdN9Sx/jZo3H2xUrNTcvRcd0KVYV0yLP4RkUzr9OgeNvAGjpyKScmWSWm08eq6g06Z73HnMF3Mf03X3jLC9xQSD1
X-Gm-Message-State: AOJu0Ywye3rYqLWg8sW4urL8ld6J3+ArJQkIWOg6cJ4axiie2gByXFNK
	1/wblFF1kUu6T2K2iBG2RgjIrwKOqZ0b3VldG9HiNDM+0yOkM6LzJUacT3/NwK0=
X-Google-Smtp-Source: AGHT+IHaVTRcQ6GSzZTIOX7uqn97na0aCbldg2yl3L19ISK8nvKzKRYsmj4GCGkP1PGTK3RRw+8UUw==
X-Received: by 2002:a19:914c:0:b0:513:c223:f0e4 with SMTP id y12-20020a19914c000000b00513c223f0e4mr1128678lfj.10.1710581413374;
        Sat, 16 Mar 2024 02:30:13 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id fb4-20020a05600c520400b004132901d73asm8228520wmb.46.2024.03.16.02.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 02:30:13 -0700 (PDT)
Date: Sat, 16 Mar 2024 12:30:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] serial: 8250_lpc18xx: disable clks on error in probe()
Message-ID: <92646c10-e0b5-4117-a9ac-ce9987d33ce3@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Goto the clean up path to clean up a couple clocks before returning
on this error path.

Fixes: 0087b9e694ee ("serial: 8250_lpc18xx: Switch to use uart_read_port_properties()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/tty/serial/8250/8250_lpc18xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_lpc18xx.c b/drivers/tty/serial/8250/8250_lpc18xx.c
index 7984ee05af1d..47e1a056a60c 100644
--- a/drivers/tty/serial/8250/8250_lpc18xx.c
+++ b/drivers/tty/serial/8250/8250_lpc18xx.c
@@ -151,7 +151,7 @@ static int lpc18xx_serial_probe(struct platform_device *pdev)
 
 	ret = uart_read_port_properties(&uart.port);
 	if (ret)
-		return ret;
+		goto dis_uart_clk;
 
 	uart.port.iotype = UPIO_MEM32;
 	uart.port.regshift = 2;
-- 
2.43.0

