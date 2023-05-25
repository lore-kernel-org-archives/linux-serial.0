Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D182C7EE2C
	for <linux-serial@archiver.kernel.org>; Thu, 25 May 2023 20:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241666AbjEYUhp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 May 2023 16:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbjEYUhn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 May 2023 16:37:43 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E31194
        for <linux-serial@vger.kernel.org>; Thu, 25 May 2023 13:37:38 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-77480507360so3325339f.3
        for <linux-serial@vger.kernel.org>; Thu, 25 May 2023 13:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685047057; x=1687639057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1q5BIhyHxy2KwWgZBKI5+TSZP/AvpzgkEZSqlGxlLuw=;
        b=YQx45jR7I72YjpwV14MAmGZja6gOe2yLE7QRjIwAbN56Iel42d42EqRp2D/2GTI0cf
         02LdJWtayWKy3xQqjjNCScOaTD5b1wbm6gy4IGMOF/J1do4W6t6+MwsJRuZeqEn8yQiB
         XiCVd7ZitcpJOv54EIaNycDQNHUNQbEemzMSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685047057; x=1687639057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1q5BIhyHxy2KwWgZBKI5+TSZP/AvpzgkEZSqlGxlLuw=;
        b=AAlSxGpCnlEi0hkjjGE/gUaFjaaEl7JrGg+ilDQu/tqwrjhZwrpCRioea7RPvzIwCp
         OvHSuFxFtlG6MPr3Obt4O/oWt26fuuCPiGssbKahah51vAPAkDuY7D9TjdwM9hPN1szE
         XahoF8RLRtMbL8Cil9w7SApVJzWxC6PPRmtwnC55hawuaEDwuB+FSTGDuxgct49EGLcb
         Y99z62z7Q/kuBqAskdXk+B9gWP+r4Yz9nq7qGVBOR/uPQD1yPVRFyoJdrpg2K05KEsj4
         dAIyyhcCXTdKDOF9IpVe0UdlOyLA3yIJf1PFUZwaALqojFLZls2f2+7f5KNFFivpvlv6
         p5FQ==
X-Gm-Message-State: AC+VfDzv7S9GixpjiKgRo8+BOje8jykPwxUw5E+WVdI1StQ1EQzhL7qP
        s0OXir27ezcNuIzCni6uUmmXgG84AyF1W3vxr9Q=
X-Google-Smtp-Source: ACHHUZ7cIi+e61FJWpaI+hdgPx3+KMU88/GODe0MakO9bWsssJctA5S3hbzSHPIUx+stwqYHbB63rg==
X-Received: by 2002:a5e:db08:0:b0:775:5f74:f4ca with SMTP id q8-20020a5edb08000000b007755f74f4camr531384iop.9.1685047056717;
        Thu, 25 May 2023 13:37:36 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id p22-20020a027816000000b004189da0d852sm631174jac.167.2023.05.25.13.37.35
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 13:37:36 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-338458a9304so11245ab.1
        for <linux-serial@vger.kernel.org>; Thu, 25 May 2023 13:37:35 -0700 (PDT)
X-Received: by 2002:a05:6e02:1581:b0:320:9759:bf6b with SMTP id
 m1-20020a056e02158100b003209759bf6bmr68419ilu.3.1685047055386; Thu, 25 May
 2023 13:37:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230525093159.223817-1-john.ogness@linutronix.de> <20230525093159.223817-3-john.ogness@linutronix.de>
In-Reply-To: <20230525093159.223817-3-john.ogness@linutronix.de>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 May 2023 13:37:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U42xgt1PBdpaqtuzHOAjVUdWRyRaE0OpWiiMm-B1qf7g@mail.gmail.com>
Message-ID: <CAD=FV=U42xgt1PBdpaqtuzHOAjVUdWRyRaE0OpWiiMm-B1qf7g@mail.gmail.com>
Subject: Re: [PATCH tty v1 2/8] serial: core: lock port for stop_rx() in uart_suspend_port()
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Thu, May 25, 2023 at 2:35=E2=80=AFAM John Ogness <john.ogness@linutronix=
.de> wrote:
>
> The uarts_ops stop_rx() callback expects that the port->lock is
> taken and interrupts are disabled.
>
> Fixes: c9d2325cdb92 ("serial: core: Do stop_rx in suspend path for consol=
e if console_suspend is disabled")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  drivers/tty/serial/serial_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
