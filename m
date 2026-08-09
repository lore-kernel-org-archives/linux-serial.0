Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4157F3CF670
	for <linux-serial@vger.kernel.org>; Sun,  9 Aug 2026 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786277710; cv=none; b=ivUwr9Kk24jx24ppsEgalDj8pIvkuhoVqXAkfheLVWLZCWE82aycsPvn2eykcg/eh3p+63hNgDbTyf5vEKy6VhuVSg2lHY4BAeZbxVnhFQNLfCGMawV1k9D5/JzjL/GvzIAuIMa88qVbvp9rl3f0mdd2Kgyl1e6bN3Wo/sm9mSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786277710; c=relaxed/simple;
	bh=I6mglyweQO8ryeKHCO+zp+ON2naaajVwIsB/Q6NBjwk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=lBdg3n5tJfPQRfcEu0tI+KXxI4NikHFAqfHUMAJD7pl22cZLPHLphHcaX+LtS6uNEvVbCScAvobKqCyUUhXJCYQipboAdbjZV0VgnN7p0zHvm0vjt+UupP8LO1otcEQpPcASIk4oCExo2fwbPEu0wtwqNgrkvepyhMZAeIbvq5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ovVuSSIs; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovVuSSIs"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49553515a8bso15364735e9.1
        for <linux-serial@vger.kernel.org>; Sun, 09 Aug 2026 05:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786277703; x=1786882503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rE3IjPZJHA6t5dZ+S5v5NleRepR+dFK9piV5wH4qC4U=;
        b=ovVuSSIs8CdiselHBXLerEcR8sVL8lm2ch54NUDvyB63x54k9N/QptkflX650SCCI8
         x25G3AeFGgbd18Drsj6wop3aikCa4baPx7b3g+Ko41f5V4s97aVnVTgmG2XpkYpuW61P
         EwWmo0R9IDaok5JarVKonHUUrhxfla83GEzZQdx2yf1poqi9KzoyPlHrV/zD8QVhPUS+
         T2HuFgV7NykNBRfD9dhKlW7RrrzHQYwDHSV7u2CimP6hyJU+lgKGn/gpDV/SUGnWtX+h
         SaboSnY6RbC7548sjleGpmyaQs+ZsQvcOOeWM81afG09iF4whYLtRJVzuqdLse2QV3ty
         23DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786277703; x=1786882503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rE3IjPZJHA6t5dZ+S5v5NleRepR+dFK9piV5wH4qC4U=;
        b=mRxocFqOvifUhT/h+T9OWSNrvVFLXn4dOkaIo4dtd4Sekw/98woxtNT4Lgu3xDtlWv
         PcE6H1X+eW/yIH3P1t/GH3qf6wbkqJEJm0WtFtTlilj4CL+wbjD+bOyEydHlVlB8D1k/
         OlznOhbTldU5kOysa4BUnqfb+hjZ9awI43IqLaPBxaST8e5Dt1T8PBxRxmOqPfBiJhHc
         vHI3NYzX3GpBEo25EB/eVv7L7C1Ick5jP1sT40vamSCoWyDEEXWt4UXKPqou46wI/MJL
         cQRoJukt0LEHwVuYfNJY6zoX4EFd5Q6pZjXDknLVXwDLJeeX5ZHhaSP0tpohlEWsFNM8
         BPGQ==
X-Forwarded-Encrypted: i=1; AHgh+RoX8RZiqv2ZRA/01wOLFTk4ZGM76YBRxM/wQWMSBRfsY4VpwHswgJG54l9a9nv8hwy26doAiXCQnm0oAuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsYYZF96S0Vytlo1rhSwq1ym758fyIkbHFwfYd1K5C13CKUAFX
	fNfKrMgAjB/WlNTz5LRa/NmJe8+m/KxnqBn5VaenN1eEkDRXmdRVjBQA
