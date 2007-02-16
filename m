From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git master
Date: Fri, 16 Feb 2007 16:47:59 +0300
Message-ID: <45D5B60F.7020104@ru.mvista.com>
References: <200702151926.l1FJQT2o020816@pasqua.pmc-sierra.bc.ca> <20070215171035.83918aae.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030188AbXBPNsK@vger.kernel.org>
In-Reply-To: <20070215171035.83918aae.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Marc St-Jean <stjeanma@pmc-sierra.com>, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello.

Andrew Morton wrote:

>>+			status = *(volatile u32 *)up->port.private_data;

> It distresses me that this patch uses a variable which this patch
> doesn't initialise anywhere.  It isn't complete.

    I assume this gets passed via early_serial_setup(). Marc?

> The sub-driver code whch sets up this field shuld be included in the
> patch, no?

    Hardly so, this code (not a subdriver) resides under arch/mips/ I think.

WBR, Sergei
