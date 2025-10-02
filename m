Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905C018A6D4;
	Thu,  2 Oct 2025 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759417077; cv=none; b=loxGSzquYKgvbRmmKZBSOWMKTfSQg5YmJVP/3KbCld0G3KkmoR4gNS1C0qlimrobrw8SVACM2lOWUl+3L3EtEnPXToFy/NcvuHA3MQkeA+RHbNTukunQ24LWqdDXNzsO0EHJqIcZ/Qn9kBS+a/ZYWhPUSA/l2/if7OWJUgv1Zco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759417077; c=relaxed/simple;
	bh=Osl3lK+5GNxpDMlWvdjfwsvcGaI1ktVUOuV66qZLqCc=;
	h=From:To:Cc:Date:Message-Id:MIME-Version:Subject; b=Ub1/xyv2OOic4LkxyiuMu1Vj2HTgG5kG2q7oDZLcrTEUpWsKlqdBIiF0GvpTNW67XghqYWd42tnWLqOxEzzx5kNKayRVrSPHuynGlCCK0linj396XLxSGilpZ5BPYWqJFcNS8u3cz2joRj+fMDpw/9dhkqYo8ds+TVW/hkMLNAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=ZG2ovfqI; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="ZG2ovfqI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=C9Rys4W+wB/rglzOsk7PUg+JPAxU5qbHWAO6MUD+azI=; b=ZG2ovfqIirwpM6loZkvJ3c3Vky
	S1RVy/6G39KZYCHeaalfzy2/O0zXGrhS3DY7SZiBCZJNNa/gQVKctgYSv5/qsuTdbV8M3GgvlvPyB
	XV92ZXIOT8AsUOggklfo6ByfsKcKcWJTp3fZ9KcgEsB14zeTcJdH28nQBVP5+19S/yyM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:59004 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1v4KkZ-0005hy-JI; Thu, 02 Oct 2025 10:57:44 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	fvallee@eukrea.fr
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu,  2 Oct 2025 10:57:23 -0400
Message-Id: <20251002145738.3250272-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH v2 00/15] serial: sc16is7xx: register access fixes and improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series brings some fixes and improvements to the register
accesses for the sc16is7xx driver.

It also adds some minor improvements, and cleanups to uniformize code
style accross the driver.

I have tested the changes on a custom board with two SC16IS752 DUART over
a SPI interface using a Variscite IMX8MN NANO SOM. The four UARTs are
configured in RS-485 mode.

I did not test the change on a SC16is7xx using I2C interface, as my custom
board is only using SPI.

Thank you.

Link: [v1] https://lore.kernel.org/linux-serial/20250924153740.806444-1-hugo@hugovil.com/raw

Changes for V2:
- Patch "change incorrect indentation": move to same line and reword (suggested
  by Maarten Brock)
- remove superfluous rc variable (suggested by Jiri Slaby)
- replace guard with scoped_guard() in sc16is7xx_ms_proc()
  (suggested by Jiri Slaby)
- Patch "use dev_err_probe() instead of dev_err()": remove original dev_err()
  line and reword (suggested by Jiri Slaby)
- Patch "remove empty line": remove useless cast and reorder variables
  for reverse xmas tree (suggested by Jiri Slaby)
- Simplify to_sc16is7xx_one() macro
- Reformat some multi-line comments up to 100 columns (suggested by Jiri Slaby)
- Remove typo cleanup from patch "add/improve comments" and move to patch
  "reformat comments to improve readability"

Hugo Villeneuve (15):
  serial: sc16is7xx: remove useless enable of enhanced features
  serial: sc16is7xx: rename LCR macros to better reflect usage
  serial: sc16is7xx: rename EFR mutex with generic name
  serial: sc16is7xx: define common register access function
  serial: sc16is7xx: remove unnecessary pointer cast
  serial: sc16is7xx: use guards for simple mutex locks
  serial: sc16is7xx: drop -ENOMEM error message
  serial: sc16is7xx: declare SPR/TLR/XOFF2 register as volatile
  serial: sc16is7xx: move port/channel init to separate function
  serial: sc16is7xx: simplify to_sc16is7xx_one() with a single parameter
  serial: sc16is7xx: Kconfig: allow building with COMPILE_TEST
  serial: sc16is7xx: use KBUILD_MODNAME
  serial: sc16is7xx: change conditional operator indentation
  serial: sc16is7xx: reformat comments to improve readability
  serial: sc16is7xx: add comments for lock requirements

 drivers/tty/serial/Kconfig         |   2 +-
 drivers/tty/serial/sc16is7xx.c     | 420 +++++++++++++----------------
 drivers/tty/serial/sc16is7xx.h     |   1 -
 drivers/tty/serial/sc16is7xx_i2c.c |   4 +-
 drivers/tty/serial/sc16is7xx_spi.c |   4 +-
 5 files changed, 187 insertions(+), 244 deletions(-)


base-commit: f4abab350840d58d69814c6993736f03ac27df83
-- 
2.39.5

