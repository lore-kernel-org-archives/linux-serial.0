Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4953B2417E7;
	Tue, 18 Feb 2025 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739881811; cv=none; b=u13jy1NPJ7+W4PJGrAAnE4W48hoLr6Dn3Ig4t/I7Q+NXuKMmZ/T7y371ToLI5lurogpjcLHQ043ipK7ScBnsrY1rD6vuh10RAf/W9DzEneHKHAPhQpDN/6t+wDYA6I/fAEx6oDZhP1R9DVkEfh/ppN6loDBxy0tPqqGF0U9npnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739881811; c=relaxed/simple;
	bh=fYMQnL//pawh6xRrxhtsC6fORTOwujMkRQAxDeZAmRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IbZIlTTVavVm87n4CI1HJDnL0OmhkXWYr6UHmN0RlBClCmNq8+Xi/MaKnGwV7NNPeTq/ajVLqK6Ojp/NeKL2b/G1hzUXhDVz2pGt/UYYr58xID28MmxH5sVj3AIdfSDlRyT28mfeD+9PsWazcSQJkBwNcHSF1HBYaGPXioYlYVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sL02gyt7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sL02gyt7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA2CC4CEE2;
	Tue, 18 Feb 2025 12:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739881810;
	bh=fYMQnL//pawh6xRrxhtsC6fORTOwujMkRQAxDeZAmRw=;
	h=From:To:Cc:Subject:Date:From;
	b=sL02gyt7CwEnFXF+LPfg/Cub+prSbn8X6brXZkErc1lXojj+JexT3Mj+XSws1A26a
	 fY7q1pmqL841dhGtxjEHN2bOZQB0STUQTE3/9boGrAhRwfe2u+siQzKRe+GaJw541z
	 pvT47VDmGFLJi43u7vxFplVteBYenFtcV2rZoRW/2qfYltVDYB4Epg6/JXBfgbf8b+
	 XwsF5IjyxhHR8iA1C+R4ehEp0ChVjnF8oX4BZvNCaQ3hCgfh6Z9E04UpmITcmyhYaE
	 KAAQScIBEeuXO5IPuF6BKPULhlcWpy721EL4uyWF5XVlE0QiXivZlfVTif/JyNuWdA
	 cXuUEuBGeS1Aw==
From: Alexey Gladkov <legion@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-serial@vger.kernel.org
Subject: [PATCH v1 0/2] tty/vt: Cleanups for keyboard driver
Date: Tue, 18 Feb 2025 13:29:37 +0100
Message-ID: <cover.1739881707.git.legion@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a few minor cleanups I found in keybord driver. There's nothing
important here and these changes just slightly improve readability.

Alexey Gladkov (2):
  tty/vt: Use KVAL instead of use bit operation
  tty/vt: Gather the code that outputs char with utf8 in mind

 drivers/tty/vt/keyboard.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

-- 
2.48.1

