From: "johnny" <johnny@pan-tone.com.sg>
Subject: RE: Help:Serial / Parallel Port Control Under Linux
Date: Wed, 8 Oct 2008 12:01:30 +0800
Message-ID: <C524BFB0588A46AFA3D2DCEF28D7FB4B@johnny>
References: <709406A39EA948FCB5AE537FF0873FAD@johnny> <gc5a30$lup$1@ger.gmane.org> <4C87D88DE2D24B98846B72330EAE7229@johnny> <48E9D682.3030204@fela.ch>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from netsmtp-a.singnet.com.sg ([165.21.1.25]:34481 "EHLO
	netsmtp-a.singnet.com.sg" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbYJHEBl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Oct 2008 00:01:41 -0400
Received: from ovscan55.singnet.com.sg (ovscan55.singnet.com.sg [165.21.101.72])
	by netsmtp-a.singnet.com.sg (8.14.2/8.13.5) with ESMTP id m9841Wtc006503
	for <linux-serial@vger.kernel.org>; Wed, 8 Oct 2008 12:01:38 +0800
Received: from netsmtp-b.singnet.com.sg (netsmtp-b.singnet.com.sg [165.21.1.28])
	by ovscan55.singnet.com.sg (8.13.6/8.13.6) with ESMTP id m9841Vx7005166
	for <linux-serial@vger.kernel.org>; Wed, 8 Oct 2008 12:01:31 +0800
Received: from singnet.com.sg (bizw20.singnet.com.sg [165.21.111.20])
	by netsmtp-b.singnet.com.sg (8.14.2/8.13.5) with SMTP id m9841VMt018911
	for <linux-serial@vger.kernel.org>; Wed, 8 Oct 2008 12:01:31 +0800
In-Reply-To: <48E9D682.3030204@fela.ch>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Andreas Stricker' <andreas.stricker@fela.ch>, linux-serial@vger.kernel.org

I realized that I need to #include iotcl.h as well in order to use TIOCMGET
constant.

If I want to run this small program continuously and detect the changes of
the input pins all the time, can I simply use an infinite loop to do that?
Does it anything wrong to the serial port?

Thanks & Best Regards,
 
Johnny Xing
-----Original Message-----
From: linux-serial-owner@vger.kernel.org
[mailto:linux-serial-owner@vger.kernel.org] On Behalf Of Andreas Stricker
Sent: 2008年10月6日 17:13
To: linux-serial@vger.kernel.org
Subject: Re: Help:Serial / Parallel Port Control Under Linux

johnny schrieb:
> serialIO.c:195: error: `TIOCMGET' undeclared (first use in this function)

Did you include termios.h? (See `man ioctl_list`)

Regards,
Andy
--
To unsubscribe from this list: send the line "unsubscribe linux-serial" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


