From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Subject: [RFC] firmware: annotate thou shalt not request fw on init or probe
Date: Fri, 28 Aug 2015 18:18:27 -0700
Message-ID: <1440811107-861-1-git-send-email-mcgrof@do-not-panic.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ming.lei@canonical.com, julia.lawall@lip6.fr
Cc: torvalds@linux-foundation.org, liam.r.girdwood@linux.intel.com, yang.jie@intel.com, tiwai@suse.de, dmitry.torokhov@gmail.com, joonas.lahtinen@linux.intel.com, teg@jklm.no, viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org, kay@vrfy.org, dwmw2@infradead.org, linux-kernel@vger.kernel.org, yalin.wang2010@gmail.com, "Luis R. Rodriguez" <mcgrof@suse.com>, Jonathan Corbet <corbet@lwn.net>, Julia Lawall <Julia.Lawall@lip6.fr>, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, linux-doc@vger.kernel.org, cocci@systeme.lip6.fr, Alessandro Rubini <rubini@gnudd.com>, Kevin Cernekee <cernekee@gmail.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: "Luis R. Rodriguez" <mcgrof@suse.com>

We are phasing out the usermode helper from the kernel,
systemd already ripped support for this a while ago, the
only remaining valid user is the Dell rbu driver. The
firmware is now being read directly from the filesystem
by the kernel. What this means is that if you have a
device driver that needs firmware early, when it is
built-in to the kernel the firmware may not yet be
available. Folks building drivers that need firmware
early should either include it as part of the kernel or
stuff it into the initramfs used to boot.

In particular since we are accessing the firmware directly
folks cannot expect new found firmware on a filesystem
after we switch off from an initramfs with pivot_root().
Supporting such dynamic changes to load drivers would
be possible but adds complexity, instead lets document
the expectations properly and add a grammar rule to enable
folks to check / validate / police if drivers are using
the request firmware API early on init or probe.

The SmPL rule used to check for the probe routine is
loose and is currently defined through a regexp, that
can easily be extended to any other known bus probe
routine names.

Thou shalt not make firmware calls early on init or probe.

I spot only 2 offender right now.

mcgrof@ergon ~/linux-next (git::20150805-pend-all)$ export COCCI=scripts/coccinelle/api/request_firmware.cocci
mcgrof@ergon ~/linux-next (git::20150805-pend-all)$ make coccicheck MODE=report

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting
it.

./drivers/fmc/fmc-write-eeprom.c:136:7-23: ERROR: driver call request firmware call on its probe routine on line 136.
./drivers/tty/serial/rp2.c:796:6-29: ERROR: driver call request firmware call on its probe routine on line 796.

Cc: Ming Lei <ming.lei@canonical.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: Michal Marek <mmarek@suse.com>
Cc: linux-doc@vger.kernel.org
Cc: cocci@systeme.lip6.fr
Cc: Alessandro Rubini <rubini@gnudd.com>
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 Documentation/firmware_class/README           | 24 +++++--
 drivers/base/Kconfig                          |  2 +-
 scripts/coccinelle/api/request_firmware.cocci | 90 +++++++++++++++++++++++++++
 3 files changed, 110 insertions(+), 6 deletions(-)
 create mode 100644 scripts/coccinelle/api/request_firmware.cocci

diff --git a/Documentation/firmware_class/README b/Documentation/firmware_class/README
index 71f86859d7d8..7c59f4d07f1d 100644
--- a/Documentation/firmware_class/README
+++ b/Documentation/firmware_class/README
@@ -33,7 +33,7 @@
 	than 256, user should pass 'firmware_class.path=$CUSTOMIZED_PATH'
 	if firmware_class is built in kernel(the general situation)
 
- 2), userspace:
+ 2), userspace: (DEPRECATED)
  	- /sys/class/firmware/xxx/{loading,data} appear.
 	- hotplug gets called with a firmware identifier in $FIRMWARE
 	  and the usual hotplug environment.
@@ -41,14 +41,14 @@
 
  3), kernel: Discard any previous partial load.
 
- 4), userspace:
+ 4), userspace: (DEPRECATED)
 		- hotplug: cat appropriate_firmware_image > \
 					/sys/class/firmware/xxx/data
 
  5), kernel: grows a buffer in PAGE_SIZE increments to hold the image as it
 	 comes in.
 
