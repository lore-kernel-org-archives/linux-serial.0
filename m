Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620554;
	b=3VYa93kfw4hLjtOqRyyDeVZK4ZXtbf/YlQ4MMDifZ1VYYhPqXFj6bl+WyvVSa1sSMq5y
	 pZeLqZ0onnmoSQ7i74gZcEuH3n45v5cMGNDGMDZsz2bOTlOp6aG4PbZhZ/yudprhFYFM8
	 TCX45ygQ/ZDlv2Pg4Er50w/VExpByR2wSoBMLrxC0JlYWDtH/vuYwUI4EW5rIQDk8UbbP
	 c9LVKJ9lKHEryO+kv9C77mQKQI+Is7wzKvEemFd7jYTvsiTylNYo4Pv5SZEriw9pgaOrF
	 LrRAfPcmr1q9I2J3doF82ZihN8++0KjLd4Blasm40y35LouXPFFllwDJmo6j42xoeFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=vQqym24+If5ELVVFnbBoXAdZ9f94OZTCB0DYtaAU0iA=;
	b=WL6R1rF4HcUf8OR7bixp75lO6bkikJaXiT1oO2Gbhdf8FtdXAFkyO+EG5Ckeawmdo7XX
	 N5tTPdT7glxlzdSwqfC+W7UUSeei1HItqRMctQ/fmlD/gNInFdKh0NJcsdN38BGUJs/TP
	 jfW7aZRXXn2yK1BR9pbkJ8QzkxtU0luKw6DsgRuwkxl8Nq1+Ko+tbISWh+RL9F1eVJLPg
	 cabyk01Ft5IjosiDpg/UgK67PB0MDG/JUAvv0Ablgfcf9fa2g8WJgm6g+by4/NKWK4Ijf
	 JF/GLEpgGpIfuFvTsqhjzFfsN02solLPM3jsA3PtCc9Q9THDE88dffHdgUMinzi7eCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jgU9jZsO;
	arc=none smtp.remote-ip=209.85.161.50
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19CD606A31A
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 22:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F19CD606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jgU9jZsO
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-70094949641so330252eaf.0
        for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 15:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792620553; x=1793225353; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vQqym24+If5ELVVFnbBoXAdZ9f94OZTCB0DYtaAU0iA=;
        b=jgU9jZsO8tiFUvmqMoyMReQoqnUJZ2I8mJ7I/BfCRTART2gBCL+6eNQnkPSB/DEBvE
         aV41lvP3ZnQ57oCzf/kIkLjUwFvLFUiG3Qgr6AsTWgw8w8WzUFbtxhXzNAcn2J0YbtMm
         eZTuVQyrViNupw9+KiuZBWHGhodWvIFe8+fT+fAeIv3M4KyvmsIe2enAZikvKmADRVVk
         2FfCQKyAqAbJETAAVYhQg9j6epO3A3NVyGcVtWf+QGBvnLlJaD7YHhKo9+7HeHiC8S1E
         eMYq6Z27WGyUttVXgq8Ki6YK8O2GjvzE1SzMTOR1oDmUo6NMotSSJOP5e9xFY1/YTXVs
         cwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792620553; x=1793225353;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vQqym24+If5ELVVFnbBoXAdZ9f94OZTCB0DYtaAU0iA=;
        b=KNvxuQNnXLmuOOmgt+s8UjUKmGnZUivFzkO6GrGbPQoNDGRNGcJJHmDv2J+7Q3aQav
         h9sxl2I4/S+yIvm8gUL8ykYjnA81m2zV2cYRBTE6zTUNk9fM7/NxyTp7fuJCGi2to9ki
         lz7ROF0rWSqStLiKJh9ZtsgZtiqyNLASSpAdJVJEuNUvt10nhGzCjeArP10IMRxIC4J6
         179myR4mqVI++kMsj2WjlfTy8jQ7l/ao0ix7DGLyK7TeHhtFtOETlIKvsZB+H9tKBEHD
         yI3ZrNYLJOQVyCVaN5QZe40heJNOmuEpN8GYUIlqIn2+tmXtXt9cXsvr1CanNNIY5PRd
         neFg==
X-Forwarded-Encrypted: i=1; AKwUvBz4z5JMTZWyRucXce4CCEcVOcapBb5gCaEIyKbOHJq/c2RTaCAxsp4UPH7ReTyt2+q+/w7UfoctTi7cl/I=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvCgcQlVxNwmqNZUDe8wPhzGpaa5mGRuqKb0eRMqwbL/kv7iGi
	/0dzG5c7wkml2Khf36XmtVYsZZEO00XgSvyZhauehpmQPbcmmrhPIUAP6FNOaQ==
