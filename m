Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D24402B8A
	for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 14:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785508826; cv=none; b=e3xjGFxyZDvXAFijAfSQ3tzCcf99Ma/us8e7L4BwyrXPzOOltMItFdWe3bZ9bnw0r6punkCIrbbD4jVRwo3Z0jsiOuWp/CvPRfOHtt7pCtQyB2ro0gLgOH3J7nQZYibox7v3Wc0fJeMnwzciZquGfHG/4KoOlyj2O/+RQgATT+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785508826; c=relaxed/simple;
	bh=SWjs5dj3TCu3z/6b9bho/ZTJi29DUTPyt83vnmEXV+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH4k3xdeHziawOOAX0RePJnUP+s0h02aBD4HO60256QoDaZarPeHTxh1ACSsqkOeetfAlKfP8GQJA1UMq3UVM8/oP1b/lD08oBe6uy5o9TGfV6ChDhltzaWYUvWCgJvR4HR0mW+fVb2DTenCIwhDCwd/CXaXz4QILohU/BnKSH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8TfB4lZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8TfB4lZ"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1670dad7a8so142800366b.3
        for <linux-serial@vger.kernel.org>; Fri, 31 Jul 2026 07:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785508823; x=1786113623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wGVPADeki+0/bIy545BYdtbcA87ECTF8VmVOWBf1hwc=;
        b=Y8TfB4lZ8beKQ9FQSX8NYBrFFlVJYmiPcdzMh7hy3QcuqOi+ug1woW6b/YvGtxrIMB
         btVAJecaEwJhoRF2u/xUlXRN92RkBnI+q0h0E8mUy4YrbYSbpwPaun9IZJIeOkJVN2BV
         VjW3XjoY8MpukRf8zbl22kjlTkH9YAXD/WudI1zZlP7C36a5QB3GQiGK/TKKQo4KP3iE
         95UJFQUEDc3zm82jKjb570iKmrByQqJlWghn9Qee96T+vPDttRWRu/DPnEkwcjZp+QvR
         DRWtrxOrPU2ak44QMzc8I/pSvC19DeL3X54DGo/lfRgciUuTre0/Tf8z4uGh5m8mp8xM
         lh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785508823; x=1786113623;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wGVPADeki+0/bIy545BYdtbcA87ECTF8VmVOWBf1hwc=;
        b=CPzKM43xala1UM/BFU5LySgdlNZJidyUzcPZkCxeggNgMFlK1TZAnBKV/RGx0CvwPn
         JbWrp38YknRJVkcSUv6OKAoZkj4YMQa2SJtQO1bjmCOY9mWuHo4SyB5JzP1Pt4H+wCkf
         OeASmLTdEZdo/3I1xHHmQv63Ecy9k1XOZjl5Moz1O6sWXNc4kx5c8og/7JGHCRRNjFvo
         NtNfUCETT0g1qnPW2lieYVEivCbQA50ZXo8FeNM76GxxmvLkWakk7AXwswrq0WZInijp
         Z+/Ae8nAqAcRPqtual8WhQ9TxxhvFmwpqR7JH+GPDGYYma78EjO9umgQJIHURe21ANDK
         xdNw==
X-Forwarded-Encrypted: i=1; AHgh+Rpc8GdTF+IBNANxJBAnXZGcE8jf3FdH/f24i+1tTcNstzDfWS4uDoGN4y48etpnxJzAj3CjtZy5gZbKbys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGXbLK6QvU9zyfILWwUPyZyWUfFrX3r3gH8U7m240p9VlAE95+
	8Y8ztKXgdSUjBWcfVNT2nh494VwUsc68m/Xpk9nyzbY3iOlvyiut81px
X-Gm-Gg: AR+sD13HjkHNWVULC5ScC0GPh0SffJ4RNffO8LAkN/Wzwj/pkOgvW4mXyz6Tga5vLUy
	SRRbQ7K1Z5bPF1Uj/BTQPmhrxDCBdU6E5hkvrpYKLYy8gkquExiX2ZwaQQi4exvdCWkiT91pWRH
	jFq94ux0DQ1z9Mg5uH/KaFRkC3jO3t5CxVggeJMRCngTcRSJE9q62626YRkino/HE1XQT8OLNs0
	6jXSxrGv6xvOUujeSlEsHL/hb5UdfWV78TY9wfkE4sxBjujbaC5dJg2xj2swcUGepDhmX+Ek5h6
	bwNReOnh0PrCF57s9GBXm528Gz4jgXv7yfpxU9xRdDIlT9EIpPTHe8uEZdnUdoG/Y+qZmvAE0Pn
	wgcugxcULs58WJmYBFIw2XScxEyp2rD3N1BxnGf5CoJVK3EF1dJSRYt830mu7OJoCAzcx0w0GZ3
	volTs+3jG8A0clWtoGgilcK6z5B3TxTvqOo8HmQtvl+9Wa8MPPkr42504gzlVZw8yztsBzD9rxF
	fpxe5lri0TdeBzaBwWbuYJCYCMJu/UY0XmzN4X9JbEr49pL2hu4RpL+tihWGgeDwhVmjIPZCh5p
	OGZib4nRoP7D1hxWa5uf6ZW+Zvq9ZFQO6HOfrnD/kn1bbFpYCb93L1fch+ktB2c7/RIv76Y=
X-Received: by 2002:a17:907:d08e:b0:c16:6e45:5ba7 with SMTP id a640c23a62f3a-c1fd271cb9fmr136450466b.59.1785508823290;
        Fri, 31 Jul 2026 07:40:23 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a8d0-bc01-6d31-3d12-3a11-d2d0.310.pool.telefonica.de. [2a02:3100:a8d0:bc01:6d31:3d12:3a11:d2d0])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fd4453823sm185693866b.40.2026.07.31.07.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:40:22 -0700 (PDT)
Date: Fri, 31 Jul 2026 16:40:21 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2 4/4] serial: imx: serialize imx_uart_ports[] lifetime
Message-ID: <amyxxce6haNJBJ3G@gmail.com>
References: <20260719221014.44354-1-kmehltretter@gmail.com>
 <20260719221014.44354-5-kmehltretter@gmail.com>
 <amufrR-1hop2pZOz@SMW015318>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amufrR-1hop2pZOz@SMW015318>

On Thu, Jul 30, 2026 at 02:02:05PM +0100, Frank Li wrote:
> imx_uart_remove()
> {
> 	imx_uart_ports[line] = NULL;
> 	uart_remove_one_port(&imx_uart_uart_driver, &sport->port);
> }
> 
> Is above sequence to avoid use mutex?
> 

I now tried this, but it doesn't work as-is:

uart_add_one_port() may call imx_uart_console_setup(), so the entry
must be present before the call.

uart_remove_one_port() unregisters the console. Clearing the entry first
causes its callbacks to dereference NULL.

The mutex protects those sequences against sibling probes.

Thanks,
Karl
