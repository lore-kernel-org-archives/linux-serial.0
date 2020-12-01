Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15DCC64E7B
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 07:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F35216C4
	for <linux-serial@archiver.kernel.org>; Tue,  1 Dec 2020 07:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727694AbgLAHOv (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 1 Dec 2020 02:14:51 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:36316 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgLAHOv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 1 Dec 2020 02:14:51 -0500
Received: by mail-ej1-f66.google.com with SMTP id lt17so1996140ejb.3;
        Mon, 30 Nov 2020 23:14:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OZosIAZ5kQh+M6bi+XZwxMMNMZ/xJ39Rm7xM03MsjcM=;
        b=Z9O5lhlGPN5n4qDVVBMLPbnCOOwpRJq/n86cJJYlpubfJKYeJevjoZdFWBchuQmG0D
         FGZhAVeqa6Hdtn2X4ZpEScDz/8KbYo5ZCZ5G3L2alOU06f/JQRW3aQklOQuthw+fO06O
         Yt7X+7At0Sliq1Lh7D2LSnyb7awy77cbbKbYM2e+l+GUGP+jmcAqbG4M9q/imNOGT10H
         suc0VzAHiHA8/s3w1DBswcp/LF0Km3wGkKWohln2Rn30S8lTgK9XktkfJcPyAaU0gRFi
         uhbxKSalmgmvQGxQjAhh7vNKvk7JdUr1/CWgyzq0GcBpHBzPJ68yD3e8mmwUN/zx/+QU
         jUrg==
X-Gm-Message-State: AOAM531XTrdzlWV24eONQgbOdsgo9+713zKA5Mm76wMp4gw6xPToJuyR
        2iYZoyeUcoZ+ePeYQxh5do1V5otmz8M=
X-Google-Smtp-Source: ABdhPJzRWz7vobwzkYeFLRzS9k+kWPNCUAcD5jS0op2Gx0uy8xzuSX1j+n1WCiMlDI7DwuVfsSqwvg==
X-Received: by 2002:a17:906:358e:: with SMTP id o14mr1678870ejb.526.1606806848925;
        Mon, 30 Nov 2020 23:14:08 -0800 (PST)
Received: from [192.168.1.49] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id j27sm191022ejo.61.2020.11.30.23.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 23:14:08 -0800 (PST)
Subject: Re: [PATCH 0/5] tty: add flag to suppress ready signalling on open
To:     Mychaela Falconia <mychaela.falconia@gmail.com>,
        Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201130153742.9163-1-johan@kernel.org>
 <CA+uuBqYmzJMiY75LrA_uKb_uL2=7oQTrzCFksb2ehT0XMXxrbw@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <c8f3e485-54c6-99c7-4888-6eef2e174bf6@kernel.org>
Date:   Tue, 1 Dec 2020 08:14:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CA+uuBqYmzJMiY75LrA_uKb_uL2=7oQTrzCFksb2ehT0XMXxrbw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 30. 11. 20, 22:22, Mychaela Falconia wrote:
> 2) For situations in which the luxury of a custom USB ID is not
> available, e.g., a situation where the device that does not tolerate
> automatic DTR/RTS assertion on open is a physical RS-232 device that
> can be connected to "any" serial port, the new sysfs attribute comes
> to the rescue.
> 
> Johan's patch comments say that the new flag can also be brought out
> to termios in the future, similarly to HUPCL,

The difference to other control flags is that open raises DTR/RTS in any 
case (i.e. including O_NONBLOCK) -- provided baud rate is set (and it is 
for casual serials). That means you cannot open a port to configure it 
(using e.g. setserial) without actually raising the DTR/RTS.

> but I question the
> usefulness of doing so, as it is a chicken and egg problem: one needs
> to open the tty device in order to do termios ioctls on it, and if
> that initial open triggers DTR/RTS hardware actions, then the end user
> is still screwed.  If Johan or someone else can see a potential use
> case for manipulating this new flag via termios (as opposed to sysfs
> or USB-ID-based driver quirks), perhaps you could elaborate on it?

We would need to (ab)use another open flag (e.g. O_DIRECT). I am not 
biased to either of solutions.

thanks,
-- 
js
