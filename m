Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318CB27057D;
	Sun,  7 Jun 2026 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780814286; cv=none; b=WscnFJ+Yl+0MTPR2tMFLwXf0UHnghgiJi69Bo3EX5L0YfFa+gBCwkm7gBpEF6hAtQ5niC/B7Vq5ZIyK2c93LcniT/+09j+lpFgkmzPGQ8T5JEejA08dNrYDYlQ1LeW9rhiONvtJBP2fkI2vlYip+Nv2MQ1NDYXbw21gArgPACpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780814286; c=relaxed/simple;
	bh=wWugRAWLuOxxWHUawoaqbTLgVxUsIzmNprBbH6J9mLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ix9GFymDaOk7VVTvRMcMAmsFRz3joGUYAqjfz2eYjgcDq3SEDiap56r1Sby+rZ+cANeqnpnCEzAUR1FBqnEy9iTgryCktZoHrc9fpfIeYfgZdyDVA92lf2OtODgvnCv0dHodBpToxVqXrVk9vobXUygfmOhj1G4AQcK/Sd1nlwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NDa7GbAM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NDa7GbAM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C4E1F00893;
	Sun,  7 Jun 2026 06:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780814284;
	bh=+gEerk25mI2FpsRr3i9toP3hYmoIPN3W7X6+PFxNtb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NDa7GbAMt55MnpC69cP4T+NdIMgxP9TElLCErCfrIne8ywUz5txTNV9vV2aYoYD2B
	 HeMkW9lB4ZGb3vtIu0QIP9TNOW47TA3MJ/dpgKqO5fFKEdniP8b7ourFBV9YegIttx
	 W4FF/ugmFW49tP+Zs6wQohiLopwMeFGwiEFxEacI=
Date: Sun, 7 Jun 2026 08:37:07 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: n_gsm: bound the EA scan in gsm_control_rls()
Message-ID: <2026060715-quarterly-dexterity-982c@gregkh>
References: <20260606170323.1522340-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606170323.1522340-1-michael.bommarito@gmail.com>

On Sat, Jun 06, 2026 at 01:03:23PM -0400, Michael Bommarito wrote:
> gsm_control_rls() walks the control message looking for the end of the
> EA-encoded address, but it dereferences each byte before checking the
> remaining length:
> 
> 	int len = clen;
> 	const u8 *dp = data;
> 
> 	while (gsm_read_ea(&addr, *dp++) == 0) {
> 		len--;
> 		if (len == 0)
> 			return;
> 	}
> 
> When a malformed RLS control message decodes to a control length of
> zero, len starts at 0, the loop reads *dp before testing len, len
> underflows to -1, and the "if (len == 0)" test never fires. The scan
> then keeps reading forward through gsm->buf (kmalloc(MAX_MRU + 1)) until
> it happens upon a byte whose EA bit is set, reading past the end of the
> allocation.
> 
> A two byte DLCI 0 UIH control frame carrying CMD_RLS with an encoded
> length of zero reaches this from the receive path. KASAN reports a
> slab-out-of-bounds read in gsm_control_rls() (inlined into
> gsm_dlci_command()) when the bytes that follow the message in gsm->buf
> do not terminate the scan before the end of the buffer.
> 
> The sibling control handlers gsm_control_modem() and gsm_dlci_data()
> already reject a too short message before walking it; gsm_control_rls()
> was missed. Bound the EA scan by the remaining length so a zero length
> message returns without dereferencing past the data.
> 
> Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  drivers/tty/n_gsm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index c13e050de83b1..4f8f2ce038bc8 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -1806,12 +1806,12 @@ static void gsm_control_rls(struct gsm_mux *gsm, const u8 *data, int clen)
>  	int len = clen;
>  	const u8 *dp = data;
>  
> -	while (gsm_read_ea(&addr, *dp++) == 0) {
> +	while (len > 0) {
> +		if (gsm_read_ea(&addr, *dp++))
> +			break;
>  		len--;
> -		if (len == 0)
> -			return;
>  	}
> -	/* Must be at least one byte following ea */
> +	/* Must be at least one byte following the EA */
>  	len--;
>  	if (len <= 0)
>  		return;
> 
> base-commit: 5200f5f493f79f14bbdc349e402a40dfb32f23c8

While it's fun to throw LLMs at this codebase, how was this actually
tested?  there are loads of documented "problems" with this file, but in
the real world, with real devices, it works fine so without testing of
the code with those devices, we have to be careful with changing
anything here.

thanks,

greg k-h
