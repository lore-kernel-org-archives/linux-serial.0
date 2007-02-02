From: "Christopher Curtis" <ccurtis0@gmail.com>
Subject: Re: [BUG]: 2.6.19.2: Weird serial core issue
Date: Thu, 1 Feb 2007 22:34:52 -0500
Message-ID: <969d87000702011934p49414d1cwc3a0a63f11ec8cd@mail.gmail.com>
References: <6d6a94c50701310249o2b2c8024i4d3f28ec1601246a@mail.gmail.com>
	 <20070131162123.67e22e23@localhost.localdomain>
	 <6d6a94c50701311833m5952c6fdn8e1f0db28d674e79@mail.gmail.com>
	 <20070201094522.GA24608@flint.arm.linux.org.uk>
	 <6d6a94c50702010209t94964ew1aebfad2677aa315@mail.gmail.com>
	 <20070201111618.GA3462@flint.arm.linux.org.uk>
	 <6d6a94c50702010954g7cb769y8cba30fbad658984@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:45082 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669AbXBBDey (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Feb 2007 22:34:54 -0500
Received: by ug-out-1314.google.com with SMTP id 44so660529uga
        for <linux-serial@vger.kernel.org>; Thu, 01 Feb 2007 19:34:53 -0800 (PST)
In-Reply-To: <6d6a94c50702010954g7cb769y8cba30fbad658984@mail.gmail.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Aubrey Li <aubreylee@gmail.com>
Cc: linux-serial@vger.kernel.org

On 2/1/07, Aubrey Li <aubreylee@gmail.com> wrote:

> Yes, from the back trace stack, it appears to come from userspace. But
> I didn't startup any application. If there should be one, I think it's
> shell.

If you have a second way to access the computer (telnet, eg) log in
and do an strace of the shell.  Hit enter and see what it is doing.
You may find it enlightening.

As an example, see what bash does:

read(0, "\r", 1)                        = 1
write(2, "\n", 1)                       = 1
rt_sigprocmask(SIG_BLOCK, [INT], [], 8) = 0
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig -icanon
-echo ...}) = 0
ioctl(0, SNDCTL_TMR_STOP or TCSETSW, {B38400 opost isig icanon echo ...}) = 0
ioctl(0, SNDCTL_TMR_TIMEBASE or TCGETS, {B38400 opost isig icanon echo ...}) = 0
[...]

Chris
