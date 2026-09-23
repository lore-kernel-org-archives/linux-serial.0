Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B80E4A4409;
	Wed, 23 Sep 2026 12:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167289; cv=none; b=rXtoufHk2U4akR/Akg732n5klylDhs6vJkZyJVuqLMSqt+CFEyv+0IpPf+hZzn+i9iav8t2PrTkshONUFaDRW/SHJJFESTvrGB3kQY1CiX2J7Ew681lmtHtfD+hpGoAtGY/IymDR2elQymAHL7bXmGlBorR09z9Tu0t/LqpduiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167289; c=relaxed/simple;
	bh=ZLaxCRTsdTLU1Nk/9DJiJkk+vh/IWkAQI2B0PnmrWxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsAucMwMd52duCdPDHHqVQt3Kgte+09B3L4HCvpRbs9vOr8YdALtFvIXJEWfIQCPEiTONcQrFOsTqPBgK+kotap7gyNatOvhhB6lYOQ46Z9ymwtQjE6F24/0v+Of4DCO8Nj2KIWgcAyYywW1TwzERy2Wz784+1XJXMBSmRqPMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BN1FW+zM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BN1FW+zM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE471F000FF;
	Wed, 23 Sep 2026 12:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790167287;
	bh=xrji9nXd3vXH2ZzBK+PRVQMeg19smoRAoWKHTufOfL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BN1FW+zMQICXSe2fg/H8Of71YcLBrVHlwePLKhIv2k1ptKaRJjWQIKQb29cvRDkCj
	 0dVM0h9BMlg5eDvp7ocfXxEhrKJaLG+yK6p6LlhDoXku9+NeZnncYo9BKzCdyjwjKy
	 ua6QKky3nYYZQghe801S6m1ZomO/Tpt52FQctV/g=
Date: Wed, 23 Sep 2026 14:41:23 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 0/2] serial: 8250_port: Update runtime PM flow
Message-ID: <2026092315-eatable-canned-26a5@gregkh>
References: <20260814112435.3290545-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260814112435.3290545-1-andriy.shevchenko@linux.intel.com>

On Fri, Aug 14, 2026 at 01:16:28PM +0200, Andy Shevchenko wrote:
> There are two changes, one is a straightforward drop of the duplicate
> runtime PM call (which is idempotent and hence it's harmless to call,
> but practically no need to do so) and the other addresses long standing
> problem with potentially sleeping PM calls on some system in IRQ context.
> Also the latter might lead to unneeded resume-suspend cycle when IRQ is
> shared and interrupt is not ours. This mini-series to update runtime
> PM flow to make sure this won't happen.
> 
> Andy Shevchenko (2):
>   serial: 8250_port: Remove redundant pm_runtime_mark_last_busy() call
>   serial: 8250_port: properly handle runtime PM in IRQ
> 
>  drivers/tty/serial/8250/8250_port.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> -- 
> 2.50.1
> 
> 

  CC      drivers/tty/serial/8250/8250_port.o
drivers/tty/serial/8250/8250_port.c: In function ‘serial8250_default_handle_irq’:
drivers/tty/serial/8250/8250_port.c:1897:32: error: unused variable ‘up’ [-Werror=unused-variable]
 1897 |         struct uart_8250_port *up = up_to_u8250p(port);
      |                                ^~
cc1: all warnings being treated as errors

:(
