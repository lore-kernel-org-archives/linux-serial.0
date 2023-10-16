Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AAACDB474
	for <linux-serial@archiver.kernel.org>; Mon, 16 Oct 2023 07:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbjJPHQq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 16 Oct 2023 03:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbjJPHQe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 16 Oct 2023 03:16:34 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3592170F
        for <linux-serial@vger.kernel.org>; Mon, 16 Oct 2023 00:16:13 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507a62d4788so1977516e87.0
        for <linux-serial@vger.kernel.org>; Mon, 16 Oct 2023 00:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697440572; x=1698045372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DbPYbKLlJ5BiSO4wtuS6smxtQmGTNqq7d+35QDKzymY=;
        b=reJODLtz2hNJzvVlSPCuC95sMSi0MoAi3h9P2UpPvmvPYq90QlBHZ24DRU5bAiULiy
         YFGedzieEpbCH07U+ckC9X0HpsWP8k9lw/xJwZfvNSaFs0IxETuHG7EuEEd0J4MDjnYV
         hfB0wbRlgMR6D2KIYYzyYJ8DoFgBc40jNU4VaKm4+7pE/cvqLukt/YDkmAXf8XlVH0j1
         YUkASJwx6ViOMiqqfaJOTUfcquQIB1OYhkfnUwHC3ysliS6u9Sg/coUW1O0+hmRdnQEb
         ivEurdCAZwQdsDL3oigWdyrLEHZWOxTDTOpooJlrPStr98M00O2hQ1mPepdCicxf41Bh
         Ut/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697440572; x=1698045372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DbPYbKLlJ5BiSO4wtuS6smxtQmGTNqq7d+35QDKzymY=;
        b=sUpBTdEyJV7sJkGbQs+7s9kiaNa8SkgiHBeW6NYOJZk+ue2YtRo/oeXQ6v44/C9GOa
         2G8dqSPTG+8AZ0bHhdDccvak8Ym7LPA7QIHrcDtzvnxOhUw32U83s3cb++nuUxv5wyHy
         IVNczH4xvBVUqy1UHYGhbVVm1DfYLwHM25EnMf2x12yRPCr8wH7GVDimX1RNRNXnlxAS
         xnlL+9gpTgfHmykfwlRr1ESlN1c3aNCV/uyNCnEEkl4DzU8v11iQY6A8eVgI03ZHVjfw
         s1hNog/ElUkU/2ht1BRUSEUbRo4wteD17msWTk8zOIVP2oAzx0bH7TaU46Jg6JmPJ5Z+
         s8og==
X-Gm-Message-State: AOJu0YwJJI6by2IXKuYX0Fs9gnCSC1cA0HClC8jU8dhUoiduMjqL2VWi
        5npChjHsF5L38y8RIfqvwliMrPTX2JfOncn9w1w=
X-Google-Smtp-Source: AGHT+IE0Ow54vtv7ZyDXScGFdC8M5BizsL6ucXJsyxMusg7/XktNiy+qr5BqVm3Svcuu2vdpacBUXQ==
X-Received: by 2002:a05:6512:48a:b0:507:984e:9f16 with SMTP id v10-20020a056512048a00b00507984e9f16mr6198600lfq.36.1697440572036;
        Mon, 16 Oct 2023 00:16:12 -0700 (PDT)
Received: from nuoska (dc7g6tyyyyyyyyyyyyhlt-3.rev.dnainternet.fi. [2001:14ba:16cb:a800::193])
        by smtp.gmail.com with ESMTPSA id b10-20020ac2410a000000b004fe432108absm4444893lfi.182.2023.10.16.00.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 00:16:11 -0700 (PDT)
Date:   Mon, 16 Oct 2023 10:16:06 +0300
From:   Mikko Rapeli <mikko.rapeli@linaro.org>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Richard Purdie <richard.purdie@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        openembedded-core <openembedded-core@lists.openembedded.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Randy MacLeod <randy.macleod@windriver.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: Kernel 6.5 ttyS1 hang with qemu (was Re: [OE-core] Summary of
 the remaining 6.5 kernel serial issue (and 6.5 summary)
Message-ID: <ZSzjNgdCH_wmB4u2@nuoska>
References: <178BF2895FF685E6.5378@lists.openembedded.org>
 <a2ad67a0575548b6d5d8d187e597dcd72ae07f64.camel@linuxfoundation.org>
 <ZSPQY6UYg21Z0PnN@nuoska>
 <1520ecb5f4b6959af835a7781b94694913f76912.camel@linuxfoundation.org>
 <178DF50519C11C84.8679@lists.openembedded.org>
 <b208c9c6b72be4ef0f2aadb7bed103280bff60a0.camel@linuxfoundation.org>
 <2023101516-unmolded-otter-e3e0@gregkh>
 <214757eca7f4cd639a7a8d9a822476c1ec30f01c.camel@linuxfoundation.org>
 <20231016063501.GL27774@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016063501.GL27774@atomide.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Mon, Oct 16, 2023 at 09:35:01AM +0300, Tony Lindgren wrote:
> * Richard Purdie <richard.purdie@linuxfoundation.org> [231015 21:30]:
> > On Sun, 2023-10-15 at 17:31 +0200, Greg Kroah-Hartman wrote:
> > > Can you try the patch below?  I just sent it to Linus and it's from Tony
> > > to resolve some other pm issues with the serial port code.
> > 
> > Thanks for the pointer to this. I've put it through some testing and
> > had one failure so far so I suspect this isn't enough unfortunately.
> >
> > FWIW I was looping the testing on the complete removal of the
> > conditions and didn't see any failures with that.
> 
> Care to clarify what's the failing test now?
> 
> Is the issue still the second port not always coming up after boot or
> something else?

Yes, data from the ttyS1 getty is not coming through from kernel and qemu to
the test framework looking for login prompt after qemu machine boot.
Workarounds like sending "\n\n" from the test framework through qemu to ttyS1
or "echo helloB > /dev/ttyS1" via working ttyS0 don't seem to help and wake
it up.

Cheers,

-Mikko
