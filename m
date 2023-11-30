Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBB731A6D;
	Thu, 30 Nov 2023 15:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pjwpb1hi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79237C433C8;
	Thu, 30 Nov 2023 15:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701357093;
	bh=O8vlZdRzHuB/ofC7NHp0ch34OjJjZxcFddRF5G34Fys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pjwpb1higZRwmJCySttJXVnzJzQuOOvgRslChW/0g03ssWIr2HJwiV1czzenqEnOX
	 DY4eJ+9QpFXwqKlTxKu8RbMddHOYZJfUQxiwU+7R9GUP4zFndkdN/i15SSxjKKDuFk
	 dSLaLdatbTDXvcLG/gu0HBhqWBTx8gPGXAGGhH/Ou6ngsQrkjOKGYyQLUTR4nnDZNJ
	 7iJHy/45Y9EooDB4dNP9bRRoBpGj3paOIul/JBG5ytH2gFyMpP0scdN5V+GheotahP
	 ZIRPLt8JmInYHpRvHVZvfzU6tgdRDRQifQtQwycfVwqjVj3pec515aPOoqRskNGnoV
	 XxKx1fTHx+fxw==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1r8ihx-0000u5-2R;
	Thu, 30 Nov 2023 16:12:06 +0100
Date: Thu, 30 Nov 2023 16:12:05 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oliver Neukum <oneukum@suse.com>, Jiri Slaby <jirislaby@kernel.org>,
	USB list <linux-usb@vger.kernel.org>, linux-serial@vger.kernel.org
Subject: Re: question on correct error return from break_ctl()
Message-ID: <ZWimRdaCVvPjLsTL@hovoldconsulting.com>
References: <7e649033-0e1d-4c21-a1f3-ceb2de894861@suse.com>
 <2023113055-molecular-backlands-6b3d@gregkh>
 <0dd783e9-1cd2-467f-a90d-e63fec88350c@suse.com>
 <2023113053-oxidize-observant-9fb8@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023113053-oxidize-observant-9fb8@gregkh>

On Thu, Nov 30, 2023 at 02:42:20PM +0000, Greg Kroah-Hartman wrote:
> On Thu, Nov 30, 2023 at 03:36:21PM +0100, Oliver Neukum wrote:
> > On 30.11.23 14:48, Greg Kroah-Hartman wrote:

> > I am afraid I need to point out that usb-serial has been changed _this_ _year_
> > to return -ENOTTY. CDC-ACM being also in this situation unfortunately
> > I need to decide between one of the alternatives.
> 
> Ah, oops, then it should probably be changed back.  Unless Johan, any
> specific reason this was changed?

Had to go back to lore to see why I changed this:

	https://lore.kernel.org/all/20230604123505.4661-1-johan@kernel.org/

IIRC we had a user that was not expecting break signalling to only work
with one of the two ports of a Silabs device without user space being
notified about it.

In the cover letter I mention that the intent of "commit 9e98966c7bb9
("tty: rework break handling") from 2008 appears to be to allow missing
support to be reported to user space".

Reporting back an error also avoids waiting for the break period when a
subdriver does not support break (i.e. as when a tty driver does not
support break).

The inconsistency was discussed and if this turns out to be an issue we
can have the tty layer turn that -ENOTTY into 0 before returning:

	https://lore.kernel.org/all/ZH8a12ZYtA2RzEK_@hovoldconsulting.com/

I haven't heard from anyone noticing any issues so far though.

Johan
