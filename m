Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57455291E
	for <linux-serial@vger.kernel.org>; Mon, 27 Jan 2025 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737999455; cv=none; b=ZAH5VIRTZdQVV2ExqdN5NAvFiwA9y6j5OdBTPc6azvRBia8GlJtYADAy7dqJfKqOFo23ajwYVxNaTFiGD6OAM4XZZoS7GKFB9p9MlS3oqPwvfu5O70WwiiXldBblqX9G1WIcQkMQEF6ZlNl54hj79WzmkWhbwNLdItHxekGH7k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737999455; c=relaxed/simple;
	bh=6mN7WykjP+eoMMJPBMc7alUs+ua+zTJoYEXOXCyvFvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DhQ5ck7VuvW0+059Y1nQB6/JZ7I5FEsP9uYNa9XcmdMY3CVerOZm6tMUVNzX+oihRP0FaOl1qmlov14Y4uNgBqMBfPL5PQIsXf1+LpN7L5O2K0k9BnRKzj0FbsXIyIAEpw/wRbAIYEsHHMRRx2ECX5yt7Su2EV6HPJXuJGL7pu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ce4IyDi9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ce4IyDi9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A27C4CED2;
	Mon, 27 Jan 2025 17:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737999454;
	bh=6mN7WykjP+eoMMJPBMc7alUs+ua+zTJoYEXOXCyvFvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ce4IyDi9slQcNDT+4iKXWKOJ5Ha3C4O31gvqSV+P7M00+POBDYtRwKGCpcVJ6qcWr
	 aq2h3ffPEnxbw2HKtQUgqWnA1igDzfDrCeCD2p6ZvKGgpl4k4PqlKDNT0b90VRTlDd
	 JfJ59OZoODHQmnluuu9tnl1pKX6UtUEtSgDtWBxU=
Date: Mon, 27 Jan 2025 18:37:31 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Lizewski <daniellizewski@geotab.com>
Cc: linux-serial@vger.kernel.org
Subject: Re: BUG: n_gsm.c: Deadlock in gsm_modem_upd_via_msc
Message-ID: <2025012727-halved-regally-fe46@gregkh>
References: <CANYnu5-4Vzsp7jbOZ-ZeQx_0uwnP5RUMLO72DOGqrsFbLO0zOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANYnu5-4Vzsp7jbOZ-ZeQx_0uwnP5RUMLO72DOGqrsFbLO0zOQ@mail.gmail.com>

On Mon, Jan 27, 2025 at 11:23:49AM -0500, Daniel Lizewski wrote:
> Hello,
> I have found a deadlock in the n_gsm line discipline.

Yeah, yet another one!  :)

(hint, this ldisc is full of locking issues and should NEVER be used on
a system that you do not trust.

See the archives for many other examples of known bugs in this codebase,
patches are gladly accepted to help mitigate and fix them.

thanks,

greg k-h
