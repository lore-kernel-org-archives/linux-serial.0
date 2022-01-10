Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B75C433FE
	for <linux-serial@archiver.kernel.org>; Mon, 10 Jan 2022 09:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbiAJJ2n (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 10 Jan 2022 04:28:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242932AbiAJJ2A (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 10 Jan 2022 04:28:00 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838E6C061756
        for <linux-serial@vger.kernel.org>; Mon, 10 Jan 2022 01:27:59 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id l25so14618069wrb.13
        for <linux-serial@vger.kernel.org>; Mon, 10 Jan 2022 01:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3JIe/AziNkL7QWWwzr2FGj9H5QSbDRRWwjLKOVDugLY=;
        b=4e/NgOncPGsI6zL82IKBGE3RBzWcjd1sdmMoSfIeMMq+biJ+zFQ12dPnmoHrSyF1xK
         2BkUZwWICKVO4SteHjvVLKvJB9ATXfg51nfZSwlQq77s9g/hwyC0nnsO+bgfBdq3Akoi
         9e9nLREII4Uc+KUJYMZIIrhyna9Auemz9XbYnL3XGgstSUhh8UVLVs7YFxTMgZ8G5kg7
         +wnIIgQQWV9Pgr6kXgJ1ZobbydhZ4DCcxn60Xesojt8EiL71Ks0IfMv5sJdgP4QmAfqC
         MZIoS2QQfVrwjuXnj/U8qkecb5Pt5ggMsicb56e2GCFt+t1i648g0w0JUmIQ/nARiuNg
         kYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=3JIe/AziNkL7QWWwzr2FGj9H5QSbDRRWwjLKOVDugLY=;
        b=bwBEdTAMu5UTpaw7hhPnyTyoc//Tyw2VtdewxO6gxaeYdw/D1fIanSc2KC4Tl6WFQ9
         zWn8EF9n2Rk5Y0c9zTj5CDgM40KIzks9MptOxEpwXXnmfas8B9eYqSRy8FeIoXTOevL5
         Xn4Wq8EDda6f//W52J5tOlG8lUNI/DLZbHqJYgMZy1NJTmMt/9fh5ssoD3OR1CMI1fWs
         kDGdZTBjE//VUlGiYh/hu7rT0WIc/4W4hMy5tYnGCax8HnevKHk/KuLKjm1OS0mRUGi0
         myv0S9vj5cWhToO6m6V4bYsVg5gsvDn23omnjIfhbWaDJ+u1zEKeuonx/QCwRGvtT3oo
         KshQ==
X-Gm-Message-State: AOAM533EOrD56Cr4cd0+yhe21CRoRV9p0Jq+SNeiDvduCr3q4XpexuBm
        5NQjHTWgQdWkPm70ZMSPTC+blA==
X-Google-Smtp-Source: ABdhPJxif1cXTO0qc4AtrxnBYKdw1S+IGnZNRgcQM96lZpohEhKLaAGAuc9lRusoIkLi0vPyC0k68A==
X-Received: by 2002:a05:6000:1569:: with SMTP id 9mr63539563wrz.127.1641806878077;
        Mon, 10 Jan 2022 01:27:58 -0800 (PST)
Received: from ?IPv6:2001:861:44c0:66c0:94e5:2e36:6bcc:a9f1? ([2001:861:44c0:66c0:94e5:2e36:6bcc:a9f1])
        by smtp.gmail.com with ESMTPSA id m6sm7068700wrx.36.2022.01.10.01.27.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 01:27:57 -0800 (PST)
Subject: Re: [PATCH V4 0/5] the UART driver compatible with
To:     Yu Tu <yu.tu@amlogic.com>, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220110085604.18042-1-yu.tu@amlogic.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <1f4b9288-c7ff-c895-425c-187d058642b9@baylibre.com>
Date:   Mon, 10 Jan 2022 10:27:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220110085604.18042-1-yu.tu@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On 10/01/2022 09:55, Yu Tu wrote:
> Using the common Clock code to describe the UART baud rate
> clock makes it easier for the UART driver to be compatible
> with the baud rate requirements of the UART IP on different
> meson chips. Add Meson S4 SoC compatible.
> 
> Yu Tu (5):
>   dt-bindings: serial: meson: Drop compatible = amlogic,meson-gx-uart.
>   tty: serial: meson: Request the register region in meson_uart_probe()
>   tty: serial: meson: The UART baud rate calculation is described using
>     the common clock code.
>   tty: serial: meson: Make the bit24 and bit [26,27] of the UART_REG5
>     register writable
>   tty: serial: meson: Added S4 SOC compatibility.

Weird, the subjects are fine in the cover letter but are all truncated in the email thread:
[PATCH V4 0/5] the UART driver compatible with
[PATCH V4 1/5] dt-bindings: serial: meson: Drop
[PATCH V4 2/5] tty: serial: meson: Request the register
...
Only the last one is OK.


> 
> V1 -> V2: Use CCF to describe the UART baud rate clock.Make some changes as
> discussed in the email
> V2 -> V3: add compatible = "amlogic,meson-gx-uart". Because it must change
> the DTS before it can be deleted
> V3 -> V4: Change CCF to describe the UART baud rate clock as discussed
> in the email.
> 
> Link:https://lore.kernel.org/linux-amlogic/20211230102110.3861-4-yu.tu@amlogic.com/
> 
>  .../bindings/serial/amlogic,meson-uart.yaml   |  10 +-
>  drivers/tty/serial/meson_uart.c               | 244 ++++++++++++------
>  2 files changed, 177 insertions(+), 77 deletions(-)
> 

