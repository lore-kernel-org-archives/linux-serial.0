Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182CE4A35
	for <linux-serial@vger.kernel.org>; Wed, 25 Sep 2024 15:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727278426; cv=none; b=dCsnFUapyCxgmnucwqMaK43neWOqSzDQTERjcwT0fWnYjhsMDHzKF6dADNe4RpvitHdCe2tGTVeTYpR3hhQD7X07IctvRk61i4LxFF13Pw85NqtqW4TCB/7zMiaclzQY/AqyJv1/ze8tWydF0ZsDc6TH486Lh0HHlK9GCz5NQus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727278426; c=relaxed/simple;
	bh=6s1MagNJBPekRNSvIF0G+21FSbsqB2RZ8cdg1dY9Bsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aY6mUWwxwM83PVDo5iMLY61lokQT9DRU5x4PgAyjGoiRGQFf4O1/UxYRj3o1wABkmzaWH8c0pYZ0CU1vy9+Ux4XXVN/CJCqVl2sPnqJLjEV5wWeuCWzQ5RNYjCkRWw2zhzHd09sgYOB8K9uli6JrwBwS1SIKDtYBIvkuNkgz5SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tWJndY/t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tWJndY/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6765FC4CECD;
	Wed, 25 Sep 2024 15:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727278425;
	bh=6s1MagNJBPekRNSvIF0G+21FSbsqB2RZ8cdg1dY9Bsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tWJndY/tQ9rXqmjWjCKBtaPKJX2e0qvezkRLMIE2IKkIhPP/AdYwRQvna2gvwDs53
	 JeH1qN2MsuOr3OdTtgNbJr9kqKLbgW8LXl9UfRJbsn/GK+HONG2yxK8s7570Ig72rI
	 kM3HeZidQFqpYoU5alI0eXB/DriAhrNOu2iVBaF8=
Date: Wed, 25 Sep 2024 11:33:44 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Peter Korsgaard <peter@korsgaard.com>
Cc: linux-serial@vger.kernel.org, helpdesk@kernel.org
Subject: Re: Bouncing maintainer: Peter Korsgaard (XILINX UARTLITE SERIAL
 DRIVER)
Message-ID: <20240925-cryptic-funny-rhino-4c2d59@lemur>
References: <20240925-cute-viper-of-skill-a55aae@lemur>
 <87setng3oe.fsf@dell.be.48ers.dk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87setng3oe.fsf@dell.be.48ers.dk>

On Wed, Sep 25, 2024 at 05:21:05PM GMT, Peter Korsgaard wrote:
> I think there is a bug in your script, presumably this is related to the
> uartlite driver instead (where I should send an update of my email
> address):
> 
> XILINX UARTLITE SERIAL DRIVER
> M:      Peter Korsgaard <jacmet@sunsite.dk>
> L:      linux-serial@vger.kernel.org
> S:      Maintained
> F:      drivers/tty/serial/uartlite.c
> 
> I am pretty sure I never touched the sundance driver.

Yes, my apologies -- it's a case of bad copypaste. There is no script, since
each situation is individual.

Please send the patch for the actual subsystem for which you are in charge. :)

-K
