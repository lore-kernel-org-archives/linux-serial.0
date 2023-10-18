Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E86ACDB47E
	for <linux-serial@archiver.kernel.org>; Wed, 18 Oct 2023 05:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjJRF20 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 Oct 2023 01:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjJRF2Z (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Oct 2023 01:28:25 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3BA1FA
        for <linux-serial@vger.kernel.org>; Tue, 17 Oct 2023 22:28:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5DEA18027;
        Wed, 18 Oct 2023 05:28:23 +0000 (UTC)
Date:   Wed, 18 Oct 2023 08:28:22 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Richard Purdie <richard.purdie@linuxfoundation.org>
Cc:     Mikko Rapeli <mikko.rapeli@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        openembedded-core <openembedded-core@lists.openembedded.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Randy MacLeod <randy.macleod@windriver.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Kernel 6.5 ttyS1 hang with qemu (was Re: [OE-core] Summary of
 the remaining 6.5 kernel serial issue (and 6.5 summary)
Message-ID: <20231018052822.GP27774@atomide.com>
References: <178DF50519C11C84.8679@lists.openembedded.org>
 <b208c9c6b72be4ef0f2aadb7bed103280bff60a0.camel@linuxfoundation.org>
 <2023101516-unmolded-otter-e3e0@gregkh>
 <214757eca7f4cd639a7a8d9a822476c1ec30f01c.camel@linuxfoundation.org>
 <20231016063501.GL27774@atomide.com>
 <ZSzjNgdCH_wmB4u2@nuoska>
 <20231016072352.GM27774@atomide.com>
 <0d86deae37877258f46322d4d727903fca12ad21.camel@linuxfoundation.org>
 <20231017065616.GN27774@atomide.com>
 <87cdf04bfd7997465dad157d9d81fc14ca7d122f.camel@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cdf04bfd7997465dad157d9d81fc14ca7d122f.camel@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

* Richard Purdie <richard.purdie@linuxfoundation.org> [231017 22:15]:
> On Tue, 2023-10-17 at 09:56 +0300, Tony Lindgren wrote:
> > * Richard Purdie <richard.purdie@linuxfoundation.org> [231016 08:10]:
> > > The port sometimes doesn't come up properly at boot.
> > > 
> > > To be clear, the "\n\n" from the qemu side into the port doesn't seem
> > > to help. The "echo helloB > /dev/ttyS1" inside the image does seem to
> > > wake it up. 
> > 
> > So if I understand correctly, this issue still happens with kernel patched
> > with commit 81a61051e0ce ("serial: core: Fix checks for tx runtime PM
> > state"), and the issue now only happens sometimes.
> 
> The issue has always been intermittent and it appeared to happen less
> frequently with 81a61051e0ce added but it was hard to know if I was
> imagining that.

Oh OK.

> > I wonder if the following additional change might help?
> 
> I've added it into testing and have not reproduced the failure with it
> applied yet, locally or on our autobuilder. We need to sort some
> release pieces which have been delayed by these issues and we're going
> with a workaround for that. Once that is built I can get back to
> testing this change more extensively, see if we can still provoke the
> issue or not. It may take a day or two of testing before we know with
> any certainty if the issue is resolved or not.

Thanks for the update, let's wait a few days and see then.

Regards,

Tony
