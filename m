Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BB8C433FE
	for <linux-serial@archiver.kernel.org>; Mon,  7 Mar 2022 11:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242016AbiCGLeG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 7 Mar 2022 06:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241996AbiCGLd4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 Mar 2022 06:33:56 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF66D38A0
        for <linux-serial@vger.kernel.org>; Mon,  7 Mar 2022 03:32:15 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bt26so5864758lfb.3
        for <linux-serial@vger.kernel.org>; Mon, 07 Mar 2022 03:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PfDSGTII8OEq1qMEWbwlEjjVe6Gd0qQ3i7mpLlNovXo=;
        b=s6fHa1lvEZ+3Bh1MehfEE0HK2VfASVuaxT8SUp12QuE277aF8K2ybSSCjlQLOh6dJi
         6zpjHIwqMHH72jSXgtSQe2JtnejXCOauODmvOckPKVdOlqqp/Vq/CrgMeT5SJw6kS6BK
         ZsPglIRC5dj0Yt88BFUbW4EjjleYt8+jh83REiycP2I5e2xY/+ZmyvS75mTCoQQE5uYQ
         CArbxumWu4wcAdWMeCHljWrnasDzzlg8KtdX/1wPmtgkubTys0XMuhk8eIkc2S20PRVT
         sMIq8M2tKLu1pwsBS6LquT12mIPGWldhjYkSa6AmYa3Z6uB/hkjIgZ9yUH25RUYEoCcB
         Bk7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PfDSGTII8OEq1qMEWbwlEjjVe6Gd0qQ3i7mpLlNovXo=;
        b=w3SvoK8rVCsxc84I7BTD5AS84jnvDZWdcKnCaIEfoI/b3KJmVUzG8j8cJOeC/7nEaD
         lgni365d2mkvFORPRoTfqL4+afXlhB9Y2EpFPsD8CJKkgHmIK4q+aDgXrAo+UaFk1jYr
         7ifcGV3+5KELuWYuB5XlR2Ttcc1c5FqFU240wHIhpMqiZL3iJB7aKlrVz68fQG6NG6Br
         rp0SR0PEr+dqjCfYNIkGLvnGu/aq3KGsHPitxvP3vzpNx0Asi+o4QB2JXpV06SL04qjt
         GglbNoniDsArEZMoqwSaZ5cVh8gEE60FBTnQQoB4KiwIOsZW0IuSOi747W03MGsyXlSV
         d/kQ==
X-Gm-Message-State: AOAM530FhWnX9ekwqZBsen5zWEoDV2vyxiUEY+7R24neN2VFCYEaYfnD
        bbTrr3bReaH8Qr82IjGiTHZIEhpinNucHRWnTWm8hg==
X-Google-Smtp-Source: ABdhPJwrz3os6eByp/EdpREzHyJ/tokDYc1QXytMUsDeDk0Qqfiy5D7kAKidVGdZ+pKK2v++O45kzV7d0Lmw+p4uxYg=
X-Received: by 2002:a05:6512:220c:b0:447:413d:f9a2 with SMTP id
 h12-20020a056512220c00b00447413df9a2mr7324231lfu.22.1646652734247; Mon, 07
 Mar 2022 03:32:14 -0800 (PST)
MIME-Version: 1.0
References: <20220304064324.331217-1-hasegawa-hitomi@fujitsu.com>
 <20220304064324.331217-2-hasegawa-hitomi@fujitsu.com> <CAD=FV=Udf=MzyPa_o=vz=nc7ZVXBuuVNqw-VOSfrShuv0hN64Q@mail.gmail.com>
In-Reply-To: <CAD=FV=Udf=MzyPa_o=vz=nc7ZVXBuuVNqw-VOSfrShuv0hN64Q@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 7 Mar 2022 17:02:02 +0530
Message-ID: <CAFA6WYM77XTttu4H35PL7tkZxtBA8XaX23QW1UTBcESBE4V0fw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tty/sysrq: Make sysrq handler NMI aware
To:     Doug Anderson <dianders@chromium.org>
Cc:     Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>, linux-serial@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Doug,

On Fri, 4 Mar 2022 at 23:36, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Mar 3, 2022 at 10:45 PM Hitomi Hasegawa
> <hasegawa-hitomi@fujitsu.com> wrote:
> >
> >  void __handle_sysrq(int key, bool check_mask)
> >  {
> >         const struct sysrq_key_op *op_p;
> > @@ -573,6 +606,10 @@ void __handle_sysrq(int key, bool check_mask)
> >         int orig_suppress_printk;
> >         int i;
> >
> > +       /* Skip sysrq handling if one already in progress */
> > +       if (sysrq_nmi_key != -1)
> > +               return;
>
> Should this give a warning?
>
> Also, can you remind me why this is safe if two CPUs both call
> handle_sysrq() at the same time? Can't both of them make it past this?
> That doesn't seem so great.
>
>
> > @@ -596,7 +633,13 @@ void __handle_sysrq(int key, bool check_mask)
> >                 if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
> >                         pr_info("%s\n", op_p->action_msg);
> >                         console_loglevel = orig_log_level;
> > -                       op_p->handler(key);
> > +
> > +                       if (in_nmi() && !op_p->nmi_safe) {
> > +                               sysrq_nmi_key = key;
> > +                               irq_work_queue(&sysrq_irq_work);
>
> It looks like irq_work_queue() returns false if it fails to queue.
> Maybe it's worth checking and setting "sysrq_nmi_key" back to -1 if it
> fails?

Thanks for your comments. I hope v4 here [1] addresses all of them.
Please have a look again.

[1] https://lkml.org/lkml/2022/3/7/1059

-Sumit
