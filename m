Return-Path: <SRS0=ZZst=AN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BD0C433E0
	for <linux-serial@archiver.kernel.org>; Thu,  2 Jul 2020 07:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B39B20B1F
	for <linux-serial@archiver.kernel.org>; Thu,  2 Jul 2020 07:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHu1EI3p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgGBH5g (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Jul 2020 03:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbgGBH5g (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Jul 2020 03:57:36 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39442C08C5C1
        for <linux-serial@vger.kernel.org>; Thu,  2 Jul 2020 00:57:36 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id h23so20602944qtr.0
        for <linux-serial@vger.kernel.org>; Thu, 02 Jul 2020 00:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=IbcfzBGXAeh0gGkf8Pi77B8GNneiYPbvAmXfVLNzfnM=;
        b=SHu1EI3pecmIOTnxwMNPW9/VGtR5pG4UukZ4WcXs3ZEB6TpG+4i+JGXWZ4mti0Fbfd
         29MwU3RhE9MExAJ917EnUglCTVyK+GfC2zNBvzE31uJNAQE7VY1uaPk0yhGy4JhKtHLb
         rECCM9tAAw4K4lc0S7YI2u3siYXPm1WT4Vjr6yxFaBlHevxX9tVxLQpcWxgdyer6D5Lx
         zsSsv3uzBdLY3TGIZa79A98NYF/et767DxbRYl2sPYOj0uVPH+iud5KdZP5uBhqzUI8u
         d1GC+HxfZ07UZkhhblFRnnh2eNkjFCYhwJ36IdViU1XEyGqxZHcsJMc45MV+diB8cHOf
         78rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=IbcfzBGXAeh0gGkf8Pi77B8GNneiYPbvAmXfVLNzfnM=;
        b=P6hwpktmLQWbAfw4py9vklICtVg+TREUqiCxqbfyX9R8wGc1WObHX3tfqWEeEAMFDb
         RA+kiikERh7iJSzrClyneF0z0WE+t2W4prMO4oBu+B2+yhV9PMDkhUR4cKOQGOkp3LHw
         khEKRiWdNQwtSuBsXWAZEIjLUAVBI9+RYXsyGW8NpoPNbtI1Tmg0zqgMTp9/88MyV8wQ
         Rp/zN8e/dLdNePZlu85MoHiM+yCOMGKpGPK0PClcucobyF5cqQaiABbwt/cMIL09FZOZ
         5/KBcxVD5PbRpevCJq5l9dLRi8EaxGw3Vv5nKbShjTbAVzBXv9lHpg/AeWWkR31UTepA
         Jl/A==
X-Gm-Message-State: AOAM531+kO03I1HvipSjqRqtcw01Qkv2MTeQfe0Rc+Fefb14I+9Ou8se
        NZr/gIaww57uPvhD0Trd23K1F7ITu2+tlgloz6Q=
X-Google-Smtp-Source: ABdhPJykE4vxR8CUzYgsIXL+4t+1m9ScaoU+CH7I5ZoI9mYqgkbg4Vjq+lgUnGn8BF5BvbSToAEAfwrqhApPNjtNIGE=
X-Received: by 2002:ac8:1ac4:: with SMTP id h4mr31032409qtk.249.1593676654799;
 Thu, 02 Jul 2020 00:57:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAGWcZkJ5LMK59UWPP6zsV3ipgVNbk+mH7tVcmRGsp1PJzxBdTA@mail.gmail.com>
 <CAGWcZk+qZaNN1LOWxWjsBiP+JfSKDvD5+atNHe3LeWgWQhC=gw@mail.gmail.com>
 <20200701132309.GA2362785@kroah.com> <CAGWcZkKChAQwLx16yQ0b6aVx22UrmP_LaK2UjfXBnnZZvLHerQ@mail.gmail.com>
 <20200702072757.GA1052499@kroah.com> <CAGWcZkL0tFJO-A-UV1CugQ9Jpb=P1PJfn8r8d8qzeMcSF1+-1A@mail.gmail.com>
In-Reply-To: <CAGWcZkL0tFJO-A-UV1CugQ9Jpb=P1PJfn8r8d8qzeMcSF1+-1A@mail.gmail.com>
From:   Egmont Koblinger <egmont@gmail.com>
Date:   Thu, 2 Jul 2020 09:56:58 +0200
Message-ID: <CAGWcZkKVoQL7zMWqLr9T-d6JXUe4DeS5332feHotT-k9bxRjtQ@mail.gmail.com>
Subject: Fwd: PROBLEM: tty devices with future timestamps
To:     Greg KH <greg@kroah.com>, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

(Sorry, resending to include the list)

> As for setting it in the
> future, I don't think that's what is happening here,

Let's forget the "knock the lower bits off" part, it's irrelevant.
For the sake of simplicity, let's just pick a timestamp where those
bits are unset to begin with (i.e. a second divisible by 8).

If you set the seconds to the current seconds, but leave the
nanoseconds intact, whatever non-zero value it has, there's a good
chance that this results in a future timestamp (up to almost 1 second
into the future), as demonstrated in the example in my first mail.

In other words:  If you look at the entire, fine-grained timestamp,
you don't knock the lower bits off.  You update the higher bits, knock
the *middle* bits off, and leave the lower bits intact.

> you are just
> comparing two things that can't be compared as they are not the same
> thing.

Could you please elaborate?  (We're not understanding each other, and
I'm not sure in which direction :-))

My expectation is:  If the kernel maintains the concept of "current
time" which (apart from rare special circumstances like settimeofday()
-- we're not talking about those) always grows, and maintains the
"last access timestamp" of files, it shouldn't be possible that the
automatically updated "last access timestamp" is bigger than the
"current time".

Is this a wrong expectation?  Because if so, then I guess I should
follow up with coreutils devs to reconsider how they decide -- based
on comparing these two values: the file's "last access timestamp" and
the "current time" -- which formatting to pick.  If this is what you
referred to by "comparing two things that can't be compared" then what
they do is conceptually wrong.

> as it needs to be fast.

Zeroing out the nanoseconds -- maybe just once, at tty creation -- is
fast, and eliminates the possibility of future timestamps.

(s/milli/nano in my previous mails)


cheers,
egmont
