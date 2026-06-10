Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145243D88E5
	for <linux-serial@vger.kernel.org>; Wed, 10 Jun 2026 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781090935; cv=none; b=oAUTHkglUL68TP7eHsI2K8jUz0u31yRy1k9XosmCU0aIulItL8YsF5ZHiLXj3qbqm8Mv2kzlcPDdK0gfRaXVMXxp+V4XNVHfU7//iKDL6deJVuCD2KSIZ/a6oNHS1R6pvrulyWs4GKnnqdOodzquEr1gt/S9Q+gVsaYf/iWUMzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781090935; c=relaxed/simple;
	bh=CQocN7n6EL1m7QmHcuY9oAbnmAD3Rs3OWnENrXQGuEc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ToOUCa2peHmOpCWOuqjp34zlepVLiQKPiPn3/FhrHwAwu7R08STvUBFQs9BJjoY2e4i8qe03RIJEzgmfDEz54FS3DEeZmScr1SEyszfw5A1S5OMIH2mqguk5OzhdJmHczXEcmkQ+/iLDzoaW83G8jWnt0gYZ28LQfJMZB4do8G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cECNW5yM; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cECNW5yM"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36d630c0e35so7168393a91.3
        for <linux-serial@vger.kernel.org>; Wed, 10 Jun 2026 04:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781090932; x=1781695732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f7CoPC71NMmToN6IqHyZ2J7Av/IeasabCIzNKilALHc=;
        b=cECNW5yMf7yavulApIaQCZjJKbLYbSoWGlAGhfFOK7qYKe3Pq1ezpN/2NBiMpaCkiy
         F+GTfxC63JaqyoqmMLqc+7LQV30DRgyIaM6bo2AB4Fx6tYKXymK0k2SiU2p0B6LtI/RS
         QtMhFFW4YdFx158MAa8mCY1xuMF2PkDv0qNg3yyywpfhJCWA/F/rOKsQpeduy7lGe2f2
         FVmInokNalp/O9MmrNsk0wDnS2cGhkZUfKrJZDb47jg+XnjXIebjCtDfS7aWMLYlTSS4
         S02bOfTaou8Vum3a3hLDyqABgpL5O2spHxM/5ytRbrSymQkhpVfC+9rrvA+jcjT0xpER
         5cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781090932; x=1781695732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7CoPC71NMmToN6IqHyZ2J7Av/IeasabCIzNKilALHc=;
        b=jnRPI2G0sacyDPB/uhCijBMGP7TMgtdVx5hxtSzKp51D6q+RmF/W5G86JUiK+v6JUf
         /lt9bv0WhW4LX03U5xQk/1Fdla/QmbgMm/UeFcjKUM0KC7lzVHLGGOUD6zc3YZSiBBkN
         prACMU/6c8HAiU34osWEVAeT94Llq/s3+9AbMZjRiN53YL9IvmQYjCtjxcjqSYbj/xET
         omCtfqadY3wQJQwWM1CeJRqSfPePHnokXStbAQ+SDn8brV1AejMPIt8+2M4PBtcqGFyH
         /3QVN8H5rhWcNk5p3BmSrRHy6mBTytgT8w1xzf1tgpKKY3OFoLDmvtpw+eo2ZoYf58wa
         pYgw==
X-Forwarded-Encrypted: i=1; AFNElJ8hjAoyi7bKEkIsDJ/NQKrqOOtFwq/1eiDDmFYfOql+wFzqW5YFX1nXQsNQJwiQHCcdYfutrbWW3iIjkUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRx0E8xcBzik/FSEsOQTFpHxlnCKuLCY4EsRD6THsKyp9+z7ST
	SuihN9tmT0HD9/nIZPC6aCtbczgsDVw8zlyS8SzPDJJ4B0dVnHiuV4R8
