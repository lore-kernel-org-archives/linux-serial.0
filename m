From: Ian Jackson <Ian.Jackson@eu.citrix.com>
Subject: Re: [PATCH] IRQ handling race and spurious IIR read in
	serial/8250.c
Date: Thu, 12 Mar 2009 19:30:27 +0000
Message-ID: <18873.25299.416627.13221@mariner.uk.xensource.com>
References: <874oxyei9k.fsf@pike.pond.sub.org>
	<20090312180955.1f52a401@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20090312180955.1f52a401@lxorguk.ukuu.org.uk>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Markus Armbruster <armbru@redhat.com>, Anders Kaseorg <andersk@MIT.EDU>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-serial@vger.kernel.org

Alan Cox writes ("Re: [PATCH] IRQ handling race and spurious IIR read in serial/8250.c"):
> > Ian Jackson recently debugged a problem reported by Anders Kaseorg, and
> > posted a fix (see http://lkml.org/lkml/2009/2/11/240).  As far as I can
> > see, the patch has been dropped on the floor.
> 
> It was proposed as a band aid fix not a real fix. The real fix involves
> finishing sorting out any locking issues Ian identified. I've not seen a
> patch for that yet.

The patch I have provided and which Markus has reposted has these
properties:

 1. It is definitely correct and does not introduce any new bugs.

 2. It makes the existing bug definitely go away.  That is, after my
    patch is applied the code drives the UART correctly - that is,
    according to the specification and in a manner guaranteed to be
    reliable - even though the code may still mistakenly set a bug
    flag;

 3. Without it the code is definitely wrong;

 4. Any fix which does not involve completely removing UART_BUG_TXEN
    will need my change.   

Or to put it another way

                        UART_BUG_TXEN           UART_BUG_TXEN
                        incorrectly set         behaviour

    Current code         Sometimes in VMs        Breaks correct systems
                         Rarely in baremetal?    (observed in production)

    With my patch        Sometimes in VMs        Always correct.
                         (behaviour unchanged)   Minor possible
                                                  performance problem.

    Perfect code         Perhaps feature         If retained, should
                         should be removed?       be correct.  Minor
                                                  performance impact
                                                  is acceptable.

My patch is therefore a strict improvement and also a likely component
of many of the possible ultimate fixes; the other ultimate fixes
involve removing entirely the code which I am now proposing to patch.

Please do not block this bugfix just because I haven't been able to
conclusively determine whether the buggy-without-my-patch workaround
should be entirely removed, and just because I do not fix every other
bug in the same area.

In particular, the fact that the detection of UART_BUG_TXEN remains
buggy is not a reason to block a patch which makes UART_BUG_TXEN's
effects correct.

As you can see `perfect code' is not yet attainable because the people
who originally implemented UART_BUG_TXEN don't seem to be around right
now to ask, and we don't have a 100% clear description of the buggy
behaviour it is trying to detect, and so we don't know whether it can
safely be removed.

Ian.
