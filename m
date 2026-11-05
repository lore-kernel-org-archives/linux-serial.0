Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911944;
	b=T6tkWJ5LG4Plf/2V7iuf8S5RXXaG0qzRQ13jL7P76Q6IeIjKw+k6jUrD8J1fvW/7jyvY
	 BhR5akteIL1WqzAg4XXiH7u8vzjwnlvJIuubnVRoPVqcpR2I83KnWdjfuQPWGdnZ7lYLK
	 nI2dcvtT/c44cN3PcugtzNx6g+EShUKU8tp736oZ4agtJlqlInj4kWOn75PGrblzVAMSU
	 SHStKvN2oFGmPTgYFQI/dC50WVXxlbkOlWd3Irt/wtQtfhvdRXRvG07miJT6xh7plRFzm
	 +wCUifF4/uFOpwUwAAMmFEWxvIiDHOcrIEhsNkby6hL2x+ue88fIzvreRdXhu3Tx3qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=9v6fhE64vJST/e4wIKc/qZZ4G1qcfWVja1/2g7y5JFA=;
	b=FUOjRfjyLGBILMcK4ePw+luYQbsx9cj4w29a4Wo8dw6NvVMbOZMzi3k+jxy8fyLVUrSI
	 z4k5AG07yygEL00nJGpAaqmazmmJrkD6P0ZvbFwJwgTwmWMMxOLsI7EO9hcMXctQDfc0P
	 ugl5q59xG55BXsgOxs6JPB5wpegm9j1OOhBoXzaEPzTmxmAo8pPeno2lHx0jqO32MjcuE
	 kYORIZ484dDW4D+XDj7uQXZGy9Pqqep9M30ukOaUifL8W9qLENEHCq68i25sZTPRh0xys
	 ZaBqHGRs6HMq7c18D5rQ+1gCh3iVXNVQmJMb9qECpT382f9Zxa0UEueEzc4ytgJ4DPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="x1/1PkbX";
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7F3606D81B
	for <linux-serial@vger.kernel.org>; Thu,  5 Nov 2026 20:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A7F3606D81B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x1/1PkbX
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-716d052dc23so4891eaf.1
        for <linux-serial@vger.kernel.org>; Thu, 05 Nov 2026 12:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911942; x=1794516742; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9v6fhE64vJST/e4wIKc/qZZ4G1qcfWVja1/2g7y5JFA=;
        b=x1/1PkbXEl/xKNPfpHRZjkItcLdgBOL+Mw1jDWTDrVr7UMokvg6+rz9Cy+eHHuHq1l
         4Jc7U8Gpxwd7lpPLTvVtM6tEbTYgAFClce8IrSCJBlmajP8uEcPPbmdiEaWFO0rctCSV
         F94/vc0VbpMw3fUoU5AoEZGtt18WMNIjKSMltoaTx/5Gis1Rr3wllgJqQYWGId81Syrh
         1MRY0jqeq2Qz8EUZOB9TYWyPyZNtDbLpHKedSzNUABMkAxhJMHUNi3I6Fa87OXbIXRbm
         A2mwv8EY4Mlx5rwpTzf8A2M2gTMdYdzkAtq5/32Mh/cnIwsiOPUwtyWyWHL39R9T4nzZ
         1ROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911942; x=1794516742;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9v6fhE64vJST/e4wIKc/qZZ4G1qcfWVja1/2g7y5JFA=;
        b=jGVQS1LG4NPpOkyqoG1lKkKm2dieoyrw9feuf22HiO19lMAFXl8cwO4wDfqoPJG+Z/
         S8fGaMVuONBGjFKDqMWIfYN1LROz2n/Px01ef6xfQ+jB5zaaeJor4hPeAEorgY+jXQYi
         vFmxsri5YE1PA6m6RE3KdPPiyRY4Vh0LcpdLQLRh8Fju8VN8p12AjlvIsCVqi2qT8iho
         gGZUKc116FaTHK2dw++mGOX3sO023x/s2TbX7EM9kvd0M+rMni8As7exLxPWyCTJbsg9
         9UQk+VY3lViQqCGa94HQ7KqQcwJo+rQWhfom6Km7ymqVxSZJHJRcqGHMZ9jG//p4mcS/
         lYZA==
