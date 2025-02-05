Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180B3215077;
	Wed,  5 Feb 2025 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738743409; cv=none; b=Op+JYbRU6P0OcSxZy3b6nmGnkbr1xoo6fGSFEBg++ya+9biAd/VP4r6XjNV3ennbZD0k/tXPKCPXyMRh7l3MtGsYG1QROivT4aIaErB7zVpt5jC3cqYlAHqDRGbTehLWDLwSNW1+GvwN9HV8260aJVxr0h5hWDOPrlUcANaaisc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738743409; c=relaxed/simple;
	bh=+TY+V5VUjGkYXSPOZUitIxHMJC2IRgwqV8ym0qDyBWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lY371Aa0G0teGp+NoOZ/xMRoH66Nt124jd/hwbXNBadkiPz1miEn7vFD0EROA2WI9akZFcwhXpOH76NyGf8OWhoMhO1EWFeH3BhKefoEFtvi/d9SzcS4Mb24qcjMhGTYM+MDqk+o3ylD1BCCBnc3ONoe+d94to5NtPPjizQUihA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gt66zVm9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gt66zVm9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102ECC4CED1;
	Wed,  5 Feb 2025 08:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738743408;
	bh=+TY+V5VUjGkYXSPOZUitIxHMJC2IRgwqV8ym0qDyBWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gt66zVm9cG14dl/tRqKxa6+YjalwSM5TKK7Zfapl827x9adcpkTVi/Qk+IUfyWfHR
	 qNgXRLaiSB+sh4uVZ/bjFkC83aZPBR5IRTAAqo5NxNuwXDUolPo/SoVoMzHqrAnPE4
	 kB1PNG7TAEMAYl8MavtqaE1SwHbjFo+mG1+biX7M=
Date: Wed, 5 Feb 2025 09:16:45 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] tty: tty_buffer: Avoid hundreds of
 -Wflex-array-member-not-at-end warnings
Message-ID: <2025020513-arena-tackling-1741@gregkh>
References: <Z6L1XwE-WEzcGFwv@kspp>
 <2025020503-unnamable-canopener-ac71@gregkh>
 <3befc536-3bf8-4a79-9815-3386912069b2@embeddedor.com>
 <44d7feed-173e-4e46-994b-e3136161efc9@kernel.org>
 <8fa0b596-c812-4bc5-bdc1-beb75d7928d3@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fa0b596-c812-4bc5-bdc1-beb75d7928d3@embeddedor.com>

On Wed, Feb 05, 2025 at 06:33:13PM +1030, Gustavo A. R. Silva wrote:
> 
> 
> On 05/02/25 17:29, Jiri Slaby wrote:
> > On 05. 02. 25, 7:49, Gustavo A. R. Silva wrote:
> > > If the above changes are better for you then I'll send a new patch. :)
> > 
> > No, you are supposed to switch tty_buffer to tty_buffer_hdr too.
> 
> Do you mean something like the following:
> 
>  struct tty_buffer {
> -       union {
> -               struct tty_buffer *next;
> -               struct llist_node free;
> -       };
> -       unsigned int used;
> -       unsigned int size;
> -       unsigned int commit;
> -       unsigned int lookahead;         /* Lazy update on recv, can become less than "read" */
> -       unsigned int read;
> -       bool flags;
> +       struct tty_buffer_hdr hdr;
>         /* Data points here */
>         u8 data[] __aligned(sizeof(unsigned long));
>  };
> 
> +struct tty_buffer_hdr {
> +        union {
> +                struct tty_buffer *next;
> +                struct llist_node free;
> +        };
> +        unsigned int used;
> +        unsigned int size;
> +        unsigned int commit;
> +        unsigned int lookahead; /* Lazy update on recv, can become less than "read" */
> +        unsigned int read;
> +        bool flags;
> +};
> +

Yes!

> The problem with this is that then we have to modify a lot of
> lines from, let's say, instance->used, instance->size, etc...
> to instance->hdr.used, instance->hdr.size, and so on...

Great, let's do that and get it right please.

> This code churn is avoided if we use the struct_group() helper.

It's not "churn" if it is "fix the code to be correct" :)

thanks,

greg k-h
