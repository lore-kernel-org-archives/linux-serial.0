From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH 0/3] Deterministic UART numbering on Samsung SoCs
Date: Tue, 8 Jul 2014 09:32:02 +0100
Message-ID: <CAD8Lp45MvDLsxehayx8uuGt3w3O0vGskiFjb1vdvtOyOv2nG2w@mail.gmail.com>
References: <1403781875-5425-1-git-send-email-t.figa@samsung.com>
	<20140626113939.GP32514@n2100.arm.linux.org.uk>
	<53AC0BCC.1010608@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:48130 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbaGHIcE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 8 Jul 2014 04:32:04 -0400
Received: by mail-wi0-f181.google.com with SMTP id n3so517590wiv.2
        for <linux-serial@vger.kernel.org>; Tue, 08 Jul 2014 01:32:02 -0700 (PDT)
In-Reply-To: <53AC0BCC.1010608@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Tomasz Figa <tomasz.figa@gmail.com>

Hi,

How can we move forward here?

On Thu, Jun 26, 2014 at 1:02 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> - basically Samsung UART already has its own namespace (ttySAC) and the
> order inside it is well-defined - instance ID shall be the hardware
> instance number as specified by documentation. The ports vary in certain
> aspects and the ID is important knowledge of the driver. The problem
> here was broken implementation of assigning IDs based on probe order,
> which worked only because on all Exynos platforms all ports have been
> always registered (which we want to change now and keep unused ones
> "disabled" in DT),

Yes, the kernel help text documents this quite well:

config SERIAL_SAMSUNG
    tristate "Samsung SoC serial support"
    depends on PLAT_SAMSUNG
    select SERIAL_CORE
    help
      Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
      providing /dev/ttySAC0, 1 and 2 (note, some machines may not
      provide all of these ports, depending on how the serial port
      pins are configured.

> - we already have a lot of userspace depending on the aforementioned
> ttySAC namespace and proper ordering of instances there. While I believe
> the proper solution as of today would be to go back to standard ttyS
> namespace and make userspace use a smarter way of identifying the
> instances (e.g. by path or id, as you suggested), I don't think this
> will make anyone's life easier with current assumptions,

I like the sound of going to the standard ttyS notation and only
providing ports for ones that exist, but is this userspace-visible
naming change OK? You could argue that userspace that relies on fixed
device paths is a bit broken, but that argument would be a bit cloudy
given the kernel documentation for the ttySAC devices above.

> - correct me if I'm wrong, but I don't think the
> /dev/serial/by-{path,id} would be handled in kernel's console= parameter.

That's right, that problem is left to the user, but at least we'd be
consistent with other SoCs (and open to generic solutions to that
inconvenience).

Daniel
