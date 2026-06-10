Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F6B3E3172
	for <linux-serial@vger.kernel.org>; Wed, 10 Jun 2026 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781090939; cv=none; b=Zg6hbuDU8fvyTFrHrwzzgqqYXo2+6XIhB5JkKZ9afhudHNKJNPto0Sh+iVenj197wkDfiN2nS5vamN247HEy7EhwEQ94ewr5/bD3dSS6oS2zJtFqOPKZtWGbN0UBAUaVWKfVy20rshSiIqjm1sSxG31uoXqwa4ET7BMoWaiiwQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781090939; c=relaxed/simple;
	bh=LgdbPNP0ihMSKvD35dVdCR1EjeRMx3oEv6r7a45UVcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LaOMg6WvcrwoffsQ6NSicbBtP+Fpn0HIFKQxJwUlofQwbGZz3RchM/MqbYdwKd2LfuWk6pcnjNRj7f7qezrjq8J/KfJG5r8+cUnvpB383cjx1CxRET/09k+CqEOflQiGK+W0gpY5DWEhUdrGrLQz4L9Q1UO6KNFxDg9vlduLBl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4Bt1Gsq; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4Bt1Gsq"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36bba9a1089so3988387a91.3
        for <linux-serial@vger.kernel.org>; Wed, 10 Jun 2026 04:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781090937; x=1781695737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bwi1GK1b6kFMqMMmZP+3rXcQIfq6dBSGPyXYvtvQ7e8=;
        b=M4Bt1GsqxV5bcKq8mCun5wtJu+s4wf4VWTifu7rkph8KKvfxxpSKC4xdYo1R89CR+9
         aYDxxUUkak/HSrWBthqT7ptYzlXsQRS+K8azlEQrhzigatFb6KCyexHsAiv2bYZs9tOH
         k6XBdoNS220pjbQ9Db4SCELEI6fIJ/g/cQsbHTTixbKl3iRVCpvgd3LFUAb3qXISLTgX
         7STL2mJ62KjRsem0RxyD71BmUFPglpjauLleRpYvpsMvPgh4O3HMV5OP6fO1tDZvBWk0
         gqbzePm1cvFP8HGiI9F8ZPXVpwXKkvR9Hx7gqmktkgbGbgkOdOYUHpR8m/Cipu3oVqTC
         CCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781090937; x=1781695737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bwi1GK1b6kFMqMMmZP+3rXcQIfq6dBSGPyXYvtvQ7e8=;
        b=XF1ka10nqWHT75Cz3On6pDNJ9XUyxmRuDO+9kaUVkNqLPxylFRpkN8FvKsSzS9pKn7
         CVsCjqn016y3JOqmafXGmsm+CQLIf5tUKuBocuOp1zIN0suXpt76buABmPGLOYSAJ2w8
         ZLBvSy2G4EnH7aS6tN3QT8XRo+xKprZ8PbmPvgVcs1vij/ScFCbb4vKnGJFrDhGVll4H
         m7xkx6pXc6GWLQZ0ZrGFnBkdHq75915W9sPsjkdvNwah5JvAGz8D578mj4vP1kqokUgz
         KASdjsMPWQ8K/K8wu2tijTSR0FbgZXP8Ji9KhoVdzn59pFN9ROJU/ttlzpS4k03clWob
         5WcA==
X-Forwarded-Encrypted: i=1; AFNElJ/1xHiNlmg5qjtWKnfFuisHb49PXuMxsGkbpTv71ME/6+Mj8SGJPJukLH+6wFggJCmQd9IezQvaxOaHC+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV5G9EvIml5GJV57XLeYh+O8CclCj6nVgSS620JUCMh9mKYwQK
	3u4wtdoEHMWAbAjB7MY7x2glgj5j6enftd/6y031qHhADy6qkdy53MEp
X-Gm-Gg: Acq92OEr0ZsLG8YW21cKGbdQty25BIQvxcaFbQ/CxJe1Vq2nhGGfAlvH1ofPCz9n2TS
	atHlP3sUhXP03uF6dEF91nKLJ/Hz8dwBctHNm9gg5kU/BQMa3gqYdH/0Dy6uYBXQvNdZM0RwiWr
	VC2KWGDqLyB/SBTGC23TAf4sYZRnGRnzAZbiZRR3omdrdUf2bQnxC2ZE76MN4ZEEdMmKyG71Vnr
	gXYgekyV4zWoOZIc1VGUhDcceMPaZhholT5QCLb30XmhU/czzpjE3wsbJBHSu19J6R7kBt35d70
	x6FFt70KEANCLSbZN5QEJpwVdP8rQw05QbFW/Jxud7bk0Z0OeQzzMR3rnjKzZFiXBWgpAxF6gNG
	FHVyuMcybMzGxvxs+yvtPR6US13O0mwGSLKk9sjC4KnEAfmxAPVzDX4mp27sWFPpSzKPCt84OLh
	72gcnoi7sZVENf+M7GAymFZpZhx+EJjTBKGkYc0JgHe75Z8lh3+xaWoQ==
X-Received: by 2002:a17:90b:580e:b0:36c:e254:4db with SMTP id 98e67ed59e1d1-370ee544633mr25082162a91.6.1781090937473;
        Wed, 10 Jun 2026 04:28:57 -0700 (PDT)
Received: from hc-pb-01.realtek.com ([123.51.179.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-376460ee14fsm2027651a91.1.2026.06.10.04.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:28:57 -0700 (PDT)
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
Date: Wed, 10 Jun 2026 19:28:18 +0800
Message-Id: <20260610112821.3030099-2-jason.li@cortina-access.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260610112821.3030099-1-jason.li@cortina-access.com>
References: <20260610112821.3030099-1-jason.li@cortina-access.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds Linux kernel support for the UART controller integrated
in Cortina-Access SoCs, with CA8289 (Venus) as the first supported device.

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

