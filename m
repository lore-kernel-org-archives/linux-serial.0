Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1F413CAA4
	for <linux-serial@vger.kernel.org>; Thu, 23 May 2024 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716451109; cv=none; b=PEKqHUhlyvlZL9zb/kYLETSXDqQo4W6qh9SdVi5BUzmCtCCSHBfTJ741JykNAR7opz9EEIqYlLQBn70N+RPYyEi4+/YiGqCIEUtZosgIWCfesZR3OH/0zMA22OMTup/3jOV3doVXqHPua3xqlkQ37usTryVVxOBpZojnCTXPhR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716451109; c=relaxed/simple;
	bh=pWvlBUsTahE00BJX6As7h5+KeekjrqWMB+YQjnR50/g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MDHIiT4n4hbr5ihtY9klw7wDJTMCypaV4N6bXizIntWaD04HQVBDenjOhk5HEmR4xbkWOIGd5prcMKO0SFN0UJGymw/yzsjPYe8z6KTpYYKlNE2Tvz0nSDrABTZT7eB9+86X9J4cqiGxc553fb7XOolELvHhe85Hf3ufTuNcQ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=pfhp84pK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pfhp84pK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41fd5dc0480so48991965e9.1
        for <linux-serial@vger.kernel.org>; Thu, 23 May 2024 00:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1716451106; x=1717055906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ufllGCwa6G4RtEd5vl28DPHk2z3wosI7B9qfMgMUop8=;
        b=pfhp84pKqyDiJ8h+fhVs1mXGPfuSk3Z4+Q7tqYRoTxQnVRpQSxC3DlHjcLyX8blDE3
         IblQuAjRV6PglPK6yof1Qolx/+/Vj2I0f/D324cjex+fBIN+gT/6WI6/V4IJ6Xox8Tcp
         4OMj2xNCTdO1+A0Kg+QHqMC0J7XfgLXRoE5JBvxc8IOGN0YF3Oc50sHVP7TXl1W81VHx
         ZPoqED82PAZpkUygRfdXwpgMjGzWiCIirAqOBOv/Ky6obP5haRiQXi6tRFUuvDkCvjp7
         8v8Gd+WeIxTQMv+vRxqta3NfXZWgI0zhZD5ZzNdxD3oc1uoS8yZ0uYSbxgqxz3AJrJ2W
         nUKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716451106; x=1717055906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufllGCwa6G4RtEd5vl28DPHk2z3wosI7B9qfMgMUop8=;
        b=S61oE/nLA3mXnCCXKw2jnQqrKbLlk9zhI+yVP3P4Dl2+AivaQyYwRxCkI92RIlKZOd
         am/SKaml1F81Nxfgbg3sDRUEF4PhIv7sb22CkaSod3GoGhe8l0Wec1WFCFAUSrN4oLWl
         NmZm4CLxGh3hZA34c7Hnr1J5tsnlLbtKH8Vzb2OptjEoqoJyKPgMS6OdQ7gVz0l+rQpk
         YevTZN/PfltWGeqAOXAtEfu8k9AYQlnUggMbmjBViSeqYa9SyxH3nZ0WFqOGeNSGSNvi
         5U1Fr/gW5vWvQ9h/OXB4V9HTn0CnGRfIr9WRghagrgznp9o1MTn0THClVaD7cYzULeVZ
         MFeg==
X-Forwarded-Encrypted: i=1; AJvYcCVrxaGZK9G4K8rGLLU7dl1y9Qv/ehGMUTr5eCtbKVY6gIO/7I7AGL9UfPBhHHbJQ5CJYd6FyUaCYgyfCZUua/JdeFoI2kWFqtoibzXk
X-Gm-Message-State: AOJu0YyQ+dQWhZH5Ykl/WIDDKF3xFmgzjlwRMMf5B2Q8j0FxVWOD3CJN
	VaRc49a7Ab0fr/SqjPJbSAo7gP5Bgr8YJzvuV89iZQnAdU+T04InhMYn3d6Z8cA=
X-Google-Smtp-Source: AGHT+IFxvRFLirejbb1KOGhY+jxFHdcXdR1VdijnYqXfBvsYXq1FJc2+tHan1bu4JGQuKKYxchl8nA==
X-Received: by 2002:a05:600c:3b8d:b0:418:6138:6777 with SMTP id 5b1f17b1804b1-420fd339b22mr30829365e9.31.1716451106146;
        Thu, 23 May 2024 00:58:26 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f01d7fsm17359125e9.1.2024.05.23.00.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 00:58:25 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	John Ogness <john.ogness@linutronix.de>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Thomas Richard <thomas.richard@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vibhore Vardhan <vibhore@ti.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Dhruva Gole <d-gole@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 0/5] serial: 8250: omap: Add am62 wakeup support
Date: Thu, 23 May 2024 09:58:14 +0200
Message-ID: <20240523075819.1285554-1-msp@baylibre.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

to support wakeup from Partial-IO using serial pins of mcu_uart0 and
wkup_uart0, this series adds a new pinctrl state 'wakeup' in which
specific wakeup flags are set on these pins. Partial-IO is a poweroff
state of the SoC in which only a few pingroups are partly powered.

If the user enabled wakeup from the serial port, the pinctrl state is
selected on shutdown. For another deep sleep state, which is comparable
with suspend to memory, the same pinctrl state is selected on suspend as
well.

The series is based on v6.9-rc1.

This series is part of a bigger topic to support Partial-IO on am62,
am62a and am62p. Partial-IO is a poweroff state in which some pins are
able to wakeup the SoC. In detail MCU m_can and two serial port pins can
trigger the wakeup.

These two other series are relevant for the support of Partial-IO:

 - firmware: ti_sci: Partial-IO support
 - can: m_can: Add am62 wakeup support

A test branch is available that includes all patches required to test
Partial-IO:

https://gitlab.baylibre.com/msp8/linux/-/tree/integration/am62-lp-sk-partialio/v6.9?ref_type=heads

After enabling Wake-on-LAN the system can be powered off and will enter
the Partial-IO state in which it can be woken up by activity on the
specific pins:
    ethtool -s can0 wol p
    ethtool -s can1 wol p
    poweroff

I tested these patches on am62-lp-sk.

Best,
Markus

Markus Schneider-Pargmann (5):
  dt-bindings: serial: 8250_omap: Add wakeup pinctrl state
  serial: 8250: omap: Remove unused wakeups_enabled
  serial: 8250: omap: Set wakeup capable, do not enable
  serial: 8250: omap: Support wakeup pinctrl state
  serial: 8250: omap: Set wakeup pinctrl on suspend

 .../devicetree/bindings/serial/8250_omap.yaml | 16 ++++++
 drivers/tty/serial/8250/8250_omap.c           | 56 ++++++++++++++++++-
 2 files changed, 70 insertions(+), 2 deletions(-)

-- 
2.43.0

