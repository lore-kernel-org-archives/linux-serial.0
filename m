From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 2/3] tty/serial: of_serial: add support for PXA/MMP uarts
Date: Wed, 28 Jan 2015 12:37:43 -0500
Message-ID: <54C91E67.2070501@hurleysoftware.com>
References: <1422334209-23125-1-git-send-email-robh@kernel.org>
 <1422334209-23125-2-git-send-email-robh@kernel.org>
 <54C78823.7050504@hurleysoftware.com>
 <CAL_Jsq+8jDN+fYyed5RYd2e1K+H_R1NkjT38WXSpKfxTLgsDbQ@mail.gmail.com>
 <54C7AA2D.7080202@hurleysoftware.com>
 <CAL_Jsq+wxY0=S1ff-Fk0xDBxHdhBvNopLpjfCETVoo_mou658w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_Jsq+wxY0=S1ff-Fk0xDBxHdhBvNopLpjfCETVoo_mou658w@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 01/27/2015 11:44 AM, Rob Herring wrote:
> On Tue, Jan 27, 2015 at 9:09 AM, Peter Hurley <peter@hurleysoftware.com> wrote:

[...]

>> Maybe Kconfig should warn if they're both built-in or both modules?
> 
> Is there a way to do that?

Well, it's not what I had in mind originally, but the diff below
generates a broken dependencies warning without causing build problems:
	$ scripts/kconfig/mconf Kconfig
	warning: (SERIAL_PXA) selects TTYS_DRIVER_PXA which has unmet direct dependencies (TTY && HAS_IOMEM && !TTYS_DRIVER)

(My original idea was thwarted by the requirement that choice/endchoice
requires prompts).

That said, for PXA, I think we agree splitting out a standalone 8250 platform
driver is the solution.

Regards,
Peter Hurley

--
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 0fcbcd2..c367542 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -6,6 +6,7 @@
 config SERIAL_8250
 	tristate "8250/16550 and compatible serial support"
 	select SERIAL_CORE
+	select TTYS_DRIVER
 	---help---
 	  This selects whether you want to include the driver for the standard
 	  serial ports.  The standard answer is Y.  People who might say N
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index c79b43c..10c3e27 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -7,6 +7,13 @@ if TTY
 menu "Serial drivers"
 	depends on HAS_IOMEM
 
+config TTYS_DRIVER
+       tristate
+
+config TTYS_DRIVER_PXA
+       tristate
+       depends on !TTYS_DRIVER
+
 config SERIAL_EARLYCON
 	bool
 	help
@@ -438,6 +445,7 @@ config SERIAL_PXA
 	bool "PXA serial port support"
 	depends on ARCH_PXA || ARCH_MMP
 	select SERIAL_CORE
+	select TTYS_DRIVER_PXA
 	help
 	  If you have a machine based on an Intel XScale PXA2xx CPU you
 	  can enable its onboard serial ports by enabling this option.
