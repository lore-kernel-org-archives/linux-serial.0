Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373DC1F3FED;
	Wed, 14 May 2025 05:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747201419; cv=none; b=a8KpznJJ5S1Fnm519/xWciCfV88eUORyZnDTTOoCLRXNZfGvsWGkqyaw4Gcc7sd/6ORVmCgSyfsUCV3QD0w5IPEMuZ3b/D0T5ZTIWZFhM2USmzZpFJH+t94fFEBv8OB0Edy6nV1u6vN57wwHiiLT+6E63h3Av6SU+pzHGzDbVl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747201419; c=relaxed/simple;
	bh=ToBGjHXrPQqmhHhPi2h5AhEO0dYh0gr5acZEkolmOZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i/Sq4aBhmWUy57rQnWHLcUbdPPb/KYvoitzkttnA3VBEH9YgxGBX6dOOZTYgIEzLxZPHXmZzFpXuO086m8BtL1E/++USVgWxKLe6+ZTKks69cvXADxBe28sQycZy4fGmb5qwqr1LFoP+QNk4OaHTAeUkuSURl3HkpvuVt7B0AbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hi489zuy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hi489zuy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4FB5C4CEEB;
	Wed, 14 May 2025 05:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747201418;
	bh=ToBGjHXrPQqmhHhPi2h5AhEO0dYh0gr5acZEkolmOZk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hi489zuy7UUyWUDRDFNgiBeo9dJtPEb/Q16yZoOqRWv/Rmv87uNOSRoS+5PxRZNUF
	 IXLqALij7GK9UoeXGx/A9Oswwb27cjHkRElsQ41AmN92Eu+NV0qPqFoTEEZEt2KdSU
	 yyrPIMa7rCz6nX24UB0XXkTOtH5dBRd1Wz9q2CDJw3858qRmiGGiR6CtXGVhh16g7R
	 TzxDNSHvzmKthF/rpsMLEhZKj08KOVeE+XqIguLq4Qj0DpuBFWWoOvVSA0aJgWGKkE
	 B2O/3wk+UNY3sCM4NKzkAFHyN4Jjy4h/enG9UdXn8IUuNAy0D6i5curbkgP2cI1URh
	 vp94dAUdg4mIg==
Message-ID: <8d38bf57-ad99-4889-8e5a-9ae7e5c5b39e@kernel.org>
Date: Wed, 14 May 2025 07:43:35 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vt: bracketed paste support
To: Nicolas Pitre <nico@fluxnic.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nicolas Pitre <npitre@baylibre.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250514015554.19978-1-nico@fluxnic.net>
 <20250514015554.19978-2-nico@fluxnic.net>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20250514015554.19978-2-nico@fluxnic.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14. 05. 25, 3:52, Nicolas Pitre wrote:
> From: Nicolas Pitre <npitre@baylibre.com>
> 
> This is comprised of 3 aspects:
> 
> - Take note of when applications advertise bracketed paste support via
>    "\e[?2004h" and "\e[?2004l".
> 
> - Insert bracketed paste markers ("\e[200~" and "\e[201~") around pasted
>    content in paste_selection() when bracketed paste is active.
> 
> - Add TIOCL_GETBRACKETEDPASTE to return bracketed paste status so user
>    space daemons implementing cut-and-paste functionality (e.g. gpm,
>    BRLTTY) may know when to insert bracketed paste markers.
> 
> Link: https://en.wikipedia.org/wiki/Bracketed-paste

LGTM.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

In case (and only then) you resend for some reason, I have some nits below.

(And a question at the bottom.)

> Signed-off-by: Nicolas Pitre <npitre@baylibre.com>
> ---
>   drivers/tty/vt/selection.c     | 35 ++++++++++++++++++++++++++++++----
>   drivers/tty/vt/vt.c            | 15 +++++++++++++++
>   include/linux/console_struct.h |  1 +
>   include/uapi/linux/tiocl.h     |  1 +
>   4 files changed, 48 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
> index 791e2f1f7c0b..ac86b82411a8 100644
> --- a/drivers/tty/vt/selection.c
> +++ b/drivers/tty/vt/selection.c
...
> @@ -427,10 +433,31 @@ int paste_selection(struct tty_struct *tty)
>   			continue;
>   		}
>   		__set_current_state(TASK_RUNNING);
> +
> +		if (bps) {
> +			count = tty_ldisc_receive_buf(ld, bps, NULL, strlen(bps));
> +			bps += count;
> +			if (*bps == '\0')
> +				bps = NULL;
> +			else
> +				continue;

This could have been simpler:

bps += tty_ldisc_receive_buf(ld, bps, NULL, strlen(bps));
if (*bps != '\0')
   continue;

bps = NULL;

> +		}
> +
>   		count = vc_sel.buf_len - pasted;
> -		count = tty_ldisc_receive_buf(ld, vc_sel.buffer + pasted, NULL,
> -					      count);
> -		pasted += count;
> +		if (count) {
> +			count = tty_ldisc_receive_buf(ld, vc_sel.buffer + pasted,
> +						      NULL, count);
> +			pasted += count;

Same here for pasted.

> +			if (vc_sel.buf_len > pasted)
> +				continue;
> +		}
> +
> +		if (bpe) {
> +			count = tty_ldisc_receive_buf(ld, bpe, NULL, strlen(bpe));
> +			bpe += count;

And bpe.

> +			if (*bpe == '\0')
> +				bpe = NULL;
> +		}
>   	}
>   	mutex_unlock(&vc_sel.lock);
>   	remove_wait_queue(&vc->paste_wait, &wait);
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index efb761454166..ed39d9cb4432 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1870,6 +1870,14 @@ int mouse_reporting(void)
>   	return vc_cons[fg_console].d->vc_report_mouse;
>   }
>   
> +/* invoked via ioctl(TIOCLINUX) */
> +static int get_bracketed_paste(struct tty_struct *tty)

vc_bracketed_paste is unsigned. (I understand tioclinux() returns an int.)

> +{
> +	struct vc_data *vc = tty->driver_data;
> +
> +	return vc->vc_bracketed_paste;
> +}
> +
>   enum {
>   	CSI_DEC_hl_CURSOR_KEYS	= 1,	/* CKM: cursor keys send ^[Ox/^[[x */
>   	CSI_DEC_hl_132_COLUMNS	= 3,	/* COLM: 80/132 mode switch */
...
> --- a/include/uapi/linux/tiocl.h
> +++ b/include/uapi/linux/tiocl.h
> @@ -36,5 +36,6 @@ struct tiocl_selection {
>   #define TIOCL_BLANKSCREEN	14	/* keep screen blank even if a key is pressed */
>   #define TIOCL_BLANKEDSCREEN	15	/* return which vt was blanked */
>   #define TIOCL_GETKMSGREDIRECT	17	/* get the vt the kernel messages are restricted to */
> +#define TIOCL_GETBRACKETEDPASTE	18	/* get whether paste may be bracketed */

Do you plan on updating man-pages too?

https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man/man2const/TIOCLINUX.2const

thanks,
-- 
js
suse labs
