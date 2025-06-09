Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DAFA1487D1;
	Mon,  9 Jun 2025 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749472758; cv=none; b=udi4BGh0U5nT2/sVw0lFI5mu5RW8s0cN8+EDwoYnISdeODCuIVnsiAsJvRH771yFe7KyzKTrqDW1LrjzVrmGkUcM4Y5eZmuuuv4KwnoZtMHB5eaRoItBBlJjjc6wxvvOQezfKk5X1y9ecpmWNc78+cXU1+F/88teZ7YEAI5cxvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749472758; c=relaxed/simple;
	bh=bBK+fw1Pb3Rb0q/iEK29jV7iVAI/EBRtGoYRmC74JFg=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=mg5hA98MLOxna1KAkPdXosXRUJKTPFzkhVkWdRFTat4ht8N/2x2+/kNqPYgDG8mJSSrYVPy8ThS+FaWdEChZwnIi5kAolB1p/DQOXBOBzJL/kVW5EWjGa8AYNzfc0kivUf8dpm32t9FU8ij8N+pevOsFLAI9yKHhVqOIk4y0lRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=vLMW9n5W; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="vLMW9n5W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=e5FqJHW2gfLCv1rYVjg7825Aoec+97DH4gBEZutMljw=; b=vLMW9n5W87oxtql+bhbf8rfzdH
	rjPD5d9pd2ZOa/zLYrYgje0FnCZn1pDPKVOhLUbJAk1YElQst8u9gJpR72SXr072sFjV35KebsOXa
	TDVCgDtF8M7bJ7DxKBJHt+8rrFKC2sLC3jMI4KVZ2lixzJrWWVYt8m6nwQ8dJfsmCokQ=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:38760 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1uObmN-00071a-A1; Mon, 09 Jun 2025 08:39:07 -0400
Date: Mon, 9 Jun 2025 08:39:06 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: shanmukh.iyer@gmail.com
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 trivial@kernel.org, Shanmukh Iyer <shanmukh.iyer@polymtl.ca>
Message-Id: <20250609083906.2612e881444ee04360715aed@hugovil.com>
In-Reply-To: <20250605000903.74242-1-shanmukh.iyer@polymtl.ca>
References: <20250605000903.74242-1-shanmukh.iyer@polymtl.ca>
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
Subject: Re: [PATCH] drivers/tty/moxa: Fix spelling mistake in comment
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Wed,  4 Jun 2025 20:09:03 -0400
shanmukh.iyer@gmail.com wrote:

Hi Shanmukh,

> From: Shanmukh Iyer <shanmukh.iyer@polymtl.ca>
> 
> Corrected to "maximum" as my very first patch to the kernel.
> Just to get used to the contribution workflow.
> 
> Signed-off-by: Shanmukh Iyer <shanmukh.iyer@polymtl.ca>
> ---
>  drivers/tty/moxa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/moxa.c b/drivers/tty/moxa.c
> index 329b30fac8fc..d32fb37e2e1c 100644
> --- a/drivers/tty/moxa.c
> +++ b/drivers/tty/moxa.c
> @@ -1628,9 +1628,9 @@ static void MoxaPortFlushData(struct moxa_port *port, int mode)
>   *
>   *           return:    0       : this port is invalid or baud < 50
>   *                      50 - 115200 : the real baud rate set to the port, if
> - *                                    the argument baud is large than maximun
> + *                                    the argument baud is large than maximum

while at it:

s/large/larger

>   *                                    available baud rate, the real setting
> - *                                    baud rate will be the maximun baud rate.
> + *                                    baud rate will be the maximum baud rate.
>   *
>   *
>   *      Function 12:    Configure the port.
> -- 
> 2.34.1
> 
> 


-- 
Hugo Villeneuve
