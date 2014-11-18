From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH V2 03/10] of: Fix of_device_is_compatible() comment
Date: Tue, 18 Nov 2014 17:32:09 +0000
Message-ID: <20141118173209.EF793C40966@trevor.secretlab.ca>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
	<1415825647-6024-4-git-send-email-cernekee@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:53694 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749AbaKRRcO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 18 Nov 2014 12:32:14 -0500
Received: by mail-wg0-f49.google.com with SMTP id x12so466276wgg.36
        for <linux-serial@vger.kernel.org>; Tue, 18 Nov 2014 09:32:13 -0800 (PST)
In-Reply-To: <1415825647-6024-4-git-send-email-cernekee@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org
Cc: arnd@arndb.de, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

On Wed, 12 Nov 2014 12:54:00 -0800
, Kevin Cernekee <cernekee@gmail.com>
 wrote:
> This function passes back a value from __of_device_is_compatible(), which
> returns a score in the range 0..11, not a bool.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Applied, thanks.

g.

> ---
>  drivers/of/base.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 3823edf..707395c 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -485,7 +485,7 @@ EXPORT_SYMBOL(of_device_is_compatible);
>   * of_machine_is_compatible - Test root of device tree for a given compatible value
>   * @compat: compatible string to look for in root node's compatible property.
>   *
> - * Returns true if the root node has the given value in its
> + * Returns a positive integer if the root node has the given value in its
>   * compatible property.
>   */
>  int of_machine_is_compatible(const char *compat)
> -- 
> 2.1.1
> 

