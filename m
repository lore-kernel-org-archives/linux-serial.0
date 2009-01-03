From: Oleg Kravchenko <oleg@kaa.org.ua>
Subject: gps on /dev/ttyS1
Date: Sat, 03 Jan 2009 16:08:24 +0200
Message-ID: <495F7158.8060504@kaa.org.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kaa.org.ua ([193.178.146.73]:33497 "EHLO kaa.org.ua"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753752AbZACOSp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 3 Jan 2009 09:18:45 -0500
Received: from [192.168.0.2] (passing.curtsy.volia.net [77.123.113.239])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by kaa.org.ua (Postfix) with ESMTPSA id DF58FC1526
	for <linux-serial@vger.kernel.org>; Sat,  3 Jan 2009 15:59:40 +0200 (EET)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello! I have gps device on ttyS1, but to use I must enable it by i2c-tools:
$ i2cset -y 0 0x20 2 0x80 b 0x80

and disable:
$ i2cset -y 0 0x20 2 0x0 b 0x80

I want add some wrapper code to start gps device when ttyS1 is open and 
shutdown device on close.
How is is easy to do?
