Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9F87F9;
	Mon, 23 Dec 2024 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734976763; cv=none; b=XwFwu/4P7VJEzC0PTTs1zcWtqE0Y5nUJbispOE1Y5YIZDOlQ/gtS39ZQVa2yQbZN41QDKfHniTogrqqS0tsMzBmToguJRR3Ub0vKwPHcW+5EIM9cHVgZpUlC9nh/OP1NaksM+dEze0jYcUz7KNGDb1gup5n7QhCEhg/7BJZnEDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734976763; c=relaxed/simple;
	bh=RmmHQHI9OT7foCSNS3heOsTBq0YrsanZIh164vcpy6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lk+bKTWIp2PxG/EkCyxIOiPMDwiHn1SfGhHcGh7Jm8EaRMm62LYBhtF9XJBdTxazIe0FKGiPjbYSBNMfpmKMV+pFYhuZUIwwC5eP/v9kRVlxipiChTM1UDRCEwZJKAve2Cng23g+a1zNg68FjGFQGHszSVaW7fpjPi7ua1tiMII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mqMo61gv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mqMo61gv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8655C4CED3;
	Mon, 23 Dec 2024 17:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734976762;
	bh=RmmHQHI9OT7foCSNS3heOsTBq0YrsanZIh164vcpy6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mqMo61gvpYlWuE5L+rFhAAPAUZkUaCMN88n0aKv2Z7cidw78bTRRUNgFuFW7WqTV8
	 Gan4TNtaD+OH0gY/a7U2dGyTH07y5siIMy0SDSjWsGjo+EmLX28jJV2ZCR7faqqsMf
	 XgPt/ZxMx4kbqIn3C6jlH6EoUQbSBtXiu6HXlRY0=
Date: Mon, 23 Dec 2024 18:59:19 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: Andre Werner <andre.werner@systec-electronic.com>,
	"jirislaby@kernel.org" <jirislaby@kernel.org>,
	"hvilleneuve@dimonoff.com" <hvilleneuve@dimonoff.com>,
	"andy@kernel.org" <andy@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"lech.perczak@camlingroup.com" <lech.perczak@camlingroup.com>
Subject: Re: [External Email] Re: [PATCH] serial: sc16is7xx: Add polling
 feature if no IRQ usage possible
Message-ID: <2024122301-trickery-unexpired-e6b6@gregkh>
References: <20241219084638.960253-1-andre.werner@systec-electronic.com>
 <2024121931-turbojet-preamble-b520@gregkh>
 <fbd224a3-8f10-3ccf-5480-38fcd839d409@systec-electronic.com>
 <2024121906-reach-hash-3d7c@gregkh>
 <5a524cb7-23d9-63b8-81fc-b68a23fddd65@systec-electronic.com>
 <AS8PR05MB9810B543A1223ED04729EAAE83022@AS8PR05MB9810.eurprd05.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR05MB9810B543A1223ED04729EAAE83022@AS8PR05MB9810.eurprd05.prod.outlook.com>

On Mon, Dec 23, 2024 at 02:27:22PM +0000, Maarten Brock wrote:
> > I got your point and I'm fully with. This caused me to print a warning
> > in Kernel log because it should not be the general working method.
> > In our special case we do not have any other option because the sensor
> > module using the SC16IS7xx and the hardware with the MCU running Linux OS
> > are fixed. We had no possibilities to move any GPIO or such. This was
> > the only chance  to support the dedicated sensor platform and I may be
> > the case that someone else faces the same problems. I thought that
> > someone else may benefit from this workaround too. But as I got your
> > point I'm also fine if it is not merged into main Linux Kernel sources.
> 
> I vote this patch to go in (after modification).

Ok, let's see a cleaned up version of this and we'll review it again.

thanks,

greg k-h
