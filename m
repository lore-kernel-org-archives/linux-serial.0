Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793407348;
	b=S20KwrKao+HrArE3rW9mPwst7gErkDCGbhJEQvcjFweWJUbl0Y6H8RKQ2kyVGifAsKb/
	 jln5iUXW6jg+J82rfiZ8NdxsWlE/S8NqwpY77MSPrM4xIGw/GbfcE/dzYK3EVgfp+Bt7o
	 K7mvLLpHClykDNOKLS2qPKtwUSlV38J1Tt6DptAjdoLdxWY5D+r4fgdCIneNn7ZxrfJjM
	 bllZC6zUCMSPBD3dDV8AftIb84XqpGQq3GtaVg9VzEab5NQIN18WxgJnQXqZfhVqPg3a+
	 wvjdlydMA56MBx7lbfqXgXRjk5wfNDU3q9RqI6fS8xQZwPAQsmfgpp3vbyQmrGSbsDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793407348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sz2NiJZ3qIKEXA71rCBDrOKHY9+zaIkwX4bCGBQ323U=;
	b=W6C3WKP4AOehj4PWM2454RnCbAOilxgyJnqoA6xrk/0ZI2T3vUkUMPYtfJ22MGM3LJUb
	 xmdZKc7X9zFT0i7lMULvKZcFU2gQQlI3VqlvINwnQed5uiKUAP7TFaETXEUMk3WmdFREQ
	 GfOnElKbDJOTRCPYtyQ8ULWLi+uZMiKkfxnc0wSikZ2Tc7OQkzwaYZ1y0oMQYJ/9OVROh
	 +0eKPMzws+N6hcx9YGBOeIo9l90u+sJkzPu2iyFtAOtdL1jo8pGcQySG5A1CVNSevOt8O
	 uaruMcDpuq4C1oXDPA/BzThWEhq93d8gvVDXSkk7KvFvlMWHuceQuLuLEhaFm4fbaDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HQVXeJRK;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05AC606A31A
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 00:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C05AC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HQVXeJRK
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35b2c599f43so500871eec.0
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 17:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793407347; x=1794012147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sz2NiJZ3qIKEXA71rCBDrOKHY9+zaIkwX4bCGBQ323U=;
        b=HQVXeJRKbHbH+PENXZA/vCBb2n2Fj8A8OXTpVl4KqYXjAGH7NmwgR/rs2vLlP5zMeQ
         zTO0FQgL3wsI0+LGyjeTt5wfgmc8U0SYkaZWc61SEYjnOsa6pid4wVYj8VdHTXYR6Eg0
         CqJkMVAPtRb1BThWTwYNdOEiPzd237Oq3ornsmLQWKzXbQ/yEP611wLzZsM1NRAd8oeQ
         UfGuMopjl0SdGxPQjVePmIBXpNgUT2Gl15O566nUHBzGIR84CdJZVCNSwbEBOcBOeX5a
         FZPimCcxZWQ987Tn4L19fBe5mGR0FeJ2dHL6FNkanrfQz70X/0hSLc3c+k6ODU3AMmwg
         L2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793407347; x=1794012147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sz2NiJZ3qIKEXA71rCBDrOKHY9+zaIkwX4bCGBQ323U=;
        b=RFTWQJVqfQLRFYhINnZTmRQwYFe3CmOeHAeEx0452v8af+kE5cG6gySndPPBqp79ve
         AgTWGwokufqXX28PkruyorGk59CqDL9i/Ge5IoTPDwXIIWck6fO2mq5EdGadb69lg1gn
         M+eFOU8pBkTlUe87Gk82H6u2tqfDpmI6rQLJ3yLkJCvRGb0hrMiaJCEuc9XguIL+CTR/
         wmH/dg3Nvl2yJYxA+HdbnlwMONAmOIIw/w8dBVHGfgt5b3BrSKG1iKei0G1JeYcXsgCm
         18JCYGGso5XM22WDsVs1uhCmNlkUQveNJ2oo+HLgbkEIpcwvlbJccd0W50AgLX/zZ6Yt
         Rb3w==
X-Forwarded-Encrypted: i=1; AKwUvByRDAftHLicunZiZ5OMHIRVChcUEVSytpYLuTzn4V9cyj0XnbamnLMsrgZTZROL2QduZ0dCCyj1q7lzo5w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhCUemA+dqvUTU4Nq3xMAvlf523dV4n4CQDv353OgGhN0vT2jf
	jUIjPuSTuvX2klWxSl+18eqykiP1PCoz7wM7HNozdVVhYJJGIOzKbjHy
