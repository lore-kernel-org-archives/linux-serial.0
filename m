From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] serial: pl011: protect attribute read from NULL platform
 data struct
Date: Mon, 13 May 2013 21:09:38 +0200
Message-ID: <CACRpkdZR3AsGyCUH=cbskcZPs0PVBjH6QXUGkD+KG8SzGMMOKg@mail.gmail.com>
References: <1368103855-28363-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1368103855-28363-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linus WALLEIJ <linus.walleij@stericsson.com>, Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>, Russell King <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, May 9, 2013 at 2:50 PM, Lee Jones <lee.jones@linaro.org> wrote:

> It's completely feasible that platform data will be empty i.e. when
> booting with Device Tree with no device AUXDATA. So we must protect
> it's use in these use-cases, or risk a kernel Oops.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.cz>
> Cc: linux-serial@vger.kernel.org
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
> *******                                                        *******
> If this issue has not already been fixed, this patch should be applied
> during the v3.10 -rc:s, as it fixes a serious bug which was introduced
> in the merge-window.
> *******                                                        *******

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

You should probably put Greg on To: so that he picks this up for
the -rc:s ASAP.

Yours,
Linus Walleij
