Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069C718C1F;
	Sat, 14 Sep 2024 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726340335; cv=none; b=EfuW/UkU+W33TyP1pE6V35ME24q+Dv2BuwWvv6DSuT7polBhu9te+asm6OK/RL4EmLH1+5oSErD0vFQdlutWSXL0bbPnCSVGLvdPLv81fu6XtnenNb6PXP4isIW/tO3h82yHp5ct5AcFymj25dwDaYwQ4ldA6N6bi3gyqd4me5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726340335; c=relaxed/simple;
	bh=Ag8EUoRntaBY11eoaLPLw4SDAfflI0AQ+/LpKMj6ACk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haBrMmSIdL4qs/zfccg9El24m16T2v1TroiHFTXg+P2WX6NR1GcpU+2bcwMkJs0s1vgvM5KUuACZzBraE9rM11nhhJHfVKNCwK7eaJkBqJSVIZojV5IcFqDE3NgyuKZTVs34KZpmcTZwf4DaxJStrrfqAjxHlrZaEWllblXt0cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1EgSQjG2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1EgSQjG2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC80EC4CEC0;
	Sat, 14 Sep 2024 18:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726340334;
	bh=Ag8EUoRntaBY11eoaLPLw4SDAfflI0AQ+/LpKMj6ACk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1EgSQjG2WL040FNMDcqJUX8RXkOTsCbqeYQE3xiHCK1lkJSX5OJ1fXo8l7Ayb1Zgz
	 a793I6ighlVpCmHTTJ1PLjeYPJzzzpH4d1VdXTQ8mkLMSAl5NUADOw2leq4mlXnae/
	 FYL8C3O1X7PE5bJMH5LD0b+8dFFWQH8RE9T1Jm8U=
Date: Sat, 14 Sep 2024 20:58:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Parker Newman <parker@finest.io>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v1 3/6] misc: eeprom: eeprom_93cx6: Replace
 printk(KERN_ERR ...) with pr_err()
Message-ID: <2024091438-charity-borough-54b3@gregkh>
References: <cover.1726237379.git.pnewman@connecttech.com>
 <127dcc7f60d15a1cc9007c9e5b06a1aa2b170e19.1726237379.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <127dcc7f60d15a1cc9007c9e5b06a1aa2b170e19.1726237379.git.pnewman@connecttech.com>

On Fri, Sep 13, 2024 at 10:55:40AM -0400, Parker Newman wrote:
> From: Parker Newman <pnewman@connecttech.com>
> 
> Replace printk(KERN_ERR ...) with pr_err() to improve readability.
> 
> Fixes checkpatch warning:
> 
> WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ... then
> dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...
> +			printk(KERN_ERR "%s: timeout\n", __func__);
> 
> Signed-off-by: Parker Newman <pnewman@connecttech.com>
> ---
>  drivers/misc/eeprom/eeprom_93cx6.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/eeprom/eeprom_93cx6.c b/drivers/misc/eeprom/eeprom_93cx6.c
> index 64da22edefa4..755be9a4ffd4 100644
> --- a/drivers/misc/eeprom/eeprom_93cx6.c
> +++ b/drivers/misc/eeprom/eeprom_93cx6.c
> @@ -378,7 +378,7 @@ void eeprom_93cx6_write(struct eeprom_93cx6 *eeprom, u8 addr, u16 data)
>  		usleep_range(1000, 2000);
> 
>  		if (--timeout <= 0) {
> -			printk(KERN_ERR "%s: timeout\n", __func__);
> +			pr_err("%s: timeout\n", __func__);

It's a device, please use dev_err().

thanks,

greg k-h
