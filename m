From: Christian Pellegrin <chripell@fsfe.org>
Subject: [PATCH 1/3] max3100: added raise_threaded_irq
Date: Fri, 19 Mar 2010 09:38:54 +0100
Message-ID: <1268987934-22690-1-git-send-email-chripell__17487.1317613453$1268988551$gmane$org@fsfe.org>
References: <cabda6421003190139h344bc172h3556fca78e4b25cb@mail.gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:39782 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752988Ab0CSIsl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Mar 2010 04:48:41 -0400
Received: by qw-out-2122.google.com with SMTP id 8so522372qwh.37
        for <linux-serial@vger.kernel.org>; Fri, 19 Mar 2010 01:48:40 -0700 (PDT)
In-Reply-To: <cabda6421003190139h344bc172h3556fca78e4b25cb@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: feng.tang@intel.com, akpm@linux-foundation.org, greg@kroah.com, david-b@pacbell.net, grant.likely@secretlab.ca, alan@lxorguk.ukuu.org.uk, spi-devel-general@lists.sourceforge.netlinu
Cc: Christian Pellegrin <chripell@fsfe.org>

raise_threaded_irq schedules the execution of an interrupt thread

Signed-off-by: Christian Pellegrin <chripell@fsfe.org>
---
 include/linux/interrupt.h |    3 +++
 kernel/irq/manage.c       |   27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 75f3f00..14c0c13 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -144,6 +144,9 @@ request_threaded_irq(unsigned int irq, irq_handler_t handler,
 static inline void exit_irq_thread(void) { }
 #endif
 
+extern int raise_threaded_irq(unsigned int irq);
+
+
 extern void free_irq(unsigned int, void *);
 
 struct device;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index eb6078c..a7d21e0 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1088,3 +1088,30 @@ int request_threaded_irq(unsigned int irq, irq_handler_t handler,
 	return retval;
 }
 EXPORT_SYMBOL(request_threaded_irq);
+
+/**
+ *	raise_threaded_irq - triggers a threded interrupt
+ *	@irq: Interrupt line to trigger
+ */
+int raise_threaded_irq(unsigned int irq)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+	struct irqaction *action;
+
+	if (!desc)
+		return -ENOENT;
+	action = desc->action;
+	if (!action)
+		return -ENOENT;
+	if (unlikely(!action->thread_fn))
+		return -EINVAL;
+	if (likely(!test_bit(IRQTF_DIED,
+			     &action->thread_flags))) {
+		set_bit(IRQTF_RUNTHREAD, &action->thread_flags);
+		wake_up_process(action->thread);
+	} else {
+		return -ECHILD;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(raise_threaded_irq);
-- 
1.5.6.5

