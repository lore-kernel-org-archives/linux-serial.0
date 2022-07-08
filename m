Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7817C43334
	for <linux-serial@archiver.kernel.org>; Fri,  8 Jul 2022 15:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237849AbiGHPvi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 8 Jul 2022 11:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237623AbiGHPvi (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 8 Jul 2022 11:51:38 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCC271BD6
        for <linux-serial@vger.kernel.org>; Fri,  8 Jul 2022 08:51:37 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-31caffa4a45so130305047b3.3
        for <linux-serial@vger.kernel.org>; Fri, 08 Jul 2022 08:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PxXJGYjc1T1RUNmEye8JEXfa/M7X5f4G0fVy7bZJQlI=;
        b=arP9T+KAHOv+frRF5GTxO7iWhTS306JQ/EX4TkSMeg0UBl6/s4zoQ9VUTnpNkEUz+2
         YssUoW2eHFNmsIcg99K0w9fH68TGvWVIg5ul2tSnsIux0obXj3iLGohwm9Civ94YzQX/
         TM3vyeWz/gXCnNmva7iCWbusiKBRJxDTLxa3XxSaoUL8AGtT9ygCr5sZ8q4Lp0Kt/iec
         PEPx5Ej3OXTWHwI/KnigGm4XuZIDeYfPbUadhHewTHJ1XEOoT1bJQBrQrHNPai4AV1My
         3dLF7HieayU12BDV34nt4iUPD3ag7BlV+xQ8+mRiDwtjwJnmR7WEXyqykvvr0LTYTTPD
         7txA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PxXJGYjc1T1RUNmEye8JEXfa/M7X5f4G0fVy7bZJQlI=;
        b=7LKfxC2B3svJtDUl/QxUjqo/SJbGms9SKDJhJAURtCtq98F68FpqnrIr53ECotgWqk
         GjaBV+gJBFhtPVZLiJf7yA5+VpHHR1qtdKq+gvkiYOeUb18bEjfbPaGngYlSBI+qlS7j
         hppOMRdulBoDARaoMhDyjSdWklNNYcZpd+8rTahCJRnBcO3EtfE1ZWE0cwqyLtio8a61
         gtPUREOwfe4Uq0DMB332gD1pAQUsi1ra0msB33hUCPce60zhNKeoeJCmVhg85Fm46naN
         PmoYKaPf7bMFCnnPw6DruF+aNr2Dq7+gZDMHeV6aqz885L21CiCGY9DCCAEfE4wKEHQD
         /5Og==
X-Gm-Message-State: AJIora9xOQy56b2KzIYfgT9Y6qhqj3H+MLzgqwnuE55Jw+KumJqV/ejj
        zqcctaKUvtE7kr1/UnWDi0UxnPITCUca5D+oO/c6EW5kdd8=
X-Google-Smtp-Source: AGRyM1twHJtpO9FFvhghZ79LYS4bcXPmPwCMHZsOk/b/lSJrqYpzbao55nfxjb/dIaKxT37VZDSVWB/VNQcQVJvwCYk=
X-Received: by 2002:a81:4986:0:b0:31d:388b:d08d with SMTP id
 w128-20020a814986000000b0031d388bd08dmr369267ywa.185.1657295496768; Fri, 08
 Jul 2022 08:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220707145354.29705-1-kabel@kernel.org> <20220707145354.29705-5-kabel@kernel.org>
In-Reply-To: <20220707145354.29705-5-kabel@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Jul 2022 17:51:00 +0200
Message-ID: <CAHp75VdamVbTZ2--GXLY6u_O9QmqN5GXTyZQ-NLfWWaEX6bBBw@mail.gmail.com>
Subject: Re: [PATCH 4/7] USB: serial: ftdi_sio: Do not reset baudrate to 9600
 on error
To:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Jul 7, 2022 at 4:57 PM Marek Beh=C3=BAn <kabel@kernel.org> wrote:
>
> From: Pali Roh=C3=A1r <pali@kernel.org>
>
> On failure to set new baudrate, reset baudrate to the previous value

a new
baud rate

> (as is done by other serial drivers) instead of resetting to 9600.

...

> +                       baud =3D old_baud ? old_baud : 9600;

Can be written as

  baud =3D old_baud ?: 9600;

...

> +                       if (div_value =3D=3D (u32)-1) {

Oh, unsigned -1? Can you define it with a meaningful name and depends
on the semantics use U32_MAX or GENMASK()?

> +                               baud =3D 9600;
> +                               div_value =3D ftdi_sio_baud_to_divisor(ba=
ud);
> +                       }

...

> +                       baud =3D (old_baud >=3D 183 && old_baud <=3D 3000=
000) ? old_baud : 9600;

These repetitive magics are error prone (easy to make a mistake or
off-by-one error). Can you create a simple helper for this?

--=20
With Best Regards,
Andy Shevchenko
