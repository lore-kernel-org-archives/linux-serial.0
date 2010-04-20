From: "Kittlitz, Edward (Ned)" <ned.kittlitz@alcatel-lucent.com>
Subject: handling flow control for console device
Date: Tue, 20 Apr 2010 14:08:16 -0500
Message-ID: <C1859C32A5123B49B7BC37C19355B37A24F842695D@USNAVSXCHMBSA3.ndc.alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ihemail4.lucent.com ([135.245.0.39]:39361 "EHLO
	ihemail4.lucent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379Ab0DTTR0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 20 Apr 2010 15:17:26 -0400
Received: from usnavsmail1.ndc.alcatel-lucent.com (usnavsmail1.ndc.alcatel-lucent.com [135.3.39.9])
	by ihemail4.lucent.com (8.13.8/IER-o) with ESMTP id o3KJ8IQV006242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-serial@vger.kernel.org>; Tue, 20 Apr 2010 14:08:20 -0500 (CDT)
Received: from USNAVSXCHHUB01.ndc.alcatel-lucent.com (usnavsxchhub01.ndc.alcatel-lucent.com [135.3.39.110])
	by usnavsmail1.ndc.alcatel-lucent.com (8.14.3/8.14.3/GMO) with ESMTP id o3KJ8Fhc005139
	for <linux-serial@vger.kernel.org>; Tue, 20 Apr 2010 14:08:18 -0500
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Hello,

I've been trying to figure out the Linux philosophy on
flow control for console devices.

We have several situations where flow control
can stop bootup or normal operation.  For us, it's more
important that things keep running; console output has
lower priority.

I thought there would be some way to forcibly disable
flow control for the console. But I can not find any way
to do it.  In my case, it's XOFF flow control.

I have searched multiple online system admin books and
also some kernel books, and don't see much discussion of
flow control.  There's a bit about enabling RTS/CTS flow
control in bootargs, but nothing about a big hammer to avoid
the problem.

Some examples:

- I think XOFF can happen while RC scripts are running,
  and bootup stops.  I think that the RC scripts start running
  without a control terminal, but at some point a script
  does something that attaches one.

  *1 I haven't figured outwhere I might be able to put
  an 'stty -ixon' in the rc processing.
  I think the problem happens when rc3.d is processed.

- login as root can be blocked because login is trying to
  write a message to the console. e.g. user is logged
  in on console and has sent XOFF.

  *2 I have not found a way to force getty to start
  with -ixon for the console device.

*1/*2 neither of these solutions make me totally happy,
but they might be good enough.

I'd like to be able to fix this in the kernel
and/or OS files, and not rely on external equipment
configuration. It's hard to control customers.

DETAILS:

I'm working on embedded system boards using powerpc
CPUs and uboot. We have private drivers.
bootargs specifies the device:
   console=ttySCS1,9600
Also, I have an inittab login on this device
(not on "console").

Most stty operations do not get to UART_set_termios(),
so I can not even put a hack in our driver that would
always disable flow control (XOFF and RTS/CTS).

We first saw this problem in our lab, on a board with
the DB9 connected to a terminal server.  The T.S.
has large buffers. I believe it will send XOFF if
the buffer fills, and it will not send XON until
somebody opens a session to the T.S. port. I assume it
will send more XOFF characters if it receives more
data from the DB9.

Thanks for any comments or suggestions,
 Ned Kittlitz
