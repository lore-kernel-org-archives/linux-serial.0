Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EE530C625;
	Mon,  8 Sep 2025 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757339617; cv=none; b=RsjiaXIgnh6FzDqY+M+N16WGZ+Y0rcPljtPrXnrRiBAE3fzSFRRPDC1zbYnaUUL8zFhbhCxlsQpVG7LZFA+vCvbp4uVC43wDi2p0ROmuDQX18ncfmO8DkM/HT0qsvxZrGDB7b3zAyncDovdcdWyDkx+P3fNjGrnIcxJmeEhpyS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757339617; c=relaxed/simple;
	bh=Umci1imQy3chnb0mQHQQDUq4/7QPVlGljxwmFdMFd0s=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=ev10ppAIp4JIXNVVIwwuQ4d4CN/vJ8Epf8/f6+53t7z5705mjiWT0z6GTjtRu7vuNr2YydPcS36gkTZEa2YmCtgD9NZuln3Fg1RzV/iZEi8K3vjVeE8ZhXIQrfIQLZzy4x1VvM1XnFHumypWnUzQA30lPk5Z+O1l4baApMHzZiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=a284EV2z; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="a284EV2z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=umyZGfgtDmDd0ANfroE9M+DpA0XZsT0kLMeY3dIqaEs=; b=a284EV2zzo+fgtPybZUC6p4OgS
	QCws7wsADxVeku5ENKIipV5Ue6ISIRCZk8l16qsd6W68zX9dqAFPkKH+3Nl/kf/TdZAxd0B8w5qvL
	dA9vyLq8IoJpno3/Eg39xKSh0APWJPIxBddOSi6Lp2CD3SoLr3ICDXkG+1wCR1bgh3U4=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:46338 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1uvcJ2-0002Y7-Ko; Mon, 08 Sep 2025 09:53:17 -0400
Date: Mon, 8 Sep 2025 09:53:15 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Tapio Reijonen <tapio.reijonen@vaisala.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, Alexander Shiyan <shc_work@mail.ru>, Hugo
 Villeneuve <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Message-Id: <20250908095315.44f1688153add9ae4c53b16b@hugovil.com>
In-Reply-To: <20250908-master-max310x-improve-interrupt-handling-v3-1-91985e82ba39@vaisala.com>
References: <20250908-master-max310x-improve-interrupt-handling-v3-1-91985e82ba39@vaisala.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -1.9 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v3] serial: max310x: improve interrupt handling
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Mon, 08 Sep 2025 06:53:43 +0000
Tapio Reijonen <tapio.reijonen@vaisala.com> wrote:

> When there is a heavy load of receiving characters to all
> four UART's, the warning 'Hardware RX FIFO overrun' is
> sometimes detected.
> The current implementation always service first the highest UART
> until no more interrupt and then service another UART
> (ex: UART3 will be serviced for as long as there are interrupts
> for it, then UART2, etc).
> 
> This commit handle all individual interrupt sources before
> reading the global IRQ register again.
> 
> This commit has also a nice side-effect of improving the efficiency
> of the driver by reducing the number of reads of the global
> IRQ register.
> 
> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>

Reviewed-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

-- 
Hugo Villeneuve
