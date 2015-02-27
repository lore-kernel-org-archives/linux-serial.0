From: Jonathan Richardson <jonathar@broadcom.com>
Subject: [PATCH v2 0/1] Synopsis 8250 serial port driver fix
Date: Thu, 26 Feb 2015 16:35:56 -0800
Message-ID: <1424997357-31487-1-git-send-email-jonathar@broadcom.com>
References: <Jonathan Richardson <jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Jonathan Richardson <jonathar@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dtor@google.com>, Anatol Pomazau <anatol@google.com>, Jonathan Richardson <jonathar@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

Hi,

This patchset fixes a bug in the Synopsis 8250 serial driver which causes the
driver to hang. The bug occurs on simple 2 wire serial ports when modem control
signalling has been enabled. It can be reproduced from user space by enabling
modem control signals (stty -clocal), then opening a serial port and polling for
data available to read with a timeout. A properly implemented driver will
ignore the control signals and the call to poll will return. The current
version of the driver hangs forever on the call to poll despite the timeout.

Jon

Changes from v1:
- Changed DT properties from strings to booleans as suggested by Arnd. 
  Documentation updated accordingly.

Desmond Liu (1):
  serial: 8250_dw: Fix get_mctrl behaviour

 .../bindings/serial/snps-dw-apb-uart.txt           |   16 ++++++++++
 drivers/tty/serial/8250/8250_dw.c                  |   32 ++++++++++++++++++++
 2 files changed, 48 insertions(+)

-- 
1.7.9.5
