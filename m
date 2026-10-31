Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793407352;
	b=5tmPhaVmv7c9SHMTVHHPvGQ43I2JevMryL6AdlYZKc9kz97zPbAUu5RueV1cIPQRdZGZ
	 YUCr41ss/m4+A0Xwq6Wi8GCkC9OUHktoLjVvwOnEgD2/q+JAOkaMgas636ZWi/GxgcA0f
	 zoyPuFc1VAEVvC0Uc2GZHsb/qqdmJrAhyrRNadD6JBMOn0/rHkAVtI/EPvR8CjiV6AgmP
	 tiCy7IDRN0MKXl49rgpSw/FBZfqF33nNL9Kk+k4zTOSHCiCL/Ex7RLZKVc/DiMXzNvg7v
	 zABmjUwta2VRcnaOA6GO3nRogEdQDuARlX6yJFjUYHVkJ88mvJgi84Xx0NFU39xnqYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793407352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CSp+JrDvF+4x5emqlEOYM8+al5h5LvfzmXFhEk2YqvM=;
	b=GjkcMoE0Isjw3sI4hBqcUfXi8BwSnNwlJT//vpJiO/unjuhDucVaM4v2L5MJGvzgnKFd
	 6YcJhSuAHj1XeKPwsdYS16ff8xDoQ4r6Ok7at7AyJHHZMe6LAY1SlZGl3MEY0iYxe1hSB
	 ujwDQBD0olFsxCFZw67AfbKmEXtHy9N/sRSS/rCrwSBz4Di+dSV+Yj1ZlgIqE11mdDgUk
	 5gbSDQwW3JNySJSBTOB9kKjB+NhmwplmnwxPX3xcvdQntl5Q0uAKSykttaWesCwP+cWWY
	 zoDuDhueQqxzOCcZW5dpRCbghtJdI0AgQSAk8F9aObRjdcp7iGVEOUYcjyEMHbEKUIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xowMI382;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1FB606A324
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 00:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD1FB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xowMI382
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-353804b591eso2010542eec.0
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 17:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793407351; x=1794012151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CSp+JrDvF+4x5emqlEOYM8+al5h5LvfzmXFhEk2YqvM=;
        b=xowMI382kXt0JlNAaISc4k7doxpJc4H7KqK3RcQHXxYwEPuaDmuCdCeT8vjQ0/BkuI
         rAGBmDV0aq8uU9ciZbt51HiIhebAZpONrCz0ycnsD2n/FAruk1wsdYr9QZAHlM40WEiw
         AOO+g26kPqVQVJzYFfmKcf+TmD0uT7t1a0OiUcEK9RJEDlQ/Dd+Yj8Bsm2NTRIOnT7v9
         KieBeewfJq3qPm0h3+SXz5ixZ5B0EJbUI9iF6siVi1Lk/2nTrrWdlEqeRFqQSoq9LlBC
         B68Y5T9aNMJuWXzNr5eX+37IFP4bQwZZ9qN5735AQ2v/IgkudPDP2sA6NGtRS9caYy92
         mXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793407351; x=1794012151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CSp+JrDvF+4x5emqlEOYM8+al5h5LvfzmXFhEk2YqvM=;
        b=r4VYw2nQtjYyYgNYM5hFdg+PflHelvX29IajU2i/NfXdeM4eP90swppFTUW1sXU8p4
         zUwobvKPkHn1OXIbrRVYVbVMaqEYaYNuw0XszoIVBPWnOYpSumtp7FgwFzGrQnnkdYuX
         Bzc0GpKGKOTLYGLZXGEXSATUTOr14BFKzMeVXMJYy3cK4KhSMX/3tIs6dvncEA+iElzw
         2gqaZp8r+C/ceayHeKEimaJ1Xc3+Fm5lnn8RERsLY3AMLgyITM5u5ICMKSVAs64/ZCFF
         P4esWgQd6VzeFzYuGgAs4GbA89UBZd+FUfgNNbHw+3QoPxBBkAHZQDHyi80LU+lRg4Gm
         hVpw==
X-Forwarded-Encrypted: i=1; AKwUvBxWlcrqKilirX5ueJYpLs6R9NpTHubmbY0/EbWtrl/QU4mHRPRWFUQl7XpYjJNYlG0EMXyIBo67XxPnhKI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIy4w/eH6bJRIVZrDkp6wPo4v+pvY2/pn99tyPKY+CuG5Sr1tkj
	AhhTeYq3PRT0NqW01QXcGvJdf1iCIpsCLoOosFMFSvichTAVwnBUEQk6
