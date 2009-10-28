From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] MIPS: Alchemy: UARTs are 16550A
Date: Wed, 28 Oct 2009 12:24:30 -0700
Message-ID: <20091028122430.f7670ae2.akpm@linux-foundation.org>
References: <1256756954-29211-1-git-send-email-manuel.lauss@gmail.com>
	<1256756954-29211-2-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41224 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751904AbZJ1TYj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Oct 2009 15:24:39 -0400
In-Reply-To: <1256756954-29211-2-git-send-email-manuel.lauss@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, Linux-MIPS <linux-mips@linux-mips.org>, linux-serial@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>

On Wed, 28 Oct 2009 20:09:14 +0100
Manuel Lauss <manuel.lauss@googlemail.com> wrote:

> UART autodetection breaks on the Au1300 but the IP blocks are
> identical, at least in the datasheets.
> 
> Pass uart type on to the 8250 driver via platform data, and move
> the MSR quirk to another place sind autoconf() is now no longer
> called on init.
> 
> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> ---
> Tested on DB1200 and DB1300.
> The mips parts apply on top of Ralf's mips-queue tree.
> 
>  arch/mips/alchemy/common/platform.c |    4 +++-
>  drivers/serial/8250.c               |   13 +++++++------
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
> index 195e5b3..3be14b0 100644
> --- a/arch/mips/alchemy/common/platform.c
> +++ b/arch/mips/alchemy/common/platform.c
> @@ -26,7 +26,9 @@
>  		.irq		= _irq,				\
>  		.regshift	= 2,				\
>  		.iotype		= UPIO_AU,			\
> -		.flags		= UPF_SKIP_TEST | UPF_IOREMAP	\
> +		.flags		= UPF_SKIP_TEST | UPF_IOREMAP |	\
> +				  UPF_FIXED_TYPE,		\
> +		.type		= PORT_16550A,			\
>  	}

The kernel which you patched differs from current mainline here.
