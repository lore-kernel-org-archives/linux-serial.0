Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from muru.com (muru.com [72.249.23.125])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 761C19C;
	Tue, 21 Nov 2023 03:32:43 -0800 (PST)
Received: from hillo.muru.com (localhost [127.0.0.1])
	by muru.com (Postfix) with ESMTP id F3A6C80CC;
	Tue, 21 Nov 2023 11:32:39 +0000 (UTC)
From: Tony Lindgren <tony@atomide.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Dhruva Gole <d-gole@ti.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v3 0/3] Add support for DEVNAME:0.0 style hardware based addressing
Date: Tue, 21 Nov 2023 13:31:54 +0200
Message-ID: <20231121113203.61341-1-tony@atomide.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

With the recent serial core changes, we can now add DEVNAME:0.0 style
addressing for the serial ports. When using DEVNAME:0.0 naming, we don't
need to care which ttyS instance number is allocated depending on HSUART
settings or if the devicetree has added aliases for all the ports.

This also allows us to also drop the old console_setup() parsing for
character device names.

Regards,

Tony

Changes since v2:

- Console name got constified and already applied as suggested by Ilpo
  and Andy

- Add printk/conopt.c to save console command line options

- Add a patch to drop old console_setup() character device name parsing

- Use cleanup.h to simplify freeing as suggested by Andy

- Use types.h instead of kernel.h as suggested by Andy

- Use strcspn() as suggested by Andy

- Various coding improvments suggested by Andy

Changes since v1:

- Constify printk add_preferred_console() as suggested by Jiri

- Use proper kernel command line helpers for parsing console as
  suggested by Jiri

- Update description for HSUART based on Andy's comments

- Standardize on DEVNAME:0.0 style naming as suggested by Andy

- Added missing put_device() calls paired with device_find_child()

Tony Lindgren (3):
  printk: Save console options for add_preferred_console_match()
  serial: core: Add support for DEVNAME:0.0 style naming for kernel
    console
  serial: core: Move console character device handling from printk

 drivers/tty/serial/serial_base.h     |  14 ++++
 drivers/tty/serial/serial_base_bus.c | 104 ++++++++++++++++++++++++
 drivers/tty/serial/serial_core.c     |   4 +
 include/linux/printk.h               |   3 +
 kernel/printk/Makefile               |   2 +-
 kernel/printk/conopt.c               | 115 +++++++++++++++++++++++++++
 kernel/printk/console_cmdline.h      |   4 +
 kernel/printk/printk.c               |  41 +++-------
 8 files changed, 254 insertions(+), 33 deletions(-)
 create mode 100644 kernel/printk/conopt.c

-- 
2.42.1
