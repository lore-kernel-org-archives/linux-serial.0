Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AAE4C3B5
	for <linux-serial@vger.kernel.org>; Thu, 23 Nov 2023 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kzffbtMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B49C433C9;
	Thu, 23 Nov 2023 19:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700768122;
	bh=GV33Ja8p/x8b4Sn/8W6w24BkBB0SuBPzuOK/VUIfmCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kzffbtMp78WBKeyMMfCa4mEGqUq9lzjkw2fDZTauERL5arVXwl0L+1GKOwJ0zDTVR
	 eYH+EvwoAsbd9P1wNr9SBPQ2DZShOpfEVeO+k14jEkyA7+y89PDy++akk+k3g7uLGQ
	 fiYmBDQDUiNYohvD7gFwNOwWhc7XJw+iDoFVlv80=
Date: Thu, 23 Nov 2023 19:35:19 +0000
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
Subject: Re: [PATCH v4 3/6] tty: serial: amba-pl011: cleanup driver
Message-ID: <2023112351-liable-handbag-d120@gregkh>
References: <20231123-mbly-uart-v4-0-7f913a74ff89@bootlin.com>
 <20231123-mbly-uart-v4-3-7f913a74ff89@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123-mbly-uart-v4-3-7f913a74ff89@bootlin.com>

On Thu, Nov 23, 2023 at 02:42:41PM +0100, Théo Lebrun wrote:
> Follow recommandations from:
> 
>     $ ./scripts/checkpatch.pl --strict --file \
>             drivers/tty/serial/amba-pl011.c
> 
> It does NOT fix alerts relative to TIOCMBIT which will be dealt with in
> another patch. Fixes following alerts:
> 
>     CHECK: Alignment should match open parenthesis
>     CHECK: Blank lines aren't necessary after an open brace '{'
>     CHECK: Comparison to NULL could be written [...]
>     CHECK: Lines should not end with a '('
>     CHECK: Please don't use multiple blank lines
>     CHECK: Please use a blank line after function/struct/union/enum declarations
>     CHECK: Prefer using the BIT macro
>     CHECK: Unbalanced braces around else statement
>     CHECK: Unnecessary parentheses around [...]
>     CHECK: braces {} should be used on all arms of this statement
>     CHECK: spaces preferred around that '/' (ctx:VxV)
>     CHECK: spaces preferred around that '|' (ctx:VxV)
>     ERROR: do not initialise statics to false
>     WARNING: Comparisons should place the constant on the right side of the test
>     WARNING: Possible unnecessary 'out of memory' message
>     WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
>     WARNING: Prefer [subsystem eg: netdev]_info([subsystem]dev, ... then dev_info(dev, ... then pr_info(...  to printk(KERN_INFO ...
>     WARNING: quoted string split across lines
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 147 +++++++++++++++++++---------------------
>  1 file changed, 71 insertions(+), 76 deletions(-)

This patch does not apply.

And really, you should have broken it up into smaller pieces and most of
them would have applied :(

Please rebase and break it up and resend.

thanks,

greg k-h
