From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] serial/imx: enable the clock when we really use the uart port
Date: Sun, 10 Jun 2012 14:31:26 -0300
Message-ID: <CAOMZO5DtC3yK7RgtbjefepQXk2jE+tODmivw+CC_hd5TCCe-oA@mail.gmail.com>
References: <1335946770-17120-1-git-send-email-b32955@freescale.com>
	<20120502081902.GT4141@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:49687 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab2FJRb1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 10 Jun 2012 13:31:27 -0400
Received: by bkcji2 with SMTP id ji2so2946288bkc.19
        for <linux-serial@vger.kernel.org>; Sun, 10 Jun 2012 10:31:26 -0700 (PDT)
In-Reply-To: <20120502081902.GT4141@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Huang Shijie <b32955@freescale.com>, gregkh@linuxfoundation.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, alan@linux.intel.com

Huang,

On Wed, May 2, 2012 at 5:19 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Wed, May 02, 2012 at 04:19:30PM +0800, Huang Shijie wrote:
>> The current code keeps the clock enabled even when we do not really
>> use the uart port. But keep the clock enabled will consume some power.
>>
>> In order to save more power, disable the clock when we do not use
>> the uart, and enable the clock when we really use the uart port.
>>
>> Signed-off-by: Huang Shijie <b32955@freescale.com>
>
> This conflicts with my series converting i.MX to the common clock
> framework. Please lets delay this until this has been merged.

I think it is OK to resubmit this patch now.
