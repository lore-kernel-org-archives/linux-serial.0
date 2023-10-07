Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DF9E92FE4
	for <linux-serial@archiver.kernel.org>; Sat,  7 Oct 2023 05:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343510AbjJGFps (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 7 Oct 2023 01:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjJGFpr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 7 Oct 2023 01:45:47 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2A372BB;
        Fri,  6 Oct 2023 22:45:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id A15F380E0;
        Sat,  7 Oct 2023 05:45:42 +0000 (UTC)
Date:   Sat, 7 Oct 2023 08:45:41 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: Re: [PATCH] serial: core: Fix checks for tx runtime PM state
Message-ID: <20231007054541.GL34982@atomide.com>
References: <20231005075644.25936-1-tony@atomide.com>
 <ZR6lc/F1Esxt5ChI@smile.fi.intel.com>
 <20231006072738.GI34982@atomide.com>
 <ZR-_TUSwvIs6Vl_v@hovoldconsulting.com>
 <20231006083712.GJ34982@atomide.com>
 <ZSAp0hUOPQNtOG_T@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSAp0hUOPQNtOG_T@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Johan Hovold <johan@kernel.org> [231006 15:37]:
> On Fri, Oct 06, 2023 at 11:37:12AM +0300, Tony Lindgren wrote:
> > OK so let's just use:
> > 
> > The serdev controller runtime PM state is not currently propagated
> > to the serial core controller port device. The runtime PM usage count
> > only propagates to the parent device.
> 
> That sounds better.

OK

> > > I'm still not sure why it was implemented this way, or if it is even
> > > correct, but this seems to be the state of things.
> > 
> > Care to clarify a bit which parts are unclear? The hierarchy of port
> > devices, making serial core manage runtime PM in a generic way, or
> > flushing tx?
> 
> I still don't know why you added these two new abstractions (controller
> and port), and that isn't really explained by the commit message either.

We want serial core to do runtime PM in a generic way and have the usage
count propagate to the parent serial port hardware device. This way we
don't need to care much if the numerous serial port drivers implement
runtime PM or not. Well, except for now we need to check the parent state
for this fix :)

We also want serial core to know the serial port to serial port hardware
mapping as we already have multiport devices. The serial core controller
is there to group the serial ports for each serial port hardware device.
We at least now have an option to support devices with multiple controllers
and ports in case we ever happen to see such things.

> And if these are indeed needed, then why isn't the serdev controller now
> a child of the "port" device, for example?

Yes I agree we should now move serdev controller to be a child of the
serial core port device. Then this $subject patch can be reverted.

Moving serdev controller should also help serdev to deal with multiport
devices I think?

In the long run serial port specific functions could live there too.

> There are just a lot of questions and I worry that there are more
> problems lurking, but unfortunately I still don't have time to review
> this.

Well incremental steps should be easier to do now.

Regards,

Tony