X-Gm-Gg: AYBFou1bu4m1xt+Bsfy4umNs4ao9QoRfzQWHBzC/Nnfou0m7qluET3EF3kWda/zVV4M
	HmkcLb/ZGWHpRUvIs28BikktzB+eA1J1u/X7ywypsfqQ1BKs67BO1Wc/xUYR8UCDair+1RvMVWg
	f6iMp72onYAovZno+jbQrHeOYd+pu1ZoCDNZ86dnuSWGhvwyJRa/wkWnTgosRHdsUGINWjIIe7d
	h/OxqNRWe0Nzn490MWzO7ckpj2o2aiQFoK2xiGkLNPUf8u+83OzwZrAZ9vm3DhskiHgEp+JehCZ
	2jpmyk7ZFcbtM0YISdu5CDoofMQzJHB6KOFzG36TGQZhyTgLHGbNod5wQR92WkfydwMbhskAd69
	VFpp9O0l+imKU3A3Hbah/oX0F5gBzbF2vxn84hZ5NjYEkK7P0dfojKm/81idfjdhvQK++XRIzlL
	8tdkQ0/eyR78uyTW6ALCO+qtzuAdJCPtw1oYIBq2KuoXwc3Beiqf3w8XE0+/kFJd9KZMmu4yqYu
	aKw5wGUVYlkuUE2I59cAKgYWLmxpOcN2zaqaS8AfKkz7JgLt5fU329bE+viqp1veWv5kRUyRNHS
	+A7Ye4+EXXbNkH29hnS7jfnsJrEH/lzAktuMNL0P4vnpJIQXUTdkwgLXs6UcnQEBncCbZ2eezYC
	icxqU2pnUTw6z+hJGhVi14gEi4KJIa1LHLQeiWVJM9nETCc52fHMKHnJArSoEtIFfxxKCGH1m3h
	39xvBL7EWzYmUIJjB3qyZLsBpR0CBy+QsP7t8X
X-Received: by 2002:a05:693c:65d1:b0:36a:3407:26ed with SMTP id 5a478bee46e88-36a4243cd68mr5338049eec.34.1793407346852;
        Fri, 30 Oct 2026 17:42:26 -0700 (PDT)
Received: from brev-9gdpyq8lp.ap-south-1.compute.internal (ec2-3-110-210-194.ap-south-1.compute.amazonaws.com. [3.110.210.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af91bsm10889097eec.8.2026.10.30.17.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 17:42:26 -0700 (PDT)
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
Subject: [PATCH 1/2] tty: serial: samsung: pause the RX DMA channel in stop_rx
Date: Sat, 31 Oct 2026 00:42:16 +0000
Message-Id: <20261031004217.3340610-2-samarth.colleges@gmail.com>
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

In s3c24xx_serial_stop_rx(), the driver pauses dma->tx_chan before
reading the residue of the RX transfer on dma->rx_chan to determine how
many bytes have been received. Since pausing the TX channel does not
stop RX DMA, additional bytes may arrive before the RX channel is
terminated, causing them to be omitted from the data passed to the tty.
This also unnecessarily pauses an active TX transfer, which the driver
does not subsequently resume.

Pause the RX channel instead, following the existing handling in
s3c24xx_serial_rx_chars_dma() on the RX timeout path.

Fixes: b543c301c2c5 ("serial: samsung: add DMA support for RX")
Link: https://lore.kernel.org/r/20261030162334.3000737-1-samarth.colleges@gmail.com
Assisted-by: LLM
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
---
 drivers/tty/serial/samsung_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 4eeef149b..2f6c69bec 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -553,7 +553,7 @@ static void s3c24xx_serial_stop_rx(struct uart_port *port)
 		ourport->rx_enabled = 0;
 	}
 	if (dma && dma->rx_chan) {
-		dmaengine_pause(dma->tx_chan);
+		dmaengine_pause(dma->rx_chan);
 		dma_status = dmaengine_tx_status(dma->rx_chan,
 				dma->rx_cookie, &state);
 		if (dma_status == DMA_IN_PROGRESS ||
-- 
2.34.1

