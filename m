From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Powerpc 8xx CPM_UART delay in receive
Date: Thu, 16 Aug 2012 15:29:18 +0100
Message-ID: <20120816152918.5ed2649f@pyramind.ukuu.org.uk>
References: <201208141426.q7EEQSPc003956@localhost.localdomain>
 <20120814155227.018988da@pyramind.ukuu.org.uk>
 <502CF2A0.8080109@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <502CF2A0.8080109@c-s.fr>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: leroy christophe <christophe.leroy@c-s.fr>
Cc: Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

> The PowerPC CPM is working differently. It doesn't use a fifo but 
> buffers. Buffers are handed to the microprocessor only when they are 
> full or after a timeout period which is adjustable. In the driver, the 

Which is different how - remembering we empty the FIFO on an IRQ

> buffers are configured with a size of 32 bytes. And the timeout is set 
> to the size of the buffer. That is this timeout that I'm reducing to 1 
> byte in my proposed patch. I can't see what it would break for high 
> speed I/O.

How can a timeout be measured in "bytes". Can we have a bit more clarity
on how the hardware works and take it from there ?

Alan
