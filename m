Return-Path: <SRS0=IUNt=CT=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09492C43461
	for <linux-serial@archiver.kernel.org>; Thu, 10 Sep 2020 05:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC561208A9
	for <linux-serial@archiver.kernel.org>; Thu, 10 Sep 2020 05:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/v1zrYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgIJF5k (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Sep 2020 01:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgIJF4c (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Sep 2020 01:56:32 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D776C061573;
        Wed,  9 Sep 2020 22:56:32 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id x2so4633249ilm.0;
        Wed, 09 Sep 2020 22:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WtWg76231xpg3A+iPIghdBKCt3SdBEICQRv0buy/6kY=;
        b=Z/v1zrYtfWP1VHMGT1kjaG7mjED+jmhQGwd9LfJP8+xJyLxJkyTacUkwoacozPfzx2
         fl9oPeyuq72q0N4xV5sc+yb1XSf3d9hO8g262ln1VxPiqybXw/hXg7M1VVREElbUsf9d
         uC3/HnXnJWzX030lF1r/GFF6ZbLerZvQqWN6bqDJq4Trp3e57BFMgobSI0M2KhzY2YCQ
         09ILeNsEVZx2chXBBdrFrovyrqr44Ap/bTSXbNhWq4QP8tlZ2BWXcYSkMJpIdHUipLsG
         X1keFuCN56yvNLd44hni+ozWWpGD8s2mmdI/h7JxOpBahrmIQkZyJWI67hEFn6Z6UmIg
         7zHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WtWg76231xpg3A+iPIghdBKCt3SdBEICQRv0buy/6kY=;
        b=YpOwruEKCZVU36ecfoqMJN/7XyIdSusgsAYqsyNEgD6BOOtLEM4zquAGhzCdlyJNEr
         7NTAcK6lG7WUvW6u+jvVEylpDfImd88QvwcNIYGJBjdFtNRRK9IfqGOuUSZwm7l1NBks
         qVi+0Jyc6shEau4Ek5DSXPiXcwHZGmJQN8NuT++MsCJeq4XsTGfY7uQoa3opry3dyH/Q
         tx6d9499KALmJ4pNsEjaJR+p2SDpQ3R5Y9eU2hkQ6Wj1DlEYCt7gDAwmUL2OWTle+kOi
         vlZU0185WB16aa3/jN6w6TeqfUnvAProRP9Btd9Uhr8L4mkpSFqFOrZ5kszWfs3/mrla
         3HMg==
X-Gm-Message-State: AOAM530oonTFmtPX7aFm7AgXf9xQRZ6DQ1ieUCPr+dB202C4bpDbahx/
        1RbZyH6veTlUyJDYyBEn91PMamTB/QgVTDKfzA8=
X-Google-Smtp-Source: ABdhPJx4Bmu418Jkz4gBug2aAwPLeL2apYOulOzOjZ7I/cA67pseYj1yFFBRx2kSVXtUsdTl67PxA8X/cyb/fP4Rh+g=
X-Received: by 2002:a92:c7b0:: with SMTP id f16mr5024764ilk.137.1599717391127;
 Wed, 09 Sep 2020 22:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <1554181578-13362-1-git-send-email-shubhrajyoti.datta@gmail.com>
 <1554181578-13362-2-git-send-email-shubhrajyoti.datta@gmail.com> <5ca841e5.1c69fb81.87c5.289f@mx.google.com>
In-Reply-To: <5ca841e5.1c69fb81.87c5.289f@mx.google.com>
From:   Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date:   Thu, 10 Sep 2020 11:26:19 +0530
Message-ID: <CAKfKVtGXQCj9KLkVuurJfQzRmRYBUkASGc9Jq9r+tXqh5y3d_g@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] dt-bindings: xilinx-uartps: Add support for noctsrts
To:     Rob Herring <robh@kernel.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jslaby@suse.com, linux-serial@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Rob,
Thanks for the review.

On Sat, Apr 6, 2019 at 11:36 AM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Apr 02, 2019 at 10:36:17AM +0530, shubhrajyoti.datta@gmail.com wrote:
> > From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> >
> > Vivado has a configurationo for selecting the flow control.
>
> Vivado is ?
>
> > Add a dt binding to check for the same.
> >
> > Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> > ---
> >  Documentation/devicetree/bindings/serial/cdns,uart.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.txt b/Documentation/devicetree/bindings/serial/cdns,uart.txt
> > index 227bb77..5161a05 100644
> > --- a/Documentation/devicetree/bindings/serial/cdns,uart.txt
> > +++ b/Documentation/devicetree/bindings/serial/cdns,uart.txt
> > @@ -12,6 +12,10 @@ Required properties:
> >    See ../clocks/clock-bindings.txt for details.
> >
> >
> > +Optional properties:
> > +- xlnx,nortscts: The presence of this property indicates that the
> > +    UART does not support modem lines for RTS/CTS hardware flow control.
>
> We already have 'uart-has-rtscts'. Please use that. Maybe you need a new
> compatible as I'd guess current users assume RTS/CTS is present.
>
Current behavior is it is with 'uart-has-rtscts . However to keep
backward compatibility.
I added nortscts .

Let me know if we can tackle that or can we change the default behavior?
> > +
> >  Example:
> >       uart@e0000000 {
> >               compatible = "cdns,uart-r1p8";
> > --
> > 2.1.1
> >
>
