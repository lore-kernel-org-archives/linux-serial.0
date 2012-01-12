From: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Subject: Re: mxs-auart serial driver DMA support?
Date: Thu, 12 Jan 2012 12:28:11 +0200
Message-ID: <4F0EB5BB.1060008@bluegiga.com>
References: <4F0E7EB0.2060906@bluegiga.com> <20120112094244.GA2775@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from bluegiga.fi ([194.100.31.45]:37028 "EHLO darkblue.bluegiga.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317Ab2ALK2O (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 12 Jan 2012 05:28:14 -0500
In-Reply-To: <20120112094244.GA2775@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-serial@vger.kernel.org

On 01/12/2012 11:42 AM, Wolfram Sang wrote:
>
>> Any plans to add DMA support for mxs-auart serial driver? I noticed
>> it is impossible to archive full 3.25 Mbs speed with current one.
>
> No plans from our side, currently.

OK, AUART works fine with 115200 bps but over that it loose data 
randomly. I have seen fifo overrun errors during receiving data with 
1Mbs and over. So current driver is unuseful with higher baud rates.

Regards,
Lauri
