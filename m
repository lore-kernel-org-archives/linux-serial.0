From: Andrei Warkentin <andreiw@motorola.com>
Subject: Newbie question: setting baudrate / managing FIFO.
Date: Wed, 16 Feb 2011 04:51:07 -0600
Message-ID: <AANLkTimdduXQaXJTuWPUKTFdQo9XOEYCkdNB_6RTVLFu@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from exprod5og116.obsmtp.com ([64.18.0.147]:38249 "EHLO
	exprod5og116.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab1BPLyp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Feb 2011 06:54:45 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p1GApKTC022411
	for <linux-serial@vger.kernel.org>; Wed, 16 Feb 2011 05:51:20 -0500 (EST)
Received: from mail-qw0-f42.google.com (mail-qw0-f42.google.com [209.85.216.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p1GAnX0F021582
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-serial@vger.kernel.org>; Wed, 16 Feb 2011 05:51:20 -0500 (EST)
Received: by mail-qw0-f42.google.com with SMTP id 4so1486222qwe.15
        for <linux-serial@vger.kernel.org>; Wed, 16 Feb 2011 02:51:08 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

I looked about the archives, but maybe I skipped something... When I
am handling set_termios, what assumptions can I make regarding the
TX/RX state? I didn't take a look at all the serial drivers, but the
ones I did look did not bother flushing FIFOs and ensuring nothing can
be present in the TX FIFO while updating LCR and divisors. Should I do
the equivalent of stop_tx inside set_termios? Is that already ensured?
The hardware I am looking at needs to have FIFO cleared after setting
baud rate, and I was getting concerned over potential data loss
scenarios...

Thanks,
A