- 6), userspace:
+ 6), userspace: (DEPRECATED)
 		- hotplug: echo 0 > /sys/class/firmware/xxx/loading
 
  7), kernel: request_firmware() returns and the driver has the firmware
@@ -66,8 +66,8 @@
 	 	copy_fw_to_device(fw_entry->data, fw_entry->size);
 	 release_firmware(fw_entry);
 
- Sample/simple hotplug script:
- ============================
+ Sample/simple hotplug script: (DEPRECATED)
+ ==========================================
 
 	# Both $DEVPATH and $FIRMWARE are already provided in the environment.
 
@@ -93,6 +93,20 @@
    user contexts to request firmware asynchronously, but can't be called
    in atomic contexts.
 
+Requirements:
+=============
+
+You should avoid at all costs requesting firmware on both init and probe paths
+of your device driver. Reason for this is as usermod helper functionality is
+being deprecated we will only have direct firmware access. This means that
+any routines requesting firmware will need the filesystem which contains the
+firmware available and mounted. Device drivers init and probe paths can be
+called early on prior to /lib/firmware being available. If you might need
+access to firmware early you should consider requiring your device driver to
+be only available as a module, this however as its own set of limitations.
+
+Folks building drivers that need firmware early should either include it as
+part of the kernel or stuff it into the initramfs used to boot.
 
  about in-kernel persistence:
  ---------------------------
diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 98504ec99c7d..a63ede4a2fc9 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -152,7 +152,7 @@ config FW_LOADER_USER_HELPER
 	bool
 
 config FW_LOADER_USER_HELPER_FALLBACK
-	bool "Fallback user-helper invocation for firmware loading"
+	bool "Fallback user-helper invocation for firmware loading (deprecated)"
 	depends on FW_LOADER
 	select FW_LOADER_USER_HELPER
 	help
diff --git a/scripts/coccinelle/api/request_firmware.cocci b/scripts/coccinelle/api/request_firmware.cocci
new file mode 100644
index 000000000000..fa1da7a650ed
--- /dev/null
+++ b/scripts/coccinelle/api/request_firmware.cocci
@@ -0,0 +1,90 @@
+///
+/// Thou shalt not request firmware on init or probe
+///
+// Confidence: High
+// Copyright: (C) 2015 Luis R. Rodriguez <mcgrof@do-not-panic.com>
+// URL: http://coccinelle.lip6.fr/
+// Options: --no-includes --include-headers
+
+virtual context
+virtual org
+virtual report
+
+@ defines_module_init exists @
+declarer name module_init;
+identifier init;
+@@
+
+module_init(init);
+
+@ has_probe depends on defines_module_init @
+identifier drv_calls, drv_probe;
+type bus_driver;
+identifier probe_op =~ "(probe)";
+@@
+
+bus_driver drv_calls = {
+	.probe_op = drv_probe,
+};
+
+@ calls_fw_on_init depends on defines_module_init @
+identifier defines_module_init.init;
+position p1;
+@@
+
+init(void)
+{
+ ...
+(
+request_firmware@p1(...)
+|
+request_firmware_nowait@p1(...)
+|
+request_firmware_direct@p1(...)
+)
+...
+}
+
+@ calls_fw_on_probe depends on has_probe @
+identifier has_probe.drv_probe;
+position p2;
+@@
+
+drv_probe(...)
+{
+ ...
+(
+request_firmware@p2(...)
+|
+request_firmware_nowait@p2(...)
+|
+request_firmware_direct@p2(...)
+)
+...
+}
+
+@script:python depends on calls_fw_on_init && org@
+p1 << calls_fw_on_init.p1;
+@@
+
+cocci.print_main("init make firmware call",p1)
+
+@script:python depends on calls_fw_on_init && report@
+p1 << calls_fw_on_init.p1;
+@@
+
+msg="ERROR: driver call request firmware call on its init routine on line %s." % (p1[0].line)
+coccilib.report.print_report(p1[0], msg)
+
+@script:python depends on calls_fw_on_probe && org@
+p2 << calls_fw_on_probe.p2;
+@@
+
+cocci.print_main("probe make firmware call",p2)
+
+@script:python depends on calls_fw_on_probe && report@
+p2 << calls_fw_on_probe.p2;
+@@
+
+msg="ERROR: driver call request firmware call on its probe routine on line %s." % (p2[0].line)
+coccilib.report.print_report(p2[0], msg)
-- 
2.4.3
