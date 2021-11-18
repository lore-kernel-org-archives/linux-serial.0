Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB85C433FE
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 09:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B376961B3A
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 09:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245307AbhKRJ4c (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 04:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245348AbhKRJzo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 04:55:44 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F8BC061570;
        Thu, 18 Nov 2021 01:52:44 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g14so24377512edb.8;
        Thu, 18 Nov 2021 01:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7DecnYT2s+hYqidekxZh3rO2VTwJwsmLGjxxQVTuTBQ=;
        b=pVuNtLd/pkm+gqVZ5M9iFYP//8CIp+aFuodRKg38Dk+YXunOgxRncM9UO/7HpOFbsb
         cZ7v9/fWxTbfjhur+YDrLeryd3MaYpWxVgWAA52O8q8Wmb5qPNTtXL7s6RNfWgTfRFa/
         kePQ5hLXqHMKGf/U8GAXkaEZaIGYylgN9B7ltnU4ktnwpCcUed2xC2O7EnWI+kU1GcTd
         Z5BO3Qw4vBpx6WhDY2w/dpS7a4M+0C/FUwsgykyxCIXjbhYoGi5OxfO5hh0nfOOhL23L
         7O/s4PX349fjVQWK1CW56ufI+m5QzK1b0Hn5N1WcJUSzGjoOBXrExmv++X0fupscCpVI
         F8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7DecnYT2s+hYqidekxZh3rO2VTwJwsmLGjxxQVTuTBQ=;
        b=KYmAUl8di8h5cCv5zS7KmVCU2LgPXqzibUFOtkQowK7zeGOgeENEZD0iJfStaLXgWm
         yPZ9txuRom2mCshQnYQpfxgrXYRrs6kb+KIWxCU7rpfAlwj0gBqsxPYlLGFLcK6lxRSg
         kiBNfFenee7sDB6jge/mVwDuzc32iZwClbXDsyMoA24Fx5l1ASSgI/cdfZVY/xxbFU72
         7cPuE35KuHKUuUuFhuITFwu0/VKRLhWvxenSG0AxA3J09P1yAuDjFPk3rGqlVoQLHWuQ
         JfpujI1Wkpy4ax/yFmWNXYzjqCND63AIrD3zhcvq1LhGregr2/hAzPjkxnfGDrIQGgTH
         NgOQ==
X-Gm-Message-State: AOAM533PzM/j+8WgtM8HFqzBh52FDfNCO6x4z5EjKUyPqiAP28I84hyW
        /yMxq0UnvNB2Mtms0hrjepn1P1yAXLNvP99AFfY=
X-Google-Smtp-Source: ABdhPJw0Ra9YcrMdl8PH3pxd+z/pgW+bgg+AGqCt7wjsxm5nTu6nCaGOfKdjvewUqhRkdWvLezKOpYMTbzdXh5SuImU=
X-Received: by 2002:a17:906:bccc:: with SMTP id lw12mr30503265ejb.128.1637229162874;
 Thu, 18 Nov 2021 01:52:42 -0800 (PST)
MIME-Version: 1.0
References: <20211117145502.43645-1-andriy.shevchenko@linux.intel.com> <89c2f319-b0b9-3c64-e9f8-6c4081cdcce4@accesio.com>
In-Reply-To: <89c2f319-b0b9-3c64-e9f8-6c4081cdcce4@accesio.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 Nov 2021 11:52:06 +0200
Message-ID: <CAHp75VcboxaNnSnt1wKvE9JefSsLtMReZkMDVEpUVOJnd_oQnA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] serial: 8250_pci patches to address issues with pericom_do_set_divisor()
To:     Jay Dolan <jay.dolan@accesio.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Nov 18, 2021 at 8:09 AM Jay Dolan <jay.dolan@accesio.com> wrote:
> On 11/17/21 6:55 AM, Andy Shevchenko wrote:
> > A series patches to address three issues one customer managed to hit
> > all at once.
> >
> > 1) Fourth port not being setup correctly on some Pericom chips. Fix
> > the entries in pci_serial_quirks array.
> >
> > 2) Rewrite pericom_do_set_divisor() to always calc divisor and to use
> > the uartclk instead of a hard coded value. Always calculate divisor
> > without passing control to serial8250_do_set_divisor().
> >
> > Jay, can you retest this, please?
> I was able to verify that the fourth port was placed at the fixed
> address for the card that previously had it at the wrong offset.
> I was also able to verify all of the standard baud rates for 24 and
> 14.7456 MHz crystals from 50 to their respective uartclk speed on the
> oscilloscope.

Thanks!

-- 
With Best Regards,
Andy Shevchenko
