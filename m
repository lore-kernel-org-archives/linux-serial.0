From: "Tony Chung" <tonychung00@gmail.com>
Subject: serial console hang problem
Date: Tue, 10 Jul 2007 17:51:58 -0700
Message-ID: <6c4b14140707101751x470848f1kb1d478f4a63f3d83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.235]:4094 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532AbXGKAv7 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 10 Jul 2007 20:51:59 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1200836nze
        for <linux-serial@vger.kernel.org>; Tue, 10 Jul 2007 17:51:58 -0700 (PDT)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

My serial console was running fine but then eventually hang with the
following messages:

INIT: Id "co" respawni
INIT: no more processe
INIT: Id "co" respawni
INIT: Id "co" respawni


I was able to ssh into the box and cat the content of /proc/interrupts
and found the following line is missing:

  4:        xxxxx             IO-APIC-edge  serial

When I did "init 5" and "init 3", I was able to get back my login
prompt and missing line in /proc/interrupts.

I will appreciate if someone can tell me how to debug the problem.
For example, under what circumstances, will the /proc/interrupts is
not reporting IRQ 4 ?
Thanks.

- Tony
