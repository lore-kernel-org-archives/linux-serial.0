Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F46198843
	for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2024 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718650947; cv=none; b=AqF1KUwSyyRp/OeSLTPlifxv47fkUnlY+wREANzfJsLTDce4lDPpe04dVTKpIj0KI72YPuK0J2zCGg+t6Rygz+7nzTOnsX2aBu/jfBIOOMSxKjnoSDzMhveildXHE180NEbV/bGeNRhMnaupmdavdUxv0CXf8J8myiT7EYRxVMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718650947; c=relaxed/simple;
	bh=MWSn9TBjOwS2vg8xx5VVZIugFpI93VfejC92HrxWgPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n2Bna63USsy5ffd8f2KULIA0pC3w884OcK4MV1wd6BGvE02P0tb75/ctOed+ZbEOYPtIf2zCmpS4/ogR+vWIAVJpplORLyA0ZSmLAhrFMcnzcOdTokebl0PAJtXykm+MkzE8Hg7bNBpfUfw0ZMRSv0j3m+0ns4zKza46/g9bv4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gYq2WY8K; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gYq2WY8K"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ec1ac1aed2so33662581fa.3
        for <linux-serial@vger.kernel.org>; Mon, 17 Jun 2024 12:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718650943; x=1719255743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6SrWLHt58GYbBezUKilQJH2NVZYtT03QBjIfd+Sim4=;
        b=gYq2WY8KIULJBDmLP3ZarQ+OMr51unZEHSLS5KV6jrCSlysIaD6d+4DsPW7b36MgFq
         nKw0hLIs+pWrsRUJ38X1eZZ+HcwlXhFvtHa6Q6gfBh0fgCNcIzHXlKKwm1jx/KL7TKyv
         cFcG3oZvhaLYnG+XJFGFdTtS7yOwr06eqfZ+MuPtVmkM9J+c06wWU9Id3sbsemLAfcsy
         kyEpChFWHLC4gpUHJpql0aumZhZ40bHS7KVJsmQp8XU2NVnscKUBURWd0Ra3JJt8n7Wv
         0Q8z/czdh7hJmn8JoJzaaneXDgJYF6g6tsoVOqIsVDMr6Ga95P9vF9Sg/5P8nGJlhDLL
         M1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718650943; x=1719255743;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6SrWLHt58GYbBezUKilQJH2NVZYtT03QBjIfd+Sim4=;
        b=jSZI7TW7QwxxUlnomnEFcIJAzfz8BG9h5W664WaVS4DKPYW+Ck4vJa1mMy6z30uqRa
         NBqH6K9RZvdQuEBW8O9beBmbambSYlwZLrUMMn6D9+TRz0E1j3O01YW8MP8WvtytY2GA
         wZv5QMY7GmFxZvvkIfa8Qb76ysEimF7ATGAcbTpWj+7SqkLZYfwwP/adpsVmHccHsKM8
         92j7e6afOwQa39YCqDg78pZa6yuM87Q/KbHS6QGUEpEZ4oSQEhioIvd8/BfLY+ZN8qjo
         0oho7cXBB7AyWCpKQz8l66QNwrLW44jlXTjlEMJ15MTCS40jFZ9a8F4Pj71h858fGafd
         dd2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgnOoE3F48lNtYyuSFFgLHXD6Aa3qJ/AM2BB9Ck3Y+9xAHxXn/G4PNh3EJ4sZz2NQEmtkkQmgmkvyY+QhAdyBlOHYhhrz83eNHJZeA
X-Gm-Message-State: AOJu0Yz93POzM0MKtVuxdy8FHi86W3tMIfJCrvKPAuHs3QhnQSuKGBCo
	hzHmrTIiEULB0r1vX93Xu5cQL7x/2d5BYXflogcnjSRIjIoohqQ8EsjsR34KjFM=
