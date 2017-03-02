From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v2 0/3] printk: fix double printing with earlycon
Date: Thu,  2 Mar 2017 16:11:31 +0300
Message-ID: <20170302131153.22733-1-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>
List-Id: linux-serial@vger.kernel.org

If a console was specified by ACPI SPCR table _and_ command line parameters like
"console=ttyAMA0" _and_ "earlycon" were specified, then log messages
appear twice.

This issue was addressed in the patch [1] but the approach was wrong and
a revert [2] was suggested.

First two patches "printk: fix name/type/scope of preferred_console var" and
"printk: rename selected_console -> preferred_console" were sent sent some
time ago as one patch "printk: fix name and type of some variables" [3].
They fix name/type/scope of some variables without changing the logic.

The real fix is in the second patch.  The root cause is that the code traverses
the list of specified consoles (the `console_cmdline` array) and stops at the
first match.  But it may happen that the same console is referred by
the elements of this array twice:

	pl011,mmio,0x87e024000000,115200 -- from SPCR
	ttyAMA0 -- from command line

but in this case `preferred_console` points to the second entry and
the flag CON_CONSDEV is not set, so bootconsole is not deregistered.

To fix that, match the console against the `console_cmdline` entry
pointed by `preferred_console` instead of the first match.

v2:
- split the patch that renames `selected_console` and `preferred_console`
  into two patches (Steven Rostedt)
- add a comment explaining why we need a separate match to check for
  preferred_console (Steven Rostedt)
- v1 of this patchset changed the logic of console initialization a bit.
  That could lead to bugs/incompatibilities.  Use the exactly the same
  logic as in the original code.

v1:
https://lkml.kernel.org/r/20170301161347.4202-1-aleksey.makarov@linaro.org

[1] https://lkml.kernel.org/r/1485963998-921-1-git-send-email-sudeep.holla@arm.com
    commit aea9a80ba98a ("tty: serial: pl011: add ttyAMA for matching pl011 console")
[2] https://lkml.kernel.org/r/20170301152304.29635-1-aleksey.makarov@linaro.org
[3] https://lkml.kernel.org/r/1455299022-11641-2-git-send-email-aleksey.makarov@linaro.org

Aleksey Makarov (3):
  printk: fix name/type/scope of preferred_console var
  printk: rename selected_console -> preferred_console
  printk: fix double printing with earlycon

 kernel/printk/printk.c | 63 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 22 deletions(-)

-- 
2.11.1
