Return-Path: <SRS0=EuFA=BA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469C4C433E6
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 08:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244652080D
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 08:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X9SVl1no"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgGUInh (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbgGUIng (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jul 2020 04:43:36 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215F8C0619D8
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 01:43:36 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id l6so9950116plt.7
        for <linux-serial@vger.kernel.org>; Tue, 21 Jul 2020 01:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=LDyYq7mGwU/io/5kwm3whsJhqDFrwNw4M+0gHu2yWNM=;
        b=X9SVl1noxhxAJSxVLxnUk8o/KVL6aNK/lBRqGdm26YT8FAGcP40UJUB4BB2eG9FC9R
         7cY73a/L9bOTX3FMGx+9yNjqfED2E3hwadYVHTGyX9aEqhrcpcKsT8Q7Gykux3FwOouw
         2QGN+kC97nd84cz5yCXtzKOKY+5Dy6TvR83fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=LDyYq7mGwU/io/5kwm3whsJhqDFrwNw4M+0gHu2yWNM=;
        b=ndnsgGhTA1piF23qJCFHHFtlHX8Hi9DEOmg+9DGCRabihrzNPzN40TF0HP5GYvwcK7
         744VY/Ct5HVFb3W7XPofR4LzLOcCuBXDkguS0AIoFUJ6A5UfU8HTzOXrn14QX0uf+WXw
         YiGFeMb+1rMOEt6nr4FIRXX16NdSPK4rWG4GgcVJT1cBuRMrDk55jB3jCbuFwwOvslC0
         B2khxFioCkbiGLW+B4q+2PWSyLB05CrD4S5ze9vDmLJYGUyhRfaxgoohZS0oKJy/SdcC
         hwf7qKhfBxfLt4rNvWjeJoQF3MI0akJ9aA6MXUidXfY2u1nmR2EAFZaF+S1VViE1Jq91
         vI6g==
X-Gm-Message-State: AOAM533Lx4QgB1zrzClQ9LxsscEtzUSV2YbgMhYOnE+4jDPiqcSvuIGP
        QRZZx+cLdOnwpaGZxyns7pCg1g==
X-Google-Smtp-Source: ABdhPJy4aKFmpB5Dgc+0DC8B10/KpMNM/Ag1dR6K/OxvywuhrosN4V4qOP35QJiccdOAUxzwf8dn0g==
X-Received: by 2002:a17:90a:6888:: with SMTP id a8mr3579090pjd.59.1595321015512;
        Tue, 21 Jul 2020 01:43:35 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id r191sm19920333pfr.181.2020.07.21.01.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 01:43:34 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200630030552.cfp5oh33qde6nlnf@vireshk-i7>
References: <1592222564-13556-1-git-send-email-rnayak@codeaurora.org> <1592222564-13556-2-git-send-email-rnayak@codeaurora.org> <159347264530.1987609.11350620235820019545@swboyd.mtv.corp.google.com> <a3d53f82-b29d-97ef-3ba1-ca9bd650d354@codeaurora.org> <20200630030552.cfp5oh33qde6nlnf@vireshk-i7>
Subject: Re: [PATCH v6 1/6] tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        robdclark@chromium.org, robdclark@gmail.com,
        stanimir.varbanov@linaro.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-serial@vger.kernel.org
To:     Rajendra Nayak <rnayak@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Date:   Tue, 21 Jul 2020 01:43:33 -0700
Message-ID: <159532101373.3847286.9695594340556014384@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting Viresh Kumar (2020-06-29 20:05:52)
> On 30-06-20, 08:31, Rajendra Nayak wrote:
> >=20
> >=20
> > On 6/30/2020 4:47 AM, Stephen Boyd wrote:
> > > Quoting Rajendra Nayak (2020-06-15 05:02:39)
> > > > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/se=
rial/qcom_geni_serial.c
> > > > index 457c0bf..a90f8ec 100644
> > > > --- a/drivers/tty/serial/qcom_geni_serial.c
> > > > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > > > @@ -9,6 +9,7 @@
> > > >   #include <linux/module.h>
> > > >   #include <linux/of.h>
> > > >   #include <linux/of_device.h>
> > > > +#include <linux/pm_opp.h>
> > > >   #include <linux/platform_device.h>
> > > >   #include <linux/pm_runtime.h>
> > > >   #include <linux/pm_wakeirq.h>
> > > > @@ -962,7 +963,7 @@ static void qcom_geni_serial_set_termios(struct=
 uart_port *uport,
> > > >                  goto out_restart_rx;
> > > >          uport->uartclk =3D clk_rate;
> > > > -       clk_set_rate(port->se.clk, clk_rate);
> > > > +       dev_pm_opp_set_rate(uport->dev, clk_rate);
> > >=20
> > > If there isn't an OPP table for the device because it is optional then
> > > how can we unconditionally call dev_pm_opp_set_rate()?
>=20
> Looks like some *Maintainers* aren't paying enough attention lately ;)
>=20
> Just kidding.
>=20

It seems that dev_pm_opp_set_rate() calls _find_opp_table() and finds
something that isn't an error pointer but then dev_pm_opp_of_add_table()
returns an error value because there isn't an operating-points property
in DT. We're getting saved because this driver also happens to call
dev_pm_opp_set_clkname() which allocates the OPP table a second time
(because the first time it got freed when dev_pm_opp_of_add_table()
return -ENODEV because the property was missing).

Why do we need 'has_opp_table' logic? It seems that we have to keep
track of the fact that dev_pm_opp_of_add_table() failed so that we don't
put the table again, but then dev_pm_opp_set_clkname() can be called
to allocate the table regardless.

This maintainer is paying very close attention to super confusing code like
this:

	if (drv->has_opp_table)
		dev_pm_opp_of_remove_table(dev);
	dev_pm_opp_put_clkname(drv->opp_table);

which reads as "if I have an opp table remove it and oh by the way
remove the clk name for this opp table pointer I also happen to always
have".

Maybe I would be happier if dev_pm_opp_of_table() went away and we just
had dev_pm_opp_add_table(const struct opp_config *config) that did all
the things for us like set a clk name, set the supported hw, set the
prop name, etc. based on the single config struct pointer and also
parsed out the OPP table from DT or just ignored that if there isn't any
operating-points property. Then the caller wouldn't need to keep track
of 'if has_opp_table' because it doesn't seem to actually care and the
core is happy to allocate a table for the device anyway so long as it
sets a clk name.
