Return-Path: <SRS0=iYMu=4J=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0208C11D27
	for <linux-serial@archiver.kernel.org>; Fri, 21 Feb 2020 00:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67BD24654
	for <linux-serial@archiver.kernel.org>; Fri, 21 Feb 2020 00:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RC1y9Ev8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgBUAYD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:24:03 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41826 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729484AbgBUAYD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Feb 2020 19:24:03 -0500
Received: by mail-pl1-f195.google.com with SMTP id t14so103101plr.8
        for <linux-serial@vger.kernel.org>; Thu, 20 Feb 2020 16:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N+W2ETEjDh4VNtgtmLh/TfEkNqYr/Dj+9ajtDJm9neY=;
        b=RC1y9Ev8yYPshv4Bs732//4TwtEKj4z/RU6pjfL30nYLsKEse7Ahw4+tlJLRCJcYPi
         QHtBOyv+Qik/4Nn8QKBRwMA1A2R4jCmYA0rQDE6KXO24k4yzHT0fiCIEnPMExEWZiWXA
         ag7DzPHT64h0fZaJAQjYG6clhowVsW+2rW6h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N+W2ETEjDh4VNtgtmLh/TfEkNqYr/Dj+9ajtDJm9neY=;
        b=ebBvHmIWrxMxn2OkoLBMAhcKz4FYrzV57ONE8zFWfTWpdSCoGG7SRFf/99ZUNZejPb
         U9InglvI5APeaJ9ApW1tj0BtQYR9cGZytVQdZ8ShMdlxDSTLnQa3e2bVu/5jguJVe9Ot
         EiXzFdcy2YE7sJ8iNogPr2I6XOC1s84A+IrFhnGKYgOGWNihBMR3rtZUlghMF1HMwd4p
         sx9lNem0+G/VnU5ovNsTDLTIPaj9E0/v+bDAowMmIKqz0Us4BbcM0OoQF7yk0sDgLnXQ
         i/ay9QDkGyaZS8QDHfT6ypnkzJguu3vZQnOlvZIuRA/u3PHldzezFaWdwGoqzL2LOHXE
         7DcA==
X-Gm-Message-State: APjAAAUmQHkWCnemPCUeKngVsRK3XsKvWVyf0MDMrkSLgbRx9/1BaA4c
        vYrgs8IMUuxRNTBUMDueOKEOFg==
X-Google-Smtp-Source: APXvYqyocUfmVHntXz0Jeoqt9gMILke4bXLLeHZVx9N6jDKA2rov2r0w1ZLTo07S4ZMWTAhuiB+C2Q==
X-Received: by 2002:a17:902:9a4c:: with SMTP id x12mr32244576plv.297.1582244642055;
        Thu, 20 Feb 2020 16:24:02 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id f127sm726701pfa.112.2020.02.20.16.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 16:24:01 -0800 (PST)
Date:   Thu, 20 Feb 2020 16:24:00 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, dianders@chromium.org
Subject: Re: [PATCH 3/6] i2c: i2c-qcom-geni: Add interconnect support
Message-ID: <20200221002400.GD24720@google.com>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
 <1581946205-27189-4-git-send-email-akashast@codeaurora.org>
 <20200218224709.GF15781@google.com>
 <84a7d97a-4e10-5509-9c87-af8a545c7385@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <84a7d97a-4e10-5509-9c87-af8a545c7385@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Akash,

On Wed, Feb 19, 2020 at 07:17:44PM +0530, Akash Asthana wrote:
> Hi Matthias,
> 
> On 2/19/2020 4:17 AM, Matthias Kaehlcke wrote:
> > On Mon, Feb 17, 2020 at 07:00:02PM +0530, Akash Asthana wrote:
> > > Get the interconnect paths for I2C based Serial Engine device
> > > and vote according to the bus speed of the driver.
> > > 
> > > Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> > > ---
> > >   drivers/i2c/busses/i2c-qcom-geni.c | 84 ++++++++++++++++++++++++++++++++++++--
> > >   1 file changed, 80 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> > > index 17abf60c..5de10a1 100644
> > > --- a/drivers/i2c/busses/i2c-qcom-geni.c
> > > +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> > >
> > >   static void geni_i2c_err_misc(struct geni_i2c_dev *gi2c)
> > >   {
> > >   	u32 m_cmd = readl_relaxed(gi2c->se.base + SE_GENI_M_CMD0);
> > > @@ -563,17 +601,34 @@ static int geni_i2c_probe(struct platform_device *pdev)
> > >   	gi2c->adap.dev.of_node = pdev->dev.of_node;
> > >   	strlcpy(gi2c->adap.name, "Geni-I2C", sizeof(gi2c->adap.name));
> > > +	ret = geni_i2c_icc_get(&gi2c->se);
> > > +	if (ret)
> > > +		return ret;
> > > +	/* Set the bus quota to a reasonable value */
> > > +	gi2c->se.avg_bw_core = Bps_to_icc(1000);
> > > +	gi2c->se.peak_bw_core = Bps_to_icc(CORE_2X_100_MHZ);
> > > +	gi2c->se.avg_bw_cpu = Bps_to_icc(1000);
> > > +	gi2c->se.peak_bw_cpu = Bps_to_icc(1000);
> > > +	gi2c->se.avg_bw_ddr = Bps_to_icc(gi2c->clk_freq_out);
> > > +	gi2c->se.peak_bw_ddr = Bps_to_icc(2 * gi2c->clk_freq_out);
> > > +
> > > +	/* Vote for core clocks and CPU for register access */
> > > +	icc_set_bw(gi2c->se.icc_path[GENI_TO_CORE], gi2c->se.avg_bw_core,
> > > +				gi2c->se.peak_bw_core);
> > > +	icc_set_bw(gi2c->se.icc_path[CPU_TO_GENI], gi2c->se.avg_bw_cpu,
> > > +				gi2c->se.peak_bw_cpu);
> > error handling needed?
> 
> I will add error handling for GENI_TO_CORE path in all the drivers. Will it
> be okay if we don't handle errors for CPU_TO_GENI and GENI_TO_DDR path
> 
> as CPU and DDR will be running at much higher frequency?

It may still work, but you might never know that there was a problem. I
would be inclined to check the return value of all invocations of icc_set_bw()
- including runtime suspend/resume - and log a message if a problem is
detected. For runtime suspend/resume it would probably be wise to use
dev_err_ratelimited(), to avoid spamming the system log too much in case of
a persistent problem.

If others think that error checking all icc_set_bw() calls is overkill
please speak up :)

Thanks

Matthias
