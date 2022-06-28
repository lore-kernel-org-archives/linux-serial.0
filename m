Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574F9C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 28 Jun 2022 11:41:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344195AbiF1LlI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Jun 2022 07:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344191AbiF1LlI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Jun 2022 07:41:08 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9302EA32;
        Tue, 28 Jun 2022 04:41:07 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3177f4ce3e2so113814967b3.5;
        Tue, 28 Jun 2022 04:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gtqkbAt/44JZuKoK/8+HWU5SI7/GA5fXmx6NsOvWC0s=;
        b=fg4edWbeIxms6mXn3pRaZGUDWb9BIfURpmMACw9YYY5JI4KE2RpDvFcxWrZjOgmmGT
         Rcx/Ht6bZ6ozPc+KJA+hWqjT9F725C2bQbp40ZnGvMwuznmt93zEDsIZyC046qiyODar
         Bk165bcFrgO4RC3OhuW8ZtEDB/lW8FifJY7WXQOLKs5QUVXQTIsoVbDwWEPNZKa1t05h
         Z2f/gtZs/ihhsYncWMGhiZigAxXyNAt7jcRgE60O0bUBzr1Tb8MxJhNtbChlIhN4FWXQ
         JlclNYLLVG/aoUXqVlqao4X7m2f2o2psATTkMdBpuLpOzDYwsSjZGtLPVUUZKr/Sobrb
         wBaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gtqkbAt/44JZuKoK/8+HWU5SI7/GA5fXmx6NsOvWC0s=;
        b=r81yV9F+mYKw2WCUbpC/GCyCbJbqToEWNK4KQglveofmQmx8I1PkUsk6dVtuTuWSlt
         IXB0mgAEj8HOi2bI5B1pCR59qJEo5srkzR73CWVxnG4ESr1nQtQJlDFihLKI63e84Us+
         piKM6bizh5h1YH7BCMLxp54vOhCdBVZOlJ4MKtNKNGVLxoVuQUeW1RwRBXIm4jp/Rt33
         yFjNg9YU1Sm4oIr+1WowVgW1mC61whvNe5LBx9VXyOWnagw6Ty2BedITCLhqQW0K/x3C
         VFvXGCyck7kqSfwxflauXFEw2m4Wo41EiZZunjBU9itSSQpSgF9OhX/Uaabn0X2bXaQb
         UeHg==
X-Gm-Message-State: AJIora8iZ1yXYoEKlDc5LUv7XoDbur7leHLuXLRV/Uje1TI+e6h02nu9
        JGHPks1YuNJQ/naEmPAkXyuzDYbp9mB5IU0yu2onvDWUz6w7IA==
X-Google-Smtp-Source: AGRyM1sAQk4IQ4ZgknIXlWCj2t3hqBQFszoXafJ1dWj9Cbbug/yzMs6/HzvxvM3GoEYn+SRfT/NAoPXNnGxw7jLiEGI=
X-Received: by 2002:a81:1889:0:b0:317:987b:8e82 with SMTP id
 131-20020a811889000000b00317987b8e82mr20634424ywy.185.1656416466227; Tue, 28
 Jun 2022 04:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220628094155.26297-1-ilpo.jarvinen@linux.intel.com>
 <20220628095136.fhtjjjkj3mre7hwa@pali> <20220628095942.rbpl2iocxoqtzxiy@pali> <CAHp75VeHNERyPAam_-u7+ykYxcUM_N-YT6kBAh+hG+7WNW31SA@mail.gmail.com>
In-Reply-To: <CAHp75VeHNERyPAam_-u7+ykYxcUM_N-YT6kBAh+hG+7WNW31SA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jun 2022 13:40:28 +0200
Message-ID: <CAHp75VfDA1x0OQjBb8rj7RB9bHgjXa86jrcayeuxbYxGLf2=Kg@mail.gmail.com>
Subject: Re: [PATCH] serial: mvebu: Apply old baudrate to termios
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Allen Yan <yanwei@marvell.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 28, 2022 at 1:39 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jun 28, 2022 at 12:01 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> > On Tuesday 28 June 2022 11:51:36 Pali Roh=C3=A1r wrote:

...

> > Ou, now I see where is the issue. Patch which I tested and which fixes
> > reporting baudrate is not in kernel tree yet and it looks like I totall=
y
> > forgot to sent it to ML. I will send it. Sorry for confusion.
>
> Shouldn't the Ilpo's applied anyway to fix the current code base?

Ah, now I understand that your patch is a fix. Sorry for the noise.

--=20
With Best Regards,
Andy Shevchenko
