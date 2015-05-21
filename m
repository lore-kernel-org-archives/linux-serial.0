From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH] serial: tegra: Fix memory leak on DMA setup failure
Date: Thu, 21 May 2015 14:27:59 +0900
Message-ID: <CAAVeFu+rRSXfrVGDz4piMmeHAMkWGsL5caukAN1w9DNH38D9FQ@mail.gmail.com>
References: <1432120864-23916-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1432120864-23916-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, May 20, 2015 at 8:21 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
> If the call to dmaengine_slave_config() fails, then the DMA buffer will
> not be freed/unmapped. Fix this by moving the code that stores the
> address of the buffer in the tegra_uart_port structure to before the
> call to dmaengine_slave_config().
>
> Reported-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Looks good, we had the same if/else condition appearing three times in
this function for no real reason anyway. This considerably simplifies
the code.

>  drivers/tty/serial/serial-tegra.c | 32 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 21 deletions(-)

Negative number of lines, another good point for this patch!

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
