Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5216563C3
	for <linux-serial@vger.kernel.org>; Sat, 25 Nov 2023 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mjS3OuNE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C364C433C7;
	Sat, 25 Nov 2023 07:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700897705;
	bh=zPOBzZx43U5hf8TwnbJx30DgsWNOssZV3HiN/UWC8Bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mjS3OuNE7NuzkT1dJ0if+kJDQqREjezr/iBO3Tb+3fIOoaMIsk2IOlB9W6HNJFwZ5
	 ZcL+tHZZ9O/ysEyktWsUD7zLUCw2fowqqujui8Dqk+5X+fUwM3z5wjHLqxL13gAXCD
	 eZM9TvgYEpYkp+sJSlaUR7yr2nKTFJMmRpc5WwdI=
Date: Sat, 25 Nov 2023 07:22:49 +0000
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
Subject: Re: [PATCH v4 0/6] Cleanup AMBA PL011 driver
Message-ID: <2023112521-variably-snowcap-0861@gregkh>
References: <20231123-mbly-uart-v4-0-7f913a74ff89@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231123-mbly-uart-v4-0-7f913a74ff89@bootlin.com>

On Thu, Nov 23, 2023 at 02:42:38PM +0100, Théo Lebrun wrote:
> Hi,
> 
> While adding upstream support to a new platform (Mobileye EyeQ5[1]) that
> uses the AMBA PL011 driver, I took some time to look at the PL011
> driver and ended up with a few patches that cleanup parts of it. The
> line-diff is big mostly because of the checkpatch-fixing commits.
> 
> The driver hadn't received any love for quite some time. See commit
> messages for more information.
> 
> We can thank Ilpo Järvinen for the V3 & V4. V4 fixes an inversed if
> expression bug added in [PATCH V3 6/6].

This series causes build errors in linux-next so I'm dropping them from
my tree now.

greg k-h
