Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D779C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 15 Nov 2021 10:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 827956126A
	for <linux-serial@archiver.kernel.org>; Mon, 15 Nov 2021 10:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhKOKvT (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Nov 2021 05:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhKOKvI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Nov 2021 05:51:08 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF115C061746
        for <linux-serial@vger.kernel.org>; Mon, 15 Nov 2021 02:48:10 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z5so9920204edd.3
        for <linux-serial@vger.kernel.org>; Mon, 15 Nov 2021 02:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yf714q2A5/MrMjZCA3gGUPqhlajmH/vPC1c+Bvnu9I4=;
        b=iCVBuFnMPhYk+FMQq84QGCDsdbHTWOuu/BS1YH/vyRXceOWvA/C3HwtyI9ciqpT2Na
         yzHxt7I3sMXp56f0lBYB+tlWLPg8r+GEmOAqoJfKXabiHA9ZLYHMl536C6b4IxaYA10L
         jX1FoUUTA8Rk4jOLfNzdTTbyHZzFMQ5FBP/4xm5mHelUtK38iU66ldw7FhaZZC2mlUAu
         IQSKkU5sm86eW3o5z/YOWhkQF79/1KK+uN5D9pbgvFrscpCm0JLEVV2IqW0skIY+7UCc
         MBuISERwCIJHEWp/t3IAbuN3h4XrN3UTMnwyC8l5QWvV9e+vMnDh3RRVAFEb/ia5e8AZ
         LtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yf714q2A5/MrMjZCA3gGUPqhlajmH/vPC1c+Bvnu9I4=;
        b=LNhwChqSvVKaz/iG+Vet9Rx9IyrbkU/Me9zBfgtVh6qBxnY+3PvwUB1EdMFvs9Ck3h
         01xbW3h8U5GnkVVCEKgjOv8jYFIZahpuH0qscgSUKVE2TMLPF6rQxtPznYKx9hQxugG+
         xl1qkFnx3/PiA77Ne4ajZz4XAcEWXniyTRa4hHkcoNrjhOqYkSvlOPXEuAH+zb8br+PU
         ejUl/ntvgw4eTwH8PQL8Mev54BeHW2mxbUNcsIErBHAWdQwQPRCV12xQxskclQtGKJ7S
         mVKoqz+512fH22byF1L50pispIWHV9oeZKmSIeCU7Z/CMoCsgT67eGG3uqP9elID7ixP
         XS8A==
X-Gm-Message-State: AOAM5307WFXMOo8kFboY/oCXyeT1oEsLImEeeI305uxuya6iKBkmPZw/
        HP0DCQjwJgXPNoRVxIcPSprdcItwlFi9lDT7YsI=
X-Google-Smtp-Source: ABdhPJyTuD4wi4PwIBSKwFuAE6ryKZbRDQCo6sW9PiMzo5mu0GylpaXX/c8VYDbhNwhbeqrstPbr0wY0kwMXNiVvLcM=
X-Received: by 2002:a17:906:bccc:: with SMTP id lw12mr46590924ejb.128.1636973289346;
 Mon, 15 Nov 2021 02:48:09 -0800 (PST)
MIME-Version: 1.0
References: <20211115031808.7ab632ef@dtkw>
In-Reply-To: <20211115031808.7ab632ef@dtkw>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Nov 2021 12:47:27 +0200
Message-ID: <CAHp75VdpEj3gdvRN+KCSEeTCjjo6tveYaB6uHisn6BYhCkR0SA@mail.gmail.com>
Subject: Re: [PATCH] serial: liteuart: fix missing drvdata
To:     Ilia Sergachev <silia@ethz.ch>
Cc:     "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Nov 15, 2021 at 4:34 AM Ilia Sergachev <silia@ethz.ch> wrote:

Besides what Greg asked for, can you rephrase Subject to something like
"serial: liteuart: Fix NULL pointer dereference in ->remove()"

> drvdata has to be set in _probe() - otherwise platform_get_drvdata()
> causes null pointer dereference BUG in _remove()

Don't forget the grammatical period.

Code looks good to me, though.

-- 
With Best Regards,
Andy Shevchenko
