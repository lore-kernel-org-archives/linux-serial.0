From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 2/5] genirq: Add optional hardware synchronization for
 shutdown
Date: Wed, 26 Jun 2019 15:03:54 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1906261502450.32342@nanos.tec.linutronix.de>
References: <20190625111353.863718167@linutronix.de> <20190625112405.666964552@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625112405.666964552@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Robert Hodaszi <Robert.Hodaszi@digi.com>, Vadim Pasternak <vadimp@mellanox.com>, Ido Schimmel <idosch@mellanox.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>
List-Id: linux-serial@vger.kernel.org

On Tue, 25 Jun 2019, Thomas Gleixner wrote:
>   *	Returns: false if a threaded handler is active.
>   *
>   *	This function may be called - with care - from IRQ context.
> + *
> + *	It does not check whether there is an interrupt on flight at the
> + *	hardware level, but not serviced yet, as this might deadlock.

  + when invoked from an interrupt disabled region.
