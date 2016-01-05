From: Martin Fuzzey <mfuzzey@parkeon.com>
Subject: [PATCH V2] serial: imx: Fix suspend / resume.
Date: Tue, 05 Jan 2016 16:53:31 +0100
Message-ID: <20160105155331.6024.7211.stgit@localhost>
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
Cc: Shawn Guo <shawnguo@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

When a non console i.MX UART is enabled in the device tree,
system suspend fails due to an unprepared clock:

[  638.794563] PM: Syncing filesystems ... done.
[  638.878902] Freezing user space processes ... (elapsed 0.002 seconds) done.
[  638.888454] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[  638.996697] PM: suspend of devices complete after 97.200 msecs
[  639.002611] PM: suspend devices took 0.100 seconds
[  639.013020] PM: late suspend of devices complete after 2.288 msecs
[  639.021486] ------------[ cut here ]------------
[  639.026147] WARNING: CPU: 0 PID: 488 at drivers/clk/clk.c:732 clk_core_enable+0xc0/0x12c()
[  639.034413] Modules linked in:
[  639.037490] CPU: 0 PID: 488 Comm: system_server Tainted: G        W       4.4.0-rc5-pknbsp-svn2214-atag-v4.4-rc5-121-gebfd9cb #1304
[  639.049312] Hardware name: Freescale i.MX53 (Device Tree Support)
[  639.055444] [<c0016d54>] (unwind_backtrace) from [<c00140f8>] (show_stack+0x20/0x24)
[  639.063199] [<c00140f8>] (show_stack) from [<c02c99a0>] (dump_stack+0x20/0x28)
[  639.070442] [<c02c99a0>] (dump_stack) from [<c0024ca8>] (warn_slowpath_common+0x88/0xc0)
[  639.078541] [<c0024ca8>] (warn_slowpath_common) from [<c0024d0c>] (warn_slowpath_null+0x2c/0x34)
[  639.087332] [<c0024d0c>] (warn_slowpath_null) from [<c05171e8>] (clk_core_enable+0xc0/0x12c)
[  639.095777] [<c05171e8>] (clk_core_enable) from [<c05172f8>] (clk_enable+0x2c/0x40)
[  639.103441] [<c05172f8>] (clk_enable) from [<c0349880>] (imx_serial_port_suspend_noirq+0x20/0xe0)
[  639.112336] [<c0349880>] (imx_serial_port_suspend_noirq) from [<c03a26a0>] (dpm_run_callback+0x68/0x16c)
[  639.121825] [<c03a26a0>] (dpm_run_callback) from [<c03a2898>] (__device_suspend_noirq+0xf4/0x22c)
[  639.130705] [<c03a2898>] (__device_suspend_noirq) from [<c03a4b0c>] (dpm_suspend_noirq+0x148/0x30c)
[  639.139764] [<c03a4b0c>] (dpm_suspend_noirq) from [<c00511d4>] (suspend_devices_and_enter+0x2e8/0x6a4)
[  639.149078] [<c00511d4>] (suspend_devices_and_enter) from [<c00518a0>] (pm_suspend+0x310/0x4b8)
[  639.157782] [<c00518a0>] (pm_suspend) from [<c00500ec>] (state_store+0x7c/0xcc)
[  639.165099] [<c00500ec>] (state_store) from [<c02cb6dc>] (kobj_attr_store+0x1c/0x28)
[  639.172858] [<c02cb6dc>] (kobj_attr_store) from [<c01633d4>] (sysfs_kf_write+0x54/0x58)
[  639.180871] [<c01633d4>] (sysfs_kf_write) from [<c01629b4>] (kernfs_fop_write+0x100/0x1c8)
[  639.189152] [<c01629b4>] (kernfs_fop_write) from [<c00fb8b8>] (__vfs_write+0x3c/0xe8)
[  639.196991] [<c00fb8b8>] (__vfs_write) from [<c00fc810>] (vfs_write+0xa4/0x160)
[  639.204307] [<c00fc810>] (vfs_write) from [<c00fcac4>] (SyS_write+0x4c/0x98)
[  639.211363] [<c00fcac4>] (SyS_write) from [<c0010760>] (ret_fast_syscall+0x0/0x3c)

This does not happen for the common case of a single UART used as a console
(since imx_console_setup() already does a prepare)

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>

---
Changelog
V2:
* Use a seperate clk_[un]prepare() in .suspend() / .resume()
  to avoid using may sleep functions in .suspend_noirq() / .resume_noirq()
* Update description to make it clear that problem only occurs for non console
---
 drivers/tty/serial/imx.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 016e4be..e06b3b6 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2109,7 +2109,8 @@ static int imx_serial_port_suspend(struct device *dev)
 
 	uart_suspend_port(&imx_reg, &sport->port);
 
-	return 0;
+	/* Needed to enable clock in suspend_noirq */
+	return clk_prepare(sport->clk_ipg);
 }
 
 static int imx_serial_port_resume(struct device *dev)
@@ -2122,6 +2123,8 @@ static int imx_serial_port_resume(struct device *dev)
 
 	uart_resume_port(&imx_reg, &sport->port);
 
+	clk_unprepare(sport->clk_ipg);
+
 	return 0;
 }
