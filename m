Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A088E2951A7;
	Tue,  2 Dec 2025 05:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764654177; cv=none; b=CUn22VD9XLWN+AvWfCSG5eLiG5wPQSmxccO6Kd37x6yu+oIK8zeGeBsU7K5hEoEcZ7u3lTEBmq4/Eo8h9Vk05P/UFrL7C/TlKyGzY10o1vD1fa+XseDQCVmHe+ICspuD+XbT3bg6PEkHpT30DUuF2ykmRiAi4zZUhZBMFrBK6Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764654177; c=relaxed/simple;
	bh=obfmHNPc1CG6JeCVKNZYjQV0BfHSxMC/CXBGphNG1+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejOsQeCfBHsHWpBPvDj9u4R2e4kaqBsatwYk5IN1vco2pbL+c4ruwn8yCl8GxGZrE5tzhW3BaECrWHkPhwOkqXMm22aE6LytrYi1paVtFU+IuoXdYYQvCbGTlwObj072VBs4p0GYefjRAbQRI65hHajvttba70kf6WWlnFspHOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frkQW5VG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frkQW5VG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032C7C4CEF1;
	Tue,  2 Dec 2025 05:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764654177;
	bh=obfmHNPc1CG6JeCVKNZYjQV0BfHSxMC/CXBGphNG1+4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=frkQW5VGqimzc7J8a++I+W5NUs0rGfxZ1VIfxlLZiUP9f9rAq/r//rTguptK+D7Xg
	 vYGG2+q5xztrTPm8YKmDZczVMBQCh28GETuwK2ipkeMsXBqoF1V8VM6BZfr3Kkc0Ni
	 xq05W2d5ygjPSmtU+JxKDAg4CLTf/TIwF5HWUmuafZfx0H3e8gdjlFeEKvRMI6+eff
	 2AA75eWefpipV9xqGlfmwvzYTFROUVqOwX1uq9i4HWMW6BjfIUzJKKfQnrX1z03BQg
	 L675+k59HPy43kyQWUOcFW0qyMM1+GsATlV3I8NGSGnwmKyc4bNC+23KFpTHYQ/lWf
	 gFDhMDwOiiQeQ==
Date: Mon, 1 Dec 2025 19:42:55 -1000
From: Tejun Heo <tj@kernel.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, hch@infradead.org,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4] tty: tty_port: add workqueue to flip tty buffer
Message-ID: <aS58X-1-Izo237HY@slm.duckdns.org>
References: <20251128181048.429570-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128181048.429570-1-jackzxcui1989@163.com>

Hello,

On Sat, Nov 29, 2025 at 02:10:48AM +0800, Xin Zhao wrote:
> +	if (!(driver->flags & TTY_DRIVER_CUSTOM_WORKQUEUE)) {
> +		driver->flip_wq = alloc_workqueue("%s-flip-wq",
> +						WQ_UNBOUND | WQ_SYSFS,
> +						0, driver->name);
> +		if (!driver->flip_wq) {
> +			error = -ENOMEM;
> +			goto err_unreg_char;
> +		}
> +		for (i = 0; i < driver->num; i++) {
> +			if (driver->ports[i] && !driver->ports[i]->buf.flip_wq)
> +				tty_port_link_driver_wq(driver->ports[i], driver);
> +		}
> +	}

Maybe it's just me not understanding the requirement but does this need to
be this complicated? It was just using system_unbound_wq before. Can we
start with something very simple - ie. one custom workqueue which is shared
across devices? Wouldn't that work?

Thanks.

-- 
tejun
