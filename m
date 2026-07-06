Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CC238238A
	for <linux-serial@vger.kernel.org>; Mon,  6 Jul 2026 14:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348524; cv=none; b=a9mOVEZOJL5Bwj1kj7qNNRFXbiqbom9/Mf1ABM4FvC3+Kh6pwFTgUllciois5VnQ06wLICEK9cmzmI6nGPIHZpwm/6/BcngDH1f3gWBERG97kiendpn9BfJicpZ8fqRLpASHkVAvhCIA1UiuGCCa+PIeMjBFd6a2RIcteIOnnmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348524; c=relaxed/simple;
	bh=DBqABHxHYldpXnvTqOMSux3NUGXLgXFkkq5x83HmH08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X42ychIZXD8ORtqpRC9HPwT6MTXkmid8MsbfCMzWJ1lfAVBbgJagCL/o8JKl96fwE3yseQkVu5MnU/duLyOALSr0slVwV0cac1Ge62aDvWrNC4PWhloRXR4FRmegxLlJoYlWIzPBkvxGKL6QEL3NpEMk/kHEBRyiEaaj9F7Swuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J1zH2Ayc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J1zH2Ayc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED1C1F00A3A;
	Mon,  6 Jul 2026 14:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783348523;
	bh=SCvoonKkeli+xF8/8JviFrO7dGqC6426+llHFI0KR1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J1zH2Aycuy2vbXKvOf4gOtIU7H93KFExy1X9P+irKkZusiahqmuNaMsohjZ/WAhLq
	 Vet7pX1lrIaKCzI/+G9J6TB0DODy7+vBhZAOmKHAJiBTEY/wOSSjM0eHcts/u+6Vqo
	 dfMf2Tw0ZkXbOT+/3KO/TCXgwHx6Wh1gltdZKBcQ=
Date: Mon, 6 Jul 2026 16:35:36 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	lvc-project@linuxtesting.org,
	syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] tty: n_gsm: avoid reactivation without previous
 cleanup
Message-ID: <2026070611-pamperer-traps-84d4@gregkh>
References: <20260706142016.3385636-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706142016.3385636-1-dmantipov@yandex.ru>

On Mon, Jul 06, 2026 at 05:20:15PM +0300, Dmitry Antipov wrote:
> Initially reported by syzbot at as memory leak, actual issue is an attempt
> to configure DLCI 0 (via 'ioctl(..., GSMIOC_SETCONF_EXT, ...)') more than
> once without previous cleanup (likely requested with GSM_FL_RESTART). To
> prevent such a scenario, including racy attempts to do it from multiple
> threads, adjust 'gsm_activate_mux()' to grab GSM mux's mutex and throw
> -EBUSY if DLCI 0 was configured already.
> 
> Reported-by: syzbot+b5d1f455d385b2c7da3c@syzkaller.appspotmail.com

We've had loads of syzbot "issues" reported in this code, and unless it
actually shows up in a real device or operation, I'd just leave it alone
please as there are lots of subtle issues involved in it.

Have you tested this in real hardware?

> Closes: https://syzkaller.appspot.com/bug?extid=b5d1f455d385b2c7da3c
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/tty/n_gsm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index c13e050de83b..ce447477ccf3 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -3186,6 +3186,11 @@ static int gsm_activate_mux(struct gsm_mux *gsm)
>  	struct gsm_dlci *dlci;
>  	int ret;
>  
> +	guard(mutex)(&gsm->mutex);
> +
> +	if (unlikely(gsm->dlci[0]))
> +		return -EBUSY;

Why unlikely()?  Can you measure it with/without that?  If not, it
should never be used.

thanks,

greg k-h
