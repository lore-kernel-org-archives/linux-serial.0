From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: behavior with !PARENB and INPCK | IGNPAR
Date: Thu, 31 May 2007 03:18:23 -0400
Message-ID: <8bd0f97a0705310018m567333b2j2542ec9183942cd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.249]:41788 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbXEaHS0 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 31 May 2007 03:18:26 -0400
Received: by an-out-0708.google.com with SMTP id d31so25413and
        for <linux-serial@vger.kernel.org>; Thu, 31 May 2007 00:18:24 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Robin Getz <rgetz@blackfin.uclinux.org>

i'm trying to determine the expected behavior of a UART when PARENB is
turned off in c_cflag but INPCK and IGNPAR is enabled in c_iflag and
my googling / termios readings just lead me in vague directions

having PARENB turned off means that the UART should not be
transmitting with parity bits ... so you transmit 1 start bit, 8 bits
of data (CS8), and 1 stop bit

having INPCK and IGNPAR turned on means that the UART should be
receiving with parity bits ... so you receive 1 start bit, 8 bits of
data (CS8), 1 parity bit, and 1 stop bit

however, all the UARTs i look at dont have the ability to distinguish
between input and output parity settings ... parity is either enabled,
or it's disabled
-mike
