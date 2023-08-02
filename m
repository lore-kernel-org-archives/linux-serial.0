Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB4FC001DF
	for <linux-serial@archiver.kernel.org>; Wed,  2 Aug 2023 12:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjHBMFf (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 2 Aug 2023 08:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjHBMFe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 2 Aug 2023 08:05:34 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A8B110C1;
        Wed,  2 Aug 2023 05:05:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 4C38480AE;
        Wed,  2 Aug 2023 12:05:32 +0000 (UTC)
Date:   Wed, 2 Aug 2023 15:05:30 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update TTY layer for lists and recently
 added files
Message-ID: <20230802120530.GE14799@atomide.com>
References: <20230721072334.59272-1-tony@atomide.com>
 <ZLpboaXKVOOjeGJ+@smile.fi.intel.com>
 <20230724045327.GV5194@atomide.com>
 <2023072517-onward-payment-569d@gregkh>
 <2023072530-wired-chaps-c1e3@gregkh>
 <edb0414f-3808-8651-4956-8ec34b056901@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edb0414f-3808-8651-4956-8ec34b056901@kernel.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Jiri Slaby <jirislaby@kernel.org> [230726 10:12]:
> On 25. 07. 23, 19:29, Greg Kroah-Hartman wrote:
> > On Tue, Jul 25, 2023 at 07:28:46PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Jul 24, 2023 at 07:53:27AM +0300, Tony Lindgren wrote:
> > > > * Andy Shevchenko <andriy.shevchenko@intel.com> [230721 10:19]:
> > > > > On Fri, Jul 21, 2023 at 10:23:32AM +0300, Tony Lindgren wrote:
> > > > > > Add mailing lists for linux-serial and lkml for the TTY layer. And let's
> > > > > > list the recently added files. This makes it easier for get_maintainer.pl
> > > > > > to include linux-serial for patches.
> > > > > 
> > > > > Shouldn't serial_* stuff go to the "SERIAL DRIVERS" section?
> > > > 
> > > > Not sure if there's some reason we have "TTY LAYER" with serial_core
> > > > files. If not, yeah let's move the serial files.
> > > 
> > > I'll take this patch, can you send a new one that removes the serial
> > > files from this entry as I don't think they are needed in here anymore.
> > 
> > Better yet, they should be merged probably.  Although I don't know if
> > Jiri wants to be responsible for serial stuff, that's his call...
> 
> No problem. I actually didn't realize they are separate. So feel free to
> submit a patch, so we have a single MAINTAINTERS file entry...

How about something like this?

Tony

8< ----------------------
diff --git a/MAINTAINERS b/MAINTAINERS
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19319,13 +19319,6 @@ F:	Documentation/devicetree/bindings/serial/serial.yaml
 F:	drivers/tty/serdev/
 F:	include/linux/serdev.h
 
-SERIAL DRIVERS
-M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
-L:	linux-serial@vger.kernel.org
-S:	Maintained
-F:	Documentation/devicetree/bindings/serial/
-F:	drivers/tty/serial/
-
 SERIAL IR RECEIVER
 M:	Sean Young <sean@mess.org>
 L:	linux-media@vger.kernel.org
@@ -21760,20 +21753,16 @@ W:	https://github.com/srcres258/linux-doc
 T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
-TTY LAYER
+TTY LAYER AND SERIAL DRIVERS
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Jiri Slaby <jirislaby@kernel.org>
 L:	linux-kernel@vger.kernel.org
 L:	linux-serial@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
+F:	Documentation/devicetree/bindings/serial/
 F:	Documentation/driver-api/serial/
 F:	drivers/tty/
-F:	drivers/tty/serial/serial_base.h
-F:	drivers/tty/serial/serial_base_bus.c
-F:	drivers/tty/serial/serial_core.c
-F:	drivers/tty/serial/serial_ctrl.c
-F:	drivers/tty/serial/serial_port.c
 F:	include/linux/selection.h
 F:	include/linux/serial.h
 F:	include/linux/serial_core.h
-- 
2.41.0
