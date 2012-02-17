From: John Crispin <blogic@openwrt.org>
Subject: Re: [PATCH 7/9] SERIAL: MIPS: lantiq: convert serial driver to clkdev
 api
Date: Fri, 17 Feb 2012 17:47:47 +0100
Message-ID: <4F3E84B3.1030201@openwrt.org>
References: <1329474800-20979-1-git-send-email-blogic@openwrt.org> <1329474800-20979-8-git-send-email-blogic@openwrt.org> <4F3E90C4.8010904@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:55764 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582Ab2BQQr4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 17 Feb 2012 11:47:56 -0500
In-Reply-To: <4F3E90C4.8010904@mvista.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, linux-serial@vger.kernel.org

Hi Sergei,

>    The comment doesn't match the essence of patch.
>

sorry

>    Why not just clk_get(&pdev->dev, NULL)?
>
> WBR, Sergei
>


clk_get_sys uses the clkdev lookup table, which is added by this series.
it makes the clock code consistent throughout the lantiq related files.
we use clk connections other places, which we cannot reference with
clk_get that easily

John
