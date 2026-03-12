Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D10136CE10;
	Thu, 12 Mar 2026 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773325334; cv=none; b=s7LvY9JydYNy7Q5qAbOpZC7yoFe6YoIVsu8xs6NGKNpN3TKM1nUlBFZPj/IbDrFlEO1xUq6x1V+leXSatOKO+GBNWJhdpAof83NkFSjwkby2YCg8Mewrizo+nBCy49b5s7g+Cen+qDN3QVySbuR90sGVNkafsULGPc9fCp0h0GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773325334; c=relaxed/simple;
	bh=+/JITOJV6/YAAA0w4VtIiRn8INzojOTa5aUdv/RhcPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TodpJjx39VvKkTkQlXX7zlqp2HsH73wPZO6sLCfooTV+NdQImuwk5FexBU468VKJUNDjabLac1JCFpmp+Af0ercf3k0yqnWLYHR6R+QlNddmx1wQxgiSQqf1DzkacHu73M5PmYJvfYlroltxR3CkJ0lF5i6XDwq/0taqSqjU0g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N6nzYGrQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N6nzYGrQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06B8C2BC86;
	Thu, 12 Mar 2026 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773325333;
	bh=+/JITOJV6/YAAA0w4VtIiRn8INzojOTa5aUdv/RhcPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N6nzYGrQXmDq1uvnu5q6ZtV501RvCk9QPbmpHXbDyWlvXZrvXCD/zQzASh8pwIlFn
	 7XQCeeoWf9Av2XL+erHbklJ5uKfWI4AP4lLKx1l7At9s3+S1bROPohIHuY01a5b/Mb
	 DNXXosZjRuQTrLjaaVIFdoMcZnfHXOBw9nhltbvw=
Date: Thu, 12 Mar 2026 15:22:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Hodges <git@danielhodges.dev>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	syzbot+c3693b491545af43db87@syzkaller.appspotmail.com,
	syzbot+03f79366754268a0f20c@syzkaller.appspotmail.com
Subject: Re: [PATCH] vt: keyboard: add NULL check for vc_cons[fg_console].d
 in kbd_keycode and kbd_rawcode
Message-ID: <2026031236-unfold-repurpose-52e6@gregkh>
References: <20260208003112.6040-1-git@danielhodges.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208003112.6040-1-git@danielhodges.dev>

On Sat, Feb 07, 2026 at 07:31:12PM -0500, Daniel Hodges wrote:
> kbd_keycode() and kbd_rawcode() dereference vc_cons[fg_console].d
> without checking if it is NULL. The foreground console should normally
> always be allocated, but there could be a time during console setup or
> teardown where this pointer could be NULL, leading to a general
> protection fault.
> 
> Syzkaller triggers this by injecting USB HID input events that reach
> kbd_event() while the console state may not be fully consistent. The crash
> manifests as a null-ptr-deref in __queue_work when put_queue() or
> puts_queue() calls tty_flip_buffer_push() on the uninitialized vc port.
> 
> Add a NULL check for vc at the start of both kbd_rawcode() and
> kbd_keycode() to bail out early if the foreground console is not allocated.
> 
> Reported-by: syzbot+c3693b491545af43db87@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c3693b491545af43db87
> Reported-by: syzbot+03f79366754268a0f20c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=03f79366754268a0f20c
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> ---
>  drivers/tty/vt/keyboard.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index a2116e135a82..975830013d24 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -1389,6 +1389,9 @@ static void kbd_rawcode(unsigned char data)
>  {
>  	struct vc_data *vc = vc_cons[fg_console].d;
>  
> +	if (!vc)
> +		return;
> +

What prevents vc from being NULL right after checking this?



>  	kbd = &kbd_table[vc->vc_num];
>  	if (kbd->kbdmode == VC_RAW)
>  		put_queue(vc, data);
> @@ -1405,6 +1408,9 @@ static void kbd_keycode(unsigned int keycode, int down, bool hw_raw)
>  	struct keyboard_notifier_param param = { .vc = vc, .value = keycode, .down = down };
>  	int rc;
>  
> +	if (!vc)
> +		return;

Same here, where is the locking?

thanks,

greg k-h
