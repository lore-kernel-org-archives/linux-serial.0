From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [PATCH] serial: pl011: add console matching function
Date: Wed, 9 Nov 2016 12:17:18 -0600
Message-ID: <CAOZdJXXf7=KWya4Nr3NZo_A7FSfxKPn1B-HdxZ_bN57duqRaSA@mail.gmail.com>
References: <20161004071547.19224-1-aleksey.makarov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161004071547.19224-1-aleksey.makarov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Christopher Covington <cov@codeaurora.org>, Peter Hurley <peter@hurleysoftware.com>, Russell King <linux@armlinux.org.uk>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 4, 2016 at 2:15 AM, Aleksey Makarov
<aleksey.makarov@linaro.org> wrote:
> This patch adds function pl011_console_match() that implements
> method match of struct console.  It allows to match consoles against
> data specified in a string, for example taken from command line or
> compiled by ACPI SPCR table handler.
>
> This patch was merged to tty-next but then reverted because of
> conflict with
>
> commit 46e36683f433 ("serial: earlycon: Extend earlycon command line option to support 64-bit addresses")
>
> Now it is fixed.
>
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> Tested-by: Christopher Covington <cov@codeaurora.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Is there any chance this fix will make it into 4.9?  It's been out for
over a month.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
