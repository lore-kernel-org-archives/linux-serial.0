From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 0/8] serial: tegra: various fixes
Date: Tue, 5 May 2015 15:17:51 +0100
Message-ID: <1430835479-6613-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Various fixes for the tegra hsuart driver.

Tested on tegra124 nyan-big by opening a serial console on ttyTHS0
and performing simple z-modem transfers.

Jon Hunter (6):
  serial: tegra: Correct delay after TX flush
  serial: tegra: Add delay after enabling FIFO mode
  serial: tegra: Use unsigned types for RX and TX byte counts
  serial: tegra: Fix cookie used by TX channel
  serial: tegra: Correct shutdown of UARTs
  serial: tegra: Correct error handling on DMA setup

Shardar Shariff Md (2):
  serial: tegra: check the count and read if any from dma
  serial: tegra: handle race condition on uart rx side

 drivers/tty/serial/serial-tegra.c | 128 ++++++++++++++++++++++++++------------
 1 file changed, 87 insertions(+), 41 deletions(-)

-- 
1.9.1
