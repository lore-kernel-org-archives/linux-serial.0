From: viresh kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] serial/amba-pl011: move custom pin control to driver
Date: Mon, 25 Jun 2012 14:17:16 +0100
Message-ID: <CAOh2x=m0PAtaJszeYzL0cYLMYAyDUHgEoP=fGx1qxa_5FHTxHw@mail.gmail.com>
References: <1337800726-4076-1-git-send-email-linus.walleij@stericsson.com>
	<CAOh2x==OPVVLeKxCT0mkYX3NmOjGQRcsSY=GHCaHEJfy6wOg3Q@mail.gmail.com>
	<CAOMZO5DoO32LZyZAqrY=ut5HN=bEf7UgAhVkRBwZzrexeTKOXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:44455 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936Ab2FYNRQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Jun 2012 09:17:16 -0400
Received: by obbuo13 with SMTP id uo13so6448096obb.19
        for <linux-serial@vger.kernel.org>; Mon, 25 Jun 2012 06:17:16 -0700 (PDT)
In-Reply-To: <CAOMZO5DoO32LZyZAqrY=ut5HN=bEf7UgAhVkRBwZzrexeTKOXA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, spear-devel <spear-devel@list.st.com>, linux-serial@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

On Mon, Jun 25, 2012 at 2:09 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Jun 25, 2012 at 8:31 AM, viresh kumar <viresh.kumar@linaro.org> wrote:
>> What is expected from Platforms to handle this? AFAICR, we haven't
>> done anything special
>> to bind a pinctrl node to a struct dev for uart.
>
> Does using "pinctrl_provide_dummies()" fix this problem?

I have seen imx patches using this stuff and probably it will fix our
problem. We are
checking and will come back tomorrow.

--
viresh
