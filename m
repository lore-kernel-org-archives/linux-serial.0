Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998FDC433E6
	for <linux-serial@archiver.kernel.org>; Sun, 31 Jan 2021 05:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68F7064E05
	for <linux-serial@archiver.kernel.org>; Sun, 31 Jan 2021 05:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbhAaFZP (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 31 Jan 2021 00:25:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:39188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229481AbhAaFZN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 31 Jan 2021 00:25:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1891264E1F;
        Sun, 31 Jan 2021 05:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612070672;
        bh=rztIUAxj6lRAykEeYYAw3qte7w6d9rekhBKaDwj2+Jc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YnHqzVJk0k+sY1TSm1uZwU59CQDtrLY92VcaRhW5Dfvoa0WLqc7ZrXmKWEo6WH/Q/
         7XiNMa6ztfGry4jYnHVKfVNUYBtC8DVmjBJzLkrd5SzsGglP9OJr2gfoBgX67Pg8ia
         0AnugPFCWY9L/b+ySVLFywNfWeiwU6RUpBwdXo9g=
Date:   Sun, 31 Jan 2021 06:24:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mychaela Falconia <mychaela.falconia@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Maarten Brock <m.brock@vanmierlo.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Mychaela N . Falconia" <falcon@freecalypso.org>,
        linux-serial@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] tty: add flag to suppress ready signalling on open
Message-ID: <YBY/DDSWB+YT2r8m@kroah.com>
References: <CA+uuBqYTzXCHGY8QnP+OQ5nRNAbqx2rMNzLM7OKLM1_4AzzinQ@mail.gmail.com>
 <6b81cca21561305b55ba8f019b78da28@vanmierlo.com>
 <X9H9i98E1Gro+mDP@kroah.com>
 <3fc3097ce1d35ce1e45fa5a3c7173666@vanmierlo.com>
 <X9IcKoofq+2iGZn7@kroah.com>
 <CA+uuBqaNcKadyLRyufm+6HUHXcs7o0rtgw84BrHc7Jq9PauV8Q@mail.gmail.com>
 <X9d039qPr/LO/2R/@localhost>
 <CA+uuBqZgq4KRZsqGRKDUbKAcQxYr1XPhYDrjzMNfWMYgDX8Wfg@mail.gmail.com>
 <YBPxG+i/ZLP8/wg1@hovoldconsulting.com>
 <CA+uuBqaf7cDJcXPsba5qKG78sak0dF4aHHtKOpUMj-0zNS-hAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+uuBqaf7cDJcXPsba5qKG78sak0dF4aHHtKOpUMj-0zNS-hAQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, Jan 30, 2021 at 04:18:04PM -0800, Mychaela Falconia wrote:
> Greg K-H wrote:
> 
> > our job is to make Linux work for everyone.
> 
> But as your refusal to accept the purely additive (zero impact on
> anything other than specific hw in question) patch adding support for
> a new hardware device clearly indicates, your job is NOT to make Linux
> work for everyone, but rather for a smaller subset of "everyone"
> *other than* hardware designers who come to the maintainers in good
> faith, asking to mainline support for new hardware they just made.

Anything we take adds work to our overall effort to support that new
feature added.  And you are asking us to do that work for you, for free,
for forever.  Sorry, given that your attitude does not understand that
this is a community and we need to work together, I don't think it's
worth continuing here, sorry.

If you change your mind in the future, you know how to contact us.

greg k-h
