Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720391494A6
	for <linux-serial@vger.kernel.org>; Fri, 26 Apr 2024 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145562; cv=none; b=gp8qoUJQP9sy50U29WW1c3F6xiFBwBqljk5i9TVDhTmNKr7om/tYzxBBXjvQU7VLCBtzX+IXCxVcUQA4ya6CdfvHEunvtRhZ8j7khLweVkuRzstSTMSA7cD4MhaiNJ4qNqtYQ9kKr9RFb6aMbfqoZnX9JYMsHn0irbcGQbS6Z0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145562; c=relaxed/simple;
	bh=qklciRQxec8j59g3ZMuTPWOVbw7bNHFK9MOa3OI5oBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVunE8u82dgAs/XHuAejHYsMdK4oguMLjnD3jrJs+uZ4FaPMQKKgUqwH8Ocw/9QSAYN+9eFwPb7kI2FWCoZxzPxyewHBJ4VBH+76O+NDvjp/uSIBWyS7HI11C/HARd2Oxfl3SxvjdxurcGm3SQ8cM8t5fmOLxRRlZ/9z+Wv9mww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A28551tf; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A28551tf"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-572511ae0c2so1371292a12.3
        for <linux-serial@vger.kernel.org>; Fri, 26 Apr 2024 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714145559; x=1714750359; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gd6ILVzk0t6uXM79Zttkn5VJ29kj20R5ZD7OwenGmLo=;
        b=A28551tf4kbu1BWESsy4bxyXyR2ba8bom2utsMw0Hg72G0xIITj3xZfKWgE5xY5WXU
         NFd3IJxvzScIibRBwpGr3rTMgMaUlS/2+xKlM8KNQz42p4x6hHay6+O1Pd8Eqj/2n6sx
         Kx5DdMEhJFrWJf/SE1e+TjtaNp5+rDyDLB03m2Zj9hS0PJQozPKn9BS29o+dsP5yIV1b
         bPYktCaCov0pq6s+G7N5/yIXFI0Tsqpi97Nc4fh96lE+eZTzgJZgL7ebGdCUf3GCxuzs
         dcIB3dHROUfVMYPw8Z3R737XfyXMpJLlHhuk6bhk7oYCfJKG8VbVumwhtnljdfDgXVli
         Y2TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145559; x=1714750359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gd6ILVzk0t6uXM79Zttkn5VJ29kj20R5ZD7OwenGmLo=;
        b=YLU4/NPrOlqmQGsBu4gYu5/nEsNP+kzSN3C2ej4b24g3H1Q6MMnuVRt8A63obVpRG7
         6yG6kbcIWQK5k/P81av1YxUz2ho1jrUC2VkHT13mRFOnVti4KV7UEsTUusAgoSyp0p/v
         +pCovHnncp1BZU5mg0EFs1GhmSKlCCBDBtJbt0ynTATCBu82okTLyuOvxZ+g+dYQBMSj
         qyle6d2w2kNkL+N24h7/yuK4hUL4/KvQcvxMWBWJgyESVtrvkxD5r+ZfBTApHGzhzphS
         ZdUKPMDNY+rap78xXPiqkCdAzH/p5keDPEr5dBXWKBbRkIu+a7KnIgxjwqZWYA0Eo3tY
         efsA==
X-Forwarded-Encrypted: i=1; AJvYcCU6UcFNcMi+LMz6laF8pSbgqKpDhsVcykqap1EdXENCEedL8ys/Waovc8W/+zwTZmLV3AyCeRFBjZgY3563oBLWzGXfjqwvsUczFt2L
X-Gm-Message-State: AOJu0Yx21W4qhRM4Ix68NO/H2fVdaNpWDGa5HNIfPgct293QYuVSAi1I
	oYs/znCJ1AjhzcA31pq4TFaXxDw9g4FtMa2lPkkCJhvdjGgGGr6a9eT/N6qOBBk=
X-Google-Smtp-Source: AGHT+IHO9ZwNd+bCnrGqjMRC0t/4lWSuJQ5CiOnjwm37ZKk+bzMBetUelSmBBHMySLB81gG6EG9SRw==
X-Received: by 2002:a17:906:13c7:b0:a51:f463:cfa6 with SMTP id g7-20020a17090613c700b00a51f463cfa6mr2046211ejc.29.1714145558440;
        Fri, 26 Apr 2024 08:32:38 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id z12-20020a170906270c00b00a55895c7f50sm9192735ejc.151.2024.04.26.08.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:32:37 -0700 (PDT)
Date: Fri, 26 Apr 2024 18:32:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: lumingyindetect@126.com, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	gregkh@linuxfoundation.org, jirislaby@kernel.org,
	LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
Subject: Re: [PATCH] serial: 8250_lpss: Fix memory leak in lpss8250_probe()
Message-ID: <047e490b-0dbf-49b7-9506-996f0053e92d@moroto.mountain>
References: <20240426114716.1275085-1-lumingyindetect@126.com>
 <87d376e4-84f1-48c3-8c5d-955f706f3bfb@moroto.mountain>
 <Ziu-HUUE43xsjnia@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ziu-HUUE43xsjnia@smile.fi.intel.com>

On Fri, Apr 26, 2024 at 05:45:49PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 26, 2024 at 04:53:18PM +0300, Dan Carpenter wrote:
> 
> > > Fixes: e88c4cfcb7b888ac374916806f86c17d8ecaeb67
> > 
> > This is the wrong hash and the format is wrong.  It should be:
> > 
> > Fixes: 254cc7743e84 ("serial: 8250_lpss: Switch over to MSI interrupts")
> 
> Since you are here, just pay attention that this does NOT fix anything
> as it uses pcim_enable_device(). I hope smatch won't stumble over this
> and produce false positives.
> 

Ah...  No, this isn't a Smatch warning.  I think I tried to add it but
was told it was wrong because I have this in my unpublished code.  :P

// Are these affected by pcim_enable_device()?
//      { "pci_alloc_irq_vectors", ALLOC, 0, "$",  &int_one, &int_max },
//      { "pci_free_irq_vectors", RELEASE, 0, "$" },

So when we're using pcim_enable_device(), calling pci_free_irq_vectors()
is harmless but not necessary?

regards,
dan carpenter
