Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184B84B3364;
	Thu,  1 Oct 2026 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845114; cv=none; b=RQGjWma5VD5lu3G7Oa1r4YzSddpxDadI3FYEpQqslpKdnplpfGTRrSv+XKZz1Mu9+bS2Q1xEarfO5s8Tjhw+O3sxzyn0sFEDAoDEGj3HKoiQ7TrXk9k0iuQsIC9U/dmwn0lQFv26MQYSM/d3Br2U2KAlxt3YW0FcImkjQ8haPmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845114; c=relaxed/simple;
	bh=qta4kRKUASH8hbBlqIALP2lEsGhPUsVmb03ZLtoSnBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMriXjltj7c1yh3mouzkTSsVYFO1cYrgU/uv6z5MGmWtrDbzJCcgZzwvkSd8SaQTR4BjAD43ZiQzrZ1nht6JcrOBiqqvWr9t09JvlkDrNXIv5NOD7NG4kYqsnF9nPzLj2FTc0NaTh0656YOERiOG5tP3xZPqD+RW6qbqoGRUfpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=h3bvXvc3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nd2oZP9m; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="h3bvXvc3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nd2oZP9m"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id CDA221D000C0;
	Thu,  1 Oct 2026 04:58:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 01 Oct 2026 04:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790845110; x=1790931510; bh=xLTQ+nikEh
	cXgg+zHn1NylmpLJrhBgo/pijUD/rowyw=; b=h3bvXvc3DexVhe3VMzq4GjVK2u
	ZwQrYT2k8qJZTwZyDDjJwDi0YJgsYItJElKnqzTIeuUrv3x22DgzVrn4zB+CrJAX
	cXUBaaWbsJkPpPG8I+c6MwGgQ16EKB0yZ7Tqe9ygRIjOVXZJDK6dPEnT1vPojdKj
	F+1A6exoPZUsRAjdFDSRA8thPJfYXdQN3LPYofR2ThDIcaY0Mqvloj29jbYb4Lfj
	3vBgWKIW5LX7XeD0q5z3eNNXVsYTOidQKowgz/IaoZ0jgR5wq7SaqaE1P83aN+NG
	eGiL8usW0T5ONG1hspWgPVf3S8sPziOH5hJimrpJbVWXfFmdDdjWSwlBaI5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790845110; x=1790931510; bh=xLTQ+nikEhcXgg+zHn1NylmpLJrhBgo/pij
	UD/rowyw=; b=Nd2oZP9m2v0HWWgktXVSQPzgN+Xc3lQqYGmb4np4r5uYIpOj1wQ
	qhxE6RVQ6/vxrh+1E4nmLqUSS383PIyaaQs3J5SEUHtQ1pjUMmaTylGPwWVN2MNh
	GEcxe2pAUPGfkab5Gw47LWCTSPGLoallbLPSCfucLEmavmwUBq9qYhuEbGOuzT81
	P33+u6NQypRnqj0lsT36aMyXHfAG4bULK+ZuNiu0gi84hLscaAEiNrbK11jAXSVe
	aQL1znIDDxip8+LUAc/nHA1NJPaAgb/VUrcNBdtMCYiJw2uWxQ3fRC+JaTunPWm3
	XoBJ61RFLUzAiJVURomyURyiezrxpxu9uBQ==
X-ME-Sender: <xms:tiC-ag9tzTuc9CfUYWEz3XJBcYpfMy36nvkkh48duXWTar5x21sD9w>
    <xme:tiC-aoINrq2UCZ0EZasno0nb7h6FG1GdblaSH9RbAGBike9CPQqaf-qd-y_7RpIww
    LlrVJisLWy7EopWMYJfGY8Qr0mYC3klbxT-n50ni0j1V2UD>
