Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E410C433FE
	for <linux-serial@archiver.kernel.org>; Fri,  4 Dec 2020 06:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77D3224DF
	for <linux-serial@archiver.kernel.org>; Fri,  4 Dec 2020 06:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgLDG7j (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 4 Dec 2020 01:59:39 -0500
Received: from mail-ej1-f66.google.com ([209.85.218.66]:42086 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLDG7i (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 4 Dec 2020 01:59:38 -0500
Received: by mail-ej1-f66.google.com with SMTP id d17so7134660ejy.9;
        Thu, 03 Dec 2020 22:59:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e50yAptPk4qvH2DjIDkzdRdD/+Aa+SiLK2zM+mJlFWA=;
        b=eC5k0J95DjW8FrZJhU3Z+5kXbR/eCy0IEYRe2JqcboV8SotoZ/2TOKp59zWAExaaEH
         5Dbu3Ixe5HIHnQMFqE0cnQ9PciUFqkEFNA4MtWmt1GGL+BM0HKb/RksQgMxwlNYWS/iZ
         i1COKAnuGUocvAxCtZMAJVAcjJ6iJFhRi2aWinh2AiuVEFHWe+1/QwRC5wqeuybKwrWz
         vmlIf0He6BYEsJP4A4USmwrHbHyCPKZVin5CdRR4xQyA4IFi6vBPFQFoHc6qzUYiWIG7
         jhZHdxLLk7ChHA8tdaG2EQ4KLQkJXu7T0Dy9QlangXMBHIhO7URP4qiq2XboSpZNSro2
         qg/A==
X-Gm-Message-State: AOAM533KuKBKMrUsVWgbHO0O6Snm1tu6drmTREAh2n4LrQ5zPeymmppf
        LD/KLUfAFTIXxgtNiZvaSTaisfZ6h7UNgQ==
X-Google-Smtp-Source: ABdhPJy5MEfKbVUJFTnh1vKqmxmxnnoKlgi6kcqIAd4ISej8g/3EJ6ptUx8ssAV5yi5x1hhhmvLh+Q==
X-Received: by 2002:a17:906:d72:: with SMTP id s18mr5900964ejh.110.1607065136221;
        Thu, 03 Dec 2020 22:58:56 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id x20sm2418231ejv.66.2020.12.03.22.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Dec 2020 22:58:55 -0800 (PST)
Subject: Re: [PATCH 0/5] tty: add flag to suppress ready signalling on open
To:     Johan Hovold <johan@kernel.org>
Cc:     Mychaela Falconia <mychaela.falconia@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201130153742.9163-1-johan@kernel.org>
 <CA+uuBqYmzJMiY75LrA_uKb_uL2=7oQTrzCFksb2ehT0XMXxrbw@mail.gmail.com>
 <c8f3e485-54c6-99c7-4888-6eef2e174bf6@kernel.org>
 <X8d/Ac5Z4bT/W7ZA@localhost>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <a58e3a7b-58bb-0430-2344-8e8155758e45@kernel.org>
Date:   Fri, 4 Dec 2020 07:58:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <X8d/Ac5Z4bT/W7ZA@localhost>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 02. 12. 20, 12:48, Johan Hovold wrote:
>>> but I question the
>>> usefulness of doing so, as it is a chicken and egg problem: one needs
>>> to open the tty device in order to do termios ioctls on it, and if
>>> that initial open triggers DTR/RTS hardware actions, then the end user
>>> is still screwed.  If Johan or someone else can see a potential use
>>> case for manipulating this new flag via termios (as opposed to sysfs
>>> or USB-ID-based driver quirks), perhaps you could elaborate on it?
>>
>> We would need to (ab)use another open flag (e.g. O_DIRECT). I am not
>> biased to either of solutions.
> 
> Forgot to mention that using open-flags would prevent using standard
> utilities like cat, echo and terminal programs. So for that reason a
> termios and/or sysfs interface is also preferred.

Nope, I meant it differently. You set it up once using the special open 
flag. Like with setserial, one sets I/O port, irqs etc. and then uses 
standard tools as the port is already set up (marked as NORDY in this case).

thanks,
-- 
js
