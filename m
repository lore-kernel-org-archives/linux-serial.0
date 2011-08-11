From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH v2] serial:bfin_uart: Put TX IRQ in individual platform
 resource.
Date: Thu, 11 Aug 2011 10:19:05 +0100
Message-ID: <20110811101905.0ff01437@bob.linux.org.uk>
References: <1312256727-13906-1-git-send-email-sonic.adi@gmail.com>
	<CAJxxZ0Ob6MddPM17B_yhx47ZCCfxa38g0j+bUD4gTbH_GfFhQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:7342 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753592Ab1HKJPW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Aug 2011 05:15:22 -0400
In-Reply-To: <CAJxxZ0Ob6MddPM17B_yhx47ZCCfxa38g0j+bUD4gTbH_GfFhQQ@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sonic Zhang <sonic.adi@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

On Thu, 11 Aug 2011 16:03:52 +0800
Sonic Zhang <sonic.adi@gmail.com> wrote:

> Hi Alan,
> 
> Any comments?
> 
> Sonic Zhang

Fine by me - doesn't really touch any tty specific code or tty
interfacing code anyway
