Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB4E3A1C9;
	Sun,  8 Feb 2026 06:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770531971; cv=none; b=oI0Axlgj+NNBg6sTrbBUGeDQpE8FeBYcW+trEM4WA5URX4bPwFMo8b7BsKN2Z9Ucp9+7WkW3ZdRwr5EhJDGveXrgZObGNWb2KUBj0scP0BAhFUR4haC5hmfTiYU4ff2itxR9ngySLa4/vIJiibk7rug1mvwaEPRDN09cacnULY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770531971; c=relaxed/simple;
	bh=tT5Cn7I1ie77p4tSMWCoNdRxpUjP8Va6svkAlWLwnsE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PuEaF1y05SeSsZaxjZpYCdI7Jt/kpvipZtI2fYS2lexHJLgKjySHl1+ICoMAy8AxWcqHg0OLJ2Ke1v5ZAiIbRuqqu2lcBH+Vk0C6esfUXIOkwwajhTjnQV6Oes3nbqvma4bbLs1/iqVgQKHcgG0Frp1mbCdFbYJ0xVU+BhPgkZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [218.12.17.94])
	by mtasvr (Coremail) with SMTP id _____wBHxnBoLIhpVdGSAA--.12724S3;
	Sun, 08 Feb 2026 14:25:46 +0800 (CST)
Received: from ubuntu.localdomain (unknown [218.12.17.94])
	by mail-app2 (Coremail) with SMTP id zC_KCgD3EEVkLIhp45u5BQ--.23362S2;
	Sun, 08 Feb 2026 14:25:44 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jikos@kernel.org,
	dsterba@suse.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	kuba@kernel.org,
	alexander.deucher@amd.com,
	akpm@linux-foundation.org,
	pkshih@realtek.com,
	tglx@kernel.org,
	mingo@kernel.org,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] tty: ipwireless: Fix use-after-free in tasklet during device removal
Date: Sun,  8 Feb 2026 14:25:38 +0800
Message-Id: <20260208062538.29608-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgD3EEVkLIhp45u5BQ--.23362S2
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwMPAWmHlYcDxgABs2
X-CM-DELIVERINFO: =?B?YttiAAXKKxbFmtjJiESix3B1w3uoVhYI+vyen2ZzBEkOnu5chDpkB+ZdGnv/zQ0PbP
	CR1w8GsfJQzmAq1cHhaxNT+qPA3D992N8znMd1+DWWIGr/7CEgkmMurtyzTA4UjreQs4B/
	coVP/6qI5ARQuOJ5bNzDKmQ2SAb0euAd1f9AkxQJQlhnpD24zyZxQTFEYCyWRQ==
X-Coremail-Antispam: 1Uk129KBj93XoWxJryxKFWfZw1fXw4ktr1UJwc_yoW8Ar48pF
	W8Gw4qkFW8Kr1jvw4jqa1xZry8Xas3KFy7Wr4vk3yrZr1rJr10qrnxAa4DGr45KayUZ3Z5
	Wrn0qr15Gan2yFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Kb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvr2IYc2Ij64
	vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I
	3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxV
	WUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAF
	wI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j
	6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7xwIDUUUU

When IPWireless PCMCIA card is being detached, the ipw_hardware is
deallocated in ipwireless_hardware_free(). However, the hw->tasklet may
still be running or pending, leading to use-after-free bugs when the
already freed ipw_hardware is accessed again in ipwireless_do_tasklet().

One race condition scenario is as follows:

CPU 0 (cleanup)               | CPU 1 (interrupt)
ipwireless_hardware_free()    | ipwireless_interrupt()
  ipwireless_stop_interrupts()|   ipwireless_handle_v1_interrupt()
    do_close_hardware()       |     tasklet_schedule()
      synchronize_irq()       |
  kfree(hw) //FREE            | ipwireless_do_tasklet() //handler
                              |   hw = from_tasklet() //USE
                              |   hw-> //USE

Fix this by ensuring hw->tasklet is properly canceled before ipw_hardware
is released. Add tasklet_kill() in ipwireless_stop_interrupts() to
synchronize with any pending or running tasklet. Since do_close_hardware()
could prevent further interrupts, place tasklet_kill() after it to avoid
the tasklet being rescheduled by ipwireless_interrupt().

Fixes: 099dc4fb6265 ("ipwireless: driver for PC Card 3G/UMTS modem")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/tty/ipwireless/hardware.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/ipwireless/hardware.c b/drivers/tty/ipwireless/hardware.c
index e18848267be..c736cba751f 100644
--- a/drivers/tty/ipwireless/hardware.c
+++ b/drivers/tty/ipwireless/hardware.c
@@ -1725,6 +1725,7 @@ void ipwireless_stop_interrupts(struct ipw_hardware *hw)
 
 		/* Prevent the hardware from sending any more interrupts */
 		do_close_hardware(hw);
+		tasklet_kill(&hw->tasklet);
 	}
 }
 
-- 
2.34.1

