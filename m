Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C256C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 10:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45FC120801
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 10:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fy0kdcuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgERKEx (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 06:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgERKEx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 06:04:53 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743ACC061A0C
        for <linux-serial@vger.kernel.org>; Mon, 18 May 2020 03:04:53 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id f4so9889071iov.11
        for <linux-serial@vger.kernel.org>; Mon, 18 May 2020 03:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RKROO8T8T/wRvHNAyo40LMuoZm+6bud6XqpTFz5/h4w=;
        b=fy0kdcuoeSucOVpB37b28WEy2Z7BTjSQPoaSXSZqfWX5PynLzWLa06IIOmSb47HQfk
         Nk7Lz8qUhRmZt6Uqw/+gbocUoU6pJc8rWwzPJwyXSzPNmym88rVnFeD71u5olQiXqTch
         i6vC8EcjOjdQRWfG5xjD03JaXffn85wsZgbw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RKROO8T8T/wRvHNAyo40LMuoZm+6bud6XqpTFz5/h4w=;
        b=iGbnpGBNX527UXRRG4RA1TFG3PLWmrFs74qDxhumVeBj97qnugkoqoPfjs8pEtwI2r
         s/NpCXPUQaAERPuyqCc8Lu+R+mAYztjeDT0hkKMqtY/mrk907GOrHcrv8uFSDStjF4G0
         lMB84D0+0WKeByAB3ZxSgb+oWchLsDrgn5YxcVDQIEGpg4zuTkFB5wMZEC16bzC/fG7Q
         MRrS3s2dKUJI358EAqH4v/bpqIlRWfxy0ulGU86Gt5UMwbF1Q7MOHsIB9U6My+oJSsER
         QnUTQKQcvbuSrPKTMUVYRMZwMSnHSJpHaa0+tds9C2t/2KF5ugiZ88zrnEf4a2enX2bm
         foow==
X-Gm-Message-State: AOAM530yz+nDTcPlp5ACYe5sVni45CVa6w2G6hgjzq1zK+KGlMjdQCl0
        uSuI/nciIVu+/OrPnqVLEXeWLeKU9Fs=
X-Google-Smtp-Source: ABdhPJwx36ZBtMkQxH3a1czcOmUKW5lZ0/mMrR8/fHBPau8RLTZtqpZbUmPB9z1ew54D13vgQffLpg==
X-Received: by 2002:a5d:9547:: with SMTP id a7mr13887353ios.6.1589796292550;
        Mon, 18 May 2020 03:04:52 -0700 (PDT)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com. [209.85.166.176])
        by smtp.gmail.com with ESMTPSA id j16sm4659633ild.8.2020.05.18.03.04.51
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2020 03:04:51 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id w18so9197919ilm.13
        for <linux-serial@vger.kernel.org>; Mon, 18 May 2020 03:04:51 -0700 (PDT)
X-Received: by 2002:a92:b001:: with SMTP id x1mr5174498ilh.18.1589796290578;
 Mon, 18 May 2020 03:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200506072314.112409-1-tientzu@chromium.org> <20200506072314.112409-2-tientzu@chromium.org>
 <20200515124621.GB1888557@kroah.com>
In-Reply-To: <20200515124621.GB1888557@kroah.com>
From:   Claire Chang <tientzu@chromium.org>
Date:   Mon, 18 May 2020 18:04:39 +0800
X-Gmail-Original-Message-ID: <CALiNf2_ukL1Ogk3MW5_DSCXHcVxTaE2Rv_JkF+hi7E-8XfrBxw@mail.gmail.com>
Message-ID: <CALiNf2_ukL1Ogk3MW5_DSCXHcVxTaE2Rv_JkF+hi7E-8XfrBxw@mail.gmail.com>
Subject: Re: [PATCH 1/3] serdev: ttyport: add devt for tty port
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     robh@kernel.org, jslaby@suse.com, long.cheng@mediatek.com,
        changqi.hu@mediatek.com, linux-serial@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, May 15, 2020 at 8:46 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 06, 2020 at 03:23:12PM +0800, Claire Chang wrote:
> > serial_match_port() uses devt to match devices. However, when serdev
> > registers a tty port, devt has never been set. This makes
> > device_find_child() always return NULL.
> >
> > Assign devt in serdev_tty_port_register() to fix this.
> >
> > Signed-off-by: Claire Chang <tientzu@chromium.org>
> > ---
> >  drivers/tty/serdev/serdev-ttyport.c | 2 ++
> >  1 file changed, 2 insertions(+)
>
> So is existing code broken because of this?  Or does no one ever call
> device_find_child() on this?  Who needs/uses this?
>
> thanks,
>
> greg k-h

I'm not sure. Our use case is to control the wake on bluetooth
behavior by the power/wakeup node.

`readlink -f /sys/class/bluetooth/hci0`
/sys/devices/platform/soc/11003000.serial/serial0/serial0-0/bluetooth/hci0

and we'd like to use
`/sys/devices/platform/soc/11003000.serial/serial0/power/wakeup` to
decide whether to enable the in-band wakeup on uart host side.

Thanks,
Claire
