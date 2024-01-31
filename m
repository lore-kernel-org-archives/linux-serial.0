Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F145FF18
	for <linux-serial@vger.kernel.org>; Wed, 31 Jan 2024 08:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689507; cv=none; b=dWowYGbtjYe5RrY5ZU3q8KlR7q7VoP5SFUssfcPkt9QA9exKEfwxQuc4qmA1bCZJLJbMccf9LFhAt3kZwWD98lNj+PYDubfN8FblXJha2o6FOyHDvCOZygA/suLdxUBujVBvki914GfVmDBnY6gLQ9YYyUN0n3f1L78iDLmu2rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689507; c=relaxed/simple;
	bh=m32rvnoHeDneErJtvFKjJCT1+v1UYtt13ihilo7pDBw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sJ/J1slHNNBAK9/OS4jKcHkuswiEZFqmwQgDwOpW6dwp/KIufGvTaFPcbKexhRFjhSQ7xh5IAewuqinyI3GNUct3WD1BXb/htWf5pHWHDAWsiECD1I/90RFvw9CUzC5g4DHwZbbqLuPYLD2JMaRC5SPDqxgOaata2YV1WStIB8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vtiVCS5/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vtiVCS5/"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33ae3154cf8so2533454f8f.3
        for <linux-serial@vger.kernel.org>; Wed, 31 Jan 2024 00:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706689503; x=1707294303; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kjfr1JWWqOzBpF09vA5iofFwPy0q9GLVhIb7MB26bGk=;
        b=vtiVCS5/9LYvIczCo1dTkKjHd8K6tFOJ7jYfICwpunCl/BidSDeH/4ByXEujRI3E9Z
         345c3FzfjPkngk6Izs5/dIvCN4RRsZDUffL5aD5UhTGHT83RTMzI6TbfHWc5OvKgFr7z
         zB7gTmbfOqukmAhzw3VaWCdSV1h7hd+oJa+V4Vf6LhPe8vVRgt8fx4Ai3AmxyBeCwP/E
         m3XGHhgKq3fD+j+BN1g00cyKhi9yvH1VVJebaJ9dSY3wllWPI3Ult8TESpc1SvIqzkwM
         QM6OHMlBerwcVGKVLz7gWOL45juG7jJX9t0f1j+xxMFXHpYhKBUmXcUnUe584bg+UaOf
         4vLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706689503; x=1707294303;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kjfr1JWWqOzBpF09vA5iofFwPy0q9GLVhIb7MB26bGk=;
        b=qsqBal7+lr8ouxirEQtKP67aAEv78hOrPFZak3OTTdTdWLN4V8WKsEtY6kpn2vmZBh
         ebrJi3tcitnNDK6iSXYCy0LCTJu6RSUrWOFppYOEzs3ESVA2zxWlxpPaN3YU5J8KRO0C
         V0SZnxI+rb6vzyUQ3eziiSfkwFYzo6nX5ZdOTBg6tpJTOmKngKsq3vdvUHsgstV/pUll
         Fb6tgODf2R2htQFSMV4iroMrrEfdXZ5U+dspdkftsBATdF1f/i6AgLdKGaXVxOKaJYnf
         vKaJaWMSh7VOVhCeEPKk43C3XmFfAd4a9c6ae+x4XARVi3g/1q4RgaTN8M/1syX6jRnu
         5lmg==
X-Gm-Message-State: AOJu0Yy/x76tesLGwcmVCLU8gn2d/HG1zld02F8s4rbZRb83ZYwQ/IsT
	iHIzS/Her9wTKQvfNIGsetGiWpjprFVVHPH/nIzNmtSwxe0EB+ZGqsAUajfLrj4=
X-Google-Smtp-Source: AGHT+IHoltuxoKIeHVVpKUMTvfTCftXaiHZYAChZuYJHWMkSt7h0Ajid41fYMtToV3jNL4hkgTJq/g==
X-Received: by 2002:a05:6000:118f:b0:337:b9ac:97f6 with SMTP id g15-20020a056000118f00b00337b9ac97f6mr554324wrx.55.1706689503559;
        Wed, 31 Jan 2024 00:25:03 -0800 (PST)
Received: from localhost ([102.140.226.10])
        by smtp.gmail.com with ESMTPSA id ch19-20020a5d5d13000000b00337b47ae539sm12799999wrb.42.2024.01.31.00.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:25:03 -0800 (PST)
Date: Wed, 31 Jan 2024 11:24:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] serial: 8250_pci1xxxx: partially revert off by one patch
Message-ID: <bd6fb361-bbb9-427d-90e8-a5df4de76221@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

I was reviewing this code again and I realized I made a mistake here.
It should have been > instead of >=.  The subtract ensures that we
don't go out of bounds.  My patch meant that we don't read the last
chunk of the buffer.

Fixes: 86ee55e9bc7f ("serial: 8250_pci1xxxx: fix off by one in pci1xxxx_process_read_data()")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
Sorry about that.  The other part of my fix was correct though...

 drivers/tty/serial/8250/8250_pci1xxxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index 5cf0580f21cd..356972734b29 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -330,7 +330,7 @@ static void pci1xxxx_process_read_data(struct uart_port *port,
 	 * to read, the data is received one byte at a time.
 	 */
 	while (valid_burst_count--) {
-		if (*buff_index >= (RX_BUF_SIZE - UART_BURST_SIZE))
+		if (*buff_index > (RX_BUF_SIZE - UART_BURST_SIZE))
 			break;
 		burst_buf = (u32 *)&rx_buff[*buff_index];
 		*burst_buf = readl(port->membase + UART_RX_BURST_FIFO);
-- 
2.43.0

