Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FF730504A
	for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764251584; cv=none; b=MBCRwD4lDJQIeMDiLhFaTkj/xhlbbW7qxkSFTbXdkMz6kSZEzuzXWjgSWZJCiDwaB2gjiSRrxIyszwDIM4c2hCUw0GjDTb3zlyiLuL5ILAIhCCeGhVzA2blheC7nlKsAztV3fyLmfOgMaP3ivTryiv25upqb8WQwYywg+eidmx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764251584; c=relaxed/simple;
	bh=uvWSUnAueiEOoFOEIl2JYdtmpK89idUnhb83TwQALwc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEL8BvZUOhkvzSFte6ZWhQtLMctdA2DuXsdDDKlROsFwXqXAFNi9Tj2lYTk5j08Qqcv0Xo+mIiZd4fKiedvY1rQyx3nfZldeHf1iNsTTCs4JQ+kMFrrCoM9DGo1XC6lbJyy5LtzLKNH75S2e0by3YzZMQfd0l4D4FfpjjrClNKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Dnu4my3I; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Dnu4my3I"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-596a055b1b8so1020726e87.0
        for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 05:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1764251580; x=1764856380; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pN64heDHbxqZ2OKQxyJVBsdd0gJZEzFf6zoPDx6GqoA=;
        b=Dnu4my3Ic1+uyfUIZlX9r952UDUx4Un5aKBPAnOVnWX73cFuzv4Tkz8I9uXsjRJwDy
         MifpyoIwNOgbL1pELe3kXR/zFqhGUIl3TqjztPcB48bz1ldm4CK7cW0DbdNTve9VIq7P
         SmrjS9T50H7epBqEQbscoqdLnpPNqiU0laDWV91fA/BfQd7nM0zQKlPMhi9wOxRuytPs
         pW7vG1oxg9wvtBLXoFuCIc3VDceGbrtGz4hgzfYdTCUe5bBoRDor1kb65LH9mSQsiJ5V
         XdzxXXZdjPjLFSGngOt53q+/dEXCODNSz3+fNLs1aR99Vz2500fGNy4qAKLDTWsENyVa
         /eWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764251580; x=1764856380;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pN64heDHbxqZ2OKQxyJVBsdd0gJZEzFf6zoPDx6GqoA=;
        b=Krf9N+3FJgjVnJ3n1qVmpx/Zb4DEn5O3j7sLhzNCg0laWJs/FD8lOpXI+QJm9HPm34
         vwvYbi918kYUN+L6YgYLsvh81MKaDKKWXuM/azSWV9y8VHlvIopcvvd7egp2M9261myl
         BbD/Gt3hpD0cD2zNPDYVIe9DFvlxmL4eQBAHljY7QhA0B7ljzt8/M0lQ5ZI9LggOs1c2
         u4VDONBCwnTCldj9TZhAs9VDj1JITl2Z+XGZbPaEqNI3CyLwO16+4uPmoCFzhITp9oW3
         7rxOIX89qMGZTKJAXf9WOEWytf9ZVtwgUaFXvZvAyHEbiMV/aZLciTja92EYEMElEx0Z
         lXRg==
X-Forwarded-Encrypted: i=1; AJvYcCVYq9WpsmoZ9HUzWrL1YWsnfxrEDNdrB1bgdsmHsKrQzEcxMWpV+hYRtSmV2NZi+13Td0I3u2hjoH68F7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDcy7TQ6Dqyy1UMSFwVZtN36YWSXOi1eRDodsK7zaW6vAMQQcf
	4wVrcBscYNfyvPyKi8FzikGCgYgVu1WEUKU6PDqgrOv+f2qwocqo+08d7H8h7ZBNlWyh7CD6t4E
	tktX1woo8Vq1ipfE8HWhSJoTrrXyO4dLkVu/sr2qB/9X8pYHoqLBOyuc=
