Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B42BE92FF4
	for <linux-serial@archiver.kernel.org>; Fri,  6 Oct 2023 08:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjJFIDK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 6 Oct 2023 04:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjJFIDJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Oct 2023 04:03:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBF3CA;
        Fri,  6 Oct 2023 01:03:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0EE3C433CA;
        Fri,  6 Oct 2023 08:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696579387;
        bh=PcmAvvx88HZXcDnWhvV/6PWlJS0yccpOIGqXi/UObtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QlT8hPd7Un24UWMVDcvz/rzgyq3xzJU79JDYaLcghW+IT37t/3kDdeo2YShv/hJaS
         6NJsNF1WVUt3a3QGCbhoXIdelm2HFTy5NZwG6ARP5IP+s9D59p2JZPcF3HeCF4s8cg
         SC/rJYyM5rOg9I3qLVhb4DxCvaOvHWTohzi8LvR8TC4zJY/uzbPHsvq+POUYNZsp0N
         7/u38AyfeIViBjZW1QNZRauTlfam9zpt1y792gfv6uhDJ7CZkhXCEo705xUXqpK0Wh
         UA5HNW7eRATtjyb6kmFw9km87PV1blpPjoCYJUernMAXiKtwP42l3QQ9U8Ky/eoLTT
         Rt/MibdrBTyfA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qofnx-0004Aw-2b;
        Fri, 06 Oct 2023 10:03:25 +0200
Date:   Fri, 6 Oct 2023 10:03:25 +0200
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
Message-ID: <ZR-_TUSwvIs6Vl_v@hovoldconsulting.com>
References: <20231005075644.25936-1-tony@atomide.com>
 <ZR6lc/F1Esxt5ChI@smile.fi.intel.com>
 <20231006072738.GI34982@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006072738.GI34982@atomide.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Oct 06, 2023 at 10:27:38AM +0300, Tony Lindgren wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [231005 12:01]:
> > On Thu, Oct 05, 2023 at 10:56:42AM +0300, Tony Lindgren wrote:
> > > The serdev device and the serial core controller devices are siblings of
> > > the serial port hardware device. The runtime PM usage count from serdev
> > 
> > I'm a bit lost in terminology here.
> > AFAIU there are:
> > 1) children of the serial physical device;
> > 2) siblings (to each other).
> > 
> > But may be I mistakenly deciphered the diagram from the previous discussion.
> 
> You're right, so how about:
> 
> The serdev device and the serial core controller devices are children of
> the serial port hardware device. The runtime PM usage count from serdev
> device does not propagate to the serial core device siblings, it only
> propagates to the parent.

That's still not accurate:

 - the serdev device is not a child (but a grandchild) of the serial
   controller
 - the new serial port devices are not "siblings" (but descendants) of
   the serial controller
 - the serdev controller ignores the power state of its children so that
   bit is also incorrect

You just want to describe the fact that the serdev controller runtime PM
state is currently not propagated to your new "devices" that are
descendants to the serial controller.

I'm still not sure why it was implemented this way, or if it is even
correct, but this seems to be the state of things.

Johan
