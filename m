Return-Path: <SRS0=aNI9=ZO=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E819C432C3
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 18:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177F92071C
	for <linux-serial@archiver.kernel.org>; Fri, 22 Nov 2019 18:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="adtUzSvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfKVSqV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 22 Nov 2019 13:46:21 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35873 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfKVSqV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 22 Nov 2019 13:46:21 -0500
Received: by mail-pj1-f66.google.com with SMTP id cq11so3401898pjb.3
        for <linux-serial@vger.kernel.org>; Fri, 22 Nov 2019 10:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9XnDb7Q/IygLgTSRY7SeZwvkE08Zst4cGrNTkzkS96o=;
        b=adtUzSvCsWX468rx5R8F7PruMHga/0PUW/ZE3rqPEUxn/YxLoh/JKlMiy9+nZ4XhCj
         6jqSdenfcrsTGyG+hYUE7GJpzq8RKsyU+3vguQ+JT40Xx/BRPhxR5hNa9tvKYAQJJEmx
         ug2U1ijvy9ktHQKXm0Q8wKNrkpfiA26bGEy08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9XnDb7Q/IygLgTSRY7SeZwvkE08Zst4cGrNTkzkS96o=;
        b=oC8PYHJzTKG9qD5gU4YokqAaFEFeX3IouUdHA23eUh1m0XTahiUjqfXY3tXZjqQEI0
         EVFam0VQ/GnwElAvFqvXi2+hy3dw0boKpniRPasTY3wcfxf25ZDlfIkEsVzbiaTIBt8F
         M2n0BgdlcFcv+apNpFe57Ka6AD6DB1L130hh65QcunSzQiXadrwsR/cisdLv36hiutwi
         bqMUFiVNUAPWT5uIMAq8BnIL1dNCtH38nLmhp82I7qPy7qTu8SAqVIy7+Whse8YQbVLo
         1u6xrJOfla3tj5T6CNPd0L91uwicvv59fii8OTv94S2SaM1Tjy6qNlMeXfu8DBj4twul
         XapA==
X-Gm-Message-State: APjAAAXYy7yJMVZNsOnYt3EUM/6yVKTVvKRlH0s/aOqShPn8gqsE8SGD
        6Y6bWRIgqNOjJG/RAudILOGfN6igYmI=
X-Google-Smtp-Source: APXvYqxdSCDY1pz30iWJARX7yjsOYRJC+q3IVnarA7giUUrnGrvRUXePwiklSmlBDTvlpPAVjwIaAg==
X-Received: by 2002:a17:902:b945:: with SMTP id h5mr15631521pls.291.1574448380152;
        Fri, 22 Nov 2019 10:46:20 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id z1sm3893020pju.27.2019.11.22.10.46.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2019 10:46:19 -0800 (PST)
Date:   Fri, 22 Nov 2019 10:46:18 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Akash Asthana <akashast@codeaurora.org>
Cc:     gregkh@linuxfoundation.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 3/5] tty: serial: qcom_geni_serial: IRQ cleanup
Message-ID: <20191122184618.GN27773@google.com>
References: <1574432266-20732-1-git-send-email-akashast@codeaurora.org>
 <0101016e937a3e05-f74c5c73-a964-45f2-ae71-6daed292e8ee-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0101016e937a3e05-f74c5c73-a964-45f2-ae71-6daed292e8ee-000000@us-west-2.amazonses.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Nov 22, 2019 at 02:18:12PM +0000, Akash Asthana wrote:
> Move ISR registration from startup to probe function to avoid registering
> it everytime when the port open is called for driver.
> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
> Changes in v6:
>  - Rebased on tty-next branch
> 
> Changes in v5:
>  - No change.
> 
> Changes in v4:
>  - As per Stephen's comment, move ISR registration(later in probe) after
>    registering uart port with serial core.
>  - As per Greg's comment, corrected returning of PTR value from integer type
>    function(probe).
> 
> Changes in v3:
>  - As per Stephen's comment, using devm_kasprintf instead of scnprintf API.
> 
>  drivers/tty/serial/qcom_geni_serial.c | 38 ++++++++++++++++++++++++-----------
>  1 file changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 14c6306..634054a 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
>
> ...
>
> @@ -1307,7 +1307,21 @@ static int qcom_geni_serial_probe(struct platform_device *pdev)
>  	port->handle_rx = console ? handle_rx_console : handle_rx_uart;
>  	if (!console)
>  		device_create_file(uport->dev, &dev_attr_loopback);
> -	return uart_add_one_port(drv, uport);
> +
> +	ret = uart_add_one_port(drv, uport);
> +	if (ret)
> +		return ret;
> +
> +	irq_set_status_flags(uport->irq, IRQ_NOAUTOEN);
> +	ret = devm_request_irq(uport->dev, uport->irq, qcom_geni_serial_isr,
> +			IRQF_TRIGGER_HIGH, port->name, uport);
> +	if (ret) {
> +		dev_err(uport->dev, "Failed to get IRQ ret %d\n", ret);
> +		uart_remove_one_port(drv, uport);
> +		return ret;

nit: could fall through

> +	}
> +
> +	return ret;

nit: if not falling through above this could/should be 0.

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
