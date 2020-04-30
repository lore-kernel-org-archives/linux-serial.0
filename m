Return-Path: <SRS0=pdp3=6O=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B717C83000
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 00:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D930E208E0
	for <linux-serial@archiver.kernel.org>; Thu, 30 Apr 2020 00:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i2TyRdk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgD3AkZ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Apr 2020 20:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726279AbgD3AkZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Apr 2020 20:40:25 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3686C035494
        for <linux-serial@vger.kernel.org>; Wed, 29 Apr 2020 17:40:24 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id z1so2687793vsn.11
        for <linux-serial@vger.kernel.org>; Wed, 29 Apr 2020 17:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=49/GUq/fltLJWqVhbL7UqtJO8rowbFsOO5SNzjwHTOY=;
        b=i2TyRdk3Tqw4h5DLb1A3tKoVpg6kPPWMN84oMR/sl9QzBxxG57S94enQkwZ8kWGyDV
         tzwy8lrWGZ5glKqDug98HzSRlI/YWxPBTgkGtapyACJT9Q7CD0mJ1M+mRSABCl9EdY8i
         qce3QsW8VvVCYeQp7Cbb/dZQ7uMdN1f7TZLaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=49/GUq/fltLJWqVhbL7UqtJO8rowbFsOO5SNzjwHTOY=;
        b=K01pBsgiwIgmhlVND23uitJ6D6OTc0BaVyTz7ytixx+lZY9Mwn1gNvr0oyuOP0ND/l
         cT1C90lp4tP/dKohdn2Kym54HBwb/Cb14iah2TXwnzToerIfuJvdL6djNBmzMoB6RbG2
         0W68LwLjemC6kTQ2NQZrxQ61uLJmL5OR6qgWIbdC7r1m4Ebc6TUl8vlEcs5fF+QTBfXD
         xb6wA+kZsacmOjeoD0Kx76apha0qHVNc50XCasF30K73+1q6A0+kRa7de9TvDUFyn9RR
         O4VfhClkuDGrV5InAYiuRbVb2hE7aK7+jRF55Y5W6HCxHHTCAuPyUCTEMLOH4h/OUmsX
         AkFA==
X-Gm-Message-State: AGi0PuYDbpHs9iJlhdrIinnZEhaxWxjK+9yQvKonosNstU2NJanxqjNK
        GSscZutb4eypBXbbgPI4ruYkvyNgt+I=
X-Google-Smtp-Source: APiQypK2TlCbYi4WbFXu0w8n6e93muhaVT0pOSgVfirxnIcMj66OBmGABpgHhUGBFd2CilzfrH4uqQ==
X-Received: by 2002:a67:32c4:: with SMTP id y187mr969697vsy.120.1588207223709;
        Wed, 29 Apr 2020 17:40:23 -0700 (PDT)
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com. [209.85.221.172])
        by smtp.gmail.com with ESMTPSA id d184sm365892vkf.37.2020.04.29.17.40.22
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 17:40:22 -0700 (PDT)
Received: by mail-vk1-f172.google.com with SMTP id i185so1235745vki.12
        for <linux-serial@vger.kernel.org>; Wed, 29 Apr 2020 17:40:22 -0700 (PDT)
X-Received: by 2002:a1f:9645:: with SMTP id y66mr643020vkd.40.1588207222154;
 Wed, 29 Apr 2020 17:40:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200428162227.687978-1-daniel.thompson@linaro.org>
In-Reply-To: <20200428162227.687978-1-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 29 Apr 2020 17:40:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VTkO5AULJe1ksyhKLLxpywqX-RLC_T4ENyDf3ONJNMKg@mail.gmail.com>
Message-ID: <CAD=FV=VTkO5AULJe1ksyhKLLxpywqX-RLC_T4ENyDf3ONJNMKg@mail.gmail.com>
Subject: Re: [PATCH] serial: earlycon: Allow earlier DT scan is acpi=off
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Tue, Apr 28, 2020 at 9:22 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently if the kernel has support for ACPI SPCR parsing then earlycon
> without arguments is processed later than the full earlycon=...
> alternative.
>
> If ACPI has been explicitly disabled on the kernel command line then
> there is not need to defer since the ACPI code (both x86 and arm64)
> will never actually run.
>
> Or, put another way it allows lazy people to throw "acpi=off earlycon"
> onto the command line of a DT systems and be confident the console will
> start as early as possible without them having to lookup the driver
> and address needed for a specific platform.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  drivers/tty/serial/earlycon.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)

I wonder if a cleaner option is to just add a special "earlycon" value
like "earlycon=not_acpi".  This wouldn't require any special peeking
and would just be a sentinel that just says "you should autodetect the
earlycon, but don't worry about waiting for ACPI".  ...that in itself
is a bit of a hack, but at least it's more self contained in the
earlycon driver and maybe more discoverable when someone is figuring
out how to setup earlycon?

-Doug



>
> diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
> index 2ae9190b64bb..ebb648aacb47 100644
> --- a/drivers/tty/serial/earlycon.c
> +++ b/drivers/tty/serial/earlycon.c
> @@ -215,6 +215,31 @@ int __init setup_earlycon(char *buf)
>   */
>  bool earlycon_acpi_spcr_enable __initdata;
>
> +/*
> + * This takes a sneaky peek at other boot arguments (which may not have
> + * been parsed at this point in the boot) to check whether ACPI has
> + * been explicitly disabled. If it is explicitly disabled then there is
> + * no reason to defer initialization of the early console.
> + */
> +static bool earlycon_check_for_acpi_off(void)
> +{
> +       static const char token[] = "acpi=off";
> +       const char *arg;
> +       char before, after;
> +
> +       arg = strstr(boot_command_line, token);
> +       while (arg) {
> +               before = arg == boot_command_line ? ' ' : arg[-1];
> +               after = arg[sizeof(token)-1];
> +               if (isspace(before) && (isspace(after) || after == '\0'))
> +                       return true;
> +
> +               arg = strstr(arg+1, token);
> +       }
> +
> +       return false;
> +}
> +
>  /* early_param wrapper for setup_earlycon() */
>  static int __init param_setup_earlycon(char *buf)
>  {
> @@ -222,7 +247,8 @@ static int __init param_setup_earlycon(char *buf)
>
>         /* Just 'earlycon' is a valid param for devicetree and ACPI SPCR. */
>         if (!buf || !buf[0]) {
> -               if (IS_ENABLED(CONFIG_ACPI_SPCR_TABLE)) {
> +               if (IS_ENABLED(CONFIG_ACPI_SPCR_TABLE) &&
> +                   !earlycon_check_for_acpi_off()) {
>                         earlycon_acpi_spcr_enable = true;
>                         return 0;
>                 } else if (!buf) {
> --
> 2.25.1
>
