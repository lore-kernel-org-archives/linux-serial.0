From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 00/10] serial: st-asc: Allow handling of RTS line
Date: Fri, 27 Jan 2017 17:27:54 +0000
Message-ID: <20170127172804.23881-1-lee.jones@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, dt@kernel.org, devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, patrice.chotard@st.com, Lee Jones <lee.jones@linaro.org>
List-Id: linux-serial@vger.kernel.org

When hardware flow-control is disabled, manual toggling of the UART's
reset line (RTS) using userland applications (e.g. stty) is not
possible, since the ASC IP does not provide this functionality in the
same was as some other IPs do.  Thus, we have to do this manually.

This set ensures the correct Pinctrl groups are configured and
obtained for both manual toggling of the RTS line and for the IP to
take over the lines when HW flow-control is requested by the user. 

Lee Jones (10):
  serial: st-asc: Ignore the parity error bit if 8-bit mode is enabled
  serial: st-asc: Provide RTS functionality
  serial: st-asc: Read in all Pinctrl states
  serial: st-asc: (De)Register GPIOD and swap Pinctrl profiles
  serial: st-asc: Use generic DT binding for announcing RTS/CTS lines
  dt-bindings: serial: Update 'uart-has-rtscts' description
  ARM: dts: STiH410-b2260: Identify the UART RTS line
  ARM: dts: STiH407-pinctrl: Add Pinctrl group for HW flow-control
  ARM: dts: STiH407-family: Use new Pinctrl groups
  ARM: dts: STiH410-b2260: Enable HW flow-control

 .../devicetree/bindings/serial/serial.txt          |   3 +-
 arch/arm/boot/dts/stih407-family.dtsi              |   3 +-
 arch/arm/boot/dts/stih407-pinctrl.dtsi             |  12 ++-
 arch/arm/boot/dts/stih410-b2260.dts                |   5 +
 drivers/tty/serial/st-asc.c                        | 101 +++++++++++++++++++--
 5 files changed, 110 insertions(+), 14 deletions(-)

-- 
2.9.3
