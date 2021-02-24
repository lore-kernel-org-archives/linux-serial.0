Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4ADC433DB
	for <linux-serial@archiver.kernel.org>; Wed, 24 Feb 2021 07:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E5064ED3
	for <linux-serial@archiver.kernel.org>; Wed, 24 Feb 2021 07:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhBXHgA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Feb 2021 02:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbhBXHff (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Feb 2021 02:35:35 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BFFC061574;
        Tue, 23 Feb 2021 23:34:55 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id c10so910332ilo.8;
        Tue, 23 Feb 2021 23:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PmXp0hCJjxr+GbIpkblU7x66szvTmFkmNMuldYojcdk=;
        b=G2T5kekjhIrkyj6YcR8ZhQLfFiapMvHkrYw1yC42mKYe+vgTxn3W2WVheWVAI4vWk2
         T+e2hBT06jjnzFmcx3G5cUjB9arL9c7ciThohH+0UCSRgxo9QUirVTuLr8vcwSl/R949
         8vn188c83AfMrSL/MT0O/I66Lmvi88gdkp4GfqsGfzZBNRD8iXRbKJHTnub66YqZnYy7
         3TqYrp/jBb0AYv160UNChlvUfIHgSrk9TqJWHS7C+G20okZGnNL7Ua7XAwRdKcUP9Wx6
         BaXOGp/adphrL8OS7TX1jjsOMLzy46wgoLYMBVV3nK3GJ+05KVqSzlhHFg6BtSVOxsyI
         fDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PmXp0hCJjxr+GbIpkblU7x66szvTmFkmNMuldYojcdk=;
        b=MO5EtMYaKHmM872kQNo49UJip+04d7VzbJPNm3fXPNmKrTC08hMTa9Wx08DdVznWP6
         VSTBDDPkLoJW+8GVNgculhQByDM9stLA639baRJLKOKnG8qeWHyYf12/1JcYIEvekQcO
         5w1IQ4QhHFjZlajEOlBtPFy96f2/D5/nB4FmkdgH/Jk6bRiRorUTBQnLbHOjZK2ZiulU
         Y6UponB/gkfDQVwAQIMoG52o/Olv+71UechS5Dlzo2fyLc9SibCwFjLZZuVYw2qWaGVT
         LFZjdwemh5JrusCM94ydxHRRV19OoEV+xrGAPXHvjtwzTp4UWjYYQqDlID4WFG9XR4+6
         1vng==
X-Gm-Message-State: AOAM530UP8z9bTz2eH7pDtj8OScjM/5/SAkx/bCgiEzPqlDUCbprXJdh
        /nhYriPEvWCJhr0jaBfayR4Ivptfbneg3Lpnb0c=
X-Google-Smtp-Source: ABdhPJxgvvLwYE2z5ygYN516JxKOuJbilOtcZ1+GMjfYyXr92Gxsc6pxA+t3p7mHxUscWceFC4y4RxgFFOAr9WmqHEA=
X-Received: by 2002:a92:cda6:: with SMTP id g6mr23381816ild.274.1614152094608;
 Tue, 23 Feb 2021 23:34:54 -0800 (PST)
MIME-Version: 1.0
References: <YDOvLseYXaUHs0lS@hovoldconsulting.com> <fb1489c2-b972-619b-b7ce-4ae8e1d2cc0f@IEEE.org>
 <YDPO/JprcDTaPmR4@hovoldconsulting.com> <0f9caf26-af58-13a9-9947-47bb646f505e@IEEE.org>
 <YDPS3AP63/PwmwJU@hovoldconsulting.com> <780b9aa6-890d-47fd-d6b2-cd9a39f7634a@IEEE.org>
 <YDUiuLtwRkZ0D0Mi@hovoldconsulting.com> <f63df659-6cdf-bba6-f892-1012b98f82e2@IEEE.org>
 <YDUp0tIThOZSTHJt@hovoldconsulting.com> <93584ae4-665e-1e67-01e0-cc53f987bee4@IEEE.org>
 <YDUysZY90FfVhrHK@hovoldconsulting.com>
In-Reply-To: <YDUysZY90FfVhrHK@hovoldconsulting.com>
From:   Charles Yeh <charlesyeh522@gmail.com>
Date:   Wed, 24 Feb 2021 15:34:43 +0800
Message-ID: <CAAZvQQ6F=cQ-EhC0kgeTVM3GrtBWR+HfM6UJWj2AEF1NYZ-vAQ@mail.gmail.com>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
To:     Johan Hovold <johan@kernel.org>
Cc:     "Michael G. Katzmann" <michaelk@ieee.org>,
        =?UTF-8?B?WWVoLkNoYXJsZXMgW+iRieamrumRq10=?= 
        <charles-yeh@prolific.com.tw>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Joe Abbott <jabbott@rollanet.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

PL2303HXD
          =3D=3D=3D>Device Descriptor<=3D=3D=3D
bLength:                           0x12
bDescriptorType:                   0x01
bcdUSB:                          0x0110
bDeviceClass:                      0x00  -> This is an Interface Class
Defined Device
bDeviceSubClass:                   0x00
bDeviceProtocol:                   0x00
bMaxPacketSize0:                   0x40 =3D (64) Bytes
idVendor:                        0x067B =3D Prolific Technology, Inc.
idProduct:                       0x2303
bcdDevice:                       0x0400



PL2303TA
          =3D=3D=3D>Device Descriptor<=3D=3D=3D
bLength:                           0x12
bDescriptorType:                   0x01
bcdUSB:                          0x0200
bDeviceClass:                      0x00  -> This is an Interface Class
Defined Device
bDeviceSubClass:                   0x00
bDeviceProtocol:                   0x00
bMaxPacketSize0:                   0x40 =3D (64) Bytes
idVendor:                        0x067B =3D Prolific Technology, Inc.
idProduct:                       0x2303
bcdDevice:                       0x0300


PL2303HX(A)/XA ( EOL : PHASED OUT SINCE 2012 )
          =3D=3D=3D>Device Descriptor<=3D=3D=3D
bLength:                           0x12
bDescriptorType:                   0x01
bcdUSB:                          0x0110
bDeviceClass:                      0x00  -> This is an Interface Class
Defined Device
bDeviceSubClass:                   0x00
bDeviceProtocol:                   0x00
bMaxPacketSize0:                   0x40 =3D (64) Bytes
idVendor:                        0x067B =3D Prolific Technology, Inc.
idProduct:                       0x2303
bcdDevice:                       0x0300


You can use the two fields bcdUSB & bcdDevice to distinguish PL2303HXD
/ PL2303TA / PL2303HX(A)/XA

Johan Hovold <johan@kernel.org> =E6=96=BC 2021=E5=B9=B42=E6=9C=8824=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8812:51=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Feb 23, 2021 at 11:30:41AM -0500, Michael G. Katzmann wrote:
> > On 2/23/21 11:14 AM, Johan Hovold wrote:
> > > I only have an HXD (and a GC) here.
> > >
> > > The HXD has bcdUSB as 1.10 unlike your TA with 2.00, but not sure tha=
t
> > > helps.
> >
> > Sound promising .. why do you think this is this not reliable?
>
> Perhaps it is. Perhaps even bcdDevice of 3.00 is enough (includes some
> older variants that the TA replaced supposedly). Not sure anyone ever
> tried the current scheme on those older models.
>
> Charles, could you post the output of "lsusb -v" for your PL2303TA? And
> did you verify that you actually got 110 Bd with the current Linux
> driver?
>
> Johan
