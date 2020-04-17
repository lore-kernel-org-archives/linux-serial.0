Return-Path: <SRS0=oPkf=6B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72E9C352BE
	for <linux-serial@archiver.kernel.org>; Fri, 17 Apr 2020 05:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF084221E9
	for <linux-serial@archiver.kernel.org>; Fri, 17 Apr 2020 05:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vFUkBxR5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgDQFOr (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Apr 2020 01:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgDQFOr (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Apr 2020 01:14:47 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B75C061A0C;
        Thu, 16 Apr 2020 22:14:46 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w24so1006650qts.11;
        Thu, 16 Apr 2020 22:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5imWM9PoUe4cCDhSNWS0fi5ZUgYX+BEu4b7csjsffI8=;
        b=vFUkBxR5NlxOV5IXDdLmtqx87H2oMA2w3wcEN59Rqfc06684oOpJtSlsa+NofreCbF
         OAwE6Q1ZAnO3GVV5wTwI5Y6E93CLK6XkywEVRbEE/++JxMwhyFFmLfo3INTXqPo/xRn/
         94IGlkS3zGC55fZtxbMop1+hIbCzaxjlXih+ra83OIWP8D5YEFGBN8EyfbHyJiqQh5Ah
         fcjd/AtZ4GH+hTzb1QUev0X6uaOd+iM3WSaLGm/0CTrvUzaje7HeW2+brY6b78nB46wg
         JjdltRKPPA3pA0OEOz6De6UnODpPK5S3fQCDIkCn6JRHTDiQOlJGd3NMc9dxOKYPMQ+u
         ta9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5imWM9PoUe4cCDhSNWS0fi5ZUgYX+BEu4b7csjsffI8=;
        b=FNLGnfMqXfjHAH81xLzxSQf/yf6vD5bcBLilnjEeXDFu419VVefpL7weF5tbx1jDxg
         n+kA0VQ/PwbcqxDQzCGd2bj3HVJo4qTXep05B6rN3e6VQND9dmO2A5lXPd8bPXC12QQq
         8aG3GuS/1T1ZVl+Eq8jskAQapGZLg2e6bdfPQblbnBITqoVf3w991AwM0Qn3elORaZJn
         KXksoK9MpDbg81G1xVDEOpE7nSEIjh7LljZVSoDp5kFKoLymwSPZYW6mKCxy8ldvU+r8
         gY9g8a8FlLUV1GVVGmuXaKz6X6H1bnNrlhJC0yQWae3XR5V3d7f5Jka3iAzyqnFD+7bg
         JWVw==
X-Gm-Message-State: AGi0PuZXFtBAEZJnYCAyDQvoL0yxBW7MIGZyTVNSD2G14cQR+9cdJm/a
        47OETp46VhqR6iR/eLSsMIkrWDPjs+iYcyi/BP7cJhEA
X-Google-Smtp-Source: APiQypKiXsh891oZUSO2SmIKvGzEThVHpuLi5ba2n9Mea29s5pn1nJGPyHRhkcNPWl3+TX7/+WBgUD6P+3RfOUgyryg=
X-Received: by 2002:aed:20e3:: with SMTP id 90mr1267488qtb.142.1587100485803;
 Thu, 16 Apr 2020 22:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <1587012974-21219-1-git-send-email-gupt21@gmail.com> <CAL_JsqLWMTpHG=bOmWgy1kg6d7vxRGbCda+febq=FnqbuRbPyQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLWMTpHG=bOmWgy1kg6d7vxRGbCda+febq=FnqbuRbPyQ@mail.gmail.com>
From:   rishi gupta <gupt21@gmail.com>
Date:   Fri, 17 Apr 2020 10:44:34 +0530
Message-ID: <CALUj-gsuUFQbRLKX=nTbA+y6oTyEAnX7OaxkAX375rBBgNc44g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: ttyvs: document serial null modem
 driver bindings
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Initially there was no DT support but later it was added as CONFIGFS
is optional.

DT is giving flexibility to use the driver.

On Fri, Apr 17, 2020 at 2:08 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Apr 15, 2020 at 11:56 PM Rishi Gupta <gupt21@gmail.com> wrote:
> >
> > The ttyvs driver creates virtual tty devices. These devices can
> > also be created through device tree. This commit document this.
>
> Device tree is for real h/w devices. You have a configfs interface to
> set these up. I don't think we need both.
>
> Rob
