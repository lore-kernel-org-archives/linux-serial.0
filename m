Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C875033C503;
	Wed, 19 Nov 2025 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763544302; cv=none; b=ZmWpkdrglmqRAdsms1/GeeXT1GLVR6GxJo6t0gVX+cfO8pByHPioFOA0S31pkupW2Ae/358LQB60C6BPglSwV5GkSOvSVd+Y9b9ReqSKnRQ0v9UKFEozKEzFgxhSzgWXgq4WA07JW7qZnjYv+w4kDMQf/tSv2JXup290xn5kvVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763544302; c=relaxed/simple;
	bh=t3uLWazg6A/iVsMQl7BV3J0IdsMfnAt6SnIjNbRfS9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MjDq0TrOiiQ6+GNLKPDfhJja8DjqLZZF9RZxJdNYvnr+f482qqnsv9twm/nnqr0ZQ0sjrk/iDXsN/KtR9ToY3Os5R7yjP23IAM6CaWjPAk1TtAlSnql3/bRzlgoVbB4gLPNezaqI6BXBTGcqOIsGPIAAZ5CVYcl+cQ0VNL4mXZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGd7oOBG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGd7oOBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09262C116D0;
	Wed, 19 Nov 2025 09:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763544301;
	bh=t3uLWazg6A/iVsMQl7BV3J0IdsMfnAt6SnIjNbRfS9I=;
	h=From:To:Cc:Subject:Date:From;
	b=JGd7oOBGKsiguNaLfCkCvaz5ygDjOgqlgAoQBQ8IuwBUVSkED6nS7KTjO1UEIHNAh
	 DS9D6RSbVkiUJB+PdYtv0MPD1S2D2aoR8vnLbQ3PqT0O/XmbS4z1Hy93GGBlOQdbRo
	 fhoeQMAratRvMXInCpEAzTe1cNhAPIyWXBVrLJODHsesox1mCskt7+QftQZyWQhjbw
	 b/Fa0M/YcTdCq+nO7w2/xR7iReKGO8184nokopF2UJYEkPECnx19Si30AzC7wL283c
	 1XquGo/z+xvKV6Ir5k9q9Fub0tcjF3i0iYPnWHD74utWAB2wj6PzWXRzvYuWnUTOiv
	 xxED7/Jfh8lIg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 0/6] tty cleanup for 6.19 or later
Date: Wed, 19 Nov 2025 10:24:51 +0100
Message-ID: <20251119092457.826789-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this is another couple of random cleanup patches over the tty drivers.

Jiri Slaby (SUSE) (6):
  tty: vt: do not open code DIV_ROUND_UP()
  serial: xilinx_uartps: drop cdns_uart::cdns_uart_driver
  serial: drop SERIAL_8250_DEPRECATED_OPTIONS
  serial: 8250: move skip_txen_test to core
  serial: 8250: make share_irqs local to 8250_platform
  serial: 8250_platform: simplify IRQF_SHARED handling

 arch/arm/configs/aspeed_g4_defconfig        |  1 -
 arch/arm/configs/aspeed_g5_defconfig        |  1 -
 arch/arm/configs/hisi_defconfig             |  1 -
 arch/arm/configs/lpc18xx_defconfig          |  1 -
 arch/arm/configs/shmobile_defconfig         |  1 -
 arch/mips/configs/bcm47xx_defconfig         |  1 -
 arch/mips/configs/bmips_stb_defconfig       |  1 -
 arch/mips/configs/gcw0_defconfig            |  1 -
 arch/nios2/configs/10m50_defconfig          |  1 -
 arch/parisc/configs/generic-32bit_defconfig |  1 -
 arch/parisc/configs/generic-64bit_defconfig |  1 -
 arch/powerpc/configs/44x/akebono_defconfig  |  1 -
 arch/powerpc/configs/microwatt_defconfig    |  1 -
 arch/riscv/configs/nommu_virt_defconfig     |  1 -
 arch/xtensa/configs/audio_kc705_defconfig   |  1 -
 arch/xtensa/configs/generic_kc705_defconfig |  1 -
 arch/xtensa/configs/nommu_kc705_defconfig   |  1 -
 arch/xtensa/configs/smp_lx200_defconfig     |  1 -
 arch/xtensa/configs/xip_kc705_defconfig     |  1 -
 drivers/tty/serial/8250/8250.h              |  9 ----
 drivers/tty/serial/8250/8250_core.c         |  4 ++
 drivers/tty/serial/8250/8250_platform.c     | 55 +++++----------------
 drivers/tty/serial/8250/8250_rsa.c          | 24 ---------
 drivers/tty/serial/8250/Kconfig             | 17 -------
 drivers/tty/serial/xilinx_uartps.c          | 15 ++----
 drivers/tty/vt/vt.c                         |  4 +-
 26 files changed, 22 insertions(+), 125 deletions(-)

-- 
2.51.1

