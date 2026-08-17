Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A1642D763;
	Mon, 17 Aug 2026 14:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786976060; cv=none; b=W+t0Ld9YKeas/aWS5RVj21ugAgugXK/MHp+o4lCZfsJdXpJZFDVK7k4/c9JJry366HhEzWKTClHfu60dyBP+VEu0ltwajEfYXBtjWLkhGBR+y79gq+uDqIbJEEGZNbBIAg099wMHlDi3ELp6P7/fZLlxMiweI1pjmSZumT2xfSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786976060; c=relaxed/simple;
	bh=s59V704mE9NSsW54ibnQ64U2RiLE66hEa5FitdkHmZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1Viw0Fsc3ZIe9NmiyEDYgJiaKsigO5yr8J/HJgNGqyBsMM19vgIqcfnboZlrHKo8HecpxNgZwiWje5BZxML6oIHUgQUQwf3ISbm40ymiN8+h+0G+T0/msZ+TYOmhKN0axbtxlRjqZiIJE6PIaXjwU0njMZHjC24nj5Y3VNoVxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qR9KX1zD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qR9KX1zD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B63B1F00A3A;
	Mon, 17 Aug 2026 14:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786976059;
	bh=pynuHM1Qlbmo4XHJgfGS56Zv9Uqnu12X+vs418vJI+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=qR9KX1zDjcOCmfVDHFQII9m7t+/D89ze/tRcC+Lmw2cwrLVjziyUxO12Nmq4uNToP
	 Nw7SLBgHfEUsu5WCs3HOvNGZLnKrvctXhFuqBuzHNg1bUF/IwoGb7CMhSkv/UBlpo4
	 7wqf6SQjM/rwDL+o3s7XSRiwmlsSfbhtkw7KLYgY=
Date: Mon, 17 Aug 2026 16:14:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Xin Chen <xin.chen2@oss.qualcomm.com>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, liulzhao@qti.qualcomm.com,
	cheng.jiang@oss.qualcomm.com
Subject: Re: [PATCH v1] tty: n_tty: use kvzalloc/kvfree for line discipline
 data
Message-ID: <2026081744-vision-coherent-8b62@gregkh>
References: <20260817135526.386863-1-xin.chen2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817135526.386863-1-xin.chen2@oss.qualcomm.com>

On Mon, Aug 17, 2026 at 09:55:26PM +0800, Xin Chen wrote:
> Note: checkpatch warns "Prefer kvzalloc_obj over kvzalloc with
> sizeof", but kvzalloc_obj() was introduced after v6.6 and is not
> available in the target kernel, so kvzalloc(sizeof(*ldata),
> GFP_KERNEL) is used intentionally.

What do you mean "target kernel"?  This is for 7.3-final, right?

confused,

greg k-h
