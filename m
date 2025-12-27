Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409713148A6
	for <linux-serial@vger.kernel.org>; Sat, 27 Dec 2025 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837811; cv=none; b=rTZlPq26/bf3bkG6Y7r/SknKff38K344uvvSyQ1LQ6BxstNwA5nATUwm0sSKY2CMar/8+HUX5TwvKUNBlk+cjVxL5c1ZgKHVO863K3rpAsRAPDA09Jg0WT5hEbuJBU5uu+d49WZzNYoLrENNOVgeQUZBz1lQPF0yMaxfiQLM5Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837811; c=relaxed/simple;
	bh=pGCwrx7s/pzxpnqEvxnowKr5kIMRsCkFnk8/FBkLNPk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=gEqmawIXwPKQa3/Qvv2skhJPFElnc7d6Hn6tTvlSAiLVzruHP0GCLolxbegFRD8GZHxOHiZjAijzuLFpb0/RA34z/D6+e/9NeeWHWNPcxAQgiSSuEGXwIleUwa+CwZbD+UHANWxfmpg9G5ysMrsY+vGjmNVkNwLvGnSPedY77nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MojoTYPn; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MojoTYPn"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-477aa218f20so47217245e9.0
        for <linux-serial@vger.kernel.org>; Sat, 27 Dec 2025 04:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837808; x=1767442608; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTn0eoJ78H/BcwAZAT5V21TN0j41vlUozcdKxdaozdI=;
        b=MojoTYPn/vh9i9P9d2ImtnGnIixYN91e76gt2hx7oaH6OJ6IrXG/HqKhGa8E2Rlgqr
         0u6TwhL3XPT1GJyH6xI2vueGEO1Ois6gdP0nCZ0QW3Hrkv8E+F3OrqxZDTeAmuBOfrb+
         IVLZ98txfxesz5mk5+jkFuBBJ0Zdd2qgv4ODqJs/ETAw85AwtInKw+meS8G/qfIU2zJm
         14RrfzVhuh0eq2+/nj8qikylbPxilDSo1g4HvWw4qMehcNb3eAIAb2HpO8V/mxNhEeUd
         Yjf+9cHbWyLW7ED7Hqbq7IgFTD/CMdflMGEHQR/XPHZ56X9uP8I0U0iBy2VlkDZ+X+wa
         KQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837808; x=1767442608;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTn0eoJ78H/BcwAZAT5V21TN0j41vlUozcdKxdaozdI=;
        b=Lbrs1wEwxLtrEDRxU4q1QULV1jfF5mWiM4fl5e+cM9y13ykGWCZMp3jeawDQuIIHcY
         qiHBmn5t4OQhf9V1svKBUubIIPh9gx0sYmgHMyhRcS3E0a6uor10SMw67aekwtCAIohE
         XEpz014VnWCwXqKsrfZrrLo7PweOiSgLIejRa+L1v91umN09JPMvjePGfSbS/lHCyq/1
         jRnXNWqD4L3IjYmHxOODCorY+EcBOor/uaGv4m/SSWMxZX9TZTwrG52x1T5vkv12XnhY
         j9CgQp99ZPw9NvQCFzkvOaVritipTbvZkTKseGo97CVHsLHKFoAcZDB8DzHnt88XJgG0
         uJbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLzaLefx0iPUHRj02qp6uccjY/fUydT0VYKDrGwkR5llwlIEun7ArGCCdKqmR/IgwYXkbBMJeytD4wkts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtbSEXmFySeV6NLv/l9EDEACHlW40txX2gVF6U0q2gHDJX7ap4
	gbl64XyCKEb5vlmBujyZmGaB8PNMtqi0n4rPbQBqzjJltf0DqJLXgT/lWVuswmPyOzE=
X-Gm-Gg: AY/fxX6MFIdSeV6FNtN7zmjgWl+cwg42XaZlcSctpjho6tEpqgVTjjqoyQHZF+pposN
	TZH5k1vQK/yv83hL4MQnctlUvQLIBoaBtQRZSeDI+5sQBSytTyhviiMVunxUahVD90QjIkcWm1O
	LwneKFdoQigKCVCsllgVPoXGqI7OK8+jPCJ+0/Gp3pKtZ7HfJbORUyTcNXMWtdSCXxZzbzxrflL
	X1gkkwm0BaZ1Fayron4fI8AUaScTuXK95fX6ztbxI7JYuuMe8rp6T1nSlizPq32/PHwKRUYGhdZ
	gisJ+XmXPuTzzIEDylZPyFM5gI1B8avGVfU2hYbSTexCxtLlp6ODGNbXG0P3/+csX3w4aL7ddY5
	8G9AfmLRFWL9+BbaPyv7t8ImFSlmtwB5NaMD23JXZH4DbBL4yegYeDt75aSUwfnH3/g6vRnMdme
	MH5ZHvtTQzwRSg/8bLLz0=
X-Google-Smtp-Source: AGHT+IGAwYPYNfJmaY9Q33nFH+RhwoM5QU0IvIHlZhMLVrSDLSWfjJCihtYGJekOl50CWdODgpBmVA==
X-Received: by 2002:a05:600c:c086:b0:47b:e0ff:60f9 with SMTP id 5b1f17b1804b1-47d19577114mr202487205e9.20.1766837807525;
        Sat, 27 Dec 2025 04:16:47 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:16:46 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 00/19] printk cleanup - part 3
