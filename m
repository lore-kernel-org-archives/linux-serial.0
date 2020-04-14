Return-Path: <SRS0=CAPS=56=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA9EC2BB1D
	for <linux-serial@archiver.kernel.org>; Tue, 14 Apr 2020 05:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E5D206E9
	for <linux-serial@archiver.kernel.org>; Tue, 14 Apr 2020 05:26:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IYW4YTrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405498AbgDNF0f (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Apr 2020 01:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405495AbgDNF0e (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Apr 2020 01:26:34 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52865C008748
        for <linux-serial@vger.kernel.org>; Mon, 13 Apr 2020 22:26:34 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i7so15378190edq.3
        for <linux-serial@vger.kernel.org>; Mon, 13 Apr 2020 22:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uuPdzsYrCELKJnGVxoANM1PIXJOyrUjt5nhJHbZTcKo=;
        b=IYW4YTrYfy+kuwOU/lYSO3bgdbsS6ahDQGbWQz2pVXyf3gpqKiVGpSqAGXtloLGD2M
         WA6XxacLcQak2MEzhhTV0X5U/dR3yiLyx5qEePcdC4cRvL0T7jdFdGi3CGg8DESOCPws
         lsm3aaw0P2r+rWFW6Jf015OyCD5/EKke57c2kACRLYYaHvTXrpOJn8pSD0QXt63mP9H2
         NunKHb4PkJIIeZPyu3B0BstWYB74PnnGOaUD6TXxgbVwrVMYLY1FJV/Hp2oxnAh234Zl
         xFnItRaPtPJptW3rvZuQD06WVCaVjjK96ry+TXpdxrM5IgHrbsgb77anjgstT6SY1QLw
         ZSug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uuPdzsYrCELKJnGVxoANM1PIXJOyrUjt5nhJHbZTcKo=;
        b=Bfoko25IlEpmc2WJmsux4QDi3ee8192uSVyIfCe5fe/L3Rol6Qtw/YDH3RibDcgh/g
         oqXt9OMH1cKkQG9Sfo4VQhWAhS1SrX3hfG/7mX894i7L31BLMXz30bhKCW3yFSmC6mzG
         HfZaF6EM2tm4HE82FcbRygTrnS0BmTlVOIp8hAkgVxzd2WGReSxakNSh5U5V2QEWUfsB
         RRX4IpnPTEdWuPIonS0uOUqEwNFFMPOwh4uVd3WD/kDixXVmoVRCDdvjexVagomW03zf
         NygLJnDGF4CY1/GbOFS+VZlJYdT5bUGSZ2E729ayiSOSTYLZ5JXnEy+tsAHii0ZJND5y
         mHpw==
X-Gm-Message-State: AGi0PuZdE44kRrb0teFED3Ow0n1qPnRwokA6InePuYHAJVe1RnQ4enqn
        St+gNwbdcPgBozYBVQoL2yXguiEKLEsf2+/owM0BVg==
X-Google-Smtp-Source: APiQypI+OHSx7I0zAFNl0j3kM4YuBCc2AJy2aRhhIsVV8UZqht0LfkdSl9kXkAtfkBw1fMhlpmo+n7+6X8Ap0UyfKBQ=
X-Received: by 2002:a50:d71e:: with SMTP id t30mr969087edi.246.1586841992805;
 Mon, 13 Apr 2020 22:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <1586353607-32222-1-git-send-email-rnayak@codeaurora.org>
 <1586353607-32222-3-git-send-email-rnayak@codeaurora.org> <20200409174511.GS199755@google.com>
 <CABymUCNdX=K1vFuC0Rt-u0h-CRYcKtXogyOkAiGZpDfKSVAYqA@mail.gmail.com> <13907000-e3b0-12d6-0768-fd8a7ab100d9@codeaurora.org>
In-Reply-To: <13907000-e3b0-12d6-0768-fd8a7ab100d9@codeaurora.org>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Tue, 14 Apr 2020 13:26:21 +0800
Message-ID: <CABymUCM+WjSxKhhvqbBSxub_3wxvnJ8aOVgtWD9JOoxA3MuY2A@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Rajendra Nayak <rnayak@codeaurora.org> =E4=BA=8E2020=E5=B9=B44=E6=9C=8813=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8810:22=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
>
> On 4/10/2020 2:06 PM, Jun Nie wrote:
> >>> @@ -961,7 +962,7 @@ static void qcom_geni_serial_set_termios(struct u=
art_port *uport,
> >>>                goto out_restart_rx;
> >>>
> >>>        uport->uartclk =3D clk_rate;
> >>> -     clk_set_rate(port->se.clk, clk_rate);
> >>> +     dev_pm_opp_set_rate(uport->dev, clk_rate);
> >
> > Hi Rajendra,
>
> Hi Jun,
>
> > I see lowest rpmhpd_opp_low_svs opp is for 75MHz. It is a bit higher
> > for a serial.
> > I am just curious about this.
>
> Well these OPP tables are technically what we call as fmax tables, which =
means
> you can get the clock to a max of 75MHz at that perf level. You need to g=
o
> to the next perf level if you want to go higher.
> That however does not mean that serial cannot run at clocks lower than 75=
Mhz.
>
> > I also want to confirm that the rpmhpd_opp_low_svs voltage restriction
> > is for serial
> > controller, not for clock controller? Because I see there is similar
> > restriction to clock
> > controller on another platform, the restriction is for branch clock,
> > not leaf clock that
> > consumer device will get.
>
> yes, its a serial controller restriction and not of the clock provider.
> On your note on the branch clock vs leaf clock I am not sure I understand
> the point you are making.

For the leaf clock, I mean the clock that consumer get with devm_clk_get().=
 The
branch clock means it is not for consumer directly, and its child
clock or grandchild
clock is for consumer. In that case, the restriction has to be done in
clock driver,
not in clock consumer driver. Sorry for confusing you. I just want to
know more about
what function this patch set provide. Because I am working on the
clock controller
restriction of fmax/voltage. Thanks!

Jun
>
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
