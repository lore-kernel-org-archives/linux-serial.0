Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F73D1A9F88
	for <linux-serial@vger.kernel.org>; Sun,  9 Nov 2025 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762650857; cv=none; b=hnhW6Ol5E5VALZdiPoOlsoqZHnUUiXmLghpLPml2w7IvR4TgUcj5Q7uXeiJxjd5pB6lSS+WSnZoR6uGzrHd9PRuMedtr6VCA5sIWY8S5eO+rHGBMZ02AQTcm/Iea6L0W3+dxAOQ566eOsADguYhLpfZA2q/cLDeQcRC356TbAVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762650857; c=relaxed/simple;
	bh=uefiuLN8IbfBihNZZkjBSMoPN6ucb+zBnItNDB5kBho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCZY65QjNMymgrQ6TI6Qf0NzPbAxti4TEPxYsw2hr0qE1SZqhYMWv4WLjW1ZbZZjQKgcEldwZHsST03rOnp4j3eqJ4MunMf7m5mQPzNzBdkY9twR2ve9INROLoBruqaV8RhtkGtG81mAgS3YUWGujLP0BF9RFZSRCL5MzYaADms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qUrYgEWN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qUrYgEWN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49786C16AAE;
	Sun,  9 Nov 2025 01:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762650856;
	bh=uefiuLN8IbfBihNZZkjBSMoPN6ucb+zBnItNDB5kBho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qUrYgEWNXjpotQ8d8Skl5P/JLMGNP4NBKTgBka8h1kc5UhaNESf7UQ+z9ydY8N2iE
	 C4cPtrI7K61F/zv3M8nhjdEwRVyYag9SNBcQ+rWJnWHOjS8/+o3SYK8sZQQFEJ63VR
	 DI9pmVFC+DV2C0aUF5/39hhE+MCEoOnPQPabdeq8=
Date: Sun, 9 Nov 2025 09:50:10 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: Magne Bruno <magne.bruno@addi-data.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 001/001] serial: add support of CPCI cards
Message-ID: <2025110945-poison-luxurious-7e49@gregkh>
References: <20251108214617.77631-1-magne.bruno@addi-data.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108214617.77631-1-magne.bruno@addi-data.com>

On Sat, Nov 08, 2025 at 10:46:17PM +0100, Magne Bruno wrote:
> Addi-Data GmbH is manufacturing multi-serial ports cards supporting CompactPCI (known as CPCI).
> Those cards are identified with different DeviceIds. Those cards integrating standard UARTs
> work the same way as PCI/PCIe models already supported in the serial driver.
> 
> Signed-off-by: Magne Bruno <magne.bruno@addi-data.com>
> ---
> 
> diff --git a/drivers/tty/serial/8250/8250_pci.c b/drivers/tty/serial/8250/8250_pci.c
> index 152f914c599d..924ea92d17d7 100644
> --- a/drivers/tty/serial/8250/8250_pci.c
> +++ b/drivers/tty/serial/8250/8250_pci.c
> @@ -5996,6 +5996,38 @@ static const struct pci_device_id serial_pci_tbl[] = {
>  		0,
>  		pbn_ADDIDATA_PCIe_8_3906250 },
>  
> +	{	PCI_VENDOR_ID_ADDIDATA,
> +		PCI_DEVICE_ID_ADDIDATA_CPCI7500,
> +		PCI_ANY_ID,
> +		PCI_ANY_ID,
> +		0,
> +		0,
> +		pbn_b0_4_115200 },
> +
> +	{	PCI_VENDOR_ID_ADDIDATA,
> +		PCI_DEVICE_ID_ADDIDATA_CPCI7500_NG,
> +		PCI_ANY_ID,
> +		PCI_ANY_ID,
> +		0,
> +		0,
> +		pbn_b0_4_115200 },
> +
> +	{	PCI_VENDOR_ID_ADDIDATA,
> +		PCI_DEVICE_ID_ADDIDATA_CPCI7420_NG,
> +		PCI_ANY_ID,
> +		PCI_ANY_ID,
> +		0,
> +		0,
> +		pbn_b0_2_115200 },
> +
> +	{	PCI_VENDOR_ID_ADDIDATA,
> +		PCI_DEVICE_ID_ADDIDATA_CPCI7300_NG,
> +		PCI_ANY_ID,
> +		PCI_ANY_ID,
> +		0,
> +		0,
> +		pbn_b0_1_115200 },
> +
>  	{	PCI_VENDOR_ID_NETMOS, PCI_DEVICE_ID_NETMOS_9835,
>  		PCI_VENDOR_ID_IBM, 0x0299,
>  		0, 0, pbn_b0_bt_2_115200 },
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 92ffc4373f6d..221a83d4e1ed 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2333,6 +2333,7 @@
>  #define PCI_DEVICE_ID_ADDIDATA_APCI7500        0x7000
>  #define PCI_DEVICE_ID_ADDIDATA_APCI7420        0x7001
>  #define PCI_DEVICE_ID_ADDIDATA_APCI7300        0x7002
> +#define PCI_DEVICE_ID_ADDIDATA_CPCI7500        0x7003
>  #define PCI_DEVICE_ID_ADDIDATA_APCI7500_2      0x7009
>  #define PCI_DEVICE_ID_ADDIDATA_APCI7420_2      0x700A
>  #define PCI_DEVICE_ID_ADDIDATA_APCI7300_2      0x700B
> @@ -2344,6 +2345,9 @@
>  #define PCI_DEVICE_ID_ADDIDATA_APCIe7420       0x7011
>  #define PCI_DEVICE_ID_ADDIDATA_APCIe7500       0x7012
>  #define PCI_DEVICE_ID_ADDIDATA_APCIe7800       0x7013
> +#define PCI_DEVICE_ID_ADDIDATA_CPCI7500_NG     0x7024
> +#define PCI_DEVICE_ID_ADDIDATA_CPCI7420_NG     0x7025
> +#define PCI_DEVICE_ID_ADDIDATA_CPCI7300_NG     0x7026
>  
>  #define PCI_VENDOR_ID_PDC		0x15e9

Please look at the top of this file, there's no real need to add these
new ids to it, right?

thanks,

greg k-h
