From: Jarek <jarek@poczta.srv.pl>
Subject: Debugging serial driver
Date: Fri, 28 Apr 2006 11:20:15 +0200
Message-ID: <1146216016.7371.9.camel@jarek.macro.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.srv.pl ([213.241.71.70]:39174 "EHLO beret.srv.pl")
	by vger.kernel.org with ESMTP id S965195AbWD1JUs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Apr 2006 05:20:48 -0400
Received: from (jarek.macro.local) [83.5.224.253]
	by beret.srv.pl with asmtp (Exim 3.36 #1 (Debian))
	id 1FZP9a-00085o-00
	for linux-serial@vger.kernel.org; Fri, 28 Apr 2006 11:20:46 +0200
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello!

	I've found some very strange problem. I've embedded device with linux
(kernel 2.6.14 at the moment) and sometimes, after unexpected power
failure, serial port stops receiving data. I can send data over the
port, but can't receive (just nothing arrives). If, in such case, I will
restart computer everything comes back to work. It happends for
different types of serial ports (there are two standard ports on board,
and 8 additional ports on advantech cards).
	How can I find where is the problem ?

best regards
Jarek.

