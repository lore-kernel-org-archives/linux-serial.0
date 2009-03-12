From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Re: [PATCH] IRQ handling race and spurious IIR read
	in serial/8250.c
Date: Thu, 12 Mar 2009 21:38:31 +0000
Message-ID: <20090312213831.5045f5d0@lxorguk.ukuu.org.uk>
References: <874oxyei9k.fsf@pike.pond.sub.org>
	<20090312180955.1f52a401@lxorguk.ukuu.org.uk>
	<18873.25299.416627.13221@mariner.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <18873.25299.416627.13221@mariner.uk.xensource.com>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Ian Jackson <Ian.Jackson@eu.citrix.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Markus Armbruster <armbru@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Anders Kaseorg <andersk@MIT.EDU>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-serial@vger.kernel.org

>  1. It is definitely correct and does not introduce any new bugs.

Right ;)

>  2. It makes the existing bug definitely go away.  That is, after my
>     patch is applied the code drives the UART correctly - that is,
>     according to the specification and in a manner guaranteed to be

The UART hardware and specifications diverge - often quite spectacularly.

>  4. Any fix which does not involve completely removing UART_BUG_TXEN
>     will need my change.   

Or the locking fix

It was described as a band aid so I treated it as such. Regardless of the
right thing to do long term its not a 2.6.29 candidate at this point but
certainly something that wants looking into in 2.6.30
