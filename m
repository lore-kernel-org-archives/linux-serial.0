From: mrc <j.marincic@imotec.nl>
Subject: Serial communication under real-time Timesys Linux
Date: Thu, 20 Jan 2005 11:09:10 +0100
Message-ID: <41EF8346.8020300@imotec.nl>
Reply-To: j.marincic@imotec.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from relay.introweb.nl ([80.65.96.45]:23777 "EHLO relay.introweb.nl")
	by vger.kernel.org with ESMTP id S262102AbVATKHF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 Jan 2005 05:07:05 -0500
Received: from brievenbus1.introweb.nl (frontend1 [192.168.4.31])
	by relay.introweb.nl (Postfix) with ESMTP id 8C899866BB4
	for <linux-serial@vger.kernel.org>; Thu, 20 Jan 2005 11:07:03 +0100 (CET)
Received: from mail.imotec.nl (ip114-73.dsl.introweb.nl [80.65.114.73])
	by brievenbus1.introweb.nl (Postfix) with ESMTP id 68F721071C
	for <linux-serial@vger.kernel.org>; Thu, 20 Jan 2005 11:07:03 +0100 (CET)
Received: from [192.168.1.73] (helo=[192.168.1.73])
	by mail.imotec.nl with esmtp (Exim 4.43)
	id 1CrZDT-0006rQ-7A
	for linux-serial@vger.kernel.org; Thu, 20 Jan 2005 11:07:03 +0100
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org


We are running hard RT and soft RT process under realtime OS Timesys
Linux on the industrial PC. Hard RT process has a 1 milisecond period
and soft RT runs with 300 milisecond period.

The Soft RT process is accessing the serial RS422 port and the driver
used is the Linux serial driver. (We have an RS422 card and the driver
is slightly modified by the manufacturer, but it is based on the Linux
driver).

The serial communication affects hard RT process performance which
results in its overruns. We suspect that the problem is in the serial
communication driver - either the interrupt routine is not preemptible
or the problem is that it uses jiffies or something else.

Does anyone know if there is a real-time serial driver available? Did
anyone have experience with Timesys Linux?

Thanks in advance.


