Return-Path: <SRS0=wizI=6A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D276EC2BB55
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 15:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A882A21D91
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 15:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dz6wZBVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgDPPcv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2441560AbgDPPcs (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Apr 2020 11:32:48 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3E9C061A0C
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2020 08:32:48 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id l11so5936979lfc.5
        for <linux-serial@vger.kernel.org>; Thu, 16 Apr 2020 08:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kVMGSQ9IEofGNQ49ai5W+s9ptaxO5th0S2hgeAeM2VY=;
        b=dz6wZBVgzcedFcfued/+z4D86dhxhUgTiKnT4xHY1FoV/tTbSoyJ9QpQZ11k5nAg6G
         Wf9C7hUOYuM8tc6pJCjRykHc2iH1MzGaJQfjFHcQH6N9zMZbo5yKjTAZP+yUj/Ycy8Qn
         zL4vr618fa4u94rqPi2yVbRv+NP81b87GLYoz1vna5+cb2Onha44hY7zrFztihTtlNV9
         Yn6zdQT24SZ+6OcqLoSTdB9qYNFcSjBjRBrU+c653f57MpfW41JKH453OUc+iG3qXDqj
         iUAaLnDATSYqGYc2rjQa/mRjvWSKJnsL6SLsEZxP7jcBcZoVApzv//fuOJcEJemu97md
         7jIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kVMGSQ9IEofGNQ49ai5W+s9ptaxO5th0S2hgeAeM2VY=;
        b=WKl3fW+wqgTphONUKyUuuUqyNAvu+YH6fVw1vY5Wclc7zgDThFGEfNeeQeiHDHQDfD
         X9fuNnylLzwlkCyeAA4gatt9dIcmRO0SdmMx7Sy1bQ/lGIjcI3ICaEutQWOC/sagIxL0
         noOvwx0fan0nDfENiW1Klh4TsxT27Tg3n0xI6/6LlxhZhlQSks5vuMU7SPJoGviNWbIn
         FriihQ6QHAoD+M3k1mV8KbfK91Z4P9qhjsYiWZc8toevmTsAasdCUn0JmD+GdcduyFM+
         R9jg6JUFaMIk/nEjnbcbMjOZ9Do7l4qTfP5pDC05Mvwfcm08Ch4lof+k0fkZwU8lWEqM
         FJWw==
X-Gm-Message-State: AGi0PubpBGmiHZW+1RbXc/KjB92F/9vUvw27/MPBInF6vL9lb/C57rsH
        is8yKbu2cDMvL+wyD3YpzRpxBV47mydFhpPuuKOEq4SB
X-Google-Smtp-Source: APiQypKkLbJwEfq9e7gYOmYV8RcufOS5IOb9mf11c6jWPbsiQIyucBp/5xMPeBJqn3u5aqgedFrS23cbghNpefA1XFU=
X-Received: by 2002:a19:e041:: with SMTP id g1mr6294918lfj.70.1587051166903;
 Thu, 16 Apr 2020 08:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200416151541.18385-1-festevam@gmail.com> <60a8e3864d3dcf3b122a7ea4e71486f2@walle.cc>
In-Reply-To: <60a8e3864d3dcf3b122a7ea4e71486f2@walle.cc>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 16 Apr 2020 12:33:16 -0300
Message-ID: <CAOMZO5DnD-DWXombAqvY_917yDmrBkwRUKA5TWWDsNhBQ=_yCg@mail.gmail.com>
Subject: Re: [PATCH] serial: fsl_lpuart: Change DMA failure messages to debug level
To:     Michael Walle <michael@walle.cc>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 16, 2020 at 12:28 PM Michael Walle <michael@walle.cc> wrote:

> Are you sure, they weren't seen before? Because before the commit there
> were
> the same just in _probe() (as dev_info()).

Good point. Maybe I will just drop the commit reference and Fixes tag then.

I will submit a v2, thanks.
