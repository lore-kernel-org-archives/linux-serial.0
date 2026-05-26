Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982583FE67A;
	Tue, 26 May 2026 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779805763; cv=none; b=Y3S5aqhNAKIkPstirROC6obLQtq+1HPFqb22YlzEzr6ROakHB7CdbnEtGMC7vQ/oL4XUdRhcX4qAKSJTjUY+IYLDIR+udSUMyFhnfUiyGV8OQGpd4KpG2CDCR0joLt0ZyYb5PywZIv9KR6O7H2m1t/j7NCIY6C2Iru4r1H9/FB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779805763; c=relaxed/simple;
	bh=JuLpsn9OUJnk+KDwxoPVnf2wqQZ47a7Z+ADuKrOixk0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=q9kY9RndUghVa6zbprtdtHYvKFlnu8bK7jz4Xno1qR2/mHyPrVQwltOS4GfxPxj0ccHwa/HQto2y/7H2DOYrCN80Xq9swuLJNrgESucyVQemYiBVP+EdzIhH9sOGqVQR9VVA4FuHbNiAZSYomocfjm4VNrUVxUEImXrJ0kz9x7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=lykq1Ryz; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="lykq1Ryz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=lXy7s6PShBzv4LimLMoGBm3uez6l935U2ZfETM+0NFI=; b=lykq1Ryz+xLG80fFys7F2t+YH/
	f2ZsTuA1Nqt8+3FWuAuklXoe67wzPk15ENl8onX1eZhro4ajblksoM9nTCbUiKoCxWuc1aAlCnESX
	5MM7CiQtAzdSAXxqBq2lukTfjNR2y2dtqfD5IVNRfSe/5lZ+whUq11FciQUYzg3gC3MY=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wRsmR-000000001vB-46m8;
	Tue, 26 May 2026 10:29:16 -0400
Date: Tue, 26 May 2026 10:29:15 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Theodore Tso <tytso@mit.edu>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Randy
 Dunlap <rdunlap@infradead.org>, "Dr. David Alan Gilbert"
 <linux@treblig.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>, Gerhard Engleder <eg@keba.com>,
 Jiayuan Chen <jiayuan.chen@shopee.com>, Joseph Tilahun
 <jtilahun@astranis.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] serial: core: Don't clobber the baud rate on hangup
 via B0
Message-Id: <20260526102915.c0dc51579182c0aeb1390bc4@hugovil.com>
In-Reply-To: <alpine.DEB.2.21.2605242242330.1450@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2605242242330.1450@angie.orcam.me.uk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi Maciej,

On Mon, 25 May 2026 00:14:03 +0100 (BST)
"Maciej W. Rozycki" <macro@orcam.me.uk> wrote:

> Requesting hangup via the B0 baud rate has this nasty side effect of 
> clobbering the previously set rate for the port unless it happens to be 
> 9600bps.  Consequently if there's a consumer still active at the other 
> end, then it receives garbled data from any other producers outputting 
> messages to the port, such as init(8) or the kernel console.
> 
> There doesn't appear to be any particular reason for this clobbering 
> other than that we have been doing it since 2.1.131, so take a saner 
> approach and try to retain the old baud rate where available before 
> resorting to 9600bps.
> 
> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> ---
> Ted,
> 
>  This code ultimately evolved from a patch of yours[1], so would you be 
> able by any chance to recreate your rationale beyond resetting the baud 
> rate to 9600bps rather than just keeping the old one for B0?
> 
>  Otherwise, does anyone know or can come up with any actual use case for 
> this baud rate setting?  There seems no sensible way to restore the baud 
> rate required by init(8) and the kernel console other than by hand, while 
> I can't see a way for software that actually issued a hangup request via 
> the B0 artificial baud rate to withdraw the request other than by choosing 
> another explicit baud rate.  So there appears to me to be no usable way 
> there of relying on the implicit 9600bps baud rate set via the B0 baud 
> rate.
> 
>  Have I missed anything?
> 
>  I have dug into this having been irritated by the occasional clobbering 
> of init(8)/console output observed and now finding a reproducible way to 
> clobber the port in the course of working on a recent set of changes for 
> the sb1250-duart driver.  This change has made messages get through with 
> no damage.  Many of my systems in the lab actually use the baud rate of 
> 9600bps, which covers the issue, but the CFE firmware sets the baud rate 
> to 115200bps for systems that use the sb1250-duart driver.
> 
>   Maciej
> 
> References:
> 
> [1] "Was: patch to drivers/char/serial.c to fix kernel lock-up", 
>     <https://lkml.org/lkml/1998/12/5/126>
> ---
>  drivers/tty/serial/serial_core.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> linux-serial-uart-get-baud-rate-hup.diff
> Index: linux-macro/drivers/tty/serial/serial_core.c
> ===================================================================
> --- linux-macro.orig/drivers/tty/serial/serial_core.c
> +++ linux-macro/drivers/tty/serial/serial_core.c
> @@ -461,8 +461,8 @@ EXPORT_SYMBOL(uart_update_timeout);
>   * @max: maximum acceptable baud rate
>   *
>   * Decode the termios structure into a numeric baud rate, taking account of the
> - * magic 38400 baud rate (with spd_* flags), and mapping the %B0 rate to 9600
> - * baud.
> + * magic 38400 baud rate (with spd_* flags), and mapping the %B0 rate to the
> + * rate provided by the @old termios setting if available, otherwise 9600 baud.
>   *
>   * If the new baud rate is invalid, try the @old termios setting. If it's still
>   * invalid, we try 9600 baud. If that is also invalid 0 is returned.
> @@ -516,7 +516,7 @@ uart_get_baud_rate(struct uart_port *por
>  		 */
>  		if (baud == 0) {
>  			hung_up = 1;
> -			baud = 9600;
> +			baud = old ? tty_termios_baud_rate(old) : 9600;
>  		}

Please rebase your patch on greg's tty-next branch, because there have
been some changes by me lately [1] to uart_get_baud_rate() and your
patch will not apply.

Hugo.

[1] https://lore.kernel.org/all/20260410152022.2146488-1-hugo@hugovil.com/raw


>  
>  		if (baud >= min && baud <= max)
> 


-- 
Hugo Villeneuve
