From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 3/8] arm64: enable FIX_EARLYCON_MEM kconfig
Date: Mon, 24 Mar 2014 11:38:54 +0000
Message-ID: <20140324113854.GG3850@arm.com>
References: <1395436128-11244-1-git-send-email-robherring2@gmail.com>
 <1395436128-11244-4-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from fw-tnat.austin.arm.com ([217.140.110.23]:40118 "EHLO
	collaborate-mta1.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752259AbaCXLjU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 24 Mar 2014 07:39:20 -0400
Content-Disposition: inline
In-Reply-To: <1395436128-11244-4-git-send-email-robherring2@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Russell King <linux@arm.linux.org.uk>, Will Deacon <Will.Deacon@arm.com>, "x86@kernel.org" <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>

On Fri, Mar 21, 2014 at 09:08:43PM +0000, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> In order to support earlycon on arm64, we need to enable earlycon fixmap
> support.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