X-Gm-Gg: AR+sD11ExUd/wH0c5lJFdBeAmt4vndWep1VD8k0Ww6chO1BaeyYxiCuB8w0ZBdq5FOi
	KHeERa7kJTv6QIt44UvYOxbkH0N7k7V26YiN4PnaGon38tqKwM+hBm0yIXtNVu1+j0QRhh/HhrG
	d/B+aK/AvqoIFHMW+ycAcKmdIjgNGwym7Fo7MxwH0wLuDhky8mvCvyA4uZ6HKS2tfnRudfLfOqA
	VKrWi14BHqO7Z4UZB1jCodCvwETPb7y7/SCBTwmKL3K8YlsByAkJeODidcGrbD9EsEUka+JY35e
	SdFWohwk7gaLGQHuRHo6extrUgfo0+ASsfX1FaeIzzhEzXn0cWI4CudakrRVJVGDyNCxQ3vAo76
	gw6hwvRjXMb99DsYCW1ASVujsBLFuMmZ9QBtS+97Z2t1E50dU1PGTup4dKfXhPW0jPm4kbwl/VF
	/GqTK4jRae+UlUeaQV4XYDvNJb+E/x829XQU+QUaPai69W4FA5+D9/lovdXklrzQggafUYuvV++
	7WdezHmTvbYzAefLSi29rg/fA9T09M8CbI9n6SQDg7hIVRn5RbsHD7j65M=
X-Received: by 2002:a05:600c:3ba6:b0:495:779a:ed33 with SMTP id 5b1f17b1804b1-49959e0c481mr269281445e9.7.1786277703131;
        Sun, 09 Aug 2026 05:15:03 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4995ea3361esm194506475e9.15.2026.08.09.05.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 05:15:02 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>,
	John Ogness <john.ogness@linutronix.de>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	Jacques Nilo <jnilo@free.fr>,
	Rong Zhang <rongrong@oss.cipunited.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Gerhard Engleder <eg@keba.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Lubomir Rintel <lkundrak@v3.sk>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v4 0/2] serial: 8250: Add AN7581 UART support
Date: Sun,  9 Aug 2026 14:14:45 +0200
Message-ID: <20260809121449.574277-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a new version of [1] to support UART driver for
Airoha SoC.

One additional function was needed serial8250_get_baud_rate()
for the driver to work correctly for baud rate calculation.

While at it also try to clarify a long standing issue with
new UART driver when adding new ids for uart_config[].

[1] https://lore.kernel.org/all/20250209210241.2622309-1-benjamin.larsson@genexis.eu/

Changes v4:
- Add Review tag
- Add errno and types header
- Drop redundant () from comment
- Use define for get_divisor

Changes v3:
- Address review from ai bot
- Add all missing kernel headers
- Improve divisor calculation
- Fix wrong uart config table
- Simplify divisor table handling

Changes v2:
- Drop intermediate patch
- Use .set_divisor OPs
- Use div_u64 instead of / 40 for 32 bit overflow
- Drop dedicated match table and use compatible for type

Changes compared to [1]:
- Fix all formal error
- Use better compatible names
- Drop unneeded header
- Drop usage of irq (it's filled by the generic function)
- General code cleanup and reorg
- Split to patch and add the UAPI map patch

Benjamin Larsson (1):
  dt-bindings: serial: 8250: Add Airoha compatibles

Christian Marangi (1):
  serial: 8250: Add Airoha SoC UART and HSUART support

 .../devicetree/bindings/serial/8250.yaml      |   5 +
 drivers/tty/serial/8250/8250.h                |   6 +
 drivers/tty/serial/8250/8250_airoha.c         | 187 ++++++++++++++++++
 drivers/tty/serial/8250/8250_port.c           |  16 ++
 drivers/tty/serial/8250/Kconfig               |  11 ++
 drivers/tty/serial/8250/Makefile              |   1 +
 6 files changed, 226 insertions(+)
 create mode 100644 drivers/tty/serial/8250/8250_airoha.c

-- 
2.53.0

