From: viresh kumar <viresh.linux@gmail.com>
Subject: Re: [PATCH v3] serial: PL011: clear pending interrupts
Date: Thu, 22 Mar 2012 06:11:19 +0530
Message-ID: <CAOh2x=mrjzX=BuoQW+pdcHsdzyenXFEbt0jNTYf-HV0GNk--1Q@mail.gmail.com>
References: <1331641643-25929-1-git-send-email-linus.walleij@stericsson.com>
	<CAOh2x=nh-aiJ1FQecm=5WsNw=Fph5osNh5C2YU6x9TGrKBoMmA@mail.gmail.com>
	<CACRpkdZ-epTV8dAY4gT9HKgPifRS_wfooy0QqEGsSgCqZ98MYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49454 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096Ab2CVAlU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Mar 2012 20:41:20 -0400
Received: by wibhj6 with SMTP id hj6so99162wib.1
        for <linux-serial@vger.kernel.org>; Wed, 21 Mar 2012 17:41:19 -0700 (PDT)
In-Reply-To: <CACRpkdZ-epTV8dAY4gT9HKgPifRS_wfooy0QqEGsSgCqZ98MYw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Linus Walleij <linus.walleij@stericsson.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, Chanho Min <chanho0207@gmail.com>, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>, Jong-Sung Kim <neidhard.kim@lge.com>, stable@kernel.org, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>, spear-devel <spear-devel@list.st.com>

On Thu, Mar 22, 2012 at 12:38 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> Strange, because these changes are not even in 3.3. Did you mean 3.4
> HEAD?

Ya. you are correct, actually i was switching between both of them and so
wrote 3.3 :(

> The uap->port is likely the problem. The clock does not need to be
> enabled for this, the clock that need to be enabled is the pclk and that
> should be taken care of by the amba/primecell core.

Ya. I know uap->port is the problem. But i thought like normal platform drivers
writers: "we need to enable clk too". And i was wrong :(.

> I'm sending a fixup patch to sort out my own screwing up.

Waiting for that.

--
viresh
