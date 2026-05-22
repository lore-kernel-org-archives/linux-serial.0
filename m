Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0D834E760;
	Fri, 22 May 2026 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779442907; cv=none; b=FK4USvrX2L7X6BZUqduxcL1yqYPWZljFaGD4ihfZdRfJmV69uBYsYKqKiH0moM7znCHKXwUFNLXvoOZnch73pCU392Ek7cQRcCZct35p6UQVQDZeHOJvDqTB/rZ/blpDPZePsZYbDz90BGr5TC9DMWqUOd8y1Mn4w7HKQb3NIMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779442907; c=relaxed/simple;
	bh=gCXObbnIS7yQyfHM4o+Ru7QBu2FnZId5hsbI975cMHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VqagojlhG6hmUjhkyHVVeEaoraoGT/xZ0Sp6wCh7kWts7aNtZgAJk8pbedlAzMdbWsj9QINKTWgtJ31OGVoVRW3W7ya1JdFoGxjocm1PLf4Pg8sdnzu0BbMJRUwLCDOFvILjx+cX/OyASKKEBXwQGeXzXyCKaAIFRJEeSkLhbag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XlVRAJ5R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XlVRAJ5R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A05441F00A3F;
	Fri, 22 May 2026 09:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779442906;
	bh=Pe+uw+Qgb6SeBofdzBSI2x4kJ8rv2QjMVMldOwBx9F0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XlVRAJ5RP5FHLk9Bmj+yASoE7Y0bXvhJhDKgtdaOG3GKdSa9mekeXdK3fEREWGsfw
	 6MkyrWFPZGCt96R9HfD/ZFRqzucG4/pAIS5VmsVWQpVLLVmF6XHGRyPeEOls7TOnAh
	 E0OYJ9SN7RmP9wVrIjSq/3rHRAPieNe7ElrEqJFU=
Date: Fri, 22 May 2026 11:41:48 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Tapio Reijonen <tapio.reijonen@vaisala.com>,
	Dan Carpenter <error27@gmail.com>,
	Xichao Zhao <zhao.xichao@vivo.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH] drm: Use named initializers for arrays of i2c_device_data
Message-ID: <2026052243-phrasing-oblivious-cb15@gregkh>
References: <20260518101456.632410-2-u.kleine-koenig@baylibre.com>
 <agrybgEu5PT7orKA@monoceros>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agrybgEu5PT7orKA@monoceros>

On Mon, May 18, 2026 at 01:07:00PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Hello,
> 
> I messed up the Subject, of course this should have been:
> 
> 	[PATCH] tty: serial: Use named initializers for arrays of i2c_device_data
> 
> please fix up accordingly iff you apply this version. If I should resend
> for this reason, please tell me.

I'll fix it up.
