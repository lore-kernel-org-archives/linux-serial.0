Return-Path: <SRS0=FKjJ=45=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1274BC10DCE
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 09:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B152071C
	for <linux-serial@archiver.kernel.org>; Thu, 12 Mar 2020 09:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584003788;
	bh=MTh3jM8oqw1W7hCQ3S0NIbmJXFwKR0gPlg51nsUyruY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=s49+P2hSAXKfJoTNK5MrMKyzhJ9rYNZEuY9eimaG6V/wiV/tTIkpJ8AYHG3snkhql
	 SC8l1IT+1RakL2NYoTOCUTp0sKRAgHlhGcs7nXv9baydRPB7J7xy4DvTH5983T9v4X
	 wljpA0Fro7ulh3S+9CM1GioLh1pKqGVI5k1ORKAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgCLJDH (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:03:07 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:48170 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgCLJDH (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Mar 2020 05:03:07 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 02C92t11017789;
        Thu, 12 Mar 2020 18:02:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 02C92t11017789
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1584003776;
        bh=Ze66mSQ/66E2lEFTcWIDioNc3sfhaXsBfI/IJCaQiF8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d5L24OgHRVwFOBGi6xGnPl0Z/D1On+Gu9Feb3LLGmWPc1rSDlcekOKc4JsCChNQ/V
         v+grQoy6PrO5Bj7I+mHMi/vWvtPUbrYvDQXrbPadyg7ecpAODRYk0Kr3X3hlBb02l1
         3LpkvTA8e8c6yEMZ+R5qp6DMvKB8TpGH1/kRYuMyM0sk2f29BB+OL29QvM3wlaIk3G
         PYG5VZ9hsvvUpPHlWbyGebmRGk6JRBIWD6g3Dkjggq8f7TX+b+gVwOTiQ5cqFNtHDU
         U/HYTfGNzCy2/x4StrdYRLR0SAywssKVcQoJHtkUpKoy2++DntLDl1UhHg2EKJpUn6
         wj/r2Ud7jH0IQ==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id i7so1497068uap.0;
        Thu, 12 Mar 2020 02:02:56 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2b1mQztEbIdpLdDAGlK8rrgQIzXPfTJdDw6GWDhl5ppVUyYOMU
        M9nc7JuV/GOoBaOkFfgBvuISGORrF5OnDhG+BqY=
X-Google-Smtp-Source: ADFU+vvFC2wWLLojiSmCVABb2cx04S0no+WUO1vLaarHeweUtZ5Q4oyHvq2r/9Q3efqfrz7YFQ41Invz1cnhlanlbuA=
X-Received: by 2002:ab0:28d8:: with SMTP id g24mr2907292uaq.121.1584003775380;
 Thu, 12 Mar 2020 02:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583896344.git.joe@perches.com> <dae0878058223a42c77d725b8d7c5845a7ef9dc0.1583896348.git.joe@perches.com>
 <CAK7LNAS7GAk9yXkPhbS3ByU+n9Gb-rk0PeLcXLCNwpW1B22aeg@mail.gmail.com>
 <891a42ad8d8fd7beca911845108e1ded022ef3f7.camel@perches.com> <20200312085606.GA154268@kroah.com>
In-Reply-To: <20200312085606.GA154268@kroah.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 12 Mar 2020 18:02:19 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS98yeCeFZpKgNRRKcFhXSKWQ7Ka4vP90YcY=ufScZRCw@mail.gmail.com>
Message-ID: <CAK7LNAS98yeCeFZpKgNRRKcFhXSKWQ7Ka4vP90YcY=ufScZRCw@mail.gmail.com>
Subject: Re: [PATCH -next 005/491] ARM/UNIPHIER ARCHITECTURE: Use fallthrough;
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joe Perches <joe@perches.com>, Jiri Slaby <jslaby@suse.com>,
        linux-serial@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Mar 12, 2020 at 5:56 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 11, 2020 at 07:31:07AM -0700, Joe Perches wrote:
> > On Wed, 2020-03-11 at 14:15 +0900, Masahiro Yamada wrote:
> > > On Wed, Mar 11, 2020 at 2:07 PM Joe Perches <joe@perches.com> wrote:
> > > > Convert the various uses of fallthrough comments to fallthrough;
> > > >
> > > > Done via script
> > > > Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
> > > >
> > > > Signed-off-by: Joe Perches <joe@perches.com>
> > >
> > > Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > >
> > >
> > > But, I think the patch subject should be prefixed:
> > > "serial: 8250_uniphier:"
> >
> > Yeah thanks, that's difficult to script though.
> >
> >
>
> Kernel development is hard :)


It is strange to process this per-platform
and to send out a giant series that
consists of 491 patches.

This is very trivial conversion.

I think it is better to have a single patch
to convert all files under drivers/tty/serial/,
with the patch subject "serial:".



-- 
Best Regards
Masahiro Yamada
