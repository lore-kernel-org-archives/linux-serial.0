From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] serial/8250_gsc.c: add MODULE_LICENSE
Date: Mon, 14 Apr 2008 22:31:48 +0100
Message-ID: <20080414223148.4960f7b1@core>
References: <20080414195608.GF26885@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49286 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761240AbYDNVgJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Apr 2008 17:36:09 -0400
In-Reply-To: <20080414195608.GF26885@cs181133002.pp.htv.fi>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 14 Apr 2008 22:56:08 +0300
Adrian Bunk <bunk@kernel.org> wrote:

> This patch adds the missing MODULE_LICENSE("GPL").
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> ---
> c0d845566182db3fc650dcfa35700f84e82bbae7 diff --git a/drivers/serial/8250_gsc.c b/drivers/serial/8250_gsc.c
> index 4eb7437..0416ad3 100644
> --- a/drivers/serial/8250_gsc.c
> +++ b/drivers/serial/8250_gsc.c
> @@ -119,3 +119,5 @@ int __init probe_serial_gsc(void)
>  }
>  
>  module_init(probe_serial_gsc);
> +
> +MODULE_LICENSE("GPL");

Acked-by: Alan Cox <alan@redhat.com>
