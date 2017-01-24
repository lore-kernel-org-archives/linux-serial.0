From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 0/8] serial: st-asc: Allow handling of RTS line
Date: Tue, 24 Jan 2017 13:43:02 +0000
Message-ID: <20170124134310.27512-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, robh+dt@kernel.org, devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, patrice.chotard@st.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-serial@vger.kernel.org

When hardware flow-control is disabled, manual toggling of the UART's
reset line (RTS) using userland applications (e.g. stty) is not
possible, since the ASC IP does not provide this functionality in the
same was as some other IPs do.  Thus, we have to do this manually.

This set ensures the correct Pinctrl groups are configured and
obtained for both manual toggling of the RTS line and for the IP to
take over the lines when HW flow-control is requested by the user.

Lee Jones (8):
  serial: st-asc: Ignore the parity error bit if 8-bit mode is enabled
  serial: st-asc: Provide RTS functionality
  serial: st-asc: Read in all Pinctrl states
  serial: st-asc: (De)Register GPIOD and swap Pinctrl profiles
  ARM: dts: STiH410-b2260: Identify the UART RTS line
  ARM: dts: STiH407-pinctrl: Add Pinctrl group for HW flow-control
  ARM: dts: STiH407-family: Use new Pinctrl groups
  ARM: dts: STiH407-family: Enable HW flow-control

 arch/arm/boot/dts/stih407-family.dtsi  |  7 +--
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 12 ++++-
 arch/arm/boot/dts/stih410-b2260.dts    |  1 +
 drivers/tty/serial/st-asc.c            | 98 +++++++++++++++++++++++++++++++---
 4 files changed, 105 insertions(+), 13 deletions(-)

-- 
2.10.2
