From: Ryan Case <ryandcase@chromium.org>
Subject: [PATCH v2 0/4] tty: serial: qcom_geni_serial: Assorted cleanups
Date: Mon,  7 Jan 2019 17:58:34 -0800
Message-ID: <20190108015838.166271-1-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>, Ryan Case <ryandcase@chromium.org>
List-Id: linux-serial@vger.kernel.org


This is a series of cleanups for issues raised in prior reviews that
were unrelated to the patches at hand.

Changes in v2:
- Updated commit messages
- Removed CONSOLE from UART_CONSOLE_RX_WM
- Coalesced lines where possible
- Updated missed rxstale variable

Ryan Case (4):
  tty: serial: qcom_geni_serial: Remove use of *_relaxed() and mb()
  tty: serial: qcom_geni_serial: Remove set_rfr_wm() and related
    variables
  tty: serial: qcom_geni_serial: Remove xfer_mode variable
  tty: serial: qcom_geni_serial: Use u32 for register variables

 drivers/tty/serial/qcom_geni_serial.c | 279 ++++++++++----------------
 1 file changed, 106 insertions(+), 173 deletions(-)

-- 
2.20.1.97.g81188d93c3-goog
