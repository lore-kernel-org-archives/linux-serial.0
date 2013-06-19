From: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 3/5] ARM: davinci: da850: do not specify clock_frequency
	for UART DT node
Date: Wed, 19 Jun 2013 14:45:40 +0530
Message-ID: <1371633342-1210-4-git-send-email-prakash.pm@ti.com>
References: <1371633342-1210-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1371633342-1210-1-git-send-email-prakash.pm-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, hs-ynQEQJNshbs@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

DT kernel on da850-evm comes up with garbled UART logs. This is because
of mismatch in actual module clock rate and rate specified(clock-frequency)
in DT blob. kernel should not assume or depend on bootloaders clock
configuration, instead let it find the clock rate at runtime.

Issue discussed here before arriving on this implementation:
"ARM: davinci: da850 evm: update clock rate for UART 1/2 DT nodes"
https://patchwork.kernel.org/patch/2162271/

Signed-off-by: Manjunathappa, Prakash <prakash.pm-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/da850.dtsi |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 2c88313..4d43046 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -129,7 +129,6 @@
 		serial0: serial@1c42000 {
 			compatible = "ns16550a";
 			reg = <0x42000 0x100>;
-			clock-frequency = <150000000>;
 			reg-shift = <2>;
 			interrupts = <25>;
 			status = "disabled";
@@ -137,7 +136,6 @@
 		serial1: serial@1d0c000 {
 			compatible = "ns16550a";
 			reg = <0x10c000 0x100>;
-			clock-frequency = <150000000>;
 			reg-shift = <2>;
 			interrupts = <53>;
 			status = "disabled";
@@ -145,7 +143,6 @@
 		serial2: serial@1d0d000 {
 			compatible = "ns16550a";
 			reg = <0x10d000 0x100>;
-			clock-frequency = <150000000>;
 			reg-shift = <2>;
 			interrupts = <61>;
 			status = "disabled";
-- 
1.7.4.1
