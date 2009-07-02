From: Manuel Jander <manuel.jander@gmail.com>
Subject: Serial loop back virtual device
Date: Thu, 2 Jul 2009 22:08:52 +0200
Message-ID: <21ed1c370907021308g18fb0ab5r895ee8871244a341@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:56604 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757377AbZGBUIv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 2 Jul 2009 16:08:51 -0400
Received: by fxm18 with SMTP id 18so1742520fxm.37
        for <linux-serial@vger.kernel.org>; Thu, 02 Jul 2009 13:08:53 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi there,

hopefuly this message is going to the right people. I wrote a small
virtual serial loop back driver and I have some questions in regard to
that.

First, the driver basically creates a set of serial port device pairs
(/dev/ttySL0, /dev/ttySL1, etc) and if some programs talks to one of
this ports, the counterpart port will receive all data and vice versa.
This is usful for writing a simulator of a hardware device which has a
serial port, without having to connect to real serial ports together
with a null modem cable or something like that. I'm using to develop a
simulator of Webasto W-Bus (ODB-II) car heating device. The driver can
optionally do line echo, required for K-Line emulation.

Now the questions:

- Did I really need to write a driver like this or are there any
trivial tricks to accomplish this somehow else ? Note, that the
software to talk to my simulator is a propietary windows executable
(using wine), thus I can not modify it. And my computer has only one
single serial port (and I would need to buy a second ODB-II hardware
adapter anyway, software is way much cheaper).

- Is this useful to anyone ? I think it is :) and it would be kind of
stupid if anyone requiring this would have to either use 2 hardware
ports or write another driver like this. But maybe I'm wrong, I dont
know.

- Is this driver worth to be part of the Linux mainline tree ?
Probably some adjustment would be required...

source code is available here:
http://micro.homelinux.net/~mjander/serial_loop.zip

It did built on  2.6.28, hopefuly it also does on the current vanilla tree.

Best Regards,
Manuel
