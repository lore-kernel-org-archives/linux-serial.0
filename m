Return-Path: <SRS0=XuIp=X5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4EA7C4360C
	for <linux-serial@archiver.kernel.org>; Fri,  4 Oct 2019 13:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F2620700
	for <linux-serial@archiver.kernel.org>; Fri,  4 Oct 2019 13:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iLvtJf3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388272AbfJDNhq (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Oct 2019 09:37:46 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34662 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388244AbfJDNhq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Oct 2019 09:37:46 -0400
Received: by mail-qt1-f194.google.com with SMTP id 3so8597648qta.1
        for <linux-serial@vger.kernel.org>; Fri, 04 Oct 2019 06:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lIvWUdQ0cj9tj+Tou+UfCDEfn2JcEDJ7RBUviLUzUjI=;
        b=iLvtJf3wEWBqZW2d3gWroy4bSCPeBWLaUgs9TKYfU8hFukvDgZ0rzbntiG5c92h597
         FDDsEXx7gTkZTlng2fmoc5ed4s+6afStthwbnZ4vd3Y1LbiLBnKFBtHDsZ1PEQF2aOM3
         EYekb8zErFFTIzd0/aEUsCUVffqiI3T8C1wT3PVDlRXoXu95XGYW0ut0Yr6Kjc4v68uy
         sR0WQnMguezEg+RAjycgBl5JiWMClYJ1jI+8BoZstnvykuvM9+g0jDp1bmz5DJkovT+i
         TnN/9rVhhqZJn5rwFXkr5PtR1vbwlrm/0xyf6361zyuZvd2PIEuFS4idbVsBI4+vkmor
         IxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lIvWUdQ0cj9tj+Tou+UfCDEfn2JcEDJ7RBUviLUzUjI=;
        b=thEgVFUPElfCzDT/1cpbuSeuCRo/V9ASJzgSWIyadzCx/jJ7tIaRv0RvrVLERtDaW1
         ac6J0U8OEsiBJtlM7RTh7atFxyHKLoCMkgl580Sdvjv8smF8fnnMMeyJ4nDH1K8D//Cn
         KhQ2r8We09fdJGzhC/6U436BdNtWFChpmlh+CZFRe8OTACluRLJ2YPGXCgr5FKN4bWvd
         +ctjpDy0/ntXzvQCbEoUF3vpBEFGbw3BX9B2tr3ijgIFdvlLcDPPlktrxZbVam5lL3Nd
         S+ucB6esmJD6AtI/mZ431aMyABI6Ye7avRn/gA3lO/1Judwco0L20mOv+5i0jh1r/9lq
         boHw==
X-Gm-Message-State: APjAAAVvjHW+WXaX1swUxrJl1Je3X9hILPsI0Wx2SUpdLz+g0sRs+BH9
        67nrY6BiUpjKWdDQ+pz6frY5C19O/jQbMVfcUFPwIA==
X-Google-Smtp-Source: APXvYqzM6JBGiUxO8TTDlYV8tKxg8VU0NlHZyJjCY/untvVfxQW7KEiyPTzVuQngQmy4D0+eRJcmC6/zpYHU1aTv/Cg=
X-Received: by 2002:a0c:acaf:: with SMTP id m44mr14058525qvc.42.1570196264727;
 Fri, 04 Oct 2019 06:37:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191004124505.GA556034@kroah.com> <20191004132001.99027-1-pterjan@google.com>
 <e1b5cbbe-e44a-7119-286f-79c1fec08e1f@physik.fu-berlin.de>
In-Reply-To: <e1b5cbbe-e44a-7119-286f-79c1fec08e1f@physik.fu-berlin.de>
From:   Pascal Terjan <pterjan@google.com>
Date:   Fri, 4 Oct 2019 14:37:28 +0100
Message-ID: <CAANdO=Km1Jbog8v5f2wunzjVpTdHH6ttkZWEw9s7=07PNto4-Q@mail.gmail.com>
Subject: Re: [PATCH] Remove every trace of SERIAL_MAGIC
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

[ Sorry, for previous HTML email, trying to send patches from work
machine for the first time, re-sending in text ]

On Fri, 4 Oct 2019 at 14:29, John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
>
> On 10/4/19 3:20 PM, Pascal Terjan wrote:
> > The only code mentioning it doesn't build (and hasn't at least since git)
> > and doesn't include the header defining it.
> What do you mean, amiserial doesn't build?

The code doesn't build if enabling the "option" SERIAL_PARANOIA_CHECK
in the file, this patch is removing that option and he code protected
by it

> root@elgar:~> grep AMIGA_BUILTIN_SERIAL /boot/config-$(uname -r)
> CONFIG_AMIGA_BUILTIN_SERIAL=y
> root@elgar:~>
>
> root@elgar:~> uname -a
> Linux elgar 5.2.0-2-m68k #1 Debian 5.2.9-2 (2019-08-21) m68k GNU/Linux
> root@elgar:~>
>
> We're using this driver, it works just fine.
>
> And I'm not sure what SERIAL_MAGIC does. Is that for CONFIG_MAGIC_SYSRQ_SERIAL?

It used to be a magic number in the struct to verify you are getting
the expected object

> Because we still use that, too. Although I haven't tested it for a while but
> I'm using the serial console on my Amiga 4000 right now using amiserial.c.
>
