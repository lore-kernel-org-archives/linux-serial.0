Return-Path: <SRS0=+uUE=36=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC97BC3B186
	for <linux-serial@archiver.kernel.org>; Mon, 10 Feb 2020 20:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAC820838
	for <linux-serial@archiver.kernel.org>; Mon, 10 Feb 2020 20:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581368257;
	bh=8EBwQnnayyWkzJqyeB1opWjOW6s4LsL74lZDs1gbMSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iKbT/+zVKA5pTs01Q0RwQCV0IDD6j342icgFQnbT+QA0GVPC24uSGZ6UXhnm5mUX7
	 t7o6wRXEdtPUxV65JVsR4ZzQNatT4VaxrwXm0PNy48Kq0yAUijEvxz0U7rMQuL2x2i
	 I1/Gay5t7XSBA2lZ9HnaulvgUObGI1hSaAsgciFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgBJU5h (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 Feb 2020 15:57:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:45344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgBJU5h (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Feb 2020 15:57:37 -0500
Received: from localhost (unknown [104.132.1.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5876F20715;
        Mon, 10 Feb 2020 20:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581368256;
        bh=8EBwQnnayyWkzJqyeB1opWjOW6s4LsL74lZDs1gbMSk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q+K0NWEc4WuLeQcS12L0g8smg3uR2/TjI/YFp1Goe4vKDAJgrAzjLT/h3XcCvlZnH
         mbcYT3lfOd/3IEsiQEAh6LfffzHPnpV1q7PKrsbILzrceiMjbxZP3jKZ7sdufCi6T2
         mJVPiefKlgOQfMtx7phL4DPLoUxUwZy6OvoIL7Mw=
Date:   Mon, 10 Feb 2020 12:57:35 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        "George G . Davis" <george_davis@mentor.com>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Jiada Wang <jiada_wang@mentor.com>,
        Yuichi Kusakabe <yuichi.kusakabe@denso-ten.com>,
        Yasushi Asano <yasano@jp.adit-jv.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>,
        Fukui Yohhei <yohhei.fukui@denso-ten.com>,
        Torii Kenichi <torii.ken1@jp.fujitsu.com>,
        Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] serial: sh-sci: Support custom speed setting
Message-ID: <20200210205735.GB1347752@kroah.com>
References: <20200129161955.30562-1-erosca@de.adit-jv.com>
 <CAMuHMdWV0kkKq6sKOHsdz+FFGNHphzq_q7rvmYAL=U4fH2H3wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWV0kkKq6sKOHsdz+FFGNHphzq_q7rvmYAL=U4fH2H3wQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jan 30, 2020 at 01:32:50PM +0100, Geert Uytterhoeven wrote:
> Hi Eugeniu,
> 
> On Wed, Jan 29, 2020 at 5:20 PM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
> > From: Torii Kenichi <torii.ken1@jp.fujitsu.com>
> >
> > This patch is necessary to use BT module and XM module with DENSO TEN
> > development board.
> >
> > This patch supports ASYNC_SPD_CUST flag by ioctl(TIOCSSERIAL), enables
> > custom speed setting with setserial(1).
> >
> > The custom speed is calculated from uartclk and custom_divisor.
> > If custom_divisor is zero, custom speed setting is invalid.
> >
> > Signed-off-by: Torii Kenichi <torii.ken1@jp.fujitsu.com>
> > [erosca: rebase against v5.5]
> > Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> 
> Thanks for your patch!
> 
> While this seems to work fine[*], I have a few comments/questions:
>   1. This feature seems to be deprecated:
> 
>          sh-sci e6e68000.serial: setserial sets custom speed on
> ttySC1. This is deprecated.
> 
>   2. As the wanted speed is specified as a divider, the resulting speed
>      may be off, cfr. the example for 57600 below.
>      Note that the SCIF device has multiple clock inputs, and can do
>      57600 perfectly if the right crystal has been fitted.
> 
>  3. What to do with "[PATCH/RFC] serial: sh-sci: Update uartclk based
>      on selected clock" (https://patchwork.kernel.org/patch/11103703/)?
>      Combined with this, things become pretty complicated and
>      unpredictable, as uartclk now always reflect the frequency of the
>      last used base clock, which was the optimal one for the previously
>      used speed....
> 
> I think it would be easier if we just had an API to specify a raw speed.
> Perhaps that already exists?

Yes, see:
	http://www.panix.com/~grante/arbitrary-baud.c

