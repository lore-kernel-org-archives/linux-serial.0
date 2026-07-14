Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A303932ABCD
	for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 18:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784055207; cv=none; b=Hfn8f8p2Eo4Pqy7mQaspaoEEXQjbPRvxjIiaW3YvFoWcm5LQGtzrQyc/AdIDlCKYKelikSTq0DGHaJ+5daj/vkOb1LwZY7jE2AYdVd3EF2bZ4yNCKNGN9/UwKQKyRvkgNXPxadz1+EY/Qs0Y1rpZKQZR7nRiSF7otFj03JlxYLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784055207; c=relaxed/simple;
	bh=Y9FJBI04v0b5TlI5275Tjuzdsyze3l17kCBKDrC4yME=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=N0+AKPC23mC9kpJSw+RokS+1szwrZeb/8Dtm+/+C6og8/eperPCWYWImmkjdZcV9RW4uAM7ukYXmKEt3Wkpt6xyUfRf6/73zJepFmFlrpoATOBu0eLqCkr32YE1NRM7xOcT23XoqJCp0Wh+Y8Z6jMcT2YwDGrk3K6Jy0PnUUZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=L8neElKB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="L8neElKB"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-493f45e206dso7599405e9.1
        for <linux-serial@vger.kernel.org>; Tue, 14 Jul 2026 11:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1784055189; x=1784659989; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pcNBWSk81aXJRf1HEe9CIzvLtrqcVP1uAiQM4+26Yvg=;
        b=L8neElKBI+1EN3FDHmnDBLqzeOoM/f9EBfl0XM1QrahWy26HivYXWvng4AntAPVKxF
         wjPKPljlFjgHISLymbKO2xKaYC6rFC5ISeF5mDaLiSFAdeUUqSKqXKDK3XKrGLg06iaJ
         tlIPUIA5UJb7kN0BcYyJs4Kl/IH7EVFBk47130zHCUjIp0EeQCWDJNMn9j6Wr2N11W6a
         rtffwNbHnirLJOYdxf26rMzu7rpxEt85iAgKes4TpCGjUjomg/ZVYTmXu1Tuo4lYAXpH
         7USrky6TBgX1yQYGJ8nY3DEuulq78Suwvy8V5Agx1U53tEWU6QR6My+87K9ocSK2rKP5
         mZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784055189; x=1784659989;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pcNBWSk81aXJRf1HEe9CIzvLtrqcVP1uAiQM4+26Yvg=;
        b=j1Gz11HU1qXuoek81JDu0G1ag+Zk7SlG8ENn/VGxMiqvtHau9AGXRlksSCpw/ieEFY
         GFFRhkYAI0XjA63kRQOrM2ZW9G5yZRHzBf0fVZkQSR9LifMHbYDZnJHOvREODFK4GulX
         x0h3nYA6eMhybmZWqjLzHf8khkNFPy7iOcgEkxMfPE4jfIhfbq3a5mmgD0Co/wDXE8lc
         UFhyMBekDhtJm+yFyd7t2nP/QZmEDstiw2kSz5LTLLYx/LhC6dbDrLsAoDGtFi0xuIuj
         HS0F25oZufwrg5QSc9fmysbGwCdiZVrLqrsrODznStKkmcz/CyePUtAGhaIzMxinZRCC
         gKfw==
X-Forwarded-Encrypted: i=1; AHgh+RqFiHcKIU3/Y6hmXpQkI+Yt1PbDUlMD8YS5oxCmunR50EK7BZgXjJlbjpk1mxfnlKKpT8L0mnB5DJlRcvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbm8wpLRfOeD7hunBSEIr2+nPvVw3PdYkVIpLNCvEInilFOieb
	LKVAo4PVfos7uYoQpUC20YOlhasTcGWtIkXvW/9iO/VQ3iC3ufjPMO97AZzTJ71b97g=
X-Gm-Gg: AfdE7cnGRF7MoL62w3J6Ot2RPRm2nMaXDEepYfT0KNfw+0U+GLTcRZVsIhMvXBpK5/v
	E2XIEEQe3Xq0JzLSVkAJBUyMUoWCtz7HplwHaf4cI66o8pbttRL5mmwTej2rB3VyA5MzoUumawr
	Tp4u2R4AS5Zd2aUv99HQBUJxVI7aGiaPsV7x9d52MWog8e+JDypf8HQnH/NPrqa45gZFXLC9MN4
	yA4DvzSnL3TiO3qQpX2n13BtEQIa7nQUIZAw75PIiHc+2y7eT6eUMwBotdOdTf6hNLXPyrrlcEM
	JlNjHyq0+Bj1nief3PScytYebjYWhpSbWbJjaUSa22tbdELZg90pFTsEu5kpVJ7NpuIcGcgtXbu
	TVbKY8n4dcXv9G0z/YkRnnn1+oD77lZWvbEMep0lfdsQ8oZSdfJf5YWYp9E29TB8xKJPdTBaXW7
	Py3FTAL/ophxlzFqWiZ/IsvLq63v+KBhWCVpOuHgIb
X-Received: by 2002:a05:600c:6749:b0:493:edde:54c8 with SMTP id 5b1f17b1804b1-493f8885b92mr156957465e9.8.1784055188747;
        Tue, 14 Jul 2026 11:53:08 -0700 (PDT)
