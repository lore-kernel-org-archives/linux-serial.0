From: "johnny" <johnny@pan-tone.com.sg>
Subject: RE: Help:Serial / Parallel Port Control Under Linux
Date: Mon, 6 Oct 2008 16:54:24 +0800
Message-ID: <4C87D88DE2D24B98846B72330EAE7229@johnny>
References: <709406A39EA948FCB5AE537FF0873FAD@johnny> <gc5a30$lup$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from netsmtp-b.singnet.com.sg ([165.21.1.28]:35412 "EHLO
	netsmtp-b.singnet.com.sg" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961AbYJFIyd (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 6 Oct 2008 04:54:33 -0400
Received: from ovscan55.singnet.com.sg (ovscan55.singnet.com.sg [165.21.101.72])
	by netsmtp-b.singnet.com.sg (8.14.2/8.13.5) with ESMTP id m968sOIZ029253
	for <linux-serial@vger.kernel.org>; Mon, 6 Oct 2008 16:54:30 +0800
Received: from netsmtp-a.singnet.com.sg (netsmtp-a.singnet.com.sg [165.21.1.25])
	by ovscan55.singnet.com.sg (8.13.6/8.13.6) with ESMTP id m968sO1T029671
	for <linux-serial@vger.kernel.org>; Mon, 6 Oct 2008 16:54:24 +0800
Received: from singnet.com.sg (bizw20.singnet.com.sg [165.21.111.20])
	by netsmtp-a.singnet.com.sg (8.14.2/8.13.5) with SMTP id m968sN2a002413
	for <linux-serial@vger.kernel.org>; Mon, 6 Oct 2008 16:54:24 +0800
In-Reply-To: <gc5a30$lup$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: 'Grant Edwards' <grante@visi.com>, linux-serial@vger.kernel.org

Hi, Grant, 

I have written a simple program based on the POXIS programming guide,
however, it seems that ioctl() function doesn't have a command of
'TIOCMGET'and 'TIOCMSET'.

I am currently using Centos system.

Do you know any other function which could control the serial port pin
status?


Error:

serialIO.c:195: error: `TIOCMGET' undeclared (first use in this function)
serialIO.c:195: error: (Each undeclared identifier is reported only once
serialIO.c:195: error: for each function it appears in.)
serialIO.c:207: error: `TIOCM_CD' undeclared (first use in this function)
serialIO.c:208: error: `TIOCM_CTS' undeclared (first use in this function)
serialIO.c:209: error: `TIOCM_DSR' undeclared (first use in this function)
serialIO.c:210: error: `TIOCM_RI' undeclared (first use in this function)
serialIO.c:212: error: `TIOCM_DTR' undeclared (first use in this function)
serialIO.c:215: error: `TIOCM_RTS' undeclared (first use in this function)
serialIO.c:223: error: `TIOCMSET' undeclared (first use in this function)

-----Original Message-----
From: linux-serial-owner@vger.kernel.org
[mailto:linux-serial-owner@vger.kernel.org] On Behalf Of Grant Edwards
Sent: 2008年10月3日 22:27
To: linux-serial@vger.kernel.org
Subject: Re: Help:Serial / Parallel Port Control Under Linux

On 2008-10-03, johnny <johnny@pan-tone.com.sg> wrote:

> Right Now I need to write a simple C code to control the
> serial / parallel port under linux working like this: Detect
> there is an input signal / voltage change and send some output
> signal / voltage accordingly, eg: if DSR is detected to be
> high, I want to set RTS to be high as well; if RI is detected
> to be high, I want DTR set to be low etc.
>
> I have read the Serial-How to and Serial programming-How to,
> however I am still not so clear regarding to this simple
> programming.

Ignore the serial programming howto.  It's out-of-date,
incomplete, unmaintained and just plain wrong in many areas. I
needs to be gotten rid of, but that doesn't seem to be
possible.

A far better source of information is the Serial Programming
Guide for Posix Operating Systems:

http://www.easysw.com/~mike/serial/serial.html

Specifically, the information about modem control and status
lines is in chapter 5.1:

http://www.easysw.com/~mike/serial/serial.html#5_1

-- 
Grant Edwards                   grante             Yow! Inside, I'm already
                                  at               SOBBING!
                               visi.com            

--
To unsubscribe from this list: send the line "unsubscribe linux-serial" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


