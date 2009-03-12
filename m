From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] IRQ handling race and spurious IIR read in
 serial/8250.c
Date: Thu, 12 Mar 2009 18:09:55 +0000
Message-ID: <20090312180955.1f52a401@lxorguk.ukuu.org.uk>
References: <874oxyei9k.fsf@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <874oxyei9k.fsf@pike.pond.sub.org>
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Markus Armbruster <armbru@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Ian, Jackson <Ian.Jackson@eu.citrix.com>, linux-kernel@vger.kernel.org, Anders Kaseorg <andersk@MIT.EDU>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, linux-serial@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-serial@vger.kernel.org

> Ian Jackson recently debugged a problem reported by Anders Kaseorg, and
> posted a fix (see http://lkml.org/lkml/2009/2/11/240).  As far as I can
> see, the patch has been dropped on the floor.

It was proposed as a band aid fix not a real fix. The real fix involves
finishing sorting out any locking issues Ian identified. I've not seen a
patch for that yet.
