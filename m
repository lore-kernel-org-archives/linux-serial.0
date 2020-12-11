Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81956C2BB9A
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 08:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46E8823F36
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 08:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437031AbgLKIr5 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Dec 2020 03:47:57 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42287 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392611AbgLKIrj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Dec 2020 03:47:39 -0500
Received: by mail-ed1-f67.google.com with SMTP id v22so8486828edt.9;
        Fri, 11 Dec 2020 00:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V3miwBN5IwwSL9GTcKFlkJLkNfHwlmPFsY5VZw1t92s=;
        b=Fb4A/HWVy2YO3sJ33ygvYz11XRoNjfJvGGxr88EM8/+2h637JdBrfw7CC6WCchqKoU
         GYWniTb3TvM+HLCq/AQNU69Dn5ANM+dTo/rAnleBEuK2XPrB78POP6qQx76MkVPDjY3q
         eqO7s4tp3twfveEUoycT2JFl4bg9nDZMEPaVzn8G48RS6eLv87si+nfQAgRQ9vAbTSmY
         LQ2OHycCiWJrBLCp/sXN5L4LkhKaCzUAubxFpLmYXTI9PoggTbNvgsyjE1FuYqNatw2D
         DWjRi7EAKTGsnGOyt9lf36xL+216E8d1/bItgHZMoT0Gl5mt625PMTY5PsP4tQWeYIur
         cw/A==
X-Gm-Message-State: AOAM533hCrdhZizqa86yUVDLNcl3W7qHw7RW8eb6entwasW+NMSowSeZ
        x00iqEEz6fbEsM3WiNlOVZp3UMa1qHPC6g==
X-Google-Smtp-Source: ABdhPJwKcj4KtAa8BCcQFRGDJwiq6iFsPCqd888uzqaoZtJxArMJYyBeGjZpcIjyrnpmUFuq7TIH+w==
X-Received: by 2002:aa7:cb49:: with SMTP id w9mr11045398edt.357.1607676417217;
        Fri, 11 Dec 2020 00:46:57 -0800 (PST)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id b14sm1336275edu.3.2020.12.11.00.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 00:46:56 -0800 (PST)
Subject: Re: [PATCH v2 0/7] tty: add flag to suppress ready signalling on open
To:     Mychaela Falconia <mychaela.falconia@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Maarten Brock <m.brock@vanmierlo.com>,
        Johan Hovold <johan@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201202113942.27024-1-johan@kernel.org>
 <X9Dficb8sQGRut+S@kroah.com>
 <CA+uuBqYTzXCHGY8QnP+OQ5nRNAbqx2rMNzLM7OKLM1_4AzzinQ@mail.gmail.com>
 <6b81cca21561305b55ba8f019b78da28@vanmierlo.com> <X9H9i98E1Gro+mDP@kroah.com>
 <3fc3097ce1d35ce1e45fa5a3c7173666@vanmierlo.com> <X9IcKoofq+2iGZn7@kroah.com>
 <CA+uuBqaNcKadyLRyufm+6HUHXcs7o0rtgw84BrHc7Jq9PauV8Q@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <54f40116-9a11-8daa-d3cd-5557cc60a4ef@kernel.org>
Date:   Fri, 11 Dec 2020 09:46:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CA+uuBqaNcKadyLRyufm+6HUHXcs7o0rtgw84BrHc7Jq9PauV8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10. 12. 20, 19:59, Mychaela Falconia wrote:
>> O_DIRECT is an interesting hack, has anyone seen if it violates the
>> posix rules for us to use it on a character device like this?
> 
> According to open(2) Linux man page, O_DIRECT does not come from POSIX
> at all, instead it is specific to Linux, FreeBSD and SGI IRIX.  Thus
> it seems like there aren't any POSIX rules to be violated here.
> 
> If we go with O_DIRECT, what semantics are we going to implement?
> There are 3 possibilities that come to mind most readily:
> 
> 1) O_DIRECT applies only to the open call in which this flag is set,
> and suppresses DTR/RTS assertion on that open.  If someone needs to do
> multiple opens with DTR/RTS suppression being required every time,
> then they need to include O_DIRECT every time.
> 
> 2) O_DIRECT applies not only immediately, but also sets a latched flag
> whereby all subsequent opens continue to suppress auto-assertion
> without requiring O_DIRECT every time.  This approach by itself runs
> counter to the generic Unix way of doing things, but it may be OK if
> there is also some ioctl to explicitly set or clear the latched flag.
> 
> 3) O_DIRECT applies only to the open call in which it is set, no
> built-in latching, but there is also some ioctl to control a flag
> enabling or disabling DTR/RTS auto-assertion on subsequent opens.

3) -- to allow standard tools to work on the device after the quirk is 
set up once.

thanks,
-- 
js
