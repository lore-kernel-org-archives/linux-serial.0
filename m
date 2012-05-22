From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: struct tty_flip_buffer replacement in newer kernels
Date: Tue, 22 May 2012 15:10:33 +0100
Message-ID: <20120522151033.33ef577a@pyramind.ukuu.org.uk>
References: <CAMMxdh1Ak2LWeL=3qxTmvfR43E=wSHz5OmSj_irMubz0aK+TgA@mail.gmail.com>
	<4FBB8742.7050504@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:55270 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968Ab2EVOHm (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 May 2012 10:07:42 -0400
In-Reply-To: <4FBB8742.7050504@fastmail.fm>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jack Stone <jwjstone@fastmail.fm>
Cc: gregkh@linuxfoundation.org, alan@linux.intel.com, linux-serial@vger.kernel.org

> I'm newbie, working under existed serial driver, adapting it for 2.6.32.
> During the compilation I have had several problems, which I
> succesfully solved except this one:
> error: 'struct tty_struct' has no member named 'flip'
> In particular, cound you advice correct replacement of "tty->flip.count"

Your driver shouldn't be looking in those areas. There isn't a correct
replacement. You will need to update it to use the flip buffers properly
not poke its nose in places it shouldn't have.

Perhaps the best thing would be to post a link to the driver ?

Alan
