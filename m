From: "Oleksiy Kebkal" <kebkal@gmail.com>
Subject: Re: should RTS init in serial core be tied to CRTSCTS
Date: Fri, 9 Mar 2007 15:18:48 +0100
Message-ID: <57354eff0703090618q17d80f53p25b904d552fc30c@mail.gmail.com>
References: <8bd0f97a0703011603m794e00f5x875eb68ad0db05de@mail.gmail.com>
	 <200703080844.32157.rgetz@blackfin.uclinux.org>
	 <20070308134800.GA30023@flint.arm.linux.org.uk>
	 <200703081523.39698.rgetz@blackfin.uclinux.org>
	 <20070308204020.GE30023@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.185]:46105 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767314AbXCIOSv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 9 Mar 2007 09:18:51 -0500
Received: by nf-out-0910.google.com with SMTP id o25so1082549nfa
        for <linux-serial@vger.kernel.org>; Fri, 09 Mar 2007 06:18:49 -0800 (PST)
In-Reply-To: <20070308204020.GE30023@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Robin Getz <rgetz@blackfin.uclinux.org>, Oleksiy Kebkal <kebkal@gmail.com>, Krzysztof Halasa <khc@pm.waw.pl>, Mike Frysinger <vapier.adi@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

2007/3/8, Russell King <rmk+lkml@arm.linux.org.uk>:
> ... which occurs /after/ userspace is up and running, when sysfs is
> available.  So putting it in sysfs is reasonable.

Is it right place for serial settings?
/sys/class/tty/ttySN/

How far is it reasonable to split termios settings to the attributes?
1)
/sys/class/tty/ttyS0/termios
2)
/sys/class/tty/ttyS0/c_iflag
/sys/class/tty/ttyS0/c_oflag
/sys/class/tty/ttyS0/c_cflag
/sys/class/tty/ttyS0/c_lflag
/sys/class/tty/ttyS0/c_cc
3)
/sys/class/tty/ttyS0/speed
/sys/class/tty/ttyS0/eof
/sys/class/tty/ttyS0/eon
/sys/class/tty/ttyS0/erase
.... and so on


-Oleksiy
