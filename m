From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] serial: PL011: move interrupt clearing
Date: Thu, 22 Mar 2012 09:00:44 +0100
Message-ID: <CACRpkdate+sQJvS8H7qNXiwe6c+F58g=OF0Qg=TxxnTwPXBrYQ@mail.gmail.com>
References: <1332357318-8017-1-git-send-email-linus.walleij@linaro.org>
	<CAOh2x==5QHEcA3h216p8rJukx0LR=cVcGYN84aqzw=fnhu8Y-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:51545 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755727Ab2CVIAp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Mar 2012 04:00:45 -0400
Received: by obbeh20 with SMTP id eh20so1323819obb.19
        for <linux-serial@vger.kernel.org>; Thu, 22 Mar 2012 01:00:45 -0700 (PDT)
In-Reply-To: <CAOh2x==5QHEcA3h216p8rJukx0LR=cVcGYN84aqzw=fnhu8Y-g@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: viresh kumar <viresh.linux@gmail.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Jong-Sung Kim <neidhard.kim@lge.com>, stable <stable@vger.kernel.org>, Chanho Min <chanho0207@gmail.com>, linux-arm-kernel@lists.infradead.org, Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>, spear-devel <spear-devel@list.st.com>

On Thu, Mar 22, 2012 at 2:04 AM, viresh kumar <viresh.linux@gmail.com> =
wrote:

>> Cc: Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>
>> Cc: Russell King <linux@arm.linux.org.uk>
>> Cc: stable <stable@vger.kernel.org>
>> Reported-by: Viresh Kumar <viresh.kumar@st.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> ---
>> =A0drivers/tty/serial/amba-pl011.c | =A0 =A08 ++++----
>> =A01 files changed, 4 insertions(+), 4 deletions(-)
>
> You missed me in CC??

I put you in Reported-by, then used --cc at the prompt because git send=
-email
still does not realize it must put Reported-by: tags on the CC list.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
