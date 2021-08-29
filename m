Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A88CC432BE
	for <linux-serial@archiver.kernel.org>; Sun, 29 Aug 2021 07:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3111160F4B
	for <linux-serial@archiver.kernel.org>; Sun, 29 Aug 2021 07:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhH2HKy (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 29 Aug 2021 03:10:54 -0400
Received: from mail-ej1-f43.google.com ([209.85.218.43]:41499 "EHLO
        mail-ej1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbhH2HKx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 29 Aug 2021 03:10:53 -0400
Received: by mail-ej1-f43.google.com with SMTP id t19so23642756ejr.8
        for <linux-serial@vger.kernel.org>; Sun, 29 Aug 2021 00:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dT2Iy+p5szNYHF2ajzKhpXpVglkAyzkqwycKiP5qs5o=;
        b=hrKSAXirGS3I8pKcVChCKDt7Be0vvmHc6KUOMhiNOcP+z6fY2bEihyK/4cubGWu8K0
         WRnncKPC8m4NVmVrht7al6HWUTAkqTJmCeYyH2DeyP0qGyt/K0ZvOU9z8WjdXquhRP1H
         BFBnPdi7yEi4SyFhTafVqobEYfv58BYsltb2J6SZcNfc4SxFQEMdHwKGGkXHgGeSTIkn
         X0JxjDyjwOHylaTCz/zGS6rEywrZOEQ8YIrxhCyUm0pKa1sfwfyiyiU1o3Mt1vnLlXBl
         TNPx+YA4guAZG0dcBMElWEqSxoBvliVuMx40fxHCbsyLtyKU0NYOQC9B2EczyE3gUJNE
         tvOg==
X-Gm-Message-State: AOAM532OKu6VzEK/6moXMNSVcWWDXEMtWguLtU18WaZVFyIZgh+SeA6g
        ku0u4VkAheA5ZKAydUd44MgqXuBJq8Y=
X-Google-Smtp-Source: ABdhPJzkkX7InysLUxxj2ZKSfWdHqEHURcPKkxy5ky0O49oJVTJs7YZbllIgQbabK+BDYGkYmxGsDQ==
X-Received: by 2002:a17:906:fb19:: with SMTP id lz25mr19119275ejb.162.1630221001109;
        Sun, 29 Aug 2021 00:10:01 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with UTF8SMTPSA id b13sm5778137edu.27.2021.08.29.00.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 00:10:00 -0700 (PDT)
Message-ID: <a473e415-1cb2-a6bf-829b-c91777856a12@kernel.org>
Date:   Sun, 29 Aug 2021 09:09:58 +0200
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
 <c5ef817e-7ae9-ae93-a3c4-08fecb943c53@kernel.org>
 <SG2PR04MB3820A1CDCC0EBFCDC04B6D1181C99@SG2PR04MB3820.apcprd04.prod.outlook.com>
 <SG2PR04MB3820E80B2501990F1B906E8581C99@SG2PR04MB3820.apcprd04.prod.outlook.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <SG2PR04MB3820E80B2501990F1B906E8581C99@SG2PR04MB3820.apcprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 28. 08. 21, 19:16, Sathish Kumar Balasubramaniam -ERS, HCL Tech wrote:
> Classification: Public
> 
> Hi JS,
> 
> Got the function opening change and will do it.
> But could not understand the meaning which you are referring by mangled lines.
> Please can you explain the issue for one place so that I will do for all
> 
> Thank you.
> 
> 
> On 27. 08. 21, 18:32, Sathish Kumar Balasubramaniam -ERS, HCL Tech wrote:
>> +static void chromite_serial_set_termios(struct uart_port *port,
>> +                                               struct ktermios *termios,
>> +                                               struct ktermios *old) {
>> +       struct chromite_serial_port *csp = port_to_chromite_serial_port(port);
>> +       unsigned long flags;
>> +       int rate;
>> +
>> +       if ((termios->c_cflag & CSIZE) != CS8)
>> +               dev_err_once(csp->port.dev, "only 8-bit words supported\n");
>> +       if (termios->c_cflag & CSTOPB)
>> +               dev_err_once(csp->port.dev, "only 1 stop-bit is supported\n");
>> +       if (termios->c_iflag & (INPCK | PARMRK))
>> +               dev_err_once(csp->port.dev, "parity checking not supported\n");
>> +       if (termios->c_iflag & BRKINT)
>> +               dev_err_once(csp->port.dev, "BREAK detection not
>> + supported\n");
> 
> Many mangled lines like this. Please fix these up in v2. And also use checkpatch. The function-opening { above should be on a separate line (on many locations).

Note the
supported\n");
on a separate line above.


-- 
js
suse labs
