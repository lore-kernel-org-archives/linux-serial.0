From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH 0/3] Deterministic UART numbering on Samsung SoCs
Date: Thu, 26 Jun 2014 14:02:20 +0200
Message-ID: <53AC0BCC.1010608@samsung.com>
References: <1403781875-5425-1-git-send-email-t.figa@samsung.com>
 <20140626113939.GP32514@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:59551 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757114AbaFZMCr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Jun 2014 08:02:47 -0400
In-reply-to: <20140626113939.GP32514@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Daniel Drake <drake@endlessm.com>, Tomasz Figa <tomasz.figa@gmail.com>

On 26.06.2014 13:39, Russell King - ARM Linux wrote:
> On Thu, Jun 26, 2014 at 01:24:32PM +0200, Tomasz Figa wrote:
>> Current Samsung UART driver relies on probe order of particular
>> samsung-uart instances, which makes it impossible to get proper
>> initialization of ports when not all ports are available on board,
>> not even saying of deterministic device naming.
>>
>> This series intends to fix this situation by adding support to parse
>> aliases from device tree and use them to assign instance IDs to
>> particular port instances.
> 
> How about instead exporting the path/id information so that userspace
> can create /dev/serial/by-{path,id}/... for internal devices instead?
> 
> The problem you're raising is very much the same problem you have when
> there are multiple USB serial devices connected to the machine - you
> just get a bunch of /dev/ttyUSB* devices which are unordered (they can
> change on each boot, or change order if you disconnect and reconnect
> them.)
> 
> /dev/serial/by-{path,id}/ allows for a much more stable path.
> 

The problem being solved has slightly different constraints than the one
with USB serials you mentioned:

- basically Samsung UART already has its own namespace (ttySAC) and the
order inside it is well-defined - instance ID shall be the hardware
instance number as specified by documentation. The ports vary in certain
aspects and the ID is important knowledge of the driver. The problem
here was broken implementation of assigning IDs based on probe order,
which worked only because on all Exynos platforms all ports have been
always registered (which we want to change now and keep unused ones
"disabled" in DT),

- we already have a lot of userspace depending on the aforementioned
ttySAC namespace and proper ordering of instances there. While I believe
the proper solution as of today would be to go back to standard ttyS
namespace and make userspace use a smarter way of identifying the
instances (e.g. by path or id, as you suggested), I don't think this
will make anyone's life easier with current assumptions,

- correct me if I'm wrong, but I don't think the
/dev/serial/by-{path,id} would be handled in kernel's console= parameter.

Best regards,
Tomasz
