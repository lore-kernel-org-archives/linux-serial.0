Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB3B183CC3;
	Fri, 25 Apr 2025 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579600; cv=none; b=JzAd2j29IYY/E9K10AkdG5j3Uk9MiDKo53QR80EDPX4okFXXvcptheQyglm+3YcCcDwHcl0c45pvWf3DpT/WJGBx+wULf3uc4Klr+fP6wM+ME60u6dclLt7LgfBJOrf5t5ZeO7/bssh9WLZA2ti1nzItlSJZ3ZGLBs1YVIQpL5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579600; c=relaxed/simple;
	bh=DNZdYQV7RwfkKh9ZxmtSZR05bOMge8j4Ld8v8tgWcu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/kLYDMb8oHOAh5ic4LX6fIg6in5I0OU6SK2erEokXgVA1I1nj7Me7IV33BydUBhO9qi5W/FC2K3an5IWZq86GBmqr6jCt14+tHcC34y732ug9UypsQLfamku4P5iynQNnDP41ws06m+0ZWxk4XawuUyZW6FbcCU2TqIGdKfQ7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4HBo9ml; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4HBo9ml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62CBC4CEE4;
	Fri, 25 Apr 2025 11:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745579598;
	bh=DNZdYQV7RwfkKh9ZxmtSZR05bOMge8j4Ld8v8tgWcu8=;
	h=From:To:Cc:Subject:Date:From;
	b=J4HBo9mlo8rMwXEzwYSHrSQl9ClfYBj6D8teBSVpvdGeasY8hhCiCw5WIA92V2Hev
	 0fwo5EWjV2JOv7cu3yEVn4aUWEwYFtjRubWeitLAKnrQVU/CuVLkywzfRYmNhiyDGF
	 2rsA5tFV9QcjPH6/XkFczGGTWa2kZ6lx+OQx2cIqtD/Z1BbQ712VNdf0nBD9ptkvAE
	 d2CzyfZDSk6QtVr1WTgpapmjUq6wm6VSiJACONjeEubGGxCaC/rcfqo0IiSWb5zSD1
	 PDY54ZDsQf/CD+DWs6EX7LetvOXLKNVWX8WWCkmUHTZ1B89U4RF37ZSyZ8vIBsIwYY
	 uJEc/UGeob9Kw==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 0/6] tty: spring cleanup
Date: Fri, 25 Apr 2025 13:13:09 +0200
Message-ID: <20250425111315.1036184-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this is another series of various cleanup in tty of issues which popped
up at me during a larger rework.

Jiri Slaby (SUSE) (6):
  tty: simplify throttling using guard()s
  tty: use lock guard()s in tty_io
  serial: switch uart_port::iotype to enum uart_iotype
  serial: rename local uart_port_lock() -> uart_port_ref_lock()
  serial: use uart_port_ref_lock() helper
  serial: 8250: unexport serial8250_rpm_*() functions

 drivers/tty/serial/8250/8250.h       |  6 --
 drivers/tty/serial/8250/8250_core.c  |  2 +-
 drivers/tty/serial/8250/8250_early.c |  2 +
 drivers/tty/serial/8250/8250_port.c  | 16 ++---
 drivers/tty/serial/8250/8250_rsa.c   |  2 +
 drivers/tty/serial/amba-pl011.c      |  2 +-
 drivers/tty/serial/fsl_lpuart.c      |  5 +-
 drivers/tty/serial/samsung_tty.c     |  4 ++
 drivers/tty/serial/serial_core.c     | 97 ++++++++++++++--------------
 drivers/tty/tty_io.c                 | 96 ++++++++++++---------------
 drivers/tty/tty_ioctl.c              | 50 +++++++-------
 include/linux/serial_core.h          | 30 +++++----
 12 files changed, 149 insertions(+), 163 deletions(-)

-- 
2.49.0

