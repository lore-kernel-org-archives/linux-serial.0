Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AAB10A00
	for <linux-serial@vger.kernel.org>; Thu,  7 Dec 2023 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FyFgUT00"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544E9C433C9;
	Thu,  7 Dec 2023 06:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701931848;
	bh=rTrj+609LSXiUpACDhoj4mKW1YyIQfyh+kNZrOdvGXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FyFgUT00KRW2fhfDQ3yiYl2xNNwFdJETCHpiIa+Bs/eHqvAzXvqLYg3BWAXt6iiPS
	 mJY60DT6d8IpPIkhSAOiAeZ/a50cocZ4feFq6CZAzFBTLsxsvLAWXQ26deRnEJhjNB
	 CcKB62Njz310fFyTo8dTwFN88vjdOlxOjM5HGNh4=
Date: Thu, 7 Dec 2023 10:37:38 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>
Cc: Russell King <linux@armlinux.org.uk>, Jiri Slaby <jirislaby@kernel.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	=?iso-8859-1?Q?Gr=E9gory?= Clement <gregory.clement@bootlin.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
	Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v5 2/9] tty: serial: amba: Use linux/{bits,bitfield}.h
 macros
Message-ID: <2023120742-argue-slighting-6120@gregkh>
References: <20231130-mbly-uart-v5-0-6566703a04b5@bootlin.com>
 <20231130-mbly-uart-v5-2-6566703a04b5@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231130-mbly-uart-v5-2-6566703a04b5@bootlin.com>

On Thu, Nov 30, 2023 at 03:07:14PM +0100, Théo Lebrun wrote:
> The driver uses bit shifts and hexadecimal expressions to declare
> constants. Replace that with the BIT(), GENMASK() & FIELD_PREP_CONST()
> macros to clarify intent.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  include/linux/amba/serial.h | 248 +++++++++++++++++++++++---------------------
>  1 file changed, 127 insertions(+), 121 deletions(-)

As 0-day had a problem with this patch, I've applied only patch 1 of
this series.  Can you fix it up and rebase and resend the rest again
(while adding the collected reviewed-by that some patches in this series
had)?

thanks,

greg k-h
