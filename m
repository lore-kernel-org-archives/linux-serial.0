From: Ian Jackson <Ian.Jackson@eu.citrix.com>
Subject: Re: [PATCH] Do not read IIR in serial8250_start_tx when
 UART_BUG_TXEN
Date: Thu, 19 Nov 2009 18:15:49 +0000
Message-ID: <19205.35669.210191.691969@mariner.uk.xensource.com>
References: <alpine.LSU.2.00.0911181101090.15039@wotan.suse.de>
	<alpine.LSU.2.00.0911191734570.15039@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.eu.citrix.com ([62.200.22.115]:52758 "EHLO
	SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbZKSSZf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 19 Nov 2009 13:25:35 -0500
In-Reply-To: <alpine.LSU.2.00.0911191734570.15039@wotan.suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Alan Cox <alan@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Greg Kroah-Hartman <gregkh@suse.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Markus Armbruster <armbru@redhat.com>, Michal Hocko <mhocko@suse.cz>

Jiri Kosina writes ("Re: [PATCH] Do not read IIR in serial8250_start_tx when UART_BUG_TXEN"):
> Does anyone have any comments about this please?
> 
> In a nutshell -- this is needed so that we make the UART_BUG_TXEN really 
> harmless (which I guess it originally inteded to be, but reading IIR has 
> some unwanted sideeffects and is in fact not needed).

Yes.

> We need to have this in to handle properly the cases in which BUG_TXEN is 
> misdetected, and we can't blacklist such systems as we do for some SoL 
> hardware (see commit b6adea334c6c (" 8250: fix boot hang with serial 
> console when using with Serial Over Lan port"). Also there doesn't seem to 
> be any straightforward way to workaround the misdetection, so this seems 
> to be proper fix, unbreaking all the possible scenarios.

Unless the code has changed, the UART_BUG_TXEN detection is
fundamentally broken and racy.  So fixing that too would be good (and
possible, when I looked at it).

But even without fixing the UART_BUG_TXEN detection, the IIR read is
absolutely and definitely wrong.  The only purpose of the IIR read is
to avoid an unnecessary but harmless call to transmit_chars.

It seems to me that the author of the UART_BUG_TXEN patch did not
appreciate that reading the IIR was not side effect free, and that
they were just trying a minor (and perhaps ill-advised) optimisation.

In any case we don't have any useful information (in comments or
commit logs) explaining why they did it this way and it is (a) easily
seen to be buggy and (b) causes actual real problems.

So my patch should be applied.  The last time we discussed this we had
some kind of FUD along the lines of "but real serial ports often have
bugs so you can't reason about them properly".  I don't think that's a
sensible basis for discussion.  How can it be falsified ?

If there is some specific bug that real ports have that might be
relevant, sure, take it into account.  But we should not have the
situation where we hear the mere assertion that there often are bugs;
therefore reasoning doesn't show change to be safe; therefore no
change can be made.

Ian.
