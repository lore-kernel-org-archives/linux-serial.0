From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] max310x: max3109_detect should use indirect addressing
 in SPI mode for REVID register
Date: Sun, 28 Sep 2014 21:32:24 -0400
Message-ID: <20140929013224.GA22319@kroah.com>
References: <1409933256-32071-1-git-send-email-gregory.hermant@calao-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:33820 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbaI2GQt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 29 Sep 2014 02:16:49 -0400
Content-Disposition: inline
In-Reply-To: <1409933256-32071-1-git-send-email-gregory.hermant@calao-systems.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Gregory Hermant <gregory.hermant@calao-systems.com>
Cc: linux-serial@vger.kernel.org, shc_work@mail.ru

On Fri, Sep 05, 2014 at 06:07:36PM +0200, Gregory Hermant wrote:
> This patch allows to read the REV_ID register in SPI mode and consequently
> to properly detect the max3109. Indeed in SPI mode, this register is only
> accessible by using indirect addressing.
> 
> Signed-off-by: Gregory Hermant <gregory.hermant@calao-systems.com>
> ---
>  drivers/tty/serial/max310x.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
> index 5183643..2d911f6 100644
> --- a/drivers/tty/serial/max310x.c
> +++ b/drivers/tty/serial/max310x.c
> @@ -369,10 +369,13 @@ static int max3109_detect(struct device *dev)
>  	unsigned int val = 0;
>  	int ret;
>  
> -	ret = regmap_read(s->regmap, MAX310X_REVID_REG, &val);
> +	ret = regmap_write(s->regmap, MAX310X_GLOBALCMD_REG,
> +			   MAX310X_EXTREG_ENBL);
>  	if (ret)
>  		return ret;
> -
> +	

Always run your patches through checkpatch.pl and never add new problems
to the existing codebase :(

