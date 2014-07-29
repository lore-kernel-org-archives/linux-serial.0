From: Frans Klaver <frans.klaver@xsens.com>
Subject: [RFC PATCH 0/3] omap-serial high-speed fixes/improvements
Date: Tue, 29 Jul 2014 16:52:54 +0200
Message-ID: <1406645577-18620-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Frans Klaver <frans.klaver@xsens.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

Here's a couple of patches that should improve the behavior of the omap serial
driver at high data rates and baud rates.

I was actually surprised to see that proper dma support isn't there yet, but
there you go. Anyone got news on that, by the way?

Thanks for reviewing this,
Frans


Frans Klaver (3):
  tty: omap-serial: prevent division by zero
  tty: omap-serial: use threaded interrupt handler
  tty: omap-serial: support setting of hardware flow control in dts

 .../devicetree/bindings/serial/omap_serial.txt     |  1 +
 drivers/tty/serial/omap-serial.c                   | 52 ++++++++++++++++------
 2 files changed, 40 insertions(+), 13 deletions(-)

-- 
1.9.3
