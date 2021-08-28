Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA23C432BE
	for <linux-serial@archiver.kernel.org>; Sat, 28 Aug 2021 07:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA18610F9
	for <linux-serial@archiver.kernel.org>; Sat, 28 Aug 2021 07:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhH1Hzx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 28 Aug 2021 03:55:53 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:39687 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbhH1Hzw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 28 Aug 2021 03:55:52 -0400
Received: by mail-ed1-f49.google.com with SMTP id z10so13370880edb.6
        for <linux-serial@vger.kernel.org>; Sat, 28 Aug 2021 00:55:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tF0+d9wCR1f19Vsv6nm0aWJS1Jex2Zl9dmnV6eqdL/8=;
        b=Vn3Hkhc9BtO9xgNudIBcdo1bNwhgvjxg8DMjnj4ka1VyEBMD8NcPcigMhJ9dE8m4OA
         165SkSJvjcgmcTpeRxbdx4CPWY8kO/tn52/hUO9HRD2HCmMhRCeX26FFYradLqMOrke1
         g084yCYlvOZS9YhPQe6inKt4lCBlJ8LDD98h6lswKRC0wJv8DOwegS1o2CNOIWvobcgr
         YQK1w1+mqaXJ37feR5/hv29Q1ax+spO0gYkrAxqEnjehuM4HDN9JPgd1QLsQfCScOmNP
         F5v2jBT5islAhYSB+XWSjl+8MoK5TS0GGz/5bc7Snq1K8WTlfl38v6IOnGCGGjJ2743g
         3LsQ==
X-Gm-Message-State: AOAM533HOKz8im89MPq+Sra+x0xADQYyxbAWSKCdijQuzE80L0OwobFZ
        e6qu7soo3kkEEfC1yoliOGn018LDs50=
X-Google-Smtp-Source: ABdhPJz1A5s7YqMba23w5eHevXN7Wbyeu3K8P6GcPsROKDsvOZ1RxhxGv9kGfJqZlTN+gvaU4o9Hsg==
X-Received: by 2002:aa7:de85:: with SMTP id j5mr13886457edv.147.1630137301849;
        Sat, 28 Aug 2021 00:55:01 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with UTF8SMTPSA id x15sm3734941ejv.95.2021.08.28.00.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Aug 2021 00:55:01 -0700 (PDT)
Message-ID: <c5ef817e-7ae9-ae93-a3c4-08fecb943c53@kernel.org>
Date:   Sat, 28 Aug 2021 09:55:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH] tty: serial: UART driver for RISC-V based Chromite SoC
 family
Content-Language: en-US
To:     "Sathish Kumar Balasubramaniam -ERS, HCL Tech" 
        <b-sathishkumar@hcl.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
References: <SG2PR04MB382047047E75CF30B8E8EA0B81C89@SG2PR04MB3820.apcprd04.prod.outlook.com>
 <SG2PR04MB3820B2DED21B7B5DB868A18F81C89@SG2PR04MB3820.apcprd04.prod.outlook.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <SG2PR04MB3820B2DED21B7B5DB868A18F81C89@SG2PR04MB3820.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 27. 08. 21, 18:32, Sathish Kumar Balasubramaniam -ERS, HCL Tech wrote:
> +static void chromite_serial_set_termios(struct uart_port *port,
> +                                               struct ktermios *termios,
> +                                               struct ktermios *old) {
> +       struct chromite_serial_port *csp = port_to_chromite_serial_port(port);
> +       unsigned long flags;
> +       int rate;
> +
> +       if ((termios->c_cflag & CSIZE) != CS8)
> +               dev_err_once(csp->port.dev, "only 8-bit words supported\n");
> +       if (termios->c_cflag & CSTOPB)
> +               dev_err_once(csp->port.dev, "only 1 stop-bit is supported\n");
> +       if (termios->c_iflag & (INPCK | PARMRK))
> +               dev_err_once(csp->port.dev, "parity checking not supported\n");
> +       if (termios->c_iflag & BRKINT)
> +               dev_err_once(csp->port.dev, "BREAK detection not
> + supported\n");

Many mangled lines like this. Please fix these up in v2. And also use 
checkpatch. The function-opening { above should be on a separate line 
(on many locations).

thanks,
-- 
js