X-Gm-Gg: ASbGncvEPZEfRVunDfToOLAafJ5DGgnGPq8ueVG4LhSD1VGA7KVzaQfzqJZEM6+9Rud
	nwChu8ShaV7i41Ult2t9X6wSkftrriADNHFOs1KoOrNKt0M5H9XhoyN/6KbPK0P9pgfYFKIokr1
	p/K8fQmQMKh02RWP6yRHRRfL+CtWr9/BWgwHWaEyT/RwVGMj6gD9Xpkbe0wNTXGHvinGdkbV/ro
	oGmLZBW7ROROP+WjqhMNFdXb8gNkAtvJ6X7wNOy36RUkqZis4TEwPZEdwYNszZuL4bdhOmHNg/6
	BeAxZSO1T69ZmVc1MDaTdXqWBc8=
X-Google-Smtp-Source: AGHT+IG6PL+Jiezoh/uDW8dnWLihyDKxT0NJj0K3mdDXkbk6oKkhSmfyJZwok91yAbizDOVups9BJ+4+9Gf5UTlIkv4=
X-Received: by 2002:a05:6512:2351:b0:594:93b8:88b6 with SMTP id
 2adb3069b0e04-596a3eed692mr7226030e87.38.1764251580020; Thu, 27 Nov 2025
 05:53:00 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Nov 2025 07:52:58 -0600
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Nov 2025 07:52:58 -0600
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20251125-pci-m2-e-v2-4-32826de07cc5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com> <20251125-pci-m2-e-v2-4-32826de07cc5@oss.qualcomm.com>
Date: Thu, 27 Nov 2025 07:52:58 -0600
X-Gm-Features: AWmQ_bmPoMOTBlwPqpCqq0qp_ZAAK68AQ2h724JshuQcjnDCyPKjaA9BdddHSek
Message-ID: <CAMRc=MeOfpFME0LL+WDSM3ZVUOiqTCHQN-E3=PZ_qTMLWDKaKQ@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] serdev: Add an API to find the serdev controller
 associated with the devicetree node
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Nov 2025 15:45:08 +0100, Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> said:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> Add of_find_serdev_controller_by_node() API to find the serdev controller
> device associated with the devicetree node.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/tty/serdev/core.c | 16 ++++++++++++++++
>  include/linux/serdev.h    |  9 +++++++++
>  2 files changed, 25 insertions(+)
>
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index 76b89dd0720f..f90095cb778f 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -530,6 +530,22 @@ struct serdev_controller *serdev_controller_alloc(struct device *host,
>  }
>  EXPORT_SYMBOL_GPL(serdev_controller_alloc);
>
> +/**
> + * of_find_serdev_controller_by_node() - Find the serdev controller associated
> + *					 with the devicetree node
> + * @node:	Devicetree node
> + *
> + * Return: Pointer to the serdev controller associated with the node. NULL if
> + * the controller is not found.
> + */
> +struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
> +{
> +	struct device *dev = bus_find_device_by_of_node(&serdev_bus_type, node);
> +
> +	return (dev && dev->type == &serdev_ctrl_type) ? to_serdev_controller(dev) : NULL;
> +}
> +EXPORT_SYMBOL_GPL(of_find_serdev_controller_by_node);
> +
>  static int of_serdev_register_devices(struct serdev_controller *ctrl)
>  {
>  	struct device_node *node;
> diff --git a/include/linux/serdev.h b/include/linux/serdev.h
> index ffc6eb13f44b..fa235c92592a 100644
> --- a/include/linux/serdev.h
> +++ b/include/linux/serdev.h
> @@ -337,4 +337,13 @@ static inline bool serdev_acpi_get_uart_resource(struct acpi_resource *ares,
>  }
>  #endif /* CONFIG_ACPI */
>
> +#ifdef CONFIG_OF

You can make it independent from OF if you base the code on fwnode like:

struct serdev_controller find_serdev_controller_by_fwnode(struct
fwnode_handle *fwnode);
{
	struct device *dev = bus_find_device_by_fwnode(&serdev_bus_type, node);

	(...)
}

Users can always convert OF nodes to firmware nodes.

Bart

> +struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node);
> +#else
> +struct serdev_controller *of_find_serdev_controller_by_node(struct device_node *node)
> +{
> +	return NULL;
> +}
> +#endif /* CONFIG_OF */
> +
>  #endif /*_LINUX_SERDEV_H */
>
> --
> 2.48.1
>
>
