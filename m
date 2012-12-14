From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Edgeport/416 io_edgeport problem.
Date: Fri, 14 Dec 2012 09:52:20 +0000
Message-ID: <20121214095220.1be799ee@pyramind.ukuu.org.uk>
References: <CADH15GikmfJh+nFbMFVcrW8RB8pmLsJvhtutue7L7iq8+7sdHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:36684 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab2LNJqy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 14 Dec 2012 04:46:54 -0500
In-Reply-To: <CADH15GikmfJh+nFbMFVcrW8RB8pmLsJvhtutue7L7iq8+7sdHQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Robillard <david.robillard@gmail.com>
Cc: linux-serial@vger.kernel.org

On Thu, 13 Dec 2012 15:03:59 -0500
David Robillard <david.robillard@gmail.com> wrote:

> Hello everyone,
> 
> I'm having a problem with a Digi Inside Out Networks Edgeport/416
> device. According to the kernel.org file (see exerpt below) this
> particular model is not listed in the supported products.
> 
> The device is connected to a 32 bit CentOS 6.3 machine running with
> kernel 2.6.32-279.14.1.el6.i686.

Please try a recent upstream kernel. 2.6.32 is old, and the Red
Hat/CentOS version quite a bit different. If 3.6/3.7 break then yes we
might care about it.

Alan
