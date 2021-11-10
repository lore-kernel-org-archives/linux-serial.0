Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35ECC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 09:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF10061247
	for <linux-serial@archiver.kernel.org>; Wed, 10 Nov 2021 09:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbhKJJJZ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Nov 2021 04:09:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:46272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229831AbhKJJJY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Nov 2021 04:09:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D20061241;
        Wed, 10 Nov 2021 09:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636535197;
        bh=cQh2gtzFbpiUqUoKtpQ5ieN8FrH0G315r3j++GSu4uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yH7VPWK6HT/e2u3+UQ6g9J3HCJea5fPZ2hGGJ6qTG0xTa3Wkv5aFsIQYGDVin+iNR
         pxQYpklmdQyOsJe64EyRBgUeNKCghHU63D06RHAykSC88qY8gJKvoIYLotk0T7kKNJ
         eYqcFWAlVIhP/CcUoEZxaCdC53GWegCJPkrNs7i4=
Date:   Wed, 10 Nov 2021 10:06:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>, kernel@esmil.dk,
        David Laight <David.Laight@aculab.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tty: vt: keyboard: do not copy an extra-byte in
 copy_to_user
Message-ID: <YYuLmMxbKLqHD+ZW@kroah.com>
References: <CAHP4M8Ww0-VqCBKX=iLd=zy1AcDoNdzTOqJuaqRxCGZsMhoX9w@mail.gmail.com>
 <CAHP4M8UcZ=ttB8jbN1yOY6YH8SiQ27NhdEKi9SDH1CWG-GY6eg@mail.gmail.com>
 <6b58a3e1-f2ea-cc4c-03b2-06334b559373@gmail.com>
 <CAHP4M8Vs8a8u98enuHXaBcC7D4fCZzCOtEq06VnvuPUqhqPK=Q@mail.gmail.com>
 <9717b429-597f-7778-c880-94361bcdee7f@gmail.com>
 <CAHP4M8XtFiAa1kF5A_rPbcui3DP8L6iyfP8GbwgLLzo0Bo+TNQ@mail.gmail.com>
 <65c45951-08ba-26bb-f96b-3d4442b1d4d4@gmail.com>
 <08c9e717-4367-5316-87cd-90b5ceb13ed9@kernel.org>
 <1305bb43-b4bf-e129-af6e-957d1f30f269@gmail.com>
 <CAHP4M8XfCJ8btBCf42GEZGWm_4ywhPKyXtxoBbHR4U190=gg_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHP4M8XfCJ8btBCf42GEZGWm_4ywhPKyXtxoBbHR4U190=gg_A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Nov 10, 2021 at 02:27:36PM +0530, Ajay Garg wrote:
> >
> > Ajay wants to be safe and he thinks, that relying on fact, that
> > strlen(func_table[kb_func]) < sizeof(user_kdgkb->kb_string) is not good
> > approach, since it's external for vt_do_kdgkb_ioctl. (I hope, I've
> > explained his idea in the right way)
> >
> 
> That's right Pavel.
> Every function must work correctly as it "advertises", instead of
> relying on "chancy correctness" of the calls leading to the method.

That is not how the kernel works, sorry.  Otherwise every function would
have to always verify all parameters passed to them, causing slow downs
and redundant checks everywhere.

When all users of functions are in the kernel tree itself, you can use
tools and manual verification that the code is correct, because those
are the only users of the functions.

thanks,

greg k-h
