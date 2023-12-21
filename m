Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFC836084;
	Thu, 21 Dec 2023 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MkvCD1lp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9A7C433C7;
	Thu, 21 Dec 2023 16:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703177578;
	bh=2+C30gWO9p+ECh2eEqgi3YMGW3elp4Wbdj+pcgG1FBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MkvCD1lpEQS74u2K836Sk31wiPKIQVzOWS5vpSl+Zkdn7Vx2NZVJcMHIAHbA3abY5
	 T2kMc6++tN+4GEYP/fztYD0BNGwu2Vm7e7OBoZ/drb1fRqBLKEgVuM1S9xQL2IbJmR
	 Bjpa12kBkWa/68K84LeCkrqg5iyjujzcpTDdwOJc=
Date: Thu, 21 Dec 2023 17:52:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sreenath Vijayan <sreenath.vijayan@sony.com>
Cc: linux-doc@vger.kernel.org, linux-serial@vger.kernel.org, corbet@lwn.net,
	jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	anandakumar.balasubramaniam@sony.com,
	Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
Subject: Re: [PATCH] tty/sysrq: Dump kernel ring buffer messages via sysrq
Message-ID: <2023122144-enlarged-maggot-493a@gregkh>
References: <20231221133953.1507021-1-sreenath.vijayan@sony.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221133953.1507021-1-sreenath.vijayan@sony.com>

On Thu, Dec 21, 2023 at 07:09:53PM +0530, Sreenath Vijayan wrote:
> When terminal is unresponsive, one cannot use dmesg to view kernel
> ring buffer messages. Also, syslog services may be disabled,
> to check them after a reboot, especially on embedded systems.
> In this scenario, dump the kernel ring buffer messages via sysrq
> by pressing sysrq+D.
> 
> Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
> Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
> ---
>  Documentation/admin-guide/sysrq.rst |  2 ++
>  drivers/tty/sysrq.c                 | 43 ++++++++++++++++++++++++++++-
>  2 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
> index 2f2e5bd440f9..464c4e138b9d 100644
> --- a/Documentation/admin-guide/sysrq.rst
> +++ b/Documentation/admin-guide/sysrq.rst
> @@ -161,6 +161,8 @@ Command	    Function
>              will be printed to your console. (``0``, for example would make
>              it so that only emergency messages like PANICs or OOPSes would
>              make it to your console.)
> +
> +``D``	    Dump the kernel ring buffer
>  =========== ===================================================================

Nit, this doesn't line up anymore :(

