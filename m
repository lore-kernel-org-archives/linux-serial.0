From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] serial/amba-pl011: move custom pin control to driver
Date: Tue, 26 Jun 2012 02:46:57 +0800
Message-ID: <CACRpkdb9=m7Qiv+hQy3sDYAQNO5+_y5fW=av0-eW589qjL5TxQ@mail.gmail.com>
References: <1337800726-4076-1-git-send-email-linus.walleij@stericsson.com>
	<CAOh2x==OPVVLeKxCT0mkYX3NmOjGQRcsSY=GHCaHEJfy6wOg3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:52214 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754029Ab2FYSq6 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Jun 2012 14:46:58 -0400
Received: by qadb17 with SMTP id b17so1518152qad.19
        for <linux-serial@vger.kernel.org>; Mon, 25 Jun 2012 11:46:57 -0700 (PDT)
In-Reply-To: <CAOh2x==OPVVLeKxCT0mkYX3NmOjGQRcsSY=GHCaHEJfy6wOg3Q@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: viresh kumar <viresh.kumar@linaro.org>
Cc: Linus Walleij <linus.walleij@stericsson.com>, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>, spear-devel <spear-devel@list.st.com>

On Mon, Jun 25, 2012 at 7:31 PM, viresh kumar <viresh.kumar@linaro.org> wrote:

> People testing SPEAr with v3.5-rc1 saw that serial devices don't show
> up during boot and they
> actually return with error from this point, after Shawn's last patch.
> That will still happen with
> this patch i believe.
>
> What is expected from Platforms to handle this? AFAICR, we haven't
> done anything special
> to bind a pinctrl node to a struct dev for uart.

Yeah as Fabio pointed out, activate dummies is the quick
fix.

The "real" fix is to provide atleast a default pin map table
entry (sleep is not needed).

However I think you could benefit from using this on
SPEAr by providing two different pinconf lists for
the default and sleep modes as the ux500 does:
usually this saves some power.

Yours,
Linus Walleij
