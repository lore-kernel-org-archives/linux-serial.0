Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4636C43334
	for <linux-serial@archiver.kernel.org>; Thu,  2 Jun 2022 07:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiFBHsW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 2 Jun 2022 03:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiFBHsQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 2 Jun 2022 03:48:16 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A6250004;
        Thu,  2 Jun 2022 00:48:15 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id k19so5327589wrd.8;
        Thu, 02 Jun 2022 00:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n1qpPO/AQnrkjr3lnMZirqdvM1s0lzIe9jInl30P+E4=;
        b=mqpPPOItVgVkTT0iIXfw738DCDbpXXAweHr0WeZ7UTD/U4XPSVp1hX8Db83B4MmERV
         U7yrXeeNMTDJVafP/HT8QHBcz5TLSmOeobgAQBFqb186kYv/efl7DQEmVZzG2i5TRZ3v
         LPpVKmYkFtuH+6kbacgVHnVRWg7wky5WMVkDz6edhtObYCQ/P00Nn44x0Rntj/eyIz+b
         u118ld7zkUOJiSZzJeFABGN93RGqPq99hDJ9rmkvgfmi0Y97im2QzK0lmU0F7Rs1vZ7q
         ed7B8gBnnvhyWOfJfVvg0GIX5pmiELwL69aefF91SnlFqACDx70kMABb9vF35V7kj/gX
         2lEw==
X-Gm-Message-State: AOAM531EZlrCgh2NHGQnDkFRUXyNIkXqxRozfTVo5v+CA+MLbK5BN/QH
        GS8Std6u6FaueLhKH8RJZC6zbPo0ARyIxA==
X-Google-Smtp-Source: ABdhPJyIlTuH9P8cAcE6zgkOp66I3Qta64UWKFF2+NSx/m1Vbwu6jSQtaOVGpQKc0tlBR15TdSCvgw==
X-Received: by 2002:a5d:4906:0:b0:20f:fc2a:987a with SMTP id x6-20020a5d4906000000b0020ffc2a987amr2475979wrq.228.1654156093836;
        Thu, 02 Jun 2022 00:48:13 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id e11-20020adffd0b000000b0020e6ce4dabdsm3532531wrr.103.2022.06.02.00.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 00:48:13 -0700 (PDT)
Message-ID: <dbec85f5-7b28-3d0b-6b39-bd4296a49a70@kernel.org>
Date:   Thu, 2 Jun 2022 09:48:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/6] serial: core: add sysfs attribute to suppress
 ready signalling on open
Content-Language: en-US
To:     "Mychaela N. Falconia" <falcon@freecalypso.org>,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        mychaela.falconia@gmail.com
References: <20220531043356.8CAB637401A9@freecalypso.org>
 <20220531043655.DDF783740232@freecalypso.org>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220531043655.DDF783740232@freecalypso.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 31. 05. 22, 6:36, Mychaela N. Falconia wrote:
> From: Johan Hovold <johan@kernel.org>
> 
> Add a nordy sysfs attribute to suppress raising the modem-control lines
> on open to signal DTE readiness.
> 
> This can be used to prevent undesirable side-effects on open for
> applications where the DTR and RTS lines are used for non-standard
> purposes such as generating power-on and reset pulses.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Mychaela N. Falconia <falcon@freecalypso.org>
> ---
>   Documentation/ABI/testing/sysfs-tty |  7 +++++++
>   drivers/tty/serial/serial_core.c    | 26 ++++++++++++++++++++++++++
>   2 files changed, 33 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-tty b/Documentation/ABI/testing/sysfs-tty
> index 820e412d38a8..98cb5cf0af75 100644
> --- a/Documentation/ABI/testing/sysfs-tty
> +++ b/Documentation/ABI/testing/sysfs-tty
> @@ -161,3 +161,10 @@ Contact:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>   Description:
>   		 Allows user to detach or attach back the given device as
>   		 kernel console. It shows and accepts a boolean variable.
> +
> +What:		/sys/class/tty/ttyS0/nordy

s@ttyS0@ttyS<x>@

> +Date:		November 2020
> +Contact:	Johan Hovold <johan@kernel.org>
> +Description:
> +		 Show and store the port NORDY flag which suppresses raising
> +		 the modem-control lines on open to signal DTE readiness.
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 9a85b41caa0a..a17ac4efaceb 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -2870,6 +2870,30 @@ static ssize_t console_store(struct device *dev,
>   	return ret < 0 ? ret : count;
>   }
>   
> +static ssize_t nordy_show(struct device *dev, struct device_attribute *attr,
> +				char *buf)
> +{
> +	struct tty_port *port = dev_get_drvdata(dev);
> +
> +	return sprintf(buf, "%d\n", tty_port_nordy(port));

sysfs_emit()? (Even if I know %d won't overflow PAGE_SIZE :P.)


thanks,
-- 
js
suse labs
