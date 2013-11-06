From: Bastian Hecht <hechtb@gmail.com>
Subject: Re: [PATCH 4/5] serial: sh-sci: Add OF support
Date: Wed, 6 Nov 2013 16:26:02 +0100
Message-ID: <CABYn4syy10bZ+z=Fn+KK_m14GyMLPMrBGFMHntKWW6p4=VH9FQ@mail.gmail.com>
References: <1383042599-25151-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1383042599-25151-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<CABYn4sxC02bX7XqN8yQ-gYgZEdaHAUohOjyL3pjGYXK9kd8WXg@mail.gmail.com>
	<1449714.Sp0o1f9lVb@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bk0-f45.google.com ([209.85.214.45]:63144 "EHLO
	mail-bk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754854Ab3KFP0G (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Nov 2013 10:26:06 -0500
In-Reply-To: <1449714.Sp0o1f9lVb@avalon>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-serial@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

>> given that we only support ARM based ports and we hope the regtype and
>> brr_algo won't deviate a lot from the given generic settings for new chips
>
> Hopefully :-) I'm trying to simplify the baud rate algorithms mess, I should
> be able to post patches soon, but I need to test them on hardware first. Would
> you have a sh7780, sh7785 or sh7786 board by any chance ?

No never touched these unfortunately.

Cheers,

 Bastian
