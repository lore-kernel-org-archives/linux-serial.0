From: Andrew Jackson <Andrew.Jackson@arm.com>
Subject: [PATCH 0/5] serial: pl011: Fix DMA issues on 64bit PL330 based systems
Date: Fri, 07 Nov 2014 14:14:30 +0000
Message-ID: <545CD3C6.9080408@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

This patch set fixes a number of issues found when using
DMA driven UART transfers on the PL011 UART through a
DMA330 DMA controller on a 64bit system.

Andrew Jackson (5):
  serial: pl011: Allocate TX DMA buffer from DMA capable memory
  serial: pl011: Avoid assumptions about buffer size when refilling TX
    DMA
  serial: pl011: Set length of DMA transfer
  serial: pl011: Don't enable RX DMA if residue processing not
    supported
  serial: pl011: Add device tree support for RX DMA polling

 Documentation/devicetree/bindings/serial/pl011.txt |   19 +++++---
 drivers/tty/serial/amba-pl011.c                    |   46 +++++++++++++++++--
 2 files changed, 53 insertions(+), 12 deletions(-)
