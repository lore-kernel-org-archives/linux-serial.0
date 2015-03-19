From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v2 00/05] serial: sh-sci: Hardware flow control update V2
Date: Thu, 19 Mar 2015 10:49:33 +0900
Message-ID: <20150319014933.14235.44835.sendpatchset@little-apple>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: gregkh@linuxfoundation.org, geert@glider.be, laurent.pinchart@ideasonboard.com, linux-serial@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, jslaby@suse.cz
List-Id: linux-serial@vger.kernel.org

serial: sh-sci: Hardware flow control update V2

[PATCH v2 01/05] serial: sh-sci: Break out default CTS/RTS pin setup
[PATCH v2 02/05] serial: sh-sci: Fix default RTS handling
[PATCH v2 03/05] serial: sh-sci: Expose default CTS pin
[PATCH v2 04/05] serial: sh-sci: Add SCIFA/SCIFB CTS/RTS pin setup
[PATCH v2 05/05] serial: sh-sci: Expose SCIFA/SCIFB CTS pin

These patches are my latest take at improving CTS/RTS pin handling in
the SCIF driver. The goal for these patches is to improve the default
hardware flow control handling and also add CTS/RTS support for SCIFA/SCIFB.

The SCIF hardware does not provide any interrupt driven delta monitoring
of any modem control signals such as CTS. Instead the different SCIF types
tend to include "automatic" hardware handling of the CTS and RTS signals.

Things like CTS/RTS pin setup, RTS trigger level and FIFO size seem to
vary with each SCIF variant, but the actual hardware flow control logic
should be the same if you trust the documentation. The hardware flow control
support can be enabled by setting the SCFCR.MCE bit in the hardware which
will enable the following behavior:

CTS: TX FIFO contents are sent as long as CTS remains asserted.
RTS: RTS is asserted as long as enough space remains in the RX FIFO.

Depending on SCIF variant it may be theoretically possible to enable hardware
handling of only one of the signals in the SCIF device. In other cases the pin
control hardware in the SoC may be used to disable handling of a certain pin.

Most embedded boards using SCIF tend to only hook up RX and TX signals while
some special cases like KZM9G have the SCIFA console port connected with CTS
and RTS signals available as well.

Getting support for CTS/RTS on a particular board involves the following:
- The SCIF variant on the SoC that has CTS/RTS support for the channel.
- The target board must enable all SCIF pins in the pin control hardware.
- The driver instance must be marked as CTS/RTS capable with SCIx_HAVE_RTSCTS.
- User space should signal that it wants to use CTS/RTS via CRTSCTS.
- In case CRTSCTS is not desired then the CTS/RTS pins need to be setup anyway.

At this point UPF_HARD_FLOW is not used by the driver.

Tested with local SCIx_HAVE_RTSCTS enablement on a KZM9G board with
probe points hooked up to a scope to monitor signal state.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - Adjusted function names, added bit definitions - thanks Laurent!
 - Updated the RTS/CTS behavior when modem control is available but disabled.

 Built on top of renesas-devel-20150311-v4.0-rc3

 drivers/tty/serial/sh-sci.c |  148 +++++++++++++++++++++++++++++++++++++------
 include/linux/serial_sci.h  |   12 +++
 2 files changed, 140 insertions(+), 20 deletions(-)
