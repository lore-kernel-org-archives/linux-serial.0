From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] serial: remove use of gpiochip_remove() retval
Date: Thu, 2 Oct 2014 09:21:52 +0200
Message-ID: <CACRpkdZkXjTNo6koF3wn9q-tsBQkOu8+5Q7A+qku0Od_YWULjw@mail.gmail.com>
References: <1412143069-18562-1-git-send-email-pramod.gurav@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:56044 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbaJBHVx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 2 Oct 2014 03:21:53 -0400
Received: by mail-ie0-f179.google.com with SMTP id ar1so1929985iec.24
        for <linux-serial@vger.kernel.org>; Thu, 02 Oct 2014 00:21:52 -0700 (PDT)
In-Reply-To: <1412143069-18562-1-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Pramod Gurav <pramod.gurav@smartplayin.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Wed, Oct 1, 2014 at 7:57 AM, Pramod Gurav
<pramod.gurav@smartplayin.com> wrote:

> Get rid of using return value from gpiochip_remove() as it returns
> void with a new change in kernel.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: linux-serial@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>

NACK.

Already fixed through the GPIO tree.

Yours,
Linus Walleij
