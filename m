Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721115;
	b=TSKZxbmQVs+U/JistQzEsR1KJdkB6snRj2YEgCoOPpEsVOf/CJW3mja2UJAULCdnCkPK
	 6id9PEgmBVOHSOdsZWsnC5WUJg2CxSd/FZVAVmkM3y3QmGk90jlQ2ON4jDXxSqUMIQF91
	 akarZL6pjQW6ETE42D3AA8/UQiuQteWoMVci3goQdUc9EArx7439qU6Ir1bU9oumsNcUm
	 QZnOtNvCK9vr6+S1Ncw5jnlhqKsaz7v6cn6jfgZ/mOGUFA3wqrQM6kqiM8s4sRQFlnczo
	 oP9vaIRsNLgxDF0UXw32dNX/78HAhuxb0PfmDMRoOoI2sEcxzmJoUS642fu35xwvJQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ElunOHsCbJmsk6qqG837NqX15fcbk0oSvq6+bth2r9U=;
	b=fWIJuraZYPBGl2o8/epxuygVoe4s7IRva8fpjWxis56j8Nbr7qQzgyV5mqOWP9EL6XuR
	 IZBbqb8a/ndrUn2iPtnCWwNkojobohZZeinhh/CHzQXYr5Sj3WODV6XUBTBcyEcH0ESQS
	 mBQmTvnUdTzOYpg3CZIlgWXip6H5qdW5A9FHHENFh9gDXlxWA1EvjW5eMV7ErvshGKqCU
	 XK+4OrtGjaGCZ70DZ6b6u12r5qZXezDjmbuKMqFq9fwK2+BfynnP2pC4hxPEhcVEUTni0
	 WlthvJuLpgvBzW3xGDSwQ/Mp3WdrR2xifthYsVSpSgcHth1ci9/mjUh1REhh7YxRQ6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=my3X4+Tt;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEFE606A324
	for <linux-serial@vger.kernel.org>; Tue,  3 Nov 2026 15:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CEFE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=my3X4+Tt
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso35524085e9.1
        for <linux-serial@vger.kernel.org>; Tue, 03 Nov 2026 07:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793721114; x=1794325914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ElunOHsCbJmsk6qqG837NqX15fcbk0oSvq6+bth2r9U=;
        b=my3X4+TtDs+etsFJM0QPWkM4NeYyEbNHjCYNtWnJnUlBuQxi682Nl2lnTjOA35mrQX
         6HNYFaYg86KIh3nnQvpw26zuJthu/MISqFjldM19hSY0VLKfqwuf2ufqr4zQhNVg7rQ2
         hDb7buElKYxoOVIZS3F9b2fPTL2VWXGMVgoywQj0oBxKqThU5l9JzjL8UtUAZDAR4uUP
         Y58h8Pik/FZqlPNcB4czEP8KwWH2a+O9XNbZA5xMo8esnijDlqYhV53efebJ44um84pC
         tlI7Sy15vS6QsqlhNMEeoBm3SP1ogWRZxV0Z34LENUdZGvBsxYhDD+1w+aLjHyP3sbSA
         0pcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793721114; x=1794325914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ElunOHsCbJmsk6qqG837NqX15fcbk0oSvq6+bth2r9U=;
        b=BXebJ2I+9jVSUoNfhdVNhb4mUJiT57ibXM3xWogX/o89Qzoanxg6MiFKWmIJ7MJcT4
         ZMvOwMRexYJLhQ2WWUTOQVviSkItAdQKXlVLDt9GShgInalpH70/zUR28jWB5ylNPOgL
         4QvWglYsafr/PGHTdzz671UoYwn5VX1RyT3pUNG/1m0uQtGXZxICkK5BI+DpPju1FuZO
         L/b5DeWz+vhxnACq2rzx7d9/bx+FsHkfg1asbRXhUcnp3tKt/wiM/9kAeH7S1TFbzjpi
         1gUdaCov7LmUUGuvaablDeEQvz2/VrlNHBRVcRFbOqdpGzTDdh8DYSyOlCcr5Bo5uLPa
         si1g==
X-Forwarded-Encrypted: i=1; AKwUvBxXx5EBfV4Rfllf7jQ+UEh9TTYMq8rFUF78y6EoqkAWzWVQrJhu2oWzYalvmCACHWvIeH27z4hjp7ZZfkc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nKZzr8T5At3pkTRxz8jmjwseVYWbE0y9he7nwMermwJFJgGOL
	EE8wyQweK3skRxVANB2Le/IGFlvRyWaj4NI7Zjjl5XegI9R5Kq6OCWy9
