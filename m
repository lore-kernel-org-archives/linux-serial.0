From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH 0/4] pch_uart: Cleanups, board quirks, and user uartclk parameter
Date: Wed, 22 Feb 2012 17:16:21 +0900
Message-ID: <CANKRQngnFhTY3-YxhDH3oufbqUu5pe36Fi58DjKWm=9uTigr-A@mail.gmail.com>
References: <cover.1329875301.git.dvhart@linux.intel.com>
	<CANKRQni9E6NO39MFSak6MjQ0DtmQeviGo966Ex9ZUvai56wCjg@mail.gmail.com>
	<4F4462B8.6030607@linux.intel.com>
	<CANKRQnhckD5Dt+0PbD3h=Ggz+U8RoDs0qUn5CgVnsYcH08tRkw@mail.gmail.com>
	<4F448DAA.6000207@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49274 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab2BVIQW (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 22 Feb 2012 03:16:22 -0500
In-Reply-To: <4F448DAA.6000207@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Feng Tang <feng.tang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

2012年2月22日15:39 Darren Hart <dvhart@linux.intel.com>:
> We can add a patch to this series that sets the
> default to 192MHz, drops the CM-iTC quirk, and does nothing in pch_phub
> probe for the FRI2.

If you set  the clock of pch_uart as 64MHz,
do you need to add quirk for FRI2 to pch_phub so as to provide 64MHz clock?

---
ROHM Co., Ltd.
tomoya
