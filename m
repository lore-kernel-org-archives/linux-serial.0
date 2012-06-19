From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC PATCH] pch_uart: Add eg20t_port lock field, avoid
 recursive spinlocks
Date: Tue, 19 Jun 2012 10:14:47 +0100
Message-ID: <20120619101447.74cbd9a1@pyramind.ukuu.org.uk>
References: <8854635ac5471f8671b93c65e3663eb1cb204c9d.1338454156.git.dvhart@linux.intel.com>
	<CANKRQnhZErpvcsRW3ukNzY0_zv4x=5OzQ-sr+aeuxL63=tQ=4A@mail.gmail.com>
	<4FC90BAD.3080606@linux.intel.com>
	<4FCE8307.3050901@linux.intel.com>
	<CANKRQnj5mxHLprMt4VMMa7sCwLZb=PAktnVVD1MZVkkUG4eLoA@mail.gmail.com>
	<4FDFA09A.4030405@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4FDFA09A.4030405@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Cc: Tomoya MORINAGA <tomoya.rohm@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Feng Tang <feng.tang@intel.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, 18 Jun 2012 14:41:46 -0700
Darren Hart <dvhart@linux.intel.com> wrote:

> 
> 
> On 06/05/2012 04:48 PM, Tomoya MORINAGA wrote:
> > On Wed, Jun 6, 2012 at 7:07 AM, Darren Hart <dvhart@linux.intel.com> wrote:
> >> Are there still concerns about the additional lock? I'll resend V2
> >> tomorrow with the single whitespace fix if I don't hear anything back today.
> > 
> > I understand your saying. Looks good.
> > However, I am not expert of linux-uart core system.
> > So, I'd like UART maintainer to give us your opinion.
> 
> Greg, Alan,
> 
> any concerns with the locking approach I've adopted in the patch?

Only the one I noted in my reply the first time around which is that you
can't permit tty->low_latency=1 unless your tty receive path is not an
IRQ path. From a locking point of view the change makes sense anyway.

Going back over it your console locking also needs care - an oops or
printk within the areas the private lock covers will hang the box. That
should also probably be a trylock style lock as with the other lock on
that path

Alan
