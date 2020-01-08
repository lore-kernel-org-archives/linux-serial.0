Return-Path: <SRS0=qFi8=25=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C776C33CA2
	for <linux-serial@archiver.kernel.org>; Wed,  8 Jan 2020 12:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BBD20705
	for <linux-serial@archiver.kernel.org>; Wed,  8 Jan 2020 12:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geblw+pi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgAHMiV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Jan 2020 07:38:21 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44095 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgAHMiV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Jan 2020 07:38:21 -0500
Received: by mail-ed1-f66.google.com with SMTP id bx28so2394182edb.11
        for <linux-serial@vger.kernel.org>; Wed, 08 Jan 2020 04:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Mu/9rzDEV/3xchrQfdwK1gHY0WvFoFkLnnDK28soeI=;
        b=geblw+pi0bvr3Byn/YiGi0bDQkzT/xZe8kWQMwv0A2WTLr3XmcSUWBgr3aMeNEIFzF
         I4FfviJrEcOeCtlfUb8vJfhmKR5vV619dhRD5/r7lngvIwjE0CarnYIW3pbQC2Urfojy
         oowvIIvT9LNsEY1JV6woVymq20kbiyWbN7DEN/hWYz+X7GqynyU2HASQVzcmoYLu07hk
         Y0oZfgdUYVfJal8SWvZJpRK5z8EiT6Jix2RgpRGZfRVHMmbqetR/wfg1+OqQzjn2REWa
         ntJcuUb3aHY8KI8PFu7ehqvlkeu66vWVDEB5acXOQL597CrpbitDO5bg0f5AAcDaEeiC
         terQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Mu/9rzDEV/3xchrQfdwK1gHY0WvFoFkLnnDK28soeI=;
        b=IiQRPzMHyWrjntd+2NKyqh/YBc4/Oq23LhkCUyP7/EAom5HT+0l3EsmPbn645I1VcM
         R72J4irHBA9zSGmPUc8SvCpPlHhjxziCxAAZjTuJzYe2jwZgPFb/WCJGM6g6JAfPspGt
         paSG7s9Mfx1ZO2pKQU8XiC0tYjdw4h1TIRvWVpH3SV041oPDX/6OcHj+1oqH5iiAji3l
         jn7Tecm/1TmmTkqh1X3/7RXW3z8Hna6C3elxao/JDeSQtInxrHBuBAa/WCLWK0mSz1Ty
         p+6cVCWLZuMEyAdzWiaxh8rGH/LqQdmKj/lKXezWl7ewWEQs4eRAZsBB0RpunjVH9M/O
         oDnA==
X-Gm-Message-State: APjAAAVRkhcp3Do7FcJ3TzCBS94zT2rdS27Qw1MbzhxvFNWoSq05iZdq
        9EmLjUcf7cD1TGJ3OfOniW6H61U1J4Ds7jlc8XFSeH8I
X-Google-Smtp-Source: APXvYqxbMkeDWxAWYjd7TMyHmNu+6lLHyF46fr/kC+hvoFjIqKwJy+6VeEOaXhe+kjmUHlb2gvR3v3/pHjbzGvFC54c=
X-Received: by 2002:a17:906:a44d:: with SMTP id cb13mr4772079ejb.258.1578487099681;
 Wed, 08 Jan 2020 04:38:19 -0800 (PST)
MIME-Version: 1.0
References: <CAAfyv37N4OSLtcLRGRRPUg2av6AAqCSu5snR1qv9e=wA74vX1w@mail.gmail.com>
 <20200108122506.GA2365594@kroah.com>
In-Reply-To: <20200108122506.GA2365594@kroah.com>
From:   Belisko Marek <marek.belisko@gmail.com>
Date:   Wed, 8 Jan 2020 13:38:08 +0100
Message-ID: <CAAfyv35wRyoZMjep=DPOGNk_gX-GxoKknmU1Gu97dUvcUaAEgw@mail.gmail.com>
Subject: Re: 4.12 mainline crash in n_tty_receive_buf_common when using g_serial
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,

On Wed, Jan 8, 2020 at 1:25 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 08, 2020 at 12:49:52PM +0100, Belisko Marek wrote:
> > Hi,
> >
> > we're using mainline 4.12 kernel (bit too old I know) on am335x board.
>
> That's _MUCH_ too old and obsolete and broken, there's nothing the
> community can do about this, sorry.  Please update to a modern kernel
> version, like 5.4, and we will be glad to help.
Yes I know it's old but it's behaving fine just hit this issue
recently. Will take a look if we can bump to something latest.
>
> If you are stuck at 4.12 due to a SoC vendor issue, please contact that
> vendor for support as you are already paying for it from them.
No it' no vendor kernel it's really mainline (from yocto build).
>
> good luck!
>
> greg k-h

Thanks and BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