X-Gm-Gg: Acq92OHuSsNpyG440uieJ64nBNUT448L+wiBUAw0S+1ntg63jxc5W3ZIOXxWIwM2Dux
	UEktrqLUYQ/NLTLXf8hFH4qofNAJwcJABe+d1I2EiqdMikCVELaAud4DlwW+Eb9Tsx9pRGGZq7k
	M82hCNXjkAsZOhyUw6VKFi6zpuMkfWmhIMjvoKTJGHR1S+SteKhWcvj3liSV6rx9ZHj8fywzN3d
	N6ysQGiRsQTm7A++qzncKa1dJvZItiDZy2/zUhgq0+bz8H2cIFVsERoz04Ru6BOo0muruXI/X7X
	WwKwDe05DR+67QQ4Sv2W/bTqNTWidg90c/8EgoJ5VjtT/hTSO7cIQlIOE8MvA2oBFgV4spCGUBF
	YuVqnXG85M0t1+lJTWgk3/z43Yi/DTRKdAWPE47iYL8gtaz39trwDFqHq9AxJRUaQk6mh/GR2qL
	wo68jL0kz+GvGUMt2M5Z4etydrPOSyST6jX1mTOneQt+gu+ZvbYljBDw==
X-Received: by 2002:a17:90b:2741:b0:366:10f1:3d86 with SMTP id 98e67ed59e1d1-370f0b55ebbmr27067763a91.22.1781090932289;
        Wed, 10 Jun 2026 04:28:52 -0700 (PDT)
Received: from hc-pb-01.realtek.com ([123.51.179.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-376460ee14fsm2027651a91.1.2026.06.10.04.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:28:51 -0700 (PDT)
From: Jason Li <jason.lee651024@gmail.com>
X-Google-Original-From: Jason Li <jason.li@cortina-access.com>
To: jason.li@cortina-access.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] tty: serial: Add Cortina-Access UART driver and platform support
Date: Wed, 10 Jun 2026 19:28:17 +0800
Message-Id: <20260610112821.3030099-1-jason.li@cortina-access.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 adds the DT binding schema for the UART controller and the
top-level ARM board binding document for the Cortina-Access SoC family,
along with the vendor prefix.

Patch 2 introduces the serial driver (serial_cortina-access.c).  The
UART IP has a simple FIFO-based design with a single interrupt line.
The driver uses uart_port_tx() for TX, handles earlycon initialisation
when the bootloader leaves the UART disabled, and provides a TX FIFO
kick-start in start_tx() to work around edge-triggered interrupt
behaviour.  Clock frequency is obtained exclusively via the clk
framework.

Patch 3 adds the device tree sources for the CA8289 SoC and its
engineering board, covering the minimal hardware description needed to
boot a kernel with an INITRD rootfs.

Tested on CA8289 engineering board; console and earlycon both verified
at 115200 baud.

Any feedback or comments are highly appreciated.

Jason Li (3):
  dt-bindings: serial: Add binding for Cortina-Access UART
  tty: serial: Add UART driver for Cortina-Access platform
  arm64: dts: cortina-access: Add DTS for CA8289 SoC and Venus board

 .../bindings/arm/cortina-access.yaml          |  29 +
 .../serial/cortina-access,serial.yaml         |  46 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |  14 +
 arch/arm64/Kconfig.platforms                  |  10 +
 arch/arm64/boot/dts/Makefile                  |   1 +
 arch/arm64/boot/dts/cortina-access/Makefile   |   2 +
 .../dts/cortina-access/ca8289-engboard.dts    |  31 +
 .../boot/dts/cortina-access/ca8289-soc.dtsi   | 118 +++
 drivers/tty/serial/Kconfig                    |  21 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/serial_cortina-access.c    | 755 ++++++++++++++++++
 12 files changed, 1030 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/cortina-access.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/cortina-access,serial.yaml
 create mode 100644 arch/arm64/boot/dts/cortina-access/Makefile
 create mode 100644 arch/arm64/boot/dts/cortina-access/ca8289-engboard.dts
 create mode 100644 arch/arm64/boot/dts/cortina-access/ca8289-soc.dtsi
 create mode 100644 drivers/tty/serial/serial_cortina-access.c

-- 
2.39.5

