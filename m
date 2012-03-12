From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] Clear previous interrupts after fifo is disabled
Date: Mon, 12 Mar 2012 09:29:25 +0100
Message-ID: <CACRpkdayeUPFCzcKftAnkkLkB5QHhghtSxb4=uziDLDgGnsyGw@mail.gmail.com>
References: <CAOAMb1ASB0zznSSOAU9HgPNW2e=Do+8hSJ6JZ00DxtAxqsXyXQ@mail.gmail.com>
	<20120308184954.GA1275@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52748 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697Ab2CLI30 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Mar 2012 04:29:26 -0400
Received: by yhmm54 with SMTP id m54so2261391yhm.19
        for <linux-serial@vger.kernel.org>; Mon, 12 Mar 2012 01:29:25 -0700 (PDT)
In-Reply-To: <20120308184954.GA1275@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chanho Min <chanho0207@gmail.com>, Russell King <linux@arm.linux.org.uk>, Alan Cox <alan@linux.intel.com>, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>, "Kim, Jong-Sung" <neidhard.kim@lge.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Thu, Mar 8, 2012 at 7:49 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

> Can someone, if this is still needed, and everyone agrees on how to
> solve it, please send me the needed fix?

I've send a patch combining the probe() and startup() fixes from Russell
with the latest patch from Jong-Sung Kim into what may very well
be the silver bullet.
Subject "serial: PL011: clear pending interrupts"

Yours,
Linus Walleij
