From: Maxime COQUELIN <maxime.coquelin@st.com>
Subject: [PATCH 0/2] serial: st-asc: Couple of fixes
Date: Thu, 24 Jul 2014 14:02:54 +0200
Message-ID: <1406203376-18203-1-git-send-email-maxime.coquelin@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Srinivas Kandagatla <srinivas.kandagatla@linaro.com>, Patrice Chotard <patrice.chotard@st.com>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel@stlinux.com, maxime.coquelin@st.com
List-Id: linux-serial@vger.kernel.org

This series contains two fixes for ST's ASC driver.

The first issue addressed is a Kernel BUG when using the console on a different
ASC instance than the one being probed.

The second one is an overflow during buad rate calculation when requested rate
is higher than about 262Kbauds.

Maxime Coquelin (2):
  serial: st-asc: Don't call BUG in asc_console_setup()
  serial: st-asc: Fix overflow in baudrate calculation

 drivers/tty/serial/st-asc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
1.9.1
