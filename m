Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3070CC64EC7
	for <linux-serial@archiver.kernel.org>; Sat, 25 Feb 2023 23:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBYXkx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 25 Feb 2023 18:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjBYXkw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 25 Feb 2023 18:40:52 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32C51114C
        for <linux-serial@vger.kernel.org>; Sat, 25 Feb 2023 15:40:51 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31PNeCYQ023371
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Feb 2023 18:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1677368415; bh=bhCYEJZLM0pCZMEqN/8syJ86bdQY23N9bdwXdXRI52k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=gaqYJQoJ+UO8ASGAWAskViNyCMvALinTduCB4ZrQfBSRkwWj/R0RvZSB1tVijRaQa
         k++Hs+RBQE99rxmwGyDzeErpJ4/oD1mFwtPpOrTI34kEL65BcrAUl4wYOC+X15hKd7
         07kH555TsnikF2oY2wB/iRzRfvbF5ZF6ewnymVoIkoXh/9iW2CZnuH6B1KjkdoSvKt
         eJLr+9PxoSMFnzTLxXClnhDiBhkYg0hiRPoIh+EXf7qYl9ozaZ1QXEawSXlwfxk89B
         Ael0FpbOVoKB0StAyppyo1skHolMw2y9vLPEAakHnV0OjOidHo7LnFv3B/ha6l9lXm
         3uHLkaIPmwJSA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2FBE415C581F; Sat, 25 Feb 2023 18:40:12 -0500 (EST)
Date:   Sat, 25 Feb 2023 18:40:12 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [GIT PULL] TTY/Serial driver updates for 6.3-rc1
Message-ID: <Y/qcXOxTVHTNDQbY@mit.edu>
References: <Y/iywbFbiUAA6ZD3@kroah.com>
 <CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com>
 <CAHk-=wjyFhdR-M7H6JpH7zF0k_z5xj8+qERaHsh5+0c4uOmv+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjyFhdR-M7H6JpH7zF0k_z5xj8+qERaHsh5+0c4uOmv+g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Feb 24, 2023 at 01:30:58PM -0800, Linus Torvalds wrote:
> 
> It's probably most legacy by now - it's a long time since I saw a
> serial port being used outside of management ports, and even those are
> often ethernet these days.

For what it's worth, in the VM world (e.g., qemu, AWS, GCP, Azure,
Linode, etc.)  serial consoles are quite common way of debugging VM's,
and as an emergency login path when the networking has been screwed up
for some reason....

						- Ted
