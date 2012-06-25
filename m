From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] serial/amba-pl011: move custom pin control to driver
Date: Mon, 25 Jun 2012 10:09:18 -0300
Message-ID: <CAOMZO5DoO32LZyZAqrY=ut5HN=bEf7UgAhVkRBwZzrexeTKOXA@mail.gmail.com>
References: <1337800726-4076-1-git-send-email-linus.walleij@stericsson.com>
	<CAOh2x==OPVVLeKxCT0mkYX3NmOjGQRcsSY=GHCaHEJfy6wOg3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44610 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275Ab2FYNJT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Jun 2012 09:09:19 -0400
Received: by bkcji2 with SMTP id ji2so3099586bkc.19
        for <linux-serial@vger.kernel.org>; Mon, 25 Jun 2012 06:09:18 -0700 (PDT)
In-Reply-To: <CAOh2x==OPVVLeKxCT0mkYX3NmOjGQRcsSY=GHCaHEJfy6wOg3Q@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: viresh kumar <viresh.kumar@linaro.org>
Cc: Linus Walleij <linus.walleij@stericsson.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, spear-devel <spear-devel@list.st.com>, linux-serial@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

Hi Viresh,

On Mon, Jun 25, 2012 at 8:31 AM, viresh kumar <viresh.kumar@linaro.org> wrote:

> What is expected from Platforms to handle this? AFAICR, we haven't
> done anything special
> to bind a pinctrl node to a struct dev for uart.

Does using "pinctrl_provide_dummies()" fix this problem?
