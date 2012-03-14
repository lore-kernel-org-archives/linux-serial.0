From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v3] serial: PL011: clear pending interrupts
Date: Wed, 14 Mar 2012 10:02:22 +0100
Message-ID: <CACRpkdZXrMW653W=tysY8ncqBKDun3TgPqnEzrdZPqwpW8shYA@mail.gmail.com>
References: <1331641643-25929-1-git-send-email-linus.walleij@stericsson.com>
	<CAOAMb1AKmsNQbmVAaYq5G8cdafCVpRyA=5xgocqYfLsQ6BLXMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:50243 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932401Ab2CNJCZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Mar 2012 05:02:25 -0400
Received: by ghrr11 with SMTP id r11so1538692ghr.19
        for <linux-serial@vger.kernel.org>; Wed, 14 Mar 2012 02:02:25 -0700 (PDT)
In-Reply-To: <CAOAMb1AKmsNQbmVAaYq5G8cdafCVpRyA=5xgocqYfLsQ6BLXMw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Chanho Min <chanho0207@gmail.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Jong-Sung Kim <neidhard.kim@lge.com>, stable@kernel.org, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>

On Wed, Mar 14, 2012 at 2:47 AM, Chanho Min <chanho0207@gmail.com> wrote:
>
> I've tested this patch, and have confirmed that the issue is resolved
> on our CA9 platform.
> In addition, May I ask to change the tag as follows.
>
> Reported-by: Chanho Min <chanho.min@lge.com>
> Reviewed-by: Jong-Sung Kim <neidhard.kim@lge.com>

Thanks Chanho, Greg will you add the Reported/Reviewed-by
tags or do you want me to send a v4 of this?

Yours,
Linus Walleij
