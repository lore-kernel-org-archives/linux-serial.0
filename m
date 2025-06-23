Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A801F416C;
	Mon, 23 Jun 2025 07:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750664769; cv=none; b=AXYsmrtUDUK9bTBrhUhV2k8gpaBbWRaM+qNGwI6ACKTI/vRLXAB1fHwxmaQXGE56a/c5Q2eMO0RIw1BDyzZsxQrMcpscuKvQYMzx4Ajx/9wQjZhXocaE7U+obp+eESCavTK/qz2nBjgN6GMxqm6kImc7eg76Lwspg1Lf38Dexm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750664769; c=relaxed/simple;
	bh=24xcD4vornGZXzMZVCRSbS6vdrWHUoO9anQ2BPJetsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HcVGOCIrEUgvnUXGuVj/XK0Kg+nyPV84gSb3FwakHBXXwuTk6hjMS+uWkEKLqDM5DLl3SuVSKYN8B33VQ/iRqwvl6aMkqYsUEJXSR9a7LGAAgODC/vS0zn4qCWnhEjWMRiCO19xdqhJEmvzn6osabyph2yi3Uu77cU8EZzHjjEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qceN2Gh/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qceN2Gh/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EBDC4CEED;
	Mon, 23 Jun 2025 07:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750664769;
	bh=24xcD4vornGZXzMZVCRSbS6vdrWHUoO9anQ2BPJetsI=;
	h=From:To:Cc:Subject:Date:From;
	b=qceN2Gh/n/yyN022cr84uXZLRjf+kFjzHtRJ+UCNP4ijMvyqZHH0fwM2HHCOLRZBY
	 jbjBGLD/QoW7v0uhkgifJpBQcQ6tUTfaDrkUynVG/3whxx2fZdBfsN+rZ4QA3w+qPq
	 ncnPDA5HLm7lgl9/osY9QaqyHuKhyWBkH77lA+9fey/NIulwqjOw0J2jGwGijCjtP9
	 HZRtnz4aGzXsn8ZeRB40YZhLcnBnbnZo5tRtHcC+H50ZH3s1DdXHbwBNPw3tbpRo+r
	 dAa6gkuNlKsb1xM7UggUr2izNPJKx7isASy723gghOm138qSxKqTBiYqWY6MGs2iu1
	 ffaEq2YvjrYzg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 0/5] tty: fixes on top of summer cleanup
Date: Mon, 23 Jun 2025 09:46:01 +0200
Message-ID: <20250623074606.456532-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These are fixes which were suggested or popped out of the summer cleanup
series.

Jiri Slaby (SUSE) (5):
  serial: 8250: extract serial8250_init_mctrl()
  serial: 8250: extract serial8250_iir_txen_test()
  serial: 8250: rename lsr_TEMT, iir_NOINT to lowercase
  serial: 8250: document doubled "type == PORT_8250_CIR" check
  tty: fix tty_port_tty_*hangup() kernel-doc

 Documentation/driver-api/tty/tty_port.rst |  5 +-
 drivers/tty/serial/8250/8250_core.c       |  2 +
 drivers/tty/serial/8250/8250_port.c       | 73 ++++++++++++++---------
 drivers/tty/tty_port.c                    |  5 --
 include/linux/tty_port.h                  |  9 +++
 5 files changed, 58 insertions(+), 36 deletions(-)

-- 
2.49.0