Received: from [192.168.254.124] ([2001:9e8:2fb:8201:c26a:83ef:161a:409b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49508725c0bsm94908715e9.2.2026.07.14.11.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 5/7] soc: aspeed: add host-side PCIe BMC device
 driver
From: Tan Siewert <tan.siewert@9elements.com>
To: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org, 
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andrew@lunn.ch, jacky_chou@aspeedtech.com, 
 yh_chung@aspeedtech.com, ninad@linux.ibm.com, anirudhsriniv@gmail.com, 
 linux-serial@vger.kernel.org, linux-aspeed@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <51e455417bdcfe608270c6cb2806b1fd971fb998.1783524645.git.gregoire.layet@9elements.com>
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <51e455417bdcfe608270c6cb2806b1fd971fb998.1783524645.git.gregoire.layet@9elements.com>
Date: Tue, 14 Jul 2026 20:53:03 +0200
Message-Id: <178405518338.194693.10884980497331757324.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784055186; l=3719;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=Y9FJBI04v0b5TlI5275Tjuzdsyze3l17kCBKDrC4yME=;
 b=jjkhqaKHO+0KwEYLlPkLAmN+G/4gp2YBj1bgs+ajAChgEUNu9rY2W3prwusboACuGjyMx6z22
 H/kuiBmepnRCk9sHRrP1SCBIKVLrvkpvhwkwVi4bUWnB5HrF/Z7N5kF
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

> Add support for VUART over PCIe between BMC and host.
> Add the host side driver.
> Support only the AST2600.
> 
> Taken from ASPEED 6.18 Kernel SDK and trimmed down.


> 
> The host can't detect the VUART addresses, so force them to
> 0x3f8 and 0x2f8, as in the initial ASPEED driver.
> 
> Change the MSI vector index of VUART2 from 15 to 17.
> The index 15 used in the initial driver was not working.
> 
> Data path in both direction is tested on both VUART.
> 
> This module is added in soc/aspeed as it's very soc specific.
> This is not added as a PCI 8250 UART device as this host module can
> be expanded upon for IPMI over KCS. It can also be used in the
> future for custom BMC<->host communication with shared memory and doorbell.

While I understand that this driver could be expanded with more features, it is
still not fitting `soc/aspeed` as it is not for the ASPEED SoC, but for systems
that communicate with an ASPEED SoC.

Maybe `drivers/misc` is more fitting for this?

> 
> This host module should be the entry point for setting up all features
> related to an AST2600 present on the PCI bus.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> Signed-off-by: aspeedyh <yh_chung@aspeedtech.com>
> Signed-off-by: Grégoire Layet <gregoire.layet@9elements.com>
>
> diff --git a/drivers/soc/aspeed/Kconfig b/drivers/soc/aspeed/Kconfig
> index f579ee0b5afa..147a9033bdc4 100644
> --- a/drivers/soc/aspeed/Kconfig
> +++ b/drivers/soc/aspeed/Kconfig
> @@ -55,3 +55,18 @@ config ASPEED_SOCINFO
>  endmenu
>  
>  endif
> +
> +menu "ASPEED host-side drivers"
> +	depends on PCI
> +
> +config ASPEED_HOST_BMC_DEV
> +	tristate "ASPEED host-side BMC PCIe device"

"device driver" would be more fitting instead of "host-side driver" I'd say.

> +	depends on SERIAL_8250
> +	help
> +	  Host-side driver for the ASPEED AST2600 BMC PCIe device found on
> +	  BMC expansion cards. Exposes two 8250-compatible VUART
> +	  ports.

In the commit message you're stating that the device driver can be expanded for
e.g. IPMI over KCS. Should the user be able to disable features selectively, or
do they have to always have 8250 serial support active?

> +
> +	  If unsure, say N. Choose M to build aspeed-host-bmc-dev.
> +
> +endmenu
> diff --git a/drivers/soc/aspeed/Makefile b/drivers/soc/aspeed/Makefile
> index b35d74592964..c515e163eab7 100644
> --- a/drivers/soc/aspeed/Makefile
> +++ b/drivers/soc/aspeed/Makefile
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_ASPEED_HOST_BMC_DEV)	+= aspeed-host-bmc-dev.o
>  obj-$(CONFIG_ASPEED_LPC_CTRL)		+= aspeed-lpc-ctrl.o
>  obj-$(CONFIG_ASPEED_LPC_SNOOP)		+= aspeed-lpc-snoop.o
>  obj-$(CONFIG_ASPEED_UART_ROUTING)	+= aspeed-uart-routing.o
> diff --git a/drivers/soc/aspeed/aspeed-host-bmc-dev.c b/drivers/soc/aspeed/aspeed-host-bmc-dev.c
> new file mode 100644
> index 000000000000..e586d0505577
> --- /dev/null
> +++ b/drivers/soc/aspeed/aspeed-host-bmc-dev.c

*snip*

> +static int aspeed_pci_host_setup(struct pci_dev *pdev)
> +{
> +	struct aspeed_pci_bmc_dev *pci_bmc_dev = pci_get_drvdata(pdev);
> +	int rc = 0;
> +
> +	pci_bmc_dev->message_bar_base = pci_resource_start(pdev, 1);
> +
> +	if (pdev->revision == 0x27) {
> +		pr_err("AST2700 detected but not supported");
> +		return -ENODEV;
> +	}
> +
> +	rc = aspeed_pci_bmc_device_setup_vuart(pdev, 0);
> +	if (rc)
> +		return rc;
> +
> +	rc = aspeed_pci_bmc_device_setup_vuart(pdev, 1);
> +	if (rc)
> +		goto out_free_VUART0;

This goto seems unnecessary. There's no specific cleanup that should be needed
before.

	Tan

-- 
Tan Siewert <tan.siewert@9elements.com>
