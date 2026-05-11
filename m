Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380A332470A;
	Mon, 11 May 2026 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778513230; cv=none; b=Yz4BDHbzGPNkfGAzuQFFCGPxHWMPURiw1xvz9fLdoL+oFCgM3SYrXtIzswX0M5zERVtjL7EcmBSFD5sshggCdVWPDBhmCcaVv1U0YD6mT5zwQe/prYJWbkeQ9N95ep2j2qNt2HXA72+YwYBwYF0EAJWLYdz1K3BeLU9lzjClT3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778513230; c=relaxed/simple;
	bh=TqKpxdnwicPQSxFnQHzMa3wWiMX0y/VqYfyyutBpclE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HO57zvQ6xug5tLSif2MgKtnQkkTk1dpopRGS/vPArowFVN7oih9eFJLwiDGLnsDbPd26Oe9taKNGk3N3NGP7+B5/P/GAIxKkFd0mYNCwoZfb91VhEtyp0AwgjF8TIakUpBpbnPCVl90bF39aBhofmJI3mDNtlVG41U71DPjRew4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1PFF1qID; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yg8cKK3q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1PFF1qID";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yg8cKK3q"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1778513227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oI2jZkU0j7/tmX5K7c3awpgTpBBjJrmE1UydFF1lCZk=;
	b=1PFF1qIDJgKJJjaGLvBwuCeV83kuznkG1NBaZanQAUcj5Pnojwx/oMddGk+7Etcxbdf4y0
	GYImJZdKFRkgKiFCZu2qwnyFJsR7bJ7eMPSqB6s5sj61tlhaV6eMphC4LdPUH0zvXk8DTy
	heFz7o+qCtQlrTsT4anWo3iYCOFoZjFb1f0FuwGnl1dUI5nQHYWZDKaeO8vbtMYOXDJTDU
	hhRzwsUAJQND/26unHpYpmP318NzdVAS/OreUMwAZRy35Tet765SM2Qdct/IVA2HIaIgG/
	bbSfMt9oi0GYjPGZOPYHVKnvii7DM0a17nEtnGDowdBTgic5RlmvfO0PB4bYxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1778513227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oI2jZkU0j7/tmX5K7c3awpgTpBBjJrmE1UydFF1lCZk=;
	b=Yg8cKK3qZBZ1fV1zb+KubzVNunQ8CkveDOcdtc4/7fNFYOt8UtzYGX961jE9Mm7+xeqbP0
	lQuqWkcVtJvCTKDg==
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Xin Zhao <jackzxcui1989@163.com>,
	Kees Cook <kees@kernel.org>,
	Osama Abdelkader <osama.abdelkader@gmail.com>,
	linux-serial@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Joseph Tilahun <jtilahun@astranis.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH tty v5 0/3] 8250: Add console flow control
Date: Mon, 11 May 2026 17:32:59 +0206
Message-ID: <20260511152706.151498-1-john.ogness@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

As requested by Greg [0], this is a resend of the last 3 patches from
v4 of a series to implement console flow control for the 8250 serial
driver. v4 is here [1] (including all the details about the entirety
of the series).

John Ogness

[0] https://lore.kernel.org/lkml/2026051134-revisable-sherry-e5b5@gregkh
[1] https://lore.kernel.org/lkml/20260506121606.5805-1-john.ogness@linutronix.de

John Ogness (3):
  serial: 8250: Set cons_flow on port registration
  serial: 8250: Check LSR timeout on console flow control
  serial: 8250: Add support for console flow control

 drivers/tty/serial/8250/8250_core.c |  6 ++++++
 drivers/tty/serial/8250/8250_port.c | 21 +++++++++++++++++----
 drivers/tty/serial/serial_core.c    | 21 ++++++++++++++++++++-
 include/linux/serial_core.h         |  8 ++++++++
 4 files changed, 51 insertions(+), 5 deletions(-)


base-commit: 4a9a0b1a82a8b23eb68032dd19b120e82cd67004
-- 
2.47.3

