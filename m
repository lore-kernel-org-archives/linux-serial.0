Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0295439A802
	for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 10:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780136742; cv=none; b=BBTese/r5h++sFtxpZXW8j5jslVGsUunPD/8dQU7aS3zWtmPJ9joiw+rU9yKY7CvlvrlaSaE6gRKRAQkyxyKlcP2PqMaGpSstXtu+tfGagnSnj/mKm9DAcKOF+A8LmI1IT1jPeOSAxzWo3NdLvi55bInmAFrIwrMkQKcAlZt1AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780136742; c=relaxed/simple;
	bh=5liotKUH2CCRGkUkOCOBoHthJ8OJMkqN0hcTNMj+hzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ra+M2ARpiupTWd6hC9HTFQX6XPD0E81ggyX0IeE1CwUwlJZwnNN5dEP3wYhdIS+usPtoJdaYkwsZRsfG4oTLgfytVLcieUeQIEuNsaEd1xQTt+6M8CJp/NvOJXWizMQi6qiTtVmH3j/qR9BafwKPKjHKkW8sMT+fDg0R2mWs4YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J/Q4IhBW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J/Q4IhBW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5351F00893;
	Sat, 30 May 2026 10:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780136740;
	bh=8r9b4s8ES6CWyIdtdLISp8h2tgGIjyfOx3VyFaY9Wxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J/Q4IhBWXStAzk+H7GMZurmMFt0TzLVbu0FJqC1+kaznq9z9m3CALJvIPapc4dUL6
	 LqDSM7tVP0qIIU0eGV1k4lkuByhPve7+6fqPwQGZZI4LY/fL9CSy7dkOjLNHX/xr0F
	 VsyUTtj71hbVjV2gQLU+JD23N9/vZa3HV6ZNQm2Q=
Date: Sat, 30 May 2026 07:19:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Zhenghang Xiao <kipreyyy@gmail.com>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH tty] tty: n_gsm: fix use-after-free in gsm_queue vs
 gsm_cleanup_mux race
Message-ID: <2026053021-refocus-evict-fc38@gregkh>
References: <20260526102924.3174-1-kipreyyy@gmail.com>
 <2026052743-probation-anything-aa72@gregkh>
 <CACQTXGDb0vHRxjYTJo8r9Sq_ozu8Z=Y7GR4+F-2HGKGsA17kcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACQTXGDb0vHRxjYTJo8r9Sq_ozu8Z=Y7GR4+F-2HGKGsA17kcw@mail.gmail.com>

On Fri, May 29, 2026 at 02:28:22PM +0800, Zhenghang Xiao wrote:
> Resending this email as plain text, since the previous reply was
> rejected by the mailing list for containing an HTML part.
> -------------------
> Thanks for your reply!
> 
> > How to test
> I built two identical arm64 kernels (v7.1.0-rc4), differing only by
> this patch. Both kernel carry a msleep(20) instrumentation in
> gsm_queue() to widen the race window. Then run PoC and the patched
> kernel do not report kASAN again.

What PoC?  Do you have the hardware that uses this ldisc?

> > What prevents dead from changing
> Nothing prevents it and it doesn't need to. tty_ldisc_flush() is the
> sync mechanism not dead check.
> If gsmld_receive_buf() is already past the check, it's running under
> buf->lock. The patch moves tty_ldisc_flush() before DLCI release. And
> tty_buffer_flush() acquires the same buf->lock, so it blocks until the
> in-flight receive completes. DLCIs are freed only after that.
> 
> The dead check handles the other direction, any receive that starts
> after the flush sees dead == true and returns early. But I'm not sure
> if silent drop here is fine or not.

I don't think dropping is ok, test this on real hardware to see what
happens.

Also, this should be 2 patches, not 1, right?

thanks,

greg k-h
