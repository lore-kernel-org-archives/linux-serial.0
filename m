Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C46FC433E6
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 09:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D950D65005
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 09:33:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhCEJdH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhCEJcf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Mar 2021 04:32:35 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CB4C061574;
        Fri,  5 Mar 2021 01:32:35 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id f20so1271659ioo.10;
        Fri, 05 Mar 2021 01:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Jw0JfBHB7mCavf0o1VSw42/OmHMIkBLhJKIKaZgO2sY=;
        b=CEXliW8d9PXq9LU4kq6kWjGFQt4JTn0towAV0HBSPjci5aGZ6yckckUpXTTUCx/egW
         t8UueiEaZYYTYZKUq9O6i8GCzHHCPXY/zD6XJs6t1CJAyzOSb6xSWADbuAjfhKc42IX5
         jc7yP5Iinl+g3AsSM4QGValjGNSk3d/XsVufRvwbU2Q1kZz/LfQL4EuvUUz8KwtzyqI4
         r3GBxHMD1Ax1g/i3m3hMbnvjpnpgbj872SZ3oiX4RdrizPQvB1ybbIGzE4OWDCtsTZS0
         ZuIk06KZxo7p1EGBXVkm+uYpaStctimdONIvz/qR6MgjFMvAGskQOShvC7TbspsGjx5h
         s7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Jw0JfBHB7mCavf0o1VSw42/OmHMIkBLhJKIKaZgO2sY=;
        b=X2uK8mjqcZC5xsVFF9Ctq7FA89AdBqrMT5DYxtOnry1nY4vjvmxgidxcPF2xiizxlh
         GXrhMkHv8c1JIEH4tIgYMgco9nK0JjFZ5OnDN/YQamIR9PvgOjbFepj0Jx+FkT4AOOit
         VMzFJ/Oti8hXTmmSlWKQnG3Dsz8h16BWPgdnI2n9YHgtfqRwrmgxOIok8Elt2ZoBL0pV
         4bOmfcUf+3Tg0Larjh2Wo4M1+EGiWUEohDPEk4K5R30TWLb5WFfUpEyjpcVOPaceXnrC
         KESGHNx3dimmxPqgb7KV3UMal+OrBVNUrldyVpaYl1bEf0L14i5QeR/9ggBJzv/Jr8zu
         fhKg==
X-Gm-Message-State: AOAM531q0zAInD64IPXqs1GvbA+BRPipZ1RYeA0D/TIBziIyMMg+cdHq
        07qZZBSe/lG3r0t7fDEIIuljO7S4Q3OADJMRzzkf7Sv6O/JHqA==
X-Google-Smtp-Source: ABdhPJyvqlEyXuCteyoxkDh20LSr7aDK6V25HlwavDrKebzZWyL/h5qKCOdIAcgvBSkLfAbmMpQRHKzG75Ow9HL8Dxo=
X-Received: by 2002:a5d:9e03:: with SMTP id h3mr7450905ioh.94.1614936755055;
 Fri, 05 Mar 2021 01:32:35 -0800 (PST)
MIME-Version: 1.0
References: <YDPO/JprcDTaPmR4@hovoldconsulting.com> <0f9caf26-af58-13a9-9947-47bb646f505e@IEEE.org>
 <YDPS3AP63/PwmwJU@hovoldconsulting.com> <780b9aa6-890d-47fd-d6b2-cd9a39f7634a@IEEE.org>
 <YDUiuLtwRkZ0D0Mi@hovoldconsulting.com> <f63df659-6cdf-bba6-f892-1012b98f82e2@IEEE.org>
 <YDUp0tIThOZSTHJt@hovoldconsulting.com> <93584ae4-665e-1e67-01e0-cc53f987bee4@IEEE.org>
 <YDUysZY90FfVhrHK@hovoldconsulting.com> <CAAZvQQ6F=cQ-EhC0kgeTVM3GrtBWR+HfM6UJWj2AEF1NYZ-vAQ@mail.gmail.com>
 <YDaGRRYrEO5BEJv0@hovoldconsulting.com>
In-Reply-To: <YDaGRRYrEO5BEJv0@hovoldconsulting.com>
From:   Charles Yeh <charlesyeh522@gmail.com>
Date:   Fri, 5 Mar 2021 17:32:23 +0800
Message-ID: <CAAZvQQ7+b9=DKqPxgsXxS7Lhqj=QTzKHCMarSbsQkAnYqdO1GA@mail.gmail.com>
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

110 bps is not the standard Baud rate,
PL2303TA don't work with the current Linux driver (d5 0e 00 80), It
needs to "a8 a6 01 80"

Charles.

Johan Hovold <johan@kernel.org> =E6=96=BC 2021=E5=B9=B42=E6=9C=8825=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=881:00=E5=AF=AB=E9=81=93=EF=BC=9A

> But can you confirm that your PL2303TA works with the current Linux
> driver at 110 Bd (and doesn't need the alternate divisor encoding)?
>
