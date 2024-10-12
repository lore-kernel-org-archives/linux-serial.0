Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D988DBA49;
	Sat, 12 Oct 2024 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728719856; cv=none; b=Ug/Dt+1yGfYfzeJ2L0KIxIONhtWbvBpQFx1nhwjjHQsIsf0sX4a429v2/+s1VHCeISQmpcbPOb45lV0e2O48aQBiGj+PA5WqmFdATAOmLVk97UAQJ2hGoL3WCDcDhszLcSgtpkd1CAvetW58ovpmeoPL0GTeIoDs/EN30oWwKuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728719856; c=relaxed/simple;
	bh=IU2T6p+RhRrmHA305wop28b8xEXoFimsESzGPGGv7nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EypTt6ta1U6sLBHNo/W0+mPfIO/7aEDtSc4i9HuPKhqy6gLCpWw1QifwQsHvPLFmgaCUIEUppUuuiyUG4mzPcxYmmtRdQnJAbxuErKSUlcGkRsCyQBD2f3V1tidM0RAIadp+xuClMwHWCT/x7kFfhY1ybX02lpmj0Y0s9wMe99Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qr262wZY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qr262wZY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16B8C4CEC6;
	Sat, 12 Oct 2024 07:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728719855;
	bh=IU2T6p+RhRrmHA305wop28b8xEXoFimsESzGPGGv7nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qr262wZYeX+QeU3d5lxXx9ytsK6DyBKnhCQCo8XBgM43sR/5rgBTvn4FDGizHw6Ii
	 nC7OeoOokPm+MYp5WbJRM9hRODYDU8SqD1iH+CifBs70Qe2NGl3ht7q+P1XW/0dr9m
	 SUojwuHP9WYyfvtX2o9wg8GZzfP6otlk3A3x/QBQ=
Date: Sat, 12 Oct 2024 09:57:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yanteng Si <si.yanteng@linux.dev>
Cc: Yanteng Si <siyanteng@cqsoftware.com.cn>, linux@armlinux.org.uk,
	jirislaby@kernel.org, alan@linux.intel.com,
	bartosz.golaszewski@linaro.org, andriy.shevchenko@linux.intel.com,
	arnd@arndb.de, u.kleine-koenig@pengutronix.de,
	mengdewei@cqsoftware.com.cn, linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: clean up uart_info
Message-ID: <2024101206-stench-eraser-e479@gregkh>
References: <20240920053423.1373354-1-siyanteng@cqsoftware.com.cn>
 <6b5d548b-82ab-4bf3-90da-173928968fb9@linux.dev>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6b5d548b-82ab-4bf3-90da-173928968fb9@linux.dev>

On Sat, Oct 12, 2024 at 11:10:05AM +0800, Yanteng Si wrote:
> Hi all,
> 
> 
> 在 2024/9/20 13:34, Yanteng Si 写道:
> > Since commit ebd2c8f6d2ec ("serial: kill off uart_info") has
> > removed uart_info, the uart_info declaration looks lonely,
> > let it go.
> Could someone pick up my patch? Or give me some hints on what else I need to
> do?

I picked it up yesterday, you should have gotten an email for it, it is
commit 483c5c2bc6b1 ("serial: clean up uart_info") in my tree.  Do you
not see it there?

thanks,

greg k-h
