Return-Path: <SRS0=JuT/=6L=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF932C5519A
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 16:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CAA92080C
	for <linux-serial@archiver.kernel.org>; Mon, 27 Apr 2020 16:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PW927SF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgD0QsV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgD0QsV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Apr 2020 12:48:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183D9C09B050
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2020 09:48:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so383759wmh.3
        for <linux-serial@vger.kernel.org>; Mon, 27 Apr 2020 09:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V2IKgBBGeWQaS3nKENTTI6oYzwqYmWY3/5vxajcyiRg=;
        b=PW927SF/uC1q91VoVVYQ+1pXnGZTfNMH4wSEMOjVR2xohzu4yp9PaN8dJxdTffySOX
         Xg90snZYIfR+VLNbsD+aeBooFQY9hW3NEw/9WC8Ikg8Ua3CdX9GPiZdqolNYOZDjbOgW
         8nMoVwWgXPDSdBzjyuD773mLMsMK2wxXf5mig/QQUsR9SZEmYcZxvhi1gOQNi/fBDetD
         M2sOiHVkryGE0+k9XDDGVVwPrq/CFRbfFGAFfPhRys7RrcFrr1jI8b4rEFcrFjBdPlG+
         ClCJmIQPMDJNb+VxjUwfW0rLYaSZQtSlHUpG3wiJ9Of7PaDg2cLwtlVdadaEVGFXiIoU
         E5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V2IKgBBGeWQaS3nKENTTI6oYzwqYmWY3/5vxajcyiRg=;
        b=AzIOSaaadBwOvzS1c2S1As3WuXGxO1cTVlgtmxgPRSh6r3mtY0QbGT8fXvrMsX/Ft5
         XaI34PNUa4H4ZrmRyjmZkJXtCdPn8K32eTuJ9ob1ZgJqHVMSv6RfjPWsFwoXqOV0HekY
         lC2M/ay52bU80fwWQsJyQExjIjhKGTFNaZC9OIrd73WfKJRi8mJIFWVthF1PYkoCybSo
         d9ofrp1kG22hLWJ1a8/uGO3uEzaum5Xx0B5mKXplQABGqAhfemBE9/OCepiIPxMC4E1z
         z9RNOVQ4dEu3ct63o1iKByVPmJKZD2zMf7eXOXYL2vJ73QcABEItyVvb1W1ZB5YDN3Mg
         TICQ==
X-Gm-Message-State: AGi0PuZTtfBRyK2DckOK3UjgwBikvU++hKf8hqoFV8EikMycYGhFsag4
        biAlqs1dZs8W2tHIB5jbGxwA/Q==
X-Google-Smtp-Source: APiQypKZLllr/ppZ5WEDGUG/MlZ92mT/85cNLs+v4f8ofGxIckLH3GUuN5fThqZIftzZJCB3DKPn+Q==
X-Received: by 2002:a1c:ba09:: with SMTP id k9mr387758wmf.176.1588006098658;
        Mon, 27 Apr 2020 09:48:18 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id r20sm15553355wmh.26.2020.04.27.09.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 09:48:18 -0700 (PDT)
Date:   Mon, 27 Apr 2020 17:48:16 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        kgdb-bugreport@lists.sourceforge.net, mingo@redhat.com,
        hpa@zytor.com, bp@alien8.de, linux-serial@vger.kernel.org,
        agross@kernel.org, tglx@linutronix.de, frowand.list@gmail.com,
        bjorn.andersson@linaro.org, jslaby@suse.com,
        catalin.marinas@arm.com, corbet@lwn.net, will@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] serial: qcom_geni_serial: Support earlycon_kgdboc
Message-ID: <20200427164816.j4xqw3vvlgoqkmx7@holly.lan>
References: <20200421211447.193860-1-dianders@chromium.org>
 <20200421141234.v2.8.If2deff9679a62c1ce1b8f2558a8635dc837adf8c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421141234.v2.8.If2deff9679a62c1ce1b8f2558a8635dc837adf8c@changeid>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Apr 21, 2020 at 02:14:46PM -0700, Douglas Anderson wrote:
> Implement the read() function in the early console driver.  With
> recent kgdb patches this allows you to use kgdb to debug fairly early
> into the system boot.
> 
> We only bother implementing this if polling is enabled since kgdb
> can't be enabled without that.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Changes in v2: None
> 
>  drivers/tty/serial/qcom_geni_serial.c | 32 +++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index 6119090ce045..4563d152b39e 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1090,6 +1090,36 @@ static void qcom_geni_serial_earlycon_write(struct console *con,
>  	__qcom_geni_serial_console_write(&dev->port, s, n);
>  }
>  
> +#ifdef CONFIG_CONSOLE_POLL
> +static int qcom_geni_serial_earlycon_read(struct console *con,
> +					  char *s, unsigned int n)
> +{
> +	struct earlycon_device *dev = con->data;
> +	struct uart_port *uport = &dev->port;
> +	int num_read = 0;
> +	int ch;
> +
> +	while (num_read < n) {
> +		ch = qcom_geni_serial_get_char(uport);
> +		if (ch == NO_POLL_CHAR)
> +			break;
> +		s[num_read++] = ch;
> +	}
> +
> +	return num_read;
> +}
> +
> +static void __init qcom_geni_serial_enable_early_read(struct geni_se *se,
> +						      struct console *con)
> +{
> +	geni_se_setup_s_cmd(se, UART_START_READ, 0);
> +	con->read = qcom_geni_serial_earlycon_read;
> +}
> +#else
> +static inline void qcom_geni_serial_enable_early_read(struct geni_se *se,
> +						      struct console *con) { ; }

This is pure nitpicking but since I was passing... why the ; ?


Daniel.
