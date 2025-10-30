Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45AD3328F1;
	Thu, 30 Oct 2025 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761854515; cv=none; b=RkVdJALwAjrsyARdSt+jWA+MVqzySdv8pAG+kNMA0ZXfaChQvGQB0SLoUM+vRiWzEOC8/3wHTFQKGOArOM2S+obJxJf24ceXoHJ0kvNdQWnF7amqA5qpbCdNaQty+fvH8LVLTbRQzHfanegbz6B15wbWm/QO4Q//QvF7pmSA3hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761854515; c=relaxed/simple;
	bh=HVg1JjuEIl2ZtyXthNVNE0xyixvCrCltCUszdJpTUrE=;
	h=Date:From:To:Cc:Message-Id:In-Reply-To:References:Mime-Version:
	 Content-Type:Subject; b=VSzhFZFWkFc/HrB8zBD6qVrfmKtwvvk+M8bio9KuwsYrzuH4yHWqR95hbW29HfB++xEUiGwX9PsRInrIMuOwoxutl0HyPtKb776TO77oaMP3LI+HwFFFDcmOYkL8Yr9/96VjhfebW0R4/5RfV/wrHP/7o54N2Ubo34LQKcaDagA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=SA+dwgu9; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="SA+dwgu9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=VWspoIGJ+J2dFkXu8DhQ+OCtXbfe73pkNJPKHONBNxc=; b=SA+dwgu91w+y9okuQ+yehHmkum
	UDMKx61Sr1Enf3DDYiRyOzfEN2xVIAbbDYmgSox9UesJh0umKDiBOZzMGmMVge6xb+autZ+Nktwdb
	ssBtZYRdrMx5KddCbq9FydKpb3FHvHrx+iZMXD1ZXr76tClUPbUIuS0BGdq5gtI6OsV8=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:35546 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1vEYq7-0004jm-Nk; Thu, 30 Oct 2025 16:01:44 -0400
Date: Thu, 30 Oct 2025 16:01:42 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>
Message-Id: <20251030160142.e1ae7b158216b8101582cd49@hugovil.com>
In-Reply-To: <aQM_VBg_7JwyGGLG@black.igk.intel.com>
References: <20251027142957.1032073-1-hugo@hugovil.com>
	<20251027142957.1032073-12-hugo@hugovil.com>
	<aQM_VBg_7JwyGGLG@black.igk.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -3.6 NICE_REPLY_A Looks like a legit reply (A)
Subject: Re: [PATCH v3 11/14] serial: sc16is7xx: use KBUILD_MODNAME
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Thu, 30 Oct 2025 11:35:00 +0100
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Oct 27, 2025 at 10:29:53AM -0400, Hugo Villeneuve wrote:
> > 
> > There is no need to redefine the driver name. Use KBUILD_MODNAME and get
> > rid of DRV_NAME altogether.
> 
> Actually I am slightly against this change. The modname (and hence modalias)
> are parts of an ABI (visible via sysfs). Changing the module name (file name
> in this case) may inadvertently break this. Yes, it most likely not critical
> in this case, but should be taken into account.

Hi Andy,
thank you for pointing that out. It didn't occur to me that this could
impact the sysfs ABI.

Hugo.
