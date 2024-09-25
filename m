Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFE23D982
	for <linux-serial@vger.kernel.org>; Wed, 25 Sep 2024 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727280774; cv=none; b=qgMtyoQwUR+qbTrI5wnGTLcDNcX5GwvMBKE1B3PeNkVV6tShoh/Dc8xdOBgdWKrpwy81o9KM/yOPAJ58ZiJnf5c77qC13WiTlrri8N7Pyvv0DGCX4zvlO2I4K9r4gy6hcFdfisPExOlHVHdTZKKqdSersJ6euforVN2nmzAVnQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727280774; c=relaxed/simple;
	bh=ifNftldl0HICLcw92KFnSnIbQ5bJh8C1Ys21ChZlQDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6Dg3uJB+eaYLBA/NyjnvEUTnaX9yiY7aPKtblSg/0uVmrEEQURDOAj6T9voAhy32uGoMzxrX8SSMTcBax8JV/dzCMSxpGPiwiZKYGkUrbNRZ2AvnvyHrfBsA159CoUzfDxQF0bHsp5CJmadGd55vM8CqVg85kiiEK0HjJkE1uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S0xxM9rk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S0xxM9rk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3887C4CEC3;
	Wed, 25 Sep 2024 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727280774;
	bh=ifNftldl0HICLcw92KFnSnIbQ5bJh8C1Ys21ChZlQDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S0xxM9rk6mGjJKl2q+XEuYubWuBDNS3MkX/AjzGYL39TtPqxjMek4RF87CxR8xkl9
	 xmwx1yU1PjEE5FYxNqGJ3fC8XwUDh2dj5pXvRKNW9paXqOcFt7PQvckiA9RkKtj8GH
	 1HMHyXtsHMv+07AlvWPM5zshexYIsaO3j7FARiyw=
Date: Wed, 25 Sep 2024 12:12:53 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Peter Korsgaard <peter@korsgaard.com>
Cc: linux-serial@vger.kernel.org, helpdesk@kernel.org
Subject: Re: Bouncing maintainer: Peter Korsgaard (XILINX UARTLITE SERIAL
 DRIVER)
Message-ID: <20240925-macho-quoll-of-renovation-962edc@lemur>
References: <20240925-cute-viper-of-skill-a55aae@lemur>
 <87setng3oe.fsf@dell.be.48ers.dk>
 <20240925-cryptic-funny-rhino-4c2d59@lemur>
 <87o74bg1d6.fsf@dell.be.48ers.dk>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o74bg1d6.fsf@dell.be.48ers.dk>

On Wed, Sep 25, 2024 at 06:11:01PM GMT, Peter Korsgaard wrote:
> On a related note, I don't seem to be able to see the bugzilla entry
> created for this (https://bugzilla.kernel.org/show_bug.cgi?id=219324)
> even after logging in (same @sunsite.dk email). Is that normal?

Yes, this is just our internal tracking. The contents just follow this thread.

-K
