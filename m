Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="Qgm79yfy"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2834BD;
	Mon, 11 Dec 2023 09:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=aaEer9pudS/c8D2BByKXGhQ3YN3/xyWWrP78YkybY7w=; b=Qgm79yfyq7y322Vd2gcF4MfK4v
	mLJF4PM/q+uGiyL8NpxAYe515C3j8JKzIHgSc3E1gbfNUfv8Ej9jpOi9w/gw2FnS7zzH7HHOSm99c
	L7mc69O1xHKEWiCZME7gP8JbSRLJR+5tzSEaihh5X/tYBsmNqQXPxXMk5j7NKf55gHak=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:56730 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rCjqw-0003yC-1y; Mon, 11 Dec 2023 12:13:59 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hvilleneuve@dimonoff.com,
	jringle@gridpoint.com,
	tomasz.mon@camlingroup.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com
Date: Mon, 11 Dec 2023 12:13:47 -0500
Message-Id: <20231211171353.2901416-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
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
Subject: [PATCH v2 0/6] serial: sc16is7xx: regmap fixes and improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series brings fixes and improvements related to regmap access
for the sc16is7xx driver.

Most of the patches are related to commit 3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port").

I did not originally add a "Cc: stable" tag for the above mentioned commit,
as it was intended only to improve debugging using debugfs. But since then,
I have been able to confirm that it also fixes a long standing bug in our
system where the Tx interrupt are no longer enabled at some point when
transmitting large RS-485 paquets that completely fill the FIFO and thus
require multiple and subsequent writes to the FIFO once space in it becomes
available. I have been investigating why, but so far I haven't found the
exact cause, altough I suspect it has something to do with regmap caching.
Therefore, I have added this commit as a prerequisite for some of the
patches in this series so that it is automatically added to the stable
kernels.

I have tested the changes on a custom board with two SC16IS752 DUART over
a SPI interface using a Variscite IMX8MN NANO SOM. The four UARTs are
configured in RS-485 mode.

I did not test the change on a SC16is7xx using I2C interface, as my custom
board is only using SPI.

Thank you.

Link: [v1] https://lore.kernel.org/all/20231130191050.3165862-1-hugo@hugovil.com

Changes for V2:
 - Refactor patch 1 to avoid a truncation warning when using "%u" in
   snprintf.
 - Keep only fixing patches in this series. Non-fixes patches will be
   resubmitted in a new separate series.
 - Add 3 new fixing patches (4 to 6).

Hugo Villeneuve (6):
  serial: sc16is7xx: remove wasteful static buffer in
    sc16is7xx_regmap_name()
  serial: sc16is7xx: remove global regmap from struct sc16is7xx_port
  serial: sc16is7xx: remove unused line structure member
  serial: sc16is7xx: change EFR lock to operate on each channels
  serial: sc16is7xx: convert from _raw_ to _noinc_ regmap functions for
    FIFO
  serial: sc16is7xx: fix unconditional activation of THRI interrupt

 drivers/tty/serial/sc16is7xx.c | 104 ++++++++++++++++++---------------
 1 file changed, 56 insertions(+), 48 deletions(-)


base-commit: e045e18dbf3eaac32cdeb2799a5ec84fa694636c
-- 
2.39.2