X-Gm-Gg: AYBFou0AggVkPkiYCb06MmzFVdphkBMOm1fQ207z2pU/GJMnytOeHFAxU5HNe7aivxX
	EN4+u7GZ4EWQuOa5ntcKRhxUNOgiy0YIomjZB845w4bSNXdNO8GzyHNmOOfFwUJSnX93vQfGUnW
	RF+mWtPENRBuba+VfdAdF2fZHMla9w7mqJQoPpnf6maNgqzpcHcfOU5A3+EBz01Va3za1Y/67VK
	8IdbimVTfAErlghUPRynoHl8BGEdZGnQQuRYIysSGPP6sYqUehs/n//8ShF10JlKfpmsRI2f0Qm
	0/RaEBPL7bmUIBXl2CRAfSrYuFU+zFSTLku/TRPvnV1vm1GOhWI6zrDHR0Cwm+ebo9yCvHR/b2a
	t21dQjYOMHkwgKLPYNnmsCO/CG+ZssDMw2tj+V2g7Gl67CkqMpO1Ur07If3GLrlSk56iPGyk11K
	j9zB3YnBogCXFKY527PZWDYOLEsauBKMgQ/hEpylcV967f2VmIZ3oklZUaRO1xWvHCZoUJb4FbL
	mpWAEzBRyR2UHLqgMXdqIk56NFsgblP/6QyogPIasz21A4nAWe747yIB1TXAI4TfByO0H58e6yt
	IHnMU9DmztSf+18I1zY/e+Jjou8lAWO7Oqhj/75ur4orsJu401Of9qS7vqhzYY98LY/zR1TA4pP
	pG9uYsCO/FtQBDlSI8KDdnrAS0SYbp6uwGqTEgZGHpqoiIpGYShp2rIXGVEsluLWlrJM4+2jDCo
	CvNA==
X-Received: by 2002:a4a:e90c:0:b0:6e1:d8af:6e85 with SMTP id 006d021491bc7-70a7e7eed90mr402677eaf.24.1792620552954;
        Wed, 21 Oct 2026 15:09:12 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70902ec488fsm3092410eaf.5.2026.10.21.15.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 15:09:12 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 21 Oct 2026 16:09:08 -0600
Subject: [PATCH] serial: 8250: account for partial receive DMA delivery to
 TTY
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-submit-serial-8250-dma-rx-accounting-v1-v1-1-c11795914ab4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2OSw7CMAwFr1JljUUTAQKugljkY1ojmtLEqYKq3
 p0EuvBinux5XkTEQBjFtVlEwJkijb6A3DXC9tp3COQKC9Wqk2yVhJjMQAz1TL/grI4tuEFDyKC
 tHZNn8h3MEg5SKXuRDp1BUWzvgA/Kv6bb/c9F9UTLVV83jI4IJmhv+xoxf/ZlwGPmTRBwSuVD3
 izr+gVtIzLrvwAAAA==
X-Change-ID: 20261021-submit-serial-8250-dma-rx-accounting-v1-4122c91dedbe
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

tty_insert_flip_string() can accept fewer bytes than requested when the
flip buffer cannot grow. The DMA receive path advances past the entire
range regardless, but does not record that some bytes were dropped.

Increment buf_overrun on a short insertion, as the PIO receive path
does for a failed character insertion. Keep rx accounting for bytes
received from hardware and do not retry data after the DMA buffer has
been released.

Fixes: 9ee4b83e51f7 ("serial: 8250: Add support for dmaengine")
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 1da605cc8601..46fe4ebbf451 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -57,7 +57,8 @@ static void __dma_rx_complete(struct uart_8250_port *p)
 
 	count = dma->rx_size - state.residue;
 
-	tty_insert_flip_string(tty_port, dma->rx_buf, count);
+	if (tty_insert_flip_string(tty_port, dma->rx_buf, count) != count)
+		p->port.icount.buf_overrun++;
 	p->port.icount.rx += count;
 	dma->rx_running = 0;
 

---
base-commit: 1184f87e2790e8af9be3116f608d2e86b4792d7d
change-id: 20261021-submit-serial-8250-dma-rx-accounting-v1-4122c91dedbe

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

