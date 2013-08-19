From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 0/4] Document msm_serial bindings and support newer uartdms
Date: Mon, 19 Aug 2013 14:39:53 -0700
Message-ID: <1376948397-6882-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, David Brown <davidb@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

This patchset aligns the msm_serial driver more with downstream usage and
also documents the msm_serial driver's DT binding. Along the way we
update the clock names and add support for future UARTDM hardware that
isn't part of a GSBI.

Stephen Boyd (4):
  msm_serial: Switch clock consumer strings and simplify code
  devicetree: serial: Document msm_serial bindings
  msm_serial: Add support for non-GSBI UARTDM devices
  ARM: dts: msm: Update uartdm compatible strings

 .../devicetree/bindings/serial/msm_serial.txt      | 82 ++++++++++++++++++++++
 arch/arm/boot/dts/msm8660-surf.dts                 |  2 +-
 arch/arm/boot/dts/msm8960-cdp.dts                  |  2 +-
 arch/arm/mach-msm/devices-msm7x00.c                |  6 +-
 arch/arm/mach-msm/devices-msm7x30.c                |  2 +-
 arch/arm/mach-msm/devices-qsd8x50.c                |  6 +-
 drivers/tty/serial/msm_serial.c                    | 29 ++++----
 7 files changed, 104 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/msm_serial.txt

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
