From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] [SERIAL] fix driver_name conflicts
Date: Wed, 28 May 2008 15:15:10 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0805281511160.29522@cliff.in.clinika.pl>
References: <20080526172340.GA17703@polina.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752367AbYE1OUw@vger.kernel.org>
In-Reply-To: <20080526172340.GA17703@polina.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Timur Tabi <timur@freescale.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, 26 May 2008, Anton Vorontsov wrote:

> This patch fixes two drivers that are using "serial" for driver_name and
> not "ttyS" for dev_name. Drivers that are using "ttyS" for dev_name, will
> conflict anyway, so we don't bother with these.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/serial/sb1250-duart.c |    2 +-
>  drivers/serial/ucc_uart.c     |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

 Not that it makes much sense to have both included in the same kernel,
but for the purpose of purity:

Acked-by: Maciej W. Rozycki <macro@linux-mips.org>

  Maciej
