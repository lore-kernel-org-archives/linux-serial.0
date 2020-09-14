Return-Path: <SRS0=LhIc=CX=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E507AC43461
	for <linux-serial@archiver.kernel.org>; Mon, 14 Sep 2020 15:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D6FD20E65
	for <linux-serial@archiver.kernel.org>; Mon, 14 Sep 2020 15:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YttL+ZE8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgINPmU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Sep 2020 11:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgINPjm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Sep 2020 11:39:42 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F899C06178A
        for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2020 08:39:42 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id g10so304490otq.9
        for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2020 08:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jsQOlgmuW5ym+Pa5nus1EZIi7cRnYavzMa7ZkQUAfNI=;
        b=YttL+ZE88/4HT9qZqo1xUe6VqOTiG71d0Tx4vGcGQt3PL/lm3ZAs44vcRi8s3O5HGE
         mONQlRVEt/F5F5/NjGOq/B6xCx1Mfgyla/woq377uFZ+dT8/jmHOG2Yu1sMkh8Kh/QB+
         rmzs19u13bk5U+ZuAouLcjMjEWt4NQTVcW5l7b9bXLr10PaR2t2TBu+uEmcAoFqPuQFO
         CAjq4Ry7zFByt8zbyYN1fXeyu5clD5S4mVg+zVPQPgL1z/bonQSUA2SAkvJVQYcqLZ/v
         KDnmAYzO0H7nbfhIQbJ4sDhMpI0+GASjBRrbpU1ocPeddm2SVAvCbL2BdoaR4/MsB6hy
         KIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jsQOlgmuW5ym+Pa5nus1EZIi7cRnYavzMa7ZkQUAfNI=;
        b=cqOZvW9OJbv3tFeaU1iiH90PJcbPH4Ry1to3fxv9m209OPKg/I9++BwO9AZGivccvR
         WI1G62yGihgiBfOWUmXz52fMUfWZX+nzf30lzU7Q3B6jIl3f04RU2Tea3RiTP/iveC8Q
         om/0dxBZkWyYn0tsOnv14+gSOL1xd7SxqQqolZCNDhmApkRDTYhmd/9c5cwDxPSAxnrk
         W5f/myOtM0898Xys188XxolcM8iiezqOD8Zlk9BT9B0lkCcgnMUuT0QRQImCA67ZxMV9
         U9fhm0MoRxEdns0iDTXYiMDqnZyur7GW16lTcYW4zU2evk8Ylnuko72IMmFvzwyGnUNw
         0yvA==
X-Gm-Message-State: AOAM5334MuqId+6U9ei0ONUftg/5V3esLLjLgJ4ZCbLSI0X1wDzEyWDV
        CHBI1xxiFJwDaEpLYUO7IHbcFA==
X-Google-Smtp-Source: ABdhPJwFozRzSBv0WDdnzEu0BO/2gv8NycQjAuQPx4hBn62VsNQEpKguodTtgFEZ1OwjBvCY+XU/dg==
X-Received: by 2002:a9d:7841:: with SMTP id c1mr10013216otm.318.1600097981295;
        Mon, 14 Sep 2020 08:39:41 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
        by smtp.gmail.com with ESMTPSA id e30sm3496013otf.49.2020.09.14.08.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:39:40 -0700 (PDT)
Date:   Mon, 14 Sep 2020 10:39:35 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        robdclark@chromium.org, Akash Asthana <akashast@codeaurora.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        jwerner@chromium.org, Andy Gross <agross@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: 115.2 is a better console
 default than 9600
Message-ID: <20200914153935.GB3715@yoga>
References: <20200911080054.1.I4c00b921c2f17b6988688046fa7be0f729f8d591@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911080054.1.I4c00b921c2f17b6988688046fa7be0f729f8d591@changeid>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri 11 Sep 10:00 CDT 2020, Douglas Anderson wrote:

> Commit c5cbc78acf69 ("tty: serial: qcom_geni_serial: Initialize baud
> in qcom_geni_console_setup") fixed a bug by initting a variable that
> was used in some cases without initialization.  However, the "default"
> baud rate picked by that CL was probably not the best choice.  The
> chances that anyone out there is trying to run a system with kernel
> messages piped out over a 9600 baud serial port is just about nil.
> Console messages are printed in a blocking manner.  At 9600 baud we
> print about 1 character per millisecond which means that printing a
> 40-byte message to the console will take ~40 ms.  While it would
> probably work, it's going to make boot _very_ slow and probably cause
> the occasional timeout here and there in drivers (heck, even at 115200
> console delays can wreck havoc).
> 
> This has already bit at least two people that I'm aware of that tried
> to enable serial console by just adding "console=ttyMSM0" (instead of
> "console=ttyMSM0,115200n8") to the command line, so it seems like it'd
> be nice to fix.
> 
> Let's switch the default to 115200.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/tty/serial/qcom_geni_serial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index f0b1b47c3abc..e390ffc8bbbd 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1107,7 +1107,7 @@ static int qcom_geni_console_setup(struct console *co, char *options)
>  {
>  	struct uart_port *uport;
>  	struct qcom_geni_serial_port *port;
> -	int baud = 9600;
> +	int baud = 115200;
>  	int bits = 8;
>  	int parity = 'n';
>  	int flow = 'n';
> -- 
> 2.28.0.618.gf4bc123cb7-goog
> 