X-Gm-Gg: AYBFou2g17ZSdpPUBFc5NcJX351m100kXlsl4s56hiyuPu1CVTiG2YOAQZ/uH8patvk
	iWwrnxrh6/Mabclct2fezeJ0H2ynMFqN+lqG/D5sGppgdVQiaqJdBujiFgzYu7ZIW6lXmJciCeK
	z+JOvTqSMpHi8DmW2zbkvLXnV5L+JMtB5bOWLFpG3EBw9sB2FncJlAoF57LPN4Ur4OtjMn5S9h1
	Sbyua2Nams3hwJ13Sjab+5wYLQzn+lSCmL77vpZ2fwI2uOrkducIakko49kGOjvtkf83XytslWb
	FJ7FC8L2ENAe31JrfBpCMW562IdFqUpxDY79a1R43vt/V9NkNjIWEsMlPICtVDAIjLpCPs4x0J1
	G74CwDinKP6kQ6HhSS+Jmu8cIHY9BHtHjL8yY/Q0YXyPkLcKiGd9HYgeVYDwC9V6N/l0F8rZQx9
	CJoZ5wdt35ZDVfdUF9mLzIbcMmSXCnZ/mcT/i2W6A2BHup54L7vjZKZU6vypws4KNYofQ3CHf6h
	LpIStLyzb0DMoEnG55ksRz9XUK35a6E6Do7ZVpsYowmBABnw81LXMGUKAFOIOQCgiW+07MCH6Ru
	pQo3AtFAUNtAeV9WikxLAPWUOI8dmja35F7qIH27bCi6QvoW03MaQXWxt29ZqF0tJXZJBHqwU7p
	8Z1W1M7Hy0ZW917SC9WdoNWH4Yow4DGMWg8Ppu0BbYUKncIYZGfTBLllUYfP9WBQrUbA9Crxcll
	Itc9l/Swo46fbYKV0=
X-Received: by 2002:a05:7301:6787:b0:361:306f:c32a with SMTP id 5a478bee46e88-36a42345b05mr7287000eec.11.1793407350704;
        Fri, 30 Oct 2026 17:42:30 -0700 (PDT)
Received: from brev-9gdpyq8lp.ap-south-1.compute.internal (ec2-3-110-210-194.ap-south-1.compute.amazonaws.com. [3.110.210.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af91bsm10889097eec.8.2026.10.30.17.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 17:42:30 -0700 (PDT)
From: Samarth Narang <samarth.colleges@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-samsung-soc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Samarth Narang <samarth.colleges@gmail.com>
Subject: [PATCH 2/2] tty: serial: samsung: do not re-arm RX DMA once RX has been stopped
Date: Sat, 31 Oct 2026 00:42:17 +0000
Message-Id: <20261031004217.3340610-3-samarth.colleges@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261031004217.3340610-1-samarth.colleges@gmail.com>
References: <20261031004217.3340610-1-samarth.colleges@gmail.com>
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

s3c24xx_serial_rx_dma_complete() unconditionally submits a new RX
descriptor after each completion, even when reception has been stopped
or the port is shutting down. A completion racing with
s3c24xx_serial_stop_rx() or shutdown may therefore restart DMA after the
channel has been terminated, potentially allowing it to access the RX
buffer after s3c24xx_serial_release_dma() has unmapped and freed it.

Only re-arm RX DMA while rx_enabled is set, and clear the flag under the
port lock during shutdown, since the hangup path can reach
s3c64xx_serial_shutdown() without calling stop_rx(). Because the
completion callback also holds the port lock, any descriptor submitted
before rx_enabled is cleared will be covered by the subsequent channel
termination.

Fixes: b543c301c2c5 ("serial: samsung: add DMA support for RX")
Link: https://lore.kernel.org/r/20261030162334.3000737-1-samarth.colleges@gmail.com
Assisted-by: LLM
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
---
 drivers/tty/serial/samsung_tty.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 2f6c69bec..3f2346f4f 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -622,7 +622,8 @@ static void s3c24xx_serial_rx_dma_complete(void *args)
 		tty_kref_put(tty);
 	}
 
-	s3c64xx_start_rx_dma(ourport);
+	if (ourport->rx_enabled)
+		s3c64xx_start_rx_dma(ourport);
 
 	uart_port_unlock_irqrestore(port, flags);
 }
@@ -1165,10 +1166,13 @@ static void s3c24xx_serial_release_dma(struct s3c24xx_uart_port *p)
 static void s3c64xx_serial_shutdown(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
+	unsigned long flags;
 
+	uart_port_lock_irqsave(port, &flags);
 	ourport->tx_enabled = 0;
 	ourport->tx_mode = 0;
 	ourport->rx_enabled = 0;
+	uart_port_unlock_irqrestore(port, flags);
 
 	free_irq(port->irq, ourport);
 
-- 
2.34.1

