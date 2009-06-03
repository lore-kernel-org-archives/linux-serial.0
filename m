From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH 04/11] Blackfin SPORT UART: fix overrun errors
Date: Wed, 3 Jun 2009 06:15:14 -0400
Message-ID: <8bd0f97a0906030315l60214ff1n7f5d7a7203dd4547@mail.gmail.com>
References: <1243926700-30485-1-git-send-email-vapier@gentoo.org>
	 <1243926700-30485-4-git-send-email-vapier@gentoo.org>
	 <20090602100018.415b1dfc@lxorguk.ukuu.org.uk>
	 <8bd0f97a0906030103i64bc1a9duc5aeaea7bd3f8365@mail.gmail.com>
	 <20090603095346.64c874b1@lxorguk.ukuu.org.uk>
	 <8bd0f97a0906030247ueeb9320k30e794109ca51758@mail.gmail.com>
	 <20090603105716.341244fc@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gx0-f166.google.com ([209.85.217.166]:45672 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbZFCKPN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 3 Jun 2009 06:15:13 -0400
In-Reply-To: <20090603105716.341244fc@lxorguk.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>

On Wed, Jun 3, 2009 at 05:57, Alan Cox wrote:
>> since the serial stuff is in a bit of orphaned state (going by
>> MAINTAINERS), should i merge the other changes through the Blackfin
>> tree ?
>
> The other bits are all merged into the ttydev tree

ah, ok.  i'm guessing that is this:
http://www.linux.org.uk/~alan/ttydev/

useful to add to MAINTAINERS ?
-mike
