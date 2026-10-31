Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793407345;
	b=CbxJT3ccLwejhlIYE6VrpNmtCXD9WkytS2kJAepdEEHdm+I1eerNW+TbvdPS4BrU2U0I
	 sCpDt/xpA3wzKiiN41Wf+rR3CLobImIM6K0/HT6fHrU8rPCC2cduLHV7ySvFG+30DRn/C
	 2mT43uVWEgSnTQgUQHsE6hjrGgymNL6HsH1H/hOPMMgeNft3TTThJ8W5JOi4m2J7KriQT
	 BAXyJaT1zRqaoRCKk53192NA7YPO4lgYJHEQMynVNs6G+UizzaWw3vXal1UpChW6zFUvk
	 KKS5qRon02N0/TIeYbG+tvEb7ejHucoZg4/k5zaP+M6vetSt9fXAFOkI0r33FLR1CzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793407345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6Zn8ogGo3EJrK8xLaTC29uAmsx2DQ8Ou6DfNANGyHlM=;
	b=GdP0+Zr5MfjqVWgKFZiWcr0NLCxrmJk3IXt0VVKE5c0lrDJRzTgrNQE40OzGVUAcYhg0
	 ieKV64rzpdqw/rkGOPy9+tCPvgS6Bn7zCbtHxyPkpuWY4RnnQzbT4omOiWHqkv+SyqF8G
	 xPu4097tMW7RiNzqXBuHlQsShORwCvdB+K6JUBWywdzZeKdcsGBt6vgFn60yQrJvbyao/
	 9Ka/A49lunCCTqZYU5Gx53sDv9ypDa21/p3JudN282B2KReUX0AC0CIiur1jQsSNzw0vj
	 FAf7F3ubZL7ait7QHKHz3W5Mzy7z3NXKq0Pw3/69dBKjIjRAM4QNPP1h8ccda6cqrKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lDJUF5HR;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22176606A31A
	for <linux-serial@vger.kernel.org>; Sat, 31 Oct 2026 00:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22176606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lDJUF5HR
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36a1947498bso645149eec.1
        for <linux-serial@vger.kernel.org>; Fri, 30 Oct 2026 17:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793407343; x=1794012143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Zn8ogGo3EJrK8xLaTC29uAmsx2DQ8Ou6DfNANGyHlM=;
        b=lDJUF5HRQrNGcGOXShA4FcSRi6t1g5cq5qrr1V+hZFuwmkwlPaj+mOE/Ralxw5ujyJ
         pWsIo6F0SoXvQwSAmz+VCM0sGfwVkNC0T0KLZyJaBNXjhKSuo8zSDB+LDHEl3EG/z/7G
         kBV1LFgN91+PpAJCRmiHSMZkGKXEr+fa5coR+8qZ//C/OfWDLeh6Ng9kjqZcVAhLoCmt
         BaPOfmYO/OITGkli8NkfGVe2wjPfPEtL8+OP4x5emUc/Q6ZFkiIQeHdv8gGmJtQa2oEU
         xaJPd4gX65hxJUIok73Kl96O77GeK5XpwUlxhKFUiCcna6Gk9J4e+pUjp7qN/7+Aa5Y4
         CqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793407343; x=1794012143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Zn8ogGo3EJrK8xLaTC29uAmsx2DQ8Ou6DfNANGyHlM=;
        b=QHYDHgtqusOdnYYvth5A9Usz5iCQ6OuCPsZrFOzXtFk+xa4x5oFj2MDRcnzis5wqrF
         fczzR4tO9pqn7nTERKUQPCRJWZJSjz2KYC/oNVpeVE2m2OUz+4DV/HUACqTLZxhf4n1a
         Yy2qMTRELBrOyc8PamBDpGfpl6TSFQ5lEGZdiWvv2X2PY0f5s03qRPwCVIQ2s0BG2yuR
         mAnWVExFHoDag9MIYQoTvupLeoHFF8FUozmdS6fYhefy41fknOteoGc1VanoUuVyA/df
         vq8nC11dBKsfU1GSoAx+5bURMF+lnNdDXRcClCCiOMbz02iGSCyGItC3ZRxbwr9TauMr
         AP0Q==
