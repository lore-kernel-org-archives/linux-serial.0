From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git mast
  er
Date: Wed, 24 Jan 2007 22:40:46 +0300
Message-ID: <45B7B63E.70608@ru.mvista.com>
References: <45B78C19.4030408@pmc-sierra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751019AbXAXTkw@vger.kernel.org>
In-Reply-To: <45B78C19.4030408@pmc-sierra.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Cc: linux-mips@linux-mips.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello.

Marc St-Jean wrote:

>>http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc4/2.6.20-rc4-mm1/broken-out/8250-uart-backup-timer.patch

> This second patch failure description is identical to what we are seeing without
> the THRE work-around. This must be the timer patch Alan mentioned but it's not
> in the linux.git at l-m.o.

    Yeah, it must still be considered "experimental" as it resides only within 
the -mm tree.

> Could you please explain what you mean by and where I can find the "-mm tree"?

    http://kernel.org/patchtypes/mm.html

    As the serial drivers have no maintainer now, you probably have to CC the 
final patch to Andrew Morton (akpm@osdl.org), so it'd be better to be 
applicable against the recent -mm patch.

> Marc

MBR, Sergei
