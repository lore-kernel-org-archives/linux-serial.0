Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95593176FDB
	for <linux-serial@vger.kernel.org>; Sat,  8 Jun 2024 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717840722; cv=none; b=fMnbzO02TUrScLvOh4LW9I54tMUd1s15+YU5hTCECcSSxJxBuS5gLPyQjjhWRrzOIJ7cA/2gYJq3P3wN9ZeR5SazhJHjuAePnx6Y2/rlW4zPwQpGBVVK3tyQlowePkw0Fo4tLIKB3eRR6g9RH0XFKkqURKUl1GzkFFqs+iK8aMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717840722; c=relaxed/simple;
	bh=zR7u7bpINGdctpqlmk9CTOIvqrr3eyoVr9BUEGTTrGM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OECHlI6FybHQLpP9DhIrm1E5NECXOI5w7Tj8RRjBM/fQPrTgyCp2sNjls433DpKVGgHzh0T7JueIE0U6Cbn+TvALI5W3VWyLkSQ+PWUV2oFJl7s2ubStd6RET+MyIcW7vNrt05LNyUQxOWf/XQsdESe++XQS51BzKu7mIyNIMXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-230.elisa-laajakaista.fi [88.113.26.230])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id ad6f8b07-257d-11ef-80e2-005056bdfda7;
	Sat, 08 Jun 2024 12:58:38 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 8 Jun 2024 12:58:38 +0300
To: Crescent Hsieh <crescentcy.hsieh@moxa.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 1/6] tty: serial: 8250: Fix the amount of ports doesn't
 match the device
Message-ID: <ZmQrTt9Y5FFeWiFT@surfacebook.localdomain>
References: <20240607114336.4496-1-crescentcy.hsieh@moxa.com>
 <20240607114336.4496-2-crescentcy.hsieh@moxa.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607114336.4496-2-crescentcy.hsieh@moxa.com>

Fri, Jun 07, 2024 at 07:43:31PM +0800, Crescent Hsieh kirjoitti:
> Normally, the amount of ports is written at the third digit of device ID
> of Moxa PCI boards, for example: `0x1121` indicates a 2 ports device.
> 
> However, `CP116E_A_A` and `CP116E_A_B` are two exceptions, which has 8
> ports but the third digit of device ID is `6`.
> 
> This patch fixes the issue above by adding checks.

Can you send this patch separately and add Fixes tag?
I will give my tag on it, but the rest needs some additional work
I think.

-- 
With Best Regards,
Andy Shevchenko


