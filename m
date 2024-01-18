Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06121DA2C
	for <linux-serial@vger.kernel.org>; Thu, 18 Jan 2024 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705589463; cv=none; b=EEEX8UuMfxZ6KqK3izf8xhb3d445TjJ4DPYmcjP8LHlPnZUOjBIRN9SRif70jWN9636TKC75+k+66rZW3YS5LlU19JXdLcaIr63zlYkfy5vztVS6FP3M42cktHzwttPHzXwQADWWCKHZffZrpL4imbHOsoAIF5Z5w2tq/BYlWKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705589463; c=relaxed/simple;
	bh=dU0vTGtSjy0owwgueKY5DvJdRB4i0XsI3LTxRMVgXpE=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=dCb15E0jqdLWbT+o8RmurZkAcC+W0VlH7R3ECTPWGtvjiG83f4Yv5nVlmseGk0tILCisjJLiJy79wzYX3aPzzG9hiKdU2SqEoaoEtOA+D8UZFyTC5HOdAZKxeSjymWcUOxJcUSGHhPobYhlNhAbj7QaXJouiupPb5f5VaSDQu5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cf3SI2ny; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cf3SI2ny"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4498C433C7;
	Thu, 18 Jan 2024 14:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705589462;
	bh=dU0vTGtSjy0owwgueKY5DvJdRB4i0XsI3LTxRMVgXpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cf3SI2nyc1QrLdhL2wtu5KvpDfRl7HoJbrAAJm6FH/ruTGMFGJLQRPiMxM8roXq+S
	 nf9ekDQyNf5jy1JyDNRTAaaJ6KcyzjjMe/jSLEHrCtbEmcqaqGUUmFcNHl+rrkixUO
	 z7w895DXf//JKm50jyX7Bdk+Zud9Erhtr57PhsjY=
Date: Thu, 18 Jan 2024 15:18:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Crescent CY Hsieh <crescentcy.hsieh@moxa.com>,
	Jiri Slaby <jirislaby@kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH] tty: serial: Fix bit order in RS485 flag definitions
Message-ID: <2024011827-bagful-connector-9b36@gregkh>
References: <20240118124350.3772-1-cniedermaier@dh-electronics.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118124350.3772-1-cniedermaier@dh-electronics.com>

On Thu, Jan 18, 2024 at 01:43:50PM +0100, Christoph Niedermaier wrote:
> Since the commit 93f3350c46fa ("RS485: fix inconsistencies in the
> meaning of some variables"), the definition for bit 3 has been removed.
> But with the switch to bit shift marcos in commit 76ac8e29855b ("tty:
> serial: Cleanup the bit shift with macro"), this gap wasn't preserved.
> To avoid a break in user/kernel api of the system skip bit 3 again and
> add a placeholder comment.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
> Cc: Jiri Slaby <jirislaby@kernel.org>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> To: linux-serial@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---

Shouldn't this have a Fixes: tag in it?

thanks,

greg k-h
