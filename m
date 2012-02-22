From: Mayank Rana <mrana@codeaurora.org>
Subject: About changing Line Discipline  from Kernel
Date: Wed, 22 Feb 2012 12:35:16 +0530
Message-ID: <4F4493AC.5010405@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:44065 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab2BVHFZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Feb 2012 02:05:25 -0500
Received: from [10.44.21.72] (pdmz-snip-v218.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 720EE10004B6
	for <linux-serial@vger.kernel.org>; Tue, 21 Feb 2012 23:05:24 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi ,

I have few queries related to using Line Discipline.

1. I understand that line discipline can be changed from user space 
application by opening the device and doing ioctl with required Line 
Discipline ID. Is it possible to do the same from kernel module who 
would be communicating with that line discipline ?

2. Is it way to set default line discipline for particular tty device
to required Line Discipline instead of N_TTY one ?

Appreciate your help on this.

Regards,
_-_Mayank Rana_-_
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
