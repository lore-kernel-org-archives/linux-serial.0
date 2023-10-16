Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD6FCDB465
	for <linux-serial@archiver.kernel.org>; Mon, 16 Oct 2023 07:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjJPHYJ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Oct 2023 03:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjJPHX7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Oct 2023 03:23:59 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDF47B4
        for <linux-serial@vger.kernel.org>; Mon, 16 Oct 2023 00:23:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3EE4580AF;
        Mon, 16 Oct 2023 07:23:54 +0000 (UTC)
Date:   Mon, 16 Oct 2023 10:23:52 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Mikko Rapeli <mikko.rapeli@linaro.org>
Cc:     Richard Purdie <richard.purdie@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        openembedded-core <openembedded-core@lists.openembedded.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Randy MacLeod <randy.macleod@windriver.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Kernel 6.5 ttyS1 hang with qemu (was Re: [OE-core] Summary of
 the remaining 6.5 kernel serial issue (and 6.5 summary)
Message-ID: <20231016072352.GM27774@atomide.com>
References: <178BF2895FF685E6.5378@lists.openembedded.org>
 <a2ad67a0575548b6d5d8d187e597dcd72ae07f64.camel@linuxfoundation.org>
 <ZSPQY6UYg21Z0PnN@nuoska>
 <1520ecb5f4b6959af835a7781b94694913f76912.camel@linuxfoundation.org>
 <178DF50519C11C84.8679@lists.openembedded.org>
 <b208c9c6b72be4ef0f2aadb7bed103280bff60a0.camel@linuxfoundation.org>
 <2023101516-unmolded-otter-e3e0@gregkh>
 <214757eca7f4cd639a7a8d9a822476c1ec30f01c.camel@linuxfoundation.org>
 <20231016063501.GL27774@atomide.com>
 <ZSzjNgdCH_wmB4u2@nuoska>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSzjNgdCH_wmB4u2@nuoska>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Mikko Rapeli <mikko.rapeli@linaro.org> [231016 07:16]:
> Hi,
> 
> On Mon, Oct 16, 2023 at 09:35:01AM +0300, Tony Lindgren wrote:
> > * Richard Purdie <richard.purdie@linuxfoundation.org> [231015 21:30]:
> > > On Sun, 2023-10-15 at 17:31 +0200, Greg Kroah-Hartman wrote:
> > > > Can you try the patch below?  I just sent it to Linus and it's from Tony
> > > > to resolve some other pm issues with the serial port code.
> > > 
> > > Thanks for the pointer to this. I've put it through some testing and
> > > had one failure so far so I suspect this isn't enough unfortunately.
> > >
> > > FWIW I was looping the testing on the complete removal of the
> > > conditions and didn't see any failures with that.
> > 
> > Care to clarify what's the failing test now?
> > 
> > Is the issue still the second port not always coming up after boot or
> > something else?
> 
> Yes, data from the ttyS1 getty is not coming through from kernel and qemu to
> the test framework looking for login prompt after qemu machine boot.
> Workarounds like sending "\n\n" from the test framework through qemu to ttyS1
> or "echo helloB > /dev/ttyS1" via working ttyS0 don't seem to help and wake
> it up.

OK so for trying to reproduce this with qemu, is this with the default uarts
or with some -device pci-serial-2x type options?

Regards,

Tony
