Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDF93EC827;
	Fri,  2 Oct 2026 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926183; cv=none; b=R7hLJ9dculM0bKFCrzrAasV4nUXtPiZ3jt/X4EnrnX5iVAjXBu8YJLIefk4CCeF1wgp9Rfl1DYpeDeqi4hBl8KP8IpsRFCcQVf5vAxQkXwCnQdDqF/FgsYABUazF7sBWiuTsVrEL4pAEht8WzJpy/0KzaTv3AKihMOT96+WnyMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926183; c=relaxed/simple;
	bh=+cvNXXwK4yespuloWFG4UpVGah41wNwDdtFOAOrF6sk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ltddMNr0dbqw64sGUvD9/0GumNoUGAbNoF18oVfaMJFl/jqSkypOAKqBWLdQA7+NJ4Q0N0T9WQ7tZspIshOVIzvy2FgIlMrhHbnqso9S66QKphZCLhBPlWNpUdMme5eQgP8QXXDUQExwCwTZKCaod2C5oxBxMAZxhs5aPdnDx+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TJ/MX+rb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TJ/MX+rb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE131F000FF;
	Fri,  2 Oct 2026 07:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790926181;
	bh=xk/MQheh3qhoQrrKUb24suANrx68TBNceYIME3BaOBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TJ/MX+rbG0f3jgiXlrSdqfoaV+k7a+mlYt6KA8XhMutwi620AyxPOf+XV1O25S2dp
	 nzFFY991CMZ63xIOaTkt/zR/5QFIPqXa6pnzuOja2nEwyWRaJSZs229ZxxGksB5Pfm
	 N6KISuRS+de46v92Fv5vpvcdvHz4mSVXHqotC7x3p/u5POV9yVPr9kUnUEFnbwkmlR
	 ydzlBEqvmsOvqCeKoLd+AvjcioONcdQ3PwPSQqhDjRM6yNqdNVy8Gm5JgA5xwUtnpd
	 LBsay35qI6yWdfWQ1RzEeDWgMPXRNJlAtHncNq+Cgz4wxm1uElukBfL5LEd0yhKhqB
	 dU16yirN0h/9Q==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xCXi7-00000008eks-1Vz5;
	Fri, 02 Oct 2026 09:29:39 +0200
Date: Fri, 2 Oct 2026 09:29:39 +0200
From: Johan Hovold <johan@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Mark Brown <broonie@kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Serial <linux-serial@vger.kernel.org>
Subject: Re: linux-next: Tree for Sep 30 (htmldocs:
 include/linux/tty_driver.h)
Message-ID: <ar9dY0YUe-4l-KeR@hovoldconsulting.com>
References: <ar5CMQqWGUCVevPL@sirena.org.uk>
 <ec3a09d6-4ba4-41b8-abb1-b59e265f4532@infradead.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec3a09d6-4ba4-41b8-abb1-b59e265f4532@infradead.org>

On Thu, Oct 01, 2026 at 01:44:24PM -0700, Randy Dunlap wrote:
> On 10/1/26 4:21 AM, Mark Brown wrote:
> > Hi all,
> > 
> 
> Hi John,
> 
> Please add kernel-doc for:
> 
> WARNING: ../include/linux/tty_driver.h:92 Enum value 'TTY_DRIVER_RESET_SAVED_TERMIOS' not described in enum 'tty_driver_flag'

A was pretty sure I had done so but apparently a colon fell out:

	https://lore.kernel.org/20261002072736.2063004-1-johan@kernel.org

Thanks.

Johan
