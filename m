Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29021BAA4C
	for <linux-serial@vger.kernel.org>; Mon, 25 Mar 2024 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365200; cv=none; b=kYut6HJ8w5RFyTnwWjqsswS61XwG/cXyzBLanu68IMHh9sQd0X6STfS+RZ4zS2/XMRMv4v3MV7gYzPEyHvBZ7LjcS/h3ldjJ9Ihf9IPWOKxjsIwKyzxLd7iRZVI0JN4m1exKwtzgHbhD21pQCDwRZRdUZANhy9jqO5cOqd3FwPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365200; c=relaxed/simple;
	bh=Hsa/4RMLo7slhwDozooCgxr8Rhe6jK9MdW6Cr2Tbkbo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gAlLWBlw90hVyTvZnUVqDRoBG72jBnqIUntrUKxCC+I4oWcro+xO8TSN7rY2VkGGQJCqSbuv3J2EAFNAw8nVeSU7DiEdhCMj4iVq3fo1e/qfPSyIKrwjtm5FRX2I08Mcf02TZqoRMzSF98oXBWGtACOnYweLnMAUMLBIEpljaXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6ljovrx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6ljovrx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711365195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAPHGbxlJ6k982EnibWHBxa9+vZqkzt4vbnevEyQxDY=;
	b=i6ljovrxAAxtvJII+5FvBck2e+Y+YtGgrYqG7qg0wLeKvICjtKddxa94WSc045W+j5P67U
	0GSPJYHBf1FupyAeHXOrIVlDAGU2R3BAjBQroPUBnv8F6uE+j1qu/D7GyecBcb/Ry2G38+
	tGjgXqYK2YW2BQBhQ3E7rxvsTuk/veY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-zZrAo97_Mpqe2iyAmZJchA-1; Mon, 25 Mar 2024 07:13:14 -0400
X-MC-Unique: zZrAo97_Mpqe2iyAmZJchA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-56c0876729cso903120a12.0
        for <linux-serial@vger.kernel.org>; Mon, 25 Mar 2024 04:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711365193; x=1711969993;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAPHGbxlJ6k982EnibWHBxa9+vZqkzt4vbnevEyQxDY=;
        b=EBVoK2NnT4txz5oBa6w45w9PBqdK3ftOnoLeEsPrL9oAUU2EvroOrQrVT+NQn8q/Au
         jcz3kU9ehk9qkH+g80nnwUQ+o7Pe9Qh03yzTnKv/HHWAVq1WrtRqc5rxKu0GBgHn2DvI
         pvNH5K9SAEw5tRCoXl3H+yKnyXvXwCOqhYqgGpNjiBBopo2xUpFmZRn1pZho52BDW6P4
         dQzl3fSwt7SvBnQi2wX5k1HwKRr1DUcmt0l51y6791W11zVtvf0lAsfCKjx7xbwPyGnt
         1kxzQ5rr78YigT02T047uWHS+WPLEvLhfkr0eFLM3ZWopeqlcbvPFqyUHQwQDVHt6cSu
         DqQA==
X-Forwarded-Encrypted: i=1; AJvYcCWK97vST2+9tOxWkXFT6NL2tp3UFeJhyAZHmJtq1PR5P8TpSNqjGaTrJCKUpr3OJ9i18QE3UfHXz1Xkc/JYwb9quPYI4tmpkZ2n8SIj
X-Gm-Message-State: AOJu0YwzrIHZkg1l+x40RRuSX/VdybHmalW5q1zTwluurfDUHkw1zJjj
	XqzYL2wOfCaTAQa4HX3Fi3PU5oh2VasBBiizfhVvxfdoJnIHlfbjoJ4b6I5JSif85yIPckpGncW
	Wkw1zbQhjyM9urhMFKdmi4TnWVhAu7e334ZKg5EB3ej0pFrKgyULREhGqbCEdnw==
X-Received: by 2002:a50:8753:0:b0:568:aced:e5a0 with SMTP id 19-20020a508753000000b00568acede5a0mr5705685edv.14.1711365193419;
        Mon, 25 Mar 2024 04:13:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDFlIpB/lK3v3cbB5QOQ7Bbg8iNxhFwokSKMspks8TaBGXgxvtbwZi1GudHYxQskJStFdo7A==
X-Received: by 2002:a50:8753:0:b0:568:aced:e5a0 with SMTP id 19-20020a508753000000b00568acede5a0mr5705672edv.14.1711365193137;
        Mon, 25 Mar 2024 04:13:13 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id fi24-20020a056402551800b0056bfa6ad5eesm2530825edb.91.2024.03.25.04.13.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 04:13:12 -0700 (PDT)
Message-ID: <f677cad0-4387-4a79-b7bb-f7b0676e5418@redhat.com>
Date: Mon, 25 Mar 2024 12:13:11 +0100
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/28] platform: intel_ips: Use PCI_IRQ_INTX
To: Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-sound@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 ntb@lists.linux.dev, Lee Jones <lee@kernel.org>,
 David Airlie <airlied@gmail.com>, amd-gfx@lists.freedesktop.org,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240325070944.3600338-1-dlemoal@kernel.org>
 <20240325070944.3600338-8-dlemoal@kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240325070944.3600338-8-dlemoal@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US, nl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/25/24 8:09 AM, Damien Le Moal wrote:
> Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
> macro.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Thanks, patch looks good to me, feel free to merge
this through whatever tree is convenient (or let me
know if you want me to pick up just this one patch
from the series).

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/platform/x86/intel_ips.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel_ips.c b/drivers/platform/x86/intel_ips.c
> index ba38649cc142..73ec4460a151 100644
> --- a/drivers/platform/x86/intel_ips.c
> +++ b/drivers/platform/x86/intel_ips.c
> @@ -1505,7 +1505,7 @@ static int ips_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	 * IRQ handler for ME interaction
>  	 * Note: don't use MSI here as the PCH has bugs.
>  	 */
> -	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY);
> +	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_INTX);
>  	if (ret < 0)
>  		return ret;
>  

