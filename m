From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH 0/2] tty: serial: imx: fix lockup and garbage on SMP
Date: Tue, 28 Aug 2012 08:03:18 +0200
Message-ID: <503C5F26.4020108@de.bosch.com>
References: <1346053012-25686-1-git-send-email-dirk.behme@de.bosch.com> <20120827223134.GD2281@r65073-Latitude-D630> <20120827225142.GA11302@kroah.com> <20120827233756.GH2281@r65073-Latitude-D630>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp2-v.fe.bosch.de ([139.15.237.6]:25237 "EHLO
	smtp2-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465Ab2H1GGI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Aug 2012 02:06:08 -0400
In-Reply-To: <20120827233756.GH2281@r65073-Latitude-D630>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Alan Cox <alan@linux.intel.com>

On 28.08.2012 01:37, Shawn Guo wrote:
> On Mon, Aug 27, 2012 at 03:51:42PM -0700, Greg Kroah-Hartman wrote:
>> On both of them?  I can do that if needed.  How far back should they go?
>>
> It should be okay to apply on 3.4 and 3.5. 

For patch #1/2: Yes, thanks!

> But patch #2 is still in
> question.  I do not like the #ifdef.

For patch #2/2: Yes, understood. I'll look at Troy's proposal and will 
update #2/2.

Many thanks and best regards

Dirk
