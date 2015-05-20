From: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] serial: tegra: Fix memory leak on DMA setup failure
Date: Wed, 20 May 2015 12:33:22 +0100
Message-ID: <555C7102.8060207@nvidia.com>
References: <1432120864-23916-1-git-send-email-jonathanh@nvidia.com> <555C6F38.50603@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <555C6F38.50603-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-AlSwsSmVLrQ@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org



On 20/05/15 12:25, Jon Hunter wrote:
> 
> On 20/05/15 12:21, Jon Hunter wrote:
>> If the call to dmaengine_slave_config() fails, then the DMA buffer will
>> not be freed/unmapped. Fix this by moving the code that stores the
>> address of the buffer in the tegra_uart_port structure to before the
>> call to dmaengine_slave_config().
> 
> By the way, just to be clear, I did try to fix this before [1], but
> failed :-(

To be doubly clear, this is targeted to be applied on top of the
previous patch [1] which is now in linux-next.

Jon

> [1] https://lkml.org/lkml/2015/5/5/802