X-Gm-Gg: AYBFou1mc3953DP+USMbKDEQYPkepjdcDwAKTLRoTzrqtX0aV0RFHkAh8bKiXeYEbj2
	/cAV1HBYuiMsVLbkdL7SQV7PzaAV2JpLwCLqrFkS5A8JgmOU+yMjAUB4MPXqi/NhfmQ0LjNZBw/
	WlPbNkD7cxP84/gK6AS1fqjeuI1BhGFDN4E5U7R2ikCJV+4+hvJJT2827LS0RshhHndVn5aimez
	a1H5tf4iBoaugYK4Gzn88ajmnMRGlsKYGfxkBjNeZWXa20Vh2lgQpI4yINhAaKT9uxBxAh2V4au
	+caIaxW+tsJbdI9ZESK/y5hRYkX+A1X5a/2ig6X6I7qDdv05iCx1zo3j5eQoHs9jBQ/Ov4KJBdy
	kniwGoFVTeofOU5aIe6Hpw4bYwkjQqnswTF9DHKzX3EUqBvPTsrCK7mvtT+ZL7uNkXqhMTVImkt
	qi8cs4/CoMBUQd0Mqe84010fv7XRr5L3sAZP4Q74wRJcoaPaTlRQ8SWPOH4Kj43Zcdn6i7Akl/S
	4WW0HJhEoMcF81iGE/RO+1s/3MePyRe1gnm7gmq+6syAWln6Px30T+hhCmPFMwis2ccYslnbdDW
	Y8eFs5Pjg7tG5txKyWevKxrcE5LzjKMvACzB1Flj7/brE/tIQk8ZcfVNHSxuAQgzAOlpNaHmSFI
	DB45dXJLKsTCyp4MP4PuWKul9m3POHMrgXX81GWX3hjKNak9GBVrw
X-Received: by 2002:a05:600c:46ce:b0:4a1:f625:2108 with SMTP id 5b1f17b1804b1-4ac18a88820mr316895325e9.33.1793721113383;
        Tue, 03 Nov 2026 07:51:53 -0800 (PST)
Received: from Lord-Beerus.station ([93.66.71.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b964desm25680750f8f.46.2026.11.03.07.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:51:52 -0800 (PST)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luan.r@variscite.com,
	alifer.m@variscite.com,
	pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Shitalkumar Gandhi <shital.gandhi45@gmail.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Johan Hovold <johan@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	John Ogness <john.ogness@linutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Fugang Duan <fugang.duan@nxp.com>
Subject: [PATCH v1 0/3] serial: Support driver-selected TTY wakeup defaults
Date: Tue,  3 Nov 2026 16:51:24 +0100
Message-ID: <cover.1793719239.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
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

The initial goal was to enable TTY wakeup by default on NXP LPUART ports
marked with wakeup-source, without requiring a userspace write. Instead
of keeping this entirely within fsl_lpuart, this series introduces a
common serial core mechanism that other UART drivers can also adopt.

The new tty_wakeup_default field in struct uart_port lets a driver request
wakeup to be enabled when its TTY device is registered. Each driver
decides whether to use it. This series adds wakeup-source to the LPUART
binding and makes fsl_lpuart the first user, setting the field from that
property. Other drivers retain their existing behavior, userspace can
still change power/wakeup, and serdev wakeup policy is unchanged.

Tested on a Variscite VAR-SOM-MX93 with a Symphony carrier board using
LPUART1 (ttyLP0) as the console: with wakeup-source present, power/wakeup
was enabled after boot, and the board resumed from deep suspend when
Enter was pressed on the serial console.

Stefano Radaelli (3):
  dt-bindings: serial: fsl-lpuart: Allow wakeup-source
  serial: core: Allow drivers to enable TTY wakeup at registration
  serial: fsl_lpuart: Enable TTY wakeup for wakeup-source ports

 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 2 ++
 drivers/tty/serial/fsl_lpuart.c                          | 1 +
 drivers/tty/serial/serial_core.c                         | 8 ++++++++
 include/linux/serial_core.h                              | 1 +
 4 files changed, 12 insertions(+)


base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
-- 
2.47.3

