Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FDE370D52;
	Mon, 11 May 2026 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778510694; cv=none; b=JsBSU5Gb3SUvMaj1uAEWqc1SViZQsp8844anPQrLEhG6Ww3Rz03TY3eDgFhM/cKfj6vKrdz0TrlN312cjBFpKJ2H1WrxIj4DMaQh6yFuWXktHJOTM+ro3m1zPOuV0Ulhyv3C8hFd9SDlXYRV7rE/lM5plTshg9EzySdBhUzfjTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778510694; c=relaxed/simple;
	bh=AbGlIrhOvheUnMO6XqfQXdLoS9aE+kymuz6zW3rvYvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwsKeL6/nwBhprxxXs1t2cF1DJZEbJThIwm9dae/EFhNUIWE2yjPbKTODcPZ4Yz3GLzVhMwmw2L8bi1LJDXbbIaqne6PurrZSBTvrFWhC+YNSdDW5s/OE7m+lylmZxJKsgHm4PU6fG/gvIYZQLViXyLoyHQrmeTWi3Lk2b0hFjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a84o/gqe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a84o/gqe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBCDC2BCC9;
	Mon, 11 May 2026 14:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778510694;
	bh=AbGlIrhOvheUnMO6XqfQXdLoS9aE+kymuz6zW3rvYvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a84o/gqeCF+lHpGzDlO1XKoPwkaZhZdQ+LvJrYMDhp4g/QR73yreSMYZYedElghrS
	 c97ay5RLdAYr+Wl9n7jTHB+v7Ct8AgJ1kFyDYkfAKkuoyteyuhZZHs6l/AcvZn2jA9
	 Mwtjxybd93jm/KslxEoI74BRXLx+0WHTA2P+myMg=
Date: Mon, 11 May 2026 16:44:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Minu Jin <s9430939@naver.com>
Cc: jirislaby@kernel.org, daniel.starke@siemens.com,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
Subject: Re: [PATCH] tty: n_gsm: fix memory leak in gsm_activate_mux
Message-ID: <2026051106-phrase-absinthe-00b2@gregkh>
References: <20260422183321.596414-1-s9430939@naver.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422183321.596414-1-s9430939@naver.com>

On Thu, Apr 23, 2026 at 03:33:21AM +0900, Minu Jin wrote:
> syzbot reported a memory leak in gsm_activate_mux().
> The root cause is a missing cleanup path when gsm_register_devices()
> fails. In this case, the previously allocated DLCI 0
> and its associated kfifo remain allocated, leading to a memory leak.
> 
> And gsm_dlci_alloc() does not check for already allocated DLCIs.
> Repeated calls to gsm_activate_mux() would overwrite the existing pointer
> in gsm->dlci[addr], causing the original memory to be lost.
> 
> Fix this by:
> 1. Adding gsm_dlci_free() in the error path of gsm_activate_mux().
> 2. Adding a check in gsm_dlci_alloc() to return the existing DLCI
>    if it is already allocated.
> 
> Reported-by: syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=b5d1f455d385b2c7da3c
> Tested-by: syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
> Fixes: 01aecd917114 ("tty: n_gsm: fix tty registration before control channel open")
> Signed-off-by: Minu Jin <s9430939@naver.com>
> ---
>  drivers/tty/n_gsm.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index c13e050de83b..de3d30eac86e 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2645,7 +2645,12 @@ static int gsm_dlci_config(struct gsm_dlci *dlci, struct gsm_dlci_config *dc, in
>  
>  static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr)
>  {
> -	struct gsm_dlci *dlci = kzalloc_obj(struct gsm_dlci, GFP_ATOMIC);
> +	struct gsm_dlci *dlci;
> +
> +	if (gsm->dlci[addr])
> +		return gsm->dlci[addr];

Why would you be allocating a device twice?  Shouldn't that logic be
fixed instead?

> +
> +	dlci = kzalloc_obj(struct gsm_dlci, GFP_ATOMIC);
>  	if (dlci == NULL)
>  		return NULL;
>  	spin_lock_init(&dlci->lock);
> @@ -3196,8 +3201,10 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
>  		gsm->receive = gsm1_receive;
>  
>  	ret = gsm_register_devices(gsm_tty_driver, gsm->num);
> -	if (ret)
> +	if (ret) {
> +		gsm_dlci_free(&dlci->port);
>  		return ret;
> +	}

How was this tested?

thanks,

greg k-h
