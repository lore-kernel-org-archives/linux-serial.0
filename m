From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH] pch_uart: Change default UART clock setting 192MHz
Date: Wed, 22 Feb 2012 08:43:37 +0900
Message-ID: <CANKRQnjMAVBf2wn01eFD1CKTgtWyhzk2_epz-YprZp3eS1wmMg@mail.gmail.com>
References: <1329800140-4279-1-git-send-email-tomoya.rohm@gmail.com>
	<4F43C15D.6080401@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:51902 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753956Ab2BUXni (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 21 Feb 2012 18:43:38 -0500
In-Reply-To: <4F43C15D.6080401@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com, feng.tang@intel.com

2012年2月22日1:07 Darren Hart <dvhart@linux.intel.com>:
>  When does the phub driver update the clock registers?

I've already posted pch_phub patch for 192MHz setting.
You can see the patch form below.
>> Signed-off-by: Tomoya MORINAGA <tomoya.rohm@gmail.com>
>> ---
>> Related patch is
>> http://marc.info/?l=linux-kernel&m=132979974907774&w=2

---
ROHM Co., Ltd.
tomoya
