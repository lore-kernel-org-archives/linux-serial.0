Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3EA390CB3;
	Thu,  9 Jul 2026 05:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783574843; cv=none; b=cKRxuJW+Rc5m14wg48VyCwALsUs+qHq7TiNVCqNDhjsVTLjd+67xTFq0EkHiLAHbyatLmFhaFGMiNZMwM5SbisikaP9lpiGbTEwSn5ijZbq8+RohT9si8vG7jBzNY+z+1sm6hlTesgSnyNfZNH2Pp5ZZijZrP06XWoqjD+dYfJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783574843; c=relaxed/simple;
	bh=vwqDMBYSjv8gqPoU1nOysOPHJh5eN5V4wV9NFJDES0o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YaFzijBekhZbLj7+CKdXGoE4MxqZc0/4fwA6nivX4x8MZHPfMIgNCK4DF6lAWADWVfk0OrVmkRGYKrNIpefU+gKoSuvPUETyx68IxPN98YUUHeBaRKQCAQkE98V2foPdWGCP4pVRGVLHmz8EFsfHtGhVpVGbmYZFZrbyghBJiCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhNnI6XR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhNnI6XR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0AF1F000E9;
	Thu,  9 Jul 2026 05:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783574841;
	bh=tVOQQ1gm3MZyZojREIn2l7JKx5S7mcFVw/rTEMaa2fY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=OhNnI6XRrEpf3ZwrCwpNHNFOrPAjL2ojo6iw0FWwEY/4x/EewKG6iCK5K9gQxmzYN
	 WVbGhd5MXQYUVzGH8Uua+VoFc7ycTHtS1S4+zAEvIEPs2rHcIbzfJsARayquQ43TqY
	 0IDe8hCWW2fReqILaKxHXGwfUfb5/RL/04EOWm64sYnpZ6/EK7WVtCRZGLzcv/r8MR
	 AE3LVZkV00Ggbv2I3kSeRt5RuthiMfDiQfgIdeAdvu2y22wt2WcVkuOkFSsQrUZ9bo
	 gZxMFbSM/ErhsYtj5wrg5BmlXkRKhmWR5F8muKLos4YYZRMVMnb+YideQLXU9KDAHg
	 mPfYzxyKKYFGg==
