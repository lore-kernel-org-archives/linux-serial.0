From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/2] serial: 8250_omap: Add compatible for AM654 UART
Date: Tue, 19 Jun 2018 14:44:48 -0500
Message-ID: <20180619194450.6353-1-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Vignesh R <vigneshr@ti.com>, Jiri Slaby <jslaby@suse.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-serial@vger.kernel.org

Hi,

This series was previously send out as part of a larger AM654 UART
support series, but was determined to create a bit of merge conflicts
due to interdependence.

Changes since RFC are indicated in corresponding patches in the series

Instead this series is split out. The series itself is based off
v4.18-rc1 and available here:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-1-am6-uart

Consolidated all patches (including all series) are available here:
https://github.com/nmenon/linux-2.6-playground/commits/upstream/v4.18-rc1/k3-am6-integ

Full Boot log (integrated of all series) is available here:
   https://pastebin.ubuntu.com/p/bBFmnzYtCd/

Nishanth Menon (2):
  dt-bindings: serial: 8250_omap: Add compatible for AM654 UART
    controller
  serial: 8250_omap: Add support for AM654 UART controller

 Documentation/devicetree/bindings/serial/omap_serial.txt | 1 +
 drivers/tty/serial/8250/8250_omap.c                      | 1 +
 2 files changed, 2 insertions(+)

-- 
2.15.1