Date: Sat, 27 Dec 2025 09:16:07 -0300
Message-Id: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAfOT2kC/x2MwQpAQBBAf0VzNmVsHPyKHAaDidY2i5T8u83l1
 Tu890AUU4nQZA+YXBp190koz2BY2M+COiaHsigrSsBg6o8Vh03YnwED2+FQmKjuiXrHNaQ0mEx
 6/9u2e98PHmJw7WYAAAA=
X-Change-ID: 20251202-printk-cleanup-part3-ea116b11b3a6
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
 netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=4070;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=pGCwrx7s/pzxpnqEvxnowKr5kIMRsCkFnk8/FBkLNPk=;
 b=DtTvQmWwxI8nBiz56K8JWeAXva4ZUTP1TZfMsHc/t23MukO3Q9HDBbWL5zjE/2eZrLFOXevOl
 63plshGMBJVDC6pfWYfhJHhdbEMnrJWz9+G+dP9Hv10iWAGuGbiHgYC
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The parts 1 and 2 can be found here [1] and here[2].

The changes proposed in this part 3 are mostly to clarify the usage of
the interfaces for NBCON, and use the printk helpers more broadly.
Besides it, it also introduces a new way to register consoles
and drop thes the CON_ENABLED flag. It seems too much, but in reality
the changes are not complex, and as the title says, it's basically a
cleanup without changing the functional changes.

This patchset includes a patch from part 2 that needed more work [3], as
suggested by Petr Mladek.

These changes were tested by reverting f79b163c4231
("Revert "serial: 8250: Switch to nbcon console""), and used qemu to test
suspend/resume cycles, and everything worked as expected.

PS: b4 --auto-to-cc added a bunch of people as CC, so I'm not sure if
I should remove some or not, so I'm leaving the list as it is. If the
patchset needs a v2, and you feel that you don't need to copied, just
let me know.

Thanks for checking the patches, and happy holidays!

[1]: https://lore.kernel.org/lkml/20250226-printk-renaming-v1-0-0b878577f2e6@suse.com/#t
[2]: https://lore.kernel.org/linux-serial/20251121-printk-cleanup-part2-v2-0-57b8b78647f4@suse.com/
[3]: https://lore.kernel.org/linux-serial/aSgeqM3DWvR8-cMY@pathway.suse.cz/

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Marcos Paulo de Souza (19):
      printk/nbcon: Use an enum to specify the required callback in console_is_usable()
      printk: Introduce console_is_nbcon
      printk: Drop flags argument from console_is_usable
      printk: Reintroduce consoles_suspended global state
      printk: Add more context to suspend/resume functions
      printk: Introduce register_console_force
      drivers: netconsole: Migrate to register_console_force helper
      debug: debug_core: Migrate to register_console_force helper
      m68k: emu: nfcon.c: Migrate to register_console_force helper
      fs: pstore: platform: Migrate to register_console_force helper
      powerpc: kernel: udbg: Migrate to register_console_force helper
      sparc: kernel: btext: Migrate to register_console_force helper
      um: drivers: mconsole_kern.c: Migrate to register_console_force helper
      drivers: hwtracing: stm: console.c: Migrate to register_console_force helper
      drivers: tty: serial: mux.c: Migrate to register_console_force helper
      drivers: tty: serial: ma35d1_serial: Migrate to register_console_force helper
      drivers: tty: ehv_bytechan: Migrate to register_console_force helper
      drivers: braille: console: Drop CON_ENABLED console flag
      printk: Remove CON_ENABLED flag

 arch/m68k/emu/nfcon.c                           |   5 +-
 arch/powerpc/kernel/udbg.c                      |   4 +-
 arch/sparc/kernel/btext.c                       |   4 +-
 arch/um/drivers/mconsole_kern.c                 |   3 +-
 arch/um/kernel/kmsg_dump.c                      |   2 +-
 drivers/accessibility/braille/braille_console.c |   1 -
 drivers/hwtracing/stm/console.c                 |   4 +-
 drivers/net/netconsole.c                        |  13 +--
 drivers/tty/ehv_bytechan.c                      |   4 +-
 drivers/tty/serial/ma35d1_serial.c              |   4 +-
 drivers/tty/serial/mux.c                        |   4 +-
 drivers/tty/tty_io.c                            |   6 +-
 fs/proc/consoles.c                              |   1 -
 fs/pstore/platform.c                            |   6 +-
 include/linux/console.h                         | 143 +++++++++++++++++++-----
 kernel/debug/debug_core.c                       |   6 +-
 kernel/debug/kdb/kdb_io.c                       |   6 +-
 kernel/printk/nbcon.c                           |  17 +--
 kernel/printk/printk.c                          | 140 ++++++++++++-----------
 19 files changed, 230 insertions(+), 143 deletions(-)
---
base-commit: 93d65587479cfc97c0d7e41b5e8c6378ca681632
change-id: 20251202-printk-cleanup-part3-ea116b11b3a6

Best regards,
--  
Marcos Paulo de Souza <mpdesouza@suse.com>

