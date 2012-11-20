From: Matt Schulte <matts@commtech-fastcom.com>
Subject: Re: [PATCH 1/2] tty/8250: Add sleep capability to XR17D15X ports
Date: Tue, 20 Nov 2012 13:33:39 -0600
Message-ID: <CAJp1Oe6-i0hFu79D-1LYksp5cbEM8CSu+aOH7yFHoTpFmEzViQ@mail.gmail.com>
References: <CAJp1Oe4UiEpt4fXMD5X=bPR8q4-y3RsLGgFa3MGxbvvDauiwbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:57283 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab2KTTeA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Nov 2012 14:34:00 -0500
Received: by mail-vc0-f174.google.com with SMTP id m18so2757557vcm.19
        for <linux-serial@vger.kernel.org>; Tue, 20 Nov 2012 11:34:00 -0800 (PST)
In-Reply-To: <CAJp1Oe4UiEpt4fXMD5X=bPR8q4-y3RsLGgFa3MGxbvvDauiwbg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <greg@kroah.com>

On Tue, Nov 20, 2012 at 10:32 AM, Matt Schulte
<matts@commtech-fastcom.com> wrote:
> Add sleep capability to XR17D15X ports
>
> Signed-off-by: Matt Schulte <matts@commtech-fastcom.com>
> ---
> [PATCH 1/2] tty/8250: Add sleep capability to XR17D15X ports
> Built against tty-next commit: 1e619a1bf9ac878e6a984e4e279ccf712a65bc23
>
> This depends on my previous patch submission:
> [PATCH v3] Add support for new devices: Exar's XR17V35x family of
> multi-port PCIe UARTs
>
>  drivers/tty/serial/8250/8250.c |   12 +++++++++---

Alan, did you get a chance to look at this one?

Thanks,
Matt Schulte
