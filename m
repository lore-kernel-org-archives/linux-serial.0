Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F9F155C87;
	Wed, 18 Dec 2024 20:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734552334; cv=none; b=KiE0oytaA9xTTNoygc9oTAi82i20s+el2gnBBhuw7sVUf/PMdipD8GwGnyIOHLEvqqh/BtB9zNJUMlWltTMuEWm5AzQeSi8oIX2ruYqB1oH0Y4XZ3QPp0EqGIacLERLtDiL4u3exUoIG8bbwdqOpiuB0jaDWd5PpBMPHKCRDMvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734552334; c=relaxed/simple;
	bh=u02Gn6exfPKIbt3/cnfjpCAV3dtgCIFgzpTVTfE0FT4=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=KuvOvI5GZDGWn0c8CQoaEeVl8pMWtg4IUQrjrYVUMy5ej98hPgn6k00qW36p953sxxd6Z/uRzWow2QDsZx6lPVSUi1mvomLkAi33woum4evVcZKI8uc0POa4vKv4f0TurXvBSomAq+XxaExdV+5iFESILoFEzmSjk8dHB+yWY/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=f3zgNLqH; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="f3zgNLqH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=IhMdQNQOcIwIXnR1AI4gbp9UwV92+Iav/NEyjeXxCSw=; b=f3zgNLqHGo1AA19nI2/DYk/XFF
	Hn/hNqpuodmIu5Sjc0mNfFGmK9eRrclflTW0X+4nHdZxs9UU2yTzU/UprhCkn3TJ6H2W9dcwUxL4K
	Za/DEYy7Qqtu+0t1i73E/XtdKOncbfwbzbloVFndQ93wUBFBnP9NlmzW+KwsEoad4pc0=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:46792 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1tO0IA-00068J-Pn; Wed, 18 Dec 2024 15:05:11 -0500
Date: Wed, 18 Dec 2024 15:05:10 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
 hui.wang@canonical.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, Lech Perczak
 <lech.perczak@camlingroup.com>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <20241218150510.5424cd78bafbcdc30a894f18@hugovil.com>
In-Reply-To: <2024121709-fool-keep-c408@gregkh>
References: <20241216191818.1553557-1-hugo@hugovil.com>
	<20241216191818.1553557-2-hugo@hugovil.com>
	<2024121709-fool-keep-c408@gregkh>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -2.1 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH 1/4] serial: sc16is7xx: add missing support for rs485
 devicetree properties
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Tue, 17 Dec 2024 07:41:32 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Mon, Dec 16, 2024 at 02:18:15PM -0500, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> >=20
> > Retrieve rs485 devicetree properties on registration of sc16is7xx ports=
 in
> > case they are attached to an rs485 transceiver.
> >=20
> > Reworked to fix conflicts when backporting to linux-5.15.y.
> >=20
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> > Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
> > Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
> > Link: https://lore.kernel.org/r/20230807214556.540627-7-hugo@hugovil.com
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>=20
> I do not see any commit ids on this series matching up with what is in
> Linus's tree.  Please fix up and resend the series.

Ok will do. I will first submit only this patch to make sure my
submission follows the stable guidelines.

Hugo.

--=20
Hugo Villeneuve
