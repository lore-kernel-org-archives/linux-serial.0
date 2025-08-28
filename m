Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817293115AD
	for <linux-serial@vger.kernel.org>; Thu, 28 Aug 2025 13:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386926; cv=none; b=uEH3GLrnoUWo2/qW3bYPcDjcQqw7K6fiSldCvBPBIimt1mKxz/MGQ3mvP7AkSFvOXayk8mjNxHg/BSQhorcYoXUfwsYhoT6UiZ8T6ftjEKcrWpkwQadwxDmAAuWqHKT6XBAqqjYUHeGW1qUUMNsnMBcukQi0xDvIOFxxUo2AH1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386926; c=relaxed/simple;
	bh=ZoIUG0DIhl93kANAYC/KTgnrxzk10nq584qp1jORNOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YY/fa/d34kVvr/8AekOKVIs0HEq1awFOCtmcUlr0INsKRvI64BFmOr8ggpg+BGdTcpVwhKizaN0uRbV/p7kjDuSN1ugBGVDzCkA873Qfjnh/ORE9KQTgvINF5xXB2auGPA+qcPrXOS01liTOpeeRC/tqQ2a9zbSE9ZE3xxOAINU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UDxeT+q/; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UDxeT+q/"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afebe21a1c0so143301066b.1
        for <linux-serial@vger.kernel.org>; Thu, 28 Aug 2025 06:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756386923; x=1756991723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UuiNHpICi9Fji/fQ9rrN9zvOKJszsHimGcUCBamZ0/A=;
        b=UDxeT+q/XzByfuzaddUNdzlWksMM2SSrbqSy9niuu71+kfILDKdcbKUx+v1X22aThW
         DDYQyxyViQBz3+72P3iA7wGVe9+JlkmQPiuArYkQWqF6Yj6CZ5w6v7hCAHAUdAEky7SH
         407h3p0WrV1xl8IO9SGnYbiS0NWb2N1zf+L8ZBpDrG6zVbM6QW/y8fEgctfX9dV1S+dW
         5yJF+rmTXh8GL/KPkkRCBWfTsa4mLlz15EA6MCznMf8/fjyXjcDKx4Cnxf3QEGbXURGi
         wv5kLD/sZAsQfdtD7t6B+/5YayCAsvOY1PzlJv/sRkWr1QziXkAuKYt/7fIuyZ+7sgcy
         46cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756386923; x=1756991723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UuiNHpICi9Fji/fQ9rrN9zvOKJszsHimGcUCBamZ0/A=;
        b=nveSIW1Y3UEPzsaJnUfmJoJaxiejctr7HKUmtSbK9ndkIP33o09op2H91DX4G8k/m8
         hYRC+sbBOtcpFXYJuCHIaVxCNnWr4HtuexYFosdZvFM2Fhd7vpHX7ilypHfJsN6edjwk
         0iAgr1AEzSpFHfgTyEqGtOQx1II01wUNO4nw0nnXBQst6eMuPGfslx5kw210BaHbGU5e
         S6alc/SgWVXzkMiN3HzVFj8CdkggIyju51Vz7uvpmqHbXbmgDoMn+Q7vTYG/Ux3v6tdQ
         Im/7JSRb5bxM3jBnst6GHfcfDzsQb/vxMpUb2KmAS/zV8h+Tkb02sPzBsc0O7rhe1b5x
         jRhg==
X-Forwarded-Encrypted: i=1; AJvYcCX75hknRAekOFzsvrCkM2BkX07AZH73SlvSo348YIM+ewDc14MxYUKxQQJcgIRmY0FIeQGHkh1UqLWEO50=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFLGmfinwi4/WcejA1ztYtkOJDKUnVXo/VvUFWHz8Va5vHTBt3
	boe/rSSxMtZLRMu8jkJTBi6WLfYKIevMcq+kwcRg+rfWPorvnuzWgZk+pmRDA0Sdk6E=
X-Gm-Gg: ASbGncsp7NhCxMvkAFqVflYRENhdH1T10UNA42RRP8r7eTAWMjI04z7rAP6YVXAfha9
	KUeR2ktKt1pwDXHe37LMLlZSXPuktKfcMDZbvTrKthBuN5e7eNi3kKRGqFo0lP/7ic5VHV6Thsw
	Hoy1chQHtqE5bHIFy6OK0B3zxJZNjxchHZuVza0+anZR3kQ9BymVHKxuM/wZINT/Ukk+E0yeMc2
	ojZLLco4ewfBQZAFO6pixprc39UexQzTDrfrwWeDGJ3lvG0DCqx/oH1j4YNbawYi3wsaj4VPffO
	T+EtQUSBujy/mgWzvn9w545wEG2ubMM+oWL5VOi/dLkJVlQJi9rKE2IjanKXOLaejzlwg9B8+iS
	pfAQGjm5OoxdYF7C6TLhwF9eT49itxmC+YAnnWQBO16GGHMSFNxuIrDrzUJCTu4EXkBDgDG+cSh
	dGjAFvSPYw11kJ+oPdab9Bba6WJFM=
X-Google-Smtp-Source: AGHT+IFlRXZ8/HbEmILGPaaFC7SuIScItZJp+ONwofS1lsM9bJRSD1VLJx+ZjAEGaQZGAUqEEvUm5A==
X-Received: by 2002:a17:907:2d0d:b0:afe:a615:39ef with SMTP id a640c23a62f3a-afea6154a04mr947914466b.9.1756386922803;
        Thu, 28 Aug 2025 06:15:22 -0700 (PDT)
Received: from localhost (host-79-36-0-44.retail.telecomitalia.it. [79.36.0.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe7fd59b00sm872678766b.106.2025.08.28.06.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 06:15:22 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: linus.walleij@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	wahrenst@gmx.net,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	linux-mmc@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 0/5] Add peripheral nodes to RaspberryPi 5 DT
Date: Thu, 28 Aug 2025 15:17:09 +0200
Message-ID: <cover.1756386531.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The following patches add a few peripheral DT nodes and related pin/gpio
nodes for Raspberry Pi 5.

- Patch 1: Amend the bindings to avoid DT compiler warnings.

- Patch 2: Adds core pinctrl nodes and defines SD pins as a first appliance
  for the pinctrl.  

- Patch 3: Wires the gpio-key for power button and related gpio controller.

- Patch 4: Adds DT node for WiFi.

- Patch 5: Adds Bluetooth DT node.

All comments and suggestions are welcome!

Happy hacking!
Ivan and Andrea


CHANGES in V2:

--- DTS ---

- bcm2712.dtsi: added a proper clocks node to the uarta serial
  in order to replace the legacy clock-frequency property. As
  a result, the following patch from the previous patchset
  has been dropped since it's now useless:

  "dt-bindings: serial: Add clock-frequency property as an alternative to clocks"


Andrea della Porta (1):
  dt-bindings: mmc: Add support for capabilities to Broadcom SDHCI
    controller

Ivan T. Ivanov (4):
  arm64: dts: broadcom: bcm2712: Add pin controller nodes
  arm64: dts: broadcom: bcm2712: Add one more GPIO node
  arm64: dts: broadcom: bcm2712: Add second SDHCI controller node
  arm64: dts: broadcom: bcm2712: Add UARTA controller node

 .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |   2 +-
 .../dts/broadcom/bcm2712-rpi-5-b-ovl-rp1.dts  | 133 ++++++++++++++++++
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     |  55 ++++++++
 3 files changed, 189 insertions(+), 1 deletion(-)

-- 
2.35.3

