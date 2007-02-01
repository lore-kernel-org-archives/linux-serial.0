From: "Aubrey Li" <aubreylee@gmail.com>
Subject: Re: [BUG]: 2.6.19.2: Weird serial core issue
Date: Thu, 1 Feb 2007 18:38:20 +0800
Message-ID: <6d6a94c50702010238p7866f5a5m8824d2ca518eb704@mail.gmail.com>
References: <6d6a94c50701311833m5952c6fdn8e1f0db28d674e79@mail.gmail.com>
	 <000201c745d9$4577fe20$2e01a8c0@acksys.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:40525 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422751AbXBAKiV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Feb 2007 05:38:21 -0500
Received: by wx-out-0506.google.com with SMTP id h31so505662wxd
        for <linux-serial@vger.kernel.org>; Thu, 01 Feb 2007 02:38:20 -0800 (PST)
In-Reply-To: <000201c745d9$4577fe20$2e01a8c0@acksys.local>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tosoni <jp.tosoni@acksys.fr>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Alan <alan@lxorguk.ukuu.org.uk>

On 2/1/07, Tosoni <jp.tosoni@acksys.fr> wrote:
> If I understand Alan'answer correctly:
>
> You appear to use a *shell* on that console. The shell gets your ENTER key
> and in the succeeding processing the shell resets the crtscts flag to what
> the shell thinks is right for him.
>
> The shell must make some tty tweaking in order to allow you to edit the
> commands.
>
> You must disable login, shell and anything on that port in order to make a
> significant test. But beware that in this case you will close and reopen the
> port each time you run your test.
>

But the problem seems not like you said.
if enable crtscts by default, your thoughts makes sense.
But if disable crtscts by default, the fact is not as your thoughts.
The following is the test result on my side.
===================================
root:~> cflag = 0x80001cb1, old = 0x1cb1

cflag = 0x1cb1, old = 0x80001cb1
cflag = 0x1cb1, old = 0x1cb1
===================================
When run "stty -F /dev/ttyS0 crtscts",
I got
------------
root:~> cflag = 0x80001cb1, old = 0x1cb1
------------
That means crtscts in the old terminal setting is disabled. Now it's enabled.


But When I type "ENTER" key,

I got
------------
cflag = 0x1cb1, old = 0x80001cb1
cflag = 0x1cb1, old = 0x1cb1
------------
That means terminal setting is back to crtscts disabled. But here I
didn't do anything to disable it, I just type "ENTER", crtscts setting
should keep enabled. What makes it back to disabled? Now I guess there
must be something wrong with serial core.

-Aubrey
