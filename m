Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA3BC4361B
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 10:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B14823F36
	for <linux-serial@archiver.kernel.org>; Fri, 11 Dec 2020 10:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390487AbgLKKr1 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 11 Dec 2020 05:47:27 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42496 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728980AbgLKKrK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 11 Dec 2020 05:47:10 -0500
Received: by mail-lj1-f195.google.com with SMTP id y22so10330435ljn.9;
        Fri, 11 Dec 2020 02:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dRa8+8T0/doCyxO8jlNrqWF9bR8w4xPSvOc8mqFfidI=;
        b=GkRjOyByop67mPZU4KBxErD+xT3KiaTuGG7uCIK0ryjWFi9hPqCQ7Pvh9tNv9lP1Bw
         nMFUqpKle557p+AUjs0HNXh4kDwuRwJj5R+XSRj0P56znTQpZggEMKAhdZ99eIKzqSpF
         copzuAbs7km5xmG1yiZMAef4WKdOfE67qZr/9UphfJoHGtBhNdeRjZM6Hk8g9lmmovnl
         qS0aWH+v0hRjeinpFQKgvRUh8C0an8C8HEhKI0ZYyHuUrltpzJkmL/Gpvj6h8NSs8Mss
         W/EeL8M0bTLxGJk3Q+B/2PTZhaO7tMY6pFeiD3GLNc+xpjjUZKzpGZyU/ynAYBuvHzR5
         p45A==
X-Gm-Message-State: AOAM532oXhB2COuR9g+txsdXjI7bHtGJo1MljXivmGQTL+DkPJq/Ebn4
        HBg6KBWBBaUBPinfqIV7rqM=
X-Google-Smtp-Source: ABdhPJx0eK75XvUevDCsmqYfr+BPwS23tljwjADb07jfuaNvnTNuvi5wcgR9UGvhacHo3upAiIqEgw==
X-Received: by 2002:a05:651c:1199:: with SMTP id w25mr4642238ljo.165.1607683588903;
        Fri, 11 Dec 2020 02:46:28 -0800 (PST)
Received: from xi.terra (c-d2ade455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.173.210])
        by smtp.gmail.com with ESMTPSA id o8sm841166lft.101.2020.12.11.02.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 02:46:28 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1knfwR-0000u7-Eq; Fri, 11 Dec 2020 11:46:27 +0100
Date:   Fri, 11 Dec 2020 11:46:27 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Maarten Brock <m.brock@vanmierlo.com>,
        Mychaela Falconia <mychaela.falconia@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] tty: add flag to suppress ready signalling on open
Message-ID: <X9NOAypxyiS5M3Ze@localhost>
References: <20201202113942.27024-1-johan@kernel.org>
 <X9Dficb8sQGRut+S@kroah.com>
 <CA+uuBqYTzXCHGY8QnP+OQ5nRNAbqx2rMNzLM7OKLM1_4AzzinQ@mail.gmail.com>
 <6b81cca21561305b55ba8f019b78da28@vanmierlo.com>
 <X9H9i98E1Gro+mDP@kroah.com>
 <3fc3097ce1d35ce1e45fa5a3c7173666@vanmierlo.com>
 <X9IcKoofq+2iGZn7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X9IcKoofq+2iGZn7@kroah.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Dec 10, 2020 at 02:01:30PM +0100, Greg Kroah-Hartman wrote:
> O_DIRECT is an interesting hack, has anyone seen if it violates the
> posix rules for us to use it on a character device like this?

Jiri only mentioned O_DIRECT as an example of a flag which we might be
able to repurpose/abuse for this. O_DIRECT is linux-specific, not in
POSIX, so we'd still end up with a Linux-specific interface if we were
to take this route.

Johan
