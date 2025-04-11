Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127BD26563C
	for <linux-serial@vger.kernel.org>; Fri, 11 Apr 2025 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744399840; cv=none; b=nij+K6TaEPnwIO6eFM5E0JK0e/LeE6fS8swlXf1/QMq2OpAXoogYQFZSxcGKIwoJ41o8FKRu41artSecywglfTfiFLnZ8ywyAL/B7+vLXywceOdKx8Oqz1haXaH+9zGsTylMwXaALw+p5g4hQB29tYxfY/1y0qYP2rAmWRXnrsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744399840; c=relaxed/simple;
	bh=G9ymRpsi7LH6seQTYYKAivJ8rVv9OMduJ64Qrp5Q5kw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFMfarP9FjCSRjmjEMNsqqNT4I13hGCdEhwC3ToLMukGeIMJYY3XXzx9aZ+PD9sf7pO5X3aKWjHoWM9TYYclOoHvwPmY1bvz48hElK/Fp+UqhgFiHKP1M5EEVO9PFXwQKlzhr5iKP3ABDkwoqn+lHSJmYcxPu8P6SaXCZD6SKlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 658c1b78-170b-11f0-8e90-005056bdfda7;
	Fri, 11 Apr 2025 22:30:17 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 11 Apr 2025 22:30:16 +0300
To: Alex Elder <elder@riscstar.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, dlan@gentoo.org,
	benjamin.larsson@genexis.eu, bastien.curutchet@bootlin.com,
	andriy.shevchenko@linux.intel.com, u.kleine-koenig@baylibre.com,
	lkundrak@v3.sk, devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] serial: 8250_of: manage bus clock in
 suspend/resume
Message-ID: <Z_ltyAO-OBzl0adV@surfacebook.localdomain>
References: <20250411154419.1379529-1-elder@riscstar.com>
 <20250411154419.1379529-4-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411154419.1379529-4-elder@riscstar.com>

Fri, Apr 11, 2025 at 10:44:18AM -0500, Alex Elder kirjoitti:
> Save the bus clock pointer in the of_serial_info structure, and use
> that to disable the bus clock on suspend and re-enable it on resume.

...

>  	if (!port->uartclk) {
> -		struct clk *bus_clk;
> -
> -		bus_clk = devm_clk_get_optional_enabled(dev, "bus");
> -		if (IS_ERR(bus_clk)) {
> -			ret = dev_err_probe(dev, PTR_ERR(bus_clk), "failed to get bus clock\n");
> +		info->bus_clk = devm_clk_get_optional_enabled(dev, "bus");
> +		if (IS_ERR(info->bus_clk)) {
> +			ret = dev_err_probe(dev, PTR_ERR(info->bus_clk),
> +					    "failed to get bus clock\n");
>  			goto err_pmruntime;
>  		}
>  
>  		/* If the bus clock is required, core clock must be named */
> -		info->clk = devm_clk_get_enabled(dev, bus_clk ? "core" : NULL);
> +		info->clk = devm_clk_get_enabled(dev, info->bus_clk ? "core" : NULL);
>  		if (IS_ERR(info->clk)) {
>  			ret = dev_err_probe(dev, PTR_ERR(info->clk), "failed to get clock\n");

While the first patch against this file looks okay now, this one inherits the
same problem (seems like not enought thinking about the code representation).

Instead of rewritting half of the lines you just introduced (which is also a
bad practice), add a one-liner that assigns a field to the local variable.

>  			goto err_pmruntime;


-- 
With Best Regards,
Andy Shevchenko


