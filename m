Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793466602;
	b=PnEC1Qk0z+Cq5YBe+dqwpSkA++iHMCLhL746Xot5kkqwQsDdJFrvTomCa1kpPwWaojVi
	 RRnEaDEnhvSwTzQ/SIneo0HgsUQ0aO6YS9tYpnbOi5FhAlrljDJpWZ4/2vAeVXrTNtORv
	 WV8IzNgXOEMNXlMss4vBk1FlLWjwNierhrKtSKg/b50lWp1zy5fx9RSITM23EMju6xiqZ
	 iRao6YvSCGhKGJrJlc8mhMMDvTqrzIoLrUI+ty7b35qyIeGALAHrq4xn0ePv+ZvzM1c13
	 6Tcwla2MTn+oXmrdtdpWWsZfNrh+tJA+z/JGNFzMSjbmlYpt/fga9VvXsNF7ht0HnUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793466602;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=rwgOuZt3/daKJP7MDhwWg9Xwq6IOExj4eF3w/XLEjcI=;
	b=Dy+Ktu0TZRcCyWucouwYgOGRCefZr0z7gJYyef5ZrQeIQo51Dd57gje4/CVg0vNYG4NT
	 jLw38T4zXUi2a8buuXZIKO1aF4NhOxWzDtNKaqSmf9op7NyjhMAXwdRqxfmc4O78mcWVa
	 mlAQB5rrL6TARHR+wIcPQT440WZdzB5UiqC7aWlAbEtCUUfRi2EP0zVvCRyC6xgfA/3gL
	 gAVM0Ye1qKcaCisJJq2w2BUMhL2tOgnUA0+9t/mDQfpaGMZm0LV43g6JXC1NPOmamJkly
	 eZQsIiSFEmoTC6yRjHYZ9+L+VBAswX77nbT+WhDocNQYTaH2/6WVexVbPqdfWgQJGlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DgDXR5r8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D7D606A31A;
	Sat, 31 Oct 2026 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DgDXR5r8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FB31F000C1;
	Sat, 31 Oct 2026 17:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793466601;
	bh=rwgOuZt3/daKJP7MDhwWg9Xwq6IOExj4eF3w/XLEjcI=;
	h=From:Subject:Date:To:Cc;
	b=DgDXR5r8uhoVW7rNG1/mUea4nbNWPx3W7h9kGOxAutQWk/LgQcYM7jMxtI4ybU5z4
	 /VXY0Vc3/xUC4zmUsi2tyuLIuqHNG8fD0fu92wb2ksBVDhgo4x0Eq8AEYzt0l3ugdu
	 JhbD9+fAq5zhMzHcMB0lATI8fAHagVmjja8m8MYinnDL/+vv66DJu100jkfbkH+SrZ
	 fSN98XEcY8flO07fTzoLAL2IikYASnTV5/ytWZB+2nFdQQOix5XUmdooHdMvB4DsTj
	 6VEKODdjgl2kb/ZSRAScUfNhNeLRkowbvy0z78dYFTI27GFlHfZyg/p1pbOrjNhpgZ
	 ilEVZ/THNJyiA==
From: Joshua Crofts <crofts@kernel.org>
Subject: [PATCH 0/5] tty: serial: remove redundant
 pm_runtime_dont_use_autosuspend() calls
Date: Sat, 31 Oct 2026 18:09:44 +0100
Message-Id: <20261031-tty-dont-use-autosuspend-removal-v1-0-7bdadcadc4dd@kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NQQrCMBBG4auUWTvQiVLFq4iLmPzqgCYlkxSl9
 O4Gl9/mvZUMRWF0HlYqWNQ0pw7ZDRSePj3AGrvJjW6ScS9c65djTpWbgX2r2ZrNSJEL3nnxL8b
 JyS0IwuE4Uc/MBXf9/BeX67b9AE/dmkZyAAAA
X-Change-ID: 20261031-tty-dont-use-autosuspend-removal-e821bc1ec476
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Michal Simek <michal.simek@amd.com>, 
 Peter Korsgaard <jacmet@sunsite.dk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Joshua Crofts <crofts@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793466599; l=1149;
 i=crofts@kernel.org; s=20261015; h=from:subject:message-id;
 bh=2SRCu0EHsDqsQ6XggGun3l8mT6gihtWOiO8PI8Na/OI=;
 b=GJ7+wDp1zdB9c844WCb+h+JMrXpw5Q//cyIE8FCrJ/Xud+6N0TPvu17+EryGgO16JKE8QJDjT
 rt5UknaSnZnBGaaEkKSgawxPZKnBY/i7jBXMJIxlAoYyLtMwvcwnoBX
X-Developer-Key: i=crofts@kernel.org; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Signed-off-by: Joshua Crofts <crofts@kernel.org>
---
Joshua Crofts (5):
      serial: 8250_omap: remove redunant pm_runtime_dont_use_autosuspend() calls
      serial: fsl_lpuart: remove redundant pm_runtime_dont_use_autosuspend() calls
      serial: xilinx_uartps: remove redundant pm_runtime_dont_use_autosuspend() calls
      serial: port: remove redundant pm_runtime_dont_use_autosuspend() calls
      serial: uartlite: remove redundant pm_runtime_dont_use_autosuspend() calls

 drivers/tty/serial/8250/8250_omap.c | 2 --
 drivers/tty/serial/fsl_lpuart.c     | 2 --
 drivers/tty/serial/serial_port.c    | 1 -
 drivers/tty/serial/uartlite.c       | 1 -
 drivers/tty/serial/xilinx_uartps.c  | 2 --
 5 files changed, 8 deletions(-)
---
base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
change-id: 20261031-tty-dont-use-autosuspend-removal-e821bc1ec476

Best regards,
-- 
Joshua Crofts

