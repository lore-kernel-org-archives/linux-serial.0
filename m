From: Marcel Ziswiler <marcel@ziswiler.com>
Subject: [PATCH v1 0/3] clk/serial tegra: uart related fixes
Date: Thu,  1 Nov 2018 02:52:27 +0100
Message-ID: <20181101015230.27310-1-marcel@ziswiler.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Marcel Ziswiler <marcel@ziswiler.com>, Thierry Reding <thierry.reding@gmail.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Stephen Boyd <sboyd@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Prashant Gaikwad <pgaikwad@nvidia.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


This series features some UART related clock issue fix and clean-up.


Marcel Ziswiler (3):
  clk: tegra: get rid of duplicate defines
  clk: tegra: ignore unused vfir clock shared with uartb
  serial: tegra: fix some spelling mistakes

 drivers/clk/tegra/clk-tegra-periph.c |  5 +----
 drivers/tty/serial/serial-tegra.c    | 10 +++++-----
 2 files changed, 6 insertions(+), 9 deletions(-)

-- 
2.14.5
