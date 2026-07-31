Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01133B19CA
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 18:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521034; cv=none; b=fjWrdzpSkMiT66Wv/bFfHrEFP3RFZhIzAEZzmYTFYW7WtglU+kuTCt5KLi+8takdqsUON1rnAw2U1nOzpB1Wtk3/+U+nD+UmsTc2/WlKpexzxb2rHbC4l/y42DfYtk7J3g5fwbMgZigDeyVDsKxIi3GOk/2dg4yxGgy/o2gDpmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521034; c=relaxed/simple;
	bh=UnIwtfXNjLpC1Ihz9kKhZCxir32MMPCFCV40pupJOyw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q6Ni8dGYEXD5kvnVcXAOljZyAjcQpMwW+ZhjOt4aGUwRfn4/N1nftHkZkpHQuCf3bQPa31XMqkyFxmKCP3CT6QQBYodYw2/taQpsTFENJ+eoXBhnJ/ax0IfTpEmqb34wt0yy7iOSfvZwB00AG4BTFF/VVAyGNK8IjQN2Ld/b3PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jC7RYNFC; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jC7RYNFC"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f633e6058so1335535f8f.0
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 11:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785521031; x=1786125831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z3rxXlGHbXQONq0nbuDOk1X0SJF+agPubKPIOuTmpB4=;
        b=jC7RYNFCQ9j7SkbOkGU3wY18IDiGMx58mbs7oe3tP8HGJ5Rh3TvMQ3L5bzzF/v90fC
         2xYFlHB/YiZYjpfH+UdSkAa8vFc7UPmTnz/RmdjrRiR1XmKfpjxjY+9CKaL7y2DzsEoP
         JhmloKnIpufU15LjNDGYw9om6P0avNf0DErLCWk/+ASQLUsxr06mPO05v24uubfAxVU6
         yuykQ4SCx5HEHKnYGSDab4GO2BpFA2QDND4Yqx/CtJbbl8825bMqV5RdXdO6o63vo8xd
         IQZed0vKixyjTPEKoJtG62s+mM02WCzJLQVRocTeREbXOpsfOS+hx9WTs93Mjn2ihSl/
         768g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521031; x=1786125831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z3rxXlGHbXQONq0nbuDOk1X0SJF+agPubKPIOuTmpB4=;
        b=lFmK5/XU2zZwEOvvzgJ0uUBiYWVjImT48LB6+yGNoz1kWs+mAqD0qmP12xsdlVLYs1
         EfcfjkU3cR32mxLCfEaMWi21AwaIHPiV6PTMmn+RHBmQc3vkcBMKdqrIPHvtTXVYmYhW
         L9e5BPkV4sJaaQDQRepEt9U0e4a210wtymDG/A7Xa9dXrGKZWpvdfa22pDw+ARYwi+/I
         aTCxFKpcftXRdm83nifNpTItMDqZYif8B3caNCIiLgewfkslMOHXdboS5pF61FcpkvoI
         WtA3m0+8s96xRUspluC41/uI5Y47CHhdSpe8rCF9kL1OVv7xdfAEYqFctP1E9STFD3Eq
         VgdA==
X-Forwarded-Encrypted: i=1; AHgh+RqiJq/ysbNrYtkrT2kruiSS6jKxKaZWmA8GV7DzK+ObnFinbrfTvyQHdYKYWztFQb/OFPlVTnAFby8aDVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyJYsNjkt9+8+JEAernW3Q8ieiqruVLJo4tGj21IvPsBNvaPR+
	0chQcJi0q4i4RXbB7kVt2VxzRFT1ev5mlYYy2DK0ia2lDABgP96WmDE5