Message-ID: <eaef5bcc-99df-4549-8d37-fb3d127c414e@kernel.org>
Date: Thu, 9 Jul 2026 07:27:15 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] soc: aspeed: add host-side PCIe BMC device driver
To: =?UTF-8?Q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>,
 joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk,
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: andrew@lunn.ch, jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com,
 ninad@linux.ibm.com, anirudhsriniv@gmail.com, linux-serial@vger.kernel.org,
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <cover.1783524645.git.gregoire.layet@9elements.com>
 <51e455417bdcfe608270c6cb2806b1fd971fb998.1783524645.git.gregoire.layet@9elements.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 xsFNBE6S54YBEACzzjLwDUbU5elY4GTg/NdotjA0jyyJtYI86wdKraekbNE0bC4zV+ryvH4j
 rrcDwGs6tFVrAHvdHeIdI07s1iIx5R/ndcHwt4fvI8CL5PzPmn5J+h0WERR5rFprRh6axhOk
 rSD5CwQl19fm4AJCS6A9GJtOoiLpWn2/IbogPc71jQVrupZYYx51rAaHZ0D2KYK/uhfc6neJ
 i0WqPlbtIlIrpvWxckucNu6ZwXjFY0f3qIRg3Vqh5QxPkojGsq9tXVFVLEkSVz6FoqCHrUTx
 wr+aw6qqQVgvT/McQtsI0S66uIkQjzPUrgAEtWUv76rM4ekqL9stHyvTGw0Fjsualwb0Gwdx
 ReTZzMgheAyoy/umIOKrSEpWouVoBt5FFSZUyjuDdlPPYyPav+hpI6ggmCTld3u2hyiHji2H
 cDpcLM2LMhlHBipu80s9anNeZhCANDhbC5E+NZmuwgzHBcan8WC7xsPXPaiZSIm7TKaVoOcL
 9tE5aN3jQmIlrT7ZUX52Ff/hSdx/JKDP3YMNtt4B0cH6ejIjtqTd+Ge8sSttsnNM0CQUkXps
 w98jwz+Lxw/bKMr3NSnnFpUZaxwji3BC9vYyxKMAwNelBCHEgS/OAa3EJoTfuYOK6wT6nadm
 YqYjwYbZE5V/SwzMbpWu7Jwlvuwyfo5mh7w5iMfnZE+vHFwp/wARAQABzSFKaXJpIFNsYWJ5
 IDxqaXJpc2xhYnlAa2VybmVsLm9yZz7CwXcEEwEIACEFAlW3RUwCGwMFCwkIBwIGFQgJCgsC
 BBYCAwECHgECF4AACgkQvSWxBAa0cEnVTg//TQpdIAr8Tn0VAeUjdVIH9XCFw+cPSU+zMSCH
 eCZoA/N6gitEcnvHoFVVM7b3hK2HgoFUNbmYC0RdcSc80pOF5gCnACSP9XWHGWzeKCARRcQR
 4s5YD8I4VV5hqXcKo2DFAtIOVbHDW+0okOzcecdasCakUTr7s2fXz97uuoc2gIBB7bmHUGAH
 XQXHvdnCLjDjR+eJN+zrtbqZKYSfj89s/ZHn5Slug6w8qOPT1sVNGG+eWPlc5s7XYhT9z66E
 l5C0rG35JE4PhC+tl7BaE5IwjJlBMHf/cMJxNHAYoQ1hWQCKOfMDQ6bsEr++kGUCbHkrEFwD
 UVA72iLnnnlZCMevwE4hc0zVhseWhPc/KMYObU1sDGqaCesRLkE3tiE7X2cikmj/qH0CoMWe
 gjnwnQ2qVJcaPSzJ4QITvchEQ+tbuVAyvn9H+9MkdT7b7b2OaqYsUP8rn/2k1Td5zknUz7iF
 oJ0Z9wPTl6tDfF8phaMIPISYrhceVOIoL+rWfaikhBulZTIT5ihieY9nQOw6vhOfWkYvv0Dl
 o4GRnb2ybPQpfEs7WtetOsUgiUbfljTgILFw3CsPW8JESOGQc0Pv8ieznIighqPPFz9g+zSu
 Ss/rpcsqag5n9rQp/H3WW5zKUpeYcKGaPDp/vSUovMcjp8USIhzBBrmI7UWAtuedG9prjqfO
 wU0ETpLnhgEQAM+cDWLL+Wvc9cLhA2OXZ/gMmu7NbYKjfth1UyOuBd5emIO+d4RfFM02XFTI
 t4MxwhAryhsKQQcA4iQNldkbyeviYrPKWjLTjRXT5cD2lpWzr+Jx7mX7InV5JOz1Qq+P+nJW
 YIBjUKhI03ux89p58CYil24Zpyn2F5cX7U+inY8lJIBwLPBnc9Z0An/DVnUOD+0wIcYVnZAK
 DiIXODkGqTg3fhZwbbi+KAhtHPFM2fGw2VTUf62IHzV+eBSnamzPOBc1XsJYKRo3FHNeLuS8
 f4wUe7bWb9O66PPFK/RkeqNX6akkFBf9VfrZ1rTEKAyJ2uqf1EI1olYnENk4+00IBa+BavGQ
 8UW9dGW3nbPrfuOV5UUvbnsSQwj67pSdrBQqilr5N/5H9z7VCDQ0dhuJNtvDSlTf2iUFBqgk
 3smln31PUYiVPrMP0V4ja0i9qtO/TB01rTfTyXTRtqz53qO5dGsYiliJO5aUmh8swVpotgK4
 /57h3zGsaXO9PGgnnAdqeKVITaFTLY1ISg+Ptb4KoliiOjrBMmQUSJVtkUXMrCMCeuPDGHo7
 39Xc75lcHlGuM3yEB//htKjyprbLeLf1y4xPyTeeF5zg/0ztRZNKZicgEmxyUNBHHnBKHQxz
 1j+mzH0HjZZtXjGu2KLJ18G07q0fpz2ZPk2D53Ww39VNI/J9ABEBAAHCwV8EGAECAAkFAk6S
 54YCGwwACgkQvSWxBAa0cEk3tRAAgO+DFpbyIa4RlnfpcW17AfnpZi9VR5+zr496n2jH/1ld
 wRO/S+QNSA8qdABqMb9WI4BNaoANgcg0AS429Mq0taaWKkAjkkGAT7mD1Q5PiLr06Y/+Kzdr
 90eUVneqM2TUQQbK+Kh7JwmGVrRGNqQrDk+gRNvKnGwFNeTkTKtJ0P8jYd7P1gZb9Fwj9YLx
 jhn/sVIhNmEBLBoI7PL+9fbILqJPHgAwW35rpnq4f/EYTykbk1sa13Tav6btJ+4QOgbcezWI
 wZ5w/JVfEJW9JXp3BFAVzRQ5nVrrLDAJZ8Y5ioWcm99JtSIIxXxt9FJaGc1Bgsi5K/+dyTKL
 wLMJgiBzbVx8G+fCJJ9YtlNOPWhbKPlrQ8+AY52Aagi9WNhe6XfJdh5g6ptiOILm330mkR4g
 W6nEgZVyIyTq3ekOuruftWL99qpP5zi+eNrMmLRQx9iecDNgFr342R9bTDlb1TLuRb+/tJ98
 f/bIWIr0cqQmqQ33FgRhrG1+Xml6UXyJ2jExmlO8JljuOGeXYh6ZkIEyzqzffzBLXZCujlYQ
 DFXpyMNVJ2ZwPmX2mWEoYuaBU0JN7wM+/zWgOf2zRwhEuD3A2cO2PxoiIfyUEfB9SSmffaK/
 S4xXoB6wvGENZ85Hg37C7WDNdaAt6Xh2uQIly5grkgvWppkNy4ZHxE+jeNsU7tg=
