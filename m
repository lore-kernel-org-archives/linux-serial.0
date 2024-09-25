Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B4C2F5B
	for <linux-serial@vger.kernel.org>; Wed, 25 Sep 2024 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727280667; cv=none; b=qvS90IbOV5dYdeLxiW8oUgK5DBr6xS6RSJWNJCDaBDubgZZTes0A8lxAmR0v6tlqAzVdothfyzGNo0eNoC66N7Mb+MZCoHRhP/+7l8ssqrjAKTMl6hkR0TwZQjNMG9r7qi0A+usS/OR3Do1AMIK/776hKK3j0tUx/POJdP7SSYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727280667; c=relaxed/simple;
	bh=4RsANkrdXiSViUlQv/4EJH2x0PkMacn6pZm8OK3f6Dk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=cu9mKxJlxXyQDuxXHTzXDqOuB/qbobyFjQpsbr9p3eMUS7kK+/eD5pUhmPguHzhht7ZlPN05XNEH5yL/+3khAqO76yzPRGGgysC1rErx5VCqV9kTA7W8DdXvEn6Sn68PVwSkjVIUycz+RgDcXi6c0IU88is4kMxP7FF9qJ6YJ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com; spf=pass smtp.mailfrom=korsgaard.com; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=korsgaard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korsgaard.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A7431BF208;
	Wed, 25 Sep 2024 16:11:01 +0000 (UTC)
Received: from peko by dell.be.48ers.dk with local (Exim 4.96)
	(envelope-from <peter@korsgaard.com>)
	id 1stUbV-008Q0B-20;
	Wed, 25 Sep 2024 18:11:01 +0200
From: Peter Korsgaard <peter@korsgaard.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org,  helpdesk@kernel.org
Subject: Re: Bouncing maintainer: Peter Korsgaard (XILINX UARTLITE SERIAL
 DRIVER)
References: <20240925-cute-viper-of-skill-a55aae@lemur>
	<87setng3oe.fsf@dell.be.48ers.dk>
	<20240925-cryptic-funny-rhino-4c2d59@lemur>
Date: Wed, 25 Sep 2024 18:11:01 +0200
In-Reply-To: <20240925-cryptic-funny-rhino-4c2d59@lemur> (Konstantin
	Ryabitsev's message of "Wed, 25 Sep 2024 11:33:44 -0400")
Message-ID: <87o74bg1d6.fsf@dell.be.48ers.dk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: peter@korsgaard.com

>>>>> "Konstantin" == Konstantin Ryabitsev <konstantin@linuxfoundation.org> writes:

Hi,

>> I am pretty sure I never touched the sundance driver.

 > Yes, my apologies -- it's a case of bad copypaste. There is no script, since
 > each situation is individual.

 > Please send the patch for the actual subsystem for which you are in charge. :)

OK ;)

On a related note, I don't seem to be able to see the bugzilla entry
created for this (https://bugzilla.kernel.org/show_bug.cgi?id=219324)
even after logging in (same @sunsite.dk email). Is that normal?

-- 
Bye, Peter Korsgaard
