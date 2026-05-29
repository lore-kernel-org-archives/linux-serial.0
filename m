Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D9F3AD507;
	Fri, 29 May 2026 08:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780044208; cv=none; b=r4fKXO/oDMVeAS08rpFt/3Nb337qkGSf/+cyLEMEmtupLb9V6l1NBHyzGzZECJaaBt33dKkkFdIO9A4fQwn/4L2Zxv+l4Q6i694A5bPS1LM/IBF90LxJfpGl1SkqAmeC+u4Y6qvVZ98gi4z8w3cowCaXf4ssEoLEreFH7v6JgMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780044208; c=relaxed/simple;
	bh=gCAzcqXt37ZK8wVEUBgPt67BrEsU31nqauJDB0YN9GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xrf3iLKItGbCewxMZ107EjY9ZgE154IZkE0tn2Q3RzccURrKe4vA9Evn77IUnWCBmfuTAiJZjJauj3+MApTUrdHenD1aykVS+0200N7f0+Ea3LZQNEq/Zb8RUuDY6tX6nAzOGxEjeIOsQASacBB9Y/UECTk33QM0hHMB5NE3ZeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IF1RvRg2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IF1RvRg2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8CC1F00893;
	Fri, 29 May 2026 08:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780044207;
	bh=uXnHakRi/0adsncYDlGuWfuJsPpVHFQFEDTYwyaoHko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IF1RvRg2pqYFk8NBtwRTwuopel/5dnd3b9bmYsdrorGgzJYCUjEmH5vXdoHYgvAQv
	 Gd83x3+CXAElPdCTr7cEUBIQ+mr2PD08s5dd1jIL+st1XcT2J5R76cL/KZhEgx3DHv
	 0VsueIUciBpy4Q6sIH5KeXGYTxUcxDZyQwOMIIRFXareZ8pq0FRTH0FnP3n4+0jfds
	 amahNhyZC6CXJ3+AcmXpc5UBWNC7/TlHrSGCvxsi5xA5oIQ1pSfBLEN+Cw4yngDFGB
	 VuCEdaRspi2q++1DGriDtiy0ThJtopoJhCWzH/zJfYfwNcJrzyv+1q6ad4zF/pS5zb
	 YQhR3ccnxxu0w==
Date: Fri, 29 May 2026 11:43:21 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 3/4] tty: serial: men_z135_uart: replace
 __get_free_page() with kmalloc()
Message-ID: <ahlRqd3e94ojSfWE@kernel.org>
References: <20260528-b4-tty-v1-0-9da9f7aec5f2@kernel.org>
 <20260528-b4-tty-v1-3-9da9f7aec5f2@kernel.org>
 <18bb4a45-c26b-4a89-b598-a844d3aadafa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18bb4a45-c26b-4a89-b598-a844d3aadafa@kernel.org>

On Fri, May 29, 2026 at 09:47:33AM +0200, Jiri Slaby wrote:
> On 28. 05. 26, 12:24, Mike Rapoport (Microsoft) wrote:
> > men_z135_probe() allocates a receive staging buffer filled by the
> > CPU via memcpy_fromio() from the device MMIO region.
> > 
> > This buffer can be allocated with kmalloc() as there's nothing special
> > about it to go directly to the page allocator.
> > 
> > kmalloc() provides a better API that does not require ugly casts and
> > kfree() does not need to know the size of the freed object.
> > 
> > Replace use of __get_free_page() with kmalloc() and free_page() with
> > kfree().
> > 
> > Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >   drivers/tty/serial/men_z135_uart.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
> > index 6fad57fee912..9c32b01edc9e 100644
> > --- a/drivers/tty/serial/men_z135_uart.c
> > +++ b/drivers/tty/serial/men_z135_uart.c
> > @@ -17,6 +17,7 @@
> >   #include <linux/bitops.h>
> >   #include <linux/mcb.h>
> > +#include <linux/slab.h>
> >   #define MEN_Z135_MAX_PORTS		12
> 
> This one is misplaced.

Do you mean an empty line is missing? Or there's particular order of
includes here?
 
> thanks,
> -- 
> js
> suse labs

-- 
Sincerely yours,
Mike.
