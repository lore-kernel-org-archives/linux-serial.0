Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874523264DC;
	Fri, 10 Apr 2026 04:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775796891; cv=none; b=GdsifkL6cRU9tD82HkbokcvDQCs8NdvAl+XIS0wVfhXwgk9Nnn14AWROYuWNAZ1sTG7KwjR6hIc5+BzfpXO9U35OVaepvc+KteXebm2dFBc3gZb0OooRUrxdbGUsRXQjBTeyk52vqXXp3jjI8ddKNw5uQizMdXXMMEMlaDOLyrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775796891; c=relaxed/simple;
	bh=1Ym2cgNn0rPmN9+13bdbBNEWx6gVJ1bKRhcYIfUGZy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbBZJspJv4oyVLdIlJINVJX4v26lHHbNs/A2yOFoeiirMFVJ/MAd5SaUE5HCayL2m0X4Eii5F0/73y3JKhtJIfcVNhvvVU7z+4U03d3Co1+0IEuNwcQCssE/hHwsXg/7APd2ai1D/60IeY3xld5E0KcF8E8PRrcT5q5ax2ZkpbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ivv3w+Iw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ivv3w+Iw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1731C19421;
	Fri, 10 Apr 2026 04:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775796891;
	bh=1Ym2cgNn0rPmN9+13bdbBNEWx6gVJ1bKRhcYIfUGZy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ivv3w+IwJ+gEFh8iz5QB9svs9gMCKcX4X6e29j9MC9de+ouCB9TVvteQ1PJWbhGDx
	 nVQcGNenKl5NFuZiELNMrPTfdFlM1mS1HOsyGohp2EX9Drn68uB279nGIGr3jDhw6p
	 guaOjbJq8p/bE7XHpz2MAEz3YaJoOO7m4Cn7mwiI=
Date: Fri, 10 Apr 2026 06:54:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Qingfang Deng <dqfext@gmail.com>
Cc: dsterba@suse.cz, Jiri Kosina <jikos@kernel.org>,
	David Sterba <dsterba@suse.com>, Jiri Slaby <jirislaby@kernel.org>,
	Stephen Blackheath <stephen@symmetric.co.nz>,
	Ben Martel <benm@symmetric.co.nz>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] tty: ipwireless: fix memory leak in do_go_offline()
Message-ID: <2026041030-announcer-varying-a9f4@gregkh>
References: <20260306034058.386747-1-dqfext@gmail.com>
 <20260312120036.GF5735@suse.cz>
 <CALW65jY1qjiLNd_viqgiXodwGe1VzQx_qKUU2rRHMUp8TK7j_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALW65jY1qjiLNd_viqgiXodwGe1VzQx_qKUU2rRHMUp8TK7j_g@mail.gmail.com>

On Fri, Apr 10, 2026 at 12:01:23PM +0800, Qingfang Deng wrote:
> Hi, Greg and David,
> 
> On Thu, Mar 12, 2026 at 8:00 PM David Sterba <dsterba@suse.cz> wrote:
> >
> > Thanks, but the driver is going to be deleted.
> 
> Even if this is being removed from tty-next, the fix should be applied
> and backported to -stable.

We can just delete it from stable trees, as obviously no one is using
it.

thanks,

greg k-h