X-ME-Received: <xmr:tiC-anGRQRe_A0oIKKVFr7unoXLGTA1yO1ddV-47EoM5ye5O7Q_HceMlCMVEAN1dXFesNbBVUwmnDyqGWEja9sa7y6yJLxz155vUckNlFo4>
X-ME-Proxy-Cause: dmFkZTEBPyA6y5pJJYd7mRVrJUTDoDfaBG29wt3ahkoP7euVDh+6FqohMxlZrfxtICIy3u
    Q8+57gK1CdUbpAPhSau9Y/ZNhrBidamnkZx47V/FEJwkxqtuZFwarRBIsHe0qRDvel+W+P
    susiZwX2fXuPkigAOJf4dJlyvQETkF8wuC7zJJpXgen26ISYBmhb0wDekeOm+yJhMEwk5Q
    +N9xgOoNf06TEWD+P+1wPZkdIHrocqyNDQJSzjwzk547kkHARVp/RYegcHwrfoXUszWm5a
    asNFq78eXg8F6CPnL8DKsMARCXaEY7jonwzKbxQqaGk5K5CGilH/m/q/ovGXngfI6VekoC
    xg4KBWTWaEnFmeiwqBVWYjI/VNmy1Lw0qLxc01hzfbN2rnJYfOAag7IbhosC17z4QnNTk1
    I6V698eVxuTRbTKtCMW8uZ4fW2i8AcYlpK4G1vZA0x+V4tNBQ/2H/VTRPQFpmeZe4AGWZF
    0XYfEkyYkNKXoLps+RvQrff8iqrfo9uJOjVXo9Xgw5CK1chRNQTK2FyuWnLCVNzRu/DW6W
    HBMOV6hAgg5ODn/erbfLuirQ9G8ZnKLrh5rR6BL8KPfgS7AJbuyFcb3PX87vRJ3uew/KoS
    X+l0PQ3VU9a3FPTl4MehOi/ysVM2bq9VxCEfgRz8Ybr3Js4NXP0g9QzP6m5w
X-ME-Proxy: <xmx:tiC-akzmbBXMXA4wEcEdWdw07vrhWcOFW8ibXUguyEny31nqCttoMQ>
    <xmx:tiC-ao7GOY0w5QTtadRyIx-insL2v6rPfS4-_1422sNnq2F3fTE9rQ>
    <xmx:tiC-ahfudo9leF4E8-qH3EOuk6FQdotLVVbbFfJ_AYa3gPUfytQOQQ>
    <xmx:tiC-anEUa3lGjWxccFRBFPRTNl6XB9PIDcQbrV5PWlNbBIpPLxwqSg>
    <xmx:tiC-ajcXRT2k4NxB9OlO45qWYX3Ps99tsJEJWczTveovwtE6lDJrr9_n>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 04:58:30 -0400 (EDT)
Date: Thu, 1 Oct 2026 10:58:24 +0200
From: Greg KH <greg@kroah.com>
To: IgorpetinDev <igorpetindev@gmail.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	syzbot+843bf2f48f4d12e6682e@syzkaller.appspotmail.com,
	linux-serial@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] serial: core: shut down initialized port on removal
Message-ID: <2026100116-avenge-reroute-44ab@gregkh>
References: <20260924192224.3175-1-igorpetindev@gmail.com>
 <CAG21Q81Fc1-0_ZX04tY9TUv61iQi9uYHj2Ew+vQgZjWczKbZ6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG21Q81Fc1-0_ZX04tY9TUv61iQi9uYHj2Ew+vQgZjWczKbZ6Q@mail.gmail.com>

On Sat, Sep 26, 2026 at 04:05:31PM +0300, IgorpetinDev wrote:
> Hi Greg,
> Note: syzbot did not actually provide a reproducer for this crash -
> this patch is based on code analysis of the trace, not on hardware
> testing. The pcl812 trigger from syzkaller is synthetic.
> 
> On a console port, tty_port_shutdown() skips ops->shutdown() because
> port->console is true, so the IRQ is never released.
> If the device is later unbound/removed, serial_core_remove_one_port()
> frees uport->name via kfree(), but the IRQ is never freed.
> Result: a stale irqaction pointing at freed memory in action->name,
> even without anything else requesting that IRQ line.
> 
> sashiko-bot also pointed out a data race on port->console = false
> outside the mutex - separate issue, but relevant.
> 
> If the underlying problem looks real to you, I'd rather withdraw this
> patch, put together an actual reproducer (unbind a console port, check
> for the stale irqaction), fix the locking properly, and send a v2.

Please do so, thanks.

greg k-h
