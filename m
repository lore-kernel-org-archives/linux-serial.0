From: Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH 0/4] serial: =?UTF-8?Q?fsl=5Flpuart=3A=20fix=20various?=
 =?UTF-8?Q?=20DMA=20related=20issues?=
Date: Fri, 12 Dec 2014 14:44:06 +0100
Message-ID: <677f2c62b6b6c1fe8e16cd38d5f20d47@agner.ch>
References: <1417134205-4400-1-git-send-email-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417134205-4400-1-git-send-email-stefan@agner.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: jslaby@suse.cz, jingchang.lu@freescale.com, shawn.guo@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Any thoughts on this patchset? Would have hopped that it makes it into
3.19 as those are mostly fixes.

--
Stefan

On 2014-11-28 01:23, Stefan Agner wrote:
> Patch 1 and 3 are actual fixes, whereas 2 and 4 don't lead to issues
> in standard cases but are still worthwhile fixes.
> 
> Stefan Agner (4):
>   serial: fsl_lpuart: delete timer on shutdown
>   serial: fsl_lpuart: move DMA channel request to probe
>   serial: fsl_lpuart: avoid new transfer while DMA is running
>   serial: fsl_lpuart: update RX timer on successful DMA transfer
> 
>  drivers/tty/serial/fsl_lpuart.c | 110 +++++++++++++++++++---------------------
>  1 file changed, 52 insertions(+), 58 deletions(-)
