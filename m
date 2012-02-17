From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 7/9] SERIAL: MIPS: lantiq: convert serial driver to clkdev
 api
Date: Fri, 17 Feb 2012 20:53:39 +0300
Message-ID: <4F3E9423.2000502@mvista.com>
References: <1329474800-20979-1-git-send-email-blogic@openwrt.org> <1329474800-20979-8-git-send-email-blogic@openwrt.org> <4F3E90C4.8010904@mvista.com> <4F3E84B3.1030201@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35180 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942Ab2BQQyU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Feb 2012 11:54:20 -0500
Received: by bkcjm19 with SMTP id jm19so3214218bkc.19
        for <linux-serial@vger.kernel.org>; Fri, 17 Feb 2012 08:54:18 -0800 (PST)
In-Reply-To: <4F3E84B3.1030201@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Crispin <blogic@openwrt.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, linux-serial@vger.kernel.org

Hello.

On 02/17/2012 07:47 PM, John Crispin wrote:

>>     The comment doesn't match the essence of patch.

> sorry

>>     Why not just clk_get(&pdev->dev, NULL)?

>> WBR, Sergei

> clk_get_sys uses the clkdev lookup table, which is added by this series.

    clk_get() does the same, indirectly.

> it makes the clock code consistent throughout the lantiq related files.
> we use clk connections other places, which we cannot reference with
> clk_get that easily

    clkdev assumes you don't need to use connection ID if the clock is bound to 
be matched by device ID via the lookup table. clk_get() is a common case when 
using clkdev, that's why your use of clk_get_sys() stands out as something 
unusual. I'll have to have a look at your lookup tables...

> John

WBR, Sergei
