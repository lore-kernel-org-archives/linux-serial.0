Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE60440637;
	Wed, 23 Sep 2026 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167862; cv=none; b=RSHb6L99YqK1QnnH3lNhZFCg72SH3Uukjj44YtGISvq+ELSlk+9sLVvrgRFPZElzThzBmdAD8QOeebWU+MlAAF/F0SgNXIFJglAo3tAHn88HRoLZleglTSHpDL4fYD0NkEIx8MF1DeSK7v9I805d7Cvd/Eefpe2PJyAtNKJzC6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167862; c=relaxed/simple;
	bh=DO5hTkddNwS2gIW+V2FuLt+gIWOAWsNIZ2xrf3GAicU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mz/LTpWzcc7in0kY3DDDeFtK3XmyKMzu2w52EcZq/NIYPQ8otKo6lDqPGmXIRtS6QuYeg+FE2y4msX9uPRVpTjTfIdwtU4MAV7G5x+l/EynHlkj3/cVIy2L3JajFLI2Qx6jksHkRUSInw0BFESevTs2FpYajJakCI/jei7W64fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W+ixNW/q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W+ixNW/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DCF1F000FF;
	Wed, 23 Sep 2026 12:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790167855;
	bh=Ym7iJHsLfovAqm5JB7vlYkIDDJDIFXsY9myHFucj2q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W+ixNW/q+Y798Pj026dxgUEnn+/H3LV7SqpPqXXdnMANEgc6/IK7mmszvcG9uEVGT
	 lt+l0QigttnSvV/bdYtqdxt5MM8U3UBedYQwXlR1Ewlh8JvbtrqUhqF9qUrEXK2F4b
	 QsXXqKdMFBjIvCG8aa6hCBswwLilVhWHScGXG4tc=
Date: Wed, 23 Sep 2026 14:50:52 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: jaidevshastri@vt.edu
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/3] vt: order the fg_console switch against
 vt_console_print()
Message-ID: <2026092324-unlocked-step-9443@gregkh>
References: <20260921-mb-vt-v1-0-71b7990c26c1@vt.edu>
 <20260921-mb-vt-v1-1-71b7990c26c1@vt.edu>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-mb-vt-v1-1-71b7990c26c1@vt.edu>

On Mon, Sep 21, 2026 at 09:27:14PM -0400, Jaidev Shastri via B4 Relay wrote:
> From: Jaidev Shastri <jaidevshastri@vt.edu>
> 
> redraw_screen() switches fg_console with a plain store once the new
> console's state is set up. vt_console_print(), the printk console
> callback, indexes vc_cons[] with fg_console before it takes
> printing_lock.
> 
> Store the new index with smp_store_release() and read it with
> smp_load_acquire(), so that the printk path cannot reach the slot before
> the console it denotes is complete.
> 
> Found with MBCheck, a static herd7-based memory consistency checker.
> 
> Signed-off-by: Jaidev Shastri <jaidevshastri@vt.edu>
> ---
>  drivers/tty/vt/vt.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 57edf3749..3abbd6cf9 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -973,7 +973,8 @@ void redraw_screen(struct vc_data *vc, int is_switch)
>  		if (!con_is_visible(vc))
>  			redraw = 1;
>  		*vc->vc_display_fg = vc;
> -		fg_console = vc->vc_num;
> +		/* Pairs with the smp_load_acquire() in vt_console_print(). */
> +		smp_store_release(&fg_console, vc->vc_num);

Using these functions are almost always wrong.  Fix things properly, do
not pepper these types of calls all over the kernel, that way lies
madness.

greg k-h
