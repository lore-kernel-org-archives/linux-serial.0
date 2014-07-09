From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/3] Deterministic UART numbering on Samsung SoCs
Date: Wed, 9 Jul 2014 14:23:33 +0100
Message-ID: <20140709142333.503a9e39@alan.etchedpixels.co.uk>
References: <1403781875-5425-1-git-send-email-t.figa@samsung.com>
	<20140626113939.GP32514@n2100.arm.linux.org.uk>
	<53AC0BCC.1010608@samsung.com>
	<CAD8Lp45MvDLsxehayx8uuGt3w3O0vGskiFjb1vdvtOyOv2nG2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAD8Lp45MvDLsxehayx8uuGt3w3O0vGskiFjb1vdvtOyOv2nG2w@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: Tomasz Figa <t.figa@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Tomasz Figa <tomasz.figa@gmail.com>
List-Id: linux-serial@vger.kernel.org

> I like the sound of going to the standard ttyS notation and only
> providing ports for ones that exist, but is this userspace-visible

ttyS is 8250 compatible UARTS.

If the Samsung is not an 8250 compatible UART then it doesn't belong as
ttyS from the kernel perspective.

How your udev handles it is up to you.

Alan
