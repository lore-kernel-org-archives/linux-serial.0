From: Jim Brain <brain@jbrain.com>
Subject: Transmitting chars when DTR/RTS are low
Date: Tue, 23 Mar 2004 23:28:47 -0600
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <40611C8F.6040806@jbrain.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sccmmhc02.asp.att.net ([204.127.203.184]:36538 "EHLO
	sccmmhc02.asp.att.net") by vger.kernel.org with ESMTP
	id S263007AbUCXF3I (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 24 Mar 2004 00:29:08 -0500
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I apologize in advance if this is a FAQ, as I have scoured newsgroups
and web pages for a few days looking for the answer, to no avail, but
many folks in this area seemed to have lots of related wisdom.  If you
will indulge me:

I am writing an application that will emulate a modem on Linux (so that
older apps that expect a modem and an AT command set can be null-modem
connected to a Linux PC and never know the difference.  Instead of phone
line, the connection will be IP (atdt192.168.0.1:23 etc.)  There are a
few other attempts out there, but the ones I find are either commercial
or with Windows.

I have written the application, and almost all of it is working.  Both
sides can communicate, and all seems well.  However, many null modem
cables place DCD with the DTR pin.  In order, thus, to emulate a DCD to
the non PC system, I need to bring DTR low until an IP connection comes in.

This is my problem.  When I do that, the 16550A I have cannot send any
characters out.  I would chalk it up to that being the way it is, but I
have here right next to me a Windows applicaiton that is doing the exact
same thing, and all is working well.  I see DTR and RST low on my modem
line tester, and I can send and receive chars from COM1 via Win32.

I have read all of char/serial.c, and cannot see the issue from there.

I am using CLOCAL on my setattr.  Seeing a post in here from long ago
about misuse of TIOCMSET and TIOCMGET in setting DTR lines and such low
(and clobbering OUT1 and OUT2), I switched my code tonight to:

  int status;
  //old code
  //ioctl(cfg->fdTTY, TIOCMGET, &status);
  //status &= ~TIOCM_DTR;
  //ioctl(cfg->fdTTY, TIOCMSET, &status);
  status = TIOCM_DTR;
  ioctl(cfg->fdTTY, TIOCMBIC, &status);
  printf("Dropping DSR\n");
  return status;

with no luck.

I surmise that I am stepping out of the bounds of what Linux wants to do
with a serial port, but I refuse to believe it cannot be done.  I can
only assume I am missing some trivial item...  I looked at DZCOMM, but
it simply maps into the same APIs I am using.

Would anyone have a clue as to my error?  I can send source if wanted
(it's open source, and only 42kB of an app at that).

Jim Brain


