Return-Path: <SRS0=wTQQ=5W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7FEC2BA1E
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 10:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889AA206F8
	for <linux-serial@archiver.kernel.org>; Mon,  6 Apr 2020 10:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIDem+v1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbgDFK5w (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 6 Apr 2020 06:57:52 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44607 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbgDFK5w (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 6 Apr 2020 06:57:52 -0400
Received: by mail-ed1-f66.google.com with SMTP id i16so18611704edy.11;
        Mon, 06 Apr 2020 03:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CMfHof/TA0PWVnfgKpWlGDofI6slg4wF6Ylw4mLnCY0=;
        b=rIDem+v1sd1TXsYWi0U9qUKax2Gli//LKJ0qF/7v13IDLGOXOissSC8j4pEOyb9Gtt
         PIpiIH8V/tt5aUTO2Dz3q9TEl3ecSyyPoUFFx6capL8qnzNm34RxgXcbZURkIIwBXw4G
         BwXAJLO0fEurH4h/04U6DxLSE+QMTquMTemFGdPqb+tRgwAr8pOyrmbfQxPmy3QeM+60
         dTIxh26K9hdrs+U+z6GTtr30+MHlrRQta2rwPwaVLb8ntZd7L2Z/UqNtsioSwifNY9nU
         qi9vku/uCoQxe69DixQA+7tpT9YkAR++5+C7rQXdIEES4ETWrQsURSOz3XNYS82w4jIS
         WqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CMfHof/TA0PWVnfgKpWlGDofI6slg4wF6Ylw4mLnCY0=;
        b=p1hbGPmPiVPhVTHw9U2YodQlyeUsHASdAVStiKmeHKEcY1WnMl0wgtHjeYNC3hx1nz
         LW7KE5Sz3PaksAcxK50bUFQiFWeeeB+MZ5gjF9namYieebJSaeW3lVzHhVDLPD2MeHWT
         409RXVEYYTGds2OC7zr73CFOodGnghLOKaU7w9kYFRitrGwYTQCrk+JEAP3xXs/Psz/z
         BqdiJpGKWPXoG31XWhTncjfu+lrddF/1N41ojBKdiEQhXkyofwOG19AjNDhRLbCJDWEf
         wOTU9vKzlSDtEDT6cZj654DL3qy6aqBBEpyOe7XRhEr6dwYeMzS3pGnklQAXth1ftmzb
         U0rw==
X-Gm-Message-State: AGi0PubjqyHyUu65iSYTtG0sj9gNnEidOb4v6t5DXFjdKWY2TMtwnXhR
        X94A/0jdzWokyGLcOopiTMxlKwE580BgnYBTHMikzg==
X-Google-Smtp-Source: APiQypJmffUJ5UfCO5N0+TfKggr0kFNy8CWsTvRkTTZuGdrPcvcnED6Dr9zqyc0uivDYls8PrpfjQDt5MrZ7ihHSY4I=
X-Received: by 2002:a17:907:1189:: with SMTP id uz9mr8519209ejb.143.1586170670443;
 Mon, 06 Apr 2020 03:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200402172026.79478-1-andriy.shevchenko@linux.intel.com>
 <CADxRZqzgenruphXAKE8MJM2zayR7u7yvc=-5YwPHkCN4gW2eNQ@mail.gmail.com> <20200406105227.GP3676135@smile.fi.intel.com>
In-Reply-To: <20200406105227.GP3676135@smile.fi.intel.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Mon, 6 Apr 2020 13:57:39 +0300
Message-ID: <CADxRZqzVL0jgT-YimqbMn=rAnUnZUDKdWuTjSTOskvO4if+Czw@mail.gmail.com>
Subject: Re: [PATCH v1] serial: sunhv: Initialize lock for non-registered console
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 6, 2020 at 1:52 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> >
> > fixes issue for me, sorry for the late testing
>
> Thank you! Can you formally provide a Tested-by tag?

Andy,

up to you actually to add needed tags. Thanks.

But anyway,

Tested-by: Anatoly Pugachev <matorola@gmail.com>
