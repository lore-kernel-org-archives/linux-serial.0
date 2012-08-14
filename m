From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Powerpc 8xx CPM_UART delay in receive
Date: Tue, 14 Aug 2012 15:52:27 +0100
Message-ID: <20120814155227.018988da@pyramind.ukuu.org.uk>
References: <201208141426.q7EEQSPc003956@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201208141426.q7EEQSPc003956@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Alan Cox <alan@linux.intel.com>, Vitaly Bordug <vitb@kernel.crashing.org>, Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

On Tue, 14 Aug 2012 16:26:28 +0200
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> Hello,
> 
> I'm not sure who to address this Patch to either
> 
> It fixes a delay issue with CPM UART driver on Powerpc MPC8xx.
> The problem is that with the actual code, the driver waits 32 IDLE patterns before returning the received data to the upper level. It means for instance about 1 second at 300 bauds.
> This fix limits to one byte the waiting period.

Take a look how the 8250 does it - I think you want to set the value
based upon the data rate. Your patch will break it for everyone doing
high seed I/O.

Alan
