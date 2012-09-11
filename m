From: Shubhrajyoti <shubhrajyoti@ti.com>
Subject: Re: [PATCH v4 00/21] OMAP UART Patches
Date: Tue, 11 Sep 2012 17:01:06 +0530
Message-ID: <504F20FA.7020003@ti.com>
References: <20120906122948.GC29202@arwen.pp.htv.fi> <1346935540-1792-1-git-send-email-balbi@ti.com> <87harahiv6.fsf@deeprootsystems.com> <20120907054932.GB3136@arwen.pp.htv.fi> <87oblhmu6g.fsf@deeprootsystems.com> <20120908190423.GA14771@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:51448 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759164Ab2IKLbO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Sep 2012 07:31:14 -0400
Received: by obbuo13 with SMTP id uo13so531781obb.19
        for <linux-serial@vger.kernel.org>; Tue, 11 Sep 2012 04:31:13 -0700 (PDT)
In-Reply-To: <20120908190423.GA14771@arwen.pp.htv.fi>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: balbi@ti.com
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Greg KH <gregkh@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, alan@linux.intel.com

On Sunday 09 September 2012 12:34 AM, Felipe Balbi wrote:
>> In addition, IMO, if this was only tested on Panda (as suggested by
>> > earlier cover letters), it really should not have been merged until it
>> > got some broader testing.
> Shubhro's got his Tested-by tag. I believe he tested on beagleboard and
> omap4sdp. Shubhro, can you confirm which platforms you tested the UART
> patches ? cheers
Felipe I had boot tested on omap3sdp and onap4 sdp and did pm testing
on both with omap3 hitting off.

