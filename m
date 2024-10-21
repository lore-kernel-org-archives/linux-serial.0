Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E871D0DF6;
	Mon, 21 Oct 2024 06:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729493980; cv=none; b=GSWC+yHjbni55Wbbx28MDZ73D1E+rwxz/LTWH9pRHq+kLC9ZmV6c1JMhuqollLoC1wXCfeMfE+f7wR07cMB+7tBlLqc2xRcirjVnIQcsNnkJNTdMzrp2aE2XYqUcYaqbZHIHhJThpWAKkJ3moBEHlmTYz0NBEiHlVUxegYJjcxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729493980; c=relaxed/simple;
	bh=sqJe+SYePyCORlcWttoZCNBV3dX9EBKVbW24Bl/SPdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDXnzCCKZosHjbSthhYzOMvsiNIb4Vcxk5RRSJCV5dxnFcaMtZOO3axsvgWcbIpm+9zukCqkYQXY+38mAs3Y4iyHzuhx40UH0JYasxJOjKC0O73GHBpG9NY0jM8xs+ituDVD9zm5edN70p2z634Sv67By5LU9VaVL32psfgvaG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AYIsNk0f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AYIsNk0f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAB1C4CECD;
	Mon, 21 Oct 2024 06:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729493980;
	bh=sqJe+SYePyCORlcWttoZCNBV3dX9EBKVbW24Bl/SPdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AYIsNk0fGuwE2EAH47lCz5VnfTV2jCfOQPg1WzZh5Ehf+Y6kY8I9mxZRPjNhw0elt
	 D2rUxNKfgl5rB9QTHOdDft/zxXd05Es89gOI9FmmAIUH8lB9r3IzqksSL7ZvF/664/
	 ylKIJDVWE6eRIxUuyJsMIOphrutj/u0LW9WAjVqk=
Date: Mon, 21 Oct 2024 08:59:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mihai Sain <mihai.sain@microchip.com>
Cc: richard.genoud@bootlin.com, jirislaby@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] tty: atmel_serial: Use
 devm_platform_ioremap_resource()
Message-ID: <2024102151-showy-partake-a2aa@gregkh>
References: <20241021064321.3440-1-mihai.sain@microchip.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021064321.3440-1-mihai.sain@microchip.com>

On Mon, Oct 21, 2024 at 09:43:21AM +0300, Mihai Sain wrote:
> Simplify the request port function by using a single call
> to devm_platform_ioremap_resource().
> 
> This will also enhance the printing from /proc/iomem:
> 
> cat /proc/iomem | grep flexcom ; cat /proc/iomem | grep serial
> 
> f0004000-f00041ff : f0004000.flexcom flexcom@f0004000
> f8020000-f80201ff : f8020000.flexcom flexcom@f8020000
> f0004200-f00043ff : f0004200.serial serial@200
> f8020200-f80203ff : f8020200.serial serial@200
> fffff200-fffff3ff : fffff200.serial serial@fffff200
> 
> Signed-off-by: Mihai Sain <mihai.sain@microchip.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)

Why is this a rfc?  What needs to be done before you want it merged?

thanks,

greg k-h
