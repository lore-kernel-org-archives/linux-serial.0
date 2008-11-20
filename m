From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] Add support for the nwp serial device
Date: Thu, 20 Nov 2008 10:40:52 -0500
Message-ID: <20081120104052.3c2383cf@zod.rchland.ibm.com>
References: <200811201501.24000.arnd@arndb.de>
	<20081120141345.GA2410@yoda.jdub.homelinux.org>
	<20081120152054.GO24487@codiert.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <20081120152054.GO24487@codiert.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Benjamin Krill <ben@codiert.org>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, linux-serial@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

On Thu, 20 Nov 2008 16:20:54 +0100
Benjamin Krill <ben@codiert.org> wrote:

> Hi Josh,
> 
> >What does 'NWP' stand for, and how is it different from a regular serial
> >port?  Also, what platforms can this device be found on currently?
> >
> >Some of that should be included in the changelog, but I'm curious as well
> >too.
> 
> NWP stands for network processor and it is part of the QPACE - Quantum
> Chromodynamics Parallel Computing on the Cell Broadband Engine
> project [1]. The implementation is a lightweight uart implementation
> with the focus to consume as little resources as possible and it is
> connected to a DCR bus.

Neat.  Thanks.  We should include that in the changelog.

josh
