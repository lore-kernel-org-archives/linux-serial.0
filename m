Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEEFC433F5
	for <linux-serial@archiver.kernel.org>; Thu,  2 Dec 2021 10:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357073AbhLBK7g (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Dec 2021 05:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357072AbhLBK7f (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Dec 2021 05:59:35 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70595C06174A
        for <linux-serial@vger.kernel.org>; Thu,  2 Dec 2021 02:56:13 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id j3so58771528wrp.1
        for <linux-serial@vger.kernel.org>; Thu, 02 Dec 2021 02:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:organization:user-agent
         :mime-version:content-transfer-encoding;
        bh=0Oectj4S2qTh6zetaRNuZDo2BIzHPcQsFticxyh6zkY=;
        b=kVqCvAyK5iuziUXCpYfnjx4+E55CwaModHFX90rX2evfwLofKsAQQ3/uDHZLkvxx7N
         KmUl93tgbqCsjHGuYvGzE211/CD3DMNAidefmwVvv/6pcw7S1vJHgVZncWzJDMkjJXb9
         P7mhTOIg/zDG5V4iRzBZwCO6/YS/TCWDQDmJPyY9eO7Hy72AAc3qr5H3HOfhWE78tcra
         6YvFsKSICBg1rmNsNWSJCMIOzTBWpeSXeLG1xnWFSMj2N/QsZx/FpIKKM5/JptJXlIZI
         siPEF4vtNS7EMT0Q/YWPDSm9Gi1M1xg93JWIKy9n99UKWx/TSk8vdtALzeE7R0PKBv3P
         Wd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:organization
         :user-agent:mime-version:content-transfer-encoding;
        bh=0Oectj4S2qTh6zetaRNuZDo2BIzHPcQsFticxyh6zkY=;
        b=bVv31UCZkuHYSfMmIrGHI9oJTTmufEhfqg9anZuGbWTMFffY7FGkRgWD9WfwCABZvr
         xvhAMksGBtaFbDQjbi+5TzKScfvwEywMGTZLpIHuS1Vsm6DA9sr3XZIgZMnZ9nW3gt4N
         J9cfKRdeQXEFasSXVuk1ercbwXZcJYo2OzsGX4bxt6OhNSFZByzoCCf/oluOxhaKPJyN
         OUbxS9XSgQPuBdZWwlmGsAd8/KSDdDzt+QuRZOB6eaY8/Aelef+NEiL8Y21Qhzjzsics
         O1t0nYGEuRNg2LpSnlRLnH5GirXpP0ylfb9mEHcB4RAjcAJBObgHUZbsJB9lIJ25woLi
         oU5A==
X-Gm-Message-State: AOAM532aD/mUeoLujmwnKcmYhyZEk8NarXMcU226rOA233pWDjSr8Zqn
        L+aA2MlcNw96oa8TG+1MKRFVqa906/s=
X-Google-Smtp-Source: ABdhPJw2Bl3teA+aafy9pIJUfOyCI1YUzbodpia83lWOtG0j/Zgy9OR0bePL17cGxnJZ4YTFx7i3Kg==
X-Received: by 2002:adf:8091:: with SMTP id 17mr13708642wrl.457.1638442571690;
        Thu, 02 Dec 2021 02:56:11 -0800 (PST)
Received: from UbuntuVM ([217.181.227.115])
        by smtp.gmail.com with ESMTPSA id l2sm1892197wmq.42.2021.12.02.02.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 02:56:11 -0800 (PST)
Message-ID: <bc2d427e30e24978be5800c41f921b9d782570e7.camel@gmail.com>
Subject: [PATCH] Allow PPS on CTS pin and non-RS232 UARTs
From:   Mathieu Peyrega <mathieu.peyrega@gmail.com>
To:     linux-serial@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org, giometti@linux.it
Date:   Thu, 02 Dec 2021 11:56:10 +0100
Organization: mathieu.peyrega@gmail.com
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

this is my first contribution to this list (and the Linux kernel) and I'd
like trying to revive a subject already discussed in a 2017/2018 thread about
adding a possibility to use the CTS pin instead of the DCD pin for 1PPS line
disciplining (cf. https://www.spinics.net/lists/linux-serial/msg27604.html)

The rationale is similar to the original poster's one: some TTL UARTs hardware
implementations have an incomplete wiring and do not expose a DCD pin (e.g. on
some SBCs). On those platforms only TX, RX, CTS and RTS are available. In such
cases, being able to use the CTS pin for 1PPS time disciplining is useful.

In addition, to that primary need, I believe there is another missing feature
in current implementation. Some non-RS232 UARTs (e.g. TTL UARTs also often
found on SBCs) have an inverted behaviour with respect to RS232 rising edge or
falling edge vs. assert or clear logics. Not taking this inversion into account
results in a disciplining where the kernel time ends with an offset from actual
signal time. Offset value is the width/duration of the 1PPS square pulse signal.
At least this is what I experienced in the testing process on an Odroid H2 SBC
(Intel x86_64 based) and a GNSS driven 1PPS signal (from a CORS station that I
manage). Maybe this can be handled from a later userland process (e.g. ntpd)
but I believe that being able to handle it straight at kernel level is better.

As for the module behaviour control, I went with adding 2 parameters to
pps-ldisc:

-	activepin (charp) wich can be dcd (default) or cts and drives the pin
	which should be consider to detect the 1PPS signal
-	invertlogic (bool) which can be false (default) or true and defines if
	the driver complies with a RS232 type signal where assert is on the
	rising edge or inverted as for some TTL UARTs. Default values match
	the current behaviour.

Those 2 parameters were made runtime readable/writable with standard kernel
module parameter callback mecanism. Final configuration does not really require
this writable feature, but it allows easier tuning (finding correct parameters
for a given 1PPS source and UART) together with ppstest/ppscheck tools as it
allows seeing the effect of inverting the logic, especially when the width or
polarity of the 1PPS signal is not well known.

As for the implementation details, it was chosen to extend the tty_ldisc_ops
structure with a new cts_change function pointer similar to the existing
dcd_change. Another option may have been to fully reuse the existing structure
and its int flag C field (which seems unused in current code as far as I
understand). From there it should be possible to implement some logics to use
dcd_change and flag value even for handling 1PPS on CTS pin. This choice would
have had less impacts on the existing interfaces (no changes to
include/linux/tty_ldisc.h) but suppose using the dcd_change named function
pointer to actually handle cts changes (I don't really like it), and this
implementation choice would also require tests on more variables (flag and
ops->dcd_change) altough those tests happens at low frequency (1Hz) and there
should be no performance impact. I prefered going the other way and modify the
interface. The flag plus renaming dcd_change to activepin_change could also be
a third option, but it also modifies the tty_ldisc_ops (while keeping it the
same size). Parameter settings runtime changes are checked and only cts or dcd
(caseless) is allowed for activepin, with or without a trailing cariage return
to allow missing -n in configuration commands like:
echo -n cts > /sys/module/pps_ldisc/parameters/activepin

The patch modifies 3 files under both PPS SUPPORT and TTY LAYER maintainer
reponsabilities. I have seen no requirements in the MAINTAINER file for the
PPS SUPPORT tree part so the patch is proposed against main branch of the
TTY LAYER git tree.

It has been tested to compile on this tree/branch only for x86_64 (I have not
performed cross compilation tests). Runtime behaviour has been mainly tested
against the 5.11.40 branch (both generic and lowlatency flavours) of the
ubuntu focal kernel on an Odroid H2 SBC (x86_64). The tests were conducted
with a rising edge aligned 1PPS signal, 100ms width and connected to CTS pin
of ttyS0 UART. I can provide some results if needed (such as effect of runtime
switching invertlogic on ppstest / ppscheck values).

I tried and hope I complied with most of the rules for proposing a patch and
posting here.
(By the way, I have not been able to reach the wiki or mailing list in the
PPS SUPPORT section of MAINTAINERS file.)

Best regards

From 7f515e29499bbd060d72bcb58d28220c9d9644be Mon Sep 17 00:00:00 2001
From: Mathieu Peyrega <mathieu.peyrega@gmail.com>
Date: Thu, 2 Dec 2021 09:55:10 +0100
Subject: [PATCH] Allow PPS on CTS pin and non-RS232 UARTs

Signed-off-by: Mathieu Peyrega <mathieu.peyrega@gmail.com>
---
 drivers/pps/clients/pps-ldisc.c  | 137 ++++++++++++++++++++++++++++++-
 drivers/tty/serial/serial_core.c |  13 +++
 include/linux/tty_ldisc.h        |   6 ++
 3 files changed, 154 insertions(+), 2 deletions(-)

diff --git a/drivers/pps/clients/pps-ldisc.c b/drivers/pps/clients/pps-ldisc.c
index d73c4c2ed4e1..6221700ab3ad 100644
--- a/drivers/pps/clients/pps-ldisc.c
+++ b/drivers/pps/clients/pps-ldisc.c
@@ -8,12 +8,14 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/serial_core.h>
 #include <linux/tty.h>
 #include <linux/pps_kernel.h>
 #include <linux/bug.h>
+#include <linux/string.h>
 
-static void pps_tty_dcd_change(struct tty_struct *tty, unsigned int status)
+static void pps_tty_activepin_change(struct tty_struct *tty, unsigned int status)
 {
 	struct pps_device *pps;
 	struct pps_event_time ts;
@@ -36,6 +38,29 @@ static void pps_tty_dcd_change(struct tty_struct *tty, unsigned int status)
 			status ? "assert" : "clear", jiffies);
 }
 
+static void pps_tty_activepin_change_invertlogic(struct tty_struct *tty, unsigned int status)
+{
+	struct pps_device *pps;
+	struct pps_event_time ts;
+
+	pps_get_ts(&ts);
+
+	pps = pps_lookup_dev(tty);
+	/*
+	 * This should never fail, but the ldisc locking is very
+	 * convoluted, so don't crash just in case.
+	 */
+	if (WARN_ON_ONCE(pps == NULL))
+		return;
+
+	/* Now do the PPS event report */
+	pps_event(pps, &ts, status ? PPS_CAPTURECLEAR :
+			PPS_CAPTUREASSERT, NULL);
+
+	dev_dbg(pps->dev, "PPS %s at %lu\n",
+			status ? "assert" : "clear", jiffies);
+}
+
 static int (*alias_n_tty_open)(struct tty_struct *tty);
 
 static int pps_tty_open(struct tty_struct *tty)
@@ -99,10 +124,118 @@ static struct tty_ldisc_ops pps_ldisc_ops;
  * Module stuff
  */
 
+/*
+ * activepin parameter (dcd or cts) to handle the case of
+ * some SBC computers with incomplete UART wiring (no dcd)
+ * and still allow using cts as the 1PPS signal input pin
+ */
+
+static char *activepin = "dcd";
+
+/*
+ * invertlogic parameter (0 or 1) allows handling the case
+ * of some uarts (e.g. TTL UARTs) were the rising / falling
+ * edges have inverted logic with respect to conventions of
+ * the RS232 standard
+ */
+
+static bool invertlogic;
+
+static void pps_ldisc_update_settings(void)
+{
+	pr_info("%s: activepin=%s invertlogic=%c\n",
+		__func__, activepin, invertlogic?'Y':'N');
+
+	if (strncasecmp(activepin, "dcd", 3) == 0) {
+		pps_ldisc_ops.cts_change = 0;
+		if (!invertlogic)
+			pps_ldisc_ops.dcd_change = pps_tty_activepin_change;
+		else
+			pps_ldisc_ops.dcd_change = pps_tty_activepin_change_invertlogic;
+	} else if (strncasecmp(activepin, "cts", 3) == 0) {
+		pps_ldisc_ops.dcd_change = 0;
+		if (!invertlogic)
+			pps_ldisc_ops.cts_change = pps_tty_activepin_change;
+		else
+			pps_ldisc_ops.cts_change = pps_tty_activepin_change_invertlogic;
+	} else {
+		pps_ldisc_ops.cts_change = 0;
+		pps_ldisc_ops.dcd_change = 0;
+	}
+}
+
+static int pps_set_activepin(const char *val, const struct kernel_param *kp)
+{
+	int res = 0;
+	bool update_setting = false;
+	int lenval = strlen(val);
+	bool currentvalue_is_dcd = (strncasecmp(activepin, "dcd", 3) == 0);
+
+	if ((lenval == 3 && strncasecmp(val, "dcd", lenval) == 0) ||
+		(lenval == 4 && strncasecmp(val, "dcd\n", lenval) == 0)) {
+		if (!currentvalue_is_dcd) {
+			update_setting = true;
+			res = param_set_charp("dcd", kp);
+		}
+	} else if ((lenval == 3 && strncasecmp(val, "cts", lenval) == 0) ||
+		(lenval == 4 && strncasecmp(val, "cts\n", lenval) == 0)) {
+		if (currentvalue_is_dcd) {
+			update_setting = true;
+			res = param_set_charp("cts", kp);
+		}
+	} else
+		res = -1;
+
+	if (res == 0 && update_setting)
+		pps_ldisc_update_settings();
+	else if (res != 0)
+		pr_info("unable to set activepin parameter to %s\n", val);
+
+	return res;
+}
+
+static const struct kernel_param_ops activepin_ops = {
+	.set = &pps_set_activepin,
+	.get = &param_get_charp,
+};
+
+module_param_cb(activepin, &activepin_ops, &activepin, 0664);
+
+MODULE_PARM_DESC(activepin, \
+"\n\t\tparameter can be either dcd (default) or cts and defines the\n\
+\t\tphysical UART pin which receives the analogic PPS signal.");
+
+static int pps_set_invertlogic(const char *val, const struct kernel_param *kp)
+{
+	bool lastvalue = *(bool *)(kp->arg);
+	int res = param_set_bool(val, kp);
+
+	if (res == 0 && lastvalue != invertlogic)
+		pps_ldisc_update_settings();
+
+	return res;
+}
+
+static const struct kernel_param_ops invertlogic_ops = {
+	.set = &pps_set_invertlogic,
+	.get = &param_get_bool,
+};
+
+module_param_cb(invertlogic, &invertlogic_ops, &invertlogic, 0664);
+
+MODULE_PARM_DESC(invertlogic, \
+"\n\t\tflag can be either N (default) or Y and allows handling some\n\
+\t\tUARTs (e.g. TTL UARTs) whose reference edge vs. status logic\n\
+\t\t(rising/falling vs. active/inactive) is the opposite of the\n\
+\t\tRS232 standard.");
+
 static int __init pps_tty_init(void)
 {
 	int err;
 
+	pr_info("%s: activepin=%s invertlogic=%c\n",
+		__func__, activepin, invertlogic?'Y':'N');
+
 	/* Inherit the N_TTY's ops */
 	n_tty_inherit_ops(&pps_ldisc_ops);
 
@@ -114,7 +247,7 @@ static int __init pps_tty_init(void)
 	pps_ldisc_ops.owner = THIS_MODULE;
 	pps_ldisc_ops.num = N_PPS;
 	pps_ldisc_ops.name = "pps_tty";
-	pps_ldisc_ops.dcd_change = pps_tty_dcd_change;
+	pps_ldisc_update_settings();
 	pps_ldisc_ops.open = pps_tty_open;
 	pps_ldisc_ops.close = pps_tty_close;
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 1e738f265eea..abbab3fb1282 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3096,8 +3096,21 @@ EXPORT_SYMBOL_GPL(uart_handle_dcd_change);
  */
 void uart_handle_cts_change(struct uart_port *uport, unsigned int status)
 {
+	struct tty_port *port = &uport->state->port;
+	struct tty_struct *tty = port->tty;
+	struct tty_ldisc *ld;
+
 	lockdep_assert_held_once(&uport->lock);
 
+	if (tty) {
+		ld = tty_ldisc_ref(tty);
+		if (ld) {
+			if (ld->ops->cts_change)
+				ld->ops->cts_change(tty, status);
+			tty_ldisc_deref(ld);
+		}
+	}
+
 	uport->icount.cts++;
 
 	if (uart_softcts_mode(uport)) {
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index b85d84fb5f49..1ec282b7c584 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -112,6 +112,11 @@ struct tty_struct;
  *	Tells the discipline that the DCD pin has changed its status.
  *	Used exclusively by the N_PPS (Pulse-Per-Second) line discipline.
  *
+ * void (*cts_change)(struct tty_struct *tty, unsigned int status)
+ *
+ *	Tells the discipline that the CTS pin has changed its status.
+ *	Used exclusively by the N_PPS (Pulse-Per-Second) line discipline.
+ *
  * int	(*receive_buf2)(struct tty_struct *, const unsigned char *cp,
  *			char *fp, int count);
  *
@@ -208,6 +213,7 @@ struct tty_ldisc_ops {
 			       const char *fp, int count);
 	void	(*write_wakeup)(struct tty_struct *);
 	void	(*dcd_change)(struct tty_struct *, unsigned int);
+	void	(*cts_change)(struct tty_struct *, unsigned int);
 	int	(*receive_buf2)(struct tty_struct *, const unsigned char *cp,
 				const char *fp, int count);
 
-- 
2.25.1


