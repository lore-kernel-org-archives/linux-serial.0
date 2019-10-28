Return-Path: <SRS0=1MuI=YV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C8ECA9EC0
	for <linux-serial@archiver.kernel.org>; Mon, 28 Oct 2019 11:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8536214D9
	for <linux-serial@archiver.kernel.org>; Mon, 28 Oct 2019 11:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="KfHaSXac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfJ1LMt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Oct 2019 07:12:49 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:45517 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ1LMt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Oct 2019 07:12:49 -0400
Received: by mail-vs1-f66.google.com with SMTP id l5so6020020vsh.12
        for <linux-serial@vger.kernel.org>; Mon, 28 Oct 2019 04:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pXXXDBSOOrkSG1cCnPlDU0GSJ4UGZPPonzK4ONIIovA=;
        b=KfHaSXacFFWARCJfQk+aiBmVWzGu+6cYO/ghre+S+UfAa4nmdIJg2ru8dReapGlHcL
         BUULVTxGmAM8m/rgvksHzYVhiQ5RzYAJmXxT0Ppwm54q60myI0gL2M7UhejM4s20ujfI
         3oEifaQC0HVBazwm8Dkzu8Q0PUP2ZUZkRAR2C0QQMm6Vvo/FERjTd0LrWmSJN0QjQx70
         1xLnZwPVp286U2eWxqOx6N7J6aA+GaYlJ2CeS1JAlRPavNApb7ojx2wWOvrab/dP/R1w
         q/VAXaFRtq+MTZIJ/3BuwHGbq5kre0GIjuoQlOqbSmQmUrGLF0/6+PfWqrN9H5reMxeC
         SQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pXXXDBSOOrkSG1cCnPlDU0GSJ4UGZPPonzK4ONIIovA=;
        b=hbBAvPaZJINxZrEPYxyQitk0q1rKRYRUu/gfy0ZTRuHPoJ3c07QPlW5FSL6wx231xv
         XDs0vTfJobuLkLtwey50XYJuWNtV2HbI6EPNMgC9ervIB0DEDEjmvPIqHwHOtpd04NXO
         Se8Jjjaj9gXltaCfBSThKElbNazf3hC0IztApUWLw6aZV0fdaZ+rhYeuRDKTTqTvY03Q
         pCZPkRkcXwGVhOiE7L+WiGe6tQ17JJHWQKEnr1HFgZ9y+5TJ/QSwGyhsrc3+VvHgZFMD
         da5kw4b/o5eiEBrLgjJJnIVlkokjdviAsyqwDKBKKXkjkb4ZF70zc8b5cVZ/wmMzq5C9
         4R2A==
X-Gm-Message-State: APjAAAX6dC7r1f/3Hs2YPF7sokOPVgEu3ELirPC8PjzBR8L4lYiUEmDf
        uBbf72r9wcoEZJGi3JVd3KnrIBZlUQwIpWEt0Zr+3xhC
X-Google-Smtp-Source: APXvYqyDiNUAxc9PFJ4nLpwobhc8l3w4fnxXZw+1bx3+lpFoTDfOBDha8pGkyv7FYsRik7xxipSxsENjAUx00RKrRO8=
X-Received: by 2002:a67:7d54:: with SMTP id y81mr8483469vsc.134.1572261168363;
 Mon, 28 Oct 2019 04:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXMXLRBpQcSq3SrvL4LkG8_7S0CWJFGqRCnjywjbUEPZg9XxQ@mail.gmail.com>
 <CAEXMXLSty8v1K_yaxoAnoMEny=XYn2ngUdCPi_0uTqy5NTViAQ@mail.gmail.com>
 <CAGm1_ksE038XOzqXHw6iSAxq8mCegM8Ej8cdPvP5Tu_EBouSLQ@mail.gmail.com>
 <CAEXMXLSCW33wCho-7damt-aem0Z76xypr-AHY0zmR5T8PwLS7A@mail.gmail.com>
 <CAEXMXLSkNXPYQtzLtnxTzeVAL5MvafsG1yUZHjn8Stg-UZyT=g@mail.gmail.com>
 <CAGm1_ksD6UDdW-3B4KkkoP1QYhp307YMyzf-GPx1Vu1oCFka+A@mail.gmail.com>
 <CAGm1_ksb7tG3xux1yery5qya7UAGYyMBz0xbVgG6pKxaR2Nf3A@mail.gmail.com> <CAEXMXLTJbTRfiASo6Dk=0Lp1iBc4Svv4dw1L+FNi3itoo9e+eQ@mail.gmail.com>
In-Reply-To: <CAEXMXLTJbTRfiASo6Dk=0Lp1iBc4Svv4dw1L+FNi3itoo9e+eQ@mail.gmail.com>
From:   Yegor Yefremov <yegorslists@googlemail.com>
Date:   Mon, 28 Oct 2019 12:12:16 +0100
Message-ID: <CAGm1_ksCumyMWQRAbE8DRoNgO1Y6ScZbaE01hW49_f7s07iu3A@mail.gmail.com>
Subject: Re: Regression since 4a96895f74c9633b51427fd080ab70fa62b65bc4
To:     =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
Cc:     linux-serial@vger.kernel.org, Stefan Roese <sr@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Oct 28, 2019 at 12:11 PM Nuno Gon=C3=A7alves <nunojpg@gmail.com> wr=
ote:
>
> On Mon, Oct 28, 2019 at 12:09 PM Yegor Yefremov
> <yegorslists@googlemail.com> wrote:
> > could you already try at least 5.4-rc4 and test whether the hardware
> > flow control is fixed for am335x and your application?
>
> I did test last week. 5.4-rc4 is working fine for me.

Just curious. What baud rate were you using?

Yegor