X-Forwarded-Encrypted: i=1; AKwUvBxAiRnBk5wvCiX9tbhLbiSKT9h+yKCMqG31Sm3OHMCKIcxeuSqXa78cDM7HMLs0+v6RHCO033v6e/V8nkA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/iWZ/rdOEmTtc830kBkx5Qy85YP0sLox1YZnxOI6r4RiSqkaoX
	bif4CC7LOsgjnv51OEbREgbyarvkDDRItLHq85E2Zgf6aHWE9gy9G1rP
X-Gm-Gg: AYBFou1oknbiRbVsqW7/CfF9QwIjR0VAJ5f7DHEQXf1AnVR3xTp3z2QLfi9WEFLurba
	rN7xPQW7KTGB1gBFenTFtZa46uJ3t7Tq3jEN8rINGj3UyKtBdKDcst+uvUzCNwdBrbsbqUUHJ6M
	mK5TieDEFLzeMd3SVZxbe1ljvFX3QSr0H3NWSWLrdg2QKa3Eto2MV9nFjKjga2GSy5WR5K+eYmM
	bg3hMe9MQiVlpED7y0u+JVUR/VXxn+qD+I/JYy4rZBDd8o69j2mepcIRKFzJkUMY3BUv4PQlSJR
	6+CrP9osocINWKZExZmmsBF8GKxpp81jScRoQTfHi8InYGurdQTgv2oenQAAmTTUCphST8WBKlq
	ooRvM7TRYj+l/UC/5mYP7LJAr84oIM+0mMyfb9ZMo7kIGrCKMRWYs8EDDmpInlkehEu78gwpjaw
	t28oQQ4QmY4/o8e8tQCxUvz9gRtTQ1UHHW1+LlImlRVkJvxgn1Ow/+azJNPIUydPxQ8sE4Dk93d
	R1C3hVHBLQ8YfQot7+WQ2GMCRbgs1xA1Yau20C3t6ZBHHGUyj3Ql/lPVsiemZC5tkREPi6c6Pnd
	EE0bkcgZQNzkxX4pyNm3oKvPzIpd0uVrdOknggziKvBQn2VV3N+W4RCeWkIRN2MgGFbl7A6IblV
	UzZDIf9j4CNXTSMXrGH1gpLYeuFRr9vgOk8G6A/jUaZC63IBT5p3vXgPRyZ8vBtyw1IwUmzett9
	FFYHoAV4zHgc/eVia1AMmFTm6n1TWuGkYnbtsHbwVooChrrMP8rrY=
X-Received: by 2002:a05:6820:1354:b0:6f9:59ee:cf9a with SMTP id 006d021491bc7-716e73d88b9mr513073eaf.7.1793911942466;
        Thu, 05 Nov 2026 12:52:22 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f1dbb298fsm292276a34.6.2026.11.05.12.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:52:21 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 05 Nov 2026 13:52:06 -0700
Subject: [PATCH v8 05/11] serial: 8250: expose RX trigger controls for
 custom callbacks
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
Message-Id: <20261105-submit-h616-uart-fifo-v1-v8-5-14024d2b184b@gmail.com>
References: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
In-Reply-To: <20261105-submit-h616-uart-fifo-v1-v8-0-14024d2b184b@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The rx_trig_bytes attribute dispatches to a port's get_rxtrig and
set_rxtrig callbacks when present, but the attribute group is registered
only when the port type has a static receive-trigger table.

Allow a port that supplies both callbacks to expose the attribute without
a static table. This lets integrations such as Octeon provide their
FIFO-relative thresholds through callbacks while retaining their existing
port type. Require both callbacks because the attribute is read/write;
ports with a static table continue to use the existing fallback handlers.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/tty/serial/8250/8250_port.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 73bc9e7ab703..d87e2b852c3c 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3152,7 +3152,8 @@ static void register_dev_spec_attr_grp(struct uart_8250_port *up)
 {
 	const struct serial8250_config *conf_type = &uart_config[up->port.type];
 
-	if (conf_type->rxtrig_bytes[0])
+	if (conf_type->rxtrig_bytes[0] ||
+	    (up->port.get_rxtrig && up->port.set_rxtrig))
 		up->port.attr_group = &serial8250_dev_attr_group;
 }
 

-- 
2.53.0

