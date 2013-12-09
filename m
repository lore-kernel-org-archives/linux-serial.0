From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] serial: pl011: also enable DMA Rx polling with no
 platform data
Date: Mon, 9 Dec 2013 15:33:10 +0100
Message-ID: <CACRpkdZne6VQUgKWL7JvN+7PdwoV6K2Vebv=EWSJ6LMAym-ejg@mail.gmail.com>
References: <1385631664-32607-1-git-send-email-linus.walleij@linaro.org>
	<Pine.LNX.4.64.1312091229550.30018@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:36074 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760524Ab3LIOdL (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Dec 2013 09:33:11 -0500
Received: by mail-oa0-f45.google.com with SMTP id o6so3930335oag.18
        for <linux-serial@vger.kernel.org>; Mon, 09 Dec 2013 06:33:10 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1312091229550.30018@axis700.grange>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jongsung Kim <neidhard.kim@lge.com>, Chanho Min <chanho.min@lge.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <rmk+kernel@arm.linux.org.uk>

On Mon, Dec 9, 2013 at 12:53 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:

> An earlier patch "serial: pl011: use DMA RX polling by default" enabled
> DMA Rx polling on PL011 only in configurations, using platform data. A
> simple extension of that patch also enables DMA Rx polling when no
> platform data is used, e.g. in Device Tree configurations. In such cases
> a default poll timeout and an automatically calculated poll rate will be
> used.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Makes perfect sense.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
