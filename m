From: Roman Kurakin <rik@cronyx.ru>
Subject: serial driver problems (2.6.3)
Date: Tue, 02 Mar 2004 15:38:01 +0300
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <40448029.2060806@cronyx.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hanoi.cronyx.ru ([144.206.181.53]:62993 "EHLO hanoi.cronyx.ru")
	by vger.kernel.org with ESMTP id S261629AbUCBMfl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Mar 2004 07:35:41 -0500
Received: (from root@localhost) by hanoi.cronyx.ru
  id i22CZ4Lv036504 for linux-serial@vger.kernel.org.checked; (8.12.8/vak/2.1)
  Tue, 2 Mar 2004 15:35:04 +0300 (MSK) (envelope-from rik@cronyx.ru)
Received: from cronyx.ru (hi.cronyx.ru [144.206.181.94]) by hanoi.cronyx.ru with ESMTP
  id i22CYsW7036493 for <linux-serial@vger.kernel.org>; (8.12.8/vak/2.1)
  Tue, 2 Mar 2004 15:34:54 +0300 (MSK) (envelope-from rik@cronyx.ru)
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

    I have some problems with serial driver. I tried to run our async tests
and it seems that new serial driver has some problems. We use those tests
to check our hardware under Linux and FreeBSD.

    Tests cant be downloaded from:
http://www.cronyx.ru/~rik/asytest.tgz

We run this test with loopback on single com-port. I recommend to
run it with pseudo random pattern.

http://www.cronyx.ru/~rik/aiotest.tgz

This test runs over to com-ports connected by full null-modem cable.

Those tests works fine under FreeBSD and Linux prior 2.6.

Best regards,
                      Roman Kurakin