X-Gm-Gg: AR+sD11SoWdjbKvpotgwZyjmR52MSs1gF2yI9WIMPABJU1dxT8CyBhwYZ4IEUGf6GBY
	F+/fbLznG+l4LtWqsqJXRKV5TWN3Z4a1pq/C5YOd8O/2UvZSI+WDywVlKih10UvlZrMtz3/fzDx
	xqIlGcwa+GM4LtoYn3LjCutkFHJ9r4oQoOg+GPw8HcdsoXfBsAGkT/93K0QiFOYZhJy5BsrBj2m
	X7wGtZmz5U82icY/ZE3875p2wt5boBS33MknhCqbuLg4GWpeQgM8uviIJsN1eAJ0Cgygmd7FPjL
	FnI5k+I02C0EDel+g3Szg7mK+KXsE0GFwc5OuDBw32A3S9WkDuQD04Tk5rVUvErTt3B4xX4MRc/
	eyXEpiynKc1uRX5hXKPAGAjLpdJlQV+sD7yYJabrDjB9bYQhzJZhgpuNotlZdMQfOh436Abf2m6
	Gbt/j90IJz86j/SqjG7Aqy1TSU7MQT8fuZke+3QvqMUPIHcVex9vwLrIbOajY/7Q6m/z4lDFzvY
	/ZzPNyCHGMTEVEB6onLlBNkqqPm3IqShzcU9Qh6WxqbE/SQGApjzEVAO00BynkJz+Izokif+j8E
	5TRXlvJZzHTGgGC/nr1uTOM2UVH6nzHHATmEDxKQi4IyqqwsWG/myPt7cEuMFFb5QW4w
X-Received: by 2002:a05:6000:4693:b0:470:2fb1:3dbc with SMTP id ffacd0b85a97d-47fd72e0638mr836970f8f.35.1785521030885;
        Fri, 31 Jul 2026 11:03:50 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a8d0-bc01-6d31-3d12-3a11-d2d0.310.pool.telefonica.de. [2a02:3100:a8d0:bc01:6d31:3d12:3a11:d2d0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd42d91bfsm7878295f8f.15.2026.07.31.11.03.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 11:03:49 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 0/5] serial: fix console lifetime bugs on failed bind and removal
Date: Fri, 31 Jul 2026 20:03:43 +0200
Message-Id: <20260731180343.10818-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes four serial/tty error-path bugs and an i.MX console
port-table lifetime bug. The fixes were found with failslab fail-nth sweeps
and sysfs bind/unbind sequences under KASAN on QEMU's raspi1ap and
mcimx6ul-evk machines.

Patches 1-4 fix shared serial/tty core code. They move fallible allocations
before console registration, clear pointers after uart_driver registration
fails, and make a non-NULL tty cdev slot mean that the cdev is live.

Patch 5 clears i.MX's devm-allocated port-table entry after failed probe and
removal. It keeps the entry valid through console unregistration, rejects
duplicate lines and serializes table updates against other port probes.

Validation includes fail-nth sweeps on both boards. The i.MX tests also
cover the sibling-probe race, sequential unbind/rebind and
CONFIG_PROVE_LOCKING=y.

Changes in v3:
- Drop Cc: stable from patches 1-4.
- Patch 1: remove redundant uport->name clearing and credit Sashiko's report
  with Reported-by and Closes trailers.
- Split v2 patch 3 into two patches with corresponding Fixes tags.
- Shorten the changelogs.
- Patch 5: use scoped guards, reject occupied slots, remove the unnecessary
  line variable, document the console-callback locking constraint and add a
  backport note.

Changes in v2:
- Patch 4: serialize port registration and removal with imx_uart_ports[]
  updates to close the reported sibling-probe race.
- Patches 1-3 are unchanged.

v2: https://lore.kernel.org/r/20260719221014.44354-1-kmehltretter@gmail.com
v1: https://lore.kernel.org/r/20260719160812.35407-1-kmehltretter@gmail.com

Karl Mehltretter (5):
  serial: core: do fallible allocations before the console can be
    registered
  serial: core: clear freed pointers on uart_register_driver() failure
  tty: skip cdev_del() when no cdev is registered
  tty: clear cdev pointer after cdev_add() failure
  serial: imx: serialize imx_uart_ports[] lifetime

 drivers/tty/serial/imx.c         | 20 +++++++++++++++++---
 drivers/tty/serial/serial_core.c | 32 ++++++++++++++++++--------------
 drivers/tty/tty_io.c             |  6 ++++--
 3 files changed, 39 insertions(+), 19 deletions(-)

-- 
2.53.0
