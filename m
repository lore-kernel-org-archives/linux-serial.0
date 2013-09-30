From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: tty loop-back device
Date: Mon, 30 Sep 2013 22:28:59 +0000 (UTC)
Message-ID: <l2ctvb$nd3$1@ger.gmane.org>
References: <l26jrq$48d$1@ger.gmane.org> <l26uk7$id2$2@ger.gmane.org>
 <l2736h$db0$1@ger.gmane.org> <l27esn$cn6$1@ger.gmane.org>
 <l286bm$239$1@ger.gmane.org> <l28jnt$j67$1@ger.gmane.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:59838 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754561Ab3I3W3X (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 30 Sep 2013 18:29:23 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <lnx-linux-serial@m.gmane.org>)
	id 1VQlxt-000330-Pm
	for linux-serial@vger.kernel.org; Tue, 01 Oct 2013 00:29:17 +0200
Received: from dsl.comtrol.com ([64.122.56.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 01 Oct 2013 00:29:17 +0200
Received: from grant.b.edwards by dsl.comtrol.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Tue, 01 Oct 2013 00:29:17 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

On 2013-09-29, Matwey V. Kornilov <matwey.kornilov@gmail.com> wrote:
> 29.09.2013 07:21, Grant Edwards ?????:
>> I was thinking about initially just creating a blocking ioctl() call
>> that the master can use to wait for either a termios configuration
>> change or a modem control line change.  I admit that's not as elegent:
>> it would mean a master would need multiple threads in most cases (one
>> for data and one for config and modem status).  But, it may be a less
>> intrusive change [I haven't looked at the poll implementation in any
>> detail, so perhaps the poll change isn't as bad as I fear.]
>
> The simplier way is to use master in 'packet mode' (see TIOCPKT). Then 
> we can distinguish stream data from termios notification for every 
> master's read. It either starts with '\0' and the following is the data 
> to transmit or with control symbol and then master have to use ioctl to 
> read new tty->termios.

I can't believe I didn't know about packet mode.  That's exactly what
is needed.  Defining two new bits (e.g. TIOCPKT_TERMIOS, TIOCPKT_MSET)
would pretty much take care of things.  Just a single new bit to
notify of changes to either termios or modem lines would be good
enough.

> We need way more ioctls. Since every new slave pty is enumerated
> almost randomly (depends on how many sessions is opened, opening
> order, etc), we have to mark somehow the pty when the daemon creates
> it, then udev should be able to create appropriate symbolic link for
> client user-space application. Then user-space client may be
> configured to work with /dev/tty/by-name/uniqname for instance.

I've never looked at how pty slave side device nodes get named...

-- 
Grant Edwards               grant.b.edwards        Yow! I just forgot my whole
                                  at               philosophy of life!!!
                              gmail.com            

