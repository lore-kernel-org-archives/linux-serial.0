Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A84B19BAE;
	Fri,  8 Dec 2023 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2kYfjQhC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0DEC433C7;
	Fri,  8 Dec 2023 10:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702031528;
	bh=yZ0ArCVZudWIJRxf5rXx4mNCVgyBX4eaw15oShBLaj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2kYfjQhCxHl1hqoP+X9utK90pgdDIZNrPx/DP75cUl1gjWVOtlC3o5pt5gf6mzH0z
	 F9iRt3vUy7/em+JQda3xeG7X7OHH0Dw6RU/lcLAnShDjxSUchH4obGtDqNr9ucLQKa
	 sYmzyN+eWIYYdCf9KWrAhVuJywNPT2lKG/dwKJHM=
Date: Fri, 8 Dec 2023 11:32:05 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	Rob Herring <robh@kernel.org>, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
	Ian Ray <ian.ray@ge.com>, NXP Linux Team <linux-imx@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	kernel@collabora.com, Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCHv5 0/2] Fix imx53-ppd UART configuration
Message-ID: <2023120821-sandstone-lavender-7487@gregkh>
References: <20210430175038.103226-1-sebastian.reichel@collabora.com>
 <20231208090754.fn3bddlum3t7kakn@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208090754.fn3bddlum3t7kakn@pengutronix.de>

On Fri, Dec 08, 2023 at 10:07:54AM +0100, Uwe Kleine-König wrote:
> [Cc += dt maintainers]
> 
> On Fri, Apr 30, 2021 at 07:50:36PM +0200, Sebastian Reichel wrote:

You are responding to a message from 2021???

I can't remember what I wrote in an email last week, let alone years
ago, are you sure any of this is relevant still?

thanks,

greg k-h
