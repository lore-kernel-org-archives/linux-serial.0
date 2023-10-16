Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3B1CDB465
	for <linux-serial@archiver.kernel.org>; Mon, 16 Oct 2023 15:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbjJPPSh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Oct 2023 11:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjJPPSf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Oct 2023 11:18:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314E4EE;
        Mon, 16 Oct 2023 08:18:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F046C433C8;
        Mon, 16 Oct 2023 15:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697469511;
        bh=boEy4hDOwZYIC6f1Ctc6vM+vlw2nq8iYhzUDSrBTrMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bNtVx9A88qV/6tHstNr+1lRzQoQu+TTdFpNdGZbrVu8ss9R3BYXI8Ea/M7cVlHLjZ
         CzevzxrDFLxf1Hwz12qUEZphl8XiTIIh/mJN2qm3/c6Dd3o2UCAOxtlUIh8u82HnwI
         6aD4BgQTSsMMOyFEzRnrrg3IML7ffU4fnqnwUZIx5ca5+CxeyN0id3D2PxAjKdrxEG
         5tSBhCN1jbGF1Szwe2OGufS9Qf7ea37IjHmk4yLtBEWD6ev9IhMhlgiGGaCwPxtPF5
         WJxKrzMkZXHy7E5leTEl/g7ufzGVb+aE4j7/f5JORcHXM6BDA86JgmVd/fzYxteSPj
         1sla1sj1QkDJA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qsPMP-0005it-39;
        Mon, 16 Oct 2023 17:18:26 +0200
Date:   Mon, 16 Oct 2023 17:18:25 +0200
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
Message-ID: <ZS1UQS4FQYq2ZeaC@hovoldconsulting.com>
References: <20231005075644.25936-1-tony@atomide.com>
 <ZR6lc/F1Esxt5ChI@smile.fi.intel.com>
 <20231006072738.GI34982@atomide.com>
 <ZR-_TUSwvIs6Vl_v@hovoldconsulting.com>
 <20231006083712.GJ34982@atomide.com>
 <ZSAp0hUOPQNtOG_T@hovoldconsulting.com>
 <20231007054541.GL34982@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007054541.GL34982@atomide.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Oct 07, 2023 at 08:45:41AM +0300, Tony Lindgren wrote:
> * Johan Hovold <johan@kernel.org> [231006 15:37]:
> > On Fri, Oct 06, 2023 at 11:37:12AM +0300, Tony Lindgren wrote:

> > > Care to clarify a bit which parts are unclear? The hierarchy of port
> > > devices, making serial core manage runtime PM in a generic way, or
> > > flushing tx?
> > 
> > I still don't know why you added these two new abstractions (controller
> > and port), and that isn't really explained by the commit message either.
> 
> We want serial core to do runtime PM in a generic way and have the usage
> count propagate to the parent serial port hardware device. This way we
> don't need to care much if the numerous serial port drivers implement
> runtime PM or not. Well, except for now we need to check the parent state
> for this fix :)

That sounds like a lot of complexity to avoid checking if (the single
instance of) pm_runtime_get() returns -EACCESS.
 
> We also want serial core to know the serial port to serial port hardware
> mapping as we already have multiport devices. The serial core controller
> is there to group the serial ports for each serial port hardware device.
> We at least now have an option to support devices with multiple controllers
> and ports in case we ever happen to see such things.

Hypothetical multiple serial controllers should be modelled as separate
controllers, but yeah, perhaps we want to describe the ports.
 
> > And if these are indeed needed, then why isn't the serdev controller now
> > a child of the "port" device, for example?
> 
> Yes I agree we should now move serdev controller to be a child of the
> serial core port device. Then this $subject patch can be reverted.
> 
> Moving serdev controller should also help serdev to deal with multiport
> devices I think?

It wouldn't help currently I think, since we already resume the
controller and don't manage ports individually, but if we now have port
devices then it probably should be moved.

Johan
