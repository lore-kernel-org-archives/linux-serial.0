Return-Path: <SRS0=bNnH=52=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 901B3C2BB55
	for <linux-serial@archiver.kernel.org>; Fri, 10 Apr 2020 08:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65868206F7
	for <linux-serial@archiver.kernel.org>; Fri, 10 Apr 2020 08:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RbaF5aX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgDJIgR (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Apr 2020 04:36:17 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37695 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgDJIgQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Apr 2020 04:36:16 -0400
Received: by mail-il1-f195.google.com with SMTP id a6so1231221ilr.4
        for <linux-serial@vger.kernel.org>; Fri, 10 Apr 2020 01:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3PdiAI8TBZ0N3tMXe+y1F2ge/27MztcbSpV/5KcvB8=;
        b=RbaF5aX7JxR9ZrqKBrEjNGP11OAY8n8lRcyXjGJYm7/iO135dM0ZZVVQUgQ4efd0UG
         sUTveU/iBU3bYQrld5SN01eadRlX6zBTO4mgbn3sqJzBE7c13XcjK6zjVL6UHYubPHky
         kH1BFPZd30qg5hkCMx3PP8tp+a7FLB4TbRgRptXtai14kbWMgZdNJXJkdCcxvb+YIj9e
         I29vqbUBgn4o8W9GBsE3HuLluyRlgkZdTg4kJLAL+fqbzet0cBc9cteAHC7J8xdK49Nr
         gFEMPR+O9DQTqi6rW5vXPo3YtKTfaRPmJZy1+fsZomJGplw05mHBlq/GKzbR0J9BDZVe
         ZdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3PdiAI8TBZ0N3tMXe+y1F2ge/27MztcbSpV/5KcvB8=;
        b=t6mnZlinLZj4h9bOI9jwNWr+ji2T/7WcaHeEBy+ZliwnVszUT+jf6NXzCM3Ynq5rZN
         eFLkjM5kZsS0Snq2hIeI2Kl0GVGfm1XDn7q8xny8NRKKYQ/oI9y+pAlOzI99G7a3aEq4
         NnUOc3ShDz2lSpAx6A20xwkQ70IZOiZitqz5tqfroB/3OXSAhA7NxdoRSX9kgOwUithN
         3BftR1jSgprO5Y+awABxoj5C/9uF1oX/5S1WIhVZwQZX+YmaQLChfyJurM8c7XJkiKoq
         99P+nnvXQRDGSQEX+/9Oh21dp7kbX92l84IzT2qD58GoriFabrr6KLlqbbfn0VtgkC4+
         uVng==
X-Gm-Message-State: AGi0PuZ4wCF6UE09/iVNuLNtDmQTB7VpPv8Bm7ncgy9q142qdBp6vsB/
        /zA/rsXkEga4BYhrFTGbWLFf+zU2CheBylDWqoTUbg==
X-Google-Smtp-Source: APiQypKo/YXFB9RUkEEYugAuxoS+/cv8vOu8Y+o5locNToNDbEQ0zbxLVsRMlxKzTR3j94zECtDsNT7afthdXDEjN94=
X-Received: by 2002:a92:d402:: with SMTP id q2mr4101222ilm.172.1586507774870;
 Fri, 10 Apr 2020 01:36:14 -0700 (PDT)
MIME-Version: 1.0
References: <1586353607-32222-1-git-send-email-rnayak@codeaurora.org>
 <1586353607-32222-3-git-send-email-rnayak@codeaurora.org> <20200409174511.GS199755@google.com>
In-Reply-To: <20200409174511.GS199755@google.com>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Fri, 10 Apr 2020 16:36:03 +0800
Message-ID: <CABymUCNdX=K1vFuC0Rt-u0h-CRYcKtXogyOkAiGZpDfKSVAYqA@mail.gmail.com>
Subject: Re: [PATCH 02/21] tty: serial: qcom_geni_serial: Use OPP API to set
 clk/perf state
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, sboyd@kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-serial@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> > @@ -961,7 +962,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
> >               goto out_restart_rx;
> >
> >       uport->uartclk = clk_rate;
> > -     clk_set_rate(port->se.clk, clk_rate);
> > +     dev_pm_opp_set_rate(uport->dev, clk_rate);

Hi Rajendra,

I see lowest rpmhpd_opp_low_svs opp is for 75MHz. It is a bit higher
for a serial.
I am just curious about this.

I also want to confirm that the rpmhpd_opp_low_svs voltage restriction
is for serial
controller, not for clock controller? Because I see there is similar
restriction to clock
controller on another platform, the restriction is for branch clock,
not leaf clock that
consumer device will get.

Jun
