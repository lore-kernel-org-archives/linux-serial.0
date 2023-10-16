Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7BDCDB474
	for <linux-serial@archiver.kernel.org>; Mon, 16 Oct 2023 06:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjJPGfF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Oct 2023 02:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjJPGfF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Oct 2023 02:35:05 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 815EBAD
        for <linux-serial@vger.kernel.org>; Sun, 15 Oct 2023 23:35:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 698B380CC;
        Mon, 16 Oct 2023 06:35:02 +0000 (UTC)
Date:   Mon, 16 Oct 2023 09:35:01 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Richard Purdie <richard.purdie@linuxfoundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mikko Rapeli <mikko.rapeli@linaro.org>,
        linux-serial@vger.kernel.org,
        openembedded-core <openembedded-core@lists.openembedded.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Randy MacLeod <randy.macleod@windriver.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Kernel 6.5 ttyS1 hang with qemu (was Re: [OE-core] Summary of
 the remaining 6.5 kernel serial issue (and 6.5 summary)
Message-ID: <20231016063501.GL27774@atomide.com>
References: <178BF2895FF685E6.5378@lists.openembedded.org>
 <a2ad67a0575548b6d5d8d187e597dcd72ae07f64.camel@linuxfoundation.org>
 <ZSPQY6UYg21Z0PnN@nuoska>
 <1520ecb5f4b6959af835a7781b94694913f76912.camel@linuxfoundation.org>
 <178DF50519C11C84.8679@lists.openembedded.org>
 <b208c9c6b72be4ef0f2aadb7bed103280bff60a0.camel@linuxfoundation.org>
 <2023101516-unmolded-otter-e3e0@gregkh>
 <214757eca7f4cd639a7a8d9a822476c1ec30f01c.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <214757eca7f4cd639a7a8d9a822476c1ec30f01c.camel@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Richard Purdie <richard.purdie@linuxfoundation.org> [231015 21:30]:
> On Sun, 2023-10-15 at 17:31 +0200, Greg Kroah-Hartman wrote:
> > Can you try the patch below?  I just sent it to Linus and it's from Tony
> > to resolve some other pm issues with the serial port code.
> 
> Thanks for the pointer to this. I've put it through some testing and
> had one failure so far so I suspect this isn't enough unfortunately.
>
> FWIW I was looping the testing on the complete removal of the
> conditions and didn't see any failures with that.

Care to clarify what's the failing test now?

Is the issue still the second port not always coming up after boot or
something else?

Regards,

Tony
