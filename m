Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402977;
	b=sXgihis3b3BBVpVPFwOAlVE/4uuobrMfdcgMu3IESp/un7aAfJXOOOEapuBRTh9TyFYX
	 KhVlSFJgKMAVYhjkMCPel1FfCUVezTFjyr+Tu5RMctsVZ0dshVQVHOphNBXcioPt1J4lE
	 54d0vkKOh8eoFflybJm2XbfL5dgaHtWCMHAbYgGph0ulHuGHckAO5XxDbDHlH+zi94fwG
	 Uaz/FhCJUY3VhK+iXUNat7+aRThxnGhQH8NXMX51AeuXz36xAPb/gad/nosv37u5TJctd
	 8C2/UCtIvDH0cF+oiEE0nrtNCkWKESu6Y+xiupXBnAqzpSLgS6Ot34bd0CMheOeB9KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402977;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Q43sHD1SAPXSuyOsK+0hq4nqu2Ar+7r1NHNgK12+6l4=;
	b=owhb4wt6I4J9XuXs4+DDDO6TmvFNiPR2kHixdN67hwUm6zQ0VbEUOppKa9o6qrMKddaW
	 1fcjDGFSOyFDvnFNOFoPjQYtpG7JU0bfBTObl6fsz6oOyLk/I3WpBTHZkfHq+w1FKskKf
	 u46yF8YSEIli9+f6oaW4qDcBh26ca4TBtVqe3VhdzYSMbNatvoSf7mgDy43SBtri5cZMW
	 jOSgeBZmFhhsj+ekIWb8tIyr08KCYZqGjAT1wYoHreYCG8pR3HRIobGk+p5bGQQ/+z5Vs
	 Xsq2fZvDcbQvhIPWVb9DR5VwifiBv+f9ZQITQBRK5wEIOUE5yvKEl0qiNyRgi4l8aKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=EFslS2jp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BE5606A883;
	Wed, 11 Nov 2026 13:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=EFslS2jp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F131F00A0A;
	Wed, 11 Nov 2026 13:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1794402976;
	bh=Q43sHD1SAPXSuyOsK+0hq4nqu2Ar+7r1NHNgK12+6l4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EFslS2jptd6DpYDd4H7hjLWOzBB66q8jj1JuNZnIH5jFWC/q7PZ1Qb48v6wuVMLEi
	 yz6tCMIXgRNPJ7KEfInqz1zNF/g+U7sYLtZbOw2HclYHd4xPtT3qVzpQVbZsG+eIrK
	 7ZsYIij1aiJGvvigJMaVTxA86tVSRx+ot+MsiU/Y=
Date: Wed, 11 Nov 2026 08:16:15 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: sc16is7xx: Fix clock leak on invalid clock
 frequency
Message-ID: <2026111106-drowsily-dexterity-bddd@gregkh>
References: <20261030085508.1882-1-laixiangwu@cmss.chinamobile.com>
 <20261111095213.1720-1-laixiangwu@cmss.chinamobile.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261111095213.1720-1-laixiangwu@cmss.chinamobile.com>

On Wed, Nov 11, 2026 at 05:52:12PM +0800, Xiangwu Lai wrote:
> Hi,
> 
> gentle ping.  Is there anything blocking this patch, or does it just
> need more time?

There is no context here :(
