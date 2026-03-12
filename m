Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8D01A840A;
	Thu, 12 Mar 2026 13:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322986; cv=none; b=qfpaR6/epQtF2HO2v6pHhN6rDpQgxz7awm/SmqGhWRPY6B4150JJ/3YgcAyIJBOGKU5SEpjBkbXcYG34OiuRNdJQE2oX7HzS0u1TulXRXIPlcPiKtLMT6wpnt9MZ7kIg5flWjIVHpX3vgqC+9z7pY6kKt+P2s0nlh8GW0f3XQF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322986; c=relaxed/simple;
	bh=CfKcbgRGnk0+7hok+jTqYa5F+S3GZL26/2I1OSIDL00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJdzq5jUvrA9mVkW5xz9AmSZpO8K+xjfAxH3E5bZuYP9OfiZuPC7p9h3bFiWAi4HaZ72UZZy6YpFcQVrQ4BFfWOLLWEPffgYEf4dnIBEX7cPiXW2fHURHogJ7ju4PONjc0CzamdaSO6ahGQ+I8nW9whtfkWS5aFuqzjB2QtuZmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BXz2J0RD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BXz2J0RD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D80CC4CEF7;
	Thu, 12 Mar 2026 13:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773322986;
	bh=CfKcbgRGnk0+7hok+jTqYa5F+S3GZL26/2I1OSIDL00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BXz2J0RD8Pz9VWMgJV4eiM+9dmZLAtifMwZJI2j7hdo0/ou0ffkfgeg9SugPkVIXC
	 O0O3ekVYcRldC9JaKnHyU66fIPUj8JzK3QGnB7WX8qPF32fct1BrfAaN/1kwvdlIZC
	 vL3AtaxxyT2OCFGDu2op5K2KMgrw4fReqj+y+jxs=
Date: Thu, 12 Mar 2026 14:43:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kartik Rajput <kkartik@nvidia.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Robert Marko <robert.marko@sartura.hr>,
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] serial: tegra: remove Kconfig dependency on APB DMA
 controller
Message-ID: <2026031248-devalue-diabetic-51ed@gregkh>
References: <20251126090759.4042709-1-flavra@baylibre.com>
 <c850b374071b694e4c33ca091d124c0e90df02e1.camel@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c850b374071b694e4c33ca091d124c0e90df02e1.camel@baylibre.com>

On Wed, Feb 25, 2026 at 12:35:53PM +0100, Francesco Lavra wrote:
> Friendly ping

Can you resend this, I don't have it around anymore, thanks.

greg k-h
