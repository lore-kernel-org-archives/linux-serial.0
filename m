From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: 2.6.16-mm1
Date: Thu, 23 Mar 2006 17:11:12 +0100
Message-ID: <6bffcb0e0603230811w4b7d03fex@mail.gmail.com>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	 <6bffcb0e0603230631r5e6cc3d3p@mail.gmail.com>
	 <20060323144922.GA25849@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:38124 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932150AbWCWQLN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 23 Mar 2006 11:11:13 -0500
Received: by zproxy.gmail.com with SMTP id 12so516958nzp
        for <linux-serial@vger.kernel.org>; Thu, 23 Mar 2006 08:11:12 -0800 (PST)
In-Reply-To: <20060323144922.GA25849@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Hi Russell,

On 23/03/06, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> CONFIG_SERIAL_8250=m
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_PNP=y
>
> That's an illegal configuration.
>
[snip]
>
> So it would seem to be a Kconfig bug.

Thanks for explanation of the problem

Everything is ok, when I state CONFIG_SERIAL_8250=y in kernel config.

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
