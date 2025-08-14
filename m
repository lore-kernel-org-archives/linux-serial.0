Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1532266B6F;
	Thu, 14 Aug 2025 07:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156300; cv=none; b=pTyvZ+EPK/fcz0Mrs72L+cLqF+MAbyGXroV11V3olQYnPnnJwd6kMVdBWFdX2fcy5FelLxGFTPLB6IiqSCqPlccu/LDqYQ6OU6UJE75mbKxlBQI7BLyQTj5Bd59CF+wWDHPOzab/L4PBuHfP5/ebrFmBRqoF4tofWDJuRl0y5mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156300; c=relaxed/simple;
	bh=XNXHCiEWK5MhZ/JoxcVkCOVT4sKxJhnlMv2tEOMdXt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gtb2QpKWzDX3Fp8v4EP3e25uGUYXiNsXEeIoynQDGKs+SBpRsjkJS6iFyL+wjJr8viimJufY6X+dWCq2RQtVRlxwLCYLpiuwH/fsxd24GoLCQS5u6D5r7JsDQJfrLK/ZO7OyW+SAaeQ/7vHkhNQjhFVWaimqxAR3VXh9K+JtQus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdlUttA+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdlUttA+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59EA7C4CEF4;
	Thu, 14 Aug 2025 07:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755156299;
	bh=XNXHCiEWK5MhZ/JoxcVkCOVT4sKxJhnlMv2tEOMdXt0=;
	h=From:To:Cc:Subject:Date:From;
	b=pdlUttA+vnFfZdhDZtUFT4gpTBEQ/NupD3p/nWd9xhli6v9AJ7zerS0/QOcTLPTjX
	 0k3Coq+8rtJPt9wii6nt7hsUvWEUXfRegAoCIhsL//0seohmqRfbRixS5/CKUYQjhZ
	 R5SOH7OkXT4FmyDa7VCCrFZBMG07+gyMTqUBo8gT5117UwfEX4G/xXolAdFjKGr6rd
	 H2Fhuq1OvsuD63SRvMUiimi2QVLG4L1Chqjo1mzkbqyvuVhl3pHw6ftcvQb7RXFZWu
	 AmRb+FU2m7DMaJdmmz2OqyDZvgjHynKYWl0i2sora+FUhQj36ZKLXJDCLRYKsKEEdd
	 PZo8cLyGy1+7g==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 00/16] tty: use lock, rpm, and free guards
Date: Thu, 14 Aug 2025 09:24:40 +0200
Message-ID: <20250814072456.182853-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first 4 patches introduce guards for:
* console_lock/console_unlock
* tty_port_tty_get/tty_kref_put
* uart_port_lock/uart_port_unlock in all its variants (_irq, _irqsave,
  _try)
* serial8250_rpm_get/serial8250_rpm_put

"tty/vt: use guard()s" also introduces a local free_page_ptr guard for
__get_free_page/free_page (with proper casts). This could be made
public in include/.

The rest of patches make uses all those guards across the tty code.

Jiri Slaby (SUSE) (16):
  console: introduce console_lock guard()s
  tty: introduce tty_port_tty guard()
  serial: introduce uart_port_lock() guard()s
  serial: 8250: introduce RPM guard()s
  tty: tty_port: use guard()s
  mxser: use tty_port_tty guard() in mxser_port_isr()
  mxser: use guard()s
  serial: serial_core: use guard()s
  serial: 8250: use guard()s
  serial: 8250_core: use guard() in serial_unlink_irq_chain()
  serial: 8250_omap: extract omap_8250_set_termios_atomic()
  serial: 8250_omap: use guard()s
  serial: 8250_rsa: use guard()s
  tty/vt: use guard()s in con_font_set/get() and con_{set,get}_unimap()
  tty/vt: use guard()s
  s390/char/con3270: use tty_port_tty guard()

 drivers/s390/char/con3270.c         |  18 +-
 drivers/tty/mxser.c                 | 259 ++++++++++--------------
 drivers/tty/serial/8250/8250.h      |   5 +
 drivers/tty/serial/8250/8250_core.c |  91 ++++-----
 drivers/tty/serial/8250/8250_omap.c | 145 ++++++--------
 drivers/tty/serial/8250/8250_port.c | 298 ++++++++++++----------------
 drivers/tty/serial/8250/8250_rsa.c  |   7 +-
 drivers/tty/serial/serial_core.c    | 143 ++++++-------
 drivers/tty/tty_port.c              | 168 +++++++---------
 drivers/tty/vt/consolemap.c         | 116 +++++------
 drivers/tty/vt/selection.c          |  20 +-
 drivers/tty/vt/vc_screen.c          |  74 +++----
 drivers/tty/vt/vt.c                 | 187 ++++++++---------
 drivers/tty/vt/vt_ioctl.c           | 190 ++++++++----------
 include/linux/console.h             |   2 +
 include/linux/serial_core.h         |  13 ++
 include/linux/tty_port.h            |  14 ++
 17 files changed, 747 insertions(+), 1003 deletions(-)

-- 
2.50.1

