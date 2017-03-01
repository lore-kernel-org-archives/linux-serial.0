From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH 0/2] printk: fix double printing with earlycon
Date: Wed,  1 Mar 2017 19:13:44 +0300
Message-ID: <20170301161347.4202-1-aleksey.makarov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>
List-Id: linux-serial@vger.kernel.org

If a console was specified by ACPI SPCR table _and_ command line parameters like
"console=ttyAMA0" _and_ "earlycon" were specified, then log messages
appears twice.

This issue was addressed in the patch [1] but the approach was wrong and
a revert [2] was suggested.

First patch "printk: fix name and type of some variables" was sent some time
ago [3].  It fixes name/type/scope of some variables without changing the logic.

The real fix is in the second patch.  The root cause is that the code traverse
the list of specified consoles (the `console_cmdline` array) and stops at the
first match.  But it may happen that the same console is referred by
the elements of this array twice:

	ttyAMA0 -- from command line
	pl011,mmio,0x87e024000000,115200 -- from SPCR

but in this case `preferred_console` points to the second entry and
the flag CON_CONSDEV is not set, so bootconsole is not deregistered.

To fix that, match the console against the `console_cmdline` entry
pointed by `preferred_console` instead of the first match.

[1] https://lkml.kernel.org/r/1485963998-921-1-git-send-email-sudeep.holla@arm.com
    commit aea9a80ba98a ("tty: serial: pl011: add ttyAMA for matching pl011 console")
[2] https://lkml.kernel.org/r/20170301152304.29635-1-aleksey.makarov@linaro.org
[3] https://lkml.kernel.org/r/1455299022-11641-2-git-send-email-aleksey.makarov@linaro.org

Aleksey Makarov (2):
  printk: fix name and type of some variables
  printk: fix double printing with earlycon

 kernel/printk/printk.c | 66 +++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

-- 
2.11.1