X-Google-Smtp-Source: AGHT+IH5YGd+qGuXOU5UKQe5p1ChD3oRExLbGKUgR6iEmBhGv1dD9uZKX1AH4vpF2z+cj8C49W/oqw==
X-Received: by 2002:a2e:9254:0:b0:2eb:d825:e720 with SMTP id 38308e7fff4ca-2ec0e5c6d3amr71014321fa.22.1718650943345;
        Mon, 17 Jun 2024 12:02:23 -0700 (PDT)
Received: from ?IPV6:2a00:f41:cb2:a9df:9f88:17b:c7e7:fa59? ([2a00:f41:cb2:a9df:9f88:17b:c7e7:fa59])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec346d009esm492831fa.89.2024.06.17.12.02.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 12:02:23 -0700 (PDT)
Message-ID: <004b1060-3217-4ab9-805e-c1b8c95b119c@linaro.org>
Date: Mon, 17 Jun 2024 21:02:20 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] serial: qcom-geni: Fix suspend while active UART
 xfer
To: Douglas Anderson <dianders@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: Yicong Yang <yangyicong@hisilicon.com>, Tony Lindgren <tony@atomide.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Johan Hovold <johan+linaro@kernel.org>,
 John Ogness <john.ogness@linutronix.de>, linux-arm-msm@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Stephen Boyd <swboyd@chromium.org>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20240610222515.3023730-1-dianders@chromium.org>
 <20240610152420.v4.7.I0f81a5baa37d368f291c96ee4830abca337e3c87@changeid>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240610152420.v4.7.I0f81a5baa37d368f291c96ee4830abca337e3c87@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/11/24 00:24, Douglas Anderson wrote:
> On devices using Qualcomm's GENI UART it is possible to get the UART
> stuck such that it no longer outputs data. Specifically, logging in
> via an agetty on the debug serial port (which was _not_ used for
> kernel console) and running:
>    cat /var/log/messages
> ...and then (via an SSH session) forcing a few suspend/resume cycles
> causes the UART to stop transmitting.
> 
> The root of the problems was with qcom_geni_serial_stop_tx_fifo()
> which is called as part of the suspend process. Specific problems with
> that function:
> - When an in-progress "tx" command is cancelled it doesn't appear to
>    fully drain the FIFO. That meant qcom_geni_serial_tx_empty()
>    continued to report that the FIFO wasn't empty. The
>    qcom_geni_serial_start_tx_fifo() function didn't re-enable
>    interrupts in this case so the driver would never start transferring
>    again.
> - When the driver cancelled the current "tx" command but it forgot to
>    zero out "tx_remaining". This confused logic elsewhere in the
>    driver.
> - From experimentation, it appears that cancelling the "tx" command
>    could drop some of the queued up bytes.
> 
> While qcom_geni_serial_stop_tx_fifo() could be fixed to drain the FIFO
> and shut things down properly, stop_tx() isn't supposed to be a slow
> function. It is run with local interrupts off and is documented to
> stop transmitting "as soon as possible". Change the function to just
> stop new bytes from being queued. In order to make this work, change
> qcom_geni_serial_start_tx_fifo() to remove some conditions. It's
> always safe to enable the watermark interrupt and the IRQ handler will
> disable it if it's not needed.
> 
> For system suspend the queue still needs to be drained. Failure to do
> so means that the hardware won't provide new interrupts until a
> "cancel" command is sent. Add draining logic (fixing the issues noted
> above) at suspend time.
> 
> NOTE: It would be ideal if qcom_geni_serial_stop_tx_fifo() could
> "pause" the transmitter right away. There is no obvious way to do this
> in the docs and experimentation didn't find any tricks either, so
> stopping TX "as soon as possible" isn't very soon but is the best
> possible.
> 
> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver support for GENI based QUP")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

This all looks good in my eyes, with the assumption that sending an ABORT
can't somehow be rejected by the hardware.. I wouldn't normally think of
that, but GENI is peculiar at times

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

