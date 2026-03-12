Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE9F2D97B7;
	Thu, 12 Mar 2026 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773323524; cv=none; b=shF2twzt9PkT5rhg7ikrvq4+ImmvBwymUKZnVT0wpHVWDMza1hhP9fbQGfonCtBEjwvWgoqp4SKUJl0fuBe+PGY9pJiyWChZ3G5APrpcbNwPvQDegsydSDTzgsyk23j0s6y2N672Q+KSlKEPAJXkJ0cU/ZbmoE324E4A0be7LXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773323524; c=relaxed/simple;
	bh=0YY6lgbt07GJFgpUbldepo71+vLViSArEe+0WSWTgfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=np3HAaa2bsNsNP4FIIPvwDPgkZDGdQJGX0n6xO3NubrvUO8+1mDlkhZgxdHVDjnSajli0bxIxxg1nNHhCbufHRLYnfkGoUv7Hy7yVMhRmNwSD7CBWIoXF1Fu71OruM282S8lrLinVLyyiIbWjubyk57W+9xogOTuKqTumJP9dhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QkT4bA4Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QkT4bA4Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4596AC4CEF7;
	Thu, 12 Mar 2026 13:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773323523;
	bh=0YY6lgbt07GJFgpUbldepo71+vLViSArEe+0WSWTgfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QkT4bA4ZWIZsMqD38BabM2Ly22gBbUylykzr8lyAr687+0vChwFG8ZIC4sF8chhpT
	 0RCt8Bt488YO4el9yES0kyfvYYTdI19DeQgTUli8N45681b9caUoaoblQgC7KwSZvQ
	 R67CNmHwomlRIqURD5CPm9XI9POkLnHlnhsoF6No=
Date: Thu, 12 Mar 2026 14:51:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Soham Kute <officialsohamkute@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+03f79366754268a0f20c@syzkaller.appspotmail.com
Subject: Re: [PATCH] tty: vt: keyboard: fix general protection fault in k_meta
Message-ID: <2026031245-atop-lankiness-4e0c@gregkh>
References: <20260207192708.44188-1-officialsohamkute@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207192708.44188-1-officialsohamkute@gmail.com>

On Sun, Feb 08, 2026 at 12:57:08AM +0530, Soham Kute wrote:
> syzbot reported a general protection fault in k_meta() caused by
> dereferencing an invalid keyboard pointer when checking META mode.
> 
> Add a defensive check to ensure the keyboard pointer is valid before
> calling vc_kbd_mode().

How can kbd be NULL here?  What causes that to happen?

> 
> Reported-by: syzbot+03f79366754268a0f20c@syzkaller.appspotmail.com
> 
> Signed-off-by: Soham Kute <officialsohamkute@gmail.com>
> ---
>  drivers/tty/vt/keyboard.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index d65fc60dd..b535d7a42 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -880,7 +880,7 @@ static void k_meta(struct vc_data *vc, unsigned char value, char up_flag)
>  	if (up_flag)
>  		return;
>  
> -	if (vc_kbd_mode(kbd, VC_META)) {
> +	if (kbd && vc_kbd_mode(kbd, VC_META)) {

What prevents kbd from being NULL _right_ after you check it?  There's
no locking here at all...

Perhaps fix the root problem here?

thanks,

greg k-h
