From: Grant Edwards <grante@visi.com>
Subject: Re: Help:Serial / Parallel Port Control Under Linux
Date: Fri, 3 Oct 2008 14:26:40 +0000 (UTC)
Message-ID: <gc5a30$lup$1@ger.gmane.org>
References: <709406A39EA948FCB5AE537FF0873FAD@johnny>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:53246 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbYJCO0w (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 3 Oct 2008 10:26:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KllcG-0007mO-8z
	for linux-serial@vger.kernel.org; Fri, 03 Oct 2008 14:26:48 +0000
Received: from 64.251.14.41 ([64.251.14.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 03 Oct 2008 14:26:48 +0000
Received: from grante by 64.251.14.41 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-serial@vger.kernel.org>; Fri, 03 Oct 2008 14:26:48 +0000
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

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

