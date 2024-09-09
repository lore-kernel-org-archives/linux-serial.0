Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598A51531E0;
	Mon,  9 Sep 2024 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725883386; cv=none; b=bgY5GUOAcuxV9TOxs1SXXKyCTFQ8NBkIMQOrW8p8Qf1eI2EWvV+Xcj4hntSEobsOpujekICqTQjp+4Vaxebc3dPECtTAe7U9NVv1S+mgn9JPrHFYyl5JDiNlByhnDfHFqZdqG1jUKu6xhdGghakfJ4y3i7LEfVyPKeFkSTMHcB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725883386; c=relaxed/simple;
	bh=v10Caia0MnJgSdsEDIP5gynEPXE6e1skkNiCgDVcqCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8GqB8dqVEVyMhjoz7q8Iw4fXI1Waxh8cmA8OW6e00rfeIP35FIMt49H09tuAQgRgbaGQpD8ufy7WjPUd1F4gMoeaLPsOvCq7BY1htCwzzcxEhTPWysPu+QY0BvVv9rtCNCjEBKWZfzJjz4Kmyqqy4HNHNeHkqzNzaPpE5xz6Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrJAy/TD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrJAy/TD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7686C4CEC5;
	Mon,  9 Sep 2024 12:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725883386;
	bh=v10Caia0MnJgSdsEDIP5gynEPXE6e1skkNiCgDVcqCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CrJAy/TDxVkRaDk1+jwpEACpICOq3vgaX1A9QN5MvOgTV2GSVDuLY84+f/dagtbNu
	 w2Uml8k8eEWxO1hE0B5L7CIRkJK8g1JgghIanak/R/9xVtJb2fAMt89NP0OmGKpWGy
	 0JOQptF9D+2/wva5naoEdounP/YQJfPM60LCGmYIy59BQswvj0T3e6EtQn4txwzEq6
	 KhRDu4HGat+VHR/OfU7XD+DgPQAE/tRoLD8LeyzILK+o5HJVjhwx0MDbnZI2Daazet
	 PvYXxKgwCN3GId0m0DwRrAhxn99li1zzb79jfTTzHsY3c2ISwyYN+1i2SxbIUUyo4b
	 frpLLFjP6qpMw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1snd75-000000001Vg-08Sm;
	Mon, 09 Sep 2024 14:03:23 +0200
Date: Mon, 9 Sep 2024 14:03:23 +0200
From: Johan Hovold <johan@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] USB-Serial serdev support
Message-ID: <Zt7kCxawoszunWq3@hovoldconsulting.com>
References: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>

On Wed, Aug 07, 2024 at 04:08:47PM +0200, Marco Felsch wrote:
> this patchset is based on Johan's patches [1] but dropped the need of
> the special 'serial' of-node [2].

That's great that you found and referenced my proof-of-concept patches,
but it doesn't seem like you tried to understand why this hasn't been
merged yet.

First, as the commit message you refer to below explain, we need some
way to describe multiport controllers. Just dropping the 'serial' node
does not make that issue go away.

Second, and more importantly, you do not address the main obstacle for
enabling serdev for USB serial which is that the serdev cannot handle
hotplugging.


> [1] https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/log/?h=usb-serial-of
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git/commit/?h=usb-serial-of&id=b19239022c92567a6a9ed40e8522e84972b0997f

Johan
