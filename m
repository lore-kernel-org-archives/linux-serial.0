From: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH 22/27] serial: Make uart_port's ioport "unsigned long".
Date: Fri, 10 Oct 2008 08:54:34 -0400
Message-ID: <20081010125434.GB8590@yoda.jdub.homelinux.org>
References: <20081010103447.31597.42992.stgit@localhost.localdomain> <20081010105052.31597.41476.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:17962 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755767AbYJJMzz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Oct 2008 08:55:55 -0400
Received: by yw-out-2324.google.com with SMTP id 9so170930ywe.1
        for <linux-serial@vger.kernel.org>; Fri, 10 Oct 2008 05:55:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20081010105052.31597.41476.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Fri, Oct 10, 2008 at 11:50:56AM +0100, Alan Cox wrote:
>From: David Miller <davem@davemloft.net>
>
>Otherwise the top 32-bits of the resource value get chopped
>off on 64-bit systems, and the resulting I/O accesses go to
>random places.
>
>Thanks to testing and debugging by Josip Rodin, which helped
>track this down.
>
>Signed-off-by: David S. Miller <davem@davemloft.net>
>Signed-off-by: Alan Cox <alan@redhat.com>

I emailed on an earlier posting of this about using resource_size_t
instead as we have 32-bit CPUs with 64-bit address spaces.  If I'm
totally wrong, that's fine but I'm still wondering if that would be
a better general solution.

josh