In-Reply-To: <51e455417bdcfe608270c6cb2806b1fd971fb998.1783524645.git.gregoire.layet@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08. 07. 26, 17:35, Grégoire Layet wrote:
> Add support for VUART over PCIe between BMC and host.
> Add the host side driver.
> Support only the AST2600.
> 
> Taken from ASPEED 6.18 Kernel SDK and trimmed down.
...
> --- /dev/null
> +++ b/drivers/soc/aspeed/aspeed-host-bmc-dev.c
> @@ -0,0 +1,174 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +// Copyright (C) ASPEED Technology Inc.
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/errno.h>
> +#include <linux/pci.h>
> +#include <linux/serial_core.h>
> +#include <linux/serial_8250.h>
> +
> +#define BMC_MULTI_MSI	32
> +#define PCI_BMC_DEVICE_ID 0x2402
> +
> +#define DRIVER_NAME "aspeed-host-bmc-dev"
> +
> +enum aspeed_platform_id {
> +	ASPEED,

What is this good for?

> +};
> +
> +static const int vuart_msi_index[2] = { 16, 17 };
> +static const int vuart_port_addr[2] = {0x3f8, 0x2f8};

Sort of inconsistent spaces. Both arrays should be unsigned anyway. And 
for the latter, u16 should be enough.

> +struct aspeed_pci_bmc_dev {
> +	unsigned long message_bar_base;
> +
> +	struct uart_8250_port uart[2];
> +	int uart_line[2];
> +};
> +
> +static int aspeed_pci_bmc_device_setup_vuart(struct pci_dev *pdev, int idx)
> +{
> +	struct aspeed_pci_bmc_dev *pci_bmc_dev = pci_get_drvdata(pdev);
> +	struct device *dev = &pdev->dev;
> +	struct uart_8250_port *uart = &pci_bmc_dev->uart[idx];
> +	u16 vuart_ioport;
> +	int ret;
> +
> +	/* Assign the line to non-exist device before everything is setup */
> +	pci_bmc_dev->uart_line[idx] = -ENOENT;
> +
> +	vuart_ioport = vuart_port_addr[idx];
> +	/* ASPEED BMC device shift addresses by 2 to the left */
> +	vuart_ioport = vuart_ioport << 2;

Simply:
vuart_ioport <<= 2;
? Or join the two lines?

> +	uart->port.flags = UPF_SKIP_TEST | UPF_BOOT_AUTOCONF | UPF_SHARE_IRQ;
> +	uart->port.uartclk = 115200 * 16;
> +	uart->port.irq = pci_irq_vector(pdev, vuart_msi_index[idx]);
> +	uart->port.dev = dev;
> +	uart->port.iotype = UPIO_MEM32;
> +	uart->port.iobase = 0;
> +	uart->port.mapbase = pci_bmc_dev->message_bar_base + vuart_ioport;
> +	uart->port.membase = 0;
> +	uart->port.type = PORT_16550A;
> +	uart->port.flags |= (UPF_IOREMAP | UPF_FIXED_PORT | UPF_FIXED_TYPE);
> +	uart->port.regshift = 2;
> +
> +	ret = serial8250_register_8250_port(&pci_bmc_dev->uart[idx]);
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret, "Can't setup PCIe VUART%d\n", idx);
> +		return ret;
> +	}
> +
> +	pci_bmc_dev->uart_line[idx] = ret;
> +
> +	return 0;
> +}
...
> +static struct pci_device_id aspeed_host_bmc_dev_pci_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_ASPEED, PCI_BMC_DEVICE_ID),
> +		.class = 0xFF0000, .class_mask = 0xFFFF00,

PCI_CLASS_OTHERS << 16

> +		.driver_data = ASPEED },
> +	{ 0 }
> +};
> +
> +MODULE_DEVICE_TABLE(pci, aspeed_host_bmc_dev_pci_ids);
> +
> +static struct pci_driver aspeed_host_bmc_dev_driver = {
> +	.name		= DRIVER_NAME,
> +	.id_table	= aspeed_host_bmc_dev_pci_ids,
> +	.probe		= aspeed_pci_host_bmc_device_probe,
> +	.remove		= aspeed_pci_host_bmc_device_remove,
> +};
> +
> +module_driver(aspeed_host_bmc_dev_driver, pci_register_driver, pci_unregister_driver);
> +
> +MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
> +MODULE_DESCRIPTION("ASPEED Host BMC DEVICE Driver");
> +MODULE_LICENSE("GPL");

thanks,
-- 
js
suse labs
