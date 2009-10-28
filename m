From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] MIPS: Alchemy: UARTs are 16550A
Date: Wed, 28 Oct 2009 22:36:14 +0300
Message-ID: <4AE89D2E.4060704@ru.mvista.com>
References: <1256756954-29211-1-git-send-email-manuel.lauss@gmail.com> <1256756954-29211-2-git-send-email-manuel.lauss@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1256756954-29211-2-git-send-email-manuel.lauss@gmail.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ralf Baechle <ralf@linux-mips.org>, Linux-MIPS <linux-mips@linux-mips.org>, linux-serial@vger.kernel.org, Manuel Lauss <manuel.lauss@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hello.

Manuel Lauss wrote:

> UART autodetection breaks on the Au1300 but the IP blocks are
> identical, at least in the datasheets.

> Pass uart type on to the 8250 driver via platform data, and move
> the MSR quirk to another place sind autoconf() is now no longer

    s/sind autoconf/since autoconfig/

> called on init.

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

    Good to know this has been implemented.

WBR, Sergei