X-Forwarded-Encrypted: i=1; AKwUvBzFuLRIfT/zZOK//ysZouYcprxdblpyQ2R1XTYpi+HLgTXkyK927HDscruPfTZBLhc5mvJjPZig+fbSTOQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJ4ylfW9CPDO7oo4kfSMQxAlc2L96O+XypkEylWtHipo9MG48m
	Dwsg/q8hzQy1xJf4jpU7srMAxfNCp42pNytyYtTYxJsBpl0evIwo/BJ6
X-Gm-Gg: AYBFou1E02opyAfxGoF3ia+pAKtyWA0DQC/WgGmeKu2kzkFIWLe0jVqoif65EBNicHy
	X1r4bdci3QZ3xpIBiY6k2dG0Ik3SjYMEjsmoV0H6bPyLaraJ0RRZTWGdYi2hVmZYzBwShlLrpVR
	ZMrVKUuxUvCe2BTbKPMvq/alb/GxTw3cpKMrpYuni10eM6ckdxEFAKU0THOe41tl+3dp9x1Huyh
	uRPg72XD0YE9RK6D58Sl3XKy9PWA0spzHKJSMyjIcfzcz/ZVtiSN8MeWXtePNcUioT4WmPjjEaW
	4QeKU5rt6LMlwDHfMp+f3vXunDy6S2fZY6yp3PTsEw+9XK1Cu4Y0QH8TGT/KoJLJkW4omy5ABri
	LtjT+J+2ervHZFr+yKuQsvscnSWUZbpXrprFBptN1WptN/oXdzzw8XCHr5WpIrUfqA4wOOHBD3p
	f0bsN4Aztr3cE80w+IO7BIXNAIG7aJjNhNHkGSi9M4QEl1x/HlNzospE5vV85imW9YSNs9RUrD2
	YqkL4B2UoxTCMkq7r8eAsaOroySKqNJX5LSQhL40dsD0k/4rPWmXxn6ULsEAtwNmcGE7/YfrmZs
	GSGjEYXWgW006rDym7iesTGASfvLsPJvQe+GSLtUuFUFsIjxEZIyIPCh7Ox7xCg6LxFJEU3LtOD
	0j9foOHkclLBgKwn73buMORiPpReWMzDE3L4WmGIeyDzvDF1G58wNpWcV8/wOClLHvh/nX6R3/i
	YjgVdph/FH1WbEdn+E
X-Received: by 2002:a05:693c:83cf:10b0:36a:1427:3933 with SMTP id 5a478bee46e88-36a4236e7bemr6281218eec.16.1793407342986;
        Fri, 30 Oct 2026 17:42:22 -0700 (PDT)
Received: from brev-9gdpyq8lp.ap-south-1.compute.internal (ec2-3-110-210-194.ap-south-1.compute.amazonaws.com. [3.110.210.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af91bsm10889097eec.8.2026.10.30.17.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 17:42:22 -0700 (PDT)
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
Subject: [PATCH 0/2] tty: serial: samsung: RX DMA fixes in stop_rx and the RX completion
Date: Sat, 31 Oct 2026 00:42:15 +0000
Message-Id: <20261031004217.3340610-1-samarth.colleges@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This series addresses two RX DMA issues previously raised under the
release_dma patch [1] and subsequently confirmed by Marek Szyprowski.

The first fixes s3c24xx_serial_stop_rx(), which incorrectly pauses the
TX channel instead of the RX channel before reading the RX residue. The
second prevents s3c24xx_serial_rx_dma_complete() from re-arming RX DMA
after reception has been stopped or during shutdown, which could
otherwise start a new transfer after the channel has been terminated.

The series applies on top of [1] and has only been compile-tested with
arm64 defconfig and W=1, with no new warnings. It has not been tested on
hardware.

[1] https://lore.kernel.org/r/20261030162334.3000737-1-samarth.colleges@gmail.com

Samarth Narang (2):
  tty: serial: samsung: pause the RX DMA channel in stop_rx
  tty: serial: samsung: do not re-arm RX DMA once RX has been stopped

 drivers/tty/serial/samsung_tty.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)


base-commit: 83f32c773255720a661aa45d83e36278135f23f5
prerequisite-patch-id: cfa1c1db9d23de3ae1cc6f0476a8ac611d09c7a8
-- 
2.34.1

