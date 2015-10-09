From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/4] serial: tegra: One fix and a few clean-ups
Date: Fri, 9 Oct 2015 14:49:58 +0100
Message-ID: <1444398602-24020-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Fix a race condition in the receive path and simplify/clean-up the
serial-tegra driver.

This has been tested on a tegra124 by using zmodem protocol to transfer a
file from PC to the tegra device and verifying the downloaded file matches
the original.

Jon Hunter (4):
  serial: tegra: Handle another RX race condition
  serial: tegra: Remove unnecessary return statements
  serial: tegra: Remove redundant code and check in tegra_uart_stop_rx()
  serial: tegra: Add helper function for handling RX buffer

 drivers/tty/serial/serial-tegra.c | 94 ++++++++++++---------------------------
 1 file changed, 28 insertions(+), 66 deletions(-)

-- 
2.1.4
