From: viresh kumar <viresh.linux@gmail.com>
Subject: Re: [PATCH] serial: PL011: move interrupt clearing
Date: Fri, 23 Mar 2012 09:09:16 +0530
Message-ID: <CAOh2x=kqTZxzyEMEF0bYFQ0a0zMEQNZWrzw48e1WFiMxYpRSeg@mail.gmail.com>
References: <1332357318-8017-1-git-send-email-linus.walleij@linaro.org>
	<CAOh2x==5QHEcA3h216p8rJukx0LR=cVcGYN84aqzw=fnhu8Y-g@mail.gmail.com>
	<CACRpkdate+sQJvS8H7qNXiwe6c+F58g=OF0Qg=TxxnTwPXBrYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:42804 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083Ab2CWDjS (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Mar 2012 23:39:18 -0400
In-Reply-To: <CACRpkdate+sQJvS8H7qNXiwe6c+F58g=OF0Qg=TxxnTwPXBrYQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Jong-Sung Kim <neidhard.kim@lge.com>, stable <stable@vger.kernel.org>, Chanho Min <chanho0207@gmail.com>, linux-arm-kernel@lists.infradead.org, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>, spear-devel <spear-devel@list.st.com>

On Thu, Mar 22, 2012 at 1:30 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Mar 22, 2012 at 2:04 AM, viresh kumar <viresh.linux@gmail.com> wrote:
>> You missed me in CC??
>
> I put you in Reported-by, then used --cc at the prompt because git send-email
> still does not realize it must put Reported-by: tags on the CC list.

That's strange. When i check my mail on @st.com id, i see myself in cc
list, but on
gmail i see following cc list in your first mail.

linux-serial@vger.kernel.org, Greg Kroah-Hartman
<gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>,
Jong-Sung Kim <neidhard.kim@lge.com>, stable <stable@vger.kernel.org>,
Chanho Min <chanho0207@gmail.com>,
linux-arm-kernel@lists.infradead.org, Shreshtha Kumar Sahu
<shreshthakumar.sahu@stericsson.com>

Why don't i see myself in cc here?

I have seen similar issues earlier too, with our ST internal and
Mainline mailing lists.
Any ideas?

--
viresh
