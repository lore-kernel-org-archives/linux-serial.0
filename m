Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A56C77B7E
	for <linux-serial@archiver.kernel.org>; Thu, 25 May 2023 20:38:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbjEYUiy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 May 2023 16:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjEYUix (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 May 2023 16:38:53 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A5CD3
        for <linux-serial@vger.kernel.org>; Thu, 25 May 2023 13:38:52 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-77496b0b345so3523939f.3
        for <linux-serial@vger.kernel.org>; Thu, 25 May 2023 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685047130; x=1687639130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGJZr5W3x0BuCVWV8isCIdn4Eq16XXfkBNZbIkFZj74=;
        b=AgxW261fcXKa0vllpGg7fLeh5HvF5dwh/g8faM8m3DBtbtTF57FCXeqgi71H1ficqn
         aTQgBqFfQguxB/DyDO758ZrznIGT/iVX5d5/rVrXmCU4W3YDFRrZO8zDnsyOtsYqiLlb
         xIvP3XEA4/By5HLCMcr/nmasMXaGB52CXXcRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685047130; x=1687639130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGJZr5W3x0BuCVWV8isCIdn4Eq16XXfkBNZbIkFZj74=;
        b=Sw4s8exSOLsVOmul2q6q1nmvnVq8f0aL8IX0nUfbw1LGU2ZypHuIL/bsLE5l2lwAHA
         8nZzx+Fq7uCNlARm/aG5kqT5+4fdT1EzBZ4KcG4s3LpDDez42IQcrvvccAvKhel8mVNU
         iaM26mrUluPcMaqVJ29k2snHTfcIcb2sHhYza8OXdtVDQSGaHkXJ37mTZ/6BPRPGwRls
         jdzHc6pHpKVsMqZKNvjX37YsiqNrOkcRnReC2AMEzYU4ZZSdGsJrheFv4lw98FvP5wu+
         s/faIL9UB3uqCGJ/meayPkEylSSdkW0jP1SfmHRre9qw+ugpiZh1VDZtOqRn1MT/ytf9
         W8QQ==
X-Gm-Message-State: AC+VfDzMwNZXqUthSzoC4AyCn3VJflc15wix+HbwdHT4ZdGo38yH3835
        LVG8Vp360UEksUzDxmc3nivAg2oMQmv0Lapp974=
X-Google-Smtp-Source: ACHHUZ7V6Zl8mpVun//E22Y4kHlHSQAFzQe9fvDz6nVkR3ZKQ9Kgythoobiez33zOgj/qQaAAD3ALw==
X-Received: by 2002:a5d:8c82:0:b0:774:e2b4:5d6e with SMTP id g2-20020a5d8c82000000b00774e2b45d6emr489909ion.14.1685047130350;
        Thu, 25 May 2023 13:38:50 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id bq3-20020a056638468300b0040bd3646d0dsm628155jab.157.2023.05.25.13.38.49
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 13:38:49 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-33828a86ee2so40735ab.0
        for <linux-serial@vger.kernel.org>; Thu, 25 May 2023 13:38:49 -0700 (PDT)
X-Received: by 2002:a92:c54d:0:b0:33a:e716:a76d with SMTP id
 a13-20020a92c54d000000b0033ae716a76dmr7771ilj.27.1685047129031; Thu, 25 May
 2023 13:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230525093159.223817-1-john.ogness@linutronix.de>
 <20230525093159.223817-5-john.ogness@linutronix.de> <CAD=FV=UPZOOW-K8XMfnjn-BGaMnr6Ee44FimpB=ZnrOJ6N3ngA@mail.gmail.com>
In-Reply-To: <CAD=FV=UPZOOW-K8XMfnjn-BGaMnr6Ee44FimpB=ZnrOJ6N3ngA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 May 2023 13:38:37 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WSKaihdow4Bbr6SSuUXL3s1u3it-=0Gkh95q=bwZuqnA@mail.gmail.com>
Message-ID: <CAD=FV=WSKaihdow4Bbr6SSuUXL3s1u3it-=0Gkh95q=bwZuqnA@mail.gmail.com>
Subject: Re: [PATCH tty v1 4/8] serial: core: lock port for start_rx() in uart_resume_port()
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

On Thu, May 25, 2023 at 9:07=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Thu, May 25, 2023 at 2:34=E2=80=AFAM John Ogness <john.ogness@linutron=
ix.de> wrote:
> >
> > The only user of the start_rx() callback (qcom_geni) directly calls
> > its own stop_rx() callback. Since stop_rx() requires that the
> > port->lock is taken and interrupts are disabled, the start_rx()
> > callback has the same requirement.
> >
> > Fixes: cfab87c2c271 ("serial: core: Introduce callback for start_rx and=
 do stop_rx in suspend only if this callback implementation is present.")
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> > ---
> >  drivers/tty/serial/serial_core.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/seri=
al_core.c
> > index 37ad53616372..f856c7fae2fd 100644
> > --- a/drivers/tty/serial/serial_core.c
> > +++ b/drivers/tty/serial/serial_core.c
> > @@ -2430,8 +2430,11 @@ int uart_resume_port(struct uart_driver *drv, st=
ruct uart_port *uport)
> >                 if (console_suspend_enabled)
> >                         uart_change_pm(state, UART_PM_STATE_ON);
> >                 uport->ops->set_termios(uport, &termios, NULL);
> > -               if (!console_suspend_enabled && uport->ops->start_rx)
> > +               if (!console_suspend_enabled && uport->ops->start_rx) {
> > +                       spin_lock_irq(&uport->lock);
> >                         uport->ops->start_rx(uport);
> > +                       spin_unlock_irq(&uport->lock);
> > +               }
>
> Seems right, but shouldn't you also fix the call to stop_rx() that the
> same commit cfab87c2c271 ("serial: core: Introduce callback for
> start_rx and do stop_rx in suspend only if this callback
> implementation is present.") added? That one is also missing the lock,
> right?

Ah, I see. You did that in a separate patch and I wasn't CCed. I guess
I would have just put the two in one patch, but I don't feel that
strongly.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
