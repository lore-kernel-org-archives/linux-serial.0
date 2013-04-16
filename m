From: John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH V2] tty: serial: ralink: fix SERIAL_8250_RT288X dependency
Date: Tue, 16 Apr 2013 18:11:08 +0200
Message-ID: <516D781C.8010206@openwrt.org>
References: <1366093125-19352-1-git-send-email-blogic@openwrt.org> <CAOiHx=npmzXe8yk1NLwzK0dQ-XsM-0bbT+L5Yg5LL05n0a3BKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:43004 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753110Ab3DPQPS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Apr 2013 12:15:18 -0400
In-Reply-To: <CAOiHx=npmzXe8yk1NLwzK0dQ-XsM-0bbT+L5Yg5LL05n0a3BKA@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonas Gorski <jogo@openwrt.org>, linux-serial@vger.kernel.org, linux-mips@linux-mips.org

> This won't work, Having RALINK=y, but SERIAL_8250=n will still result
> in SERIAL_8250_RT288X=y, as select ignores dependencies. What could
> work is removing the select from RALINK, and changing the depends from
> this one to "default y if SERIAL_8250&&  MIPS&&  RALINK".
>
>

ok, these tty patches were rushed too much. i think trying to get them 
ready quickly for 3.10 was a bad bad idea, that already wasted too much 
of other peoples time. instead of making even more of a fool of myself 
and wasting yet more time we should just drop it and i will try again 
with more time for 3.11.

Sorry for the noise :-)
     John
