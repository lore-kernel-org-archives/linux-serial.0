Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2514071CA;
	Mon,  7 Sep 2026 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763502; cv=none; b=CSoFunI0w5j4b9MeE6kOcrpYbsnYBiZVyQJFetHDa72i3JmQaGOALhmlEfTug+JpiA5jNXZho6PMiwZ4QsWgEZbdZ7yYtHT1FpDXpr8GXjc5w8dYRJ/JvTvz7aDRKXFJJRIKTHRP2d8XYUZFD689mM4zYE1Gopt/inRJebju5K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763502; c=relaxed/simple;
	bh=py9TLAgwbzYFwuTFBIiqUl8pkjHZ5pCK2HZtU/6UJFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f9hwj5IkpCrzBMu87gK9hu2eQ4AFXPzXhxmcMVYox3EN4gSi7nT5wL31/EdLbs80fmGi/4cn2bF06McE+iIgA1RQwVJhLmkjRmmFsx4GDbKQLu4Ooi53R7HT1tbZ/TWhuj34y3AOyVFMHoJ30pNI283KbM19dsKRCUBX4s0XvR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tbncs/kk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tbncs/kk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974261F00A3E;
	Mon,  7 Sep 2026 06:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788763500;
	bh=GnL46wrTz2kWX2SmHsUS0YfqjTi6wsOs1uN7GKUqHXo=;
	h=From:To:Cc:Subject:Date;
	b=Tbncs/kk4fXS3GqV/KCQ8pxzspp0CAnJxnYKaRZlc/tQiKV17yIedELKJcPC1/CLG
	 bC5lvcIi4edNDKW5fooqVswkfb9v8TD3ytQCtGqHQ5KED4N8Gq+dGQfdnUVj1uo6jG
	 hVbtLJlygZlWeXFmhDAGznomMj02QScojaVsj7RW5zBdTPYj5zer/SeDW9TnmUfjLE
	 LqztUenJoEYRjVJ40dHHPzRuDTBY5V3ltbyg3XaKa+5pbDbbgiOAbZwaU0objrNdXd
	 sQ9qmPZIkXMb5FxHSMIUAJYpCNKW6fpKh143Lox8mFhK4jzgbvxq6kUhpkbU8PWVLG
	 vFbcYRY/QUpKg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3T69-00000000OC2-3aH8;
	Mon, 07 Sep 2026 08:44:57 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH v3 0/4] serial: fix ioctl hangup race
Date: Mon,  7 Sep 2026 08:44:14 +0200
Message-ID: <20260907064418.92953-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tty ioctls can race with hangup and end up calling into a tty
driver for a device that is already gone or powered down.

Included in v3 are also two related fixes for issues highlighted by
Sashiko.

Johan


Changes in v3
 - revert guards in uart_wait_modem_status()
 - fix race in TIOCMIWAIT (new)
 - abort TIOCMIWAIT on hangup (new)

Changes in v2
 - include TIOCMIWAIT which also access hardware
  - replace broken scoped_guard() construct in wait loop


Johan Hovold (4):
  serial: revert guards in uart_wait_modem_status()
  serial: fix ioctl hangup race
  serial: fix TIOCMIWAIT race
  serial: abort TIOCMIWAIT on hangup

 drivers/tty/serial/serial_core.c | 50 +++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 13 deletions(-)

-- 
2.55.0

