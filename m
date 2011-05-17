From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/2] tty/serial: Add PORT_TEGRA, fix break handling for it
Date: Tue, 17 May 2011 13:27:44 -0600
Message-ID: <1305660466-4704-1-git-send-email-swarren@nvidia.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-l3A5Bk7waGM@public.gmane.org
Cc: ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

8250.c needs a specific PORT_TEGRA type for two reasons:
* RTOIE bit needs to be set, but UUE is reserved, so split RTOIE handling
  out of PORT_XSCALE.
* A WAR is needed for break reception.

I'd like to get the first of these two patches merged into the tegra
arch for-next branch, so that I can modify the board files to explicitly
request the new port type rather than relying on auto-detection. As such,
could you please create a branch for that/these changes, then merge it
into tty-2.6.git, so that the same branch can be merged into Tegra's
for-next branch. Thanks.

Stephen Warren (2):
  tty/serial: Add explicit PORT_TEGRA type
  tty/serial: Fix break handling for PORT_TEGRA

 drivers/tty/serial/8250.c   |   37 +++++++++++++++++++++++++++++++++++--
 drivers/tty/serial/8250.h   |    1 +
 include/linux/serial_core.h |    3 ++-
 include/linux/serial_reg.h  |    2 ++
 4 files changed, 40 insertions(+), 3 deletions(-)
