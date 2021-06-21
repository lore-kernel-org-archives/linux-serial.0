Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E5EC4743C
	for <linux-serial@archiver.kernel.org>; Mon, 21 Jun 2021 21:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32B8611BD
	for <linux-serial@archiver.kernel.org>; Mon, 21 Jun 2021 21:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhFUVqm (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 21 Jun 2021 17:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhFUVqm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 21 Jun 2021 17:46:42 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD06C061574
        for <linux-serial@vger.kernel.org>; Mon, 21 Jun 2021 14:44:26 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id s17so12728007oij.11
        for <linux-serial@vger.kernel.org>; Mon, 21 Jun 2021 14:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LQSQLsbU1k/DyH0v6dn2m/gWT8qIlpUZpsIbjBaYE5w=;
        b=fxUMo5xt2LO0NwqKooOZdVzGR8tQRpnw1YNIxP2A2HY/fFYXbkIkGwCko2edjNw/Yr
         VDghk1Lm5WbS7sbrwgprcozeFZLTTN3q0/1UAd8sO9p+fCErTa8jYPzIUpsnV4Pup2c+
         B4aNeLKFYJAPUV1AMmCMxjFIohm47sHcmZYJNiGmzMZ+y1396Nd5BBV+MazYUnEdm6Ia
         aTICxFEAGYfricTEXxX2JeiAtJdWKjYYgFE+w/DYTXo2DvAsKVx7ReqeU7o+dy1hdCTG
         4wi4gDwqSSJJ+0IVbNY9UqhSQk1JmTh/WCqG9lbphUQJofnt0Cfw8mpXbwWjRM3/7FaV
         CTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LQSQLsbU1k/DyH0v6dn2m/gWT8qIlpUZpsIbjBaYE5w=;
        b=E+R86GlQVEgQ5ahmezi+Uaco4XfUV/L1J3s+OXnHpW2ALIhBCmX/6E8MEdNpOXVmDa
         Kho9j6aO+TjtGDDb7sFfwrI+ZvQ6QQ77GdpSvxBiZ/IVXVpFBhP6kB7QqttOkKHQt7WS
         rLvuQ9QPsp6oORbjX7hp4JT3qm33kATN2sY9dD4paApRnDt18bMXYyGKyeN00DwzCAKH
         sK5fo5ScsvapogfyHKtj1Owq5I6r7d8iFkouHTs7KLINJ3dyreptLRzj+JzEgti6yxfs
         EJF7/ZpQgMXaKG8BtGRU+kr0Tmrtn6A4A76156AcJZqaoyMjfAeUUZsSf6OZVt6e0CDZ
         uRRQ==
X-Gm-Message-State: AOAM530b2phvTBuu8ubGDKmzIv4VqB3yuCKdPTq7FVogxvKW3eaA9RKQ
        sf2HSMpT+0cevCQO06wZrc1v4w==
X-Google-Smtp-Source: ABdhPJxvYszHkbewbuCMsZuaCb0tu00QkdTkmqmIa/tlDp41W9XCj/I1dfXxDmYlQ54lVbFkyJhDMg==
X-Received: by 2002:a54:460a:: with SMTP id p10mr421190oip.47.1624311866147;
        Mon, 21 Jun 2021 14:44:26 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id v203sm3889046oib.37.2021.06.21.14.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 14:44:25 -0700 (PDT)
Date:   Mon, 21 Jun 2021 16:44:23 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] serial: qcom_geni_serial: use DT aliases according to DT
 bindings
Message-ID: <YNEINzRmyn6bBQ9n@yoga>
References: <20210621211528.1607516-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621211528.1607516-1-dmitry.baryshkov@linaro.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon 21 Jun 16:15 CDT 2021, Dmitry Baryshkov wrote:

> Device tree bindings do not specify "hsuart" aliases, instead all serial
> ports should use "serial" alias name as noted by Rob Herring [1].
> Make qcom_geni_serial driver use "serial" alias and fallback to "hsuart"
> if one is not found.
> 
> [1] https://lore.kernel.org/linux-arm-msm/6dd1f5cd-03c7-5945-9fa2-1c2698405110@linaro.org/
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/tty/serial/qcom_geni_serial.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 23d729ed3bf6..85f1c1f96597 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1354,7 +1354,9 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  		line = of_alias_get_id(pdev->dev.of_node, "serial");
>  	} else {
>  		drv = &qcom_geni_uart_driver;
> -		line = of_alias_get_id(pdev->dev.of_node, "hsuart");
> +		line = of_alias_get_id(pdev->dev.of_node, "serial");
> +		if (line == -ENODEV) /* compat with non-standard aliases */
> +			line = of_alias_get_id(pdev->dev.of_node, "hsuart");
>  	}
>  
>  	port = get_port_from_line(line, console);
> -- 
> 2.30.2
> 
