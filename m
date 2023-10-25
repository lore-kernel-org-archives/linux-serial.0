Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E6FC0032E
	for <linux-serial@archiver.kernel.org>; Wed, 25 Oct 2023 06:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbjJYGlh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 25 Oct 2023 02:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjJYGlg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 25 Oct 2023 02:41:36 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F87310A
        for <linux-serial@vger.kernel.org>; Tue, 24 Oct 2023 23:41:34 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2786F80AA;
        Wed, 25 Oct 2023 06:41:33 +0000 (UTC)
Date:   Wed, 25 Oct 2023 09:41:31 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Kevin Hilman <khilman@kernel.org>
Cc:     Thomas Richard <thomas.richard@bootlin.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, gregory.clement@bootlin.com,
        u-kumar1@ti.com, d-gole@ti.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH] serial: 8250_omap: Set the console genpd always on if no
 console suspend
Message-ID: <20231025064131.GZ27774@atomide.com>
References: <20231017130540.1149721-1-thomas.richard@bootlin.com>
 <7hfs213u0r.fsf@baylibre.com>
 <20231024045109.GT27774@atomide.com>
 <7hjzrbj29t.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7hjzrbj29t.fsf@baylibre.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Kevin Hilman <khilman@kernel.org> [231024 18:36]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Kevin Hilman <khilman@kernel.org> [231023 21:31]:
> >> Instead, what should be happening is that when `no_console_suspend` is
> >> set, there should be an extra pm_runtime_get() which increases the
> >> device usecount such that the device never runtime suspends, and thus
> >> the domain will not get powered off.
> >
> > We already have the runtime PM usage count kept in the driver (unless
> > there's a bug somewhere). The issue is that on suspend the power domain
> > still gets shut down.
> >
> > I suspect that some of the SoC power domains get
> > force shut down on suspend somewhere?
> 
> If setting GENPD_FLAG_ALWAYS_ON works as this patch proposes, then a
> force shutdown would override that genpd flag also, so I suspect the 
> runtime PM usage count is not correct.

OK good point.

> I quick skim of 8250_omap.c, and I don't see any pm_runtime_get() calls
> that are conditional on no_console_suspend, which is what I would
> suspect for the domain to stay on.

If a serial console is attached, we now have runtime PM usage count
always kept. Users can detach the console via sysfs as needed. See these
two earlier commits from Andy:

a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
bedb404e91bb ("serial: 8250_port: Don't use power management for kernel console")

Sounds like there's a bug somewhere. It's worth verifying if the runtime
PM usage count is kept for 8250_omap on suspend.

Thomas, care to check your test case with the attached debug hack
and by adding a call for pm_runtime_get_usage_count() on the suspend
path?

Regards,

Tony

8< -------------------------------
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -129,6 +129,11 @@ static inline void pm_runtime_get_noresume(struct device *dev)
 	atomic_inc(&dev->power.usage_count);
 }
 
+static inline int pm_runtime_get_usage_count(struct device *dev)
+{
+	return atomic_read(&dev->power.usage_count);
+}
+
 /**
  * pm_runtime_put_noidle - Drop runtime PM usage counter of a device.
  * @dev: Target device.
