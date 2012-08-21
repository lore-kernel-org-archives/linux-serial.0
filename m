From: Pavan Savoy <pavan_savoy@ti.com>
Subject: pm_qos usage in omap-serial.c
Date: Tue, 21 Aug 2012 15:50:16 -0500
Message-ID: <CABUK1ah4=FOSUGSc3LwHwUF1_nt-cNZ+Jw9-6DBuC7dg7Xozfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:51137 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758542Ab2HUUuR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Aug 2012 16:50:17 -0400
Received: by qcro28 with SMTP id o28so193951qcr.19
        for <linux-serial@vger.kernel.org>; Tue, 21 Aug 2012 13:50:16 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, ruchika@ti.com, paul@pwsan.com, Govindraj Raja <govindraj.ti@gmail.com>

Paul, Govindraj,

I saw a few comments from you on the omap-serial driver that the PM
qos was required because of a silicion bug which failed to wake-up via
the PRCM interrupts when the tx fifo threshold reached.

What I wasnted to ask was - does that still hold good? Which OMAP was
this seen on ? omap3 or omap4?
As of today as you mention in your patch comments we do see an impact
on the power numbers because of this constraints held in the serial
driver, and removing this doesn't seem to impact performance
(through-put) either.
(All this being done in interrupt mode..)

Also, could you let me know - How exactly was the PRCM interrupts not
being generated tested ?

Thanks & Regards,
Pavan Savoy.
