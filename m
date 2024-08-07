Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701B619006D;
	Wed,  7 Aug 2024 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723029328; cv=none; b=C6G1+0P7VC4mWSf6Jie4yROrpyz7vrhnV+D0/yyOu/YHBHecgQ3zE2JD3UO34440vhRwRSX+KiQXduuDc5sYb9JI0GVwGsfdpykpxDwMXE5Jz2BrE+W7M6bEkbPKHhhl0pn1YQqXii+bc3V73pj7xKUd1MRyqQOuWPNuQdO2T6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723029328; c=relaxed/simple;
	bh=jSsp/HKO95SPmP8lgJ7EwugbwAijmbRwyArXgZS5BKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pjs3RzseBC/u40Gervxsv/mu6Aw+VI9R8UBmfJRktweCHOqAzHft5EvFSFi3GLtf16KZ1HeFcWlfFCbcSIaAu18fkdbU2rjDe8jDHIJgfWDwbui2zrHFVSzYfJONzIjnl3VbaqBG59d3VYA2ix3b2vMjfmAM3pQ6dPidJDGUY2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BpTCAPF5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BpTCAPF5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC001C32782;
	Wed,  7 Aug 2024 11:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723029328;
	bh=jSsp/HKO95SPmP8lgJ7EwugbwAijmbRwyArXgZS5BKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BpTCAPF5f50WoUmMoMOCeAEXTkjGLdzutv28UoTMIVPUSaNsu/O57O1e/Ef+MS4L4
	 Y53GL+0kEvs12nq9U6xMVS/DklWK5x7XiPUfhzmq8RYF+q8hFtBF/6ut6UKeLPSYFa
	 RJciQIqRRpHK5fETH3SveiRiWHr7/gVk2FzN2dRY=
Date: Wed, 7 Aug 2024 13:15:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/13] serial: use guards for simple mutex locks
Message-ID: <2024080704-attendant-pajamas-d68d@gregkh>
References: <20240805102046.307511-1-jirislaby@kernel.org>
 <20240805102046.307511-6-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805102046.307511-6-jirislaby@kernel.org>

On Mon, Aug 05, 2024 at 12:20:38PM +0200, Jiri Slaby (SUSE) wrote:
> Guards can help to make the code more readable. So use it wherever they
> do so.
> 
> On many places labels and 'ret' locals are eliminated completely.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>  drivers/tty/serial/serial_core.c | 111 +++++++++++++------------------
>  1 file changed, 46 insertions(+), 65 deletions(-)

Ah, this was the breaking patch.  I applied the first 4 now, will let
you respin this one and resend the remaining.

thanks,

greg k-h
