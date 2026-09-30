Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7050483BC3;
	Wed, 30 Sep 2026 13:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790775755; cv=none; b=TUTbUnNR3L+ciqa9iTaOw6CvaLsWFn8uXXixIoZWHtOo3zB/BkdG4/JhFo1gxa2qMAV/gR0qt0MCUhm3wF2D6gPzOsWGwipAwphXPg+kP4LKATUUwYKYKBYEXiA4siVhRZFNZAHCE4Q++o8sux7wmlTP5l8hlyzD3yKCWtRqmKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790775755; c=relaxed/simple;
	bh=XV0mpdFC3QxRzZCrNzmHDmrAw7sZdhF1tE94FA0c8+8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Qdugu34+gkQKx3DDOs0s/D/m1ydpp8ku5R5lvss3/wXstQfdBNL8qFDrghKpAimMaTo9/krK9PM046RxojJMsqWgOWHyw018wpgU8ML4RR4pAxhbIW7/qTmPMc1ubbfeuzeR5ZO5N9J2LUKkATTCsZ6qVFBwW5ogiFop9ZouagI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=ThaZCC7D; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="ThaZCC7D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=hKDQhczJ4TEj8L933bYIEt22bKs3l9H0WA0I42sGdY4=; b=ThaZCC7Dl2INf+1DuuKdWeaBjf
	kqapaqREhp71gE/kNIrJWD7Ee4qzfObk6Ue6Yht5A1cHfaCqOsLBJ2T+O/T/TCNw8V7R5JFV4PfrS
	XIfnj7m0I+BUu1hO2Vxua7RJUtucCC9e41Zv02f9sndSTTkWnVl4m7LxGzWSb7MyodBE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1xBuZf-0000000038A-0cAn;
	Wed, 30 Sep 2026 09:42:19 -0400
Date: Wed, 30 Sep 2026 09:42:18 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Paul Mbewe <paultyson.mbewe@ziehl-abegg.de>
Cc: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
 <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <tobias.gannert@ziehl-abegg.de>, <joachim.knorr@ziehl-abegg.de>,
 <david.laight.linux@gmail.com>, <Maarten.Brock@sttls.nl>,
 <crescentcy.hsieh@moxa.com>
Subject: Re: [PATCH v2 RESEND] serial: sc16is7xx: fix TX gap caused by kfifo
 circular buffer wrap-around
Message-Id: <20260930094218.07c9c41c368ba8bb69651d67@hugovil.com>
In-Reply-To: <20260930064938.116227-1-paultyson.mbewe@ziehl-abegg.de>
References: <20260928094733.09482cd6d6565588e2ecd267@hugovil.com>
	<20260930064938.116227-1-paultyson.mbewe@ziehl-abegg.de>
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

On Wed, 30 Sep 2026 08:49:38 +0200
Paul Mbewe <paultyson.mbewe@ziehl-abegg.de> wrote:

> Hi Hugo,
> 
> Sorry about the signature. The mail configuration has been
> updated for your address and the reviewers CC'd on the patch.

> Could you confirm whether this reply reached you without it?

Hi Paul,
no problem, signature seems absent, good!


-- 
Hugo Villeneuve
