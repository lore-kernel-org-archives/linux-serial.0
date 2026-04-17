Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1683D346AC5;
	Fri, 17 Apr 2026 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440040; cv=none; b=Hw+XDTvNF0RnwHsEH6cmM0lqPuqk71vKxo4/FyrYQ5a8qWaRElHhhmdh3/eRndXyof9fZM94tBubAYcSQEg5Z/+GoaMbv8Trdqooz2ZMaw4MBTIfjQFSovH4aYKNjQC17IzKGquefApoTR8thz3ysrtWnzaKqeUHlZ3EZi0XfGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440040; c=relaxed/simple;
	bh=SaxzBJ37QIASNVAotLRF9iEMmuJHgODo9L84H8xFT/Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gmOqIVzB+awQJif1qjxkRMQe1PamYHpvRXtFB96ZVSKgv4bBbRVtTzpi8dIe1k1bpnM//NllNutaIeHflIxjScdKWuLZEtQBwRO9zw+HZGfsvy5zyvSupFX8kxGufGMkMzVBjNMOh5JntXFyKDQgWdoj2cYzWkXzUxUf4wNVy8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=meWLz6Qz; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="meWLz6Qz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Cc:To:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:From:subject:date:message-id:reply-to;
	bh=WXtw5a3Ao+9V+BZIiN7GYfc31fU1RhUlKaapU2p7O4o=; b=meWLz6QzadUKGC3z++iHZmZK57
	9HiCqWx7ovQKqTJqlbRmDOmdPlrPFGfmL7tyKIChyBbK3FYBBLupfAi4I8ukpdtEpubC3AE9jjTC/
	WJVg0lz/2bmvCQ63048iC8gr7U0vDJ82rrg7J8dGTrGIPTkkTj9/+VQ+KV3InTvBpW6M=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wDkZj-000000006G1-27eV;
	Fri, 17 Apr 2026 10:53:43 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
Subject: [PATCH 00/10] serial: max310x: improvements and cleanups
Date: Fri, 17 Apr 2026 10:53:27 -0400
Message-Id: <20260417-max310x-2-v1-0-b424e105ecac@dimonoff.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGdJ4mkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0Nz3dzECmNDgwpdI11LM9O0VEsjw8TURDMloPqCotS0zAqwWdGxtbU
 AIM4i7FsAAAA=
X-Change-ID: 20260417-max310x-2-965fe921aea6
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: hugo@hugovil.com, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>
X-Mailer: b4 0.14.2
X-Spam_score: -1.0
X-Spam_bar: -

Hello,
this patch series brings a few improvements and cleanups to the max310x
driver.

Note that I do not have access to a board with an actual max310x IC on it,
but I have tested it by using i2c-stub to simulate the four ports on a
virtual max14830 device.

Tests for patch "serial: max310x: use regmap_read_poll_timeout() for busy
wait":
Tested by setting the initial register values to 0x00, then loading the
driver with a (temporary) modified delay of 10s and using i2c-stub
to set register values to 0x01 after 5 seconds. Also tested by leaving
register to 0x00 and confirming the timout is properly handled.

Tests for reference clock computations:
Tested all possible frequencies from 5KHz to 35MHz in 1z increment
(osc mode) and comparing the resulting reference clock between the original
code and the new one, again using i2c-stub.

Thank you.

---
Hugo Villeneuve (10):
      serial: max310x: uniformize clock/freq types
      serial: max310x: simplify max310x_update_best_err()
      serial: max310x: change return type of max310x_set_ref_clk()
      serial: max310x: update baudrate comments for err calculation
      serial: max310x: improve max310x_set_ref_clk() efficiency
      serial: max310x: use regmap_read_poll_timeout() for busy wait
      serial: max310x: use FIELD_PREP macro to set PLL bitfields
      serial: max310x: allow driver to be built with SPI or I2C
      serial: max310x: move variables to while() scope
      serial: max310x: add comments for PLL limits

 drivers/tty/serial/Kconfig   |   2 +-
 drivers/tty/serial/max310x.c | 179 ++++++++++++++++++++++++-------------------
 2 files changed, 103 insertions(+), 78 deletions(-)
---
base-commit: a1a81aef99e853dec84241d701fbf587d713eb5b
change-id: 20260417-max310x-2-965fe921aea6

Best regards,
-- 
Hugo Villeneuve <hvilleneuve@dimonoff.com>

