From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/3] 8250: add workaround for MPC8[356]xx UART break IRQ
 storm
Date: Fri, 2 Dec 2011 11:27:12 -0600
Message-ID: <4ED90A70.8000902@freescale.com>
References: <1322783258-20443-1-git-send-email-paul.gortmaker@windriver.com>	<1322783258-20443-4-git-send-email-paul.gortmaker@windriver.com>	<4ED812E4.60905@freescale.com>	<4ED81632.3030809@windriver.com>	<176AE2A1-6AA2-4F14-942F-8ED77AB1DBEC@kernel.crashing.org> <20111202113059.15d73840@lxorguk.ukuu.org.uk> <4ED8FE14.7020007@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe010.messaging.microsoft.com ([216.32.180.30]:32682
	"EHLO VA3EHSOBE010.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757157Ab1LBR1U (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Dec 2011 12:27:20 -0500
In-Reply-To: <4ED8FE14.7020007@windriver.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Kumar Gala <galak@kernel.crashing.org>, gregkh@suse.de, alan@linux.intel.com, linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

On 12/02/2011 10:34 AM, Paul Gortmaker wrote:
> On 11-12-02 06:30 AM, Alan Cox wrote:
>>>> OK, I'll simply change the above to CONFIG_PPC then.
>>>
>>> It does, the bug is in the uart IP which I don't think we ever plan on fixing, so 32 or 64-bit parts will have it for ever and ever ;)
>>
>> It should be runtime selected, there should be no ifdefs here.
> 
> The ifdef wasn't strictly required; it just made it so gcc would
> toss the errata code out of the irq handler for !PPC.  Anyway it
> will be a moot point if I can somehow hide all the mess by snooping
> serial_inp() traffic and deploying the errata fix from there....

Eww.

If it's not to be allowed in the main 8250 code (even for ppc builds
only), a custom handle_port sounds like a saner option.

-Scott

