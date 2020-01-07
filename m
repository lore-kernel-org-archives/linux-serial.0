Return-Path: <SRS0=kbyA=24=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F14C33C99
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jan 2020 06:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620EE206DB
	for <linux-serial@archiver.kernel.org>; Tue,  7 Jan 2020 06:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QSGhNupf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbgAGGOv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 7 Jan 2020 01:14:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39180 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgAGGOv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 7 Jan 2020 01:14:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id g6so19828949plp.6
        for <linux-serial@vger.kernel.org>; Mon, 06 Jan 2020 22:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c6QXHS052iNsuIcjpN4bnLChFsKKhsioLgwWXnYkKvQ=;
        b=QSGhNupfONtSc/6jcEnspB0SQLN2n42PJgRuFT0ph2HgXETbOsw/xTm5Z0F4JhqlaT
         e+VUjqYCghs86YIo3TVviF3cifm5oPLD2zbe9zQaKLSPO7lExFgMeEyQcFaa63HodSyA
         9VNEDvwkiXOyqMyo7K4f/MGpWFYzgxF5vXYNa+Td2OCk39s7mLQou9QTwE/u4IsM8rTY
         +WUzQGR6FYYkiw6S5qJo4SmWohqyxc00m23mdm0irmwYaOhbIrV5xnxwG7uqVuiJiyoe
         D0UD1DtYa6XYwlUcUNv4i6wH9cTu9VJnCAaPfa15+/UdEyGOZiH/Q00OUr1zJQx3RAvm
         8MGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c6QXHS052iNsuIcjpN4bnLChFsKKhsioLgwWXnYkKvQ=;
        b=mJrX2Irff5XwUrnQjl1VV864Zy2ztSPsFxTwyhqfmCa48vwW/0lzW6WjQLtHCgV4Ac
         hp20c+Z4AlcwNB2lyWrKd4x21eBJvbCHK3Rl6us1XP5tDxUV+ab9xv5b4TV/qsRBAXWn
         +ZSCqAUaO1vxLWTGxObaFB2OVsTqSaKta7D8N0LwpSbt6l6cEyfEXhtUYyZcTMAOIyby
         CmedqFb5YAK0/3iZtSmux+/+fB6yEp8tJ21irJxryT7GoyOE3DDjoIs6CvlBCVgEg+za
         LYOMLF5U4vqLnzBSw0WosG71qixBDAFHFHVMDO4FY56nWPlaRweArV+kb47WqW5NBZo4
         gIrA==
X-Gm-Message-State: APjAAAXDAPAhEj3sOC6q0ZqGjaKq31HJnijlTG9KSKEqwEYUu0iE5ax9
        q3yV/dwKGgWl5txD5lt6ujxHBg==
X-Google-Smtp-Source: APXvYqxdQ1ykKFXcMVH1BRiUcRNji3NKUHPQtynSOTPjo/KB8eiFeY14gaDELdnrqKQc8w2SPofJNg==
X-Received: by 2002:a17:902:a70d:: with SMTP id w13mr110125921plq.172.1578377690462;
        Mon, 06 Jan 2020 22:14:50 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b128sm75178035pga.43.2020.01.06.22.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 22:14:49 -0800 (PST)
Date:   Mon, 6 Jan 2020 22:14:47 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Alistair Delva <adelva@google.com>,
        Amit Pundir <amit.pundir@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/2] tty: serial: Kconfig: Allow SERIAL_QCOM_GENI_CONSOLE
 to be enabled if SERIAL_QCOM_GENI is a module
Message-ID: <20200107061447.GB716784@yoga>
References: <20200107010311.58584-1-john.stultz@linaro.org>
 <20200107010311.58584-2-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107010311.58584-2-john.stultz@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon 06 Jan 17:03 PST 2020, John Stultz wrote:

> In order to support having SERIAL_QCOM_GENI as a module while
> also still preserving serial console support, tweak the
> Kconfig requirements to not require =y
> 
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Alistair Delva <adelva@google.com>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Cc: Amit Pundir <amit.pundir@linaro.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-serial@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/tty/serial/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 99f5da3bf913..4ca799198e88 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -975,7 +975,7 @@ config SERIAL_QCOM_GENI
>  
>  config SERIAL_QCOM_GENI_CONSOLE
>  	bool "QCOM GENI Serial Console support"
> -	depends on SERIAL_QCOM_GENI=y
> +	depends on SERIAL_QCOM_GENI
>  	select SERIAL_CORE_CONSOLE
>  	select SERIAL_EARLYCON
>  	help
> -- 
> 2.17.1
> 
