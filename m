Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73632C433F5
	for <linux-serial@archiver.kernel.org>; Fri,  4 Mar 2022 18:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241061AbiCDSGx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Mar 2022 13:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiCDSGx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Mar 2022 13:06:53 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D1F1C46B2
        for <linux-serial@vger.kernel.org>; Fri,  4 Mar 2022 10:06:01 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id c19so2012187ede.8
        for <linux-serial@vger.kernel.org>; Fri, 04 Mar 2022 10:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ScIINym/s1zYwdre28Fn9pTUeIcuABEqsfOfpBejDew=;
        b=gTDLuJI8Mi9+ftvhMPpwI3xkvmlECcV27R9BSVD6hXT0HmVBRR0FwwoLXYb6N1Al2i
         bK/j3t1B1Ljjq+Fc5+0SWeynkJdvwuff3j4suXxefwL460DXjznAMYUx8jShSKhXaT81
         LAKUCxOZsJQtuiy2ZURKJeOVgZdTpa69HCVI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ScIINym/s1zYwdre28Fn9pTUeIcuABEqsfOfpBejDew=;
        b=WKM4oGe4NIgPDaD69Qea/BfiRno1lOtiyRERuaTW5+OvqzH/Lv1Ld+0WnEFWSHEpfz
         FUrjqNGMj//Au+mC59664OoEVVEYoXdj0tBrU2dI7h2Uag1S2mMxC+JueBFZmzsWUT2S
         Pv485EqteJVSAUKEoZY+WFsH4ApNUMpVyUQCyPvZFWSUSbJB60mb4OR8+iQK0oTAU1J7
         vc9EJ0yRYA2pHZRAy2Kxr3n9LA7KxE0YTiNsIsVJz1iEwGDGuPhUfS1uQcgY34GsbnKP
         OZjfklTx7kuTjB3Q/GmQp7IMYer/6ukqW+AkY/2c9UA8/x/TV2WbA4E5IkUvLLNGQP6M
         8fqg==
X-Gm-Message-State: AOAM532l59LkzeEMdihWeox3fx3WJ5l5SHfIPWj4aL0hMeTtBo8/ZmtI
        JqtpC3YuVk1NudIhWt7+JcU9nrdl4gVqj3Lf
X-Google-Smtp-Source: ABdhPJyn9MgU5pr+U0b36PS9nECsRQfLlWKoFkCxZKAQZ69j0o1dyNOX3c3ljx9VYBgHitY4dW9yhg==
X-Received: by 2002:a05:6402:270a:b0:410:63d:a66d with SMTP id y10-20020a056402270a00b00410063da66dmr40489523edd.48.1646417159926;
        Fri, 04 Mar 2022 10:05:59 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id r11-20020aa7cfcb000000b00412c58c43ccsm2401608edy.37.2022.03.04.10.05.58
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 10:05:59 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id u10so12196704wra.9
        for <linux-serial@vger.kernel.org>; Fri, 04 Mar 2022 10:05:58 -0800 (PST)
X-Received: by 2002:a5d:64ed:0:b0:1f0:6672:f10c with SMTP id
 g13-20020a5d64ed000000b001f06672f10cmr4171901wri.679.1646417158156; Fri, 04
 Mar 2022 10:05:58 -0800 (PST)
MIME-Version: 1.0
References: <20220304064324.331217-1-hasegawa-hitomi@fujitsu.com> <20220304064324.331217-2-hasegawa-hitomi@fujitsu.com>
In-Reply-To: <20220304064324.331217-2-hasegawa-hitomi@fujitsu.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 4 Mar 2022 10:05:45 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Udf=MzyPa_o=vz=nc7ZVXBuuVNqw-VOSfrShuv0hN64Q@mail.gmail.com>
Message-ID: <CAD=FV=Udf=MzyPa_o=vz=nc7ZVXBuuVNqw-VOSfrShuv0hN64Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tty/sysrq: Make sysrq handler NMI aware
To:     Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>, linux-serial@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
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

Hi,

On Thu, Mar 3, 2022 at 10:45 PM Hitomi Hasegawa
<hasegawa-hitomi@fujitsu.com> wrote:
>
>  void __handle_sysrq(int key, bool check_mask)
>  {
>         const struct sysrq_key_op *op_p;
> @@ -573,6 +606,10 @@ void __handle_sysrq(int key, bool check_mask)
>         int orig_suppress_printk;
>         int i;
>
> +       /* Skip sysrq handling if one already in progress */
> +       if (sysrq_nmi_key != -1)
> +               return;

Should this give a warning?

Also, can you remind me why this is safe if two CPUs both call
handle_sysrq() at the same time? Can't both of them make it past this?
That doesn't seem so great.


> @@ -596,7 +633,13 @@ void __handle_sysrq(int key, bool check_mask)
>                 if (!check_mask || sysrq_on_mask(op_p->enable_mask)) {
>                         pr_info("%s\n", op_p->action_msg);
>                         console_loglevel = orig_log_level;
> -                       op_p->handler(key);
> +
> +                       if (in_nmi() && !op_p->nmi_safe) {
> +                               sysrq_nmi_key = key;
> +                               irq_work_queue(&sysrq_irq_work);

It looks like irq_work_queue() returns false if it fails to queue.
Maybe it's worth checking and setting "sysrq_nmi_key" back to -1 if it
fails?

-Doug
