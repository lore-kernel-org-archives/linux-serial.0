Received: from smtp6-g21.free.fr (smtp6-g21.free.fr [212.27.42.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F9E394EAF;
	Tue, 12 May 2026 13:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593588; cv=none; b=fBqNGDuUJz33coorKCYrcbcyWdU5jLhpcl7h5oJARe+gGVh/4J6kPjH+r3FgkudDsw8Q6BOvfHfYFwkYtuGV/uh7phT3Tv7RQ+kb7Rp8A0N82tFxWzAa2x/hHzanqn8q+vHoaQtidYPy+oBxjVAzREdCFSxC8jb2amRyq3eIEmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593588; c=relaxed/simple;
	bh=Bgl9FN/2EDTlJS/1ikgYLhdCePIba5SUCt2U/no841k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpcv8dSg1avPngVCdG0w0e0PXmhjZkPyN+0GYjCLnZQOX5yvy/34DvzuhxMTlsOpElFNWLvtP0iNqLdrqMp2Zv7AxqrqJTIcJzU2OHwzyix5JTFbVsNIoj9OlYB8IXHiiHCCMxQy8TyOyQ707I28BOblbkIvf0sCbsa0fZp8kdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=HXiVaEFD; arc=none smtp.client-ip=212.27.42.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="HXiVaEFD"
Received: from Gigabyte.tail209581.ts.net (unknown [IPv6:2a02:8428:7df0:ac01:fbfd:168d:553c:3eec])
	(Authenticated sender: jnilo@free.fr)
	by smtp6-g21.free.fr (Postfix) with ESMTPSA id BFDB7780389;
	Tue, 12 May 2026 15:46:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1778593585;
	bh=Bgl9FN/2EDTlJS/1ikgYLhdCePIba5SUCt2U/no841k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HXiVaEFD1LxUmPrF8odKjzuIWXM32C8avv79RaMxXxRkQdWXdL1EQN4m1EvtvDUqQ
	 m96tfdO1WYL1cJdss8oS+YCoJY7pu452NY56dsnjhLIZXlRHjN1crgWHJxk3Wqv+MC
	 tN/+srRzNoMT5D3zIYACoei3NEQqZPWIeWmZ52DVFd1pEyi5hH9T/OZBsC1NNNOUuZ
	 cNFnwgETbe2XRbrQKggQ5lhbcgCAMTeKzdEikhjoAmPsGFnnHyFG/XEVVidIY7grt6
	 ChyYb0qoGiUgUwPQUzVRFdrdvfx/R2FiRoi80mqETQXdOPaheyE7Erlsx/YiVi3V4B
	 15vwjsli0qaWQ==
From: Jacques Nilo <jnilo@free.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Jacques Nilo <jnilo@free.fr>
Subject: [PATCH 0/3] serial: 8250: fix BREAK+SysRq dispatch on guard()-locked IRQ handlers
Date: Tue, 12 May 2026 15:46:11 +0200
Message-ID: <cover.1778592805.git.jnilo@free.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5efe9e03-4d86-43a0-9ec2-e610ff31095d@free.fr>
References: <5efe9e03-4d86-43a0-9ec2-e610ff31095d@free.fr>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a silent regression where a SysRq character entered as
BREAK + key on the serial console is consumed by the kernel but never
dispatched to handle_sysrq().

The root cause and two fix candidates were discussed in [1]. Following
Ilpo's suggestion, this series adds a dedicated lock-guard variant whose
destructor is the sysrq-aware unlock helper, and switches the two
affected IRQ handlers (serial8250_handle_irq and dw8250_handle_irq) to
use it. The plain guard(uart_port_lock_irqsave) keeps its current
semantics for the many callers that do not process RX.

Patch 1 introduces guard(uart_port_lock_sysrq_irqsave) in serial_core.h.
Patch 2 switches serial8250_handle_irq() and updates the Context comment
        on serial8250_handle_irq_locked() so future HW-specific 8250
        wrappers know which unlock variant is required.
Patch 3 switches dw8250_handle_irq() to the same guard.

Verified on RTL8196E with CONFIG_MAGIC_SYSRQ_SERIAL=y: BREAK + 'h' on
the console UART now produces the SysRq help dump in dmesg; the brk
counter in /proc/tty/driver/serial increments per BREAK as expected.
Build tested on tty-next (base 16e95bfb79b5).

[1] https://lore.kernel.org/linux-serial/5efe9e03-4d86-43a0-9ec2-e610ff31095d@free.fr/

Jacques Nilo (3):
  serial: core: introduce guard(uart_port_lock_sysrq_irqsave)
  serial: 8250: dispatch SysRq character in serial8250_handle_irq()
  serial: 8250_dw: dispatch SysRq character in dw8250_handle_irq()

 drivers/tty/serial/8250/8250_dw.c   |  2 +-
 drivers/tty/serial/8250/8250_port.c |  7 +++++--
 include/linux/serial_core.h         | 13 +++++++++++++
 3 files changed, 19 insertions(+), 3 deletions(-)


base-commit: 16e95bfb79b5d9d01dc7651d98caf3c2ace331cd
-- 
2.43.0

