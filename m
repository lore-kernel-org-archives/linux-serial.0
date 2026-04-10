Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41073DE420;
	Fri, 10 Apr 2026 15:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834447; cv=none; b=UjLWYLA+p4hSj9ebJx+NmBOiluH77v71WspKTMsh/IGj09iyjFDEnOPyxqqgyhTvop0HI1cblpswk4Axr41rtTUKyS+ctjseZ8abbEiz1fWps95zYI+QsfXHNOeKcvdLsa4P78bQIYf7sebl50ZHPfIAx/urDX2MUw88D7VjuWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834447; c=relaxed/simple;
	bh=+tUCFtiBgAcE+OORO65M5mIN0BUl5p13VMNyEkoSCTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W9fIzHD7niT85fxb6WB3UHxAXJwGppOl85w8f8bxxtQAL31Mn+jZxGZAze4MAw3x8wTGNX1BfroluFv8NlHySh2zbm3YeQKGtDjukpyuGNkZmviIkF3a2ByLQC3s0mehsG1w825EwXzcyWBw+VABtELZA1g1dgnYWxui8D0jvdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=OlKD5q+k; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="OlKD5q+k"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject
	:Cc:To:From:subject:date:message-id:reply-to;
	bh=HsrGhb/qfd7RX1ZikAcyoUfsyUlHcbWdfebRh8QR00I=; b=OlKD5q+kvNv0VndONJMlnZq1VJ
	ZaWDz7BrzjgvFSvaezuIeRaGPHSwnJUScJ4weoeTVxUhiDoVaxPw3z1qmlb8j+XWF3mT32SWnBj8y
	GBnaYF0xz9JqtnqrblbArWB3byxTnMqEI7nBUzMFtnhVOJyRJFzUVaam997KKnyWZ1Ns=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wBDew-000000008Ub-2BnM;
	Fri, 10 Apr 2026 11:20:39 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: hugo@hugovil.com,
	biju.das.jz@bp.renesas.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: [PATCH 0/5] serial: core: improve safety of uart_get_baud_rate()
Date: Fri, 10 Apr 2026 11:20:08 -0400
Message-ID: <20260410152022.2146488-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam_score: -1.0
X-Spam_bar: -

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

serial: core: improve safety of uart_get_baud_rate()

Hello,
this patch series brings some improvements to uart_get_baud_rate() by
making it safer.

This originate from a review and discussions of a patch by Biju Das [1] to
fix a potential division by zero bug in the Renesas serial drivers
sh-sci and rsci.

First the comments in uart_get_baud_rate() are extremely outdated and no
longer match what the code does, which does not help when trying to fully
understand what the function does. One of the patch in this series updates
them.

All drivers, except apbuart and icom, call uart_get_baud_rate() and do not
check the returned baud rate, because it is assumed that it cannot return a
zero value. However, not all devices support a speed of 9600, and for these
uart_get_baud_rate() could return zero for the B0 case. This in turn
could trigger a "Division by zero in kernel" fault.

To be clear, this doesn't originate from a crash report, but from analyzing
the code during the above mentioned review. To test this potential bug, I
simply modified the "min" baud rate passed as argument to
uart_get_baud_rate() to 19200 for the sc16is7xx driver, and was able to
trigger the fault with "stty /dev/ttySC0 0" set to a zero baud rate
(hang up).

Historically, there was commit 16ae2a877bf4 ("serial: Fix crash if the minimum rate of the device is > 9600 baud")
in 2010 to try to prevent a zero value being returned, and added a warning
to that effect.

Then commit 23bf72faaebd ("serial: core: tidy invalid baudrate handling in uart_get_baud_rate")
in 2023 removed the warning:

  uart_get_baud_rate has input parameters 'min' and 'max' limiting the
  range of acceptable baud rates from the caller's perspective. If neither
  current or old termios structures have acceptable baud rate setting and
  9600 is not in the min/max range either the function returns 0 and
  issues a warning.
  However for a UART that does not support speed of 9600 baud this is
  expected behavior.
  Clarify that 0 can be (and always could be) returned from the
  uart_get_baud_rate. Don't issue a warning in that case.

To remove any ambiguity, and to make sure all drivers handle the returned
value the same, make sure uart_get_baud_rate() will always return a
non-zero value in all scenarios.

This ensures that for devices that do not support a speed of 9600, and B0
is the desired baud rate specified in termios, then the returned value will
be 9600 or the input parameters 'min', whichever is the greatest.

Tested on a custom board with a VAR-SOM-6UL SOM and a sc16is752 DUART.

Thank you.

Link [1] https://lore.kernel.org/all/20260408142105.310210-1-biju.das.jz@bp.renesas.com/raw

Hugo Villeneuve (5):
  serial: icom: remove check for zero baud rate from
    uart_get_baud_rate()
  serial: apbuart: remove check for zero baud rate from
    uart_get_baud_rate()
  serial: core: update uart_get_baud_rate() obsolete comments
  serial: core: simplify clipping logic in uart_get_baud_rate()
  serial: core: prevent division by zero by always returning non-zero
    baud rate

 drivers/tty/serial/apbuart.c     |  2 --
 drivers/tty/serial/icom.c        |  2 --
 drivers/tty/serial/serial_core.c | 34 ++++++++++++++------------------
 3 files changed, 15 insertions(+), 23 deletions(-)


base-commit: a1a81aef99e853dec84241d701fbf587d713eb5b
-- 
2.47.3

