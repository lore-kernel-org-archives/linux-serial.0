From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 2/2] drivers/serial: Add driver for Aspeed virtual UART
Date: Sat, 01 Apr 2017 08:29:40 +1100
Message-ID: <1490995780.3177.245.camel@kernel.crashing.org>
References: <20170328054458.29341-1-joel@jms.id.au>
         <20170328054458.29341-3-joel@jms.id.au> <20170331133120.GA26078@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170331133120.GA26078@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Joel Stanley <joel@jms.id.au>
Cc: Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Jeremy Kerr <jk@ozlabs.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, 2017-03-31 at 15:31 +0200, Greg Kroah-Hartman wrote:
> DEVICE_ATTR_RW()?
> 
> And why random sysfs files for a uart?  Where have you documented
> these?

We should stick a file somewhere in Documentation I suppose or
at least put that in a comment blob at the head of the file.

FYI:

The VUART is basically two UART 'front ends' connected by their FIFO
(no actual serial line in between). One is on the BMC side (management
controller) and one is on the host CPU side.

It allows the BMC to provide to the host a "UART" that pipes into
the BMC itself and can then be turned by the BMC into a network console
of some sort for example.

This driver is for the BMC side. The sysfs files allow the BMC
userspace which owns the system configuration policy, to specify
at what IO port and interrupt number the host side will appear
to the host on the Host <-> BMC LPC bus. It could be different on a
different system (though most of them use 3f8/4).

Cheers,
Ben.
