Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDEFE81E0D
	for <linux-serial@archiver.kernel.org>; Fri,  6 Oct 2023 15:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbjJFPhk (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Oct 2023 11:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjJFPhi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Oct 2023 11:37:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E81AD;
        Fri,  6 Oct 2023 08:37:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52ABC433C7;
        Fri,  6 Oct 2023 15:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696606655;
        bh=NmvkWFD8bZHwX17GRmdTtmtgoVM/o6Qpx7umeFUh+O0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A5llU35VLJGd50hYxUpaWZU9/v5UvRAzBWhsxz+ESpi21DbdU67fPQh+mIokBW06b
         bQwj9Kr2EtNJh2Qd3oTOnwx3oDkrI6iO/UsIIe1N46QPM8LW5CgUEabASjf/yR2m7V
         NbZvoe4JWQCqeJdiv4DjN3Px1Tx9/uoVl2+Wvp99voVIxIBXZC58p5n+3QU3W7TQIU
         wJT1lKhqO4iFIJz7QF04sa/DPW8N/sVhjenipYP3AQOF1BVitEETtUZUSQJCZWdTdp
         6vCeu96fhuChuvsSUTwGBshAQVcWZpx0FtLLg4LZqutyZY16PB/D4CPyh/0iaf8B6T
         sAZE+gUqD557A==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qomtm-00068G-0D;
        Fri, 06 Oct 2023 17:37:54 +0200
Date:   Fri, 6 Oct 2023 17:37:54 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tony Lindgren <tony@atomide.com>
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
Message-ID: <ZSAp0hUOPQNtOG_T@hovoldconsulting.com>
References: <20231005075644.25936-1-tony@atomide.com>
 <ZR6lc/F1Esxt5ChI@smile.fi.intel.com>
 <20231006072738.GI34982@atomide.com>
 <ZR-_TUSwvIs6Vl_v@hovoldconsulting.com>
 <20231006083712.GJ34982@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006083712.GJ34982@atomide.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 06, 2023 at 11:37:12AM +0300, Tony Lindgren wrote:
> * Johan Hovold <johan@kernel.org> [231006 08:03]:
> > On Fri, Oct 06, 2023 at 10:27:38AM +0300, Tony Lindgren wrote:

> > > You're right, so how about:
> > > 
> > > The serdev device and the serial core controller devices are children of
> > > the serial port hardware device. The runtime PM usage count from serdev
> > > device does not propagate to the serial core device siblings, it only
> > > propagates to the parent.
> > 
> > That's still not accurate:
> > 
> >  - the serdev device is not a child (but a grandchild) of the serial
> >    controller
> >  - the new serial port devices are not "siblings" (but descendants) of
> >    the serial controller
> >  - the serdev controller ignores the power state of its children so that
> >    bit is also incorrect
> > 
> > You just want to describe the fact that the serdev controller runtime PM
> > state is currently not propagated to your new "devices" that are
> > descendants to the serial controller.
> 
> OK so let's just use:
> 
> The serdev controller runtime PM state is not currently propagated
> to the serial core controller port device. The runtime PM usage count
> only propagates to the parent device.

That sounds better.

> > I'm still not sure why it was implemented this way, or if it is even
> > correct, but this seems to be the state of things.
> 
> Care to clarify a bit which parts are unclear? The hierarchy of port
> devices, making serial core manage runtime PM in a generic way, or
> flushing tx?

I still don't know why you added these two new abstractions (controller
and port), and that isn't really explained by the commit message either.
And if these are indeed needed, then why isn't the serdev controller now
a child of the "port" device, for example?

There are just a lot of questions and I worry that there are more
problems lurking, but unfortunately I still don't have time to review
this.

Johan
