Return-Path: <SRS0=da9C=AL=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA8AC433E0
	for <linux-serial@archiver.kernel.org>; Tue, 30 Jun 2020 03:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBDF420760
	for <linux-serial@archiver.kernel.org>; Tue, 30 Jun 2020 03:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="szix04EN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgF3DF5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 29 Jun 2020 23:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbgF3DF4 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 29 Jun 2020 23:05:56 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCB9C03E979
        for <linux-serial@vger.kernel.org>; Mon, 29 Jun 2020 20:05:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k1so7897402pls.2
        for <linux-serial@vger.kernel.org>; Mon, 29 Jun 2020 20:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cNEVQy+vICiaQ3dEMjEVUMkRw1CNp3UqW6ADGZMeyq0=;
        b=szix04ENS8s/vNMuSV9gmxw6eDA/gHtPJCmi32AKDZtmQTu3dznzhrEYphazqsUTuV
         SD1LuvDvVW4PVhTqNQR0lQ8s/bE0fcLUu7dY1F+4WnisN/0UIb6GE1KSfXBiM+j9ft7q
         3iBqr8MxTD6kVSOBAVKm7ROP5aQqjOLPul/cWyg6+21Z5+UFZU571T26GNGiF3nYrcef
         wtJU0UjEtuJI9OtB7V78h+IZIMC48jFdlYemLhceDJ8QUmUGJL+kxfIUgAFPz+omWvMn
         7fQszesv9mXKkojzECfYvnGnx0N2NU2b1Cj0u94tyqer7SKrGU4IIREFN0OHnge5CFUJ
         zE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cNEVQy+vICiaQ3dEMjEVUMkRw1CNp3UqW6ADGZMeyq0=;
        b=T+2NrPR6zVkpvJaSKzT2H3KKEr/rb6j/WT7RIjRqBHVRoLMAC21nl1AoapswQddFy9
         jV4qB4gBklE5Kg3JRZwhanT8VTtiGPdLM+UDSCCgn2ZWgZild+DQ+VjojqGVZi45Y7UE
         p+mx2b6VhmdVhUBGvQVuhfzeS5GZ9otGJQvTVKN7YQHv/YPojK+nJ4W1UBBcyfufJ71L
         ZrEDG9nvfA93i3Cpy1tMSeM8OT50E5IDm3ZOp2IVq+eFoPfBcTBk9OpTKdJzvqOHBSyf
         eoZNq7T5Ny0bK0BzJjSQTYD+DQ5szPoiWiVYnHinE3rG3vI1zAe1xTN/Z3+RHa/Nlg/l
         XCbQ==
X-Gm-Message-State: AOAM530fqQA6InA9l3pPDb0GrUSUJ5V0l986rPHCFYfe0Re17jtQ+dEM
        +3ncs2TwboEdSTF3HynfQKV+9w==
X-Google-Smtp-Source: ABdhPJwwYS9W4O4PrjOlLGBl4/OdVWJfaqDpaTLMqlG01WLme1r8xY9RSXQUaUY08Gft6qu0rVWgxg==
X-Received: by 2002:a17:90a:110:: with SMTP id b16mr7674307pjb.235.1593486354641;
        Mon, 29 Jun 2020 20:05:54 -0700 (PDT)
Received: from localhost ([122.172.127.76])
        by smtp.gmail.com with ESMTPSA id z2sm905277pfq.67.2020.06.29.20.05.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 20:05:54 -0700 (PDT)
Date:   Tue, 30 Jun 2020 08:35:52 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        robdclark@chromium.org, robdclark@gmail.com,
        stanimir.varbanov@linaro.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 1/6] tty: serial: qcom_geni_serial: Use OPP API to set
 clk/perf state
Message-ID: <20200630030552.cfp5oh33qde6nlnf@vireshk-i7>
References: <1592222564-13556-1-git-send-email-rnayak@codeaurora.org>
 <1592222564-13556-2-git-send-email-rnayak@codeaurora.org>
 <159347264530.1987609.11350620235820019545@swboyd.mtv.corp.google.com>
 <a3d53f82-b29d-97ef-3ba1-ca9bd650d354@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3d53f82-b29d-97ef-3ba1-ca9bd650d354@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 30-06-20, 08:31, Rajendra Nayak wrote:
> 
> 
> On 6/30/2020 4:47 AM, Stephen Boyd wrote:
> > Quoting Rajendra Nayak (2020-06-15 05:02:39)
> > > diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> > > index 457c0bf..a90f8ec 100644
> > > --- a/drivers/tty/serial/qcom_geni_serial.c
> > > +++ b/drivers/tty/serial/qcom_geni_serial.c
> > > @@ -9,6 +9,7 @@
> > >   #include <linux/module.h>
> > >   #include <linux/of.h>
> > >   #include <linux/of_device.h>
> > > +#include <linux/pm_opp.h>
> > >   #include <linux/platform_device.h>
> > >   #include <linux/pm_runtime.h>
> > >   #include <linux/pm_wakeirq.h>
> > > @@ -962,7 +963,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
> > >                  goto out_restart_rx;
> > >          uport->uartclk = clk_rate;
> > > -       clk_set_rate(port->se.clk, clk_rate);
> > > +       dev_pm_opp_set_rate(uport->dev, clk_rate);
> > 
> > If there isn't an OPP table for the device because it is optional then
> > how can we unconditionally call dev_pm_opp_set_rate()?

Looks like some *Maintainers* aren't paying enough attention lately ;)

Just kidding.

> because we have 'aca48b6 opp: Manage empty OPP tables with clk handle' to handle this.

-- 
viresh
