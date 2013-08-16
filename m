From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH V2 1/3] serial: sirf: drop redundant pinctrl_get_select_default
 as pinctrl core does it
Date: Fri, 16 Aug 2013 17:40:32 +0200
Message-ID: <CACRpkdYYRVROSO3DWDqpdomBbwPD7wL9GTGr8-xKEiLmm=cgeA@mail.gmail.com>
References: <1376520736-3838-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:40391 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540Ab3HPPkc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Aug 2013 11:40:32 -0400
Received: by mail-ob0-f173.google.com with SMTP id ta17so2214294obb.32
        for <linux-serial@vger.kernel.org>; Fri, 16 Aug 2013 08:40:32 -0700 (PDT)
In-Reply-To: <1376520736-3838-1-git-send-email-Baohua.Song@csr.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Barry Song <Baohua.Song@csr.com>

On Thu, Aug 15, 2013 at 12:52 AM, Barry Song <21cnbao@gmail.com> wrote:

> pinctrl core will get default pinmux, so drop it in the sirfsoc serial driver.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  -v2: rebase to tty-next

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
