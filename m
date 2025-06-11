Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E49263C91;
	Wed, 11 Jun 2025 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749636203; cv=none; b=npkJGRJXXcjcj3MZCWDt9GskXCuaCuWubvRyymGscliHsyTbCgLuMzlCVcfx0TxZICn5XG2QJlB75hDm/KPaa2Wf42P54ITMOl1CrH86udKw+8lRXVWIMmem0/8UDgrJWBYPg1vDckp4yYF8HMoCra5S1in9q5IG5DP0XZkn7Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749636203; c=relaxed/simple;
	bh=VAjUHWxQA72ZUlQaPqLVLNLzYPEe7+u0DgF2ciFjyCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U/89tf3g9joJbb4mOOWUP+g2f8JALDX/sRHuuZJGsZyS16y3a7y8v0ZP7WHzRP/tCym0epK80aXRQkvGu4H60kvHmlZjUnyyQHm+Js/7uF6Id6yUHVA760/yQpB2AXxwPcCSS2cDBXHNwa8lWlKthJVZk41IKWhJBMvK34/SRtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u29TFWnv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u29TFWnv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968CFC4CEEE;
	Wed, 11 Jun 2025 10:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749636202;
	bh=VAjUHWxQA72ZUlQaPqLVLNLzYPEe7+u0DgF2ciFjyCc=;
	h=From:To:Cc:Subject:Date:From;
	b=u29TFWnvQenJZ8qIWOgiOV48yd01Vaq32auiCNXO9WjFmNPlLv+sb4S/yHkQ4gDOQ
	 Hdg4kdeeGQIlaHRHcJOTHIpq+Xtq83kjQeoAVIvHqMuc73iU4lsC9syeZiWIjuy7aH
	 LfnlovQVvPIwq5D8cV/1AmG6NrNCR9/h1dn/wjFaPRFV3cTLb5JEZAkztM+DBy6I2r
	 ej5TwZMn280Ao7o1rytytTMO2JQdgYQ3KgMEtT4UW58GTHOTSgRu5zeeIV8tw/d0zb
	 DvZSRBd9vISz29R4+O7rNTMdnTR8ZFrrdK/a+amTZy1CuBP4zX5KrToBUvE4z+yRdd
	 Irifcnk1K2Vwg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 00/33] tty: summer cleanup
Date: Wed, 11 Jun 2025 12:02:46 +0200
Message-ID: <20250611100319.186924-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

this is (yet) another series of various cleanup in tty of issues which
popped up at me during a larger rework.

Jiri Slaby (SUSE) (33):
  tty: introduce and use tty_port_tty_vhangup() helper
  powerpc/legacy_serial: cache serial port and info in add_legacy_port()
  powerpc/legacy_serial: use %pa for phys_addr_t prints
  m68k: remove unneeded tty includes
  powerpc/powermac: remove unneeded tty includes
  tty: vt: use sane types for userspace API
  tty: vt: use _IO() to define ioctl numbers
  serial: 8250: sanitize uart_port::serial_{in,out}() types
  serial: 8250: remove CONFIG_SERIAL_8250_RSA inline macros from code
  serial: 8250: invert conditions in RSA functions
  serial: 8250: put RSA functions to their namespace
  serial: 8250: move RSA functions to 8250_rsa.c
  serial: 8250: extract serial8250_startup_special()
  serial: 8250: extract serial8250_set_TRG_levels()
  serial: 8250: extract serial8250_THRE_test()
  serial: 8250: extract serial8250_initialize()
  serial: 8250: extract serial8250_clear_interrupts()
  serial: 8250: extract serial8250_set_mini()
  serial: 8250: extract serial8250_set_trigger_for_slow_speed()
  serial: 8250: extract serial8250_set_afe()
  serial: 8250: extract serial8250_set_errors_and_ignores
  serial: 8250: extract serial8250_set_ier()
  serial: 8250: extract serial8250_set_efr()
  serial: 8250: extract serial8250_set_fcr()
  serial: 8250: lcr compute cleanup
  serial: 8250: drop unused frac from serial8250_do_get_divisor()
  serial: 8250: extract serial_get_or_create_irq_info()
  serial: 8250: remove debug prints from ISR
  serial: 8250: drop DEBUG_AUTOCONF() macro
  serial: 8250: invert serial8250_register_8250_port() CIR condition
  serial: 8250: invert condition to avoid a goto label
  serial: 8250: use hashtable
  serial: 8250_omap: use uart_port pointer when available

 arch/m68k/amiga/config.c                |   2 -
 arch/m68k/apollo/config.c               |   2 -
 arch/m68k/atari/config.c                |   1 -
 arch/m68k/mac/config.c                  |   2 -
 arch/m68k/q40/config.c                  |   2 -
 arch/powerpc/kernel/legacy_serial.c     |  62 +-
 arch/powerpc/platforms/powermac/setup.c |   2 -
 drivers/isdn/capi/capi.c                |   8 +-
 drivers/staging/greybus/uart.c          |   7 +-
 drivers/tty/serial/8250/8250.h          |   8 +
 drivers/tty/serial/8250/8250_core.c     | 316 +++++-----
 drivers/tty/serial/8250/8250_dw.c       |  34 +-
 drivers/tty/serial/8250/8250_em.c       |   4 +-
 drivers/tty/serial/8250/8250_ingenic.c  |   8 +-
 drivers/tty/serial/8250/8250_ioc3.c     |   4 +-
 drivers/tty/serial/8250/8250_lpc18xx.c  |   2 +-
 drivers/tty/serial/8250/8250_omap.c     |  53 +-
 drivers/tty/serial/8250/8250_pci.c      |   6 +-
 drivers/tty/serial/8250/8250_port.c     | 736 +++++++++++-------------
 drivers/tty/serial/8250/8250_rsa.c      |  92 +++
 drivers/tty/serial/8250/8250_rt288x.c   |   4 +-
 drivers/tty/serial/8250/8250_uniphier.c |   4 +-
 drivers/tty/serial/serial_core.c        |   7 +-
 drivers/tty/tty_port.c                  |  12 +-
 drivers/usb/class/cdc-acm.c             |   7 +-
 drivers/usb/serial/usb-serial.c         |   7 +-
 include/linux/serial_8250.h             |   4 +-
 include/linux/serial_core.h             |   4 +-
 include/linux/tty_port.h                |  12 +-
 include/uapi/linux/vt.h                 |  78 +--
 net/bluetooth/rfcomm/tty.c              |   7 +-
 31 files changed, 751 insertions(+), 746 deletions(-)

-- 
2.49.0

